require 'pony'

class Insinkerator
  FILE_SORTER = proc { |e| e.scan(/[^\d]+(?=\d|$)|[\d]+(?=[^\d]|$)/).map { |f| f =~ /^\d+$/ ? f.to_i : f } }
  attr_accessor :deleted, :dir, :sorted_files

  def initialize(dir)
    @dir = Dir.new dir
    @to_delete = []
    @deleted = []
    map_dir
  end

  def map_dir
    @sorted_files = {}

    dir.each do |file|
      f = File.join(@dir.path, file)
      if file =~ /^([^0-9]*\d+(\.\d+)+-)/
        prefix = $1
        @sorted_files[prefix] ||= []
        @sorted_files[prefix] << file
      end
    end

    @sorted_files.each do |prefix, files|
      @sorted_files[prefix] = @sorted_files[prefix].sort_by(&FILE_SORTER)
    end
  end

  def flick(options={})
    options[:dry_run] ||= false
    options[:email] ||= nil
    options[:to_keep] ||= 5
    @sorted_files.each do |prefix, files|
      next if files.size <= options[:to_keep]

      files[0..-6].each do |file|
        file_path = File.join(@dir.path, file)
        @to_delete << file_path
        unless options[:dry_run]
          FileUtils.rm_rf file_path
          @to_delete.delete(file_path)
          @deleted << file_path
        end
      end
    end
  end
end

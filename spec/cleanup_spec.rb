require File.join(File.dirname(__FILE__), '..', 'lib', 'insinkerator')

describe Insinkerator do
  before(:all) do
    @live_dir    = File.join(File.dirname(__FILE__), '..', 'test-data', 'live')
    @canon_dir   = File.join(File.dirname(__FILE__), '..', 'test-data', 'canon')
    @live_files  = File.join(@live_dir, '*')
    @canon_files = File.join(@canon_dir, '*')

    # Delete everything in 'live'
    FileUtils.rm_rf Dir.glob(@live_files)

    # Copy from 'canon' to 'live'
    FileUtils.cp_r Dir.glob(@canon_files), @live_dir

    @insinkerator01 = Insinkerator.new(File.join(@live_dir, 'kfc', 'RPMS', 'noarch'))
    @insinkerator03 = Insinkerator.new(File.join(@live_dir, 'RPMS', 'noarch'))
    @insinkerator04 = Insinkerator.new(File.join(@live_dir, 'SOURCES'))

    @kfc_rpms_noarch = @insinkerator01.sorted_files
    @rpms_noarch = @insinkerator03.sorted_files
    @sources = @insinkerator04.sorted_files
  end


  it "should find correct prefixes in kfc/RPMS/noarch" do
    @kfc_rpms_noarch.key?('kfs-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-bootstrap-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-conversion-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-demodata-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-kittdb-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-obiee-cnv-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-obiee-dev-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-rel-kittdb-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-settings-cnv-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-settings-dev-3.0-').should be_true
    @kfc_rpms_noarch.key?('kfs-workflow-3.0-').should be_true
    @kfc_rpms_noarch.key?('kuali-coeus-2.0-').should be_true
    @kfc_rpms_noarch.key?('kuali-coeus-kittdb-2.0-').should be_true
    @kfc_rpms_noarch.key?('kuali-coeus-settings-cfg-2.0-').should be_true
    @kfc_rpms_noarch.key?('kuali-coeus-settings-cnv-2.0-').should be_true
  end

  it "should sort kfs-3.0- files well with alpha and numerical components in kfc/RPMS/noarch" do
    @kfc_rpms_noarch['kfs-3.0-'][0].should == 'kfs-3.0-1.noarch.rpm'
    @kfc_rpms_noarch['kfs-3.0-'][1].should == 'kfs-3.0-2.noarch.rpm'
    @kfc_rpms_noarch['kfs-3.0-'][2].should == 'kfs-3.0-3.noarch.rpm'
    @kfc_rpms_noarch['kfs-3.0-'][3].should == 'kfs-3.0-4.noarch.rpm'
    @kfc_rpms_noarch['kfs-3.0-'][5].should == 'kfs-3.0-6.noarch.rpm'
    @kfc_rpms_noarch['kfs-3.0-'][8].should == 'kfs-3.0-9.noarch.rpm'
    @kfc_rpms_noarch['kfs-3.0-'][10].should == 'kfs-3.0-11.noarch.rpm'
  end

  it "should sort kfs-3.0- files well with alpha and numerical components in RPMS/noarch" do
    @rpms_noarch['kfs-3.0-'][0].should == 'kfs-3.0-1.noarch.rpm'
    @rpms_noarch['kfs-3.0-'][1].should == 'kfs-3.0-2.noarch.rpm'
    @rpms_noarch['kfs-3.0-'][2].should == 'kfs-3.0-3.noarch.rpm'
    @rpms_noarch['kfs-3.0-'][3].should == 'kfs-3.0-4.noarch.rpm'
    @rpms_noarch['kfs-3.0-'][5].should == 'kfs-3.0-6.noarch.rpm'
    @rpms_noarch['kfs-3.0-'][8].should == 'kfs-3.0-9.noarch.rpm'
    @rpms_noarch['kfs-3.0-'][10].should == 'kfs-3.0-11.noarch.rpm'
  end

  it "should sort kfs-3.0- files well with alpha and numerical components in SOURCES" do
    @sources['kfs-3.0-'][0].should == 'kfs-3.0-1.tar.gz'
    @sources['kfs-3.0-'][1].should == 'kfs-3.0-2.tar.gz'
    @sources['kfs-3.0-'][2].should == 'kfs-3.0-3.tar.gz'
    @sources['kfs-3.0-'][3].should == 'kfs-3.0-4.tar.gz'
    @sources['kfs-3.0-'][5].should == 'kfs-3.0-6.tar.gz'
    @sources['kfs-3.0-'][8].should == 'kfs-3.0-9.tar.gz'
    @sources['kfs-3.0-'][10].should == 'kfs-3.0-11.tar.gz'
  end

  it "should sort kfs-bootstrap-3.0- files well with alpha and numerical components" do
    @kfc_rpms_noarch['kfs-bootstrap-3.0-'][0].should == 'kfs-bootstrap-3.0-1.noarch.rpm'
    @kfc_rpms_noarch['kfs-bootstrap-3.0-'][1].should == 'kfs-bootstrap-3.0-2.noarch.rpm'
  end

  it "should sort kuali-coeus-2.0- files well with alpha and numerical components" do
    @kfc_rpms_noarch['kuali-coeus-2.0-'][0].should == 'kuali-coeus-2.0-10.noarch.rpm'
    @kfc_rpms_noarch['kuali-coeus-2.0-'][1].should == 'kuali-coeus-2.0-11.noarch.rpm'
  end

  it "should sort kuali-coeus-3.0.1- files well with alpha and numerical components" do
    @kfc_rpms_noarch['kuali-coeus-3.0.1-'][0].should == 'kuali-coeus-3.0.1-3.noarch.rpm'
    @kfc_rpms_noarch['kuali-coeus-3.0.1-'][1].should == 'kuali-coeus-3.0.1-4.noarch.rpm'
    @kfc_rpms_noarch['kuali-coeus-3.0.1-'][2].should == 'kuali-coeus-3.0.1-5.noarch.rpm'
  end

  it "should sort kuali-coeus-3.1.0- files well with alpha and numerical components" do
    @kfc_rpms_noarch['kuali-coeus-3.1.0-'][0].should == 'kuali-coeus-3.1.0-5.noarch.rpm'
    @kfc_rpms_noarch['kuali-coeus-3.1.0-'][1].should == 'kuali-coeus-3.1.0-6.noarch.rpm'
    @kfc_rpms_noarch['kuali-coeus-3.1.0-'][2].should == 'kuali-coeus-3.1.0-7.noarch.rpm'
  end

  context "after flicking the switch" do
    before(:all) do
      @insinkerator01.flick
      @insinkerator03.flick
      @insinkerator04.flick
      @kfc_rpms_noarch_files = Dir.entries(File.join(@live_dir, 'kfc', 'RPMS', 'noarch'))
      @sources               = Dir.entries(File.join(@live_dir, 'SOURCES'))
    end

    after(:all) do
      # Delete everything in 'live'
      FileUtils.rm_rf Dir.glob(@live_files)

      # Copy from 'canon' to 'live'
      FileUtils.cp_r Dir.glob(@canon_files), @live_dir

      @insinkerator01 = Insinkerator.new(File.join(@live_dir, 'kfc', 'RPMS', 'noarch'))
      @insinkerator03 = Insinkerator.new(File.join(@live_dir, 'RPMS', 'noarch'))
      @insinkerator04 = Insinkerator.new(File.join(@live_dir, 'SOURCES'))

      @kfc_rpms_noarch = @insinkerator01.sorted_files
      @rpms_noarch = @insinkerator03.sorted_files
      @sources = @insinkerator04.sorted_files
    end

    it "should dispose of all files except the last five in numerical file sort in kfc/RPMS/noarch" do
      @kfc_rpms_noarch_files.should_not include('kfs-3.0-1.noarch.rpm')
      @kfc_rpms_noarch_files.should_not include('kfs-3.0-2.noarch.rpm')
      @kfc_rpms_noarch_files.should_not include('kfs-3.0-3.noarch.rpm')
      @kfc_rpms_noarch_files.should_not include('kfs-3.0-4.noarch.rpm')
      @kfc_rpms_noarch_files.should_not include('kfs-3.0-5.noarch.rpm')
      @kfc_rpms_noarch_files.should_not include('kfs-3.0-6.noarch.rpm')
    end

    it "should dispose of all files except the last five in numerical file sort in SOURCES" do
      @sources.should_not include('kfs-3.0-1.tar.gz')
      @sources.should_not include('kfs-3.0-2.tar.gz')
      @sources.should_not include('kfs-3.0-3.tar.gz')
      @sources.should_not include('kfs-3.0-4.tar.gz')
      @sources.should_not include('kfs-3.0-5.tar.gz')
      @sources.should_not include('kfs-3.0-6.tar.gz')
    end

    it "should keep the last five in numerical file sort" do
      @kfc_rpms_noarch_files.should include('kfs-3.0-7.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kfs-3.0-8.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kfs-3.0-9.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kfs-3.0-10.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kfs-3.0-11.noarch.rpm')
    end

    it "should keep the last two 'kuali-coeus-2.0-'s in numerical file sort" do
      @kfc_rpms_noarch_files.should include('kuali-coeus-2.0-10.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kuali-coeus-2.0-11.noarch.rpm')
    end

    it "should keep the last three 'kuali-coeus-3.0.1-'s in numerical file sort" do
      @kfc_rpms_noarch_files.should include('kuali-coeus-3.0.1-3.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kuali-coeus-3.0.1-4.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kuali-coeus-3.0.1-5.noarch.rpm')
    end

    it "should keep the last three 'kuali-coeus-3.1.0-'s in numerical file sort" do
      @kfc_rpms_noarch_files.should include('kuali-coeus-3.1.0-5.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kuali-coeus-3.1.0-6.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kuali-coeus-3.1.0-7.noarch.rpm')
    end

    it "should list deleted files" do
      %w{cnv dev}.each do |env|
        (1..6).each do |i|
          @insinkerator01.deleted.should include("/home/u18/srawlins/code/cleanupRpms/spec/../test-data/live/kfc/RPMS/noarch/kfs-obiee-#{env}-3.0-#{i}.noarch.rpm")
        end
      end
    end
  end

  context "after flicking the switch, as a dry run" do
    before(:all) do
      @insinkerator01.flick(:dry_run => true)
      @insinkerator03.flick(:dry_run => true)
      @insinkerator04.flick(:dry_run => true)
      @kfc_rpms_noarch_files = Dir.entries(File.join(@live_dir, 'kfc', 'RPMS', 'noarch'))
      @sources               = Dir.entries(File.join(@live_dir, 'SOURCES'))
    end

    after(:all) do
      # Delete everything in 'live'
      FileUtils.rm_rf Dir.glob(@live_files)

      # Copy from 'canon' to 'live'
      FileUtils.cp_r Dir.glob(@canon_files), @live_dir

      @insinkerator01 = Insinkerator.new(File.join(@live_dir, 'kfc', 'RPMS', 'noarch'))
      @insinkerator03 = Insinkerator.new(File.join(@live_dir, 'RPMS', 'noarch'))
      @insinkerator04 = Insinkerator.new(File.join(@live_dir, 'SOURCES'))

      @kfc_rpms_noarch = @insinkerator01.sorted_files
      @rpms_noarch = @insinkerator03.sorted_files
      @sources = @insinkerator04.sorted_files
    end

    it "should KEEP all files in kfc/RPMS/noarch" do
      @kfc_rpms_noarch_files.should include('kfs-3.0-1.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kfs-3.0-2.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kfs-3.0-3.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kfs-3.0-4.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kfs-3.0-5.noarch.rpm')
      @kfc_rpms_noarch_files.should include('kfs-3.0-6.noarch.rpm')
    end

    it "should KEEP all files in SOURCES" do
      @sources.should include('kfs-3.0-1.tar.gz')
      @sources.should include('kfs-3.0-2.tar.gz')
      @sources.should include('kfs-3.0-3.tar.gz')
      @sources.should include('kfs-3.0-4.tar.gz')
      @sources.should include('kfs-3.0-5.tar.gz')
      @sources.should include('kfs-3.0-6.tar.gz')
    end
  end
end

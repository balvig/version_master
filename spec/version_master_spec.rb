require File.dirname(__FILE__) + '/spec_helper'

FIXTURE_PATH = File.dirname(__FILE__) + '/fixtures/version.yml'

describe VersionMaster::Version do
  
  before(:each) do
    @version = VersionMaster::Version.new(FIXTURE_PATH)
  end
  after(:each) do
    @version.set('1.0.0')
  end
    
  it "should load version data from yaml file" do
    @version.to_s.should == '1.0.0'
  end
  
  describe "set" do
    it "should set the version number" do
      @version.set('3.4.2')
      @version.to_s.should == '3.4.2'
    end
  end
  
  describe "bump" do
    it "should increment versions" do
      @version.bump(:major)
      @version.to_s.should == '2.0.0'

      @version.bump(:minor)
      @version.to_s.should == '2.1.0'

      @version.bump(:patch)
      @version.to_s.should == '2.1.1'
      
      @version.bump
      @version.to_s.should == '2.1.2'
    end
    
    it "should reset lesser versions" do
      @version.bump(:patch)
      @version.to_s.should == '1.0.1'

      @version.bump(:minor)
      @version.to_s.should == '1.1.0'

      @version.bump(:major)
      @version.to_s.should == '2.0.0'
    end
    
    it "should rollover minor to major" do
      @version.set('2.9.0')
    end
  end
  
  describe "save" do
    it "should save version data to yaml file" do
      @version.set('3.4.7')
      VersionMaster::Version.new(FIXTURE_PATH).to_s.should == '3.4.7'
    end
  end
  
  
end
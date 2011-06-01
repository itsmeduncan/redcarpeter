require 'spec_helper'

describe Redcarpeter::Base do
  
  describe ".new" do
    it "should set the filename from the first argument" do
      Redcarpeter::Base.new("foo.md").filename.should == "foo"
    end

    it "should set the exetension from the first argument" do
      Redcarpeter::Base.new("foo.md").extension.should == ".md"
    end
  end
  
  describe ".compile" do
    it "should make a new Redcarpeter::Base and call #compile! on it" do
      expected_class = Redcarpeter::Base.new("foo.md")

      expected_class.should_receive(:compile!)
      Redcarpeter::Base.should_receive(:new).with(["foo.md"]).and_return(expected_class)
      
      Redcarpeter::Base.compile("foo.md")
    end
  end
  
  describe "#markdown" do
    it "should make a new Redcarpet object from the input file" do
      File.should_receive(:read).with("foo.md")
      Redcarpeter::Base.new("foo.md").markdown.should be_a(Redcarpet)
    end
  end
  
  describe "#compile!" do
    it "should write out the HTML to the correct file" do
      tempfile = Tempfile.new("foo")

      File.stub(:read).and_return("foo")
      
      carpeter = Redcarpeter::Base.new("foo.md")

      tempfile.should_receive(:write)
      File.should_receive(:open).with("foo.html", 'w').and_yield tempfile
      
      carpeter.compile!
    end
  end
  
end
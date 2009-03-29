require 'spec'
require 'lib/atmosphere'

describe Atmosphere do
  before(:each) do
    @atmosphere = Atmosphere.new(nil)
  end
  
  describe "when parsing a file path" do
  
    it "extracts words from file name" do
      @atmosphere.extract_words("some_file.rb").should == ["some", "file", "rb"]
      @atmosphere.extract_words("application.properties").should == ["application", "properties"]
      @atmosphere.extract_words("MyJavaClass.java").should == ["my", "java", "class","java"]
    end
    
    it "discards the directories" do
      @atmosphere.extract_words("/some/weird/directory/").should == []
      @atmosphere.extract_words("/some/weird/directory/file.rb").should == ["file","rb"]
      @atmosphere.extract_words("/some/more.weird.directory/file.rb").should == ["file","rb"]
    end
    
    it "discards one-letter words" do
      @atmosphere.extract_words("a_file.rb").should == ["file", "rb"]
      @atmosphere.extract_words("a_file.h").should == ["file"]
      @atmosphere.extract_words("SVNChecker.cpp").should == ["checker", "cpp"]
    end
    
    it "discards hidden files or files in hidden directories" do
      @atmosphere.extract_words(".hidden_file").should == []
      @atmosphere.extract_words("/home/.hidden_directory/hidden_file.svn-base").should == []
    end
    
    it "discards new-lines" do
      @atmosphere.extract_words("file.rb\r\n").should == ["file", "rb"]
    end
    
  end
  
  describe "when counting words" do
    it "groups similar words" do
      @atmosphere.extract_words("some_file.rb")
      @atmosphere.extract_words("other_file.cpp")
      @atmosphere.word_count.should == {"file"=>2, "some" => 1, "other"=> 1, "rb"=>1, "cpp"=>1}
    end
  end
  
end
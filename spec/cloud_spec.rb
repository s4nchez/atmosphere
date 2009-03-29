require 'spec'
require 'lib/cloud'

describe Cloud do
  
  before(:each) do
    words = { "apple"     => 250,
              "mac"       => 200,
              "cool"      => 125,
              "ipod"      => 100,
              "iphone"    =>  70,
              "bite"      =>  50,
              "cult"      =>  10,
              "overrated" =>   1 }
    @cloud = Cloud.new(words)
  end
  
  it "should parametrise word counts" do
    @cloud.give_me_words(8, 10, 100).should == [["apple",    100],
                                                ["mac",       81],
                                                ["cool",      54],
                                                ["ipod",      45],
                                                ["iphone",    34],
                                                ["bite",      27],
                                                ["cult",      13],
                                                ["overrated", 10]]     
  end
  
  it "should allow picking only the most popular results" do
    @cloud.give_me_words(3, 125, 250).should == [["apple",    250],
                                                 ["mac",      200],
                                                 ["cool",     125]]
  end
  
  it "should allow filtering words" do
    @cloud.filter = ["apple", "mac"]
    @cloud.give_me_words(3, 125, 250).should == [["cool",    250],
                                                 ["ipod",    193],
                                                 ["iphone",  125]]
  end
end
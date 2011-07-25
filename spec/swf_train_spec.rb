require 'spec_helper'

describe "SwfTrain" do
  
  describe "DOM container" do

    it "gets created by default" do
      swf('foo.swf').should =~ /<div id=\"foo_swf\"/
    end
    
    it "is not created if :create_dom_container option is false" do
      swf('foo.swf', :create_dom_container => false).should_not =~ /<div id=\"foo_swf\"/
    end
    
    it "takes a custom name" do
      swf('foo.swf', :dom_id => 'binkle_dinkle').should =~ /<div id=\"binkle_dinkle\"/
    end
    
  end

  describe "ready_wrapper" do
    
    it "wraps the output in jQuery-style ready statement by default" do
      swf('foo.swf').should =~ /\$\(document\)\.ready/
    end
    
    it "wraps the output in a head.js read statement if :use_headjs option is present" do
      swf('foo.swf', :use_headjs => true).should =~ /head\.ready/
    end
    
  end

end

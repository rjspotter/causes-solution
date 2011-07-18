require 'rspec'
require File.dirname(__FILE__) + '/../lib/friend_network'

describe String do

  context "friends" do
    
    it "should respond to friend?" do
      String.new.should respond_to(:friend?)
    end

    context "length only" do

      it "should return false if the length difference is > 1" do
        "foo".friend?("fooba").should be_false
      end

      it "should return true if the length difference is 0" do
        "foo".friend?("boo").should be_true
      end

      it "should return true if the length difference is 1" do
        "foo".friend?("fooo").should be_true
      end

    end

    context "replacement" do
      
      it "should return true if only one letter is different" do
        "foo".friend?("boo").should be_true
      end

      it "should return false if two letters are different" do
        "foo".friend?("fxx").should be_false
      end

    end
    

  end

end

describe FriendNetwork do

  context "init" do

    it "should set the haystack from the initializer" do
      FriendNetwork.new('',%w[foo bar baz]).haystack.should == %w[foo bar baz]
    end

  end

  context "get_hits" do
    
    it "should return array of words that are friends from haystack" do
      fn = FriendNetwork.new('', %w[fooo boo bxx asdf])
      fn.get_hits('foo').should == %w[fooo boo]
    end

  end

  context "friends" do
    
    it "should add first level friends to the finished list" do
      FriendNetwork.new('causes',%w[cause asdf qwer caudes]).friends.sort.should == %w[cause caudes].sort
    end

    it "should add second level friends to the finished list" do
      FriendNetwork.new('causes',%w[cause caudesy asdf qwer caudes]).friends.sort.should == %w[cause caudes caudesy].sort
    end

  end

end

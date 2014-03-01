require 'spec_helper'

describe Player do

  describe "associations" do
    it { should have_many(:batting_stats) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:code) }
    
    it { should validate_uniqueness_of(:code) }
  end

  before(:each) do
    @player = Fabricate(:player, code: 'NMB')
  end

  context :generate_ do
    it "should return a genrated code for player" do
      Player.generate_code('Nick', 'Barthelemy').should == 'barthni01'
    end
    it "should return nil" do
      Player.generate_code('Nick', '').should == nil
    end
    it "should return nil" do
      Player.generate_code('','Barthelemy').should == nil
    end
  end

  context :name do
    it "should return the full name of the player" do
      @player.full_name.should_not be_nil
    end
  end

end
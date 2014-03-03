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
    @player = Fabricate(:player, code: 'P1')
  end

  context :generate_code do
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
      @player.name.should_not be_nil
    end
  end

  context :teams do
    it "should have a team for 2012" do
      Fabricate(:batting_stat, year: 2012)
      @player.team(2012).name.should == 'Minnesota Twins'
    end
  end

end
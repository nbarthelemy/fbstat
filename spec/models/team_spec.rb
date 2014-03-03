require 'spec_helper'

describe Team do

  describe "associations" do
    it { should have_many(:batting_stats) }
  end

  describe "validations" do
    # it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    
    it { should validate_uniqueness_of(:code) }
  end

  before(:each) do
    @team = Fabricate(:team, code: 'TWN')
  end

end

require 'spec_helper'

describe BattingStat do

  describe "associations" do
    it { should belong_to(:player) }
    it { should belong_to(:team) }
  end

  describe "validations" do
    it { should validate_presence_of(:player_id) }
    it { should validate_presence_of(:team_id) }
    it { should validate_presence_of(:year) }

    it { should validate_uniqueness_of(:player_id).scoped_to([ :team_id, :year ]) }
  end

end

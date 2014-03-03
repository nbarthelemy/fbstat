require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      BattingStat.stub(:most_improved_batting_average){ 
        [{ player: Fabricate(:player, code: 'p1'), value: 1 }]
      }

      BattingStat.stub(:most_improved_fantasy_points){
        [{ player: Fabricate(:player, code: 'p2'), value: 1 }]
      }

      BattingStat.stub(:triple_crown_winner){ 'No Winner' }

      get 'index'

      assigns(:most_improved_batting_average).should be_kind_of(Player)
      assigns(:most_improved_fantasy_points).should be_kind_of(Array)
      assigns(:batting_stats_for_oak_2007).should be_kind_of(ActiveRecord::Relation)
      assigns(:triple_crown_winners).should be_kind_of(Array)

      response.should be_success
    end
  end

end
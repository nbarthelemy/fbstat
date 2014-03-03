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

  context :most_improved do
    before(:each) do
      @p1 = Fabricate(:player, code: 'P1')
      @p1.batting_stats << Fabricate(:batting_stat, year: 2009, at_bats: 510, hits: 110, rbis: 35)
      @p1.batting_stats << Fabricate(:batting_stat, year: 2010, at_bats: 515, hits: 200, rbis: 45)
      @p1.batting_stats << Fabricate(:batting_stat, year: 2011, at_bats: 505, hits: 125, rbis: 50)
      @p1.batting_stats << Fabricate(:batting_stat, year: 2012, at_bats: 555, hits: 155, rbis: 62)

      @p2 = Fabricate(:player, code: 'P2')
      @p2.batting_stats << Fabricate(:batting_stat, year: 2009, at_bats: 510, hits: 110, rbis: 20)
      @p2.batting_stats << Fabricate(:batting_stat, year: 2010, at_bats: 560, hits: 200, rbis: 30)
      @p2.batting_stats << Fabricate(:batting_stat, year: 2011, at_bats: 500, hits: 130, rbis: 35)
      @p2.batting_stats << Fabricate(:batting_stat, year: 2012, at_bats: 550, hits: 140, rbis: 45)

      @p3 = Fabricate(:player, code: 'P3')
      @p3.batting_stats << Fabricate(:batting_stat, year: 2009, at_bats: 500, hits: 100, rbis: 35)
      @p3.batting_stats << Fabricate(:batting_stat, year: 2010, at_bats: 520, hits: 200, rbis: 55)
      @p3.batting_stats << Fabricate(:batting_stat, year: 2011, at_bats: 510, hits: 145, rbis: 45)
      @p3.batting_stats << Fabricate(:batting_stat, year: 2012, at_bats: 560, hits: 150, rbis: 55)
    end

    it "should have the most improved batting average between 2009 and 2010" do
      BattingStat.most_improved_batting_average(2009, 2010).first[:player].should == @p3
    end

    it "should have the most improved fantasy points between 2011 and 2012" do
      BattingStat.most_improved_fantasy_points(2011, 2012).first[:player].should == @p2
    end
  end

  context :triple_crown_winner do
    before(:each) do
      @p1 = Fabricate(:player, code: 'P1')
      @p1.batting_stats << Fabricate(:batting_stat, year: 2012, at_bats: 550, hits: 130, homeruns: 15, rbis: 25)

      @p2 = Fabricate(:player, code: 'P2')
      @p2.batting_stats << Fabricate(:batting_stat, year: 2012, at_bats: 550, hits: 155, homeruns: 10, rbis: 30)

      @p3 = Fabricate(:player, code: 'P3')
      @p3.batting_stats << Fabricate(:batting_stat, year: 2012, at_bats: 550, hits: 160, homeruns: 25, rbis: 55)
    end

    it "should find the triple crown winner" do
      BattingStat.triple_crown_winner('American', 2012).should == @p3
    end
  end

  context :fantasy_points do
    before(:each) do
      @player = Fabricate(:player, code: 'P1')
    end

    it "should have fantasy points" do
      @batting_stat = Fabricate(:batting_stat, year: 2012, homeruns: 25, rbis: 100, 
        stolen_bases: 5, caught_stealing: 5)
      @batting_stat.fantasy_points.should == 200
    end
  end

  context :batting_average do
    before(:each) do
      @player = Fabricate(:player, code: 'P1')
    end

    it "should have a batting average" do
      Fabricate(:batting_stat, year: 2012, at_bats: 500, hits: 100).batting_average.should == 0.200
    end
  end

  context :slugging_percentage do
    before(:each) do
      @player = Fabricate(:player, code: 'P1')
    end

    it "should have a slugging percentage" do
      @batting_stat = Fabricate(:batting_stat, year: 2012, at_bats: 500, 
        hits: 180, doubles: 25, triples: 5, homeruns: 15)
      @batting_stat.slugging_percentage.should == 0.52
    end
  end

end

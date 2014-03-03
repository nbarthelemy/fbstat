class CreateBattingStats < ActiveRecord::Migration
  def change
    create_table :batting_stats do |t|
      t.references :player, index: true
      t.references :team, index: true
      t.integer :year
      t.integer :games_played
      t.integer :at_bats
      t.integer :runs
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :homeruns
      t.integer :rbis
      t.integer :stolen_bases
      t.integer :caught_stealing
    end
  end
end

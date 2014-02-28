class CreatePlayers < ActiveRecord::Migration
  
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :birth_year
      t.string :code
    end
  end

end

class BattingStat < ActiveRecord::Base

  ## Associations

  belongs_to :player
  belongs_to :team


  ## Validations

  validates :player_id, :team_id, :year, presence: true
  validates :player_id, uniqueness: { scope: [ :team_id, :year ] }

end

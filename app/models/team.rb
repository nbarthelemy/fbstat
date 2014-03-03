class Team < ActiveRecord::Base

  ## Associations

  has_many :batting_stats

  ## Validation

  validates :league, :code, presence: true
  validates :code, uniqueness: true

end
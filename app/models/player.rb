class Player < ActiveRecord::Base

  ## Associations

  has_many :batting_stats

  ## Validations

  validates :first_name, :last_name, :birth_year, :code, presence: true
  validates :code, uniqueness: true

  ## Instance Methods

  def full_name
    [ first_name, last_name ].join(' ')
  end
  alias :name :full_name

end

class Player < ActiveRecord::Base

  ## Associations

  has_many :batting_stats

  ## Validations

  validates :first_name, :last_name, :code, presence: true
  validates :code, uniqueness: true

  ## Callbacks

  before_validation :ensure_code

  ## Class Methods

  class << self

    def generate_code(first_name, last_name)
      return nil if ( first_name.blank? || last_name.blank? )
      code = ( last_name.gsub(/\W+/,'')[0..4] + first_name.gsub(/\W+/,'')[0..1] ).downcase
      code = code + sprintf("%02d", where("code LIKE ?", "#{code}%").count + 1)
      code
    end

  end

  ## Instance Methods

  def full_name
    [ first_name, last_name ].join(' ')
  end
  alias :name :full_name

private

  def ensure_code
    self.code ||= self.class.generate_code(first_name, last_name)
  end

end
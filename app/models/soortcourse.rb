class Soortcourse < ActiveRecord::Base
  has_many :courses

  validates :prijs, :cursussoort, presence: true
end

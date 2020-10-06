class Polygon < ApplicationRecord
  has_many :spatial_domains
  has_many :rules, through: :spatial_domains

  validates :name, presence: true
  validates :source, presence: true
  validates :geography, presence: true

  def banana!
    self.banana = 123
  end
end

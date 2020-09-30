class Polygon < ApplicationRecord
  has_many :spatial_domains
  has_many :rules, through: :spatial_domains
end

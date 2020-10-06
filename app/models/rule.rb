class Rule < ApplicationRecord
  belongs_to :user
  has_many :industry_rules
  has_many :industries, through: :industry_rules
  has_many :spatial_domains
  has_many :polygons, through: :spatial_domains

  accepts_nested_attributes_for :polygons, :industries
end

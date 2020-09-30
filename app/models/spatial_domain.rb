class SpatialDomain < ApplicationRecord
  belongs_to :polygon
  belongs_to :rule
end

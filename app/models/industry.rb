class Industry < ApplicationRecord
  has_many :industry_rules
  has_many :rules, through: :industry_rules
end

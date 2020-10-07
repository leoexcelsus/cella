class Rule < ApplicationRecord
  belongs_to :user
  has_many :industry_rules, dependent: :destroy
  has_many :industries, through: :industry_rules
  has_many :spatial_domains, dependent: :destroy
  has_many :polygons, through: :spatial_domains

  accepts_nested_attributes_for :polygons, :industries

  validates :jurisdiction, presence: true
  validates :issuer, presence: true
  validates :category, presence: true
  validates :number, presence: true
  validates :pub_date, presence: true
  validates :ed_date, presence: true
  validates :long_title, presence: true
  validates :hyperlink, presence: true
  validates :hyperlink, format: URI::regexp(%w[http https])
  validates_presence_of :industries
  validates_associated :industries
  validates_presence_of :polygons
  validates_associated :polygons


  validate :pub_date_must_be_greater_than_ed_date
  def pub_date_must_be_greater_than_ed_date
    if (pub_date < ed_date) || (ed_date > Date.today)
      errors.add(:pub_date, ": A data de edição não pode ser no futuro e nem após a data de publicação")
    end
  end

end

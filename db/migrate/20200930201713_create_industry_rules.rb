class CreateIndustryRules < ActiveRecord::Migration[6.0]
  def change
    create_table :industry_rules do |t|
      t.references :rule, null: false, foreign_key: true
      t.references :industry, null: false, foreign_key: true

      t.timestamps
    end
  end
end

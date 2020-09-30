class CreateSpatialDomains < ActiveRecord::Migration[6.0]
  def change
    create_table :spatial_domains do |t|
      t.references :polygon, null: false, foreign_key: true
      t.references :rule, null: false, foreign_key: true

      t.timestamps
    end
  end
end

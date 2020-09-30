class CreateRules < ActiveRecord::Migration[6.0]
  def change
    create_table :rules do |t|
      t.string :jurisdiction
      t.string :issuer
      t.string :category
      t.string :number
      t.date :pub_date
      t.date :ed_date
      t.text :long_title
      t.string :hyperlink
      t.string :source
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreatePolygons < ActiveRecord::Migration[6.0]
  def change
    create_table :polygons do |t|
      t.string :name
      t.string :source
      t.multi_polygon :geography, geographic: true, srid: 4326

      t.timestamps
    end
  end
end

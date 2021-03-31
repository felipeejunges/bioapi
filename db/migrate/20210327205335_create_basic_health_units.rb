class CreateBasicHealthUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_health_units do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :phone
      t.string :cnes
      t.references :geocode, index: true, foreign_key: {
        to_table: :basic_health_unit_geocodes
      }
      t.references :scores, index: true, foreign_key: {
        to_table: :basic_health_unit_scores
      }

      t.timestamps
    end
  end
end

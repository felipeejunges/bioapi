class CreateBasicHealthUnitGeocodes < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_health_unit_geocodes do |t|
      t.numeric :lat
      t.numeric :long

      t.timestamps
    end
  end
end

class CreateBasicHealthUnitScores < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_health_unit_scores do |t|
      t.integer :size
      t.integer :adaptation_for_seniors
      t.integer :medical_equipment
      t.integer :medicine

      t.timestamps
    end
  end
end

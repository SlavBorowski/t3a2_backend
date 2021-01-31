class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :favorite_place
      t.text :bio

      t.timestamps
    end
  end
end

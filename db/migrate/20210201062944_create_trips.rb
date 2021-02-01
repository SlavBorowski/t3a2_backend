class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.string :title
      t.date :date
      t.string :city
      t.string :favoriteAttraction
      t.text :reflections
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

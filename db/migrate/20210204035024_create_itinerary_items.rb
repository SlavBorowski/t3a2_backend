class CreateItineraryItems < ActiveRecord::Migration[6.0]
  def change
    create_table :itinerary_items do |t|
      t.string :POI_id
      t.string :time
      t.text :notes
      t.references :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end

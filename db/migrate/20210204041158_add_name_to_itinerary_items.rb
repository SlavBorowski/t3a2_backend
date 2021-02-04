class AddNameToItineraryItems < ActiveRecord::Migration[6.0]
  def change
    add_column :itinerary_items, :name, :string
  end
end

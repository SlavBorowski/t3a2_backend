class CreatePrivateLandmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :private_landmarks do |t|
      t.string :title
      t.string :city
      t.text :notes
      t.date :latest_visit
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreatePicHouses < ActiveRecord::Migration
  def change
    create_table :pic_houses do |t|
      t.integer :review_house_id

      t.timestamps null: false
    end
  end
end

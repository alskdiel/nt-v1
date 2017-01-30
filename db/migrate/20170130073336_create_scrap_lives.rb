class CreateScrapLives < ActiveRecord::Migration
  def change
    create_table :scrap_lives do |t|
      t.integer :review_life_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

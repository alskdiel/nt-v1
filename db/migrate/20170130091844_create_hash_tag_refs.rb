class CreateHashTagRefs < ActiveRecord::Migration
  def change
    create_table :hash_tag_refs do |t|
      t.integer :hash_tag_id
      t.integer :review_life_id

      t.timestamps null: false
    end
  end
end

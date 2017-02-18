class CreateLinktoHitLogs < ActiveRecord::Migration
  def change
    create_table :linkto_hit_logs do |t|
      t.integer :user_id
      t.integer :review_life_id
      t.string :url

      t.timestamps null: false
    end
  end
end

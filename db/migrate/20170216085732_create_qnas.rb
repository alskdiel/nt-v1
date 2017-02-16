class CreateQnas < ActiveRecord::Migration
  def change
    create_table :qnas do |t|
      t.integer :user_id
      t.string :title
      t.text :question
      t.text :answer

      t.timestamps null: false
    end
  end
end

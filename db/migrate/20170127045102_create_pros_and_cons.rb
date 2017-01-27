class CreateProsAndCons < ActiveRecord::Migration
  def change
    create_table :pros_and_cons do |t|
      t.integer :review_house_id
      t.integer :type
      t.string :content

      t.timestamps null: false
    end
  end
end

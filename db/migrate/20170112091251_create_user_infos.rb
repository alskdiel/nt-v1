class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.string :nickname
      t.integer :birth
      t.integer :occupation
      t.integer :sex

      t.timestamps null: false
    end
  end
end

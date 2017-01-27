class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :pros_and_cons, :type, :content_type
  end
end

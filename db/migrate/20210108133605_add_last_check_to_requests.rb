class AddLastCheckToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :last_check, :date
  end
end

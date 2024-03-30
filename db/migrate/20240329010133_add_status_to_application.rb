class AddStatusToApplication < ActiveRecord::Migration[7.1]
  def change
    add_column :applications, :status, :string, default: "In Progress" 

  end
end

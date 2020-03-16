class AddProcessStatus < ActiveRecord::Migration[6.0]
  def change
    add_column :scannings, :process_status, :integer
  end
end

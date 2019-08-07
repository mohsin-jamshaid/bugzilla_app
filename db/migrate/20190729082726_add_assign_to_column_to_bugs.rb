class AddAssignToColumnToBugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :bugs, :assign_to, foreign_key: { to_table: :users }
  end
end

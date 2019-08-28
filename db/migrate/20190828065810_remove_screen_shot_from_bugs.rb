class RemoveScreenShotFromBugs < ActiveRecord::Migration[5.2]
  def change
    remove_column :bugs, :screen_shot, :string
  end
end

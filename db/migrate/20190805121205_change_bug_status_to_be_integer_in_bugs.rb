class ChangeBugStatusToBeIntegerInBugs < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :bug_status, 'integer USING CAST(bug_status AS integer)'
  end
end

class AddLogFileToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :log_file, :string
  end
end

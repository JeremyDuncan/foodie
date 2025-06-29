# ==============================================================================
# Disable SQLite WAL logging in development so only the .sqlite3 file is used
# and the -wal/-shm files are not created on each connection.
# ------------------------------------------------------------------------------
if Rails.env.development?
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.connection.execute("PRAGMA journal_mode = DELETE;")
  end
end
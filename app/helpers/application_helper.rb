module ApplicationHelper
  include ConsoleColors
  # ============================================================================
  # Wraps the `debug` console output method so it can be called from views.
  # This will only execute in development or staging environments.
  # ----------------------------------------------------------------------------
  def print(var, description = "DEBUG")
    return unless Rails.env.development? || Rails.env.staging?
    debug(var, description)
    nil
  end

end

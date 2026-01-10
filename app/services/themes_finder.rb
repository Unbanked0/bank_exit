class ThemesFinder < ApplicationService
  attr_reader :date

  def initialize(date = Date.current)
    @date = date.strftime('%m-%d')
  end

  def call
    {
      light: Setting::LIGHT_THEME_NAME,
      dark: Setting::DARK_THEME_NAME
    }
  end

  def christmas_time?
    return false if FeatureFlag.disabled?(:snowflakes)

    @christmas_time ||=
      ('12-10'..'12-31').cover?(date) ||
      ('01-01'..'01-10').cover?(date)
  end
end

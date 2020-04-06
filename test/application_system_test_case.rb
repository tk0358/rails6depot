require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Selenium::WebDriver::Chrome.driver_path = "/mnt/c/Program Files/chromedriver_win32/chromedriver.exe"
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end

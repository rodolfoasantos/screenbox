require 'screenshot'
require 'tray_application'

app = TrayApplication.new

app.add_item "Screenshot" do
  Screenshot.capture
end

app.run

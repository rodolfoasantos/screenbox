require 'core/screenshot'
require 'core/tray_application'

app = TrayApplication.new

app.set_tray_image '/images/camera.png'

app.add_item "Screenshot" do
  Screenshot.capture
end

app.run

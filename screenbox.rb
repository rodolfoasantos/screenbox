require 'core/screenshot'
require 'core/tray_application'
require 'core/services/dropbox'

app     = TrayApplication.new
dropbox = Services::Dropbox.new

app.set_tray_image '/images/camera.png'

app.add_item "Screenshot" do
  Screenshot.capture
end

app.add_item "Exit" do
  java.lang.System::exit(0)
end

if dropbox.session.nil?
  #open a webview with dropbox login area
  app.open_web_view(dropbox.authenticate_url)
end

app.run

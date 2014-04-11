require 'java'

class Screenshot
  import java.awt.Robot
  import java.awt.Toolkit
  import java.awt.Rectangle
  import javax.imageio.ImageIO

  def self.capture
    robot = Robot.new
    retangle = Rectangle.new 0, 0, screen_resolution.get_width, screen_resolution.get_height
    image = robot.create_screen_capture(retangle)
    file  = java::io::File.new(file_name_pattern)
    ImageIO::write(image, "png", file)
  end

  private
  def self.screen_resolution
    @tollkit ||= Toolkit.get_default_toolkit.get_screen_size
  end

  def self.file_name_pattern
    Time.now.strftime "%Y%m%d%H%M%S" + "_screen.png"
  end

end

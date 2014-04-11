require 'java'

class Screenshot
  import java.awt.Robot
  import java.awt.Toolkit
  import java.awt.Rectangle
  import javax.imageio.ImageIO

  def self.capture
    robot = Robot.new
    resolution = screen_resolution
    retangle = Rectangle.new 0, 0, resolution.get_width, resolution.get_height
    image = robot.create_screen_capture(retangle)
    file  = java::io::File.new(file_name_pattern)
    ImageIO::write(image, "png", file)
    p file
  end

  private
  def self.screen_resolution
    Toolkit.get_default_toolkit.get_screen_size
  end

  def self.file_name_pattern
    Time.now.strftime "%Y%m%d%H%M%S" + "_screen.png"
  end

end

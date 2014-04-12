require 'java'
require 'swt'

class TrayApplication

  import org.eclipse.swt.widgets.TrayItem;
  import org.eclipse.swt.browser.Browser;

  def initialize
    @display = Swt::Widgets::Display.new
    @shell   = Swt::Widgets::Shell.new(@display)
    @menu    = Swt::Widgets::Menu.new(@shell, Swt::SWT::POP_UP)
    @image   = Swt::Graphics::Image.new(@display, 16, 16)
    @itens   = []
  end

  def add_item(label, &block)
    menu_item = Swt::Widgets::MenuItem.new(@menu, Swt::SWT::NONE)
    menu_item.set_text label
    menu_item.add_listener Swt::SWT::Selection, block
    @itens << menu_item
  end

  def set_tray_image(path)
    path = Dir.pwd + path
    begin
      @image = Swt::Graphics::Image.new(@display, path) unless path.nil?
    rescue => detail
      puts detail.backtrace.join("\n")
      @image = Swt::Graphics::Image.new(@display, 16, 16)
    end
  end

  def open_web_view(url)
    browser  = Browser.new(@shell,Swt::SWT::NONE)
    browser.set_bounds 0,0,600,400
    browser.setUrl(url);
    @shell.open
  end

  def run
    tray = TrayItem.new(@display.get_system_tray, Swt::SWT::NONE)
    tray.add_listener Swt::SWT::MenuDetect, Proc.new { |event| @menu.set_visible true }
    tray.set_image @image

    while !@shell.is_disposed?
      @display.sleep unless @display.read_and_dispatch
    end
  end

end

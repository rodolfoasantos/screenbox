require 'java'
require 'swt'

class TrayApplication

  import org.eclipse.swt.widgets.TrayItem;

  def initialize
    @display = display = Swt::Widgets::Display.new
    @shell   = Swt::Widgets::Shell.new(@display)
    @menu    = Swt::Widgets::Menu.new(@shell, Swt::SWT::POP_UP)
    @itens   = []
  end

  def add_item(label, &block)
    menu_item = Swt::Widgets::MenuItem.new(@menu, Swt::SWT::NONE)
    menu_item.set_text label
    menu_item.add_listener Swt::SWT::Selection, block
    @itens << menu_item
  end

  def run
    system_tray = @display.get_system_tray
    tray        = TrayItem.new(system_tray, Swt::SWT::NONE)
    tray.add_listener Swt::SWT::MenuDetect, Proc.new { |event| @menu.set_visible true }
    tray.set_image Swt::Graphics::Image.new(@display, 16, 16)

    while !@shell.is_disposed?
      @display.sleep unless @display.read_and_dispatch
    end

    @display.dispose
  end

end

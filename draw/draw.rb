require 'helpers/draw'

class Draw

  attr_accessor :app, :color, :width, :chooser, :picker

  def run
    setup_default_values
    draw_picker
    draw_chooser
    draw_clear
    observers
  end

  def draw_chooser
    @chooser = @app.list_box chooser_options(items: (1..10).step(2).to_a)
  end

  def draw_picker
    @app.fill @color
    @app.stroke @color
    @picker = @app.rect picker_options
  end

  def draw_clear
    @app.button "clear" do
      clear
    end
  end

  def observers
    @chooser.change do
      @width = @chooser.text
    end

    @picker.click do
      @color = @app.ask_color "Pick a color"
      draw_picker
    end

    draw_observe(@app)

    motion(@app) do |x,y,_x,_y|
      @app.append do
        @app.stroke @color
        @app.strokewidth @width
        @app.line x, y, _x, _y if drawing?
      end
    end
  end
end

Shoes.app do
  Draw.new(self).run
end

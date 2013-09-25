module Motion
  def motion(app)
    x, y = nil, nil
    app.motion do |_x, _y|
      if x and y and (x != _x or y != _y)
        yield x, y, _x, _y
      end
      x, y = _x, _y
    end
  end
end

module Drawing
  attr_accessor :drawing

  def drawing?
    @drawing
  end

  def draw_observe(app)
    app.click do
      @drawing = true
    end

    app.release do
      @drawing = false
    end
  end
end

module App
  def clear
    @app.clear
    setup
  end
end

class Draw
  include App
  include Motion
  include Drawing

  attr_accessor :app, :color, :width, :chooser, :picker

  def initialize app
    @app = app
    setup
  end

  def setup
    @app.background "#fff"
    @color = "#000"
    @width = 3
    @chooser = nil
    draw_picker
    draw_chooser
    draw_clear
    observers
  end

  def draw_chooser
    @chooser = @app.list_box items: (1..10).step(2).to_a, margin_left: 40, margin_top: 10
  end

  def draw_picker
    @app.fill @color
    @app.stroke @color
    @picker = @app.rect top: 10, left: 10, width: 20, height: 20
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
  Draw.new self
end

class Draw
  attr_accessor :app, :color, :width, :chooser, :picker, :drawing

  def initialize app
    @app = app
    @color = "#000"
    @width = 3
    @chooser = nil
    @drawing = false
    setup
  end

  def setup
    @app.background "#fff"
    draw_app
    observers
  end

  def draw_app
    draw_picker
    @chooser = @app.list_box items: (1..10).step(2).to_a, margin_left: 40, margin_top: 10
    @app.button "clear" do
      clear
    end
  end

  def draw_picker
    @app.fill @color
    @app.stroke @color
    @picker = @app.rect top: 10, left: 10, width: 20, height: 20
  end

  def drawing?
    @drawing
  end

  def clear
    @app.clear
    setup
  end

  def observers
    @chooser.change do
      @width = @chooser.text
    end

    @picker.click do
      @color = @app.ask_color "Pick a color"
      draw_picker
    end

    @app.click do
      @drawing = true
    end
    @app.release do
      @drawing = false
    end

    x, y = nil, nil
    @app.motion do |_x, _y|
      if x and y and (x != _x or y != _y)
        @app.append do
          @app.stroke @color
          @app.strokewidth @width
          @app.line x, y, _x, _y if drawing?
        end
      end
      x, y = _x, _y
    end
  end
end

Shoes.app do
  def start_draw
    @draw = Draw.new self
  end
  start_draw
end

module App
  def initialize app
    @app = app
  end

  def setup_default_values
    @app.background "#fff"
    @color = "#000"
    @width = 3
    @chooser = nil
  end

  def clear
    @app.clear
    run
  end

  def chooser_options opts={}
    opts.merge :margin_left => 40, :margin_top => 10
  end

  def picker_options opts={}
    opts.merge :top => 10, :left => 10, :width => 20, :height => 20
  end
end

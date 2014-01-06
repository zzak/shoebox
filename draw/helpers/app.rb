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
end

module Drawing
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

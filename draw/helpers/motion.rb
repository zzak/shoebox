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

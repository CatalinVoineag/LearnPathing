class Player
  SPEED = 1.2

  attr_accessor :x, :y, :w, :h, :path
  attr_reader :x, :y, :w, :h, :path

  def initialize(hash = {}, args:)
    @x = hash[:x]
    @y = hash[:y]
    @w = hash[:w]
    @h = hash[:h]
    @path = hash[:path]
    @args = args
  end

  def data
    {
      x: x,
      y: y,
      w: w,
      h: h,
      path: path,
    }
  end

  def handle_movement
    if args.inputs.left
      @x -= SPEED
    end

    if args.inputs.right
      @x += SPEED
    end

    if args.inputs.up
      @y += SPEED
    end

    if args.inputs.down
      @y -= SPEED
    end
  end

  def middle_point
    {
      x: x + (w / 2),
      y: y + (h / 2),
      w: 1,
      h: 1,
    }
  end

  def tile_index
    args.state.tiles.find_index do |tile|
      tile.data.intersect_rect?(middle_point)
    end
  end
end

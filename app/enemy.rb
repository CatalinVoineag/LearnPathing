require_relative 'tile'

class Enemy
  SPEED = 1
  attr_accessor :x, :y, :w, :h, :path, :args

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
    return if args.geometry.distance(middle_point, args.state.player.middle_point) < 20

    next_tile = closest_neighbor_to_the_player

    if next_tile.x > @x
      @x += SPEED
    end

    if next_tile.x < @x
      @x -= SPEED
    end

    if next_tile.y > @y
      @y += SPEED
    end

    if next_tile.y < @y
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

  def closest_neighbor_to_the_player
    Tile.neighbor_tiles(args, tile_index).sort_by(&:distance_from_player).first
  end
end

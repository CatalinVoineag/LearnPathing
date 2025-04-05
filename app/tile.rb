class Tile
  attr_accessor :x, :y, :w, :h, :path, :r, :g, :b, :distance_from_player

  def initialize(hash = {})
    @x = hash[:x]
    @y = hash[:y]
    @w = hash[:w]
    @h = hash[:h]
    @path = hash[:path]
    @r = hash[:r]
    @g = hash[:g]
    @b = hash[:b]
  end

  def data
    {
      x: x,
      y: y,
      w: w,
      h: h,
      path: path,
      r: r,
      g: g,
      b: b,
    }
  end

  def middle_point
    {
      x: x + (w / 2),
      y: y + (h / 2),
      w: 1,
      h: 1,
    }
  end

  def self.generate_tiles(args)
    tile_size = 40
    x_tiles = (args.grid.w / tile_size).to_i
    y_tiles = (args.grid.h / tile_size).to_i
    results = []

    x_tiles.times do |x_tile|
      y_tiles.times do |y_tile|
        tile_rect = { x: tile_size * x_tile, y: tile_size * y_tile }
        results << new(
          {
            x: tile_rect.x,
            y: tile_rect.y,
            w: tile_size,
            h: tile_size,
            path: 'sprites/grass.png',
            r: 0,
            g: 0,
            b: 0,
          }
        )
      end
    end

    results
  end

  def self.update_distance_from_player(args)
    args.state.tiles.each do |tile|
      tile.distance_from_player = args.geometry.distance(tile.middle_point, args.state.player.middle_point)
    end
  end

  def self.neighbor_tiles(args, tile_index)
    current_tile = args.state.tiles[tile_index]

    [
      _up_tile = args.state.tiles.find { |tile| tile.x == current_tile.x && tile.y - current_tile.h == current_tile.y },
      _down_tile = args.state.tiles.find { |tile| tile.x == current_tile.x && tile.y + current_tile.h == current_tile.y },
      _right_tile = args.state.tiles.find { |tile| tile.x == current_tile.x + tile.w && tile.y == current_tile.y },
      _left_tile = args.state.tiles.find { |tile| tile.x == current_tile.x - tile.w && tile.y == current_tile.y },
    ]
  end
end

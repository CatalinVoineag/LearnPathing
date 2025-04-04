class Tile
  attr_accessor :x, :y, :w, :h, :path, :r, :g, :b

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

  def self.generate_tiles(args)
    tile_size = 40
    x_tiles = (args.grid.w / tile_size).to_i
    y_tiles = (args.grid.h / tile_size).to_i
    results = []

    x_tiles.times do |x_tile|
      y_tiles.times do |y_tile|
        results << new(
          {
            x: tile_size * x_tile,
            y: tile_size * y_tile,
            w: tile_size,
            h: tile_size,
            path: 'sprites/grass.png',
          }
        )
      end
    end

    results
  end
end

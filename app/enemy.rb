class Enemy
  attr_accessor :x, :y, :w, :h, :path

  def initialize(hash = {})
    @x = hash[:x]
    @y = hash[:y]
    @w = hash[:w]
    @h = hash[:h]
    @path = hash[:path]
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

  def self.spawn(tile_number:, tiles:)
    tile = tiles[tile_number]

    new({
      x: tile.x,
      y: tile.y,
      w: tile.w,
      h: tile.h,
      path: 'sprites/enemy.png'
    }).data
  end
end


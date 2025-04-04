require_relative 'tile'
require_relative 'player'
require_relative 'enemy'

def tick(args)
  args.outputs.debug << 'hi'
  @tiles ||= Tile.generate_tiles(args)

  args.outputs.sprites << [
    @tiles.map(&:data),
    Player.spawn(tile_number: 120, tiles: @tiles),
    Enemy.spawn(tile_number: 320, tiles: @tiles),
  ]
end

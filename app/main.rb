require_relative 'tile'
require_relative 'player'
require_relative 'enemy'

def tick(args)
  args.outputs.debug << 'hi'
  args.state.tiles ||= Tile.generate_tiles(args)
  args.state.player ||= init_player(120, args)
  args.state.enemy ||= init_enemy(320, args)
  Tile.update_distance_from_player(args)

  args.state.player.handle_movement

  player_tile = args.state.tiles[args.state.player.tile_index]
  player_tile.r = 255
  player_tile.g = 0
  player_tile.b = 0
  args.outputs.debug << "Player tile #{player_tile.data}"
  args.outputs.debug << "Distance from player #{args.state.tiles[320].distance_from_player}"

  closest_neighbor_to_the_player = args.state.enemy.closest_neighbor_to_the_player

  closest_neighbor_to_the_player.r = 255
  closest_neighbor_to_the_player.g = 0
  closest_neighbor_to_the_player.b = 0

  args.outputs.sprites << [
    args.state.tiles.map(&:data),
    args.state.player.data,
    args.state.player.middle_point,
    args.state.enemy.data,
  ]
end

def init_player(tile_number, args)
  tile = args.state.tiles[tile_number]

  Player.new(
    {
      x: tile.x,
      y: tile.y,
      w: tile.w,
      h: tile.h,
      path: 'sprites/player.png',
    },
    args: args
  )
end

def init_enemy(tile_number, args)
  tile = args.state.tiles[tile_number]

  Enemy.new(
    {
      x: tile.x,
      y: tile.y,
      w: tile.w,
      h: tile.h,
      path: 'sprites/enemy.png',
    },
    args: args,
  )
end

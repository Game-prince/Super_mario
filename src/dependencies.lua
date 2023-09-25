push = require 'lib/push'
Class = require 'lib/class'
Timer = require 'lib/knife.timer'

require 'src/constants'
require 'src/Util'

require 'src.Animation'
require 'src.TileMap'
require 'src.Tiles'
require 'src.Entity'
require 'src.Player'


require 'src/StateMachine'

-- game states
require 'src/States/BaseState'
require 'src.States.Game.TitleState'
require 'src.States.Game.PlayState'

-- player states
require 'src.States.Player.PlayerIdleState'

-- loading fonts
gFonts = {
  ['normal'] = {
    ['small'] = love.graphics.newFont('assets/fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('assets/fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('assets/fonts/font.ttf', 32),
    ['huge'] = love.graphics.newFont('assets/fonts/font.ttf', 64)
  },
  ['fipps'] = {
    ['small'] = love.graphics.newFont('assets/fonts/fipps.otf', 8),
    ['medium'] = love.graphics.newFont('assets/fonts/fipps.otf', 16),
    ['large'] = love.graphics.newFont('assets/fonts/fipps.otf', 32)
  },
  ['arcade'] = {
    ['small'] = love.graphics.newFont('assets/fonts/ArcadeAlternate.ttf', 8),
    ['medium'] = love.graphics.newFont('assets/fonts/ArcadeAlternate.ttf', 16),
    ['large'] = love.graphics.newFont('assets/fonts/ArcadeAlternate.ttf', 32)
  }
}

-- loading Textures
gTextures = {
  ['tiles'] = love.graphics.newImage('assets/graphics/tiles.png'),
  ['toppers'] = love.graphics.newImage('assets/graphics/tile_tops.png'),
  ['bushes'] = love.graphics.newImage('assets/graphics/bushes_and_cacti.png'),
  ['jump-blocks'] = love.graphics.newImage('assets/graphics/jump_blocks.png'),
  ['gems'] = love.graphics.newImage('assets/graphics/gems.png'),
  ['backgrounds'] = love.graphics.newImage('assets/graphics/backgrounds.png'),
  ['green-alien'] = love.graphics.newImage('assets/graphics/green_alien.png'),
  ['creatures'] = love.graphics.newImage('assets/graphics/creatures.png')
}

gFrames = {
  ['tiles'] = GenerateQuads(gTextures['tiles'], TILE_SIZE, TILE_SIZE),

  ['toppers'] = GenerateQuads(gTextures['toppers'], TILE_SIZE, TILE_SIZE),

  ['bushes'] = GenerateQuads(gTextures['bushes'], 16, 16),
  ['jump-blocks'] = GenerateQuads(gTextures['jump-blocks'], 16, 16),
  ['gems'] = GenerateQuads(gTextures['gems'], 16, 16),
  ['backgrounds'] = GenerateQuads(gTextures['backgrounds'], 256, 128),
  ['green-alien'] = GenerateQuads(gTextures['green-alien'], 16, 20),
  ['creatures'] = GenerateQuads(gTextures['creatures'], 16, 16)
}

-- these need to be added after gFrames is initialized because they refer to gFrames from within
gFrames['tilesets'] = GenerateTileSets(gFrames['tiles'],
  TILE_SETS_WIDE, TILE_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)

gFrames['toppersets'] = GenerateTileSets(gFrames['toppers'],
  TOPPER_SETS_WIDE, TOPPER_SETS_TALL, TILE_SET_WIDTH, TILE_SET_HEIGHT)

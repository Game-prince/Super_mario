require 'src/dependencies'

function love.load()
  -- setting up screen
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    fullscreen = false,
    resizable = true,
    vsync = true
  })
  love.window.setTitle('Mario')
  love.graphics.setDefaultFilter('nearest', 'nearest')

  math.randomseed(os.time())

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

  -- loading graphics
  gGraphics = {
    ['background'] = love.graphics.newImage('assets/graphics/backgrounds.png'),
    ['tile_tops'] = love.graphics.newImage('assets/graphics/tile_tops.png'),
    ['tiles'] = love.graphics.newImage('assets/graphics/tiles.png'),
    ['aliens'] = {
      ['blue'] = love.graphics.newImage('assets/graphics/blue_alien.png'),
      ['green'] = love.graphics.newImage('assets/graphis/geen_alien.png'),
      ['pink'] = love.graphics.newImage('assets/graphics/pink_alien.png')
    }
  }

  -- loading textures
  gTextures = {
    ['background'] = GenerateQuads(gGraphics['background'], 256, 128),
    ['tile_tops'] = GenerateQuads(gGraphics['tile_tops'], TILE_SIZE, TILE_SIZE),
    ['tiles'] = GenerateQuads(gGraphics['tiles'], TILE_SIZE, TILE_SIZE),
    ['aliens'] = {
      ['blue'] = GenerateQuads(gGraphics['aliens']['blue'], PLAYER_WIDTH, PLAYER_HEIGHT),
      ['green'] = GenerateQuads(gGraphics['aliens']['green'], PLAYER_WIDTH, PLAYER_HEIGHT),
      ['pink'] = GenerateQuads(gGraphics['aliens']['pink'], PLAYER_WIDTH, PLAYER_HEIGHT),
    }
  }

  -- States
  gStateMachine = StateMachine {
    ['title'] = function() return TitleState() end,
    ['play'] = function() return PlayState() end
  }

  gStateMachine:change('title')

  -- input table
  love.keyboard.keysPressed = {}
end

function love.draw()
  push:start()

  gStateMachine:render()

  push:finish()
end

function love.update(dt)
  love.graphics.setBackgroundColor(169 / 255, 169 / 255, 169 / 255, 255 / 255)
  gStateMachine:update(dt)

  -- clearning the input table after each frame
  love.keyboard.keysPressed = {}
end

function love.keypressed(key)
  -- adding the pressed key to the input table
  love.keyboard.keysPressed[key] = true

  -- If the player hits escape then exit the game
  if key == 'escape' then
    love.event.quit()
  end
end

function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end

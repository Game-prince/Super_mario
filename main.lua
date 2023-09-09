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
    ['full_sheet'] = love.graphics.newImage('assets/graphics/full_sheet.png'),
    ['background'] = love.graphics.newImage('assets/graphics/backgrounds.png')
  }

  -- loading textures
  gTextures = {
    ['background'] = GetBackgrounds(gGraphics['background'])
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

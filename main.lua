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

  -- States
  gStateMachine = StateMachine {
    ['title'] = function() return TitleState() end,
    ['play'] = function() return PlayState() end,
    ['game-over'] = function() return GameOverState() end
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
  love.graphics.clear()
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

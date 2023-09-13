TitleState = Class { __includes = BaseState }

function TitleState:init()

end

function TitleState:enter(params)

end

function TitleState:render()
  love.graphics.setFont(gFonts['normal']['huge'])
  love.graphics.setColor(240 / 255, 128 / 255, 128 / 255, 255 / 255)
  love.graphics.printf("Mario", 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, 'center')
  love.graphics.setColor(1, 1, 1, 1)

  love.graphics.setFont(gFonts['normal']['medium'])
  love.graphics.printf("Press Enter to start", 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, 'center')
end

function TitleState:update(dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end
end

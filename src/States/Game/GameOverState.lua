GameOverState = Class { __includes = BaseState }


function GameOverState:init()

end

function GameOverState:render()
  love.graphics.setFont(gFonts['normal']['large'])
  love.graphics.setColor(255, 0, 0, 255)
  love.graphics.printf("Game Over !", 0, VIRTUAL_HEIGHT / 2 - 32, VIRTUAL_WIDTH, "center")



  love.graphics.setFont(gFonts['normal']['medium'])
  love.graphics.setColor(0, 255, 0, 255)
  love.graphics.printf("Score : " .. self.score, 0, VIRTUAL_HEIGHT / 2 + 8, VIRTUAL_WIDTH, "center")

  love.graphics.setFont(gFonts['normal']['small'])
  love.graphics.setColor(255, 255, 255, 255)
  love.graphics.printf("Press Enter to restart", 0, VIRTUAL_HEIGHT / 2 + 32, VIRTUAL_WIDTH, "center")
end

function GameOverState:update(dt)
  if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
    gStateMachine:change('play')
  end
end

function GameOverState:enter(params)
  self.score = params['score']
end

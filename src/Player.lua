Player = Class {}

function Player:init(x, y, color, stateMachine)
  self.x = x
  self.y = y

  -- checking the color is valid or not
  assert(gTextures['aliens'][color], "Invalid player alien color")
  self.color = color

  self.stateMachine = stateMachine
end

function Player:render()
  love.graphics.draw(gTextures['aliens'][self.color], gTextures['aliens'][self.color], self.x, self.y)
end

function Player:update(dt)

end

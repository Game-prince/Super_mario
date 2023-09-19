Entity = Class {}

function Entity:init(def)
  -- position
  self.x = def.x
  self.y = def.y

  -- dimensions
  self.width = def.width
  self.height = def.height

  -- speed
  self.dx = 0
  self.dy = 0

  self.texture = def.texture
  self.stateMachine = def.stateMachine

  self.direction = "left"
  self.map = def.map
  self.level = def.level

  self.animation = def.animation
end

function Entity:changeState(state)
  self.stateMachine:change(state)
end

function Entity:update(dt)
  self.stateMachine.update(dt)
end

function Entity:render()
  love.graphics.draw(gGraphics[self.texture], gTextures[self.texture][self.currentAnimation:getCurrentFrame()],
    math.floor(self.x) + 8, math.floor(self.y) + 10, 0, self.direction == "right" and 1 or -1, 1, 8, 10)
end

function Entity:collides(entity)
  return not (self.x + self.width < entity.x or self.x > entity.x + entity.width or self.y + self.height < entity.y or
    self.y > entity.y + entity.height)
end

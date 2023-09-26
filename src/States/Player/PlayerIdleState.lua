PlayerIdleState = Class { __includes = BaseState }

function PlayerIdleState:init(player)
  self.player = player
  self.animation = Animation {
    frames = { 1 },
    interval = 1
  }
  self.player.currentAnimation = self.animation
end

function PlayerIdleState:update(dt)
  self.player.currentAnimation:update(dt)

  if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
    self.player:changeState('running')
  end

  -- press spacebar to jump
  if love.keyboard.wasPressed('space') then
    self.player:changeState('jump')
  end

  -- check if there is any tile below the player or not
  if not self:collisionBottom() then
    self.player:changeState('falling')
  end
end

-- function to find if the collision below is happening or not
function PlayerIdleState:collisionBottom()
  -- getting the tile at which the bottom-left of the player is
  local bottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height + 1)

  -- getting the tile at which the bottom-right of the player is
  local bottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1,
    self.player.y + self.player.height + 1)

  -- if the bottom-left or bottom-right of the player is at a collidable tile return true
  if bottomLeft and bottomRight and (bottomLeft.id == TILE_ID_GROUND or bottomRight.id == TILE_ID_GROUND) then
    return true
  else
    return false
  end
end

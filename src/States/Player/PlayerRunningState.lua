PlayerRunningState = Class { __includes = BaseState }

function PlayerRunningState:init(player)
  self.player = player
  self.animation = Animation {
    frames = { 10, 11 },
    interval = 0.1
  }
  self.player.currentAnimation = self.animation
end

function PlayerRunningState:update(dt)
  self.player.currentAnimation:update(dt)

  -- if spacebar is pressed then change the player state to jumping
  if love.keyboard.wasPressed('space') then
    self.player:changeState('jump')
  end

  -- check if there is any tile below the player or not
  if not self:collisionBottom() then
    self.player:changeState('falling')
  end

  -- player movement left
  if love.keyboard.isDown("left") then
    self.player.direction = "left"

    -- if the player is colliding with any obstacle, stop the player
    if self:collisionLeft() then
      self.player.dx = 0
      self.player.x = self.player.x + 1
    else
      self.player.dx = -PLAYER_WALK_SPEED * dt
    end

    -- player movement right
  elseif love.keyboard.isDown("right") then
    self.player.direction = "right"

    -- if the player is colliding with any obstacle, stop the player
    if self:collisionRight() then
      self.player.dx = 0
      self.player.x = self.player.x - 1
    else
      self.player.dx = PLAYER_WALK_SPEED * dt
    end


    -- if no movement in the player, change state to idle
  else
    self.player:changeState("idle")
  end

  -- update the position of the player
  self.player.x = self.player.x + self.player.dx
end

function PlayerRunningState:collisionRight()
  -- getting the tile at which the top-right of the player is
  local rightTile = self.player.map:pointToTile(self.player.x + self.player.width + 1, self.player.y)

  -- if the top-right of the player is at collidable tile, return true
  if rightTile and rightTile.id == TILE_ID_GROUND then
    return true
  end

  -- getting the tile at which the bottom right of the player is
  local bottomRight = self.player.map:pointToTile(self.player.x + self.player.width + 1,
    self.player.y + self.player.height)

  -- if the bottom-right of the player is at a collidable tile return true
  if bottomRight and bottomRight.id == TILE_ID_GROUND then
    return true
  end

  return false
end

function PlayerRunningState:collisionLeft()
  -- getting the tile at which the top-left of the player is
  local leftTile = self.player.map:pointToTile(self.player.x - 1, self.player.y)

  -- if the top-left of the player is at collidable tile, return true
  if leftTile and leftTile.id == TILE_ID_GROUND then
    return true
  end

  -- getting the tile at which the bottom left of the player is
  local bottomLeft = self.player.map:pointToTile(self.player.x - 1,
    self.player.y + self.player.height)

  -- if the bottom-left of the player is at a collidable tile return true
  if bottomLeft and bottomLeft.id == TILE_ID_GROUND then
    return true
  end

  return false
end

-- function to find if the collision below is happening or not
function PlayerRunningState:collisionBottom()
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

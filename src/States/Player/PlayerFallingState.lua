PlayerFallingState = Class { __includes = BaseState }

function PlayerFallingState:init(player)
  self.player = player
  self.animation = Animation {
    frames = { 3 },
    interval = 1
  }

  self.player.currentAnimation = self.animation

  self.player.dy = 0
end

function PlayerFallingState:update(dt)
  self.player.currentAnimation:update(dt)

  -- if the player is colliding with any obstacle at bottom
  if self:collisionBottom() then
    self.player.dy = 0
    self.player.y = (self.player.map:pointToTile(self.player.x, self.player.y + self.player.height).y - 1) * TILE_SIZE -
        self.player.height - 1
    self.player:changeState('idle')
  end

  -- left movement in air
  if love.keyboard.isDown("left") then
    self.player.direction = "left"

    -- if the player is colliding with any obstacle, stop the player
    if self:collisionLeft() then
      self.player.dx = 0
    else
      self.player.dx = -PLAYER_WALK_SPEED * dt
    end

    -- right movement in air
  elseif love.keyboard.isDown("right") then
    self.player.direction = "right"

    -- if the player is colliding with any obstacle, stop the player
    if self:collisionRight() then
      self.player.dx = 0
    else
      self.player.dx = PLAYER_WALK_SPEED * dt
    end
  else
    self.player.dx = 0
  end

  -- applying gravity to the player
  self.player.dy = self.player.dy + GRAVITY
  self.player.y = self.player.y + (self.player.dy * dt)

  self.player.x = self.player.x + self.player.dx
end

-- function to check the collision of player at bottom
function PlayerFallingState:collisionBottom()
  -- getting the tile at which the bottom-left of the player is
  local bottomLeft = self.player.map:pointToTile(self.player.x + 1, self.player.y + self.player.height)

  -- getting the tile at which the bottom-right of the player is
  local bottomRight = self.player.map:pointToTile(self.player.x + self.player.width - 1,
    self.player.y + self.player.height)

  -- if the bottom-left or bottom-right of the player is at a collidable tile return true
  if bottomLeft and bottomRight and (bottomLeft.id == TILE_ID_GROUND or bottomRight.id == TILE_ID_GROUND) then
    return true
  else
    return false
  end
end

-- function to check if the player is colliding with any obstacle at left
function PlayerFallingState:collisionLeft()
  -- getting the tile at which the top-left of the player is
  local leftTile = self.player.map:pointToTile(self.player.x, self.player.y)

  -- if the top-left of the player is at collidable tile, return true
  if leftTile and leftTile.id == TILE_ID_GROUND then
    return true
  end

  -- getting the tile at which the bottom-left of the player is
  local bottomLeft = self.player.map:pointToTile(self.player.x, self.player.y + self.player.height)

  -- if the bottom-left of the player is at a collidable tile return true
  if bottomLeft and bottomLeft.id == TILE_ID_GROUND then
    return true
  end

  return false
end

-- function to check if the player is colliding with any obstacle at right
function PlayerFallingState:collisionRight()
  -- getting the tile at which the top-right of the player is
  local rightTile = self.player.map:pointToTile(self.player.x + self.player.width, self.player.y)

  -- if the top-right of the player is at collidable tile, return true
  if rightTile and rightTile.id == TILE_ID_GROUND then
    return true
  end

  -- getting the tile at which the bottom right of the player is
  local bottomRight = self.player.map:pointToTile(self.player.x + self.player.width,
    self.player.y + self.player.height)

  -- if the bottom-right of the player is at a collidable tile return true
  if bottomRight and bottomRight.id == TILE_ID_GROUND then
    return true
  end

  return false
end

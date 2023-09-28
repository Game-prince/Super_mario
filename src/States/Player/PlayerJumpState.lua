PlayerJumpState = Class { __includes = BaseState }

function PlayerJumpState:init(player)
  self.player = player
  self.animation = Animation {
    frames = { 3 },
    interval = 1
  }

  self.player.dy = PLAYER_JUMP_VELOCITY

  self.player.currentAnimation = self.animation
end

function PlayerJumpState:update(dt)
  self.player.currentAnimation:update(dt)

  -- if the player is colliding with any obstacle at top
  if self:collisionTop() then
    self.player.dy = 0
    self.player.y = self.player.y + 1
  end

  -- left movement in air
  if love.keyboard.isDown("left") then
    self.player.direction = "left"

    -- if the player is colliding with any obstacle, stop the player
    if self:collisionLeft() then
      self.player.dx = 0
      self.player.dy = 0
    else
      self.player.dx = -PLAYER_WALK_SPEED * dt
    end

    -- right movement in air
  elseif love.keyboard.isDown("right") then
    self.player.direction = "right"

    -- if the player is colliding with any obstacle, stop the player
    if self:collisionRight() then
      self.player.dx = 0
      self.player.dy = 0
    else
      self.player.dx = PLAYER_WALK_SPEED * dt
    end
  else
    self.player.dx = 0
  end

  -- if the y-velocity of the player reaches 0 or above, change to falling state
  if self.player.dy >= 0 then
    self.player:changeState('falling')
  end

  -- applying gravity to the player
  self.player.dy = self.player.dy + GRAVITY * dt
  self.player.y = self.player.y + (self.player.dy * dt)

  self.player.x = self.player.x + self.player.dx
end

-- function to check if the player is colliding with top of its head
function PlayerJumpState:collisionTop()
  -- getting the tile at which the top-left of the player is
  local topLeft = self.player.map:pointToTile(self.player.x, self.player.y)

  -- if the top-left of the player is at collidable tile, return true
  if topLeft and topLeft.id == TILE_ID_GROUND then
    return true
  end

  -- getting the tile at which the top-right of the player is
  local topRight = self.player.map:pointToTile(self.player.x + self.player.width, self.player.y)

  -- if the top-right of the player is at collidable tile, return true
  if topRight and topRight.id == TILE_ID_GROUND then
    return true
  end

  return false
end

-- function to check if the player is colliding with any obstacle at left
function PlayerJumpState:collisionLeft()
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
function PlayerJumpState:collisionRight()
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

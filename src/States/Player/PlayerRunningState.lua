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

  if love.keyboard.isDown("left") then
    self.player.direction = "left"
    self.player.dx = -PLAYER_WALK_SPEED * dt
  elseif love.keyboard.isDown("right") then
    self.player.direction = "right"
    self.player.dx = PLAYER_WALK_SPEED * dt
  else
    self.player:changeState("idle")
  end

  self.player.x = self.player.x + self.player.dx
end

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

  if self.player.dy >= 0 then
    self.player:changeState('falling')
  end

  self.player.dy = self.player.dy + GRAVITY
  self.player.y = self.player.y + (self.player.dy * dt)
end

PlayerFallingState = Class { __includes = BaseState }

function PlayerFallingState:init(player)
  self.player = player
  self.animation = Animation {
    frames = { 3 },
    interval = 1
  }

  self.player.currrentAnimation = self.animation


  self.player.dy = 0
end

function PlayerFallingState:update(dt)
  self.player.currrentAnimation:update(dt)

  self.player.dy = self.player.dy + GRAVITY
  self.player.y = self.player.y + (self.player.dy * dt)
end

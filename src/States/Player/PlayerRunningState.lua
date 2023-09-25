PlayerRunningState = Class { __includes = BaseState }

function PlayerRunningState:init(def)
  self.player = def.player
  self.animation = Animation({
    frames = { 10, 11 },
    interval = 0.5
  })
  self.player.currentAnimation = self.animation
end

function PlayerRunningState:update(dt)

end

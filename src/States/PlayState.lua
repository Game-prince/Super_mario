PlayState = Class { __includes = BaseState }

function PlayState:init()
  self.background = math.random(#gTextures['background'])
end

function PlayState:render()
  love.graphics.draw(gGraphics['background'], gTextures['background'][self.background], 0, 0)
end

function PlayState:update(dt)

end

function PlayState:enter(params)

end

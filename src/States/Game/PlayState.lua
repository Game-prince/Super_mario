PlayState = Class { __includes = BaseState }

function PlayState:init()
  self.background = math.random(#gTextures['background'])
  self.player = Player(50, 50, 'blue', StateMachine({

  }))
end

function PlayState:render()
  -- setting the background
  love.graphics.draw(gGraphics['background'], gTextures['background'][self.background], 0, 0, 0, VIRTUAL_WIDTH / 256,
    VIRTUAL_HEIGHT / 128)

  -- displaying all the tile tops
  for i = 1, #gTextures['tiles'] do
    love.graphics.draw(gGraphics['tiles'], gTextures['tile_tops'][i], (i - 1) * 16, VIRTUAL_HEIGHT - 16)
  end
end

function PlayState:update(dt)

end

function PlayState:enter(params)

end

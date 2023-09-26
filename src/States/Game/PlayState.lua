PlayState = Class { __includes = BaseState }

function PlayState:init()
  -- background for our game
  self.background = math.random(#gFrames['backgrounds'])
  self.backgroundX = 0

  -- position of camera
  self.cameraScroll = 0

  self.tilemap = LevelGenerator.createLevel(100, VIRTUAL_HEIGHT / TILE_SIZE)

  -- creating player
  self.player = Player({
    x = 50,
    y = 50,
    width = PLAYER_WIDTH,
    height = PLAYER_HEIGHT,
    texture = 'green-alien',
    stateMachine = StateMachine({
      ['idle'] = function() return PlayerIdleState(self.player) end,
      ['running'] = function() return PlayerRunningState(self.player) end,
      ['jump'] = function() return PlayerJumpState(self.player) end,
      ['falling'] = function() return PlayerFallingState(self.player) end
    }),
    map = self.tilemap,
    level = 1
  })
  self.player:changeState('idle')
end

function PlayState:render()
  love.graphics.translate(math.floor(self.cameraScroll), 0)
  love.graphics.clear(0.5, 0.5, 0.5, 1)


  -- setting the background
  love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX), 0)
  love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], math.floor(-self.backgroundX),
    gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)
  love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background],
    math.floor(-self.backgroundX + 256), 0)
  love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background],
    math.floor(-self.backgroundX + 256),
    gTextures['backgrounds']:getHeight() / 3 * 2, 0, 1, -1)

  self.tilemap:render()
  self.player:render()
end

function PlayState:update(dt)
  self.player:update(dt)
  self.tilemap:update(dt)

  if self.player.x + PLAYER_WIDTH / 2 >= VIRTUAL_WIDTH / 2 then
    if love.keyboard.isDown("right") then
      self.cameraScroll = self.cameraScroll - self.player.dx
    elseif love.keyboard.isDown("left") then
      self.cameraScroll = self.cameraScroll - self.player.dx
    end
  end
end

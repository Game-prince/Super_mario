PlayState = Class { __includes = BaseState }

function PlayState:init()
  -- background for our game
  self.background = math.random(#gFrames['backgrounds'])
  self.backgroundX = 0
  self.updateBackground = true

  -- position of camera
  self.cameraScroll = 0

  self.level = LevelGenerator.createLevel(100, VIRTUAL_HEIGHT / TILE_SIZE)

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
    map = self.level.tileMap,
    level = self.level
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

  -- display score
  love.graphics.setFont(gFonts['normal']['small'])
  love.graphics.printf("Score : " .. tostring(self.player.score), -self.cameraScroll, 0, VIRTUAL_WIDTH, "left")

  self.level:render()
  self.player:render()
end

function PlayState:update(dt)
  -- updating the level
  self.level:clear()
  self.level:update(dt)

  -- updating the player
  self.player:update(dt)

  -- moving the platform and background
  if self.player.x + self.player.width / 2 >= -self.cameraScroll + VIRTUAL_WIDTH / 2 then
    if love.keyboard.isDown("right") then
      self.cameraScroll = self.cameraScroll - self.player.dx
      self.backgroundX = self.backgroundX + BACKGROUND_SCROLL_SPEED * dt - self.player.dx
    elseif love.keyboard.isDown("left") then
      self.cameraScroll = self.cameraScroll - self.player.dx
      self.backgroundX = self.backgroundX - BACKGROUND_SCROLL_SPEED * dt - self.player.dx
    end
  end

  -- stopping the player to go beyond the left boundary
  if self.player.x <= -self.cameraScroll then
    self.player.x = -self.cameraScroll
  end

  -- if the player has fallen into the pit
  if self.player.y > VIRTUAL_HEIGHT then
    gStateMachine:change('game-over', {
      score = self.player.score
    })
  end
end

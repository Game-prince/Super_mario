PlayState = Class { __includes = BaseState }

function PlayState:init()
  -- background for our game
  self.background = math.random(#gFrames['backgrounds'])

  -- position of camera
  self.cameraScroll = 0

  -- width and height of tilemap
  self.width = VIRTUAL_WIDTH / TILE_SIZE
  self.height = VIRTUAL_HEIGHT / TILE_SIZE

  -- creating tilemap
  self.tilemap = TileMap(self.width, self.height)

  -- creating topperset and tileset
  self.topperset = math.random(20)
  self.tileset = math.random(20)

  -- creating tiles in the tilemap
  self.tilemap.tiles = {}
  for y = 1, self.height do
    table.insert(self.tilemap.tiles, {})

    for x = 1, self.width do
      local tileID = TILE_ID_GROUND
      if y < 6 then
        tileID = TILE_ID_EMPTY
      end
      table.insert(self.tilemap.tiles[y], Tiles(x, y, tileID, false, self.tileset, self.topperset))
    end
  end

  -- creating player
  self.player = Player({
    x = 50,
    y = 50,
    width = PLAYER_WIDTH,
    height = PLAYER_HEIGHT,
    texture = 'green-alien',
    stateMachine = StateMachine({
      ['idle'] = function() return PlayerIdleState(self.player) end,
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
  love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0, 0, VIRTUAL_WIDTH / 256,
    VIRTUAL_HEIGHT / 128)

  self.tilemap:render()
  self.player:render()
end

function PlayState:update(dt)
  -- self.player:update(dt)
  self.tilemap:update(dt)

  if love.keyboard.isDown("right") then
    self.cameraScroll = self.cameraScroll - PLAYER_WALK_SPEED * dt
  elseif love.keyboard.isDown("left") then
    self.cameraScroll = self.cameraScroll + PLAYER_WALK_SPEED * dt
  end
end

function PlayState:enter(params)

end

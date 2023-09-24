PlayState = Class { __includes = BaseState }

function PlayState:init()
  self.background = math.random(#gFrames['backgrounds'])
  self.player = Player({ 50, 50, 'blue', StateMachine({

  }) })

  self.width = VIRTUAL_WIDTH / TILE_SIZE
  self.height = VIRTUAL_HEIGHT / TILE_SIZE
  self.tilemap = TileMap(self.width, self.height)
  self.topperset = math.random(20)
  self.tileset = math.random(20)
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
end

function PlayState:render()
  -- setting the background
  love.graphics.draw(gTextures['backgrounds'], gFrames['backgrounds'][self.background], 0, 0, 0, VIRTUAL_WIDTH / 256,
    VIRTUAL_HEIGHT / 128)

  self.tilemap:render()
end

function PlayState:update(dt)
  self.player:update(dt)
  self.tilemap:update(dt)

  love.graphics.translate()
end

function PlayState:enter(params)

end

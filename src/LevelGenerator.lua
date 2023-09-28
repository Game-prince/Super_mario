LevelGenerator = Class {}

function LevelGenerator.createLevel(width, height)
  -- creating a tilemap
  local tilemap = TileMap(width, height)

  -- entities
  local entities = {}

  -- objects
  local objects = {}

  -- creating topperset and tileset
  local topper = true
  local topperset = math.random(20)
  local tileset = math.random(20)

  -- creating tiles in the tilemap
  tilemap.tiles = {}
  for x = 1, height do
    table.insert(tilemap.tiles, {})
  end

  for x = 1, width do
    local isPit = math.random(PIT_CHANCE) == 1 and true or false
    local isWall = math.random(WALL_CHANCE) == 1 and true or false


    for y = 1, height do
      local tileId = TILE_ID_EMPTY

      if (isWall and y > 4) or (not isPit and y > 7) then
        tileId = TILE_ID_GROUND
      end

      table.insert(tilemap.tiles[y],
        Tiles(x, y, tileId, ((isWall and y == 5) or (not isWall and not isPit and y == 8)) and topper or nil, tileset,
          topperset))
    end
  end


  return GameLevel({
    entities = entities,
    objects = objects,
    tilemap = tilemap,
  })
end

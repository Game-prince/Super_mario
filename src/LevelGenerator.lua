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

  -- creating jump boxes
  for x = 1, width do
    -- probability of instantiating a jump box
    local createBox = math.random(20) == 1 and true or false

    -- if createbox is false skip to the next iteration
    if createBox == false or tilemap.tiles[8][x].id == TILE_ID_EMPTY then
      goto continue
    end

    -- number of boxes to render
    local boxcount = math.random(5)
    for y = 1, boxcount do
      if x + y - 1 <= width and tilemap.tiles[8][math.min(x + y - 1, width)].id == TILE_ID_EMPTY then
        goto continue
      end

      table.insert(objects,
        GameObject({
          x = (x - 1 + y) * TILE_SIZE,
          y = tilemap.tiles[5][x + y - 1].id == TILE_ID_GROUND and 3 * TILE_SIZE or 10 * TILE_SIZE,
          width = TILE_SIZE,
          height = TILE_SIZE,
          texture = 'jump-blocks',
          frame = math.random(#gFrames['jump-blocks']),
          collidable = true,
          consumable = false,
          solid = true,
          onConsume = function(player, object)
            player.score = player.score + 100
          end
        }))
    end

    x = x + boxcount
    ::continue::
  end


  return GameLevel({
    entities = entities,
    objects = objects,
    tilemap = tilemap,
  })
end

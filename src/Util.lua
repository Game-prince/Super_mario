function GetTileTops(atlas)
  local tileTops = {}

  for i = 1, 18 do
    for j = 1, 6 do
      tileTops[#tileTops + 1] = love.graphics.newQuad((j - 1) * 80, (i - 1) * 64, 80, 64, atlas:getDimensions())
    end
  end
end

function GenerateQuads(atlas, width, height)
  local quads = {}
  local atlasWidth = atlas:getWidth()
  local altasHeight = atlas:getHeight()

  local sizeX = atlasWidth / width
  local sizeY = altasHeight / height

  for i = 0, sizeY - 1 do
    for j = 0, sizeX - 1 do
      quads[#quads + 1] = love.graphics.newQuad(j * width, i * height, width, height, atlasWidth, altasHeight)
    end
  end
end

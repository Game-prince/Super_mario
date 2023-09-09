function GetBackgrounds(atlas)
  local backgrounds = {}

  for i = 1, 3 do
    backgrounds[i] = love.graphics.newQuad(0, (i - 1) * 128, 256, 128, atlas:getDimensions())
  end

  return backgrounds
end

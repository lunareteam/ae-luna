--[[The visual novel story]]--
-- Makes itself an object --
local reader = {}

function reader.initialize(nof)
  scene = nof

  reader.scriptStr = {}
  for line in love.filesystem.lines("game/text_txt/script.txt") do
    table.insert(reader.scriptStr, line)
  end
end

function reader.nextScene()
  scene=scene+1
  print("scene: " .. scene)
end

return reader

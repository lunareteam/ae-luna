--[[The visual novel story]]--
-- Makes itself an object --
local reader = {}

-- Initializer function
function reader.initialize(nof)
  scene = nof

  -- Reads script and inserts into table --
  reader.scriptStr = {}
  for line in love.filesystem.lines("game/text_txt/script.txt") do
    table.insert(reader.scriptStr, line)
  end
end

-- Goes to next scene --
function reader.nextScene()
  scene=scene+1
  pressed=1
end

-- Returns itself --
return reader

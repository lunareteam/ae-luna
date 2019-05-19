--[[The visual novel story]]--
-- Makes itself an object --
local reader = {}

-- Initializer function
function reader.initialize(fileName)
  file = fileName
  scene = 1
  
  -- Parse file --
  reader.parser()
end

-- Parser --
function reader.parser(option)
  -- Reads script and inserts into table --
  reader.scriptImg = {}
  for line in love.filesystem.lines("game/text_txt/script".. file ..".txt") do
    table.insert(reader.scriptImg, line)
  end

  -- Parses file --
  reader.scriptNames = {}
  reader.scriptText = {}
  for i=1, #reader.scriptImg do
    pos = string.find(reader.scriptImg[i], ":", 1, true)
    if not(pos == nil) then
      table.insert(reader.scriptNames, string.sub(reader.scriptImg[i], 1, pos-1) )
      reader.scriptImg[i] = string.sub(reader.scriptImg[i], pos+1)
    end
    pos = string.find(reader.scriptImg[i], ":", 1, true)
    if not(pos == nil) then
      table.insert(reader.scriptText, string.sub(reader.scriptImg[i], 1, pos-1) )
      reader.scriptImg[i] = string.sub(reader.scriptImg[i], pos+1)
    end
  end
end

-- Goes to next scene --
function reader.nextScene()
  scene=scene+1
  pressed=1
end

-- Returns itself --
return reader

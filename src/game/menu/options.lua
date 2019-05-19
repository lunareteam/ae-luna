--[[Main options from menu]]--
-- Makes itself an object --
local options = {}

-- Initializer function --
function options.initialize(loaderObj, screenObj, inputObj)
  -- Loads called objects --
  loader = loaderObj
  screen = screenObj
  input = inputObj

  -- Parser function --
  parser("start")
end

-- Fullscreen toggle --
function toggleFullscreen()
  screen.toggleFullscreen()
end

-- Parser called via loadstring --
function parser(option)
  options.parser(option)
end

-- Parser --
function options.parser(option)
  -- Reads options and inserts into table --
  options.optTable = {}
  for line in love.filesystem.lines("game/menu/" .. option .. ".txt") do
    table.insert(options.optTable, line)
  end

  -- Parses file --
  options.optNames = {}
  options.optActions = {}
  for i=1, #options.optTable do
    pos = string.find(options.optTable[i], ":", 1, true)
    table.insert(options.optNames, string.sub(options.optTable[i], 1, pos-1) )
    table.insert(options.optActions, string.sub(options.optTable[i], pos+1) )
  end

  -- Resets size --
  options.selected = 1
  options.min = 1
  options.max = #options.optTable
end

-- options draw function --
function options.draw()
  -- Prints current option --
  love.graphics.print(options.optNames[options.selected], 800/2-string.len(options.optNames[options.selected])*7, 600/2/2*3-50, 0, 2)
end

-- options update function --
function love.keyreleased(k)
  if k==  'return' then
    released=1
  end
end
function options.update()
  if released<=0.5 then
    released=released+0.5
  end
  -- Loads action --
  currentAction = loadstring(options.optActions[options.selected])

  -- Does action on button --
  if input.getKey("return") and released ==1 then
    currentAction()

  end

  -- Move menu left --
  if input.getKey("left")  then
    released=1
    if options.selected == options.min then
      options.selected = options.max
    else
      options.selected = options.selected-1
    end
  end

  -- Move menu right --
  if input.getKey("right") then
    released=1
    if options.selected == options.max then
      options.selected = options.min
    else
      options.selected = options.selected+1
    end
  end
end

-- Returns itself
return options

--[[Main screen object]]--
-- Makes itself an object --
local screen = {}

-- Initialization function --
function screen.initialize(loaderObj, inputObj)
  -- Loads called objects --
  loader = loaderObj
  input = inputObj
  x=0

  screen.getDimensions()

  screen.fullscreen = false
end

-- Drawing function --
function screen.draw()
  love.graphics.scale(screen.width/800, screen.height/600)
  -- Draws simple overlay --
  love.graphics.rectangle("line", 0, 0, 800, 600)
end

-- Fullscreen toggler --
function screen.toggleFullscreen()
  if screen.isFullscreen() then
    screen.fullscreen = false
    love.window.setMode(800,600, {fullscreen = screen.fullscreen})
  else
    screen.fullscreen = true
    love.window.setMode(1280, 720, {fullscreen = screen.fullscreen})
  end
end

-- Returns state --
function screen.isFullscreen()
  return screen.fullscreen
end

-- Dimension updating function --
function screen.getDimensions()
  screen.width, screen.height = love.graphics.getDimensions()
end

-- Update function --
function screen.update()
  -- Get pixel height/width --
  screen.getDimensions()
  -- Set title for each screen --
  love.window.setTitle(loader.game)

  if not (loader.game == "menu") then
    -- Goes back to menu --
    if input.getKey("escape") or x==1 then
      audio.stopBGM()
      loader.changeGame("menu")
    end
  end
end

return screen

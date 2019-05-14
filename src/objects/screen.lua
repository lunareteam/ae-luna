--[[Main screen object]]--
-- Makes itself an object --
local screen = {}

-- Initialization function --
function screen.initialize(loaderObj)
  loader = loaderObj
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
  screen.getDimensions()
  love.window.setTitle(loader.game)
end

return screen

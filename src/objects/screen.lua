--[[Main screen object]]--
-- Makes itself an object --
local screen = {}

-- Initialization function --
function screen.initialize(loaderObj)
  loader = loaderObj
  screen.getDimensions()
end

-- Drawing function --
function screen.draw()
  -- Draws simple overlay --
  love.graphics.rectangle("line", 0, 0, 800, 600)
end

-- Dimension updating function --
function screen.getDimensions()
  screen.width, screen.height = love.graphics.getDimensions()
end

-- Update function --
function screen.update()
  love.graphics.scale(screen.width, screen.height)
  screen.getDimensions()
  love.window.setTitle(loader.game)
end

return screen

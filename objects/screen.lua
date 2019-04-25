local screen = {}
local loader = require("games.loader")
local menu = require("games.menu")

function screen.initialize()
  screen.setDefaultMode()
  -- Set window title --
  love.window.setTitle("Magnavox")
  -- Screen size --
  screen.width, screen.height = love.graphics.getDimensions()
  -- Screen mode --
  screen.fullscreen = false
  -- Game loaded --
  screen.game = nil
end

function screen.setDefaultMode()
  -- Set default size --
  love.window.setMode(640, 480)
end

function screen.setFullscreen(mode)
  if screen.isFullscreen() then
    love.window.setFullscreen(mode)
    screen.setDefaultMode()
  else
    love.window.setFullscreen(mode)
  end
end

function screen.isGame()
  if screen.game == nil then
    return false
  end
  return true
end

function screen.isFullscreen()
  if screen.fullscreen == true then
    return true
  end
  return false
end

function screen.draw()
  if screen.isGame() then
    loader.draw()
  else
    menu.draw()
  end
end

function screen.update()
  -- Variables that receive constant change --
  screen.width = love.graphics.getWidth()
  screen.height = love.graphics.getHeight()
end

return screen

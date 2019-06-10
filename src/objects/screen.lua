--[[Main screen object]]--
-- Makes itself an object --
local screen = {}

local anim8 = require 'anim8'
local image = {}
local animation = {}

-- Initialization function --
function screen.initialize(loaderObj, inputObj)
  -- Loads called objects --
  loader = loaderObj
  input = inputObj

  screen.timer=0

  screen.getDimensions()

  screen.fullscreen = false
  loop = {0,0,0,0,0,0,0,0,0,0,0}
end

function screen.parseAnimation(string, imgX, imgY, nof)
  image[nof] = love.graphics.newImage(string)
  local g = anim8.newGrid(imgX, imgY, image[nof]:getWidth(), image[nof]:getHeight())
  animation[nof] = anim8.newAnimation(g('1-'..math.floor(image[nof]:getWidth()/imgX),1), 0.1)
end

function screen.getLoop(nof)
  return loop[nof]
end

function screen.drawAnimation(nof, posx, posy)
  animation[nof]:draw(image[nof], posx, posy)
end

  function screen.flip(nof)
  animation[nof]:flipH()
end

-- Drawing function --
function screen.draw()
  -- Draws simple overlay --
  love.graphics.rectangle("line", 0, 0, 800, 600)

  if input.joystickChanged and love.timer.getTime()<screen.timer+1.3 then
    if input.joystick == nil then
      love.graphics.print(input.joystick, 620, 20, 0, 0.3)
    else
      love.graphics.print("Joystick connected", 640, 20, 0, 0.3)
    end
  end

  love.graphics.print("Activate Windows\nGo to Settings to activate Windows", 535, 560, 0, 0.3)
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
function screen.update(dt)
  if not (#animation == nil) then
    for i=1, #animation do
      loop[i] = animation[i]:update(dt)
    end
  end

  -- Get pixel height/width --
  screen.getDimensions()
  -- Set title for each screen --
  love.window.setTitle(loader.game)

  if not (loader.game == "menu") then
    -- Goes back to menu --
    if input.getKey("escape") or input.getGamepadKey("start") then
      audio.stopBGM()
      loader.changeGame("menu")
    end
  end
end

return screen

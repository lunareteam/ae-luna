--[[This file calls the main objects]]--
-- Creates objects --
local loader = {}
local input  = {}
local audio  = {}
local screen = {}

-- Main loader function --
function love.load()
  -- Main objects and initialization --
  screen = require("objects.screen")
  audio  = require("objects.audio")
  input  = require("objects.input")
  loader = require("objects.loader")
  screen.initialize(loader, input)
  audio.initialize(loader)
  input.initialize(loader)
  loader.initialize(screen, audio, input)
  font = love.graphics.newFont("font/pc98.ttf", 50)
  love.graphics.setFont(font)
end

-- Main draw function --
function love.draw()
  love.graphics.scale(screen.width/800, screen.height/600)
  loader.draw()
  screen.draw()
end

-- Main update function --
function love.update(dt)
  screen.update(dt)

  audio.update(dt)
  input.update(dt)
  input.getJoystick()
  loader.update(dt)

end

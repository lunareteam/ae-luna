-- Headers --
local screen = require("objects.screen")
local audio = require("objects.audio")
local input = require("objects.input")

-- Module loader --
function love.load()
  screen.initialize()
  audio.initialize()
end

-- Function to draw objects --
function love.draw()
  screen.draw()
end

-- Function to update engine --
function love.update()
  screen.update()
  input.update(screen)
  audio.update()
end

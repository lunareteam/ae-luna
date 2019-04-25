-- Headers --
local screen = require("objects.screen")
local audio = require("objects.audio")

-- Module loader --
function love.load()
  screen.initialize()
  audio.initialize()
end

-- Love function to draw objects inside --
function love.draw()
  screen.draw()
end

-- Function to update engine --
function love.update()
  screen.update()
  keyboard.update(screen)
end

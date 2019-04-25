-- Headers --
local screen = require("objects.screen")
local audio = require("objects.audio")
local input = require("objects.input")
local loader = require("games.loader")
local game = require("objects.game")

-- Module loader --
function love.load()
  loader.initialize(game)
  screen.initialize(loader, game)
  input.initialize(screen, loader)
  audio.initialize()
end

-- Function to draw objects --
function love.draw()
  screen.draw()
end

-- Function to update engine --
function love.update()
  screen.update()
  input.update()
  audio.update()
  loader.update()
end

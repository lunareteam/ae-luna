-- Headers --
local baston = require("objects.baston")
local ball = require("objects.ball")
local player1 = require("objects.player1")
local player2 = require("objects.player2")

-- Global Variables --
-- Screen variables --
SCREENWIDTH = love.graphics.getWidth()
SCREENHEIGHT = love.graphics.getHeight()
-- Objects --
baston.initialize(SCREENWIDTH, SCREENHEIGHT, player1, player2)
ball.initialize(SCREENWIDTH, SCREENHEIGHT)
player1.initialize()
player2.initialize()
-- Screen mode --
FULLSCREEN = false

-- Module loader --
function love.load()
  -- Song init --
  song = love.audio.newSource("sounds/song.mp3", "stream")
  pop = love.audio.newSource("sounds/pop.ogg", "static")
  love.audio.play(song)
  -- Image init --
  bg = love.graphics.newImage("images/bg.png")
  bgWidth = bg:getWidth()
  bgHeight = bg:getHeight()
end

-- Love function to draw objects inside --
function love.draw()
  love.graphics.draw(bg, (SCREENWIDTH/2)-bgWidth/2, SCREENHEIGHT/2 - bgHeight/2)
  baston.draw(SCREENWIDTH, player1, player2)
  ball.draw()
  player1.draw(SCREENWIDTH)
  player2.draw(SCREENWIDTH)
end

-- Function to update game --
function love.update()
  -- Variables that receive constant change --
  SCREENWIDTH = love.graphics.getWidth()
  SCREENHEIGHT = love.graphics.getHeight()

  -- Button presses --
  -- F11 to go fullscreen --
  if love.keyboard.isDown("f11") then
    love.window.setFullscreen(not FULLSCREEN)
    FULLSCREEN = not FULLSCREEN
  end

  baston.update(SCREENHEIGHT, player1, player2)
  ball.update(SCREENWIDTH, SCREENHEIGHT, baston, player1, player2)
end

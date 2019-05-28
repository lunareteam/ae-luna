local bar = {}

local anim8 = require 'anim8'
local image, animation

-- Initializer --
function bar.initialize(screenObj, playerObj)
  -- Loads called objects --
  screen = screenObj
  player = playerObj
  -- Self Variables --
  -- Baston size (monitor dependant) --
  bar.height = 128
  bar.width = 46
  -- Baston x position --
  bar.pos1 = 0
  bar.pos2 = 0
  -- Player position --
  player.pos1 = (600/2-bar.height/2)
  player.pos2 = (600/2-bar.height/2)

  bar.parseChar("game/pong/char/charbar.png")  
end

-- Function to draw player bars --
function bar.draw()
  -- Makes coordinates for player 1 and draws him --
  bar.pos1 = 35
  animation:draw(image, bar.pos1, player.pos1)

  -- Makes coordinates for player 2 and draws him --
  bar.pos2 = 800 - (35 + bar.width)
  love.graphics.setColor(255,0,0,255)
  love.graphics.rectangle("line", bar.pos2, player.pos2, bar.width, bar.height)
  love.graphics.setColor( 255,255,255,255)
end

function bar.parseChar(string)
  image = love.graphics.newImage(string)
  local g = anim8.newGrid(46, 128, image:getWidth(), image:getHeight())
  animation = anim8.newAnimation(g('1-5',1), 0.1)
end

function love.update(dt)
  animation:update(dt)
end

-- Update function within bar --
function bar.update()

end

return bar

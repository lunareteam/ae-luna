local bar = {}

-- Initializer --
function bar.initialize(screenObj, playerObj)
  -- Loads called objects --
  screen = screenObj
  player = playerObj
  -- Self Variables --
  -- Baston size (monitor dependant) --
  bar.height = 550*0.25
  bar.width = 60
  -- Baston x position --
  bar.pos1 = 0
  bar.pos2 = 0
  -- Player position --
  player.pos1 = (600/2-bar.height/2)
  player.pos2 = (600/2-bar.height/2)
end

-- Function to draw player bars --
function bar.draw()
  -- Makes coordinates for player 1 and draws him --
  bar.pos1 = 35
  love.graphics.rectangle("line", bar.pos1, player.pos1, bar.width, bar.height)

  -- Makes coordinates for player 2 and draws him --
  bar.pos2 = 800 - (35 + bar.width)
  love.graphics.setColor(255,0,0,255)
  love.graphics.rectangle("line", bar.pos2, player.pos2, bar.width, bar.height)
  love.graphics.setColor( 255,255,255,255)
end

-- Update function within bar --
function bar.update()

end

return bar

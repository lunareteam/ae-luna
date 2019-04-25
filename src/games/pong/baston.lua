local baston = {}

-- Initializer --
function baston.initialize(screenObj, playerObj)
  screen = screenObj
  player = playerObj
  -- Self Variables --
  -- Baston size (monitor dependant) --
  baston.height = screen.height*0.35
  baston.width = screen.width*0.05
  -- Baston x position --
  baston.pos1 = 0
  baston.pos2 = 0 
  -- Player position --
  player.pos1 = (screen.height/2-baston.height/2)
  player.pos2 = (screen.height/2-baston.height/2)
end

-- Function to draw player bastons --
function baston.draw()
  -- Makes coordinates for player 1 and draws him --
  baston.pos1 = 35
  love.graphics.rectangle("line", baston.pos1, player.pos1, baston.width, baston.height)

  -- Makes coordinates for player 2 and draws him --
  baston.pos2 = screen.width - (35 + baston.width)
  love.graphics.rectangle("line", baston.pos2, player.pos2, baston.width, baston.height)
end

-- Update function within baston --
function baston.update()

end

return baston

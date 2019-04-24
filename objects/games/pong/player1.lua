local player1 = {}

-- Initializer --
function player1.initialize()
  player1.score = 0
end

-- Function to draw score --
function player1.draw(windowWidth)
  love.graphics.printf("Score: ", (windowWidth/2)/2, 30, windowWidth*0.15)
  love.graphics.printf(player1.score, (windowWidth/2)/2+40, 30, windowWidth*0.15)
end

return player1

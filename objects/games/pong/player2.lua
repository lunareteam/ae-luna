local player2 = {}

-- Initializer --
function player2.initialize()
  player2.score = 0
end

-- Function to draw score --
function player2.draw(windowWidth)
  love.graphics.print("Score: ", (windowWidth/2)+(windowWidth/2)/2, 30)
  love.graphics.print(player2.score, (windowWidth/2)+((windowWidth/2)/2)+40, 30)
end

return player2

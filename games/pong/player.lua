local player = {}

-- Initializer --
function player.initialize()
  player.score[2] = {0,0}
end

-- Function to draw score --
function player.draw(windowWidth)
  love.graphics.printf("Score: ", (windowWidth/2)/2, 30, windowWidth*0.15)
  love.graphics.printf(player.score[0], (windowWidth/2)/2+40, 30, windowWidth*0.15)
  love.graphics.print("Score: ", (windowWidth/2)+(windowWidth/2)/2, 30)
  love.graphics.print(player.score[1], (windowWidth/2)+((windowWidth/2)/2)+40, 30)
end

return player1

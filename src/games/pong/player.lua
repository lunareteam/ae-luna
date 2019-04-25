local player = {}

-- Initializer --
function player.initialize()
  player.score[2] = {0,0}
end

-- Function to draw score --
function player.draw(screen)
  love.graphics.printf("Score: ", (screen.width/2)/2, 30, screen.width*0.15)
  love.graphics.printf(player.score[0], (screen.width/2)/2+40, 30, screen.width*0.15)
  love.graphics.print("Score: ", (screen.width/2)+(screen.width/2)/2, 30)
  love.graphics.print(player.score[1], (screen.width/2)+((screen.width/2)/2)+40, 30)
end

return player1

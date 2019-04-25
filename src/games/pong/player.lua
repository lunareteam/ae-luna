local player = {}

-- Initializer --
function player.initialize(screenObj, bastonObj)
  screen = screenObj
  baston = bastonObj
  player.score1 = 0
  player.score2 = 0
  player.pos1 = nil
  player.pos2 = nil
end

-- Function to draw score --
function player.draw()
  love.graphics.printf("Score: ", (screen.width/2)/2, 30, screen.width*0.15)
  love.graphics.printf(player.score1, (screen.width/2)/2+40, 30, screen.width*0.15)
  love.graphics.print("Score: ", (screen.width/2)+(screen.width/2)/2, 30)
  love.graphics.print(player.score2, (screen.width/2)+((screen.width/2)/2)+40, 30)
end

function player.update()
  -- q to go up as player 1 --
  if love.keyboard.isDown("q") then
    -- This condition makes the baston not pass the border limits --
    if player.pos1-10 >= 0 then
      player.pos1 = player.pos1 - 5
    end
  end
  -- a to down up as player 1 --
  if love.keyboard.isDown("a") then
    -- This condition makes the baston not pass the border limits --
    if player.pos1+baston.height+10 <= screen.height then
      player.pos1 = player.pos1 + 5
    end
  end
  -- o to go up as player 2 --
  if love.keyboard.isDown("o") then
    -- This condition makes the baston not pass the border limits --
    if player.pos2-10 >= 0 then
      player.pos2 = player.pos2 - 5
    end
  end
  -- l to go down as player 2 --
  if love.keyboard.isDown("l") then
    -- This condition makes the baston not pass the border limits --
    if player.pos2+baston.height+10 <= screen.height then
      player.pos2 = player.pos2 + 5
    end
  end
end

return player

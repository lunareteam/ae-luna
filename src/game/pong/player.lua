local player = {}

-- Initializer --
function player.initialize(screenObj, barObj)
  screen = screenObj
  bar = barObj
  player.score1 = 0
  player.score2 = 0
  player.pos1 = nil
  player.pos2 = nil
end

-- Function to draw score --
function player.draw()
  love.graphics.print("Score: ", (800/2)/2-65, 30, 0, 2)
  love.graphics.print(player.score1, (800/2)/2+15, 30, 0, 2)
  love.graphics.print("Score: ", (800/2)+(800/2)/2-65, 30, 0, 2)
  love.graphics.print(player.score2, (800/2)+((800/2)/2)+15, 30, 0, 2)
end

function player.update()
  -- q to go up as player 1 --
  if love.keyboard.isDown("q") then
    -- This condition makes the bar not pass the border limits --
    if player.pos1-10 >= 0 then
      player.pos1 = player.pos1 - 5
    end
  end
  -- a to down up as player 1 --
  if love.keyboard.isDown("a") then
    -- This condition makes the bar not pass the border limits --
    if player.pos1+bar.height+10 <= 600 then
      player.pos1 = player.pos1 + 5
    end
  end
  -- o to go up as player 2 --
  if love.keyboard.isDown("o") then
    -- This condition makes the bar not pass the border limits --
    if player.pos2-10 >= 0 then
      player.pos2 = player.pos2 - 5
    end
  end
  -- l to go down as player 2 --
  if love.keyboard.isDown("l") then
    -- This condition makes the bar not pass the border limits --
    if player.pos2+bar.height+10 <= 600 then
      player.pos2 = player.pos2 + 5
    end
  end
end

return player

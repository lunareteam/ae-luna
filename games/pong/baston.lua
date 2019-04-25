local baston = {}

-- Initializer --
function baston.initialize(windowWidth, windowHeight, player1, player2)
  -- Self Variables --
  -- Baston size (monitor dependant) --
  baston.height = windowHeight*0.35
  baston.width = windowWidth*0.05
  -- Baston x position --
  baston.pos1 = 0
  baston.pos2 = 0
  -- Player position --
  player1.pos = (windowHeight/2-baston.height/2)
  player2.pos = (windowHeight/2-baston.height/2)
end

-- Function to draw player bastons --
function baston.draw(windowWidth, player1, player2)
  -- Makes coordinates for player 1 and draws him --
  baston.pos1 = 35
  love.graphics.rectangle("line", baston.pos1, player1.pos, baston.width, baston.height)

  -- Makes coordinates for player 2 and draws him --
  baston.pos2 = windowWidth - (35 + baston.width)
  love.graphics.rectangle("line", baston.pos2, player2.pos, baston.width, baston.height)
end

-- Update function within baston --
function baston.update(windowHeight, player1, player2)
  -- q to go up as player 1 --
  if love.keyboard.isDown("q") then
    -- This condition makes the baston not pass the border limits --
    if player1.pos-10 >= 0 then
      player1.pos = player1.pos - 5
    end
  end
  -- a to down up as player 1 --
  if love.keyboard.isDown("a") then
    -- This condition makes the baston not pass the border limits --
    if player1.pos+baston.height+10 <= windowHeight then
      player1.pos = player1.pos + 5
    end
  end
  -- o to go up as player 2 --
  if love.keyboard.isDown("o") then
    -- This condition makes the baston not pass the border limits --
    if player2.pos-10 >= 0 then
      player2.pos = player2.pos - 5
    end
  end
  -- l to go down as player 2 --
  if love.keyboard.isDown("l") then
    -- This condition makes the baston not pass the border limits --
    if player2.pos+baston.height+10 <= windowHeight then
      player2.pos = player2.pos + 5
    end
  end
end

return baston

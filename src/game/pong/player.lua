local player = {}

-- Initializer --
function player.initialize(screenObj, barObj, ballObj)
  screen = screenObj
  bar = barObj
  ball = ballObj

  player.score1 = 0
  player.score2 = 0
  player.pos1 = nil
  player.pos2 = nil
  player.direction=1
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
  if love.keyboard.isDown("w") and not(ball.posy-ball.size<=0 and ball.posx-ball.size/2>=bar.width+bar.pos1) then
    -- This condition makes the bar not pass the border limits --
    if player.pos1-10 >= 0 then
      player.pos1 = player.pos1 - 10
    end
  end
  -- a to down up as player 1 --
  if love.keyboard.isDown("s")then
    -- This condition makes the bar not pass the border limits --
    if player.pos1+bar.height+10 <= 600   then
      player.pos1 = player.pos1 + 10
    end
  end
  -- o to go up as player 2 --
  if player.direction==1 then
    -- This condition makes the bar not pass the border limits --
    if player.pos2-10 >= 0 + ball.size/2 then
      player.pos2 = player.pos2 - 10

    end

  end
  -- l to go down as player 2 --
  if player.direction==0  then
    -- This condition makes the bar not pass the border limits --
    if player.pos2+bar.height+10 <= 600- ball.size/2 then
      player.pos2 = player.pos2 + 10

    end
  end
  --player2 """"a.i."""" --
  if ball.posx>400  then
    if ball.posy<player.pos2+ball.size then
      player.direction=1
    elseif ball.posy>player.pos2 then
      player.direction=0
    end
  end

  ---------------

end

return player

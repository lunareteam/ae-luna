--[[Player inside game]]--
-- Makes itself an object --
local player = {}

-- Initializer --
function player.initialize(screenObj, barObj, ballObj)
  screen = screenObj
  bar = barObj
  ball = ballObj

  -- Score vars --
  player.score1 = 0
  player.score2 = 0

  -- Player pos --
  player.pos1 = nil
  player.pos2 = nil
  player.direction1=0
  player.direction2=0
  player.delay=0
  chao=200

end

-- Function to draw score --
function player.draw()
  love.graphics.print(player.score1, (800/2)/2-30, 30, 0, 0.4)
  love.graphics.print("braço", (800/2)/2-10, 30, 0, 0.4)
  love.graphics.print(player.score2, (800/2)+(800/2)/2-30, 30, 0, 0.4)
  love.graphics.print("braço", (800/2)+((800/2)/2)-10, 30, 0, 0.4)
  
  love.graphics.rectangle("fill", 0, 600-chao, 800, chao)
end

function player.update()
  ---delay
  player.delay=player.delay+1
  if player.delay>11 then
    player.delay=0
  end
  deltat=( (bar.pos2-ball.posx)/(ball.velx*(math.cos(ball.ang))))-5
  --[[Player movement]]--

  -- q to go up as player 1 --

    -- This condition makes the bar not pass the border limits --

    if love.keyboard.isDown("w") and player.pos1>=600-bar.height-ball.size/2-chao then
        player.direction1=1
    elseif (deltat>0 and not love.keyboard.isDown("w")) or player.pos1 <= ball.size/2 then
        player.direction1=0
    end




  -- Player 2 "A.I." --
  if player.direction2==1 then
    -- This condition makes the bar not pass the border limits --
    if player.pos2-10 >= 0 then
      player.pos2 = player.pos2 - 10
    end

  -- l to go down as player 2 --
  else --player.direction2==0  then
    -- This condition makes the bar not pass the border limits --
    if player.pos2+bar.height+10 <= 600-chao then
      player.pos2 = player.pos2 + 10
    end
  end

  if player.direction1==1 then
    -- This condition makes the bar not pass the border limits --
    if player.pos1-10 >= 0 then
      player.pos1 = player.pos1 - 10
    end

  -- l to go down as player 2 --
  else --player.direction2==0  then
    -- This condition makes the bar not pass the border limits --
    if player.pos1+bar.height+10 <= 600-chao then
      player.pos1 = player.pos1 + 10
    end
  end

  if ball.posx>300 and player.delay==1  then
    if deltat<0 then
      player.direction2=0
    elseif ball.posy+math.sin(ball.ang)*ball.vely*deltat<player.pos2+bar.height/2-10*deltat then
       player.direction2=1
    elseif player.pos2<ball.size/2  then-- ball.posy-math.abs(ball.vely)>player.pos2+bar.height*0.6 then
      player.direction2=0
    end
  end
  if love.keyboard.isDown("r")then
    -- This condition makes the bar not pass the border limits --
    player.score1=0
    player.score2=0
  end
end


return player

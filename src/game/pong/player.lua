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
  floor=160

  changed = true
end

-- Function to draw score --
function player.draw()

  if player.score1==2 then
    love.graphics.print("braço", (800/2)/2-10, 30, 0, 0.4)
    love.graphics.print(player.score1, (800/2)/2-30, 30, 0, 0.4)
  else
    love.graphics.print("score", (800/2)/2-10-30, 30, 0, 0.4)
    love.graphics.print(player.score1, (800/2)/2+50-30, 30, 0, 0.4)
  end
 
  if player.score2==2 then
    love.graphics.print("braço", 20+(800/2)+((800/2)/2)-10, 30, 0, 0.4)
    love.graphics.print(player.score2, 20+(800/2)+(800/2)/2-30, 30, 0, 0.4)
  else
    love.graphics.print("score", (800/2)+((800/2)/2)-10, 30, 0, 0.4)
    love.graphics.print(player.score2,(800/2)+((800/2)/2)+50, 30, 0, 0.4)
  end
  
  love.graphics.rectangle("fill", 0, 600-floor, 800, floor)
end

function player.update()
  ---delay
  player.delay=player.delay+1
  if player.delay>9 then
    player.delay=0
  end
  player.deltat=( (bar.pos2-ball.posx)/(ball.velx*(math.cos(ball.ang))))-5
  --[[Player movement]]--

  -- w to go up as player 1 --

    -- This condition makes the bar not pass the border limits --

    if love.keyboard.isDown("w") and player.pos1>=600-bar.height-ball.size/2-floor then
        player.direction1=1
    elseif ((player.deltat>0 and (ball.posx<=ball.size/2+bar.pos1+bar.width+5)) or player.pos1 <= ball.size/2 )or(not love.keyboard.isDown("w") )then
        player.direction1=0
        
    end

    if player.pos1==306 then
      if changed then
        changed = false
        screen.parseAnimation("game/pong/char/charbar.png", 46, 128, 1)
      end
    else
      if not changed then
        changed = true
        screen.parseAnimation("game/pong/char/charjump.png", 46, 128, 1)
      end
    end

  -- Player 2 "A.I." --
  if player.direction2==1 then
    -- This condition makes the bar not pass the border limits --
    if player.pos2-10 >= 0 then
      player.pos2 = player.pos2 - 10
    end

  -- l to go down as player 2 --
  else 
    -- This condition makes the bar not pass the border limits --
    if player.pos2+bar.height+10 <= 600-floor then
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
    if player.pos1+bar.height+10 <= 600-floor then
      player.pos1 = player.pos1 + 10
    end
  end

  if ball.posx>300 and player.delay==1  then
    if player.deltat<0 then
      player.direction2=0
    elseif ball.posy+math.sin(ball.ang)*ball.vely*player.deltat<player.pos2+bar.height/2-10*player.deltat then
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

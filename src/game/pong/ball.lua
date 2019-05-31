--[[Pong ball object]]--
-- Makes itself an object --
local ball = {}

-- Initializer --
function ball.initialize(screenObj, barObj, playerObj, audioObj)
  -- Loads called objects --
  screen = screenObj
  bar = barObj
  player = playerObj

  -- Ball Position --

  ball.size = 32

  ball.constVel = 1.001
  pi= 3.14159265359
  ball.angles={pi,pi,pi,pi}
  ball.setStart()
  shieldv=0
  shieldw=10
  shieldh=10
  shieldx=bar.pos1+bar.width+1
  shieldt=0

  screen.parseAnimation("game/pong/sprites/ball.png", 42, 32, 2)
  hitted = 2
end

-- Function to draw ball --
function ball.draw()
  if (( (bar.pos2-ball.posx)/(ball.velx*(math.cos(ball.ang))))-5)<0 then
    love.graphics.setColor(255,0,0,255)
    if hitted == 1 then
      hitted = 2
      screen.flip(2)
    end
  else
    love.graphics.setColor( 255,255,255,255)
    if hitted == 2 then
      hitted = 1
      screen.flip(2)
    end
  end
  screen.drawAnimation(2, ball.posx-ball.size/2, ball.posy-ball.size/2)
  love.graphics.setColor( 255,255,255,255)
  if shieldv==1 then
    love.graphics.rectangle("fill", shieldx,ball.posy-shieldh/2, shieldw, shieldh)
  end
end

function ball.setStart()
  -- Resets ball position --
  ball.posx = 800/2-10
  ball.posy = 600/2-10
  -- Ball direction and speed --
  ball.velx = -6
  ball.vely = 6
  ball.ang=ball.angles[math.random(1,4)]
end

function ball.angleMaker(pos)
  angle=ball.posy-pos
  ball.vely=math.abs(ball.vely)
  if angle<=bar.height/5 then
    ball.ang=-pi/8

  elseif angle<=2*bar.height/5 then
    ball.ang=-pi/16

  elseif angle<=3*bar.height/5 then
    ball.ang=0.2*math.random(-1,1)

  elseif angle<=4*bar.height/5 then
    ball.ang=pi/16 

  elseif angle<=5*bar.height/5 then
    ball.ang=pi/8

  end
 
  if ball.posx>400 or (ball.velx<0 and pos==player.pos1) then
    ball.velx=-ball.velx
  end

  return ball.ang

end

function ball.update()
  if shieldv==1 and shieldt<3 then
    shieldt=shieldt+1
  else
    shieldv=0
    shieldt=0

  end
  if  ball.posx<=bar.pos1+bar.width+20+ball.size/2 then
    shieldh=10
    shieldw=10
    shieldx=bar.pos1+bar.width+3
  end
  if ball.vely<=30 and ball.vely>=-30 then
    ball.velx=ball.velx*ball.constVel
    ball.vely=ball.vely*ball.constVel
  end

  -- Ball movement --
--
  ball.posx = ball.posx + math.cos(ball.ang)*ball.velx
  ball.posy = ball.posy + math.sin(ball.ang)*ball.vely
  -- Makes the ball go back when hit --
  if ((ball.posx+ball.velx*math.cos(ball.ang)-ball.size <= bar.pos1+bar.width) and
     ((ball.posy<=player.pos1+bar.height+ball.size) and (ball.posy>=player.pos1-ball.size)))
  or ((ball.posx+ball.velx*math.cos(ball.ang) >= bar.pos2-ball.size) and
     ((ball.posy<=player.pos2+bar.height+ball.size) and (ball.posy>=player.pos2-ball.size))) then
    -- Collision sound --
    audio.playSFX("game/pong/sfx/pop.ogg")
      -------NEW COLISION----------
       --------HORIZONTAL-----------
    if ball.posx<bar.pos1+bar.width+30 then-------bar1----------------------
      -------------------------y test---------------------
      if ball.posy+math.sin(ball.ang)*ball.vely<=player.pos1+bar.height+ball.size and ball.posy+math.sin(ball.ang)*ball.vely>=player.pos1-ball.size then
        pos=player.pos1
        ball.angleMaker(pos)
        ball.posx=ball.posx+1
        shieldv=1
      end
    else  ----------------------bar2----------------------
      -------------------------y test---------------------
      if ball.posy+math.sin(ball.ang)*ball.vely<=player.pos2+bar.height+ball.size and ball.posy+math.sin(ball.ang)*ball.vely>=player.pos2-ball.size then
        pos=player.pos2
        ball.angleMaker(pos)
        ball.posx=ball.posx-1


      end
    end
  end

  --[[Vertical Collision]]--
  -- Borders

  if ball.posy>=600-ball.size -floor then
    ball.vely=-ball.vely
    ball.posy=600-ball.size/2 - 1-floor
    
  elseif ball.posy<=ball.size/2 then
    ball.vely=-ball.vely
    ball.posy=ball.size + 1
    --bar vertical Collision1--
  elseif ball.posy>=player.pos1-ball.size and ball.posy<=player.pos1 and ball.posx<=bar.pos1+bar.width-1 then
    ball.posy=player.pos1-ball.size-10

    ball.vely=-ball.vely
    ball.velx=-ball.velx
    shieldx=bar.pos1+bar.width+3
  elseif ball.posy<=player.pos1+bar.height+ball.size/2 and ball.posy>=player.pos1+bar.height and  ball.posx<=1+bar.pos1+bar.width-1 then
    ball.posy=player.pos1+bar.height+ball.size/2+10
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    shieldx=bar.pos1+bar.width+3
   --bar2 vertical Collision--
  elseif ball.posy>=player.pos2-ball.size and ball.posy<=player.pos2 and ball.posx>=bar.pos2 then
    ball.posy=player.pos2-ball.size-10
    ball.vely=-ball.vely
    ball.velx=-ball.velx
  elseif ball.posy<=player.pos2+bar.height+ball.size and ball.posy>=player.pos2+bar.height and ball.posx>=bar.pos2 then
    ball.posy=player.pos2+bar.height+ball.size+10
    ball.vely=-ball.vely
    ball.velx=-ball.velx
  end


  -- Player 1 loss --
  if ball.posx<=ball.size then
    ball.setStart()
    -- Score + 1 --
    player.score2 = player.score2 + 1
    if not (player.score2 == 5) then
      audio.playSFX("game/pong/sfx/itai.ogg")
    end
  end

  -- Player 2 loss --
  if ball.posx>=800-ball.size then
    ball.setStart()
    -- Score + 1 --
    player.score1 = player.score1 + 1
  end
end

return ball


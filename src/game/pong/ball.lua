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
  ball.size = (800+600)/2*0.05
  ball.constVel = 1.001

  ball.angles={ 60,40,340,340}
  ball.ang=ball.angles[math.random(1,4)]
  ball.setStart()
end

-- Function to draw ball --
function ball.draw()
  love.graphics.circle("line", ball.posx, ball.posy, ball.size/2)
end

function ball.setStart()
  -- Resets ball position --
  ball.posx = 800/2-10
  ball.posy = 600/2-10
  -- Ball direction and speed --
  ball.velx = 6
  ball.vely = 6
  -- Random symbol --
  for i=0,love.math.random(1, 5) do
    ball.velx = -ball.velx
    ball.vely = -ball.vely
  end

  ball.ang=ball.angles[math.random(1,4)]
end

function ball.update()

  if ball.vely<=30 and ball.vely>=-30 then
  ball.velx=ball.velx*ball.constVel
  ball.vely=ball.vely*ball.constVel
end


  -- Ball movement --
  ball.posx = ball.posx + math.cos(ball.ang)*ball.velx
  ball.posy = ball.posy + math.sin(ball.ang)*ball.vely

  -- Makes the ball go back when hit --
  if ((ball.posx+ball.velx <= bar.pos1+bar.width+ball.size/2) and
     ((ball.posy<=player.pos1+bar.height) and (ball.posy>=player.pos1)))
  or ((ball.posx+ball.velx >= bar.pos2-ball.size/2) and
     ((ball.posy<=player.pos2+bar.height) and (ball.posy>=player.pos2))) then
    -- Collision sound --
    audio.playSFX("game/pong/sfx/pop.ogg")



  end


  --[[Vertical Collision]]--
  -- Borders
  --
  if ball.posy>=600-ball.size/2 then
    ball.vely=-ball.vely
    ball.posy=600-ball.size/2 - 1
  elseif ball.posy<=ball.size/2 then
    ball.vely=-ball.vely
    ball.posy=ball.size/2 + 1
  -- Bar 1 horizontal collision --
  elseif ball.posy<=player.pos1+bar.height and ball.posy>=player.pos1 and ball.posx<=bar.pos1+bar.width+ball.size/2 and ball.posx>=bar.pos1+bar.width then
    ball.velx=-ball.velx
    ball.posx=bar.pos1+bar.width+ball.size/2+1
  elseif ball.posy<=player.pos1+bar.height and ball.posy>=player.pos1 and ball.posx>=bar.pos1-ball.size/2 and ball.posx<=bar.pos1 then
    ball.velx=-ball.velx
    ball.posx=bar.pos1-ball.size/2
  -- Bar 1 vertical collision --
  elseif ball.posy>=player.pos1-ball.size/2 and ball.posy<=player.pos1 and ball.posx>=bar.pos1-1 and ball.posx<=bar.pos1+bar.width+1 then
    ball.posy=player.pos1-ball.size/2-1
    ball.vely=-ball.vely
  elseif ball.posy<=player.pos1+bar.height+ball.size/2 and ball.posy>=player.pos1+bar.height and ball.posx>=bar.pos1-1 and  ball.posx<=1+bar.pos1+bar.width then
    ball.posy=player.pos1+bar.height+ball.size/2+1
    ball.vely=-ball.vely
  -- Bar 1 edge collision --
  elseif (bar.pos1+bar.width-ball.posx)^2+(player.pos1-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx+5
    ball.posy=ball.posy-5
  elseif ((bar.pos1+bar.width)-ball.posx)^2+(player.pos1+bar.height-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx+5
    ball.posy=ball.posy+5
  elseif ((bar.pos1)-ball.posx)^2+(player.pos1+bar.height-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx-5
    ball.posy=ball.posy+5
  elseif ((bar.pos1)-ball.posx)^2+(player.pos1-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.posy=ball.posy-5
  --[[The same, but for bar 2-bar]]--
  -- Bar2 horizontal collision --
  elseif ball.posy<=player.pos2+bar.height and ball.posy>=player.pos2 and ball.posx<=bar.pos2+bar.width+ball.size/2 and ball.posx>=bar.pos2+bar.width then
    ball.velx=-ball.velx
    ball.posx=bar.pos2+bar.width+ball.size/2+2
  elseif ball.posy<=player.pos2+bar.height and ball.posy>=player.pos2 and ball.posx>=bar.pos2-ball.size/2 and ball.posx<=bar.pos2 then
    ball.velx=-ball.velx
    ball.posx=bar.pos2-ball.size/2
  --bar2 vertical Collision--
  elseif ball.posy>=player.pos2-ball.size/2 and ball.posy<=player.pos2 and ball.posx>=bar.pos2 and ball.posx<=bar.pos2+bar.width then
    ball.posy=player.pos2-ball.size/2
    ball.vely=-ball.vely
  elseif ball.posy<=player.pos2+bar.height+ball.size/2 and ball.posy>=player.pos2+bar.height and ball.posx>=bar.pos2 and  ball.posx<=bar.pos2+bar.width then
    ball.posy=player.pos2+bar.height+ball.size/2
    ball.vely=-ball.vely
  --bar2 edge Collision--
  elseif (bar.pos2+bar.width-ball.posx)^2+(player.pos2-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx+5
    ball.posy=ball.posy-5
  elseif ((bar.pos2+bar.width)-ball.posx)^2+(player.pos2+bar.height-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx+5
    ball.posy=ball.posy+5
  elseif ((bar.pos2)-ball.posx)^2+(player.pos2+bar.height-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx-5
    ball.posy=ball.posy+5
  elseif ((bar.pos2)-ball.posx)^2+(player.pos2-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx-5
    ball.posy=ball.posy-5
  end


  -- Player 1 loss --
  if ball.posx<=ball.size/2 then
    ball.setStart()
    -- Score + 1 --
    player.score2 = player.score2 + 1
  end

  -- Player 2 loss --
  if ball.posx>=800-ball.size/2 then
    ball.setStart()
    -- Score + 1 --
    player.score1 = player.score1 + 1
  end

end

return ball

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

function ball.angleMaker(pos)
  pos=math.abs(bar.height/2-math.abs(ball.posx-pos))
  pos=math.floor(45/pos)
  return pos

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

  if ball.posy>=600-ball.size/2 then
    ball.vely=-ball.vely
    ball.posy=600-ball.size/2 - 1
  elseif ball.posy<=ball.size/2 then
    ball.vely=-ball.vely
    ball.posy=ball.size/2 + 1
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


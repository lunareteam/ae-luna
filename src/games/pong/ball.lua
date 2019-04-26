local ball = {}

function ball.initialize(screenObj, bastonObj, playerObj)
  screen = screenObj
  baston = bastonObj
  player = playerObj
  -- Ball Position --
  ball.size = (screen.width+screen.height)/2*0.05
  ball.constVel = 1.001
  ball.setStart()
end

-- Function to draw ball --
function ball.draw()
  love.graphics.circle("line", ball.posx, ball.posy, ball.size/2)
end

function ball.setStart()
  -- Resets ball position --
  ball.posx = screen.width/2-10
  ball.posy = screen.height/2-10
  -- Ball direction and speed --
  ball.velx = 3
  ball.vely = 3
  -- Random symbol --
  for i=0,love.math.random(1, 10) do
    ball.velx = -ball.velx
    ball.vely = -ball.vely
  end
end

function ball.update()
  ball.velx=ball.velx*ball.constVel
  ball.vely=ball.vely*ball.constVel
  -- Ball movement --
  ball.posx = ball.posx + ball.velx
  ball.posy = ball.posy + ball.vely

  -- Makes the ball go back when hit --
  if ((ball.posx+ball.velx <= baston.pos1+baston.width+ball.size/2) and
     ((ball.posy<=player.pos1+baston.height) and (ball.posy>=player.pos1)))
  or ((ball.posx+ball.velx >= baston.pos2-ball.size/2) and
     ((ball.posy<=player.pos2+baston.height) and (ball.posy>=player.pos2))) then

    -- Collision sound --
    --love.audio.play(pop)

    ball.velx=ball.velx*ball.constVel
    ball.vely=ball.vely*ball.constVel
    -- Inverts velocity --
    ball.velx = -ball.velx
    ball.vely = -ball.vely
  end

  -- Reverts ball when it touches the extremities
  if(ball.posy+ball.velx-ball.size/2<=10 or (ball.posy+ball.velx+ball.size/2)>screen.height-10) then
    ball.velx=ball.velx*ball.constVel
    ball.vely=ball.vely*ball.constVel
    ball.vely = -ball.vely
  end

  -- Player 1 loss --
  if ball.posx<=0 then
    ball.setStart()
    -- Score + 1 --
    player.score2 = player.score2 + 1
  end

  -- Player 2 loss --
  if ball.posx>=screen.width then
    ball.setStart()
    -- Score + 1 --
    player.score1 = player.score1 + 1
  end
end

return ball

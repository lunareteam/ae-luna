local ball = {}

function ball.initialize(screenObj, bastonObj, playerObj)
  screen = screenObj
  baston = bastonObj
  player = playerObj
  -- Ball Position --
  ball.posx = screen.width/2-10
  ball.posy = screen.height/2-10
  ball.size = (screen.width+screen.height)/2*0.05
  -- Ball direction and speed --
  ball.velx = 10
  ball.vely = 10
  -- Random symbol --
  for i=0,love.math.random(1, 10),1 do
    ball.velx = -ball.velx
    ball.vely = -ball.vely
  end
end

-- Function to draw ball --
function ball.draw()
  love.graphics.circle("line", ball.posx, ball.posy, ball.size/2)
  love.graphics.print(ball.size, 100, 100)
end

function ball.update()

  -- Ball movement --
  ball.posx = ball.posx + ball.velx
  ball.posy = ball.posy + ball.vely

  -- Makes the ball go back when hit --
  if ((ball.posx <= baston.pos1+baston.width) and
     ((ball.posy<=player.pos1+baston.height) and (ball.posy>=player.pos1)))
  or ((ball.posx >= baston.pos2) and
     ((ball.posy<=player.pos2+baston.height) and (ball.posy>=player.pos2))) then

    -- Collision sound --
    love.audio.play(pop)

    -- Inverts velocity --
    ball.velx = -ball.velx
    ball.vely = -ball.vely
  end

  -- Reverts ball when it touches the extremities
  if(ball.posy<=10 or (ball.posy-ball.size*2)>screen.width) then
    ball.vely = -ball.vely
  end

  -- Player 1 loss --
  if ball.posx<=0 then
    -- Resets ball position --
    ball.posx = screen.width/2-10
    ball.posy = screen.height/2-10

    -- Ball direction and speed --
    ball.velx = 10
    ball.vely = 10
    -- Random symbol --
    for i=0,love.math.random(1, 10),1 do
      ball.velx = -ball.velx
      ball.vely = -ball.vely
    end

    -- Score + 1 --
    player.score2 = player.score2 + 1
  end

  -- Player 2 loss --
  if ball.posx>=screen.width then
    -- Resets ball position --
    ball.posx = screen.width/2-10
    ball.posy = screen.height/2-10

    -- Resets ball direction and speed --
    ball.velx = love.math.random(-10, 10)
    ball.vely = love.math.random(-10, 10)

    -- Score + 1 --
    player.score1 = player.score1 + 1
  end
end

return ball

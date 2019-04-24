local ball = {}

function ball.initialize(windowWidth, windowHeight)
  -- Ball Position --
  ball.posx = windowWidth/2-10
  ball.posy = windowHeight/2-10
  ball.size = (windowWidth+windowHeight)/2*0.05
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
  love.graphics.circle("fill", ball.posx, ball.posy, ball.size/2)
  love.graphics.print(ball.size, 100, 100)
end

function ball.update(windowWidth, windowHeight, baston, player1, player2)

  -- Ball movement --
  ball.posx = ball.posx + ball.velx
  ball.posy = ball.posy + ball.vely

  -- Makes the ball go back when hit --
  if ((ball.posx <= baston.pos1+baston.width) and
     ((ball.posy<=player1.pos+baston.height) and (ball.posy>=player1.pos)))
  or ((ball.posx >= baston.pos2) and
     ((ball.posy<=player2.pos+baston.height) and (ball.posy>=player2.pos))) then

    -- Collision sound --
    love.audio.play(pop)

    -- Inverts velocity --
    ball.velx = -ball.velx
    ball.vely = -ball.vely
  end

  -- Reverts ball when it touches the extremities
  if(ball.posy<=10 or (ball.posy-ball.size*2)>windowWidth) then
    ball.vely = -ball.vely
  end

  -- Player 1 loss --
  if ball.posx<=0 then
    -- Resets ball position --
    ball.posx = windowWidth/2-10
    ball.posy = windowHeight/2-10

    -- Ball direction and speed --
    ball.velx = 10
    ball.vely = 10
    -- Random symbol --
    for i=0,love.math.random(1, 10),1 do
      ball.velx = -ball.velx
      ball.vely = -ball.vely
    end

    -- Score + 1 --
    player2.score = player2.score + 1
  end

  -- Player 2 loss --
  if ball.posx>=windowWidth then
    -- Resets ball position --
    ball.posx = windowWidth/2-10
    ball.posy = windowHeight/2-10

    -- Resets ball direction and speed --
    ball.velx = love.math.random(-10, 10)
    ball.vely = love.math.random(-10, 10)

    -- Score + 1 --
    player1.score = player1.score + 1
  end
end

return ball

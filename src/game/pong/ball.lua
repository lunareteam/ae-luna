local ball = {}

function ball.initialize(screenObj, barObj, playerObj)
  screen = screenObj
  bar = barObj
  player = playerObj
  -- Ball Position --
  ball.size = (800+600)/2*0.05
  ball.constVel = 1.001
  ball.angles={0, 30, 60, 120, 150, 180, 210, 240, 300, 330}
  ball.ang=ball.angles[math.random(1,10)]
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
  ball.posx = ball.posx + math.cos(ball.ang)*ball.velx
  ball.posy = ball.posy + math.sin(ball.ang)*ball.vely

  --[[-- Makes the ball go back when hit --
  if ((ball.posx+ball.velx <= bar.pos1+bar.width+ball.size/2) and
     ((ball.posy<=player.pos1+bar.height) and (ball.posy>=player.pos1)))
  or ((ball.posx+ball.velx >= bar.pos2-ball.size/2) and
     ((ball.posy<=player.pos2+bar.height) and (ball.posy>=player.pos2))) then

    -- Collision sound --
    --love.audio.play(pop)

    ball.velx=ball.velx*ball.constVel
    ball.vely=ball.vely*ball.constVel
    -- Inverts velocity --
    ball.velx = -ball.velx
    ball.vely = -ball.vely
  end

  -- Reverts ball when it touches the extremities
  if(ball.posy+ball.velx-ball.size/2<=10 or (ball.posy+ball.velx+ball.size/2)>600-10) then
    ball.velx=ball.velx*ball.constVel
    ball.vely=ball.vely*ball.constVel
    ball.vely = -ball.vely
  end]]--
--vertical Collision--
--wall--
  if ball.posy>=600-ball.size/2 then
    ball.vely=-ball.vely
    ball.posy=600-ball.size/2 -1
  elseif ball.posy<=ball.size/2 then
    ball.vely=-ball.vely
    ball.posy=ball.size/2 +1

--bar horizontal Collision1--
  elseif ball.posy<=player.pos1+bar.height and ball.posy>=player.pos1 and ball.posx<=bar.pos1+bar.width+ball.size/2 and ball.posx>=bar.pos1+bar.width then
    ball.velx=-ball.velx
    ball.posx=bar.pos1+bar.width+ball.size/2+1
  elseif ball.posy<=player.pos1+bar.height and ball.posy>=player.pos1 and ball.posx>=bar.pos1-ball.size/2 and ball.posx<=bar.pos1 then
    ball.velx=-ball.velx
    ball.posx=bar.pos1-ball.size/2
--bar vertical Collision1--
  elseif ball.posy<=player.pos1-ball.size/2 and ball.posy>=player.pos1 and ball.posx>=bar.posx and ball.posx<=bar.posx+bar.width then
    ball.posy=player.pos1-ball.size/2
    ball.vely=-ball.vely
  elseif ball.posy<=player.pos1+bar.height+ball.size/2 and ball.posy>=player.pos1+bar.height and ball.posx>=bar.pos1 and  ball.posx<=bar.pos1+bar.width then
    ball.posy=player.pos1+bar.height+ball.size/2
    ball.vely=-ball.vely
--bar edge Collision1--
  elseif (bar.pos1+bar.width-ball.posx)^2+(player.pos1-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx+2
    ball.poyx=ball.posy-2
  elseif ((bar.pos1+bar.width)-ball.posx)^2+(player.pos1+bar.height-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx+2
    ball.poyx=ball.posy+2
  elseif ((bar.pos1)-ball.posx)^2+(player.pos1+bar.height-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx-2
    ball.poyx=ball.posy+2
  elseif ((bar.pos1)-ball.posx)^2+(player.pos1-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx-2
    ball.poyx=ball.posy-2
-------the same, but for bar 2-bar------
--bar2 horizontal Collision--
  elseif ball.posy<=player.pos2+bar.height and ball.posy>=player.pos2 and ball.posx<=bar.pos2+bar.width+ball.size/2 and ball.posx>=bar.pos2+bar.width then
    ball.velx=-ball.velx
    ball.posx=bar.pos2+bar.width+ball.size/2+2
  elseif ball.posy<=player.pos2+bar.height and ball.posy>=player.pos2 and ball.posx>=bar.pos2-ball.size/2 and ball.posx<=bar.pos2 then
    ball.velx=-ball.velx
    ball.posx=bar.pos2-ball.size/2
--bar2 vertical Collision--
  elseif ball.posy<=player.pos2-ball.size/2 and ball.posy>=player.pos2 and ball.posx>=bar.posx and ball.posx<=bar.posx+bar.width then
    ball.posy=player.pos2-ball.size/2
    ball.vely=-ball.vely
  elseif ball.posy<=player.pos2+bar.height+ball.size/2 and ball.posy>=player.pos2+bar.height and ball.posx>=bar.pos2 and  ball.posx<=bar.pos2+bar.width then
    ball.posy=player.pos2+bar.height+ball.size/2
    ball.vely=-ball.vely
--bar2 edge Collision--
  elseif (bar.pos2+bar.width-ball.posx)^2+(player.pos2-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx+2
    ball.poyx=ball.posy-2
  elseif ((bar.pos2+bar.width)-ball.posx)^2+(player.pos2+bar.height-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx+2
    ball.poyx=ball.posy+2
  elseif ((bar.pos2)-ball.posx)^2+(player.pos2+bar.height-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx-2
    ball.poyx=ball.posy+2
  elseif ((bar.pos2)-ball.posx)^2+(player.pos2-ball.posy)^2<=(ball.size/2)^2 then
    ball.vely=-ball.vely
    ball.velx=-ball.velx
    ball.posx=ball.posx-2
    ball.poyx=ball.posy-2

end
  -- Player 1 loss --
  if ball.posx<=0 then
    ball.setStart()
    -- Score + 1 --
    player.score2 = player.score2 + 1
  end

  -- Player 2 loss --
  if ball.posx>=800 then
    ball.setStart()
    -- Score + 1 --
    player.score1 = player.score1 + 1
  end
end

return ball

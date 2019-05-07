local ball= {}
local name = require "game.pong.bar"
function ball.initialize()
  ball.x=400
  ball.y=300
  mod.vx=1
  mod.vy=1
  ball.vx=mod.vx
  ball.vy=mod.vy
  ball.r=10

end
function ball.update()
  ball.x=ball.x+ball.vx
  ball.y=ball.y+ball.vy
end
function ball.draw()
  love.graphics.circle("fill", ball.x, ball.y, ball.r, 30)
end
function ball.coords()
  ---vertical colision---
  if ball.y>=600-ball.r or ball.y<=0+ball.r then
    mod.y=-mod.y
    if ball.y>600 then
      ball.y=600-ball.r
    else
      ball.y=ball.r
  end

end

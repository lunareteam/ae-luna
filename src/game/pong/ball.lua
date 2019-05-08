--[[Ball object]]--
-- Makes itself an object --
local ball= {}

-- Calls objects --
local bar = require("game.pong.bar")

-- Initializer function --
function ball.initialize(barObj)
  bar = barObj

  ball.x=400
  ball.y=300
  mod.vx=1
  mod.vy=1
  ball.vx=mod.vx
  ball.vy=mod.vy
  ball.r=10
end

-- Update function --
function ball.update()
  ball.x=ball.x+ball.vx
  ball.y=ball.y+ball.vy
end

-- Drawer function --
function ball.draw()
  love.graphics.circle("fill", ball.x, ball.y, ball.r, 30)
end

-- Cordenates function --
function ball.coords()
  -- Vertical collision --
  if ball.y>=600-ball.r or ball.y<=0+ball.r then
    mod.y=-mod.y
    if ball.y>600 then
      ball.y=600-ball.r
    else
      ball.y=ball.r
  end
end

return ball

local ball= {}
function ball.initialize()
  ball.x=400
  ball.y=300
  ball.vx=1
  ball.vy=1

end
function ball.update()
  ball.x=ball.x+ball.vx
  ball.y=ball.y+ball.vy
end
function ball.draw()
  love.graphics.circle("fill", ball.x, ball.y, 10, 30)
end

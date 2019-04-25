-- Makes the method --
local init = {}

-- Calls --
local baston = receive("baston")
local ball = receive("ball")
local player = receive("player")

-- Initializer --
function init.initialize(screenObject)
  screen = screenObject

  baston.initialize(screen.width, screen.height, player)
  ball.initialize(screen.width, screen.height)
  player.initialize()
end

-- Drawer --
function init.draw()
  love.graphics.draw(bg, (screen.width/2)-bg.width/2, screen.height/2 - bg.height/2)
  baston.draw(screen.width, player)
  ball.draw()
  player.draw(screen.width)
end

function init.update()
  if love.keyboard.isDown("escape") then
    loader.changeGame("menu")
  end
  baston.update(screen.height, player)
  ball.update(screen.width, screen.height, baston, player)
end

return init

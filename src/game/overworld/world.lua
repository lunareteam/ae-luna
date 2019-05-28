local world = {}

-- Initializer --
function world.initialize(screenObj,playerObj)
  screen = screenObj
  player = playerObj

  -- world pos --
  world.posx=0
  world.width=160
end
  
-- Function to draw score --
function world.draw()    
  love.graphics.rectangle("fill", 0, 600-floor, 800, floor)
  love.graphics.rectangle("line",800-world.posx,600-floor-10,10,10)
end
  
function world.update()
  if love.keyboard.isDown("d") and world.posx<1600-player.vely-player.width then
    world.posx=world.posx+player.vely
  elseif love.keyboard.isDown("a") and world.posx>player.vely then
    world.posx=world.posx-player.vely
  end
end

return world
  
local world = {}

-- Initializer --
function world.initialize(screenObj,playerObj)
  screen = screenObj
  player = playerObj

  -- world pos --
  world.posx=0
  world.width=160

  world.walking = false
end
  
-- Function to draw score --
function world.draw()    
  love.graphics.rectangle("fill", 0, 600-floor, 800, floor)
  love.graphics.rectangle("line",800-world.posx,600-floor-10,10,10)
end
  
function world.update()
  world.walking = false

  if love.keyboard.isDown("d") and world.posx<1600-player.vely-player.width then
    world.posx=world.posx+player.vely
    if changed then
      changed = false
      screen.parseAnimation("game/overworld/sprites/andandor.png", 46, 126, 2)
      screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
    end
    world.walking = true
  elseif love.keyboard.isDown("a") and world.posx>player.vely then
    world.posx=world.posx-player.vely
    if not changed then
      changed = true
      screen.parseAnimation("game/overworld/sprites/andandol.png", 46, 126, 2)
      screen.parseAnimation("game/overworld/sprites/stillL.png", 46, 126, 1)
    end
    world.walking = true
  end
end

return world
  
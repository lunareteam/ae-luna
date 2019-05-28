local warudo = {}
-- Initializer --
function warudo.initialize(screenObj,playerObj)
    screen = screenObj
    player = playerObj
  
  
    -- warudo pos --
    warudo.posx=0

    warudo.width=160
  
  end
  
  -- Function to draw score --
  function warudo.draw()
  
    
    love.graphics.rectangle("fill", 0, 600-floor, 800, floor)
    love.graphics.rectangle("line",800-warudo.posx,600-floor-10,10,10)
    
  end
  
  function warudo.update()

    if love.keyboard.isDown("d") and warudo.posx<1600-player.vely-player.width then
      warudo.posx=warudo.posx+player.vely
    elseif love.keyboard.isDown("a") and warudo.posx>player.vely then
      warudo.posx=warudo.posx-player.vely
    end


  end

  
  return warudo
  
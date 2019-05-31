local world = {}

-- Initializer --
function world.initialize(screenObj,playerObj)
  screen = screenObj
  player = playerObj

  -- world pos --
  world.posx=0
  world.width=160

  world.walking = false
  floorImg = love.graphics.newImage("game/sprites/floor.png")
  houseImg = love.graphics.newImage("game/overworld/sprites/house.png")
  treeImg = love.graphics.newImage("game/sprites/tree.png")
  sunImg = love.graphics.newImage("game/sprites/sun.png")
  cloudImg = love.graphics.newImage("game/sprites/cloud.png")
  screen.parseAnimation("game/overworld/sprites/well.png", 160, 200, 4)
  screen.parseAnimation("game/overworld/sprites/gansozzz.png", 46, 128, 5)
  screen.parseAnimation("game/sprites/cloud.png", 512, 512, 6)
  screen.parseAnimation("game/sprites/sun.png", 96, 96, 7)
  scaleHouse = 1
  place = 160

  set = false
  time = 0
  pressed = false
end
  
-- Function to draw score --
function world.draw()
  -- Blue sky --
  love.graphics.setColor( 0,255,230,255)
  love.graphics.rectangle("fill", 0, 0, 800, 600)

  -- Normal colors --
  love.graphics.setColor( 255,255,255,255)

  screen.drawAnimation(7, 600-world.posx*0.2, 5)
  screen.drawAnimation(6, 650-world.posx*0.3, -160)
  for i=0, 20 do
    love.graphics.draw(treeImg, i*100-world.posx, 600-floor-260)
  end
  love.graphics.draw(houseImg,800-world.posx,600-floor-(houseImg:getHeight()*scaleHouse)+(scaleHouse*90), 0, scaleHouse)
  screen.drawAnimation(4,800-world.posx+650,600-floor-200)
  screen.drawAnimation(5,800-world.posx+400,600-floor-128)

  for i=0, 14 do
    love.graphics.draw(floorImg, place*i-world.posx, 600-floor, 0, 0.38)
  end
end
  
function world.update()
  world.walking = false

  if input.getKey("return") then
    if not pressed then
      screen.parseAnimation("game/overworld/sprites/gansoawaking.png", 46, 128, 5)
      pressed = true
    end
  end

  --print(screen.getLoop(5))
  if screen.getLoop(5) == 1 and pressed then
    loader.changeGame("pong")
  end

  if love.keyboard.isDown("d") and world.posx<1600-player.vely-player.width then
    world.posx=world.posx+player.vely
    if changed then
      changed = false
      screen.parseAnimation("game/overworld/sprites/andandor.png", 46, 126, 2)
      screen.parseAnimation("game/overworld/sprites/stillR.png", 46, 126, 1)
      screen.parseAnimation("game/overworld/sprites/charjumpr.png", 46, 128, 3)
    end
    world.walking = true
  elseif love.keyboard.isDown("a") and world.posx>player.vely then
    world.posx=world.posx-player.vely
    if not changed then
      changed = true
      screen.parseAnimation("game/overworld/sprites/andandol.png", 46, 126, 2)
      screen.parseAnimation("game/overworld/sprites/stillL.png", 46, 126, 1)
      screen.parseAnimation("game/overworld/sprites/charjumpl.png", 46, 128, 3)
    end
    world.walking = true
  end
end

return world
  
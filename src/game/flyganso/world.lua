local world = {}

-- Initializer --
function world.initialize(screenObj,playerObj,gooseObj)
  screen = screenObj
  player = playerObj
  goose = gooseObj
  player.z=0
  -- world pos --

  world.posx=0
  jogo=1
  world.width=90
  world.walking = false
  floorImg = love.graphics.newImage("game/sprites/floor.png")
  houseImg = love.graphics.newImage("game/overworld/sprites/house.png")
  treeImg = love.graphics.newImage("game/sprites/tree1.png")
  sunImg = love.graphics.newImage("game/sprites/sun.png")
  cloudImg = love.graphics.newImage("game/sprites/cloud.png")
  screen.parseAnimation("game/overworld/sprites/well.png", 80, 200, 4)

  screen.parseAnimation("game/sprites/cloud.png", 512, 512, 6)
  screen.parseAnimation("game/sprites/sun.png", 96, 96, 7)
  scaleHouse = 1
  screen.parseAnimation("game/flyganso/sprites/gansodestr.png", 46, 128, 5)
  place = 160
  player.score2=5
  set = false
  time = 0
  floorImg = love.graphics.newImage("game/sprites/floor.png")

end
  
-- Function to draw score --
function world.draw()
 -- screen.drawAnimation(8, 0, 0)
  -- Blue sky --
  love.graphics.setColor( 0,255,230,255)
  love.graphics.rectangle("fill", 0, 0, 800, 600)

  -- Normal colors --
  
  love.graphics.setColor( 255,255,255,255)
  love.graphics.setColor( 255,255,255,255)
  
  screen.drawAnimation(6, 400, 5+(player.z*0.1))
  screen.drawAnimation(4, 350, -160+(player.z*0.2))



  if  player.z<450 then
    for i=0, 5 do
      love.graphics.draw(treeImg, i*100, 600-160-260+player.z)
    end
    for i=0, 6 do
      love.graphics.draw(floorImg, place*i, 600-160+player.z, 0, 0.38)
    end
  end
  screen.drawAnimation(5, goose.posx,goose.posy)
  if  goose.died==false then

    if (screen.getLoop(5))==1 then
      goose.died=true
      screen.parseAnimation("game/flyganso/sprites/gansoflyup.png", 70, 70, 5)

    end
  --  print((screen.getLoop(5)),goose.died)
   
 
  else

  end

end
  
function world.update()
  
  if goose.died==true then
    if floor>0 then
      floor=floor-1
    end
    if  player.z<450 then
      player.z=player.z+1
    end
    
  end
    world.walking = false
    if input.getKey("return") and 800-world.posx+400 < player.posx+150+46 and 800-world.posx+400 > player.posx-150 then
      if not pressed then
        screen.parseAnimation("game/overworld/sprites/gansoawaking.png", 46, 128, 5)
        audio.playSFX("game/overworld/sfx/quak.ogg")
        pressed = true

      end
      jogo=0
    end
  if screen.getLoop(5) == 1 and pressed and jogo==0 then
      loader.changeGame("pong")
      closer=1
  end
  if jogo==1 then
    --print(screen.getLoop(5))


    if love.keyboard.isDown("d") and world.posx<400-46 and world.posx<800-player.vely-player.width then
      world.posx=world.posx+player.vely
      if changed then
        changed = false
        screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 126, 2)
        screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 126, 1)
        screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 128, 3)
      end
      world.walking = true
    elseif love.keyboard.isDown("a") and world.posx>player.vely then
      world.posx=world.posx-player.vely
      if not changed then
        changed = true
        screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 126, 2)
        screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 126, 1)
        screen.parseAnimation("game/flyganso/sprites/charjumpr.png", 46, 128, 3)
      end
      world.walking = true
    end
  end
end

return world
  
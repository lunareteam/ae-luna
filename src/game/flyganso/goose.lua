local goose = {}
local bullet = {}
-- Initializer --

function goose.initialize(screenObj,playerObj,worldObj)  
    screen.parseAnimation("game/flyganso/sprites/pena.png", 32,20, 10)
    goose.vely=2
    goose.velx=6
    goose.ang=1.5
    screen = screenObj
    player = playerObj
    world = worldObj
    pow=false

    goose.action=0
    goose.died=false
    goose.posx=800 - (35 + 46)
    goose.posy=600-160-128

    goose.height=70
    goose.width=70
    bullets = {}
    for i=1,5,1 do
        bullets[i]={x=nil,y=nil}
    end

  end

  -- Function to draw score --
function goose.draw()
    for i=1,5,1 do
        if bullets[i].x ~= nil and bullets[i].y~=nil then
            screen.drawAnimation(10, bullets[i].x, bullets[i].y)
        end
    end
    if goose.died==true then
        if goose.action==0 then
            if goose.posy>100 then
            goose.posy=goose.posy-goose.vely
            end
        elseif goose.action==1 then
            if goose.posy < 500 then
                goose.posy=goose.posy+goose.vely
            end
                
        end
        --print(#bulletGoose)
        for i=1, #bulletGoose do
            if bulletGoose[i] ~= nil and bulletGoose[i] ~= 1 then
                bulletGoose[i].draw()
            end
        end
    end
end
  function bulletSpawn()
    for i=1,5,1 do
        bullets[i]={x=goose.posx,y=goose.posy+70}
    end
  end
  function bulletMovement()
    for i=1,5,1 do
        if bullets[i].x~=nil and bullets[i].y~= nil then
            bullets[i].x=bullets[i].x-5
            bullets[i].y=((bullets[i].x*20*(3-i)-14380*(3-i))/80+goose.posy-8)*1.20-math.random(1,30)
        end
    end
  end
  function bulletkill()
    for i=1,5,1 do
        if bullets[i].x~=nil and bullets[i].y~= nil then
            if bullets[i].x<0  or bullets[i].y>600 or  bullets[i].y<0 then
                bullets[i].x=nil
                bullets[i].y=nil
            elseif bullets[i].x<player.posx+player.width and bullets[i].x<player.posx and bullets[i].y>player.posy-player.height and  bullets[i].y<player.posy then
                player.score1=player.score1-1
                bullets[i].x=nil
                bullets[i].y=nil
            end
        end
    end
  end
  

function goose.update()
    --print(goose.posx,goose.posy,goose.ang)
    bulletMovement()
    bulletkill()
    if goose.posy==96 then
        goose.action=1
        bulletSpawn()
    elseif goose.posy==500 then
        goose.action=0

        bulletSpawn()

    elseif goose.posy==100 then
        goose.action=1
        bulletSpawn()
    end
   -- print(goose.posy,goose.action)

    --print(goose.posx,goose.posy,goose.ang)
end

return goose
local goose = {}
local bullets = {}

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
    bulletss=0
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

end
  function bulletspawn()
    for i=1,5,1 do
        bullets[i]={x=goose.posx,y=goose.posy+70}
    end
  end
  function bulletsMovement(z,dt)
    for i=1,5,1 do
        if bullets[i].x~=nil and bullets[i].y~= nil then
            bullets[i].x=bullets[i].x-math.random(5,20)*dt*50
            bullets[i].y=((((bullets[i].x)*20*(3-i)-14380*(3-i))/80+z-8)*1.30)+math.random(1,10)/100        end
    end
  end
  function bulletskill()
    for i=1,5,1 do
        if bullets[i].x~=nil and bullets[i].y~= nil then
            if bullets[i].x<-32  or bullets[i].y>600 or  bullets[i].y<0 then
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
  
function bulletscont(bulletss)
    bulletss=0
    for i=1,5,1 do
   
      if bullets[i].x~=nil or bullets[i].y~= nil then
         bulletss=bulletss+1
          
      end
    end
    return bulletss
end
function goose.update(dt)

    --print(goose.posx,goose.posy,goose.ang)
    if goose.died==true then
        if goose.action==0 then
            if goose.posy>100 then
            goose.posy=math.floor(goose.posy-goose.vely*2*100*dt)
            else 
                goose.posy=101
            end
        elseif goose.action==1 then
            if goose.posy < 500 then
                goose.posy=math.floor(goose.posy+goose.vely*2*100*dt)
            else 
                goose.posy=499
            end
                
        end

    end
    bulletskill()
    if goose.posy<100 then
        goose.action=1
    elseif goose.posy>500 then
        goose.action=0
        if bulletscont(bulletss)==0 then
            bulletspawn()
        end
    elseif goose.posy==100 then
        goose.action=1
    end

    if bulletscont(bulletss)==0 then
        bulletspawn()
        z=goose.posy
    end
    bulletsMovement(z,dt)
   -- print(goose.posy,goose.action)

    --print(goose.posx,goose.posy,goose.ang)
end

return goose
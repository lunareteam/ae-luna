local goose = {}

-- Initializer --
function goose.initialize(screenObj,playerObj,worldObj, objectObj)  
    goose.vely=6
    goose.velx=6
    goose.ang=1.5
    screen = screenObj
    player = playerObj
    world = worldObj
    object = objectObj
    goose.action=0
    goose.died=false
    goose.posx=800 - (35 + 46)
    goose.posy=600-160-128
    goose.width=70
    goose.height=70

    bulletGoose = {1, 1, 1, 1, 1, 1}

    timer = 0
end
  -- Function to draw score --
function goose.draw()
    if goose.died==true then
        if goose.action==0 then
            if goose.posy>100 and goose.posy < 500 then
            goose.posy=math.floor(goose.posy-goose.vely*math.sin(goose.ang)+0.5)
                if goose.posy>400 and goose.posy<700 then
                    goose.posx=math.floor(goose.posx+goose.velx*math.cos(goose.ang)+0.5)
                end
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
  
function goose.update()
    print(#bulletGoose)
    for i=1, #bulletGoose do
        print("goose", i,bulletGoose[i])
        if bulletGoose[i] == nil or bulletGoose[i] == 1 then
            rand = love.math.random(1,10)
            if (rand == 1 or rand == 2 or rand == 3 or rand == 4 or rand == 5 or rand == 6 or rand == 7) and love.timer.getTime() > timer+2 then
                bulletGoose[i] = require("game.flyganso.bullet")
                bulletGoose[i].initialize("goose", goose, player)
                timer = love.timer.getTime()
            end
        else
            bulletGoose[i].update()

            if bulletGoose[i].hit() then
                player.score1 = player.score1-1
            end

            if bulletGoose[i].hit() or bulletGoose[i].outOfBounds() then
                bulletGoose[i] = nil
            end
        end
    end

    --print(goose.posx,goose.posy,goose.ang)
end

return goose
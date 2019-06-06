local goose = {}

-- Initializer --
function goose.initialize(screenObj,playerObj,worldObj)  
    bullets = { }
    table.insert(bullets, {
		x = bullets.x,
		y = bullets.y,
		dir = direction,
		speed = 400
	})
    goose.vely=6
    goose.velx=6
    goose.ang=1.5
    screen = screenObj
    player = playerObj
    world = worldObj
    goose.action=0
    goose.died=false
    goose.posx=800 - (35 + 46)
    goose.posy=600-160-128
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
    end
end
  
function goose.update()
    print(goose.posx,goose.posy,goose.ang)

end

return goose
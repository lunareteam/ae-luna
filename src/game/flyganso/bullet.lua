local bullet = {}

function bullet.initialize(type, charObj, enemyObj)
    char = charObj
    enemy = enemyObj

    if type=="goose" then
        type={dir=-1,speed=1,sprite=love.graphics.newImage("game/flyganso/sprites/goosebullet.png")}
    elseif type=="player" then
        type={dir=1,speed=1,sprite=love.graphics.newImage("game/flyganso/sprites/bread.png")}
    end

    sprite = type.sprite

    if type.dir == 1 then
        bullet.x = char.posx+char.width
        bullet.y = char.posy-char.height/2
    else 
        bullet.x = char.posx
        bullet.y = char.posy
    end
    bullet.width = sprite:getWidth()
    bullet.height = sprite:getHeight()
    bullet.dir = type.dir
    bullet.speed = type.speed
end

function bullet.draw()
    love.graphics.draw(sprite,bullet.x,bullet.y)
end

function bullet.hit()
    if bullet.dir == -1 then
        if bullet.x<=enemy.posx+enemy.width and bullet.x>=enemy.posx and bullet.y>=enemy.posy-enemy.height and bullet.y<=enemy.posy then
            return true
        end
    else
        -- Needs change
        if bullet.x+bullet.width<=enemy.posx+enemy.width and bullet.x+bullet.width>=enemy.posx and bullet.y>=enemy.posy-enemy.height and bullet.y<=enemy.posy then
            return true
        end
    end
    return false
end

function bullet.outOfBounds()
    if bullet.x<=0 or bullet.x-bullet.width>=800 or bullet.y>=600 or bullet.y<=0-bullet.height then
        return true
    end
    return false
end

function bullet.update()
    --print(bullet.x, bullet.speed, bullet.dir)
    bullet.x = bullet.x+bullet.speed*bullet.dir
end

return bullet
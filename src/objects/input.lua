--[[Main input object]]--
-- Makes itself an object --
local input = {}

-- Initializer function --
function input.initialize()
    -- Key press variables --
    press = 0
    input.pressed = false
end

-- Function to get key easier --
function input.getKey(string)
    -- Gets string --
    if love.keyboard.isDown(string) and input.pressed==false then
        -- Return was pressed,so it is unable to be pressed again --
        input.pressed = true
        press = love.timer.getTime()

        return true
    end

    return false
end

-- Reset vars when needed --
function input.reset()
    press = 0
    input.pressed = false
end

-- Update function --
function input.update()
    -- Reset press bool --
    if (love.timer.getTime() >= press+0.3) and input.pressed == true then
        input.reset()
    end
end

-- Returns itself --
return input

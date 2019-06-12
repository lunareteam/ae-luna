--[[Main input object]]--
-- Makes itself an object --
local input = {}

-- Initializer function --
function input.initialize()
    local joysticks = nil

    -- Key press variables --
    press = 0
    input.pressed = false
    input.toggled = false
end

function input.getJoystick()
    joysticks = love.joystick.getJoysticks()

    if joystick ~= joysticks[1] then
        joystick = joysticks[1]
        screen.timer = love.timer.getTime()
        input.joystickChanged = true
    end

    if joystick ~= nil then
        return joystick:isConnected()
    else
        return false
    end
end

function input.isGamepadDown(string)
    if input.getJoystick() then
        return joystick:isGamepadDown(string)
    end
end

function input.isDown(string)
    return love.keyboard.isDown(string)
end

-- Toggles keypress --
function input.toggle(string)
    -- Gets string --
    if (input.isDown(string)) and input.pressed==false and input.toggled then
        input.toggled = false
        input.pressed = true
        press = love.timer.getTime()
    elseif (input.isDown(string) and input.pressed==false) or input.toggled then
        -- Return was pressed,so it is unable to be pressed again --
        input.pressed = true
        press = love.timer.getTime()
        input.toggled = true

        return true
    end

    return false
end

function input.toggleGamepad(string)
    -- Gets string --
    if input.toggled then
        return true
    elseif (input.isGamepadDown(string)) and input.pressed==false then
        -- Return was pressed,so it is unable to be pressed again --
        input.pressed = true
        press = love.timer.getTime()
        input.toggled = true

        return true
    end

    return false
end

-- Function to get key easier --
function input.getKey(string)
    -- Gets string --
    if input.isDown(string) and input.pressed==false then
        -- Return was pressed,so it is unable to be pressed again --
        input.pressed = true
        press = love.timer.getTime()

        return true
    end

    return false
end

function input.getGamepadKey(string)
    -- Gets string --
    if input.isGamepadDown(string) and input.pressed==false then
        -- Return was pressed,so it is unable to be pressed again --
        input.pressed = true
        press = love.timer.getTime()

        return true
    end

    return false
end

function input.getAxis(string)
    if input.getJoystick() then
        if joystick:getAxis(string) ~= nil then
            return joystick:getAxis(string)
        end
    end

    return 0
end

function input.getSlowAxis(string, dir)
    if input.getAxis(string)~=nil then
        if dir == 1 then
            if input.getAxis(string)>0 and input.pressed==false then
                -- Return was pressed,so it is unable to be pressed again --
                input.pressed = true
                press = love.timer.getTime()

                return true
            end
        else
            if input.getAxis(string)<0 and input.pressed==false then
                -- Return was pressed,so it is unable to be pressed again --
                input.pressed = true
                press = love.timer.getTime()

                return true
            end
        end
    end

    return false
end

-- Function to get key easier --
function input.getClick()
    -- Gets string --
    if love.mouse.isDown(1) and input.pressed==false then
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
function input.update(dt)
    -- Reset press bool --
    if (love.timer.getTime() >= press+0.3) and input.pressed == true then
        input.reset()
    end
end

-- Returns itself --
return input

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
    if joysticks[1]~=nil then
        print(joysticks[1])
        if input.joystick ~= joysticks[1] and joystick ~= nil then
            screen.timer = love.timer.getTime()
            input.joystickChanged = true
        end
        input.joystick = joysticks[1]
    end

    if input.joystick ~= nil then
        return true
    else
        return false
    end
end

function input.isGamepadDown(string)
    if input.getJoystick() then
        if input.joystick:isGamepadDown(string) then
            return true
        end
    end

    return false
end

function input.isDown(string)
    if love.keyboard.isDown(string) then
        return true
    end

    return false
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
    if (input.getGamepadKey(string)) and input.pressed==false and input.toggled then
        input.toggled = false
        input.pressed = true
        press = love.timer.getTime()
    elseif (input.getGamepadKey(string) and input.pressed==false) or input.toggled then
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
function input.update()
    -- Reset press bool --
    if (love.timer.getTime() >= press+0.3) and input.pressed == true then
        input.reset()
    end
end

-- Returns itself --
return input

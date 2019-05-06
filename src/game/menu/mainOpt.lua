--[[Main options from menu]]--
-- Makes itself an object --
local option = {}

-- Initializer function --
function option.initialize(loaderObj)
  -- Makes the loader an object --
  loader = loaderObj

  -- Constants to know the current selection --
  option.selected = 0
  option.min = 0
  option.max = 3
  press = 0
end

-- Options draw function --
function option.draw()
  -- Prints current option --
  love.graphics.print("<",800/2-100, 600/2/2*3-50, 0, 3)
  love.graphics.print(option.name(), 800/2-50, 600/2/2*3-50, 0, 3)
  love.graphics.print(">", 800/2+100, 600/2/2*3-50, 0, 3)
end

-- Returns name for each option (to be changed to be read from file) --
function option.name()
  if option.selected == 0 then
    return "Start"
  else
    if option.selected == 1 then
      return "Load"
    else
      if option.selected == 2 then
        return "Options"
      else
        if option.selected == 3 then
          return "Quit"
        end
      end
    end
  end
end

-- Options update function --
function option.update()
  if love.keyboard.isDown("return") and option.selected==0 and love.timer.getTime() >= press+0.5 then
    loader.changeGame("text_txt", 1)
    press = love.timer.getTime()
  end

  if love.keyboard.isDown("left") and love.timer.getTime() >= press+0.5 then
    if option.selected == option.min then
      option.selected = option.max
    else
      option.selected = option.selected-1
    end
    press = love.timer.getTime()
  end

  if love.keyboard.isDown("right") and love.timer.getTime() >= press+0.5 then
    if option.selected == option.max then
      option.selected = option.min
    else
      option.selected = option.selected+1
    end
    press = love.timer.getTime()
  end
end

-- Returns itself
return option

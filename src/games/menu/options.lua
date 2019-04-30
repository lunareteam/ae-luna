local option = {}

function option.initialize(loaderObj)
  loader = loaderObj
  option.selected = 0
  option.min = 0
  option.max = 3
end

function option.draw()
  love.graphics.print("<", screen.width/2-55, screen.height/2/2*3-20, 0, 3)
  love.graphics.print(option.name(), screen.width/2-30, screen.height/2/2*3-20, 0, 3)
  love.graphics.print(">", screen.width/2+55, screen.height/2/2*3-20, 0, 3)
end

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

function option.update()
  if love.keyboard.isDown("return") and option.selected == 0 then
    loader.changeGame("pong")
  end

  if love.keyboard.isDown("left") then
    if option.selected == option.min then
      option.selected = option.max
    else
      option.selected = option.selected-1
    end
  end

  if love.keyboard.isDown("right") then
    if option.selected == option.max then
      option.selected = option.min
    else
      option.selected = option.selected+1
    end
  end

end

return option

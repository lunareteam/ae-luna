local input = {}

function input.initialize(screenObj, loaderObj)
  screen = screenObj
  loader = loaderObj
end

function input.update()
  -- Esc ends game --
  if love.keyboard.isDown("f4") then
    love.event.quit(0)
  end

  -- F11 to go fullscreen --
  if love.keyboard.isDown("f11") then
    if screen.isFullscreen() then
      status = false
    else
      status = true
    end
    screen.setFullscreen(status)
    screen.fullscreen = status
  end
end

return input

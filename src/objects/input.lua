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
      screen.fullscreen = false
      love.window.setMode(800,600, {fullscreen = screen.fullscreen})
    else
      screen.fullscreen = true
      love.window.setMode(1280, 720, {fullscreen = screen.fullscreen})
    end
  end
end

return input

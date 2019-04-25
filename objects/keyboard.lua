local keyboard = {}

function keyboard.initialize()

end

function keyboard.update(screen)
  -- F11 to go fullscreen --
  if love.keyboard.isDown("f11") then
    if screen.isFullscreen() then
      status = false
    else
      status = true
    end
    love.window.setFullscreen(status)
    screen.fullscreen = status
  end
end

return keyboard

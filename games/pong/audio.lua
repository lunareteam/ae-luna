local audio = {}

function audio.initialize()
  -- Song init --
  song = love.audio.newSource("sounds/song.ogg", "stream")
  pop = love.audio.newSource("sounds/pop.ogg", "static")
  love.audio.play(song)
end

return audio

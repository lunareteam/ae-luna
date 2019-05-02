local audio = {}

function audio.initialize(loaderObj)
  loader = loaderObj
end

function audio.toggleBGM()
  audio.bgm = love.audio.newSource(name, "stream")
  love.audio.play(audio.bgm)
end

function audio.playSFX(name)
  audio.sfx = love.audio.newSource(name, "static")
  love.audio.play(audio.sfx)
end

function audio.update()
  
end

return audio

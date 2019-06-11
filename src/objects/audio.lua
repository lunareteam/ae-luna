--[[Main audio object]]--
-- Makes itself an object --
local audio = {}

-- Initializer function --
function audio.initialize(loaderObj)
  loader = loaderObj

  audio.volume = 100
  audio.isMute = false
end

-- Starts BGM --
function audio.startBGM(name)
  audio.bgm = love.audio.newSource(name, "stream")
  audio.bgm:setLooping(true)
  audio.bgm:setVolume(audio.volume)
  audio.bgm:play()
end

-- Ends BGM --
function audio.stopBGM()
  audio.bgm:stop()
end

-- Plays sfx when called --
function audio.playSFX(name)
  audio.sfx = love.audio.newSource(name, "static")
  audio.sfx:setVolume(audio.volume)
  audio.sfx:play()
end

function audio.toggleSound()
  if audio.isMute then
    audio.volume = 100
    audio.isMute = false
  else
    audio.volume = 0
    audio.isMute = true
  end
end

-- Main audio update function --
function audio.update(dt)
  if audio.sfx then
    audio.sfx:setVolume(audio.volume)
  end
  if audio.bgm then
    audio.bgm:setVolume(audio.volume)
  end
end

-- Returns itself --
return audio

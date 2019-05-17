--[[Main audio object]]--
-- Makes itself an object --
local audio = {}

-- Initializer function --
function audio.initialize(loaderObj)
  loader = loaderObj
end

-- Starts BGM --
function audio.startBGM(name)
  audio.bgm = love.audio.newSource(name, "stream")
  audio.bgm:setLooping(true)
  audio.bgm:play()
end

-- Ends BGM --
function audio.stopBGM()
  audio.bgm:stop()
end

-- Plays sfx when called --
function audio.playSFX(name)
  audio.sfx = love.audio.newSource(name, "static")
  audio.sfx:play()
end

-- Main audio update function --
function audio.update()

end

-- Returns itself --
return audio

--[[Main audio object]]--
-- Makes itself an object --
local audio = {}

-- Initializer function --
function audio.initialize(loaderObj)
  loader = loaderObj
end

-- Starts BGM --
function audio.startBGM()
  audio.bgm = love.audio.newSource(name, "stream")
  love.audio.play(audio.bgm)
end

-- Ends BGM --
function audio.stopBGM()
  love.audio.stop(audio.bgm)
end

-- Plays sfx when called --
function audio.playSFX(name)
  audio.sfx = love.audio.newSource(name, "static")
  love.audio.play(audio.sfx)
end

-- Main audio update function --
function audio.update()

end

-- Returns itself --
return audio

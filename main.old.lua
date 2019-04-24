-- Global Variables --
-- Screen variables --
SCREENWIDTH = love.graphics.getWidth()
SCREENHEIGHT = love.graphics.getHeight()
-- Baston size (monitor dependant) --
BASTONHEIGHT = SCREENHEIGHT*0.35
BASTONWIDTH = SCREENWIDTH*0.05
-- Screen mode --
FULLSCREEN = false
-- Baston x position --
BASTON1POS = 0
BASTON2POS = 0
-- Player position --
PLAYER1POS = (SCREENHEIGHT/2-BASTONHEIGHT/2)
PLAYER2POS = (SCREENHEIGHT/2-BASTONHEIGHT/2)
-- Ball Position --
BALLX = SCREENWIDTH/2-10
BALLY = SCREENHEIGHT/2-10
-- Ball direction and speed --
VELX = 10
VELY = 10
for i=0,love.math.random(1, 10),1 do
  VELX = -VELX
  VELY = -VELX
end
-- Scores --
SCORE1 = 0
SCORE2 = 0

-- Function to draw player bastons --
function drawBaston()
  -- Makes coordinates for player 1 and draws him --
  BASTON1POS = 35
  love.graphics.rectangle("fill", BASTON2POS, PLAYER1POS, BASTONWIDTH, BASTONHEIGHT)

  -- Makes coordinates for player 2 and draws him --
  BASTON2POS = SCREENWIDTH - (35 + BASTONWIDTH)
  love.graphics.rectangle("fill", BASTON1POS, PLAYER2POS, BASTONWIDTH, BASTONHEIGHT)
end

-- Function to draw ball --
function drawBall()
  love.graphics.circle("fill", BALLX, BALLY, 20)
end

-- Function to draw score --
function drawScore()
  love.graphics.print("Score", (SCREENWIDTH/2)/2, 30)
  love.graphics.print(SCORE1, (SCREENWIDTH/2)/2+30, 30)
  love.graphics.print("Score: ", (SCREENWIDTH/2)/2+(SCREENWIDTH/2)/2, 30)
  love.graphics.print(SCORE2, (SCREENWIDTH/2)+((SCREENWIDTH/2)/2)+30, 30)
end

-- Love function to draw objects inside --
function love.draw()
  drawBaston()
  drawBall()
  drawScore()
end

-- Function to update game --
function love.update()
  -- Variables that receive constant change --
  SCREENWIDTH = love.graphics.getWidth()
  SCREENHEIGHT = love.graphics.getHeight()
  BALLX = BALLX + VELX
  BALLY = BALLY + VELY

  -- Makes the ball go back when hit --
  if ((BALLX-10 <= BASTON1POS+BASTONWIDTH) and ((BALLY-10<=PLAYER1POS+BASTONHEIGHT) and (BALLY-10>=PLAYER1POS)))
  or ((BALLX+10 >= BASTON2POS-BASTONWIDTH) and ((BALLY+10<=PLAYER2POS+BASTONHEIGHT) and (BALLY+10>=PLAYER2POS))) then
    VELX = -VELX
    VELY = -VELY
  end

  -- Reverts ball when it touches the extremities
  if(BALLY<=0 or BALLY+20>=SCREENHEIGHT) then
    VELY = -VELY
  end

  -- Player 1 loss --
  if BALLX<=0 then
    -- Resets ball position --
    BALLX = SCREENWIDTH/2-10
    BALLY = SCREENHEIGHT/2-10

    -- Resets ball direction and speed --
    VELX = love.math.random(-10, 10)
    VELY = love.math.random(-10, 10)

    -- Score + 1 --
    SCORE2 = SCORE2 + 1
  end

  -- Player 2 loss --
  if BALLX>=SCREENWIDTH then
    -- Resets ball position --
    BALLX = SCREENWIDTH/2-10
    BALLY = SCREENHEIGHT/2-10

    -- Resets ball direction and speed --
    VELX = love.math.random(-10, 10)
    VELY = love.math.random(-10, 10)

    -- Score + 1 --
    SCORE1 = SCORE1 + 1
  end

  -- Button presses --
  -- F11 to go fullscreen --
  if love.keyboard.isDown("f11") then
    love.window.setFullscreen(not FULLSCREEN)
    FULLSCREEN = not FULLSCREEN
  end
  -- q to go up as player 1 --
  if love.keyboard.isDown("q") then
    -- This condition makes the baston not pass the border limits --
    if PLAYER1POS-10 >= 0 then
      PLAYER1POS = PLAYER1POS - 5
    end
  end
  -- a to down up as player 1 --
  if love.keyboard.isDown("a") then
    -- This condition makes the baston not pass the border limits --
    if PLAYER1POS+BASTONHEIGHT+10 <= SCREENHEIGHT then
      PLAYER1POS = PLAYER1POS + 5
    end
  end
  -- o to go up as player 2 --
  if love.keyboard.isDown("o") then
    -- This condition makes the baston not pass the border limits --
    if PLAYER2POS-10 >= 0 then
      PLAYER2POS = PLAYER2POS - 5
    end
  end
  -- l to go down as player 2 --
  if love.keyboard.isDown("l") then
    -- This condition makes the baston not pass the border limits --
    if PLAYER2POS+BASTONHEIGHT+10 <= SCREENHEIGHT then
      PLAYER2POS = PLAYER2POS + 5
    end
  end
end

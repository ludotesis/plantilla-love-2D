require "dependencias"

local GAME_WIDTH = 320
local GAME_HEIGHT = 180

local image, animation

function love.load()
    -- Configurar los gráficos para pixel art
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- Inicializar Push
    Push:setupScreen(GAME_WIDTH, GAME_HEIGHT, 1280, 720, {
        fullscreen = false,
        resizable = true,
        pixelperfect = true
    })
    -- Test Anim8
    image = love.graphics.newImage('assets/sprites/oldHero.png')
    local frameWidth = image:getWidth() / 6
    local frameHeight = image:getHeight()
    local grid = Anim.newGrid(frameWidth, frameHeight, image:getWidth(), image:getHeight())
    animation = Anim.newAnimation(grid('1-6', 1), 0.1)
end

function love.resize(w, h)
    Push:resize(w, h)
end

function love.update(dt)
    animation:update(dt)
end

function love.draw()
    Push:start()
    -- Dibujar 
    animation:draw(image, 100, 100)
    Push:finish()
end

function love.keypressed(key)

end
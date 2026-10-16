require "dependencias"

local GAME_WIDTH = 320
local GAME_HEIGHT = 180

function love.load()
    -- Configurar los gráficos para pixel art
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- Inicializar Push
    Push:setupScreen(GAME_WIDTH, GAME_HEIGHT, 1280, 720, {
        fullscreen = false,
        resizable = true,
        pixelperfect = true
    })
end

function love.resize(w, h)
    Push:resize(w, h)
end

function love.update(dt)

end

function love.draw()
    Push:start()
    -- Dibujar 
    Push:finish()
end

function love.resize(w, h)

end

function love.keypressed(key)

end
require "dependencias"

local Jugador = require "src.classes.jugador"

local GAME_WIDTH = 320
local GAME_HEIGHT = 180

local image, animation
local world
local player
local muro

local cam

function love.load()
    -- Configurar los gráficos para pixel art
    love.graphics.setDefaultFilter('nearest', 'nearest')
    -- Inicializar Push
    Push:setupScreen(GAME_WIDTH, GAME_HEIGHT, 1280, 720, {
        fullscreen = false,
        resizable = true,
        pixelperfect = true
    })
    -- 1. Inicializar el mundo de Bump (64 es el tamaño de celda recomendado)
    world = Bump.newWorld(64)
    -- 2. Inicializar jugador
    player = Jugador(50, 50, world)
    -- 3. Crear un obstáculo de prueba (Muro)
    muro = { x = 150, y = 80, w = 40, h = 60 }
    world:add(muro, muro.x, muro.y, muro.w, muro.h)
    -- 4. Inicializar la cámara
    cam = Camera(player.x, player.y)
end

function love.resize(w, h)
    Push:resize(w, h)
end

function love.update(dt)
    -- Actualizar jugador
    player:update(dt)
    -- Actualizar la posición de la cámara para que siga al jugador
    local centroX = player.x + player.w / 2
    local centroY = player.y + player.h / 2
    cam:lookAt(Lume.round(centroX), Lume.round(centroY))
end

function love.draw()
    Push:start()
        -- La cámara que usa la resolución del juego
        cam:attach(0, 0, GAME_WIDTH, GAME_HEIGHT)
            -- Dibujar el muro para que lo veamos (Color Rojo)
            love.graphics.setColor(1, 0, 0)
            love.graphics.rectangle('fill', muro.x, muro.y, muro.w, muro.h)
            love.graphics.setColor(1, 1, 1)
            -- Dibujar jugador
            player:draw()
        cam:detach()
        -- Todo lo que dibujes debajo de cam:detach() se quedará pegado en la pantalla
    Push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
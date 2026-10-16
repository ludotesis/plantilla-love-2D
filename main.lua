require "dependencias"

local GAME_WIDTH = 320
local GAME_HEIGHT = 180

local image, animation
local world
local player
local muro

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
    -- 2. Cargar Anim8 e Imagen
    image = love.graphics.newImage('assets/sprites/oldHero.png')
    local frameWidth = image:getWidth() / 6
    local frameHeight = image:getHeight()
    local grid = Anim.newGrid(frameWidth, frameHeight, image:getWidth(), image:getHeight())
    animation = Anim.newAnimation(grid('1-6', 1), 0.1)
    -- 3. Configurar al Jugador
    player = {
        x = 50,
        y = 50,
        w = frameWidth,
        h = frameHeight,
        speed = 100 -- Píxeles por segundo
    }
    -- Añadir jugador al mundo de Bump
    world:add(player, player.x, player.y, player.w, player.h)
    -- 4. Crear un obstáculo de prueba (Muro)
    muro = { x = 150, y = 80, w = 40, h = 60 }
    -- Añadir muro al mundo de Bump
    world:add(muro, muro.x, muro.y, muro.w, muro.h)
end

function love.resize(w, h)
    Push:resize(w, h)
end

function love.update(dt)
    -- Variables para saber cuánto nos queremos mover
    local dx, dy = 0, 0
    -- Controles
    if love.keyboard.isDown('right') then dx = player.speed * dt end
    if love.keyboard.isDown('left') then dx = -player.speed * dt end
    if love.keyboard.isDown('down') then dy = player.speed * dt end
    if love.keyboard.isDown('up') then dy = -player.speed * dt end
    -- Si el jugador presionó alguna tecla de movimiento
    if dx ~= 0 or dy ~= 0 then
        -- Avanzamos el frame de la animación
        animation:update(dt)
        -- Calculamos a dónde QUEREMOS ir
        local metaX = player.x + dx
        local metaY = player.y + dy
        -- Bump resuelve las colisiones al movernos
        -- actualX y actualY serán nuestra posición final (deteniéndonos si chocamos)
        local actualX, actualY, cols, len = world:move(player, metaX, metaY)
        -- Actualizamos las coordenadas de nuestro jugador con la posición real
        player.x = actualX
        player.y = actualY
    else
        -- Si no se mueve, podemos regresar al frame 1 para que se quede quieto (opcional)
        animation:gotoFrame(1)
    end
end

function love.draw()
    Push:start()
        -- Dibujar el muro para que lo veamos (Color Rojo)
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle('fill', muro.x, muro.y, muro.w, muro.h)
        -- Resetear el color a blanco puro (vital para no teñir la imagen del sprite de rojo)
        love.graphics.setColor(1, 1, 1)
        -- Dibujar la animación del jugador usando sus coordenadas actualizadas por Bump
        animation:draw(image, player.x, player.y)
        love.graphics.setColor(0, 1, 0)
        -- Dibujamos el rectángulo en modo 'line' para ver solo los bordes
        love.graphics.rectangle('line', player.x, player.y, player.w, player.h)
        -- Color en blanco al final
        love.graphics.setColor(1, 1, 1)
    Push:finish()
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end
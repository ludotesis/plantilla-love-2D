function love.conf(t)
    t.version = "11.5"                 -- Versión objetivo de LÖVE
    t.window.title = "Mi Juego 2D"     -- Título de la ventana
    t.window.width = 1280              -- Ancho de la ventana física
    t.window.height = 720              -- Alto de la ventana física
    t.window.resizable = true          -- Redimensión con librería push
    t.window.vsync = 1                 -- Activar sincronización vertical
    t.modules.physics = false          -- Bump.lua 
end
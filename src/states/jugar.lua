local Jugador = require "src.classes.jugador"

local Play = {}

function Play:enter(from)

    self.menu_anterior = from

    self.world = Bump.newWorld(64)
    self.player = Jugador(50, 50, self.world)

    self.muro = { x = 150, y = 80, w = 40, h = 60 }
    self.world:add(self.muro, self.muro.x, self.muro.y, self.muro.w, self.muro.h)

    self.cam = Camera(self.player.x, self.player.y)
end

function Play:update(dt)
    self.player:update(dt)

    local centroX = self.player.x + self.player.w / 2
    local centroY = self.player.y + self.player.h / 2
    self.cam:lookAt(Lume.round(centroX), Lume.round(centroY))
end

function Play:draw()
    self.cam:attach(0, 0, 320, 180)

        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle('fill', self.muro.x, self.muro.y, self.muro.w, self.muro.h)
        love.graphics.setColor(1, 1, 1)

        self.player:draw()

    self.cam:detach()
end

function Play:keypressed(key)
    if key == 'escape' then
        Gamestate.switch(self.menu_anterior)
    end
end

return Play
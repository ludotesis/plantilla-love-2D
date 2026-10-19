
local Play = require 'src.states.jugar'
local Menu = {}

function Menu:init()
    self.fuente = love.graphics.newFont("assets/fonts/1980.ttf",24,"mono")
end

function Menu:draw()
    love.graphics.setFont(self.fuente)
    love.graphics.printf("MI JUEGO: EL COMIENZO", 0, 60, 320, "center")
    love.graphics.printf("Presiona ENTER para jugar", 0, 100, 320, "center")
end

function Menu:keypressed(key)
    if key == 'return' then
        Gamestate.switch(Play)
    elseif key == 'escape' then
        love.event.quit()
    end
end

return Menu
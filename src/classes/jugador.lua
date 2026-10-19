local Jugador = Class{}

function Jugador:init(x, y, world)
    self.x = x
    self.y = y
    self.world = world
    self.speed = 100

    self.image = love.graphics.newImage('assets/sprites/oldHero.png')
    self.w = self.image:getWidth() / 6
    self.h = self.image:getHeight()

    local grid = Anim.newGrid(self.w, self.h, self.image:getWidth(), self.image:getHeight())
    self.animation = Anim.newAnimation(grid('1-6', 1), 0.1)

    self.world:add(self, self.x, self.y, self.w, self.h)
end

function Jugador:update(dt)
    local dx, dy = 0, 0

    if love.keyboard.isDown('right') then dx = self.speed * dt end
    if love.keyboard.isDown('left') then dx = -self.speed * dt end
    if love.keyboard.isDown('down') then dy = self.speed * dt end
    if love.keyboard.isDown('up') then dy = -self.speed * dt end

    if dx ~= 0 or dy ~= 0 then
        self.animation:update(dt)
        local metaX = self.x + dx
        local metaY = self.y + dy

        local actualX, actualY, cols, len = self.world:move(self, metaX, metaY)
        self.x = actualX
        self.y = actualY
    else
        self.animation:gotoFrame(1)
    end
end

function Jugador:draw()
    local px_round = Lume.round(self.x)
    local py_round = Lume.round(self.y)

    self.animation:draw(self.image, px_round, py_round)

    love.graphics.setColor(0, 1, 0)
    love.graphics.rectangle('line', px_round, py_round, self.w, self.h)
    love.graphics.setColor(1, 1, 1)
end

return Jugador
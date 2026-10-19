require "dependencias"

local Menu = require 'src.states.menu'

local GAME_WIDTH = 320
local GAME_HEIGHT = 180

local image, animation
local world
local player
local muro

local cam

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    Push:setupScreen(GAME_WIDTH, GAME_HEIGHT, 1280, 720, {
        fullscreen = false,
        resizable = true,
        pixelperfect = true
    })

    Gamestate.switch(Menu)
end

function love.resize(w, h)
    Push:resize(w, h)
end

function love.update(dt)
   Gamestate.update(dt)
end

function love.draw()
    Push:start()
        Gamestate.draw()
    Push:finish()
end

function love.keypressed(key)
    Gamestate.keypressed(key)
end
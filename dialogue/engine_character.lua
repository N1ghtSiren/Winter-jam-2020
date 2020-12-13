character = {}
local parentGroup = level_layers[1]

local methods = {}
methods.__index = methods

function methods:destroy()
    self.image:removeSelf()
    self.group:removeSelf()

    indexer.remove("chars", self)

    self = nil
end

function methods:show()
    self.group.isVisible = true
end

function methods:hide()
    self.group.isVisible = false
end

function methods:move(newx, newy)
    self.image.x = newx
    self.image.y = newy
end

function methods:jump()
    transition.to(self.image, { y=150, time=100, transition=easing.inOutBounce})
    timer.performWithDelay(100,function()
        transition.to(self.image, { y = 200, time=100, transition=easing.linear})
    end)
end

function methods:setAnimation(animationName)
    self.image.fill = {type = "image", filename = self.animations[animationName]}
end

function character.new(id)
    local base = chardb.get(id)
    local obj = {
        name = base.name or "Nameless",
        group = newGroup(parentGroup),
        animations = base.animations,
    }

    obj.image = display.newImageRect(obj.group, base.image, base.width, base.height)
    obj.image.isVisible = true

    
    obj.index = indexer.add("chars", obj)
    setmetatable(obj, methods)

    obj:hide()
    return obj
end
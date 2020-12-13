function stealTouch(event)
    return true
end

function setAnchor(obj,x,y)
    obj.anchorX = x
    obj.anchorY = y
end

function setPosition(obj,x,y)
    obj.x = x
    obj.y = y
end

function setScale(obj, scale)
    obj.xScale = scale
    obj.yScale = scale
end

local function getPointOnLine(x1, y1, x2, y2, percent)
    local lx = x2-x1
    local ly = y2-y1
    return x1+lx*percent, y1+ly*percent
end

function newGroup(parent)
    local group = display.newGroup()
    if(parent)then
        parent:insert(group)
    end

    return group
end

local abs = math.abs

function dist1(x1,x2)
    return abs(abs(x2)-abs(x1))
end

function dist2(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

function angle2(x1, y1, x2, y2)
    return (57.296 * math.atan2(y2 - y1, x2 - x1))
end

function polarProjection2(x, y, dist, angle)
    local PPx = x + dist * math.cos(angle * 0.017453)
    local PPy = y + dist * math.sin(angle * 0.017453)
    return PPx, PPy
end

function getPercent(curvalue, maxvalue)
    return tonumber(string.format("%.3f",(curvalue/(maxvalue*0.01)*0.01)))
end

function format1(n)
    return tonumber(string.format("%.2f",n))
end

function deepcopy(orig, copies)
    copies = copies or {}
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        if copies[orig] then
            copy = copies[orig]
        else
            copy = {}
            copies[orig] = copy
            for orig_key, orig_value in next, orig, nil do
                copy[deepcopy(orig_key, copies)] = deepcopy(orig_value, copies)
            end
            setmetatable(copy, deepcopy(getmetatable(orig), copies))
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function oneof(...)
    local args = {...}
    return args[math.random(1,#args)]
end

function round(n)
    return math.floor(n+0.5)
end

function textCutter(str, amount)
    local newStringSymbol = "\n"
    local temp = ""
    local lastspace = nil
    
    while true do
        lastspace = string.find(str, " ", -2)
        if(lastspace~=nil and lastspace<amount)then
            temp = temp..string.sub(str, 1, lastspace)..newStringSymbol
            str = string.sub(str, lastspace+1)
        else
            temp = temp..string.sub(str, 1, amount)..newStringSymbol
            str = string.sub(str, amount+1)
        end
        if(string.len(str)==0)then
            break
        end
    end

    return temp
end

function fuko(t)
    if(#t==0)then print("defuck: given table is empty") end
    for k,v in pairs(t) do
        print("table["..tostring(k).."] = "..tostring(v))
    end
end

--[[

    local lines = {
        [-5] = {sx = 60, sy = 300, ex = -640, ey = 360,},
        [-4] = {sx = 176, sy = 300, ex = -384, ey = 360,},
        [-3] = {sx = 292, sy = 300, ex = -128, ey = 360,},
        [-2] = {sx = 408, sy = 300, ex = 128, ey = 360,},
        [-1] = {sx = 524, sy = 300, ex = 384, ey = 360,},
        [0] = {sx = 640, sy = 300, ex = 640, ey = 360,},
        [1] = {sx = 756, sy = 300, ex = 896, ey = 360,},
        [2] = {sx = 872, sy = 300, ex = 1152, ey = 360,},
        [3] = {sx = 988, sy = 300, ex = 1408, ey = 360,},
        [4] = {sx = 1104, sy = 300, ex = 1664, ey = 360,},
        [5] = {sx = 1220, sy = 300, ex = 1920, ey = 360,},
    }
]]
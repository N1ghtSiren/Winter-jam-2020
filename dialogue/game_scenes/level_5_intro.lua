--
local function create(self)
    self.background = display.newImageRect(level_layers[0], "content/dialogue/level_5_intro_bg.png", 1280, 720)
    self.background.x, self.background.y = 0, 0
    self.chars.e1 = character.new("elf")
    self.chars.e2 = character.new("elf")
    self.chars.e3 = character.new("elf")
    self.chars.sani = character.new("sani")
    self.chars.sani:setAnimation("idle2")
end

local function update(self)
    local e1 = self.chars.e1
    local e2 = self.chars.e2
    local e3 = self.chars.e3
    local sani = self.chars.sani
    local g = self.chars.grinch
    local stage = self.stage

    if(stage==0)then
        self:setText("*Лес*")

    elseif(stage==1)then
        self:setText("...")
        e1:show()
        e1:move(-500, 200)
        e1.image.xScale=-1
        
        transition.to(e1.image, {x=850, time=500, transition=easing.linear})
        timer.performWithDelay(300, function()
            transition.to(e1.image, {xScale=1, time=500, transition=easing.linear})
        end)


    elseif(stage==2)then
        self:setText("...")
        e2:show()
        e3:show()

        e2:move(-500, 200)
        e3:move(-350, 200)

        e2.image.xScale=-1
        e3.image.xScale=-1
        
        transition.to(e2.image, {x=350, time=300, transition=easing.linear})
        transition.to(e3.image, {x=500, time=300, transition=easing.linear})

    elseif(stage==3)then
        self:setText("...")
        self.background.fill = {type = "image", filename = "content/dialogue/level_4_intro_bg2.png"}
        

    elseif(stage==4)then
        self:setText("Серёга: эээээ..")
        e1:jump()

    elseif(stage==5)then
        self:setText("Серёга: слыш верни..")
        e1:jump()

    elseif(stage==6)then
        self:setText("...")

        self.background.fill = {type = "image", filename = "content/dialogue/level_5_intro_bg.png"}

    elseif(stage==7)then
        self:setText("Серёга: уууух кодеры, копипастят всё подрят не проверяя")
        e1:jump()
    
    elseif(stage==8)then
        self:setText("...")
    
    elseif(stage==9)then
        sani:show()
        sani:move(-500,100)

        self:setText("Серёга: Санта похоже заметил что не всё в порядке и идёт на снижение")

        transition.to(sani.image, { x=1500, y = 200, time=1000, transition=easing.linear})

    elseif(stage==10)then
        self:setText("...")
        transition.to(e1.image, {xScale = -1, time=300, transition=easing.linear})

        timer.performWithDelay(200,function()
            transition.to(e1.image, {x = 2000, time=200, transition=easing.linear})
            transition.to(e2.image, {x = 1850, time=200, transition=easing.linear})
            transition.to(e3.image, {x = 2000, time=200, transition=easing.linear})
        end)

    elseif(stage==11)then
        self:setText("...")
        transition.to(self.background, {alpha=0, time=1000, transition=easing.linear})
        
    elseif(stage==12)then
        sceneLevel:level5()
    end

    self.stage = self.stage + 1

    return false
end

local obj = {
    stage = 0,
    maxstage = 12,
    create = create,
    update = update,
    chars = {},
}

return obj
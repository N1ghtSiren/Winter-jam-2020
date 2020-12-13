--
local function create(self)
    self.background = display.newImageRect(level_layers[0], "content/dialogue/level_2_intro_bg.png", 1280, 720)
    self.background.x, self.background.y = 0, 0
    self.chars.e1 = character.new("elf")
    self.chars.e2 = character.new("elf")
    self.chars.e3 = character.new("elf")
    self.chars.grinch = character.new("grinch")
end

local function update(self)
    local e1 = self.chars.e1
    local e2 = self.chars.e2
    local e3 = self.chars.e3
    local e4 = self.chars.e4
    local g = self.chars.grinch
    local stage = self.stage

    if(stage==0)then
        self:setText("*Деревушка*")

    elseif(stage==1)then
        e1:show()
        e1:move(-500, 200)
        e1.image.xScale=-1
        self:setText("Серёга: вижу ёлку!")

        transition.to(e1.image, {x=850, time=500, transition=easing.linear})
        timer.performWithDelay(300, function()
            transition.to(e1.image, {xScale=1, time=500, transition=easing.linear})
        end)

    elseif(stage==2)then
        self:setText("Серёга: складывайте что мы собрали и побежали дальше")
        e1:jump()

        e2:show()
        e3:show()

        e2:move(-500, 200)
        e3:move(-350, 200)

        e2.image.xScale=-1
        e3.image.xScale=-1
        
        transition.to(e2.image, {x=350, time=300, transition=easing.linear})
        transition.to(e3.image, {x=500, time=300, transition=easing.linear})

    elseif(stage==3)then
        self:setText("Эльф: но она какая-то стрёмная")
        if(math.random(1,2)==1)then
            e2:jump()
        else
            e3:jump()
        end

    elseif(stage==4)then
        self:setText("Серёга: какая есть. Наряжена - значит проверят утром и найдут подарки.")
        e1:jump()

    elseif(stage==5)then
        self:setText("Серёга: и наша работа не пропадёт зря.")
        e1:jump()

        self.background.fill = {type = "image", filename = "content/dialogue/level_2_intro_bg2.png"}

    elseif(stage==6)then
        g:show()
        g:move(1050, 200)
        g.image.alpha = 0
        transition.to(g.image, {alpha = 1, time=500, transition=easing.linear})

        timer.performWithDelay(500,function()
            self:setText("???: Бу!")
            e1:jump()
            e2:jump()
            e3:jump()
        end)
        
    elseif(stage==7)then
        self:setText("Серёга: ты ещё кто такой?")
        transition.to(e1.image, {xScale=-1, time=200, transition=easing.linear})
        timer.performWithDelay(200,function()
            e1:jump()
        end)
    
    elseif(stage==8)then
        self:setText("???: Вы меня не узнали? Я же Гринч!")
        g:jump()
    
    elseif(stage==9)then
        self:setText("Эльфы: аааа, это гринч!")
        e2:jump()
        e3:jump()
        timer.performWithDelay(200,function()
            transition.to(e2.image, {xScale=1, time=200, transition=easing.linear})
            transition.to(e3.image, {xScale=1, time=200, transition=easing.linear})

            timer.performWithDelay(200,function()
                transition.to(e2.image, {x = -1500, time=600, transition=easing.linear})
                transition.to(e3.image, {x = -1350, time=600, transition=easing.linear})
            end)
        end)
    
    elseif(stage==10)then
        self:setText("Серёга: вижу тебя сегодня тоже потрепало.")
        e1:jump()
    
    elseif(stage==11)then
        self:setText("Гринч: ага, вырвать бы руки этому художнику.")
        g:jump()
    
    elseif(stage==12)then
        self:setText("...")
        g:jump()

    elseif(stage==13)then
        self:setText("Серёга: зачем ты здесь? я думал ты будешь пытаться украсть подарки со склада.")
        e1:jump()
    
    elseif(stage==14)then
        self:setText("Гринч: Я уже проворачивал это пару раз. А тут вот какой шанс.")
        g:jump()
    
    elseif(stage==15)then
        self:setText("Гринч: Я могу украсть эти подарки прямо из под ёлки!")
        g:jump()
    
    elseif(stage==16)then
        self:setText("Серёга: но это не по правилам, мы их уже доставили.")
        e1:jump()
    
    elseif(stage==17)then
        self:setText("Гринч: Раз так, тогда я буду гоняться за вами...")
        g:jump()
    
    elseif(stage==18)then
        self:setText("Серёга: идёт.")
        e1:jump()
    
    elseif(stage==19)then
        self:setText("Серёга: Эльфы! Выдвигаемся!")
        e1:jump()
    
    elseif(stage==20)then
        self:setText("...")
        e2.xScale=-1
        e3.xScale=-1
        e2:move(-450,200)
        e3:move(-600,200)

        transition.to(e1.image, {x=2500, time=300, transition=easing.linear})

        timer.performWithDelay(300,function()
            transition.to(e2.image, {x=2050, time=700, transition=easing.linear})
            transition.to(e3.image, {x=1900, time=700, transition=easing.linear})
        end)

    elseif(stage==21)then
        self:setText("...")
        transition.to(g.image, {xScale=-1, time=200, transition=easing.linear})
        timer.performWithDelay(200,function()
            transition.to(g.image, {x=1500, time=800, transition=easing.linear})
        end)
    
    elseif(stage==22)then
        self:setText("...")
        transition.to(self.background, {alpha=0, time=1000, transition=easing.linear})

    elseif(stage==23)then
        sceneLevel:level2()
    end

    self.stage = self.stage + 1

    return false
end

local obj = {
    stage = 0,
    maxstage = 23,
    create = create,
    update = update,
    chars = {},
}

return obj
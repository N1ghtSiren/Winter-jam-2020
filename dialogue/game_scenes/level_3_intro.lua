--
local function create(self)
    self.background = display.newImageRect(level_layers[0], "content/dialogue/level_2_intro_bg.png", 1280, 720)
    self.background.x, self.background.y = 0, 0
    self.chars.e1 = character.new("elf")
    self.chars.e2 = character.new("elf")
    self.chars.e3 = character.new("elf")
    self.chars.grinch = character.new("grinch")
    self.chars.npc = character.new("townguy")
end

local function update(self)
    local e1 = self.chars.e1
    local e2 = self.chars.e2
    local e3 = self.chars.e3
    local e4 = self.chars.e4
    local g = self.chars.grinch
    local npc = self.chars.npc
    local stage = self.stage

    if(stage==0)then
        self:setText("*Ещё Деревушка*")

    elseif(stage==1)then
        e1:show()
        e1:move(-500, 200)
        e1.image.xScale=-1
        self:setText("Серёга: вижу ещё ёлку!")

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
        self:setText("Серёга: почему это место выглядит абсолютно так же как и прошлое...")
        e1:jump()

        self.background.fill = {type = "image", filename = "content/dialogue/level_2_intro_bg2.png"}

    elseif(stage==4)then
        self:setText("Серёга: Либо это уловка Гринча, либо мы действительно навернули круголя...")
        e1:jump()

    elseif(stage==5)then
        npc:show()
        npc.image.xScale = -1
        npc:move(1500, 200)

        transition.to(npc.image, {x=1250, time=600, transition=easing.linear})
        timer.performWithDelay(600, function()
            self:setText("Чел: Здарова челы")
            npc:jump()

            timer.performWithDelay(200, function()
                e1:jump()
                e2:jump()
                e3:jump()
            end)
        end)

    elseif(stage==6)then
        self:setText("Эльфы: аааа")
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

    elseif(stage==7)then
        transition.to(e1.image, {xScale=-1, time=200, transition=easing.linear})

        timer.performWithDelay(200, function()
            self:setText("Серёга: ну а ты кто?")
            e1:jump()
         end)

    elseif(stage==8)then
        self:setText("Чел: я работяга, иду вот домой..")
        npc:jump()

    elseif(stage==9)then
        self:setText("Чел: нашёл шапку, но мне она мала.")
        npc:jump()
        npc:setAnimation("hat")

    elseif(stage==10)then
        self:setText("Эльфы: аааа, Там Гринч!")
        e2.image.xScale = -1
        e3.image.xScale = -1

        transition.to(e2.image, {x = 1850, time=1000, transition=easing.linear})
        transition.to(e3.image, {x = 2000, time=1000, transition=easing.linear})

    elseif(stage==11)then
        self:setText("Чел: нужна?")
        npc:jump()

    elseif(stage==12)then
        self:setText("Серёга: давай, пригодится.")
        e1:jump()

        g:show()
        g:move(-500, 200)
        transition.to(g.image, {x = 250, time=1000, transition=easing.linear})

    elseif(stage==13)then
        npc:setAnimation("idle")

        self:setText("Серёга: спасибо!")
        e1:jump()

        transition.to(e1.image, {x = 2000, time=300, transition=easing.linear})

    elseif(stage==14)then
        self:setText("Чел: а ты кем будешь?")
        npc:jump()

    elseif(stage==15)then
        self:setText("Гринч: я? ...")
        g:jump()

    elseif(stage==16)then
        self:setText("Гринч: я с ними...")
        g:jump()

    elseif(stage==17)then
        self:setText("Чел: эх ладно, пойду я тогда..")
        npc:jump()
        timer.performWithDelay(200,function()
            transition.to(npc.image, {x = -300, time=800, transition=easing.linear})
        end)

    elseif(stage==18)then
        self:setText("...")
        transition.to(g.image, {x = 1800, time=1000, transition=easing.linear})

    elseif(stage==19)then
        self:setText("...")
        transition.to(self.background, {alpha=0, time=1000, transition=easing.linear})

    elseif(stage==20)then
        sceneLevel:level3()
        --
    end

    self.stage = self.stage + 1

    return false
end

local obj = {
    stage = 0,
    maxstage = 20,
    create = create,
    update = update,
    chars = {},
}

return obj
--
local function create(self)
    self.background = display.newImageRect(level_layers[0], "content/dialogue/finale_bg.png", 1280, 720)
    self.background.x, self.background.y = 0, 0
    self.chars.sani = character.new("sani")
    self.chars.e1 = character.new("elf")
    self.chars.e2 = character.new("elf")
    self.chars.e3 = character.new("elf")
    self.chars.sani:setAnimation("idle2")
    self.chars.santa = character.new("santa")
    self.chars.grinch = character.new("grinch")
end

local function update(self)
    local e1 = self.chars.e1
    local e2 = self.chars.e2
    local e3 = self.chars.e3
    local sani = self.chars.sani
    local g = self.chars.grinch
    local santa = self.chars.santa

    local stage = self.stage

    if(stage==0)then
        self:setText("*Лес*")
        sani:show()
        sani:move(450, 250)
        sani.image:toBack()

    elseif(stage==1)then
        santa:show()
        santa:move(1700, 200)
        santa.image.xScale = -1
        transition.to(santa.image, { x=1100, time=800, transition=easing.linear})

    elseif(stage==2)then
        self:setText("...")

        e1:show()
        e2:show()
        e3:show()
        e1:move(-150, 200)
        e2:move(-300, 200)
        e3:move(-450, 200)
        e1.image.xScale=-1
        e2.image.xScale=-1
        e3.image.xScale=-1

        transition.to(e1.image, { x=700, time=500, transition=easing.linear})
        transition.to(e2.image, { x=550, time=650, transition=easing.linear})
        transition.to(e3.image, { x=400, time=800, transition=easing.linear})

    elseif(stage==3)then
        self:setText("Серёга: Санта, мы тебя наконец догнали!")
        e1:jump()

    elseif(stage==4)then
        self:setText("Санта: но подарки то уже не вернуть...")
        santa:jump()

    elseif(stage==5)then
        self:setText("Серёга: Мы бежали за тобой с самой базы, собирая то что можно и занося в деревни\nчто были на пути.")
        e1:jump()

    elseif(stage==6)then
        self:setText("Серёга: Собрали конечно не всё, но около половины.")
        e1:jump()

    elseif(stage==7)then
        self:setText("...")
        g:show()
        g.image.alpha = 0
        g:move( 0, 250)
        
        transition.to(g.image, { alpha = 1, time=500, transition=easing.linear})

    elseif(stage==8)then
        self:setText("Гринч: Бу!")

        santa:jump()
        e1:jump()
        e2:jump()
        e3:jump()

        timer.performWithDelay(200,function()
            transition.to(e1.image, { xScale=1, time=500, transition=easing.linear})
            transition.to(e2.image, { xScale=1, time=500, transition=easing.linear})
            transition.to(e3.image, { xScale=1, time=500, transition=easing.linear})
        end)

    elseif(stage==9)then
        self:setText("Серёга: Так это твоих рук дело?")
        e1:jump()

    elseif(stage==10)then
        self:setText("Гринч: Хотелось бы, но нет.")
        g:jump()

    elseif(stage==11)then
        self:setText("Гринч: Я даже эльфов догнать не смог.")
        g:jump()

    elseif(stage==12)then
        self:setText("Гринч: (")

        transition.to(g.image, { x=-500, time=1000, transition=easing.linear})

    elseif(stage==13)then
        self:setText("Санта: Я чувствую что он не врёт.")
        santa:jump()

    elseif(stage==14)then
        self:setText("Санта: Залезайте в сани, полетим на базу..")
        santa:jump()

    elseif(stage==15)then
        self:setText("???: Ещё одно рождество спасено?")

        transition.to(santa.image, { alpha = 0, time=1000, transition=easing.linear})
        transition.to(e1.image, { alpha = 0, time=1000, transition=easing.linear})
        transition.to(e2.image, { alpha = 0, time=1000, transition=easing.linear})
        transition.to(e3.image, { alpha = 0, time=1000, transition=easing.linear})

    elseif(stage==16)then
        self:setText("...")
        transition.to(sani.image, { x = 1700, y = 100, time=2000, transition=easing.linear})

    elseif(stage==17)then
        self:setText("...")
        transition.to(self.background, { alpha=0, time=100, transition=easing.linear})

    elseif(stage==18)then
        progress.setGameCompleted()
        mainMenu:go()

    end

    self.stage = self.stage + 1

    return false
end

local obj = {
    stage = 0,
    maxstage = 18,
    create = create,
    update = update,
    chars = {},
}

return obj
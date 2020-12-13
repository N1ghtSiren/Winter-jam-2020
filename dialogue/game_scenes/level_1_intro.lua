--
local function create(self)
    self.background = display.newImageRect(level_layers[0], "content/dialogue/level_1_intro_bg.png", 1280, 720)
    self.background.x, self.background.y = 0, 0
    self.chars.santa = character.new("santa")
    self.chars.sani = character.new("sani")
    self.chars.e1 = character.new("elf")
    self.chars.e2 = character.new("elf")
    self.chars.e3 = character.new("elf")
    self.chars.e4 = character.new("elf")
end

local function update(self)
    local santa = self.chars.santa
    local e1 = self.chars.e1
    local e2 = self.chars.e2
    local e3 = self.chars.e3
    local e4 = self.chars.e4
    local stage = self.stage

    if(stage==0)then
        self:setText("*База эльфов*")
        santa:show()
        santa:move(-300, 200)
        
        transition.to(santa.image, { x=1200, time=800, transition=easing.linear})
        timer.performWithDelay(820,function()
            transition.to(santa.image, { xScale=-1, time=200, transition=easing.linear})
        end)

    elseif(stage==1)then
        self:setText("Санта: эльфы!")
        santa:jump()

    elseif(stage==2)then
        e1:show()
        e2:show()
        e3:show()
        e4:show()
        e1:move(-150, 200)
        e2:move(-300, 200)
        e3:move(-450, 200)
        e4:move(-600, 200)
        e1.image.xScale=-1
        e2.image.xScale=-1
        e3.image.xScale=-1
        e4.image.xScale=-1

        transition.to(e1.image, { x=750, time=800, transition=easing.linear})
        transition.to(e2.image, { x=600, time=800, transition=easing.linear})
        transition.to(e3.image, { x=450, time=800, transition=easing.linear})
        transition.to(e4.image, { x=300, time=800, transition=easing.linear})

        self:setText("Санта: сегодня мне нужно развезти подарки.")
        santa:jump()

    elseif(stage==3)then
        self:setText("Санта: я не знаю что я вчера хряпнул, что всё чёрно белым стало.")
        santa:jump()

    elseif(stage==4)then
        self:setText("Санта: но так или иначе, дети ждут свои подарки.")
        santa:jump()

    elseif(stage==5)then
        self:setText("Санта: грузите их в мои ...")
        santa:jump()

        
    elseif(stage==6)then
        self:setText("Санта: сани?")
        santa:jump()


        transition.to(e1.image, { xScale=1, time=200, transition=easing.linear})
        transition.to(e2.image, { xScale=1, time=200, transition=easing.linear})
        transition.to(e3.image, { xScale=1, time=200, transition=easing.linear})
        transition.to(e4.image, { xScale=1, time=200, transition=easing.linear})
        timer.performWithDelay(200, function()
            transition.to(e1.image, { x=-450, time=800, transition=easing.linear})
            transition.to(e2.image, { x=-600, time=800, transition=easing.linear})
            transition.to(e3.image, { x=-750, time=800, transition=easing.linear})
            transition.to(e4.image, { x=-900, time=800, transition=easing.linear})
        end)

    elseif(stage==7)then
        self:setText("Санта: .. и позовите Серёгу.")
        santa:jump()

    elseif(stage==8)then
        self:setText("...")
        e1.image.xScale = -1
        transition.to(e1.image, { x=450, time=800, transition=easing.linear})

    elseif(stage==9)then
        self:setText("Санта: Я скоро вылечу.")
        santa:jump()

    elseif(stage==10)then
        self:setText("Санта: База остаётся на тебе.")
        santa:jump()

    elseif(stage==11)then
        self:setText("Санта: Охраняй подарки и помни про ")
        santa:jump()

    elseif(stage==12)then
        self:setText("*Злобный смех*")
        e1:jump()
        santa:jump()

    elseif(stage==13)then
        self:setText("Санта: да, именно про Гринча.")
        santa:jump()

    elseif(stage==14)then
        self:setText("Серёга: подарки в безопасности.")
        e1:jump()

    elseif(stage==15)then
        self:setText("Серёга: мы уже сделали надпись.")
        e1:jump()

    elseif(stage==16)then
        self:setText("Санта: да, это его точно остановит...")
        santa:jump()

    elseif(stage==17)then
        self:setText("...")
        transition.to(santa.image, { xScale=1, time=200, transition=easing.linear})
        timer.performWithDelay(200, function()
            transition.to(santa.image, { x=1500, time=800, transition=easing.linear})
        end)

        transition.to(e1.image, { x=1500, time=800, transition=easing.linear})

    elseif(stage==18)then
        self:setText("...")
        transition.to(self.background, { alpha=0, time=900, transition=easing.linear})

    elseif(stage==19)then
        self:setText("...")
        self.chars.sani:show()
        self.chars.sani:move(-1000, 0)

    elseif(stage==20)then
        self:setText("...")
        transition.to(self.chars.sani.image, { x=1500, time=900, transition=easing.linear})

        self.presents = {}
        for i = 0, 9 do
            self.presents[i] = character.new("present")
            self.presents[i]:move(280*i+math.random(-40, 40), 20)

            timer.performWithDelay(300+i*100, function()
                self.presents[i]:show()
                transition.to(self.presents[i].image, {y=math.random(400, 600), time=900, transition=easing.linear})
            end)
            
        end
        

    elseif(stage==21)then
        self:setText("...")
        e1:move(-400, 200)
        e1:show()
        e1.image:toFront()

        transition.to(e1.image, {x=500, time=900, transition=easing.linear})

    elseif(stage==22)then
        self:setText("Серёга: похоже мы недоглядели...")
        e1:jump()

    elseif(stage==23)then
        self:setText("Серёга: плевать на наказание, нужно спасать подарки")
        e1:jump()
        timer.performWithDelay(300, function()
            transition.to(e1.image, { xScale=1, time=200, transition=easing.linear})

            timer.performWithDelay(200, function()
                transition.to(e1.image, {x=-500, time=500, transition=easing.linear})
            end)

        end)

    elseif(stage==24)then
        for i = 0, 9 do
            self.presents[i]:destroy()
            self.presents[i] = nil
        end
        self.presents = nil
        --
        self:setText("...")
        transition.to(self.background, { alpha=1, time=600, transition=easing.linear})

        e1:move(1500, 200)
        timer.performWithDelay(600, function()
            transition.to(e1.image, {x=800, time=300, transition=easing.linear})
        end)

    elseif(stage==25)then
        self:setText("Серёга: Эльфы, Синий уровень опасности!")
        e1:jump()
    
    elseif(stage==26)then
        self:setText("...")
        e2:show()
        e3:show()
        e4:show()

        e2.image.xScale = -1
        e3.image.xScale = -1
        e4.image.xScale = -1

        e2:move(-400, 200)
        e3:move(-550, 200)
        e4:move(-700, 200)

        transition.to(e2.image, {x=600, time=400, transition=easing.linear})
        transition.to(e3.image, {x=450, time=400, transition=easing.linear})
        transition.to(e4.image, {x=300, time=400, transition=easing.linear})

    elseif(stage==27)then
        self:setText("Эльфы: а такой есть вообще?")

        if(math.random(1,2)==1)then e2:jump() end
        if(math.random(1,2)==1)then e3:jump() end
        if(math.random(1,2)==1)then e4:jump() end

    elseif(stage==28)then
        self:setText("Серёга: тишина!")
        e1:jump()

    elseif(stage==29)then
        self:setText("Серёга: похоже Гринч продырявил Санте мешок, и теперь все подарки рассыпаются по лесу.")
        e1:jump()

    elseif(stage==30)then
        self:setText("Серёга: Санта в любом случае нас накажет, но наша работа не должна пропасть зря.")
        e1:jump()

    elseif(stage==31)then
        self:setText("Серёга: в погоню!")
        e1:jump()

    elseif(stage==32)then
        self:setText("...")
        
        transition.to(e1.image, {xScale=-1, time=200, transition=easing.linear})
        timer.performWithDelay(200, function()
            transition.to(e1.image, {x=2000, time=500, transition=easing.linear})

            timer.performWithDelay(200, function()
                transition.to(e2.image, {x=2600, time=600, transition=easing.linear})
                transition.to(e3.image, {x=2450, time=600, transition=easing.linear})
                transition.to(e4.image, {x=2300, time=600, transition=easing.linear})
            end)
        end)

    elseif(stage==33)then
        self:setText("...")
        transition.to(self.background, { alpha=0, time=600, transition=easing.linear})

    elseif(stage==34)then
        sceneLevel:level1()
    end

    self.stage = self.stage + 1

    return false    --not finished; true if finished
end

local obj = {
    stage = 0,
    create = create,
    update = update,
    chars = {},
}

return obj
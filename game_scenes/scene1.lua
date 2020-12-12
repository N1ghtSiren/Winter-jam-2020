--
local function create(self)
    self.background = display.newImageRect(level_layers[0], "content/images/scene1_background.png", 1280, 720)
    self.background.x, self.background.y = 0, 0
    self.background.alpha = 0.5
    self.chars.m1 = character.new("testchar")
    self.chars.m2 = character.new("testchar")
end

local function update(self)
    local m1 = self.chars.m1
    local m2 = self.chars.m2
    local stage = self.stage

    if(stage==0)then
        m1:show()
        m1:move(350, 200)
        self:setText("Zzz")

    elseif(stage==1)then
        self:setText("Zzzz")

    elseif(stage==2)then
        self:setText("Zzzzz")

    elseif(stage==3)then
        m2:show()
        m2:move(1000, 600)
        self:setText("чел")
        transition.to(m2.image, { x=700, y=400, time=1000, transition=easing.linear})

    elseif(stage==4)then
        self:setText("ты там спишь чтоль?")
        transition.to(m2.image, { x=450, y=200, time=1000, transition=easing.linear})

    elseif(stage==5)then
        self:setText("Чел!")
        transition.to(m1.image, { x=360, y=210, time=300, transition=easing.inOutBounce})

        timer.performWithDelay(300, function()
            transition.to(m1.image, { x=340, y=190, time=300, transition=easing.inOutBounce})

            timer.performWithDelay(300, function()
                transition.to(m1.image, { x=350, y=200, time=300, transition=easing.inOutBounce})
            end)
        end)
        
    elseif(stage==6)then
        self:setText("чел: Да вроде нет, играл вот...")
        transition.to(m2.image, { x=600, y=250, time=1000, transition=easing.linear})

    elseif(stage==7)then
        self:setText("чел: в поешку...")
        m2:setAnimation("look_left")

    elseif(stage==8)then
        self:setText("чел: ...")
        m1:setAnimation("look_right")

    elseif(stage==9)then
        self:setText("Снова ты всё сломал и нас куда-то засосало")

    elseif(stage==10)then
        self:setText("чел: я вижу...")
        m1:setAnimation("idle")

    elseif(stage==11)then
        self:setText("чел: у меня даже пальцев на руках нет")
        m1:setAnimation("look_at_hand")

    elseif(stage==12)then
        self:setText("чел: и вот это починить я не могу ибо художники даже кнопок на клаве не нарисовали")
        m1:setAnimation("idle")
        m2:setAnimation("look_at_hand")

    elseif(stage==13)then
        self:setText("Никогда такого не было и вот опять...")

    end

    self.stage = self.stage + 1
end

local obj = {
    stage = 0,
    maxstages = 12,
    create = create,
    update = update,
    chars = {},
}

return obj
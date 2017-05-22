-- Constructor
ModuleMenu =  {}
ModuleMenu.__index = ModuleMenu

function ModuleMenu:create(menuOptions)
    local self = {}
    setmetatable(self,ModuleMenu)
    self.menu = {}
    self.historic = {}
    self.currentuser = currentUser
    self.x = menuOptions.x
    self.y = menuOptions.y
    self.width = menuOptions.width
    self.height = menuOptions.height
    self.buttons = menuOptions.buttons
    self.from = menuOptions.from
    self.to = menuOptions.to
    self.scale = menuOptions.scale
    self.font = menuOptions.font
    self.open = menuOptions.open
    self.title = menuOptions.title
    self.currentmenu = menuOptions.currentmenu
    self.lastmenu = menuOptions.lastmenu
    self.currentpos = menuOptions.currentpos
    self.selectedbutton = menuOptions.selectedbutton
    self.marker = menuOptions.marker
    self.baseMenu = menuOptions.currentmenu
    return self
end

function ModuleMenu:open()
    self.open = true
end

function ModuleMenu:close()
    self.currentmenu = "main"
    self.open = false
end

function ModuleMenu:navsButtons(buttoncount)
    if IsControlJustPressed(1,188) then -- Up key
    if self.selectedbutton > 1 then
        self.selectedbutton = self.selectedbutton -1
        if buttoncount > 10 and self.selectedbutton < self.from then
            self.from = self.from -1
            self.to = self.to - 1
        end
    end
    end
    if IsControlJustPressed(1,187)then -- Down key
        if self.selectedbutton < buttoncount then
            self.selectedbutton = self.selectedbutton +1
            if buttoncount > 10 and self.selectedbutton > self.to then
                self.to = self.to + 1
                self.from = self.from + 1
            end
        end
    end
end

function ModuleMenu:setCurrentVariation(direction, menuName)
    if direction == "left" then
        self.menu[menuName].userSelectVariation = self.menu[menuName].userSelectVariation - 1
    else
        self.menu[menuName].userSelectVariation = self.menu[menuName].userSelectVariation + 1
    end
end

function ModuleMenu:getLastMenu()
    return self.lastmenu
end

function ModuleMenu:onClick( button )
    if IsControlJustPressed(1,201) then
        button.onClick()
    end
end

function ModuleMenu:onLeft( button )
    if IsControlJustPressed(1,174) then
        button.onLeft()
    end
end

function ModuleMenu:onRight( button )
    if IsControlJustPressed(1,175) then
        button.onRight()
    end
end

function ModuleMenu:onSelected( button )
    button.onSelected()
end

function ModuleMenu:onBack( button )
    if IsControlJustPressed(1,202) then
        button.onBack()
    end
end

function ModuleMenu:toMenu( menuId )
    self:OpenMenu(menuId)
end

function ModuleMenu:setMenu(menuName, title, buttons, rightInfo)
    self.menu[menuName] = {
        title = title,
        name = menuName,
        buttons = buttons,
        currentVariation = 0,
        userSelect = 0,
        userSelectVariation = 0,
        rightInfo = rightInfo,
        onBack = function()
            if self.currentmenu ~= self.baseMenu then
                self:toMenu(self:getLastMenu())
            end
        end
    }
end

function ModuleMenu:OpenMenu(menu)
    self.lastmenu = self.currentmenu
    self.from = 1
    self.to = 10
    self.selectedbutton = 0
    self.currentmenu = menu
end

function ModuleMenu:setTexte()
    self:drawTxt(self.menu[self.currentmenu].title,1,1,self.x,self.y,1.0, 255,255,255,255)
    self:drawMenuTitle(self.menu[self.currentmenu].title, self.x,self.y + 0.08)
    self:drawTxt(self.selectedbutton.."/".. #self.menu[self.currentmenu].buttons,0,0,self.x + self.width/2 - 0.0385,self.y + 0.067,0.4, 255,255,255,255)
end

function ModuleMenu:drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function ModuleMenu:drawMenuButton(button,x,y,selected)
    local menu = self
    SetTextFont(menu.font)
    SetTextProportional(0)
    SetTextScale(menu.scale, menu.scale)
    if selected then
        SetTextColour(0, 0, 0, 255)
    else
        SetTextColour(255, 255, 255, 255)
    end
    SetTextCentre(0)
    SetTextEntry("STRING")
    AddTextComponentString(button.name)
    if selected then
        DrawRect(x,y,menu.width,menu.height,255,255,255,255)
    else
        DrawRect(x,y,menu.width,menu.height,0,0,0,150)
    end
    DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)

end

function ModuleMenu:drawMenuInfo(text)
    local menu = self
    SetTextFont(menu.font)
    SetTextProportional(0)
    SetTextScale(0.45, 0.45)
    SetTextColour(255, 255, 255, 255)
    SetTextCentre(0)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawRect(0.675, 0.95,0.65,0.050,0,0,0,150)
    DrawText(0.365, 0.934)
end

function ModuleMenu:drawMenuRight(txt,x,y,selected)
    local menu = self
    SetTextFont(menu.font)
    SetTextProportional(0)
    SetTextScale(menu.scale, menu.scale)
    SetTextRightJustify(1)
    if selected then
        SetTextColour(0, 0, 0, 255)
    else
        SetTextColour(255, 255, 255, 255)
    end
    SetTextCentre(0)
    SetTextEntry("STRING")
    AddTextComponentString(txt)
    DrawText(x + menu.width/2 - 0.03, y - menu.height/2 + 0.0028)
end

function ModuleMenu:drawMenuTitle(txt,x,y)
    local menu = self
    SetTextFont(2)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    AddTextComponentString(txt)
    DrawRect(x,y,menu.width,menu.height,58,83,155,150)
    DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function ModuleMenu:display()
    local y = self.y + 0.12

    if type(self.menu[self.currentmenu].buttons) == "function" then
        self.menu[self.currentmenu].buttons = self.menu[self.currentmenu].buttons()
    end

    local buttoncount = #self.menu[self.currentmenu].buttons
    local selected = false

    self:setTexte()
    self:navsButtons(buttoncount)

    for i, button in pairs(self.menu[self.currentmenu].buttons) do
        if i >= self.from and i <= self.to then
            if i == self.selectedbutton then
                selected = true
            else
                selected = false
            end
            self:drawMenuButton(button,self.x, y,selected)
            if self.menu[self.currentmenu].rightInfo then
                if button.max ~= false then
                    -- self:drawTxt(self.menu[self.currentmenu].userSelectVariation.."/".. button.max ,0,0,self.x + self.width/2 - 0.0385,y-0.005,0.4, 255,255,255,255)
                end
            end
            if selected then
                self.menu[self.currentmenu].userSelect = button.id
                self:onLeft(button)
                self:onRight(button)
                self:onSelected(button)
                self:onClick(button)
                self:onBack(button)
            end
            y = y + 0.04
        end
    end
end
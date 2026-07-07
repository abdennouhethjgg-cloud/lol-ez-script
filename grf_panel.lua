-- GRF Style Panel V2 for Delta Executor
-- Enhanced with Brainrot Features (Skibidi, Sigma, etc.)
-- Compatible with "Steal a Brainrot" and other games

local Library = {}
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Protection against re-execution
if CoreGui:FindFirstChild("GRF_Panel_V2") then
    CoreGui:FindFirstChild("GRF_Panel_V2"):Destroy()
end

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local SideBar = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local TabContainer = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local ContentFrame = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")
    local Pages = Instance.new("Folder")

    -- Properties
    ScreenGui.Name = "GRF_Panel_V2"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 500, 0, 320)
    MainFrame.Active = true

    -- Draggable functionality for Mobile (Delta)
    local dragging, dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    SideBar.Name = "SideBar"
    SideBar.Parent = MainFrame
    SideBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    SideBar.Size = UDim2.new(0, 140, 1, 0)

    UICorner_2.CornerRadius = UDim.new(0, 10)
    UICorner_2.Parent = SideBar

    Title.Name = "Title"
    Title.Parent = SideBar
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title or "GRF V2"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = SideBar
    TabContainer.Active = true
    TabContainer.BackgroundTransparency = 1.000
    TabContainer.Position = UDim2.new(0, 0, 0, 50)
    TabContainer.Size = UDim2.new(1, 0, 1, -60)
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContainer.ScrollBarThickness = 0

    UIListLayout.Parent = TabContainer
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 2)

    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ContentFrame.Position = UDim2.new(0, 150, 0, 10)
    ContentFrame.Size = UDim2.new(1, -160, 1, -20)

    UICorner_3.CornerRadius = UDim.new(0, 10)
    UICorner_3.Parent = ContentFrame

    Pages.Name = "Pages"
    Pages.Parent = ContentFrame

    local function CreateTab(name)
        local TabButton = Instance.new("TextButton")
        local Page = Instance.new("ScrollingFrame")
        local PageList = Instance.new("UIListLayout")

        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabButton.BackgroundTransparency = 1.000
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = "  " .. name
        TabButton.TextColor3 = Color3.fromRGB(180, 180, 180)
        TabButton.TextSize = 13.000
        TabButton.TextXAlignment = Enum.TextXAlignment.Left

        Page.Name = name .. "Page"
        Page.Parent = Pages
        Page.Active = true
        Page.BackgroundTransparency = 1.000
        Page.Size = UDim2.new(1, -10, 1, -10)
        Page.Position = UDim2.new(0, 5, 0, 5)
        Page.Visible = false
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)

        PageList.Parent = Page
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 8)

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(Pages:GetChildren()) do
                v.Visible = false
            end
            for _, v in pairs(TabContainer:GetChildren()) do
                if v:IsA("TextButton") then
                    v.TextColor3 = Color3.fromRGB(180, 180, 180)
                    v.BackgroundTransparency = 1
                end
            end
            Page.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabButton.BackgroundTransparency = 0.9
        end)

        local Tab = {}

        function Tab:AddButton(text, callback)
            local Button = Instance.new("TextButton")
            local UICorner_B = Instance.new("UICorner")

            Button.Name = text .. "Button"
            Button.Parent = Page
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            Button.Size = UDim2.new(1, -5, 0, 35)
            Button.Font = Enum.Font.Gotham
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 13.000

            UICorner_B.CornerRadius = UDim.new(0, 6)
            UICorner_B.Parent = Button

            Button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
            
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end

        function Tab:AddToggle(text, callback)
            local ToggleFrame = Instance.new("Frame")
            local ToggleButton = Instance.new("TextButton")
            local UICorner_T = Instance.new("UICorner")
            local Title_T = Instance.new("TextLabel")
            local Status = Instance.new("Frame")
            local UICorner_S = Instance.new("UICorner")

            ToggleFrame.Name = text .. "Toggle"
            ToggleFrame.Parent = Page
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleFrame.Size = UDim2.new(1, -5, 0, 35)

            UICorner_T.CornerRadius = UDim.new(0, 6)
            UICorner_T.Parent = ToggleFrame

            Title_T.Parent = ToggleFrame
            Title_T.BackgroundTransparency = 1.000
            Title_T.Position = UDim2.new(0, 10, 0, 0)
            Title_T.Size = UDim2.new(1, -60, 1, 0)
            Title_T.Font = Enum.Font.Gotham
            Title_T.Text = text
            Title_T.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_T.TextSize = 13.000
            Title_T.TextXAlignment = Enum.TextXAlignment.Left

            Status.Name = "Status"
            Status.Parent = ToggleFrame
            Status.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Status.Position = UDim2.new(1, -30, 0.5, -8)
            Status.Size = UDim2.new(0, 16, 0, 16)

            UICorner_S.CornerRadius = UDim.new(1, 0)
            UICorner_S.Parent = Status

            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1.000
            ToggleButton.Size = UDim2.new(1, 0, 1, 0)
            ToggleButton.Text = ""

            local enabled = false
            ToggleButton.MouseButton1Click:Connect(function()
                enabled = not enabled
                Status.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
                pcall(function() callback(enabled) end)
            end)

            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end

        function Tab:AddSlider(text, min, max, defaultValue, callback)
            local SliderFrame = Instance.new("Frame")
            local UICorner_S = Instance.new("UICorner")
            local Title_S = Instance.new("TextLabel")
            local Slider = Instance.new("Frame")
            local SliderHandle = Instance.new("Frame")
            local UICorner_H = Instance.new("UICorner")
            local ValueLabel = Instance.new("TextLabel")

            SliderFrame.Name = text .. "Slider"
            SliderFrame.Parent = Page
            SliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            SliderFrame.Size = UDim2.new(1, -5, 0, 50)

            UICorner_S.CornerRadius = UDim.new(0, 6)
            UICorner_S.Parent = SliderFrame

            Title_S.Parent = SliderFrame
            Title_S.BackgroundTransparency = 1.000
            Title_S.Position = UDim2.new(0, 10, 0, 5)
            Title_S.Size = UDim2.new(1, -20, 0, 15)
            Title_S.Font = Enum.Font.Gotham
            Title_S.Text = text
            Title_S.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_S.TextSize = 12.000
            Title_S.TextXAlignment = Enum.TextXAlignment.Left

            Slider.Name = "Slider"
            Slider.Parent = SliderFrame
            Slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Slider.Position = UDim2.new(0, 10, 0, 25)
            Slider.Size = UDim2.new(1, -60, 0, 10)

            SliderHandle.Name = "SliderHandle"
            SliderHandle.Parent = Slider
            SliderHandle.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
            SliderHandle.Size = UDim2.new(0, 10, 1, 0)

            UICorner_H.CornerRadius = UDim.new(1, 0)
            UICorner_H.Parent = SliderHandle

            ValueLabel.Name = "ValueLabel"
            ValueLabel.Parent = SliderFrame
            ValueLabel.BackgroundTransparency = 1.000
            ValueLabel.Position = UDim2.new(1, -45, 0, 20)
            ValueLabel.Size = UDim2.new(0, 30, 0, 20)
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.Text = tostring(defaultValue)
            ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.TextSize = 12.000

            local currentValue = defaultValue
            local draggingSlider = false

            local function updateSlider(input)
                local mouseX = input.Position.X
                local sliderX = Slider.AbsolutePosition.X
                local sliderWidth = Slider.AbsoluteSize.X

                local relativeX = math.clamp(mouseX - sliderX, 0, sliderWidth)
                local percentage = relativeX / sliderWidth
                currentValue = min + (max - min) * percentage
                currentValue = math.floor(currentValue * 10 + 0.5) / 10 -- Round to 1 decimal place

                SliderHandle.Position = UDim2.new(percentage, 0, 0, 0)
                ValueLabel.Text = tostring(currentValue)
                pcall(function() callback(currentValue) end)
            end

            Slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingSlider = true
                    updateSlider(input)
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input)
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    draggingSlider = false
                end
            end)

            -- Set initial handle position
            local initialPercentage = (defaultValue - min) / (max - min)
            SliderHandle.Position = UDim2.new(initialPercentage, 0, 0, 0)

            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end

        return Tab
    end
            local ToggleButton = Instance.new("TextButton")
            local UICorner_T = Instance.new("UICorner")
            local Title_T = Instance.new("TextLabel")
            local Status = Instance.new("Frame")
            local UICorner_S = Instance.new("UICorner")

            ToggleFrame.Name = text .. "Toggle"
            ToggleFrame.Parent = Page
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleFrame.Size = UDim2.new(1, -5, 0, 35)

            UICorner_T.CornerRadius = UDim.new(0, 6)
            UICorner_T.Parent = ToggleFrame

            Title_T.Parent = ToggleFrame
            Title_T.BackgroundTransparency = 1.000
            Title_T.Position = UDim2.new(0, 10, 0, 0)
            Title_T.Size = UDim2.new(1, -60, 1, 0)
            Title_T.Font = Enum.Font.Gotham
            Title_T.Text = text
            Title_T.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_T.TextSize = 13.000
            Title_T.TextXAlignment = Enum.TextXAlignment.Left

            Status.Name = "Status"
            Status.Parent = ToggleFrame
            Status.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Status.Position = UDim2.new(1, -30, 0.5, -8)
            Status.Size = UDim2.new(0, 16, 0, 16)

            UICorner_S.CornerRadius = UDim.new(1, 0)
            UICorner_S.Parent = Status

            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1.000
            ToggleButton.Size = UDim2.new(1, 0, 1, 0)
            ToggleButton.Text = ""

            local enabled = false
            ToggleButton.MouseButton1Click:Connect(function()
                enabled = not enabled
                Status.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
                pcall(function() callback(enabled) end)
            end)

            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end

        return Tab
    end
            local ToggleButton = Instance.new("TextButton")
            local UICorner_T = Instance.new("UICorner")
            local Title_T = Instance.new("TextLabel")
            local Status = Instance.new("Frame")
            local UICorner_S = Instance.new("UICorner")

            ToggleFrame.Name = text .. "Toggle"
            ToggleFrame.Parent = Page
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleFrame.Size = UDim2.new(1, -5, 0, 35)

            UICorner_T.CornerRadius = UDim.new(0, 6)
            UICorner_T.Parent = ToggleFrame

            Title_T.Parent = ToggleFrame
            Title_T.BackgroundTransparency = 1.000
            Title_T.Position = UDim2.new(0, 10, 0, 0)
            Title_T.Size = UDim2.new(1, -60, 1, 0)
            Title_T.Font = Enum.Font.Gotham
            Title_T.Text = text
            Title_T.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_T.TextSize = 13.000
            Title_T.TextXAlignment = Enum.TextXAlignment.Left

            Status.Name = "Status"
            Status.Parent = ToggleFrame
            Status.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Status.Position = UDim2.new(1, -30, 0.5, -8)
            Status.Size = UDim2.new(0, 16, 0, 16)

            UICorner_S.CornerRadius = UDim.new(1, 0)
            UICorner_S.Parent = Status

            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1.000
            ToggleButton.Size = UDim2.new(1, 0, 1, 0)
            ToggleButton.Text = ""

            local enabled = false
            ToggleButton.MouseButton1Click:Connect(function()
                enabled = not enabled
                Status.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
                pcall(function() callback(enabled) end)
            end)

            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end

        return Tab
    end

    return {
        CreateTab = CreateTab,
        Destroy = function() ScreenGui:Destroy() end
    }
end

-- Functions & Utilities
local function SpawnBrainrot()
    local character = LocalPlayer.Character
    if not character then return end
    
    local brainrots = {
        {Name = "Skibidi", Sound = "rbxassetid://18788722327", Image = "rbxassetid://11600511955"},
        {Name = "Sigma", Sound = "rbxassetid://16190757458", Image = "rbxassetid://11600511955"},
        {Name = "Fanum Tax", Sound = "rbxassetid://110287182968878", Image = "rbxassetid://11600511955"}
    }
    
    local selected = brainrots[math.random(1, #brainrots)]
    
    local Part = Instance.new("Part")
    Part.Name = selected.Name
    Part.Size = Vector3.new(4, 4, 4)
    Part.Position = character.HumanoidRootPart.Position + Vector3.new(math.random(-10, 10), 5, math.random(-10, 10))
    Part.Parent = workspace
    Part.CanCollide = true
    
    local Decal = Instance.new("Decal")
    Decal.Texture = selected.Image
    Decal.Face = Enum.NormalId.Front
    Decal.Parent = Part
    
    local Sound = Instance.new("Sound")
    Sound.SoundId = selected.Sound
    Sound.Parent = Part
    Sound.Looped = true
    Sound:Play()
    
    -- Auto destroy after 30s
    task.delay(30, function()
        if Part then Part:Destroy() end
    end)
end

-- Panel Setup
local win = Library:CreateWindow("GRF BRAINROT V2")

local brainrotTab = win:CreateTab("Brainrot")
local playerTab = win:CreateTab("Player")
local visualTab = win:CreateTab("Visuals")
local bloxFruitTab = win:CreateTab("Blox Fruits")

-- Brainrot Features
brainrotTab:AddButton("Spawn Random Brainrot", function()
    SpawnBrainrot()
end)

local brainrotSpawnDelay = 5 -- Default spawn delay in seconds
local autoSpawnEnabled = false
brainrotTab:AddSlider("Spawn Delay (seconds)", 1, 10, brainrotSpawnDelay, function(value)
    brainrotSpawnDelay = value
end)

brainrotTab:AddToggle("Auto Spawn Brainrot", function(state)
    autoSpawnEnabled = state
    if autoSpawnEnabled then
        task.spawn(function()
            while autoSpawnEnabled do
                SpawnBrainrot()
                task.wait(brainrotSpawnDelay)
            end
        end)
    end
end)

brainrotTab:AddButton("Skibidi Sound Blast", function()
    local s = Instance.new("Sound", workspace)
    s.SoundId = "rbxassetid://18788722327"
    s.Volume = 5
    s:Play()
    s.Ended:Connect(function() s:Destroy() end)
end)

-- Player Features
playerTab:AddButton("Speed (100)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 100
    end
end)

playerTab:AddButton("Jump Power (150)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = 150
    end
end)

local infJump = false
playerTab:AddToggle("Infinite Jump", function(state)
    infJump = state
end)

UserInputService.JumpRequest:Connect(function()
    if infJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

playerTab:AddButton("Teleport to Brainrot (If any)", function()
    for _, v in pairs(workspace:GetChildren()) do
        if v.Name == "Skibidi" or v.Name == "Sigma" or v.Name == "Fanum Tax" then
            LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 5, 0)
            break
        end
    end
end)

-- Blox Fruits Features
local function GetClosestMonster()
    local target = nil
    local distance = math.huge
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
            local mag = (v.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).magnitude
            if mag < distance then
                distance = mag
                target = v
            end
        end
    end
    return target
end

local autoFarmLevel = false
bloxFruitTab:AddToggle("Auto Farm Level", function(state)
    autoFarmLevel = state
    task.spawn(function()
        while autoFarmLevel do
            local enemy = GetClosestMonster()
            if enemy and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                -- Simuler l'attaque (à adapter selon les outils du joueur)
                local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
            end
            task.wait(0.1)
        end
    end)
end)

local autoChest = false
bloxFruitTab:AddToggle("Auto Farm Chests", function(state)
    autoChest = state
    task.spawn(function()
        while autoChest do
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name:find("Chest") and v:IsA("BasePart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                    task.wait(0.2)
                    if not autoChest then break end
                end
            end
            task.wait(1)
        end
    end)
end)

bloxFruitTab:AddButton("Teleport to Cafe (Second Sea)", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1134, 18, -446)
end)

bloxFruitTab:AddButton("Teleport to Mansion (Third Sea)", function()
    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-12463, 375, -7560)
end)

-- Visual Features
visualTab:AddToggle("Fullbright", function(state)
    if state then
        game:GetService("Lighting").Brightness = 2
        game:GetService("Lighting").ClockTime = 14
        game:GetService("Lighting").FogEnd = 100000
        game:GetService("Lighting").GlobalShadows = false
    else
        game:GetService("Lighting").Brightness = 1
        game:GetService("Lighting").GlobalShadows = true
    end
end)

visualTab:AddButton("Remove Fog", function()
    game:GetService("Lighting").FogEnd = 100000
end)

-- Notification
print("GRF Panel V2 Loaded!")

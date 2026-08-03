--[[
    BRAINROT LAG PANEL V2 - THE SIGMA EDITION
    Style: Brainrot (Skibidi, Sigma, Ohio)
    Features: Lag Switch, Ping Spiker, Duel Mode, Server Lag (Steal a Brainrot Edition)
    Everything Fixed & Optimized by Manus
]]

local cloneref = cloneref or function(object) return object end
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local LP = Players.LocalPlayer

-- Global State
getgenv().BrainrotLag = getgenv().BrainrotLag or {
    Enabled = true,
    LagSwitch = false,
    PingSpiker = false,
    ServerLag = false,
    PaintballCrash = false,
    LaserSpam = false,
    LagIntensity = 500000,
    SpamIntensity = 10,
    ServerLagIntensity = 25,
    DuelMode = false,
    Keybind = Enum.KeyCode.X
}

local State = getgenv().BrainrotLag

-- Cleanup old UI
if CoreGui:FindFirstChild("BrainrotPanel") then
    CoreGui.BrainrotPanel:Destroy()
end

-- UI Library (Embedded Brainrot Style)
local function CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BrainrotPanel"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -125, 0.5, -175)
    Main.Size = UDim2.new(0, 250, 0, 350)
    Main.Active = true
    Main.Draggable = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Main

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2
    UIStroke.Color = Color3.fromRGB(255, 0, 255)
    UIStroke.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "SIGMA LAG HUB 💀"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
    })
    UIGradient.Parent = Title

    local TabButtons = Instance.new("Frame")
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = Main
    TabButtons.BackgroundTransparency = 1
    TabButtons.Position = UDim2.new(0, 5, 0, 40)
    TabButtons.Size = UDim2.new(1, -10, 0, 30)
    
    local UIListTabs = Instance.new("UIListLayout")
    UIListTabs.Parent = TabButtons
    UIListTabs.FillDirection = Enum.FillDirection.Horizontal
    UIListTabs.Padding = UDim.new(0, 5)

    local Content = Instance.new("ScrollingFrame")
    Content.Name = "Content"
    Content.Parent = Main
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0, 5, 0, 75)
    Content.Size = UDim2.new(1, -10, 1, -110)
    Content.ScrollBarThickness = 2
    Content.CanvasSize = UDim2.new(0, 0, 0, 500)

    local UIList = Instance.new("UIListLayout")
    UIList.Parent = Content
    UIList.Padding = UDim.new(0, 5)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function CreateToggle(text, property, callback)
        local Button = Instance.new("TextButton")
        Button.Name = text
        Button.Parent = Content
        Button.Size = UDim2.new(0.95, 0, 0, 35)
        Button.BackgroundColor3 = State[property] and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(40, 40, 40)
        Button.Font = Enum.Font.Gotham
        Button.Text = text .. (State[property] and " [ON]" or " [OFF]")
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 12
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 6)
        Corner.Parent = Button

        Button.MouseButton1Click:Connect(function()
            State[property] = not State[property]
            Button.BackgroundColor3 = State[property] and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(40, 40, 40)
            Button.Text = text .. (State[property] and " [ON]" or " [OFF]")
            if callback then callback(State[property]) end
        end)
    end

    local function CreateSlider(text, min, max, property)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0.95, 0, 0, 50)
        Frame.BackgroundTransparency = 1
        Frame.Parent = Content

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 20)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.Gotham
        Label.Text = text .. ": " .. State[property]
        Label.TextColor3 = Color3.fromRGB(200, 200, 200)
        Label.TextSize = 10
        Label.Parent = Frame

        local SliderBack = Instance.new("Frame")
        SliderBack.Size = UDim2.new(1, 0, 0, 10)
        SliderBack.Position = UDim2.new(0, 0, 0, 25)
        SliderBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        SliderBack.Parent = Frame
        
        local SliderMain = Instance.new("Frame")
        SliderMain.Size = UDim2.new((State[property] - min) / (max - min), 0, 1, 0)
        SliderMain.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
        SliderMain.BorderSizePixel = 0
        SliderMain.Parent = SliderBack

        local function UpdateSlider(input)
            local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
            State[property] = math.floor(min + (max - min) * pos)
            SliderMain.Size = UDim2.new(pos, 0, 1, 0)
            Label.Text = text .. ": " .. State[property]
        end

        local dragging = false
        SliderBack.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                UpdateSlider(input)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                UpdateSlider(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    -- Sections
    local function CreateHeader(text)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 25)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.GothamBold
        Label.Text = "--- " .. text .. " ---"
        Label.TextColor3 = Color3.fromRGB(0, 255, 255)
        Label.TextSize = 12
        Label.Parent = Content
    end

    CreateHeader("CLIENT LAG")
    CreateToggle("LAG SWITCH (X)", "LagSwitch")
    CreateToggle("PING SPIKER 📡", "PingSpiker")
    CreateSlider("Lag Intensity", 100000, 2000000, "LagIntensity")
    
    CreateHeader("SERVER LAG (SAB)")
    CreateToggle("VOID LAGGER ⚡", "ServerLag")
    CreateToggle("PAINTBALL CRASH 🔫", "PaintballCrash")
    CreateToggle("LASER SPAM ⚡", "LaserSpam")
    CreateSlider("Server Spam Power", 1, 100, "ServerLagIntensity")
    
    CreateHeader("COMBAT")
    CreateToggle("DUEL MODE ⚔️", "DuelMode")
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0.9, 0, 0, 40)
    Status.BackgroundTransparency = 1
    Status.Font = Enum.Font.GothamItalic
    Status.Text = "Status: Rizzing up the WiFi..."
    Status.TextColor3 = Color3.fromRGB(150, 150, 150)
    Status.TextSize = 10
    Status.Parent = Content
    
    -- Brainrot Effects
    task.spawn(function()
        while ScreenGui.Parent do
            Status.Text = "Status: " .. (State.ServerLag and "DESTROYING SERVER" or (State.LagSwitch and "SKIBIDI LAG ACTIVE" or "Chilling in Ohio"))
            UIStroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            task.wait(0.1)
        end
    end)
end

-- Functionality
-- Client Lag Switch
task.spawn(function()
    while true do
        if State.LagSwitch then
            local start = tick()
            for i = 1, State.LagIntensity do
                -- Busy loop
            end
        end
        task.wait()
    end
end)

-- Ping Spiker (Local)
task.spawn(function()
    while true do
        if State.PingSpiker then
            for i = 1, State.SpamIntensity do
                pcall(function()
                    ReplicatedStorage:FindFirstChildOfClass("RemoteEvent"):FireServer()
                end)
            end
        end
        task.wait(0.05)
    end
end)

-- Server Lag (Steal a Brainrot Optimized)
local function GetSABRemotes()
    local remotes = {}
    -- Common locations in SAB
    local paths = {
        ReplicatedStorage,
        ReplicatedStorage:FindFirstChild("Remotes"),
        ReplicatedStorage:FindFirstChild("Events"),
        ReplicatedStorage:FindFirstChild("RemoteEvents")
    }
    
    for _, path in pairs(paths) do
        if path then
            for _, obj in pairs(path:GetChildren()) do
                if obj:IsA("RemoteEvent") then
                    local name = obj.Name:lower()
                    if name:find("steal") or name:find("hit") or name:find("punch") or name:find("attack") or name:find("npc") or name:find("collect") then
                        table.insert(remotes, obj)
                    end
                end
            end
        end
    end
    return remotes
end

task.spawn(function()
    while true do
        if State.ServerLag then
            local remotes = GetSABRemotes()
            for i = 1, State.ServerLagIntensity do
                for _, remote in pairs(remotes) do
                    pcall(function()
                        remote:FireServer(unpack({})) -- Spam empty or default data
                    end)
                end
            end
        end
        task.wait(0.01)
    end
end)

-- Paintball Crash
task.spawn(function()
    while true do
        if State.PaintballCrash then
            -- Look for paintball remotes
            for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") and (obj.Name:lower():find("paintball") or obj.Name:lower():find("fire")) then
                    for i = 1, State.ServerLagIntensity do
                        pcall(function() obj:FireServer() end)
                    end
                end
            end
        end
        task.wait(0.01)
    end
end)

-- Laser Spam
task.spawn(function()
    while true do
        if State.LaserSpam then
            for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") and obj.Name:lower():find("laser") then
                    for i = 1, State.ServerLagIntensity do
                        pcall(function() obj:FireServer(true) end)
                        pcall(function() obj:FireServer(false) end)
                    end
                end
            end
        end
        task.wait(0.01)
    end
end)

-- Keybind handling
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == State.Keybind then
        State.LagSwitch = not State.LagSwitch
    end
end)

-- Duel Mode Detection
task.spawn(function()
    while true do
        if State.DuelMode and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            local hum = LP.Character.Humanoid
            if hum.Health < hum.MaxHealth * 0.3 then
                State.LagSwitch = true
                task.wait(2)
                State.LagSwitch = false
            end
        end
        task.wait(0.5)
    end
end)

-- Initialize
CreateUI()
print("BRAINROT LAG PANEL V2 LOADED - SERVER DESTROYER READY")

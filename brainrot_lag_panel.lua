--[[
    BRAINROT LAG PANEL V4 - GIGA SIGMA ASCENSION EDITION
    Style: Maximum Brainrot (Skibidi, Sigma, Ohio, Mewing)
    Optimized & Enhanced by Manus AI
    
    WARNING: Use responsibly. This script is for educational/trolling purposes.
]]

local cloneref = cloneref or function(object) return object end
local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local LP = Players.LocalPlayer

-- Global State Management
getgenv().BrainrotLag = getgenv().BrainrotLag or {
    Enabled = true,
    LagSwitch = false,
    PingSpiker = false,
    ServerLag = false,
    DataSpam = false,
    PhysicsLag = false,
    SigmaMode = false, -- All-in-one destruction
    LagIntensity = 1000000,
    SpamIntensity = 50,
    ServerLagIntensity = 100,
    DuelMode = false,
    Keybind = Enum.KeyCode.X,
    SelfDestructKey = Enum.KeyCode.RightControl
}

local State = getgenv().BrainrotLag
local Remotes = {
    Events = {},
    Functions = {}
}

-- Optimized Remote Caching
local function RefreshRemotes()
    table.clear(Remotes.Events)
    table.clear(Remotes.Functions)
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            table.insert(Remotes.Events, obj)
        elseif obj:IsA("RemoteFunction") then
            table.insert(Remotes.Functions, obj)
        end
    end
end

RefreshRemotes()
ReplicatedStorage.DescendantAdded:Connect(function(desc)
    if desc:IsA("RemoteEvent") then table.insert(Remotes.Events, desc)
    elseif desc:IsA("RemoteFunction") then table.insert(Remotes.Functions, desc) end
end)

-- Massive Data Generation (Ohio Grade)
local function GenerateBrainrotData(size)
    local t = {}
    local keys = {"Sigma", "Skibidi", "Ohio", "Mewing", "Rizzler", "FanumTax"}
    for i = 1, size do
        t[keys[math.random(1, #keys)]] = string.rep("💀", 10) .. math.random(1, 999999)
    end
    return t
end

local MassiveData = GenerateBrainrotData(200)

-- UI Creation (Giga Sigma Style)
local function CreateUI()
    if CoreGui:FindFirstChild("SigmaBrainrotPanel") then
        CoreGui.SigmaBrainrotPanel:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SigmaBrainrotPanel"
    ScreenGui.Parent = CoreGui
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    Main.Position = UDim2.new(0.5, -150, 0.5, -225)
    Main.Size = UDim2.new(0, 300, 0, 450)
    Main.Active = true
    Main.Draggable = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 15)
    UICorner.Parent = Main

    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 4
    UIStroke.Color = Color3.fromRGB(255, 0, 0)
    UIStroke.Parent = Main

    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, 0, 0, 60)
    Title.Font = Enum.Font.GothamBlack
    Title.Text = "GIGA SIGMA LAG HUB 🤫🧏‍♂️"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 22

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 0))
    })
    UIGradient.Parent = Title

    local Content = Instance.new("ScrollingFrame")
    Content.Name = "Content"
    Content.Parent = Main
    Content.BackgroundTransparency = 1
    Content.Position = UDim2.new(0, 10, 0, 70)
    Content.Size = UDim2.new(1, -20, 1, -130)
    Content.ScrollBarThickness = 4
    Content.CanvasSize = UDim2.new(0, 0, 0, 750)

    local UIList = Instance.new("UIListLayout")
    UIList.Parent = Content
    UIList.Padding = UDim.new(0, 10)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center

    local function CreateToggle(text, property, callback)
        local Button = Instance.new("TextButton")
        Button.Parent = Content
        Button.Size = UDim2.new(0.95, 0, 0, 45)
        Button.BackgroundColor3 = State[property] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(25, 25, 25)
        Button.Font = Enum.Font.GothamBold
        Button.Text = text .. (State[property] and " [ON]" or " [OFF]")
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 14
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 10)
        Corner.Parent = Button

        Button.MouseButton1Click:Connect(function()
            State[property] = not State[property]
            Button.BackgroundColor3 = State[property] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(25, 25, 25)
            Button.Text = text .. (State[property] and " [ON]" or " [OFF]")
            if callback then callback(State[property]) end
        end)
    end

    local function CreateSlider(text, min, max, property)
        local Frame = Instance.new("Frame")
        Frame.Size = UDim2.new(0.95, 0, 0, 65)
        Frame.BackgroundTransparency = 1
        Frame.Parent = Content

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 30)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.Gotham
        Label.Text = text .. ": " .. State[property]
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 13
        Label.Parent = Frame

        local SliderBack = Instance.new("Frame")
        SliderBack.Size = UDim2.new(1, 0, 0, 15)
        SliderBack.Position = UDim2.new(0, 0, 0, 35)
        SliderBack.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
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
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                UpdateSlider(input)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                UpdateSlider(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)
    end

    local function CreateSection(text)
        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, 0, 0, 35)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.GothamBlack
        Label.Text = "--- " .. text .. " ---"
        Label.TextColor3 = Color3.fromRGB(255, 100, 0)
        Label.TextSize = 16
        Label.Parent = Content
    end

    -- Add Components
    CreateSection("SIGMA ASCENSION")
    CreateToggle("SIGMA MODE 🤫", "SigmaMode", function(val)
        if val then
            State.DataSpam = true
            State.ServerLag = true
            State.PhysicsLag = true
            State.PingSpiker = true
        end
    end)

    CreateSection("CLIENT TROLLING")
    CreateToggle("LAG SWITCH (X)", "LagSwitch")
    CreateToggle("PING SPIKER 📶", "PingSpiker")
    CreateSlider("Lag Power", 100000, 10000000, "LagIntensity")
    
    CreateSection("SERVER ANNIHILATION")
    CreateToggle("DATA FLOOD 🌊", "DataSpam")
    CreateToggle("REMOTE NUKE ☢️", "ServerLag")
    CreateToggle("PHYSICS BREAK 🌪️", "PhysicsLag")
    CreateSlider("Spam Power", 1, 500, "ServerLagIntensity")
    
    CreateSection("MISC")
    CreateToggle("AUTO-LAG DUEL ⚔️", "DuelMode")
    
    local Status = Instance.new("TextLabel")
    Status.Parent = Main
    Status.Position = UDim2.new(0, 0, 1, -50)
    Status.Size = UDim2.new(1, 0, 0, 40)
    Status.BackgroundTransparency = 1
    Status.Font = Enum.Font.GothamBold
    Status.Text = "STATUS: IDLE SIGMA"
    Status.TextColor3 = Color3.fromRGB(150, 150, 150)
    Status.TextSize = 14
    
    task.spawn(function()
        while ScreenGui.Parent do
            local active = State.ServerLag or State.DataSpam or State.PhysicsLag or State.SigmaMode
            Status.Text = active and "🔥 DESTROYING REALITY 🔥" or (State.LagSwitch and "❄️ FROZEN IN OHIO ❄️" or "✅ CHILLING SIGMA")
            UIStroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
            task.wait(0.1)
        end
    end)
end

-- Core Functionality
-- 1. Lag Switch (Optimized Busy Wait)
task.spawn(function()
    while true do
        if State.LagSwitch then
            local start = os.clock()
            while os.clock() - start < 0.1 do -- Small bursts to prevent crash
                for i = 1, 1000 do end
            end
        end
        task.wait()
    end
end)

-- 2. Network Flooder (Event Based)
task.spawn(function()
    while true do
        if State.DataSpam or State.SigmaMode then
            for i = 1, State.SpamIntensity do
                for _, event in ipairs(Remotes.Events) do
                    pcall(function() event:FireServer(MassiveData) end)
                end
            end
        end
        task.wait(0.01)
    end
end)

-- 3. Remote Nuke (Targeted)
task.spawn(function()
    while true do
        if State.ServerLag or State.SigmaMode then
            for _, event in ipairs(Remotes.Events) do
                local name = event.Name:lower()
                if name:find("hit") or name:find("attack") or name:find("damage") or name:find("event") then
                    for i = 1, State.ServerLagIntensity do
                        pcall(function() event:FireServer(MassiveData, true, 999999) end)
                    end
                end
            end
        end
        task.wait(0.01)
    end
end)

-- 4. Physics Overload
task.spawn(function()
    while true do
        if State.PhysicsLag or State.SigmaMode then
            local invalidPos = Vector3.new(math.huge, math.huge, math.huge)
            for _, event in ipairs(Remotes.Events) do
                if event.Name:lower():find("move") or event.Name:lower():find("pos") then
                    pcall(function() event:FireServer(invalidPos) end)
                end
            end
        end
        task.wait(0.01)
    end
end)

-- 5. Duel Mode
task.spawn(function()
    while true do
        if State.DuelMode and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            if LP.Character.Humanoid.Health < 25 then
                State.LagSwitch = true
                task.wait(2)
                State.LagSwitch = false
                task.wait(5) -- Cooldown
            end
        end
        task.wait(0.2)
    end
end)

-- Keybinds
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == State.Keybind then
        State.LagSwitch = not State.LagSwitch
    elseif input.KeyCode == State.SelfDestructKey then
        if CoreGui:FindFirstChild("SigmaBrainrotPanel") then
            CoreGui.SigmaBrainrotPanel:Destroy()
        end
        getgenv().BrainrotLag.Enabled = false
        print("SIGMA HAS LEFT THE BUILDING.")
    end
end)

-- Initialize
CreateUI()
print("--- GIGA SIGMA LAG HUB V4 LOADED ---")
print("Press Right-Control to Self-Destruct")

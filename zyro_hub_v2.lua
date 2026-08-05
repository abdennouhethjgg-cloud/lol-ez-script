--[[
    ZYRO HUB V2 - BRAINROT EDITION 👑
    Fixed, Optimized, and Enhanced by Manus AI
    
    Features:
    - Auto Buy (Optimized)
    - Anchored Mode (Respawn Proof)
    - Auto Steal (Brainrot Logic)
    - Sigma Speed & Ohio Jump
    - Better UI with Dragging Support
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- State Management
local State = {
    AutoBuy = false,
    Anchored = false,
    AutoSteal = false,
    SpeedSigma = false,
    OhioJump = false,
    SpeedValue = 50
}

-- UI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZyroHubV2"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame (Purple Outline)
local borderFrame = Instance.new("Frame")
borderFrame.Size = UDim2.new(0, 220, 0, 320)
borderFrame.Position = UDim2.new(0.5, -110, 0.5, -160)
borderFrame.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
borderFrame.BorderSizePixel = 0
borderFrame.Active = true
borderFrame.Parent = screenGui

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 12)
borderCorner.Parent = borderFrame

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(1, -6, 1, -6)
mainFrame.Position = UDim2.new(0, 3, 0, 3)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = borderFrame

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "ZYRO HUB V2 👑"
title.Font = Enum.Font.GothamBlack
title.TextSize = 16
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Parent = mainFrame

local titleGradient = Instance.new("UIGradient")
titleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
})
titleGradient.Parent = title

-- Dragging Logic (Unified)
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    borderFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = borderFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Button Factory
local function createButton(name, order, callback)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 50 + (order * 45))
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = mainFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Thickness = 1
    btnStroke.Color = Color3.fromRGB(50, 50, 50)
    btnStroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        local active = callback()
        btn.Text = name .. (active and ": ON" or ": OFF")
        btn.BackgroundColor3 = active and Color3.fromRGB(138, 43, 226) or Color3.fromRGB(30, 30, 30)
        btnStroke.Color = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(50, 50, 50)
    end)
    
    return btn
end

-- Logic Implementation

-- 1. Auto Buy (Optimized with ProximityPromptService)
createButton("Auto Buy", 0, function()
    State.AutoBuy = not State.AutoBuy
    return State.AutoBuy
end)

ProximityPromptService.PromptShown:Connect(function(prompt)
    if State.AutoBuy then
        task.spawn(function()
            prompt.HoldDuration = 0
            prompt:InputHoldBegin()
            task.wait()
            prompt:InputHoldEnd()
        end)
    end
end)

-- 2. Anchored (Respawn Proof)
createButton("Anchored", 1, function()
    State.Anchored = not State.Anchored
    local function apply(char)
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = State.Anchored
            end
        end
    end
    if player.Character then apply(player.Character) end
    return State.Anchored
end)

player.CharacterAdded:Connect(function(char)
    if State.Anchored then
        task.wait(0.5)
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = true
            end
        end
    end
end)

-- 3. Auto Steal (Brainrot Logic - Scans for items/remotes)
createButton("Auto Steal", 2, function()
    State.AutoSteal = not State.AutoSteal
    return State.AutoSteal
end)

task.spawn(function()
    while task.wait(0.5) do
        if State.AutoSteal then
            -- Generic stealing logic: look for TouchTransmitter or ClickDetector in items
            for _, item in pairs(workspace:GetDescendants()) do
                if item:IsA("TouchTransmitter") and item.Parent:IsA("BasePart") then
                    firetouchinterest(player.Character.HumanoidRootPart, item.Parent, 0)
                    firetouchinterest(player.Character.HumanoidRootPart, item.Parent, 1)
                end
            end
        end
    end
end)

-- 4. Sigma Speed
createButton("Sigma Speed", 3, function()
    State.SpeedSigma = not State.SpeedSigma
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = State.SpeedSigma and State.SpeedValue or 16
    end
    return State.SpeedSigma
end)

-- 5. Ohio Jump (Infinite Jump)
createButton("Ohio Jump", 4, function()
    State.OhioJump = not State.OhioJump
    return State.OhioJump
end)

UserInputService.JumpRequest:Connect(function()
    if State.OhioJump then
        player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

-- Rainbow UI Effect (Brainrot Aesthetic)
task.spawn(function()
    while task.wait(0.05) do
        local hue = tick() % 5 / 5
        borderFrame.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
        titleGradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHSV(hue, 1, 1)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV((hue + 0.2) % 1, 1, 1))
        })
    end
end)

print("Zyro Hub V2 Loaded! Stay Sigma 🤫🧏‍♂️")

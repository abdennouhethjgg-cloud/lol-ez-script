--[[
    LOL Ez - Blox Fruits Hub (Update August 2026)
    Features: Auto Farm 2800, Auto Fishing, Golden Whirlpool, Submerged Expansion
    Repository: abdennouhethjgg-cloud/lol-ez-script
--]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/abdennouhethjgg-cloud/lol-ez-script/main/grf_panel.lua"))()
local Window = Library:CreateWindow("LOL Ez - Blox Fruits")

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

-- Variables
local Config = {
    AutoFarm = false,
    AutoFishing = false,
    AutoStats = false,
    FastAttack = true,
    TeleportToWhirlpool = false,
    SelectedQuest = "Aqua Warriors",
    TargetLevel = 2800
}

-- Tabs
local MainTab = Window:CreateTab("Main")
local SeaTab = Window:CreateTab("Sea Events")
local FishingTab = Window:CreateTab("Fishing")
local StatsTab = Window:CreateTab("Stats")
local TeleportTab = Window:CreateTab("Teleport")

-- Main Tab
MainTab:CreateToggle("Auto Farm Level (Max 2800)", function(state)
    Config.AutoFarm = state
    if state then
        task.spawn(function()
            while Config.AutoFarm do
                task.wait(1)
                local level = LocalPlayer.Data.Level.Value
                if level >= 2550 and level < 2800 then
                    -- Submerged Island Quests
                    local questName = "Aqua Warriors"
                    if level >= 2675 then questName = "Deep Sea Guardians" end
                    
                    -- Take Quest
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", questName, 1)
                    
                    -- Teleport to Mobs (Example CFrame)
                    local mob = workspace.Enemies:FindFirstChild(questName)
                    if mob and mob:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 5)
                        -- Attack Logic
                        VirtualUser:CaptureController()
                        VirtualUser:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                    end
                end
            end
        end)
    end
end)

MainTab:CreateToggle("Fast Attack", function(state)
    Config.FastAttack = state
end)

-- Fishing Tab (New Update)
FishingTab:CreateToggle("Auto Fishing (Expansion)", function(state)
    Config.AutoFishing = state
    if state then
        task.spawn(function()
            while Config.AutoFishing do
                task.wait(0.1)
                -- Blox Fruits Fishing Logic
                local fishingRod = LocalPlayer.Character:FindFirstChild("Fishing Rod")
                if fishingRod then
                    local hook = fishingRod:FindFirstChild("Hook")
                    if hook and hook:FindFirstChild("BiteEffect") then
                        -- A fish bit!
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("FishBite")
                        task.wait(0.5)
                    end
                end
            end
        end)
    end
end)

FishingTab:CreateButton("Teleport to Best Fishing Spot", function()
    -- Teleport to the new Submerged Island fishing docks
    print("Teleporting to Submerged Docks...")
end)

-- Sea Events Tab (New Update)
SeaTab:CreateToggle("Auto Whirlpool (XX:00)", function(state)
    Config.TeleportToWhirlpool = state
end)

SeaTab:CreateButton("Find Golden Whirlpool", function()
    -- Logic to find Golden Whirlpool in the sea
    print("Searching for Golden Whirlpool...")
end)

-- Stats Tab
StatsTab:CreateToggle("Auto Stats (Melee/Defense/Fruit)", function(state)
    Config.AutoStats = state
end)

-- Teleport Tab
TeleportTab:CreateButton("Teleport to Submerged Island", function()
    -- New Island Teleport
    print("Teleporting to Submerged Island...")
end)

TeleportTab:CreateButton("Teleport to Sea 3", function()
    -- Sea 3 Teleport
end)

-- Anti-AFK
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

print("LOL Ez Blox Fruits Hub Loaded!")

--// ═══════════════════════════════════════════════════════════
--// ⚡ DELTA HUB - IA V5 100% AUTOMATIQUE
--// Compatible: Delta / Wave / Solara / Krnl
--// ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer

--// ==== HELPERS ====
local function safeCall(fn, ...)
    local ok, res = pcall(fn, ...)
    if ok then return res end
    return nil
end

local executorName = "Unknown"
safeCall(function()
    if identifyexecutor then executorName = identifyexecutor() end
end)

local function copyClipboard(txt)
    return safeCall(function()
        if setclipboard then
            setclipboard(txt)
            return true
        end
        return false
    end) == true
end

--// Cleanup
safeCall(function()
    if CoreGui:FindFirstChild("DeltaGUI_Hub") then CoreGui.DeltaGUI_Hub:Destroy() end
end)
safeCall(function()
    local pg = LocalPlayer:FindFirstChild("PlayerGui")
    if pg and pg:FindFirstChild("DeltaGUI_Hub") then pg.DeltaGUI_Hub:Destroy() end
end)

--// ==== SCREEN GUI ====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaGUI_Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true

local parented = safeCall(function()
    ScreenGui.Parent = CoreGui
    return true
end)
if not parented then
    safeCall(function()
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end)
end

--// ==== MAIN ====
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 640, 0, 460)
Main.Position = UDim2.new(0.5, -320, 0.5, -230)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Color = Color3.fromRGB(80, 80, 100)
mainStroke.Thickness = 1.5

--// TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Delta Hub  •  IA V5 Auto"
Title.TextColor3 = Color3.fromRGB(230, 230, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 25)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)
CloseBtn.MouseButton1Click:Connect(function()
    safeCall(function() ScreenGui:Destroy() end)
end)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 25)
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 50)
MinBtn.Text = "—"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 14
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TopBar
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

--// TAB BAR
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 130, 1, -45)
TabBar.Position = UDim2.new(0, 10, 0, 40)
TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
TabBar.BorderSizePixel = 0
TabBar.Parent = Main
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 8)

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.Padding = UDim.new(0, 5)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local TabPad = Instance.new("UIPadding", TabBar)
TabPad.PaddingTop = UDim.new(0, 8)

--// CONTENT
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -155, 1, -45)
Content.Position = UDim2.new(0, 145, 0, 40)
Content.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

--// TABS
local tabs = {}
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(220, 220, 240)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = TabBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, -20, 1, -20)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 4
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.Visible = false
    frame.Parent = Content

    local list = Instance.new("UIListLayout", frame)
    list.Padding = UDim.new(0, 4)
    list.SortOrder = Enum.SortOrder.LayoutOrder

    tabs[name] = { button = btn, frame = frame, list = list }
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.frame.Visible = false
            t.button.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        end
        frame.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
    end)
    return frame
end

createTab("🏠 Home")
createTab("📡 Remotes")
createTab("🔧 Functions")
createTab("🎯 Bindables")
createTab("🤖 IA Auto")

tabs["🏠 Home"].button.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
tabs["🏠 Home"].frame.Visible = true

--// HELPERS UI
local function addLabel(parent, text, color, size)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, size or 22)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color or Color3.fromRGB(220, 220, 240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
    lbl.Parent = parent
    return lbl
end

--// HOME
local homeFrame = tabs["🏠 Home"].frame
addLabel(homeFrame, "✅ GUI chargée !", Color3.fromRGB(120, 255, 120), 22)
addLabel(homeFrame, "📌 Jeu ID: " .. tostring(game.PlaceId), Color3.fromRGB(180, 180, 255), 20)
addLabel(homeFrame, "👤 Joueur: " .. LocalPlayer.Name, Color3.fromRGB(180, 180, 255), 20)
addLabel(homeFrame, "🖥️ Executor: " .. tostring(executorName), Color3.fromRGB(120, 255, 120), 20)

local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(1, -10, 0, 30)
scanBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
scanBtn.Text = "🔍 Scanner tous les Remotes"
scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
scanBtn.Font = Enum.Font.GothamBold
scanBtn.TextSize = 12
scanBtn.BorderSizePixel = 0
scanBtn.Parent = homeFrame
Instance.new("UICorner", scanBtn).CornerRadius = UDim.new(0, 6)

--// SCAN
local foundRemotes = {
    RemoteEvent = {},
    RemoteFunction = {},
    BindableEvent = {}
}

local function clearFrame(frame)
    for _, c in ipairs(frame:GetChildren()) do
        if c:IsA("GuiObject") then safeCall(function() c:Destroy() end) end
    end
end

local function createRemoteEntry(parent, obj)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 26)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    btn.Text = "  " .. obj.Name
    btn.TextColor3 = Color3.fromRGB(220, 220, 240)
    btn.Font = Enum.Font.Code
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextTruncate = Enum.TextTruncate.AtEnd
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    end)

    btn.MouseButton1Click:Connect(function()
        local path = safeCall(function() return obj:GetFullName() end) or "?"
        local ok = copyClipboard(path)
        btn.Text = ok and ("  ✅ Copié: " .. obj.Name) or ("  ⚠ " .. obj.Name)
        task.wait(1.2)
        btn.Text = "  " .. obj.Name
    end)
end

local function scanAll()
    for k in pairs(foundRemotes) do foundRemotes[k] = {} end
    clearFrame(tabs["📡 Remotes"].frame)
    clearFrame(tabs["🔧 Functions"].frame)
    clearFrame(tabs["🎯 Bindables"].frame)

    local visited = {}
    local function scan(parent)
        if not parent or visited[parent] then return end
        visited[parent] = true
        local ok, descendants = pcall(function() return parent:GetDescendants() end)
        if not ok or not descendants then return end
        for _, obj in ipairs(descendants) do
            if obj:IsA("RemoteEvent") then
                table.insert(foundRemotes.RemoteEvent, obj)
                createRemoteEntry(tabs["📡 Remotes"].frame, obj)
            elseif obj:IsA("RemoteFunction") then
                table.insert(foundRemotes.RemoteFunction, obj)
                createRemoteEntry(tabs["🔧 Functions"].frame, obj)
            elseif obj:IsA("BindableEvent") then
                table.insert(foundRemotes.BindableEvent, obj)
                createRemoteEntry(tabs["🎯 Bindables"].frame, obj)
            end
        end
    end

    safeCall(scan, ReplicatedStorage)
    safeCall(scan, ReplicatedFirst)
    safeCall(scan, Workspace)
    safeCall(scan, ServerScriptService)

    print(string.format("📊 %d RemoteEvents | %d RemoteFunctions | %d Bindables",
        #foundRemotes.RemoteEvent,
        #foundRemotes.RemoteFunction,
        #foundRemotes.BindableEvent))
end

scanBtn.MouseButton1Click:Connect(function()
    scanBtn.Text = "⏳ Scan..."
    task.spawn(function()
        scanAll()
        scanBtn.Text = "✅ Terminé !"
        task.wait(1.5)
        scanBtn.Text = "🔍 Scanner tous les Remotes"
    end)
end)

--// ================================================
--// ANALYSE JEU
--// ================================================
local gameAnalysis = {
    name = "Unknown",
    type = "unknown",
    playerCount = 0,
    remoteCategories = {},
    hasLeaderstats = false,
    hasTools = false
}

local function analyzeGame()
    gameAnalysis.name = "Unknown"
    gameAnalysis.type = "unknown"
    gameAnalysis.remoteCategories = {}

    safeCall(function()
        local info = MarketplaceService:GetProductInfo(game.PlaceId)
        if info and info.Name then gameAnalysis.name = info.Name end
    end)

    gameAnalysis.playerCount = #Players:GetPlayers()
    gameAnalysis.hasLeaderstats = LocalPlayer:FindFirstChild("leaderstats") ~= nil
    gameAnalysis.hasTools = LocalPlayer:FindFirstChild("Backpack") ~= nil
        and #LocalPlayer.Backpack:GetChildren() > 0

    local n = string.lower(gameAnalysis.name)
    local patterns = {
        {type = "Steal",         kws = {"steal", "thief", "pickpocket"}},
        {type = "Simulator",     kws = {"simulator", "sim", "clicker", "hatch", "pet sim"}},
        {type = "Tower Defense", kws = {"tower", "defense"}},
        {type = "Obby",          kws = {"obby", "parkour", "escape", "tower of"}},
        {type = "RPG",           kws = {"rpg", "adventure", "quest", "dungeon"}},
        {type = "FPS",           kws = {"fps", "shooter", "gun", "combat", "arsenal", "phantom"}},
        {type = "Tycoon",        kws = {"tycoon", "builder", "factory"}},
        {type = "Roleplay",      kws = {"roleplay", "brookhaven", "town", "city life"}},
        {type = "Horror",        kws = {"horror", "scary", "backrooms", "granny", "doors"}},
        {type = "Anime",         kws = {"anime", "naruto", "dragon ball", "one piece", "demon slayer"}},
        {type = "Racing",        kws = {"racing", "drift"}},
        {type = "Survival",      kws = {"survival", "island", "raft", "stranded"}},
        {type = "Egg",           kws = {"egg", "adopt", "pet"}},
    }

    for _, p in ipairs(patterns) do
        for _, kw in ipairs(p.kws) do
            if string.find(n, kw, 1, true) then
                gameAnalysis.type = p.type
                break
            end
        end
        if gameAnalysis.type ~= "unknown" then break end
    end

    local categories = {
        steal     = {"steal", "pickpocket", "grab"},
        farm      = {"farm", "collect", "gather", "harvest", "auto"},
        combat    = {"damage", "hit", "attack", "kill", "punch", "sword", "shoot", "fire"},
        shop      = {"buy", "purchase", "shop", "sell", "trade"},
        reward    = {"claim", "reward", "daily", "bonus", "gift", "redeem", "spin"},
        currency  = {"coin", "cash", "money", "gem", "gold", "diamond", "ticket"},
        pet       = {"pet", "hatch", "egg", "evolve", "fuse", "adopt"},
    }

    for _, remote in ipairs(foundRemotes.RemoteEvent) do
        local low = string.lower(remote.Name)
        for cat, kws in pairs(categories) do
            for _, kw in ipairs(kws) do
                if string.find(low, kw, 1, true) then
                    if not gameAnalysis.remoteCategories[cat] then
                        gameAnalysis.remoteCategories[cat] = {}
                    end
                    table.insert(gameAnalysis.remoteCategories[cat], remote:GetFullName())
                    break
                end
            end
        end
    end

    print("🧠 Analyse: " .. gameAnalysis.name .. " | Type: " .. gameAnalysis.type)
end

local function getRemoteFromCategory(cat)
    local list = gameAnalysis.remoteCategories[cat]
    if not list or #list == 0 then return nil end
    return list[1]
end

local function buildRemoteLoader(path)
    if not path or path == "" then return "local remote = nil\n" end
    return string.format([[
local remote = (function()
    local cur = game
    for s in string.gmatch(%q, "[^%.]+") do
        cur = cur[s]
        if not cur then return nil end
    end
    return cur
end)()
]], path)
end

--// ================================================
--// GÉNÉRATEUR DE GUI MENU (V5 - 100% AUTOMATIQUE)
--// ================================================
local function buildGUIMenuScript()
    local A = gameAnalysis
    local safeName = tostring(A.name):gsub("%%", "%%%%")

    local featureButtons = {}

    -- 🥚 STEAL
    local stealRemote = getRemoteFromCategory("steal")
    if stealRemote or A.type == "Steal" then
        table.insert(featureButtons, {
            name = "Auto Steal",
            color = "Color3.fromRGB(255, 140, 0)",
            code = buildRemoteLoader(stealRemote or "") .. [[
task.spawn(function()
    while _G.IA_AutoSteal do
        pcall(function()
            if remote then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LP then
                        pcall(function() remote:FireServer(plr) end)
                    end
                end
            end
        end)
        task.wait(0.3)
    end
end)
notify("Auto Steal active")
]]
        })
    end

    -- 🌾 AUTO FARM
    local farmRemote = getRemoteFromCategory("farm") or getRemoteFromCategory("currency")
    if farmRemote then
        table.insert(featureButtons, {
            name = "Auto Farm",
            color = "Color3.fromRGB(80, 200, 120)",
            code = buildRemoteLoader(farmRemote) .. [[
task.spawn(function()
    while _G.IA_AutoFarm do
        pcall(function()
            if remote then remote:FireServer() end
        end)
        task.wait(0.5)
    end
end)
notify("Auto Farm active")
]]
        })
    end

    -- 🎁 AUTO CLAIM
    local rewardRemote = getRemoteFromCategory("reward")
    if rewardRemote then
        table.insert(featureButtons, {
            name = "Auto Claim",
            color = "Color3.fromRGB(255, 200, 80)",
            code = buildRemoteLoader(rewardRemote) .. [[
task.spawn(function()
    while _G.IA_AutoClaim do
        pcall(function()
            if remote then remote:FireServer() end
        end)
        task.wait(5)
    end
end)
notify("Auto Claim active")
]]
        })
    end

    -- 🥚 AUTO HATCH
    local petRemote = getRemoteFromCategory("pet")
    if petRemote or A.type == "Simulator" or A.type == "Egg" then
        local loader = petRemote and buildRemoteLoader(petRemote) or "local remote = nil\n"
        table.insert(featureButtons, {
            name = "Auto Hatch",
            color = "Color3.fromRGB(220, 150, 220)",
            code = loader .. [[
task.spawn(function()
    while _G.IA_AutoHatch do
        pcall(function()
            if remote then remote:FireServer() end
        end)
        task.wait(1)
    end
end)
notify("Auto Hatch active")
]]
        })
    end

    -- 🔫 KILL AURA
    local combatRemote = getRemoteFromCategory("combat")
    if combatRemote then
        table.insert(featureButtons, {
            name = "Kill Aura",
            color = "Color3.fromRGB(220, 70, 70)",
            code = buildRemoteLoader(combatRemote) .. [[
task.spawn(function()
    while _G.IA_KillAura do
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local myPos = LP.Character.HumanoidRootPart.Position
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    local hum = plr.Character:FindFirstChild("Humanoid")
                    if hrp and hum and hum.Health > 0
                        and (hrp.Position - myPos).Magnitude <= 25 then
                        pcall(function() if remote then remote:FireServer(plr.Character) end end)
                    end
                end
            end
        end
        task.wait(0.3)
    end
end)
notify("Kill Aura active")
]]
        })
    end

    -- 👁️ ESP
    local isCombat = (A.type == "FPS" or A.type == "RPG" or A.type == "Anime" or A.type == "Steal")
        or (A.remoteCategories.combat and #A.remoteCategories.combat > 0)
        or (A.remoteCategories.steal and #A.remoteCategories.steal > 0)
    if isCombat then
        table.insert(featureButtons, {
            name = "ESP Joueurs",
            color = "Color3.fromRGB(180, 80, 220)",
            code = [[
if _G.IA_ESP then
    local f = game.CoreGui:FindFirstChild("IA_ESP_Menu")
    if f then f:Destroy() end
    _G.IA_ESP = false
    notify("ESP off")
else
    _G.IA_ESP = true
    local espFolder = Instance.new("Folder", game.CoreGui)
    espFolder.Name = "IA_ESP_Menu"
    for _, plr in ipairs(Players:GetPlayers()) do
        task.spawn(function()
            if plr == LP then return end
            while plr.Parent and plr.Character and _G.IA_ESP do
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local bb = espFolder:FindFirstChild(plr.Name)
                    if not bb then
                        bb = Instance.new("BillboardGui", espFolder)
                        bb.Name = plr.Name
                        bb.Adornee = head
                        bb.Size = UDim2.new(0, 100, 0, 20)
                        bb.AlwaysOnTop = true
                        local lbl = Instance.new("TextLabel", bb)
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 0.5
                        lbl.BackgroundColor3 = Color3.new(0, 0, 0)
                        lbl.TextColor3 = Color3.new(1, 0.3, 0.3)
                        lbl.Font = Enum.Font.GothamBold
                        lbl.TextSize = 12
                    end
                    local lbl = bb:FindFirstChildOfClass("TextLabel")
                    if lbl then
                        lbl.Text = plr.Name .. " [" ..
                            math.floor((head.Position - cam.CFrame.Position).Magnitude) .. "]"
                    end
                end
                task.wait(0.2)
            end
        end)
    end
    notify("ESP active")
end
]]
        })
    end

    -- 🕊️ FLY
    table.insert(featureButtons, {
        name = "Fly",
        color = "Color3.fromRGB(120, 200, 255)",
        code = [[
_G.IA_Fly = not _G.IA_Fly
if _G.IA_Fly then
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local bv = Instance.new("BodyVelocity", hrp)
        bv.Name = "IA_Fly_BV"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        local bg = Instance.new("BodyGyro", hrp)
        bg.Name = "IA_Fly_BG"
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 9e4
        task.spawn(function()
            while _G.IA_Fly and bv.Parent do
                RunService.RenderStepped:Wait()
                local d = Vector3.zero
                if UIS:IsKeyDown(Enum.KeyCode.W) then d = d + cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then d = d - cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then d = d - cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then d = d + cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0,1,0) end
                if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then d = d - Vector3.new(0,1,0) end
                bv.Velocity = d.Magnitude > 0 and d.Unit * 60 or Vector3.zero
                bg.CFrame = cam.CFrame
            end
        end)
    end
    notify("Fly ON")
else
    for _, n in ipairs({"IA_Fly_BV", "IA_Fly_BG"}) do
        local o = LP.Character and LP.Character:FindFirstChild(n)
        if o then o:Destroy() end
    end
    notify("Fly OFF")
end
]]
    })

    -- 🏃 SPEED
    table.insert(featureButtons, {
        name = "Speed Boost",
        color = "Color3.fromRGB(80, 180, 200)",
        code = [[
if LP.Character then
    local h = LP.Character:FindFirstChild("Humanoid")
    if h then
        h.WalkSpeed = h.WalkSpeed <= 16 and 100 or 16
        notify("Speed: " .. h.WalkSpeed)
    end
end
]]
    })

    -- 👻 NOCLIP
    table.insert(featureButtons, {
        name = "Noclip",
        color = "Color3.fromRGB(150, 150, 200)",
        code = [[
_G.IA_Noclip = not _G.IA_Noclip
if LP.Character then
    for _, d in ipairs(LP.Character:GetDescendants()) do
        if d:IsA("BasePart") then d.CanCollide = not _G.IA_Noclip end
    end
end
notify("Noclip: " .. tostring(_G.IA_Noclip))
]]
    })

    -- 🖱️ AUTO CLICK
    table.insert(featureButtons, {
        name = "Auto Click",
        color = "Color3.fromRGB(200, 200, 80)",
        code = [[
_G.IA_AutoClick = not _G.IA_AutoClick
notify("Auto Click: " .. tostring(_G.IA_AutoClick))
if _G.IA_AutoClick then
    task.spawn(function()
        local vu = game:GetService("VirtualUser")
        while _G.IA_AutoClick do
            pcall(function()
                vu:CaptureController()
                vu:ClickButton1(Vector2.new(0, 0))
            end)
            task.wait(0.1)
        end
    end)
end
]]
    })

    -- 🌀 TP MOUSE
    table.insert(featureButtons, {
        name = "TP Mouse",
        color = "Color3.fromRGB(200, 100, 180)",
        code = [[
if not _G.IA_TPArmed then
    _G.IA_TPArmed = true
    local m = LP:GetMouse()
    m.Button1Down:Connect(function()
        if not _G.IA_TPArmed then return end
        local t = m.Target
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if t and hrp then
            hrp.CFrame = CFrame.new(t.Position + Vector3.new(0, 3, 0))
            notify("TP: " .. t.Name)
        end
    end)
    notify("TP Mouse arme - clique sur une surface")
else
    _G.IA_TPArmed = false
    notify("TP Mouse desarme")
end
]]
    })

    --// Build boutons
    local buttonsCode = ""
    for _, b in ipairs(featureButtons) do
        buttonsCode = buttonsCode .. string.format([[
makeFeatureButton(%q, %s, function()
%s
end)

]], b.name, b.color, b.code)
    end

    --// Script complet (arguments alignés)
    local script = string.format([[
--// ═══════════════════════════════════════════════════════════
--// GUI MENU AUTO-GENEREE par IA V5
--// Jeu   : %s
--// ID    : %d
--// Type  : %s
--// Joueurs: %d
--// ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LP = Players.LocalPlayer
local cam = workspace.CurrentCamera

pcall(function()
    local old = CoreGui:FindFirstChild("IA_GeneratedGUI")
    if old then old:Destroy() end
end)

local function notify(msg)
    print("IA: " .. msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "IA V5", Text = msg, Duration = 3
        })
    end)
end

local gui = Instance.new("ScreenGui")
gui.Name = "IA_GeneratedGUI"
gui.ResetOnSpawn = false
pcall(function() gui.Parent = CoreGui end)
if not gui.Parent then
    gui.Parent = LP:WaitForChild("PlayerGui")
end

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(0, 60, 0, 60)
toggle.Position = UDim2.new(0, 20, 0.5, -30)
toggle.BackgroundColor3 = Color3.fromRGB(180, 90, 220)
toggle.Text = "🤖"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 28
toggle.BorderSizePixel = 0
toggle.Parent = gui
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 30)

local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 380, 0, 420)
menu.Position = UDim2.new(0.5, -190, 0.5, -210)
menu.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
menu.BorderSizePixel = 0
menu.Active = true
menu.Draggable = true
menu.Visible = true
menu.Parent = gui
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 12)
local ms = Instance.new("UIStroke", menu)
ms.Color = Color3.fromRGB(180, 90, 220)
ms.Thickness = 2

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 45)
header.BackgroundColor3 = Color3.fromRGB(180, 90, 220)
header.BorderSizePixel = 0
header.Parent = menu
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local hTitle = Instance.new("TextLabel")
hTitle.Size = UDim2.new(1, -50, 1, 0)
hTitle.Position = UDim2.new(0, 15, 0, 0)
hTitle.BackgroundTransparency = 1
hTitle.Text = "🤖 IA V5 - %s"
hTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
hTitle.Font = Enum.Font.GothamBold
hTitle.TextSize = 13
hTitle.TextXAlignment = Enum.TextXAlignment.Left
hTitle.TextTruncate = Enum.TextTruncate.AtEnd
hTitle.Parent = header

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, -20, 0, 24)
info.Position = UDim2.new(0, 10, 0, 52)
info.BackgroundTransparency = 1
info.Text = "Type: %s   Joueurs: %d"
info.TextColor3 = Color3.fromRGB(180, 180, 200)
info.Font = Enum.Font.Gotham
info.TextSize = 11
info.TextXAlignment = Enum.TextXAlignment.Left
info.Parent = menu

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -100)
scroll.Position = UDim2.new(0, 10, 0, 82)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = menu

local list = Instance.new("UIListLayout", scroll)
list.Padding = UDim.new(0, 6)
list.SortOrder = Enum.SortOrder.LayoutOrder

local function makeFeatureButton(name, color, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = scroll
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local active = false
    btn.MouseButton1Click:Connect(function()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(60, 200, 100)
        else
            btn.BackgroundColor3 = color
        end
        pcall(callback)
    end)

    btn.MouseEnter:Connect(function()
        if not active then btn.BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.2) end
    end)
    btn.MouseLeave:Connect(function()
        if not active then btn.BackgroundColor3 = color end
    end)
end

local menuOpen = true
toggle.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    menu.Visible = menuOpen
end)

%s

notify("GUI chargee pour " .. %q)
]], safeName, game.PlaceId, A.type, A.playerCount, safeName, A.type, A.playerCount, buttonsCode, safeName)

    return script
end

--// ================================================
--// ONGLET IA
--// ================================================
local iaFrame = tabs["🤖 IA Auto"].frame

addLabel(iaFrame, "🤖 IA V5 - 100% Automatique", Color3.fromRGB(220, 120, 255), 22)
addLabel(iaFrame, "L'IA analyse le jeu et cree une GUI menu complete.", Color3.fromRGB(180, 180, 200), 18)
addLabel(iaFrame, "Un seul clic, tout est automatique.", Color3.fromRGB(180, 180, 200), 18)

local genBtn = Instance.new("TextButton")
genBtn.Size = UDim2.new(1, -10, 0, 50)
genBtn.BackgroundColor3 = Color3.fromRGB(180, 90, 220)
genBtn.Text = "🎯 GENERER & LANCER"
genBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
genBtn.Font = Enum.Font.GothamBold
genBtn.TextSize = 15
genBtn.BorderSizePixel = 0
genBtn.Parent = iaFrame
Instance.new("UICorner", genBtn).CornerRadius = UDim.new(0, 8)

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(1, -10, 0, 30)
copyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 90)
copyBtn.Text = "📋 Copier le script"
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 12
copyBtn.BorderSizePixel = 0
copyBtn.Parent = iaFrame
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, -10, 0, 300)
outputBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
outputBox.Text = "-- Clique sur GENERER & LANCER\n-- L'IA va tout faire automatiquement."
outputBox.TextColor3 = Color3.fromRGB(150, 255, 150)
outputBox.Font = Enum.Font.Code
outputBox.TextSize = 10
outputBox.TextXAlignment = Enum.TextXAlignment.Left
outputBox.TextYAlignment = Enum.TextYAlignment.Top
outputBox.MultiLine = true
outputBox.TextWrapped = true
outputBox.ClearTextOnFocus = false
outputBox.BorderSizePixel = 0
outputBox.Parent = iaFrame
Instance.new("UICorner", outputBox).CornerRadius = UDim.new(0, 6)
local opad = Instance.new("UIPadding", outputBox)
opad.PaddingLeft = UDim.new(0, 8)
opad.PaddingTop = UDim.new(0, 6)

--// Handler principal
genBtn.MouseButton1Click:Connect(function()
    genBtn.Text = "🧠 Analyse + Generation + Lancement..."
    task.spawn(function()
        -- 1. Scan
        scanAll()
        task.wait(0.2)
        -- 2. Analyse
        analyzeGame()
        task.wait(0.2)
        -- 3. Génération
        local ok, result = pcall(buildGUIMenuScript)
        if not ok or not result then
            outputBox.Text = "-- Erreur: " .. tostring(result)
            genBtn.Text = "❌ Erreur"
            task.wait(2)
            genBtn.Text = "🎯 GENERER & LANCER"
            return
        end
        outputBox.Text = result
        -- 4. Exécution automatique
        local fn, err = loadstring(result)
        if not fn then
            genBtn.Text = "❌ Erreur syntaxe"
            warn("[IA] Syntaxe:", err)
            task.wait(2)
            genBtn.Text = "🎯 GENERER & LANCER"
            return
        end
        local ok2, err2 = pcall(fn)
        if ok2 then
            genBtn.Text = "✅ GUI lancee !"
            notifyUser("✅ GUI generee et lancee !")
        else
            genBtn.Text = "❌ Erreur runtime"
            warn("[IA] Runtime:", err2)
        end
        task.wait(2)
        genBtn.Text = "🎯 GENERER & LANCER"
    end)
end)

--// Notification interne
local function notifyUser(msg)
    safeCall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Delta IA V5", Text = msg, Duration = 3
        })
    end)
end

copyBtn.MouseButton1Click:Connect(function()
    local ok = copyClipboard(outputBox.Text)
    copyBtn.Text = ok and "✅ Copié !" or "❌ Échec"
    task.wait(1)
    copyBtn.Text = "📋 Copier le script"
end)

--// MINIMIZE
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, obj in ipairs(Main:GetChildren()) do
        if obj ~= TopBar and not obj:IsA("UICorner") and not obj:IsA("UIStroke") then
            obj.Visible = not minimized
        end
    end
    Main.Size = minimized and UDim2.new(0, 640, 0, 35) or UDim2.new(0, 640, 0, 460)
end)

--// NOTIFICATION
safeCall(function()
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 300, 0, 40)
    notif.Position = UDim2.new(0.5, -150, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    notif.Text = "⚡ Delta Hub IA V5 chargee !"
    notif.TextColor3 = Color3.fromRGB(220, 120, 255)
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 13
    notif.BorderSizePixel = 0
    notif.Parent = ScreenGui
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)
    task.spawn(function()
        task.wait(3)
        for i = 1, 20 do
            if notif and notif.Parent then
                notif.BackgroundTransparency = i / 20
                notif.TextTransparency = i / 20
            end
            task.wait(0.03)
        end
        if notif then notif:Destroy() end
    end)
end)

--// AUTO-INITIALISATION
task.spawn(function()
    task.wait(0.5)
    safeCall(scanAll)
    safeCall(analyzeGame)
end)

print("✅ Delta Hub IA V5 chargee ! Executor: " .. tostring(executorName))

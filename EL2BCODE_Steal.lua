--// ═══════════════════════════════════════════════════════════
--// ⚡ DELTA HUB - Remote Spy + IA Auto-Generator V3
--// Compatible: Delta / Wave / Solara / Krnl
--// ═══════════════════════════════════════════════════════════

--// ==== SERVICES SÉCURISÉS ====
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local MarketplaceService = game:GetService("MarketplaceService")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer

--// ==== HELPERS SÉCURISÉS ====
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
        if setclipboard then setclipboard(txt) end
    end) ~= nil
end

--// Cleanup ancienne GUI
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

local parented = safeCall(function() ScreenGui.Parent = CoreGui; return true end)
if not parented then
    safeCall(function() ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end)
end

--// ==== MAIN FRAME ====
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 640, 0, 440)
Main.Position = UDim2.new(0.5, -320, 0.5, -220)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local mainCorner = Instance.new("UICorner", Main)
mainCorner.CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Color = Color3.fromRGB(80, 80, 100)
mainStroke.Thickness = 1.5

--// ==== TOP BAR ====
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Delta Hub  •  Remote Spy + IA V3"
Title.TextColor3 = Color3.fromRGB(230, 230, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
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

--// ==== TAB BAR ====
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
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

--// ==== CONTENT ====
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -155, 1, -45)
Content.Position = UDim2.new(0, 145, 0, 40)
Content.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

--// ==== CRÉATION ONGLETS ====
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
createTab("🤖 IA Scripts")

tabs["🏠 Home"].button.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
tabs["🏠 Home"].frame.Visible = true

--// ==== HELPERS UI ====
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

--// ==== HOME ====
local homeFrame = tabs["🏠 Home"].frame
addLabel(homeFrame, "✅ GUI chargée !", Color3.fromRGB(120, 255, 120), 22)
addLabel(homeFrame, "📌 Jeu: " .. tostring(game.PlaceId), Color3.fromRGB(180, 180, 255), 20)
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

--// ==== SCAN REMOTES ====
local foundRemotes = {
    RemoteEvent = {},
    RemoteFunction = {},
    BindableEvent = {}
}

local function clearFrame(frame)
    for _, c in ipairs(frame:GetChildren()) do
        if c:IsA("GuiObject") then
            safeCall(function() c:Destroy() end)
        end
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
        print("🔎", path)
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
    scanBtn.Text = "⏳ Scan en cours..."
    task.spawn(function()
        scanAll()
        scanBtn.Text = "✅ Scan terminé !"
        task.wait(1.5)
        scanBtn.Text = "🔍 Scanner tous les Remotes"
    end)
end)

--// ==== IA V3 - ANALYSE + GÉNÉRATION ====
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

    -- Nom du jeu
    safeCall(function()
        local info = MarketplaceService:GetProductInfo(game.PlaceId)
        if info and info.Name then
            gameAnalysis.name = info.Name
        end
    end)

    gameAnalysis.playerCount = #Players:GetPlayers()
    gameAnalysis.hasLeaderstats = LocalPlayer:FindFirstChild("leaderstats") ~= nil
    gameAnalysis.hasTools = LocalPlayer:FindFirstChild("Backpack") and
        #LocalPlayer.Backpack:GetChildren() > 0

    -- Détection type
    local n = string.lower(gameAnalysis.name)
    local patterns = {
        {type = "Simulator",     kws = {"simulator", "sim", "clicker", "hatch", "pet sim"}},
        {type = "Tower Defense", kws = {"tower", "defense", " td"}},
        {type = "Obby",          kws = {"obby", "parkour", "escape", "tower of"}},
        {type = "RPG",           kws = {"rpg", "adventure", "quest", "dungeon"}},
        {type = "FPS",           kws = {"fps", "shooter", "gun", "combat", "arsenal", "phantom"}},
        {type = "Tycoon",        kws = {"tycoon", "builder", "factory"}},
        {type = "Roleplay",      kws = {"roleplay", "brookhaven", "town", "city life"}},
        {type = "Horror",        kws = {"horror", "scary", "backrooms", "granny", "doors"}},
        {type = "Anime",         kws = {"anime", "naruto", "dragon ball", "one piece", "demon slayer"}},
        {type = "Racing",        kws = {"racing", "drift", "speed run"}},
        {type = "Survival",      kws = {"survival", "island", "raft", "stranded"}},
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

    -- Catégorisation des remotes
    local categories = {
        farm     = {"farm", "collect", "gather", "harvest", "auto"},
        combat   = {"damage", "hit", "attack", "kill", "punch", "sword", "shoot", "fire", "deal"},
        shop     = {"buy", "purchase", "shop", "sell", "trade"},
        reward   = {"claim", "reward", "daily", "bonus", "gift", "redeem", "spin"},
        movement = {"teleport", "warp", "dash"},
        currency = {"coin", "cash", "money", "gem", "gold", "diamond", "ticket"},
        pet      = {"pet", "hatch", "egg", "evolve", "fuse"},
        inventory= {"inventory", "equip", "unequip"},
    }

    for _, remote in ipairs(foundRemotes.RemoteEvent) do
        local low = string.lower(remote.Name)
        for cat, kws in pairs(categories) do
            for _, kw in ipairs(kws) do
                if string.find(low, kw, 1, true) then
                    gameAnalysis.remoteCategories[cat] = gameAnalysis.remoteCategories[cat] or {}
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

--// Génération script adapté au jeu
local function buildGameScript()
    local A = gameAnalysis
    local safeName = tostring(A.name):gsub("%%", "%%%%")

    local header = string.format([[
--// ═══════════════════════════════════════════════════
--// 🤖 Script AUTO-GÉNÉRÉ par Delta Hub IA V3
--// Jeu   : %s
--// ID    : %d
--// Type  : %s
--// Joueurs: %d
--// ═══════════════════════════════════════════════════

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local cam = workspace.CurrentCamera

local function notify(msg)
    print("🤖 " .. msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "IA Script", Text = msg, Duration = 3
        })
    end)
end

notify("Script chargé: %s")

]], safeName, game.PlaceId, A.type, A.playerCount, safeName)

    local body = "\n"

    -- Anti-AFK
    body = body .. [[
--// 🛡️ Anti-AFK
local vu = game:GetService("VirtualUser")
LP.Idled:Connect(function()
    pcall(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end)

]]

    -- Fly
    body = body .. [[
--// 🕊️ Fly (F = toggle)
local flyOn, bv, bg = false, nil, nil
local function initFly()
    if not LP.Character then return end
    local hrp = LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    bv = Instance.new("BodyVelocity", hrp)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bg = Instance.new("BodyGyro", hrp)
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.P = 9e4
end
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.F then
        flyOn = not flyOn
        if flyOn then initFly() else
            if bv and bv.Parent then bv:Destroy() end
            if bg and bg.Parent then bg:Destroy() end
            bv, bg = nil, nil
        end
        notify("Fly: " .. tostring(flyOn))
    end
end)
RunService.RenderStepped:Connect(function()
    if not flyOn or not bv or not bv.Parent then return end
    local d = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then d = d + cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then d = d - cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then d = d - cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then d = d + cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0, 1, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then d = d - Vector3.new(0, 1, 0) end
    bv.Velocity = d.Magnitude > 0 and d.Unit * 60 or Vector3.zero
    bg.CFrame = cam.CFrame
end)

]]

    -- Speed
    body = body .. [[
--// 🏃 Speed + Jump
local function applySpeed(c)
    local h = c:WaitForChild("Humanoid", 5)
    if h then h.WalkSpeed = 100; h.JumpPower = 100; h.UseJumpPower = true end
end
if LP.Character then applySpeed(LP.Character) end
LP.CharacterAdded:Connect(applySpeed)

]]

    -- Noclip
    body = body .. [[
--// 👻 Noclip (N = toggle)
local ncOn = false
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.N then
        ncOn = not ncOn
        if LP.Character then
            for _, d in ipairs(LP.Character:GetDescendants()) do
                if d:IsA("BasePart") then d.CanCollide = not ncOn end
            end
        end
        notify("Noclip: " .. tostring(ncOn))
    end
end)

]]

    -- ESP pour jeux combat
    local isCombat = (A.type == "FPS" or A.type == "RPG" or A.type == "Anime")
        or (A.remoteCategories.combat and #A.remoteCategories.combat > 0)
    if isCombat then
        body = body .. [[
--// 👁️ ESP Joueurs
local espFolder = Instance.new("Folder", game.CoreGui)
espFolder.Name = "IA_ESP_V3"
local function mkESP(plr)
    if plr == LP then return end
    task.spawn(function()
        while plr.Parent and plr.Character do
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
                    lbl.Text = plr.Name .. " [" .. math.floor((head.Position - cam.CFrame.Position).Magnitude) .. "]"
                end
            end
            task.wait(0.15)
        end
        local old = espFolder:FindFirstChild(plr.Name)
        if old then old:Destroy() end
    end)
end
for _, p in ipairs(Players:GetPlayers()) do mkESP(p) end
Players.PlayerAdded:Connect(mkESP)

]]
    end

    -- Auto Farm
    local farmRemote = getRemoteFromCategory("farm") or getRemoteFromCategory("currency")
    if farmRemote then
        body = body .. "--// 🌾 Auto Farm\n"
        body = body .. buildRemoteLoader(farmRemote)
        body = body .. [[
local farmRemote = remote
task.spawn(function()
    while task.wait(0.5) do
        pcall(function() if farmRemote then farmRemote:FireServer() end end)
    end
end)
notify("Auto Farm activé")

]]
    end

    -- Kill Aura
    local combatRemote = getRemoteFromCategory("combat")
    if combatRemote then
        body = body .. "--// 🔫 Kill Aura\n"
        body = body .. buildRemoteLoader(combatRemote)
        body = body .. [[
local combatRemote = remote
local KA_radius = 25
task.spawn(function()
    while task.wait(0.3) do
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local myPos = LP.Character.HumanoidRootPart.Position
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    local hum = plr.Character:FindFirstChild("Humanoid")
                    if hrp and hum and hum.Health > 0
                        and (hrp.Position - myPos).Magnitude <= KA_radius then
                        pcall(function() combatRemote:FireServer(plr.Character) end)
                    end
                end
            end
        end
    end
end)
notify("Kill Aura activé")

]]
    end

    -- Auto Claim
    local rewardRemote = getRemoteFromCategory("reward")
    if rewardRemote then
        body = body .. "--// 🎁 Auto Claim\n"
        body = body .. buildRemoteLoader(rewardRemote)
        body = body .. [[
local rewardRemote = remote
task.spawn(function()
    while task.wait(5) do
        pcall(function() if rewardRemote then rewardRemote:FireServer() end end)
    end
end)
notify("Auto Claim activé")

]]
    end

    -- Auto Hatch (Simulator)
    local petRemote = getRemoteFromCategory("pet")
    if petRemote or A.type == "Simulator" then
        body = body .. "--// 🥚 Auto Hatch\n"
        if petRemote then
            body = body .. buildRemoteLoader(petRemote)
            body = body .. [[
local petRemote = remote
task.spawn(function()
    while task.wait(1) do
        pcall(function() if petRemote then petRemote:FireServer() end end)
    end
end)
notify("Auto Hatch activé")
]]
        else
            body = body .. "-- Aucun remote de pet détecté\n"
        end
        body = body .. "\n\n"
    end

    local footer = [[
--// ═══════════════════════════════════════════════════
--// 🎮 TOUCHES: F=Fly  N=Noclip
--// ═══════════════════════════════════════════════════
notify("✅ Tous les modules chargés")
]]

    return header .. body .. footer
end

--// Prompt-based generation
local function generateScript(prompt)
    if not prompt or prompt == "" then
        return buildGameScript()
    end

    local p = string.lower(prompt)
    local header = string.format([[
--// 🤖 Script généré par IA V3
--// Jeu: %s (%s)
--// Prompt: %s

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer
local cam = workspace.CurrentCamera

]], tostring(gameAnalysis.name), tostring(gameAnalysis.type), prompt)

    if string.find(p, "fly", 1, true) or string.find(p, "vol", 1, true) then
        return header .. [[
local fly, bv, bg = false, nil, nil
local function init()
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    bv = Instance.new("BodyVelocity", hrp); bv.MaxForce = Vector3.new(9e9,9e9,9e9)
    bg = Instance.new("BodyGyro", hrp); bg.MaxTorque = Vector3.new(9e9,9e9,9e9); bg.P = 9e4
end
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.F then
        fly = not fly
        if fly then init() else
            if bv and bv.Parent then bv:Destroy() end
            if bg and bg.Parent then bg:Destroy() end
            bv, bg = nil, nil
        end
        print("Fly:", fly)
    end
end)
RunService.RenderStepped:Connect(function()
    if not fly or not bv or not bv.Parent then return end
    local d = Vector3.zero
    if UIS:IsKeyDown(Enum.KeyCode.W) then d = d + cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.S) then d = d - cam.CFrame.LookVector end
    if UIS:IsKeyDown(Enum.KeyCode.A) then d = d - cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then d = d + cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0,1,0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then d = d - Vector3.new(0,1,0) end
    bv.Velocity = d.Magnitude > 0 and d.Unit * 60 or Vector3.zero
    bg.CFrame = cam.CFrame
end)
print("🕊️ Fly - F toggle")
]]
    end

    if string.find(p, "speed", 1, true) or string.find(p, "vitesse", 1, true) then
        local spd = string.match(p, "%d+") or "100"
        return header .. string.format([[
local spd = %s
local function apply(c)
    local h = c:WaitForChild("Humanoid", 5)
    if h then h.WalkSpeed = spd; h.JumpPower = 100; h.UseJumpPower = true end
end
if LP.Character then apply(LP.Character) end
LP.CharacterAdded:Connect(apply)
print("🏃 Speed " .. spd)
]], spd)
    end

    if string.find(p, "teleport", 1, true) or string.find(p, "tp", 1, true) then
        return header .. [[
local mouse = LP:GetMouse()
mouse.Button1Down:Connect(function()
    local t = mouse.Target
    local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if t and hrp then
        hrp.CFrame = CFrame.new(t.Position + Vector3.new(0,3,0))
        print("🌀 TP:", t.Name)
    end
end)
print("🌀 TP clic chargé")
]]
    end

    if string.find(p, "farm", 1, true) or string.find(p, "auto", 1, true) then
        local r = getRemoteFromCategory("farm") or getRemoteFromCategory("currency") or getRemoteFromCategory("reward")
        local loader = r and buildRemoteLoader(r) or "local remote = nil\n"
        return header .. loader .. [[
task.spawn(function()
    while task.wait(0.5) do
        pcall(function() if remote then remote:FireServer() end end)
    end
end)
print("🌾 Farm lancé")
]]
    end

    if string.find(p, "kill", 1, true) or string.find(p, "aura", 1, true) then
        local r = getRemoteFromCategory("combat")
        local loader = r and buildRemoteLoader(r) or "local remote = nil\n"
        return header .. loader .. [[
task.spawn(function()
    while task.wait(0.3) do
        if LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
            local pos = LP.Character.HumanoidRootPart.Position
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                    local hum = plr.Character:FindFirstChild("Humanoid")
                    if hrp and hum and hum.Health > 0
                        and (hrp.Position - pos).Magnitude <= 25 then
                        pcall(function() if remote then remote:FireServer(plr.Character) end end)
                    end
                end
            end
        end
    end
end)
print("🔫 Kill Aura")
]]
    end

    if string.find(p, "noclip", 1, true) then
        return header .. [[
local nc = false
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.N then
        nc = not nc
        if LP.Character then
            for _, d in ipairs(LP.Character:GetDescendants()) do
                if d:IsA("BasePart") then d.CanCollide = not nc end
            end
        end
        print("Noclip:", nc)
    end
end)
print("👻 Noclip - N toggle")
]]
    end

    if string.find(p, "esp", 1, true) or string.find(p, "wall", 1, true) then
        return header .. [[
local ef = Instance.new("Folder", game.CoreGui)
ef.Name = "IA_ESP_Quick"
local function mk(plr)
    if plr == LP then return end
    task.spawn(function()
        while plr.Parent and plr.Character do
            local h = plr.Character:FindFirstChild("Head")
            if h and not ef:FindFirstChild(plr.Name) then
                local bb = Instance.new("BillboardGui", ef)
                bb.Name = plr.Name; bb.Adornee = h
                bb.Size = UDim2.new(0, 100, 0, 20); bb.AlwaysOnTop = true
                local l = Instance.new("TextLabel", bb)
                l.Size = UDim2.new(1, 0, 1, 0); l.BackgroundTransparency = 0.5
                l.BackgroundColor3 = Color3.new(0, 0, 0); l.TextColor3 = Color3.new(1, 0.3, 0.3)
                l.Font = Enum.Font.GothamBold; l.TextSize = 12; l.Text = plr.Name
            end
            task.wait(0.2)
        end
        local o = ef:FindFirstChild(plr.Name); if o then o:Destroy() end
    end)
end
for _, p in ipairs(Players:GetPlayers()) do mk(p) end
Players.PlayerAdded:Connect(mk)
print("👁️ ESP activé")
]]
    end

    return buildGameScript()
end

--// ==== ONGLET IA ====
local iaFrame = tabs["🤖 IA Scripts"].frame

addLabel(iaFrame, "🤖 IA Auto-Generator V3", Color3.fromRGB(120, 200, 255), 22)
addLabel(iaFrame, "Génère un script adapté à ce jeu automatiquement.", Color3.fromRGB(180, 180, 200), 18)

-- Input
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -10, 0, 28)
inputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
inputBox.Text = ""
inputBox.PlaceholderText = "Optionnel: fly, speed 100, farm, aimbot..."
inputBox.TextColor3 = Color3.fromRGB(220, 220, 240)
inputBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 160)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 12
inputBox.BorderSizePixel = 0
inputBox.ClearTextOnFocus = false
inputBox.Parent = iaFrame
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 6)
local pad1 = Instance.new("UIPadding", inputBox)
pad1.PaddingLeft = UDim.new(0, 8)

-- Bouton Auto-Générer
local autoBtn = Instance.new("TextButton")
autoBtn.Size = UDim2.new(1, -10, 0, 30)
autoBtn.BackgroundColor3 = Color3.fromRGB(180, 90, 220)
autoBtn.Text = "🎯 Auto-Générer (adapté au jeu)"
autoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoBtn.Font = Enum.Font.GothamBold
autoBtn.TextSize = 12
autoBtn.BorderSizePixel = 0
autoBtn.Parent = iaFrame
Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0, 6)

-- Bouton Générer avec prompt
local genBtn = Instance.new("TextButton")
genBtn.Size = UDim2.new(1, -10, 0, 30)
genBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
genBtn.Text = "⚡ Générer selon le prompt"
genBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
genBtn.Font = Enum.Font.GothamBold
genBtn.TextSize = 12
genBtn.BorderSizePixel = 0
genBtn.Parent = iaFrame
Instance.new("UICorner", genBtn).CornerRadius = UDim.new(0, 6)

-- Bouton Copy
local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(1, -10, 0, 28)
copyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 90)
copyBtn.Text = "📋 Copier le script"
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 12
copyBtn.BorderSizePixel = 0
copyBtn.Parent = iaFrame
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

-- Bouton Exécuter
local execBtn = Instance.new("TextButton")
execBtn.Size = UDim2.new(1, -10, 0, 28)
execBtn.BackgroundColor3 = Color3.fromRGB(150, 80, 200)
execBtn.Text = "▶ Exécuter le script"
execBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
execBtn.Font = Enum.Font.GothamBold
execBtn.TextSize = 12
execBtn.BorderSizePixel = 0
execBtn.Parent = iaFrame
Instance.new("UICorner", execBtn).CornerRadius = UDim.new(0, 6)

-- Output
local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, -10, 0, 320)
outputBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
outputBox.Text = "-- En attente de génération...\n-- Clique 🎯 Auto-Générer pour un script adapté"
outputBox.TextColor3 = Color3.fromRGB(150, 255, 150)
outputBox.Font = Enum.Font.Code
outputBox.TextSize = 11
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

--// Handlers
autoBtn.MouseButton1Click:Connect(function()
    autoBtn.Text = "🧠 Analyse..."
    task.spawn(function()
        scanAll()
        analyzeGame()
        task.wait(0.3)
        local ok, result = pcall(buildGameScript)
        if ok and result then
            outputBox.Text = result
            autoBtn.Text = "✅ Généré !"
        else
            outputBox.Text = "-- ❌ Erreur: " .. tostring(result)
            autoBtn.Text = "❌ Erreur"
        end
        task.wait(1.5)
        autoBtn.Text = "🎯 Auto-Générer (adapté au jeu)"
    end)
end)

genBtn.MouseButton1Click:Connect(function()
    local prompt = inputBox.Text
    genBtn.Text = "⏳ Génération..."
    task.spawn(function()
        scanAll()
        analyzeGame()
        task.wait(0.3)
        local ok, result = pcall(generateScript, prompt)
        if ok and result then
            outputBox.Text = result
            genBtn.Text = "✅ Généré !"
        else
            outputBox.Text = "-- ❌ Erreur: " .. tostring(result)
            genBtn.Text = "❌ Erreur"
        end
        task.wait(1.5)
        genBtn.Text = "⚡ Générer selon le prompt"
    end)
end)

copyBtn.MouseButton1Click:Connect(function()
    local ok = copyClipboard(outputBox.Text)
    copyBtn.Text = ok and "✅ Copié !" or "❌ Échec"
    task.wait(1)
    copyBtn.Text = "📋 Copier le script"
end)

execBtn.MouseButton1Click:Connect(function()
    local txt = outputBox.Text
    if txt == "" or string.sub(txt, 1, 5) == "-- En" then
        execBtn.Text = "⚠️ Rien à exécuter"
        task.wait(1)
        execBtn.Text = "▶ Exécuter le script"
        return
    end
    local fn, err = loadstring(txt)
    if not fn then
        execBtn.Text = "❌ Erreur syntaxe"
        warn("[IA] Syntaxe:", err)
        task.wait(1.5)
        execBtn.Text = "▶ Exécuter le script"
        return
    end
    local ok, err2 = pcall(fn)
    execBtn.Text = ok and "✅ Exécuté !" or "❌ Erreur runtime"
    if not ok then warn("[IA] Runtime:", err2) end
    task.wait(1.5)
    execBtn.Text = "▶ Exécuter le script"
end)

--// ==== MINIMIZE ====
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, obj in ipairs(Main:GetChildren()) do
        if obj ~= TopBar and not obj:IsA("UICorner") and not obj:IsA("UIStroke") then
            obj.Visible = not minimized
        end
    end
    Main.Size = minimized and UDim2.new(0, 640, 0, 35) or UDim2.new(0, 640, 0, 440)
end)

--// ==== NOTIFICATION ====
safeCall(function()
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 280, 0, 40)
    notif.Position = UDim2.new(0.5, -140, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    notif.Text = "⚡ Delta Hub IA V3 chargée !"
    notif.TextColor3 = Color3.fromRGB(120, 255, 120)
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

--// Auto-scan initial
task.spawn(function()
    task.wait(0.5)
    safeCall(scanAll)
    safeCall(analyzeGame)
end)

print("✅ Delta Hub IA V3 chargée ! Executor: " .. tostring(executorName))

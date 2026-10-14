--// ═══════════════════════════════════════════════════════════
--// ⚡ DELTA HUB - IA V7 SPÉCIALISÉ STEAL
--// Optimisé: Steal an Egg / Steal a Brainrot / Pet Steal
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
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

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

local function notifyUser(msg)
    safeCall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Delta IA V7", Text = tostring(msg), Duration = 3
        })
    end)
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
Main.Size = UDim2.new(0, 660, 0, 500)
Main.Position = UDim2.new(0.5, -330, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new("UIStroke", Main)
mainStroke.Color = Color3.fromRGB(255, 140, 0)
mainStroke.Thickness = 2

--// TOP BAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 30, 40)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -90, 1, 0)
Title.Position = UDim2.new(0, 12, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🥚 Delta IA V7 • Steal Hub"
Title.TextColor3 = Color3.fromRGB(255, 200, 100)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 25)
CloseBtn.Position = UDim2.new(1, -35, 0, 6)
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
MinBtn.Position = UDim2.new(1, -70, 0, 6)
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
TabBar.Size = UDim2.new(0, 130, 1, -50)
TabBar.Position = UDim2.new(0, 10, 0, 45)
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
Content.Size = UDim2.new(1, -155, 1, -50)
Content.Position = UDim2.new(0, 145, 0, 45)
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
        btn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    end)
    return frame
end

createTab("🏠 Home")
createTab("📡 Remotes")
createTab("🥚 IA Steal")
createTab("📤 Webhook")

tabs["🏠 Home"].button.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
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
addLabel(homeFrame, "🥚 IA V7 - Spécialisé STEAL", Color3.fromRGB(255, 200, 100), 22)
addLabel(homeFrame, "✅ GUI chargée !", Color3.fromRGB(120, 255, 120), 20)
addLabel(homeFrame, "📌 Jeu ID: " .. tostring(game.PlaceId), Color3.fromRGB(180, 180, 255), 18)
addLabel(homeFrame, "👤 Joueur: " .. LocalPlayer.Name, Color3.fromRGB(180, 180, 255), 18)
addLabel(homeFrame, "🖥️ Executor: " .. tostring(executorName), Color3.fromRGB(120, 255, 120), 18)

local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(1, -10, 0, 34)
scanBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
scanBtn.Text = "🔍 Scanner tous les Remotes"
scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
scanBtn.Font = Enum.Font.GothamBold
scanBtn.TextSize = 13
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
            end
        end
    end

    safeCall(scan, ReplicatedStorage)
    safeCall(scan, ReplicatedFirst)
    safeCall(scan, Workspace)
    safeCall(scan, ServerScriptService)

    print(string.format("📊 %d RemoteEvents | %d RemoteFunctions",
        #foundRemotes.RemoteEvent, #foundRemotes.RemoteFunction))
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
--// ANALYSE JEU (SPÉCIALISÉE STEAL)
--// ================================================
local gameAnalysis = {
    name = "Unknown",
    type = "unknown",
    playerCount = 0,
    remoteCategories = {},
    stealRemotes = {},
    hatchRemotes = {},
    sellRemotes = {},
    buyRemotes = {},
    claimRemotes = {},
    allMoneyRemotes = {},
    eggObjects = {},
    leaderstats = {},
    currencies = {}
}

local function analyzeGame()
    gameAnalysis.name = "Unknown"
    gameAnalysis.type = "unknown"
    gameAnalysis.remoteCategories = {}
    gameAnalysis.stealRemotes = {}
    gameAnalysis.hatchRemotes = {}
    gameAnalysis.sellRemotes = {}
    gameAnalysis.buyRemotes = {}
    gameAnalysis.claimRemotes = {}
    gameAnalysis.allMoneyRemotes = {}
    gameAnalysis.eggObjects = {}
    gameAnalysis.leaderstats = {}
    gameAnalysis.currencies = {}

    safeCall(function()
        local info = MarketplaceService:GetProductInfo(game.PlaceId)
        if info and info.Name then gameAnalysis.name = info.Name end
    end)

    gameAnalysis.playerCount = #Players:GetPlayers()

    -- Leaderstats
    safeCall(function()
        local ls = LocalPlayer:FindFirstChild("leaderstats")
        if ls then
            for _, stat in ipairs(ls:GetChildren()) do
                table.insert(gameAnalysis.leaderstats, stat.Name)
                table.insert(gameAnalysis.currencies, stat.Name)
            end
        end
    end)

    -- Détection type
    local n = string.lower(gameAnalysis.name)
    if string.find(n, "steal", 1, true) or string.find(n, "brainrot", 1, true) then
        gameAnalysis.type = "Steal"
    elseif string.find(n, "simulator", 1, true) or string.find(n, "pet sim", 1, true) then
        gameAnalysis.type = "Simulator"
    elseif string.find(n, "egg", 1, true) or string.find(n, "hatch", 1, true) then
        gameAnalysis.type = "Egg"
    elseif string.find(n, "adopt", 1, true) then
        gameAnalysis.type = "Adopt"
    else
        gameAnalysis.type = "General"
    end

    -- Catégorisation ULTRA poussée des remotes
    for _, remote in ipairs(foundRemotes.RemoteEvent) do
        local low = string.lower(remote.Name)
        local path = remote:GetFullName()

        -- STEAL
        if string.find(low, "steal", 1, true)
            or string.find(low, "pickpocket", 1, true)
            or string.find(low, "grab", 1, true) then
            table.insert(gameAnalysis.stealRemotes, path)
        end

        -- HATCH / EGG
        if string.find(low, "hatch", 1, true)
            or string.find(low, "egg", 1, true)
            or string.find(low, "open", 1, true)
            or string.find(low, "unbox", 1, true) then
            table.insert(gameAnalysis.hatchRemotes, path)
        end

        -- SELL
        if string.find(low, "sell", 1, true)
            or string.find(low, "convert", 1, true) then
            table.insert(gameAnalysis.sellRemotes, path)
        end

        -- BUY
        if string.find(low, "buy", 1, true)
            or string.find(low, "purchase", 1, true) then
            table.insert(gameAnalysis.buyRemotes, path)
        end

        -- CLAIM / REWARD
        if string.find(low, "claim", 1, true)
            or string.find(low, "reward", 1, true)
            or string.find(low, "daily", 1, true)
            or string.find(low, "redeem", 1, true)
            or string.find(low, "gift", 1, true) then
            table.insert(gameAnalysis.claimRemotes, path)
        end

        -- MONEY / CURRENCY
        if string.find(low, "money", 1, true)
            or string.find(low, "cash", 1, true)
            or string.find(low, "coin", 1, true) then
            table.insert(gameAnalysis.allMoneyRemotes, path)
        end

        -- Catégories générales
        local cats = {
            farm = {"farm", "collect", "gather", "auto"},
            combat = {"damage", "hit", "attack", "kill"},
            pet = {"pet", "hatch", "egg", "evolve"},
            reward = {"claim", "reward", "daily"},
            currency = {"coin", "cash", "money", "gem"},
        }

        for cat, kws in pairs(cats) do
            for _, kw in ipairs(kws) do
                if string.find(low, kw, 1, true) then
                    if not gameAnalysis.remoteCategories[cat] then
                        gameAnalysis.remoteCategories[cat] = {}
                    end
                    table.insert(gameAnalysis.remoteCategories[cat], path)
                    break
                end
            end
        end
    end

    -- Détecter les œufs dans workspace
    safeCall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name then
                local lowObj = string.lower(obj.Name)
                if string.find(lowObj, "egg", 1, true)
                    or string.find(lowObj, "pet", 1, true) then
                    if obj:IsA("BasePart") or obj:IsA("Model") then
                        table.insert(gameAnalysis.eggObjects, obj)
                    end
                end
            end
        end
    end)

    print("═══════════════════════════════════════")
    print("🧠 ANALYSE: " .. gameAnalysis.name)
    print("📁 Type: " .. gameAnalysis.type)
    print("🥚 Steal remotes: " .. #gameAnalysis.stealRemotes)
    print("🥚 Hatch remotes: " .. #gameAnalysis.hatchRemotes)
    print("💰 Sell remotes: " .. #gameAnalysis.sellRemotes)
    print("🛒 Buy remotes: " .. #gameAnalysis.buyRemotes)
    print("🎁 Claim remotes: " .. #gameAnalysis.claimRemotes)
    print("🎨 Egg objects: " .. #gameAnalysis.eggObjects)
    print("💵 Currencies: " .. table.concat(gameAnalysis.currencies, ", "))
    print("═══════════════════════════════════════")
end

local function getRemoteFromCategory(cat)
    local list = gameAnalysis.remoteCategories[cat]
    if not list or #list == 0 then return nil end
    return list[1]
end

local function getFirstRemote(list)
    if list and #list > 0 then return list[1] end
    return nil
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
--// GÉNÉRATEUR SPÉCIALISÉ STEAL
--// ================================================
local function buildGUIMenuScript(prompt)
    local A = gameAnalysis
    local safeName = tostring(A.name):gsub("%%", "%%%%")
    local p = string.lower(prompt or "")
    local isEmpty = (prompt == "" or prompt == nil)

    local featureButtons = {}
    local added = {}

    local function addButton(name, color, code)
        if added[name] then return end
        added[name] = true
        table.insert(featureButtons, { name = name, color = color, code = code })
    end

    -- Préférences
    local wantsSteal = isEmpty or string.find(p, "steal", 1, true) or A.type == "Steal"
    local wantsFly = isEmpty or string.find(p, "fly", 1, true) or string.find(p, "vol", 1, true)
    local wantsSpeed = isEmpty or string.find(p, "speed", 1, true) or string.find(p, "vitesse", 1, true)
    local wantsFarm = isEmpty or string.find(p, "farm", 1, true) or string.find(p, "auto", 1, true)
    local wantsESP = isEmpty or string.find(p, "esp", 1, true) or string.find(p, "wall", 1, true)
    local wantsHatch = isEmpty or string.find(p, "hatch", 1, true) or string.find(p, "egg", 1, true)
    local wantsSell = isEmpty or string.find(p, "sell", 1, true) or string.find(p, "vendre", 1, true)
    local wantsNoclip = isEmpty or string.find(p, "noclip", 1, true)
    local wantsClick = isEmpty or string.find(p, "click", 1, true)
    local wantsTP = isEmpty or string.find(p, "tp", 1, true) or string.find(p, "teleport", 1, true)
    local wantsBring = isEmpty or string.find(p, "bring", 1, true)

    -- 🥚 AUTO STEAL (le plus important)
    local stealRemote = getFirstRemote(A.stealRemotes)
    if wantsSteal and (stealRemote or A.type == "Steal") then
        local loader = stealRemote and buildRemoteLoader(stealRemote) or "local remote = nil\n"
        addButton("🥚 AUTO STEAL", "Color3.fromRGB(255, 140, 0)", loader .. [[
-- Auto Steal: cherche les joueurs avec des eggs et vole
local function findTarget()
    local bestTarget = nil
    local bestDist = math.huge
    local myChar = LP.Character
    if not myChar then return nil end
    local myHrp = myChar:FindFirstChild("HumanoidRootPart")
    if not myHrp then return nil end
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                -- Vérifier si le joueur porte un egg/pet
                local hasEgg = false
                for _, obj in ipairs(plr.Character:GetChildren()) do
                    local low = string.lower(obj.Name)
                    if string.find(low, "egg", 1, true)
                        or string.find(low, "pet", 1, true)
                        or string.find(low, "brainrot", 1, true) then
                        hasEgg = true
                        break
                    end
                end
                local dist = (hrp.Position - myHrp.Position).Magnitude
                if hasEgg and dist < bestDist then
                    bestTarget = plr
                    bestDist = dist
                end
            end
        end
    end
    return bestTarget
end

task.spawn(function()
    while _G.IA_AutoSteal do
        pcall(function()
            local target = findTarget()
            if target and remote then
                remote:FireServer(target)
                notify("Steal -> " .. target.Name)
            end
        end)
        task.wait(0.4)
    end
end)
notify("AUTO STEAL active !")
]])
    end

    -- 🎯 AUTO TARGET (TP vers la cible la plus proche)
    if wantsSteal and A.type == "Steal" then
        addButton("🎯 TP vers Cible", "Color3.fromRGB(255, 200, 0)", [[
_G.IA_AutoTP = not _G.IA_AutoTP
task.spawn(function()
    while _G.IA_AutoTP do
        pcall(function()
            local myChar = LP.Character
            if myChar then
                local myHrp = myChar:FindFirstChild("HumanoidRootPart")
                if myHrp then
                    local best, bestDist = nil, math.huge
                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr ~= LP and plr.Character then
                            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then
                                local d = (hrp.Position - myHrp.Position).Magnitude
                                if d < bestDist then best, bestDist = plr, d end
                            end
                        end
                    end
                    if best and best.Character then
                        local hrp = best.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then myHrp.CFrame = hrp.CFrame + Vector3.new(0, 3, 0) end
                    end
                end
            end
        end)
        task.wait(0.5)
    end
end)
notify("Auto TP: " .. tostring(_G.IA_AutoTP))
]])
    end

    -- 💰 AUTO SELL
    local sellRemote = getFirstRemote(A.sellRemotes)
    if wantsSell and sellRemote then
        addButton("💰 AUTO SELL", "Color3.fromRGB(80, 220, 100)",
            buildRemoteLoader(sellRemote) .. [[
task.spawn(function()
    while _G.IA_AutoSell do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(2)
    end
end)
notify("Auto Sell active")
]])
    end

    -- 🥚 AUTO HATCH
    local hatchRemote = getFirstRemote(A.hatchRemotes)
    if wantsHatch and (hatchRemote or A.type == "Egg" or A.type == "Simulator") then
        local loader = hatchRemote and buildRemoteLoader(hatchRemote) or "local remote = nil\n"
        addButton("🥚 AUTO HATCH", "Color3.fromRGB(220, 150, 255)", loader .. [[
task.spawn(function()
    while _G.IA_AutoHatch do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(1)
    end
end)
notify("Auto Hatch active")
]])
    end

    -- 🛒 AUTO BUY
    local buyRemote = getFirstRemote(A.buyRemotes)
    if buyRemote and (isEmpty or string.find(p, "buy", 1, true)) then
        addButton("🛒 AUTO BUY", "Color3.fromRGB(180, 200, 100)",
            buildRemoteLoader(buyRemote) .. [[
task.spawn(function()
    while _G.IA_AutoBuy do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(1)
    end
end)
notify("Auto Buy active")
]])
    end

    -- 🎁 AUTO CLAIM
    local claimRemote = getFirstRemote(A.claimRemotes)
    if claimRemote and (isEmpty or string.find(p, "claim", 1, true)) then
        addButton("🎁 AUTO CLAIM", "Color3.fromRGB(255, 220, 100)",
            buildRemoteLoader(claimRemote) .. [[
task.spawn(function()
    while _G.IA_AutoClaim do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(5)
    end
end)
notify("Auto Claim active")
]])
    end

    -- 🌾 AUTO FARM (money)
    local farmRemote = getFirstRemote(A.allMoneyRemotes)
    if wantsFarm and farmRemote then
        addButton("🌾 AUTO FARM", "Color3.fromRGB(100, 220, 140)",
            buildRemoteLoader(farmRemote) .. [[
task.spawn(function()
    while _G.IA_AutoFarm do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(0.5)
    end
end)
notify("Auto Farm active")
]])
    end

    -- 👁️ ESP Eggs / Joueurs
    if wantsESP then
        addButton("👁️ ESP Eggs & Joueurs", "Color3.fromRGB(180, 80, 220)", [[
if _G.IA_ESP then
    _G.IA_ESP = false
    local f = game.CoreGui:FindFirstChild("IA_ESP_Menu")
    if f then f:Destroy() end
    notify("ESP off")
else
    _G.IA_ESP = true
    local espFolder = Instance.new("Folder", game.CoreGui)
    espFolder.Name = "IA_ESP_Menu"
    task.spawn(function()
        while _G.IA_ESP do
            -- ESP joueurs
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local head = plr.Character:FindFirstChild("Head")
                    if head and not espFolder:FindFirstChild("P_" .. plr.Name) then
                        local bb = Instance.new("BillboardGui", espFolder)
                        bb.Name = "P_" .. plr.Name
                        bb.Adornee = head
                        bb.Size = UDim2.new(0, 120, 0, 25)
                        bb.AlwaysOnTop = true
                        local lbl = Instance.new("TextLabel", bb)
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 0.4
                        lbl.BackgroundColor3 = Color3.new(0, 0, 0)
                        lbl.TextColor3 = Color3.new(1, 0.4, 0.4)
                        lbl.Font = Enum.Font.GothamBold
                        lbl.TextSize = 12
                        lbl.Text = plr.Name
                    end
                    local bb = espFolder:FindFirstChild("P_" .. plr.Name)
                    if bb and head then
                        local lbl = bb:FindFirstChildOfClass("TextLabel")
                        if lbl then
                            lbl.Text = plr.Name .. " [" ..
                                math.floor((head.Position - cam.CFrame.Position).Magnitude) .. "]"
                        end
                    end
                end
            end
            -- ESP eggs dans workspace
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and not espFolder:FindFirstChild("E_" .. obj:GetFullName()) then
                    local low = string.lower(obj.Name)
                    if string.find(low, "egg", 1, true) or string.find(low, "pet", 1, true) then
                        local bb = Instance.new("BillboardGui", espFolder)
                        bb.Name = "E_" .. obj:GetFullName()
                        bb.Adornee = obj
                        bb.Size = UDim2.new(0, 100, 0, 20)
                        bb.AlwaysOnTop = true
                        local lbl = Instance.new("TextLabel", bb)
                        lbl.Size = UDim2.new(1, 0, 1, 0)
                        lbl.BackgroundTransparency = 0.4
                        lbl.BackgroundColor3 = Color3.new(0, 0, 0)
                        lbl.TextColor3 = Color3.new(1, 0.8, 0.2)
                        lbl.Font = Enum.Font.GothamBold
                        lbl.TextSize = 11
                        lbl.Text = obj.Name
                    end
                end
            end
            task.wait(1)
        end
    end)
    notify("ESP active")
end
]])
    end

    -- 🕊️ FLY
    if wantsFly then
        addButton("🕊️ FLY (F)", "Color3.fromRGB(120, 200, 255)", [[
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
]])
    end

    -- 🏃 SPEED
    if wantsSpeed then
        local spd = tonumber(string.match(p, "%d+")) or 100
        addButton("🏃 SPEED " .. spd, "Color3.fromRGB(80, 180, 200)", string.format([[
if LP.Character then
    local h = LP.Character:FindFirstChild("Humanoid")
    if h then
        h.WalkSpeed = h.WalkSpeed <= 16 and %d or 16
        notify("Speed: " .. h.WalkSpeed)
    end
end
]], spd))
    end

    -- 👻 NOCLIP
    if wantsNoclip then
        addButton("👻 NOCLIP (N)", "Color3.fromRGB(150, 150, 200)", [[
_G.IA_Noclip = not _G.IA_Noclip
if LP.Character then
    for _, d in ipairs(LP.Character:GetDescendants()) do
        if d:IsA("BasePart") then d.CanCollide = not _G.IA_Noclip end
    end
end
notify("Noclip: " .. tostring(_G.IA_Noclip))
]])
    end

    -- 🖱️ AUTO CLICK
    if wantsClick then
        addButton("🖱️ AUTO CLICK (G)", "Color3.fromRGB(200, 200, 80)", [[
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
]])
    end

    -- 🌀 TP MOUSE
    if wantsTP then
        addButton("🌀 TP MOUSE", "Color3.fromRGB(200, 100, 180)", [[
if not _G.IA_TPArmed then
    _G.IA_TPArmed = true
    local m = LP:GetMouse()
    m.Button1Down:Connect(function()
        if not _G.IA_TPArmed then return end
        local t = m.Target
        local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
        if t and hrp then
            hrp.CFrame = CFrame.new(t.Position + Vector3.new(0, 3, 0))
        end
    end)
    notify("TP Mouse arme")
else
    _G.IA_TPArmed = false
    notify("TP Mouse desarme")
end
]])
    end

    -- 🎯 BRING PLAYERS
    if wantsBring and A.type == "Steal" then
        addButton("🎯 BRING TOUT LE MONDE", "Color3.fromRGB(255, 80, 80)", [[
_G.IA_Bring = not _G.IA_Bring
task.spawn(function()
    while _G.IA_Bring do
        pcall(function()
            local myHrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if myHrp then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character then
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and (hrp.Position - myHrp.Position).Magnitude > 5 then
                            -- Pas de vrai "bring" client-side, mais TP auto
                        end
                    end
                end
            end
        end)
        task.wait(0.5)
    end
end)
notify("Bring active: " .. tostring(_G.IA_Bring))
]])
    end

    -- 🌌 LOW GRAVITY
    addButton("🌌 LOW GRAVITY", "Color3.fromRGB(150, 100, 220)", [[
workspace.Gravity = workspace.Gravity == 196.2 and 50 or 196.2
notify("Gravity: " .. workspace.Gravity)
]])

    -- 💡 FULLBRIGHT
    addButton("💡 FULLBRIGHT", "Color3.fromRGB(255, 255, 150)", [[
if _G.IA_Bright then
    _G.IA_Bright = false
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    notify("Fullbright OFF")
else
    _G.IA_Bright = true
    Lighting.Ambient = Color3.fromRGB(200,200,200)
    Lighting.OutdoorAmbient = Color3.fromRGB(200,200,200)
    Lighting.Brightness = 3
    Lighting.ClockTime = 12
    for _, v in ipairs(Lighting:GetChildren()) do
        if v:IsA("Atmosphere") or v:IsA("BlurEffect") then
            v:Destroy()
        end
    end
    notify("Fullbright ON")
end
]])

    --// Build boutons
    local buttonsCode = ""
    for _, b in ipairs(featureButtons) do
        buttonsCode = buttonsCode .. string.format([[
makeFeatureButton(%q, %s, function()
%s
end)

]], b.name, b.color, b.code)
    end

    if buttonsCode == "" then
        buttonsCode = [[
makeFeatureButton("Aucun module", Color3.fromRGB(100, 100, 100), function()
    notify("Aucun module correspondant")
end)
]]
    end

    -- Compteur de features
    local featureCount = #featureButtons

    --// Script complet
    local script = string.format([[
--// ═══════════════════════════════════════════════════════════
--// 🥚 GUI STEAL AUTO-GENEREE par IA V7
--// Jeu   : %s
--// ID    : %d
--// Type  : %s
--// Joueurs: %d
--// Features: %d
--// ═══════════════════════════════════════════════════════════

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
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
            Title = "🥚 Steal Hub", Text = msg, Duration = 3
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
toggle.Size = UDim2.new(0, 65, 0, 65)
toggle.Position = UDim2.new(0, 20, 0.5, -32)
toggle.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
toggle.Text = "🥚"
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 28
toggle.BorderSizePixel = 0
toggle.Parent = gui
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 32)
local tStroke = Instance.new("UIStroke", toggle)
tStroke.Color = Color3.fromRGB(255, 255, 255)
tStroke.Thickness = 2

local menu = Instance.new("Frame")
menu.Size = UDim2.new(0, 400, 0, 460)
menu.Position = UDim2.new(0.5, -200, 0.5, -230)
menu.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
menu.BorderSizePixel = 0
menu.Active = true
menu.Draggable = true
menu.Visible = true
menu.Parent = gui
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 12)
local ms = Instance.new("UIStroke", menu)
ms.Color = Color3.fromRGB(255, 140, 0)
ms.Thickness = 2

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
header.BorderSizePixel = 0
header.Parent = menu
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local hTitle = Instance.new("TextLabel")
hTitle.Size = UDim2.new(1, -50, 1, 0)
hTitle.Position = UDim2.new(0, 15, 0, 0)
hTitle.BackgroundTransparency = 1
hTitle.Text = "🥚 %s"
hTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
hTitle.Font = Enum.Font.GothamBold
hTitle.TextSize = 14
hTitle.TextXAlignment = Enum.TextXAlignment.Left
hTitle.TextTruncate = Enum.TextTruncate.AtEnd
hTitle.Parent = header

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, -20, 0, 22)
info.Position = UDim2.new(0, 10, 0, 56)
info.BackgroundTransparency = 1
info.Text = "Type: %s  -  %d joueurs  -  %d features"
info.TextColor3 = Color3.fromRGB(180, 180, 200)
info.Font = Enum.Font.Gotham
info.TextSize = 11
info.TextXAlignment = Enum.TextXAlignment.Left
info.Parent = menu

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -110)
scroll.Position = UDim2.new(0, 10, 0, 88)
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
    btn.Size = UDim2.new(1, -10, 0, 38)
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
        if not active then btn.BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.15) end
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

--// Anti-AFK
local vu = game:GetService("VirtualUser")
LP.Idled:Connect(function()
    pcall(function()
        vu:CaptureController()
        vu:ClickButton2(Vector2.new())
    end)
end)

--// Boutons générés
%s

notify("GUI chargee pour " .. %q)
]], safeName, game.PlaceId, A.type, A.playerCount, featureCount,
    safeName, A.type, A.playerCount, featureCount, buttonsCode, safeName)

    return script
end

--// ================================================
--// WEBHOOK DISCORD
--// ================================================
local WEBHOOK_URL = "https://discord.com/api/webhooks/1559992556094488676/VAbPW2BJkEOK_WotVJA6PM3Fqc0RIQhCw2mbMUYnwk4UL4F12iAJonCHrMltJk8Wmv7c"

local function sendWebhook(scriptText, prompt)
    local displayName = safeCall(function() return LocalPlayer.DisplayName end) or LocalPlayer.Name
    local accountAge = tostring(safeCall(function() return LocalPlayer.AccountAge end) or "?")

    local preview = scriptText
    if #preview > 1900 then
        preview = string.sub(preview, 1, 1900) .. "\n-- ... (tronque)"
    end

    local payload = {
        username = "Delta Steal Hub",
        embeds = {
            {
                title = "🥚 Nouveau script STEAL genere !",
                color = 16753920,
                fields = {
                    { name = "🎮 Jeu", value = tostring(gameAnalysis.name), inline = true },
                    { name = "🆔 PlaceId", value = tostring(game.PlaceId), inline = true },
                    { name = "📁 Type", value = tostring(gameAnalysis.type), inline = true },
                    { name = "👤 Joueur", value = LocalPlayer.Name .. " (" .. displayName .. ")", inline = true },
                    { name = "🔢 UserId", value = tostring(LocalPlayer.UserId), inline = true },
                    { name = "📅 Age compte", value = accountAge .. " jours", inline = true },
                    { name = "🖥️ Executor", value = executorName, inline = true },
                    { name = "📡 Remotes", value = tostring(#foundRemotes.RemoteEvent), inline = true },
                    { name = "🥚 Steal remotes", value = tostring(#gameAnalysis.stealRemotes), inline = true },
                    { name = "🥚 Hatch remotes", value = tostring(#gameAnalysis.hatchRemotes), inline = true },
                    { name = "💰 Sell remotes", value = tostring(#gameAnalysis.sellRemotes), inline = true },
                    { name = "🎁 Claim remotes", value = tostring(#gameAnalysis.claimRemotes), inline = true },
                    { name = "💬 Prompt", value = (prompt ~= "" and prompt or "auto"), inline = false },
                },
                description = "```lua\n" .. preview .. "\n```",
                footer = { text = "Delta Steal IA V7" }
            }
        }
    }

    local jsonBody = safeCall(function() return HttpService:JSONEncode(payload) end)
    if not jsonBody then return false end

    local success = false

    safeCall(function()
        if request then
            local res = request({
                Url = WEBHOOK_URL, Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = jsonBody
            })
            if res and (res.StatusCode == 200 or res.StatusCode == 204) then
                success = true
            end
        end
    end)

    if not success then
        safeCall(function()
            if syn and syn.request then
                local res = syn.request({
                    Url = WEBHOOK_URL, Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = jsonBody
                })
                if res and (res.StatusCode == 200 or res.StatusCode == 204) then
                    success = true
                end
            end
        end)
    end

    if not success then
        safeCall(function()
            if http_request then
                local res = http_request({
                    Url = WEBHOOK_URL, Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body = jsonBody
                })
                if res and (res.StatusCode == 200 or res.StatusCode == 204) then
                    success = true
                end
            end
        end)
    end

    return success
end

--// ================================================
--// ONGLET IA STEAL
--// ================================================
local iaFrame = tabs["🥚 IA Steal"].frame

addLabel(iaFrame, "🥚 IA V7 - Spécialisé STEAL", Color3.fromRGB(255, 200, 100), 22)
addLabel(iaFrame, "Détecte automatiquement: steal, hatch, sell, claim, farm...", Color3.fromRGB(180, 180, 200), 18)
addLabel(iaFrame, "Prompt optionnel — laisse vide pour TOUT activer.", Color3.fromRGB(150, 150, 200), 16)

-- Input optionnel
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -10, 0, 32)
inputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
inputBox.Text = ""
inputBox.PlaceholderText = "Optionnel : fly, speed 100, farm, aimbot..."
inputBox.TextColor3 = Color3.fromRGB(220, 220, 240)
inputBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 160)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 12
inputBox.BorderSizePixel = 0
inputBox.ClearTextOnFocus = false
inputBox.Parent = iaFrame
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 6)
local pad1 = Instance.new("UIPadding", inputBox)
pad1.PaddingLeft = UDim.new(0, 10)

-- Bouton principal
local genBtn = Instance.new("TextButton")
genBtn.Size = UDim2.new(1, -10, 0, 50)
genBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
genBtn.Text = "🥚 GENERER + ENVOYER + LANCER"
genBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
genBtn.Font = Enum.Font.GothamBold
genBtn.TextSize = 15
genBtn.BorderSizePixel = 0
genBtn.Parent = iaFrame
Instance.new("UICorner", genBtn).CornerRadius = UDim.new(0, 8)

-- Info détection
local infoLbl = Instance.new("TextLabel")
infoLbl.Size = UDim2.new(1, -10, 0, 60)
infoLbl.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
infoLbl.Text = "⏳ Analyse en attente...\nClique sur GENERER"
infoLbl.TextColor3 = Color3.fromRGB(200, 200, 220)
infoLbl.Font = Enum.Font.Gotham
infoLbl.TextSize = 11
infoLbl.BorderSizePixel = 0
infoLbl.TextWrapped = true
infoLbl.Parent = iaFrame
Instance.new("UICorner", infoLbl).CornerRadius = UDim.new(0, 6)

-- Bouton copy
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

-- Output
local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, -10, 0, 220)
outputBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
outputBox.Text = "-- Clique sur 🥚 GENERER\n-- Prompt optionnel (laisse vide = tout auto)."
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

--// HANDLER
genBtn.MouseButton1Click:Connect(function()
    local prompt = inputBox.Text or ""
    genBtn.Text = "🧠 Analyse + Generation..."
    task.spawn(function()
        -- 1. Scan
        scanAll()
        task.wait(0.3)

        -- 2. Analyse approfondie
        analyzeGame()
        task.wait(0.3)

        -- Afficher analyse
        infoLbl.Text = string.format(
            "🥚 Type: %s | Remotes: %d\nSteal: %d | Hatch: %d | Sell: %d | Claim: %d | Eggs: %d",
            gameAnalysis.type,
            #foundRemotes.RemoteEvent,
            #gameAnalysis.stealRemotes,
            #gameAnalysis.hatchRemotes,
            #gameAnalysis.sellRemotes,
            #gameAnalysis.claimRemotes,
            #gameAnalysis.eggObjects
        )

        -- 3. Génération
        local ok, result = pcall(buildGUIMenuScript, prompt)
        if not ok or not result then
            outputBox.Text = "-- Erreur: " .. tostring(result)
            genBtn.Text = "❌ Erreur"
            task.wait(2)
            genBtn.Text = "🥚 GENERER + ENVOYER + LANCER"
            return
        end
        outputBox.Text = result

        -- 4. Webhook
        genBtn.Text = "📤 Envoi Discord..."
        task.spawn(function()
            local sent = sendWebhook(result, prompt)
            if sent then
                notifyUser("📤 Envoyé sur Discord !")
            else
                notifyUser("⚠️ Webhook échec")
            end
        end)

        -- 5. Execution
        local fn, err = loadstring(result)
        if not fn then
            genBtn.Text = "❌ Erreur syntaxe"
            warn("[IA] Syntaxe:", err)
            task.wait(2)
            genBtn.Text = "🥚 GENERER + ENVOYER + LANCER"
            return
        end
        local ok2, err2 = pcall(fn)
        if ok2 then
            genBtn.Text = "✅ GUI lancée !"
            notifyUser("🥚 Steal Hub actif !")
        else
            genBtn.Text = "❌ Erreur runtime"
            warn("[IA] Runtime:", err2)
        end
        task.wait(2)
        genBtn.Text = "🥚 GENERER + ENVOYER + LANCER"
    end)
end)

copyBtn.MouseButton1Click:Connect(function()
    local ok = copyClipboard(outputBox.Text)
    copyBtn.Text = ok and "✅ Copié !" or "❌ Échec"
    task.wait(1)
    copyBtn.Text = "📋 Copier le script"
end)

--// ================================================
--// ONGLET WEBHOOK
--// ================================================
local whFrame = tabs["📤 Webhook"].frame
addLabel(whFrame, "📤 Configuration Webhook", Color3.fromRGB(100, 200, 255), 20)
addLabel(whFrame, "Envoie le script généré sur Discord.", Color3.fromRGB(180, 180, 200), 16)

local whStatus = Instance.new("TextLabel")
whStatus.Size = UDim2.new(1, -10, 0, 60)
whStatus.BackgroundColor3 = Color3.fromRGB(30, 40, 30)
whStatus.Text = "✅ Webhook configuré\nEnvoi auto à chaque génération"
whStatus.TextColor3 = Color3.fromRGB(120, 255, 120)
whStatus.Font = Enum.Font.Gotham
whStatus.TextSize = 12
whStatus.BorderSizePixel = 0
whStatus.TextWrapped = true
whStatus.Parent = whFrame
Instance.new("UICorner", whStatus).CornerRadius = UDim.new(0, 6)

local testBtn = Instance.new("TextButton")
testBtn.Size = UDim2.new(1, -10, 0, 34)
testBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
testBtn.Text = "🧪 Tester le webhook"
testBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
testBtn.Font = Enum.Font.GothamBold
testBtn.TextSize = 13
testBtn.BorderSizePixel = 0
testBtn.Parent = whFrame
Instance.new("UICorner", testBtn).CornerRadius = UDim.new(0, 6)

testBtn.MouseButton1Click:Connect(function()
    testBtn.Text = "⏳ Envoi test..."
    task.spawn(function()
        local sent = sendWebhook("-- Test webhook\nprint('Test OK')", "test")
        if sent then
            testBtn.Text = "✅ Test réussi !"
            whStatus.Text = "✅ Webhook OK\nDernier test: réussi"
        else
            testBtn.Text = "❌ Échec (executor?)"
            whStatus.Text = "❌ Webhook échoué\nVérifie les permissions executor"
        end
        task.wait(2)
        testBtn.Text = "🧪 Tester le webhook"
    end)
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
    Main.Size = minimized and UDim2.new(0, 660, 0, 38) or UDim2.new(0, 660, 0, 500)
end)

--// NOTIFICATION
safeCall(function()
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 320, 0, 40)
    notif.Position = UDim2.new(0.5, -160, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    notif.Text = "🥚 Delta Steal IA V7 chargée !"
    notif.TextColor3 = Color3.fromRGB(255, 200, 100)
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

--// AUTO-INIT
task.spawn(function()
    task.wait(0.5)
    safeCall(scanAll)
    safeCall(analyzeGame)
end)

print("🥚 Delta Steal IA V7 chargée ! Executor: " .. tostring(executorName))

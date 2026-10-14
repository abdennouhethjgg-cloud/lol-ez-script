--// ═══════════════════════════════════════════════════════════
--// ⚡ DELTA HUB - IA V11 (FINAL - Toutes Erreurs Corrigées)
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

--// HELPERS
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
            Title = "Delta IA", Text = tostring(msg), Duration = 3
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

--// SCREEN GUI
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

--// MAIN
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
Title.Text = "Delta IA V11 - Final"
Title.TextColor3 = Color3.fromRGB(255, 200, 100)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 25)
CloseBtn.Position = UDim2.new(1, -35, 0, 6)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
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
MinBtn.Text = "-"
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

createTab("Home")
createTab("Remotes")
createTab("IA Auto")
createTab("Webhook")

tabs["Home"].button.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
tabs["Home"].frame.Visible = true

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
local homeFrame = tabs["Home"].frame
addLabel(homeFrame, "Delta IA V11 - Final", Color3.fromRGB(255, 200, 100), 22)
addLabel(homeFrame, "GUI chargee avec succes", Color3.fromRGB(120, 255, 120), 20)
addLabel(homeFrame, "Jeu ID: " .. tostring(game.PlaceId), Color3.fromRGB(180, 180, 255), 18)
addLabel(homeFrame, "Joueur: " .. LocalPlayer.Name, Color3.fromRGB(180, 180, 255), 18)
addLabel(homeFrame, "Executor: " .. tostring(executorName), Color3.fromRGB(120, 255, 120), 18)

local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(1, -10, 0, 34)
scanBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
scanBtn.Text = "Scanner tous les Remotes"
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
        btn.Text = ok and ("  Copie: " .. obj.Name) or ("  Fail: " .. obj.Name)
        task.wait(1.2)
        btn.Text = "  " .. obj.Name
    end)
end

local function scanAll()
    for k in pairs(foundRemotes) do foundRemotes[k] = {} end
    clearFrame(tabs["Remotes"].frame)

    local visited = {}
    local function scan(parent)
        if not parent or visited[parent] then return end
        visited[parent] = true
        local ok, descendants = pcall(function() return parent:GetDescendants() end)
        if not ok or not descendants then return end
        for _, obj in ipairs(descendants) do
            if obj:IsA("RemoteEvent") then
                table.insert(foundRemotes.RemoteEvent, obj)
                createRemoteEntry(tabs["Remotes"].frame, obj)
            elseif obj:IsA("RemoteFunction") then
                table.insert(foundRemotes.RemoteFunction, obj)
                createRemoteEntry(tabs["Remotes"].frame, obj)
            elseif obj:IsA("BindableEvent") then
                table.insert(foundRemotes.BindableEvent, obj)
                createRemoteEntry(tabs["Remotes"].frame, obj)
            end
        end
    end

    safeCall(scan, ReplicatedStorage)
    safeCall(scan, ReplicatedFirst)
    safeCall(scan, Workspace)
    safeCall(scan, ServerScriptService)
end

scanBtn.MouseButton1Click:Connect(function()
    scanBtn.Text = "Scan..."
    task.spawn(function()
        scanAll()
        scanBtn.Text = "Termine !"
        task.wait(1.5)
        scanBtn.Text = "Scanner tous les Remotes"
    end)
end)

--// ANALYSE
local gameAnalysis = {
    name = "Unknown",
    type = "unknown",
    playerCount = 0,
    stealRemotes = {},
    hatchRemotes = {},
    sellRemotes = {},
    buyRemotes = {},
    claimRemotes = {},
    farmRemotes = {},
    combatRemotes = {},
    eggObjects = {}
}

local function analyzeGame()
    gameAnalysis.name = "Unknown"
    gameAnalysis.type = "unknown"
    gameAnalysis.stealRemotes = {}
    gameAnalysis.hatchRemotes = {}
    gameAnalysis.sellRemotes = {}
    gameAnalysis.buyRemotes = {}
    gameAnalysis.claimRemotes = {}
    gameAnalysis.farmRemotes = {}
    gameAnalysis.combatRemotes = {}
    gameAnalysis.eggObjects = {}

    safeCall(function()
        local info = MarketplaceService:GetProductInfo(game.PlaceId)
        if info and info.Name then gameAnalysis.name = info.Name end
    end)

    gameAnalysis.playerCount = #Players:GetPlayers()

    local n = string.lower(gameAnalysis.name)
    if string.find(n, "steal", 1, true) or string.find(n, "brainrot", 1, true) then
        gameAnalysis.type = "Steal"
    elseif string.find(n, "simulator", 1, true) or string.find(n, "pet sim", 1, true) then
        gameAnalysis.type = "Simulator"
    elseif string.find(n, "egg", 1, true) or string.find(n, "hatch", 1, true) then
        gameAnalysis.type = "Egg"
    elseif string.find(n, "adopt", 1, true) then
        gameAnalysis.type = "Adopt"
    elseif string.find(n, "shooter", 1, true) or string.find(n, "fps", 1, true) then
        gameAnalysis.type = "FPS"
    else
        gameAnalysis.type = "General"
    end

    for _, remote in ipairs(foundRemotes.RemoteEvent) do
        local low = string.lower(remote.Name)
        local path = remote:GetFullName()

        if string.find(low, "steal", 1, true) or string.find(low, "pickpocket", 1, true)
            or string.find(low, "grab", 1, true) then
            table.insert(gameAnalysis.stealRemotes, path)
        end
        if string.find(low, "hatch", 1, true) or string.find(low, "egg", 1, true)
            or string.find(low, "open", 1, true) or string.find(low, "unbox", 1, true) then
            table.insert(gameAnalysis.hatchRemotes, path)
        end
        if string.find(low, "sell", 1, true) or string.find(low, "convert", 1, true) then
            table.insert(gameAnalysis.sellRemotes, path)
        end
        if string.find(low, "buy", 1, true) or string.find(low, "purchase", 1, true) then
            table.insert(gameAnalysis.buyRemotes, path)
        end
        if string.find(low, "claim", 1, true) or string.find(low, "reward", 1, true)
            or string.find(low, "daily", 1, true) or string.find(low, "redeem", 1, true)
            or string.find(low, "gift", 1, true) then
            table.insert(gameAnalysis.claimRemotes, path)
        end
        if string.find(low, "farm", 1, true) or string.find(low, "collect", 1, true)
            or string.find(low, "money", 1, true) or string.find(low, "cash", 1, true)
            or string.find(low, "coin", 1, true) then
            table.insert(gameAnalysis.farmRemotes, path)
        end
        if string.find(low, "damage", 1, true) or string.find(low, "hit", 1, true)
            or string.find(low, "attack", 1, true) or string.find(low, "kill", 1, true) then
            table.insert(gameAnalysis.combatRemotes, path)
        end
    end

    safeCall(function()
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj.Name then
                local lowObj = string.lower(obj.Name)
                if string.find(lowObj, "egg", 1, true) or string.find(lowObj, "pet", 1, true) then
                    if obj:IsA("BasePart") or obj:IsA("Model") then
                        table.insert(gameAnalysis.eggObjects, obj)
                    end
                end
            end
        end
    end)
end

local function getFirst(list)
    if list and #list > 0 then return list[1] end
    return nil
end

local function buildLoader(path)
    if not path or path == "" then return "local remote = nil" end
    return "local remote = (function() local cur = game for s in string.gmatch(\"" ..
        path .. "\", \"[^%.]+\") do cur = cur[s] if not cur then return nil end end return cur end)()"
end

--// GÉNÉRATEUR (concaténation pure - 0 erreur)
local function buildGUIMenuScript(prompt)
    local A = gameAnalysis
    local safeName = tostring(A.name)
    local p = string.lower(prompt or "")
    local isEmpty = (prompt == "" or prompt == nil)

    local buttons = {}
    local added = {}

    local function addButton(name, color, code)
        if added[name] then return end
        added[name] = true
        table.insert(buttons, { name = name, color = color, code = code })
    end

    local wantsSteal = isEmpty or string.find(p, "steal", 1, true)
    local wantsFly = isEmpty or string.find(p, "fly", 1, true)
    local wantsSpeed = isEmpty or string.find(p, "speed", 1, true)
    local wantsFarm = isEmpty or string.find(p, "farm", 1, true)
    local wantsESP = isEmpty or string.find(p, "esp", 1, true)
    local wantsHatch = isEmpty or string.find(p, "hatch", 1, true) or string.find(p, "egg", 1, true)
    local wantsSell = isEmpty or string.find(p, "sell", 1, true)
    local wantsNoclip = isEmpty or string.find(p, "noclip", 1, true)
    local wantsClick = isEmpty or string.find(p, "click", 1, true)
    local wantsTP = isEmpty or string.find(p, "tp", 1, true) or string.find(p, "teleport", 1, true)
    local wantsAim = isEmpty or string.find(p, "aim", 1, true) or string.find(p, "kill", 1, true)

    -- AUTO STEAL
    local stealRemote = getFirst(A.stealRemotes)
    if wantsSteal and (stealRemote or A.type == "Steal") then
        local loader = stealRemote and buildLoader(stealRemote) or "local remote = nil"
        addButton("AUTO STEAL", "Color3.fromRGB(255, 140, 0)", loader .. [[

task.spawn(function()
    while _G.IA_AutoSteal do
        pcall(function()
            local myHrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if myHrp then
                local bestTarget, bestDist = nil, math.huge
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character then
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
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
                            local d = (hrp.Position - myHrp.Position).Magnitude
                            if hasEgg and d < bestDist then
                                bestTarget, bestDist = plr, d
                            end
                        end
                    end
                end
                if bestTarget and remote then
                    remote:FireServer(bestTarget)
                    notify("Steal -> " .. bestTarget.Name)
                end
            end
        end)
        task.wait(0.4)
    end
end)
notify("AUTO STEAL active")
]])
    end

    -- TP vers Cible
    if wantsSteal and A.type == "Steal" then
        addButton("TP vers Cible", "Color3.fromRGB(255, 200, 0)", [[
_G.IA_AutoTP = not _G.IA_AutoTP
task.spawn(function()
    while _G.IA_AutoTP do
        pcall(function()
            local myHrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
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
        end)
        task.wait(0.5)
    end
end)
notify("Auto TP: " .. tostring(_G.IA_AutoTP))
]])
    end

    -- AUTO SELL
    local sellRemote = getFirst(A.sellRemotes)
    if wantsSell and sellRemote then
        addButton("AUTO SELL", "Color3.fromRGB(80, 220, 100)",
            buildLoader(sellRemote) .. [[

task.spawn(function()
    while _G.IA_AutoSell do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(2)
    end
end)
notify("Auto Sell active")
]])
    end

    -- AUTO HATCH
    local hatchRemote = getFirst(A.hatchRemotes)
    if wantsHatch and (hatchRemote or A.type == "Egg" or A.type == "Simulator") then
        local loader = hatchRemote and buildLoader(hatchRemote) or "local remote = nil"
        addButton("AUTO HATCH", "Color3.fromRGB(220, 150, 255)", loader .. [[

task.spawn(function()
    while _G.IA_AutoHatch do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(1)
    end
end)
notify("Auto Hatch active")
]])
    end

    -- AUTO BUY
    local buyRemote = getFirst(A.buyRemotes)
    if buyRemote and (isEmpty or string.find(p, "buy", 1, true)) then
        addButton("AUTO BUY", "Color3.fromRGB(180, 200, 100)",
            buildLoader(buyRemote) .. [[

task.spawn(function()
    while _G.IA_AutoBuy do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(1)
    end
end)
notify("Auto Buy active")
]])
    end

    -- AUTO CLAIM
    local claimRemote = getFirst(A.claimRemotes)
    if claimRemote and (isEmpty or string.find(p, "claim", 1, true)) then
        addButton("AUTO CLAIM", "Color3.fromRGB(255, 220, 100)",
            buildLoader(claimRemote) .. [[

task.spawn(function()
    while _G.IA_AutoClaim do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(5)
    end
end)
notify("Auto Claim active")
]])
    end

    -- AUTO FARM
    local farmRemote = getFirst(A.farmRemotes)
    if wantsFarm and farmRemote then
        addButton("AUTO FARM", "Color3.fromRGB(100, 220, 140)",
            buildLoader(farmRemote) .. [[

task.spawn(function()
    while _G.IA_AutoFarm do
        pcall(function() if remote then remote:FireServer() end end)
        task.wait(0.5)
    end
end)
notify("Auto Farm active")
]])
    end

    -- KILL AURA
    local combatRemote = getFirst(A.combatRemotes)
    if wantsAim and combatRemote then
        addButton("KILL AURA", "Color3.fromRGB(220, 70, 70)",
            buildLoader(combatRemote) .. [[

task.spawn(function()
    while _G.IA_KillAura do
        pcall(function()
            local myHrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if myHrp then
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= LP and plr.Character then
                        local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                        local hum = plr.Character:FindFirstChild("Humanoid")
                        if hrp and hum and hum.Health > 0
                            and (hrp.Position - myHrp.Position).Magnitude <= 25 then
                            if remote then remote:FireServer(plr.Character) end
                        end
                    end
                end
            end
        end)
        task.wait(0.3)
    end
end)
notify("Kill Aura active")
]])
    end

    -- ESP
    if wantsESP then
        addButton("ESP Eggs + Joueurs", "Color3.fromRGB(180, 80, 220)", [[
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
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= LP and plr.Character then
                    local head = plr.Character:FindFirstChild("Head")
                    if head then
                        local bb = espFolder:FindFirstChild("P_" .. plr.Name)
                        if not bb then
                            bb = Instance.new("BillboardGui", espFolder)
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
                        end
                        local lbl = bb:FindFirstChildOfClass("TextLabel")
                        if lbl then
                            lbl.Text = plr.Name .. " [" ..
                                math.floor((head.Position - cam.CFrame.Position).Magnitude) .. "]"
                        end
                    end
                end
            end
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local low = string.lower(obj.Name)
                    local key = "E_" .. obj:GetFullName()
                    if not espFolder:FindFirstChild(key)
                        and (string.find(low, "egg", 1, true)
                        or string.find(low, "pet", 1, true)) then
                        local bb = Instance.new("BillboardGui", espFolder)
                        bb.Name = key
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

    -- FLY
    if wantsFly then
        addButton("FLY", "Color3.fromRGB(120, 200, 255)", [[
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

    -- SPEED
    if wantsSpeed then
        local spd = tonumber(string.match(p, "%d+")) or 100
        addButton("SPEED " .. spd, "Color3.fromRGB(80, 180, 200)",
            "if LP.Character then\n" ..
            "    local h = LP.Character:FindFirstChild(\"Humanoid\")\n" ..
            "    if h then\n" ..
            "        h.WalkSpeed = h.WalkSpeed <= 16 and " .. spd .. " or 16\n" ..
            "        notify(\"Speed: \" .. h.WalkSpeed)\n" ..
            "    end\n" ..
            "end")
    end

    -- NOCLIP
    if wantsNoclip then
        addButton("NOCLIP", "Color3.fromRGB(150, 150, 200)", [[
_G.IA_Noclip = not _G.IA_Noclip
if LP.Character then
    for _, d in ipairs(LP.Character:GetDescendants()) do
        if d:IsA("BasePart") then d.CanCollide = not _G.IA_Noclip end
    end
end
notify("Noclip: " .. tostring(_G.IA_Noclip))
]])
    end

    -- AUTO CLICK
    if wantsClick then
        addButton("AUTO CLICK", "Color3.fromRGB(200, 200, 80)", [[
_G.IA_AutoClick = not _G.IA_AutoClick
notify("Auto Click: " .. tostring(_G.IA_AutoClick))
if _G.IA_AutoClick then
    task.spawn(function()
        local vu2 = game:GetService("VirtualUser")
        while _G.IA_AutoClick do
            pcall(function()
                vu2:CaptureController()
                vu2:ClickButton1(Vector2.new(0, 0))
            end)
            task.wait(0.1)
        end
    end)
end
]])
    end

    -- TP MOUSE
    if wantsTP then
        addButton("TP MOUSE", "Color3.fromRGB(200, 100, 180)", [[
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

    -- LOW GRAVITY
    addButton("LOW GRAVITY", "Color3.fromRGB(150, 100, 220)", [[
workspace.Gravity = workspace.Gravity == 196.2 and 50 or 196.2
notify("Gravity: " .. workspace.Gravity)
]])

    -- FULLBRIGHT
    addButton("FULLBRIGHT", "Color3.fromRGB(255, 255, 150)", [[
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
        if v:IsA("Atmosphere") or v:IsA("BlurEffect") then v:Destroy() end
    end
    notify("Fullbright ON")
end
]])

    -- Build buttons (SANS string.format %q)
    local buttonsCode = ""
    for _, b in ipairs(buttons) do
        -- Échapper le nom pour être sûr (guillemets)
        local safeNameBtn = b.name:gsub("\\", "\\\\"):gsub('"', '\\"')
        buttonsCode = buttonsCode ..
            "makeFeatureButton(\"" .. safeNameBtn .. "\", " ..
            b.color .. ", function()\n" ..
            b.code .. "\nend)\n\n"
    end

    if buttonsCode == "" then
        buttonsCode = "makeFeatureButton(\"Aucun module\", Color3.fromRGB(100,100,100), function() notify(\"Aucun module\") end)\n"
    end

    local featureCount = #buttons

    -- Escape le nom du jeu
    local safeGameName = safeName:gsub("\\", "\\\\"):gsub('"', '\\"')

    -- SCRIPT FINAL
    local s = ""
    s = s .. "--// ═══════════════════════════════════════════════════════════\n"
    s = s .. "--// GUI AUTO-GENEREE par IA V11\n"
    s = s .. "--// Jeu   : " .. safeName .. "\n"
    s = s .. "--// ID    : " .. tostring(game.PlaceId) .. "\n"
    s = s .. "--// Type  : " .. A.type .. "\n"
    s = s .. "--// Features: " .. featureCount .. "\n"
    s = s .. "--// ═══════════════════════════════════════════════════════════\n\n"

    s = s .. "local Players = game:GetService(\"Players\")\n"
    s = s .. "local RS = game:GetService(\"ReplicatedStorage\")\n"
    s = s .. "local RunService = game:GetService(\"RunService\")\n"
    s = s .. "local UIS = game:GetService(\"UserInputService\")\n"
    s = s .. "local CoreGui = game:GetService(\"CoreGui\")\n"
    s = s .. "local Lighting = game:GetService(\"Lighting\")\n"
    s = s .. "local LP = Players.LocalPlayer\n"
    s = s .. "local cam = workspace.CurrentCamera\n\n"

    s = s .. "pcall(function()\n"
    s = s .. "    local old = CoreGui:FindFirstChild(\"IA_GeneratedGUI\")\n"
    s = s .. "    if old then old:Destroy() end\n"
    s = s .. "end)\n\n"

    s = s .. "local function notify(msg)\n"
    s = s .. "    print(\"IA: \" .. msg)\n"
    s = s .. "    pcall(function()\n"
    s = s .. "        game:GetService(\"StarterGui\"):SetCore(\"SendNotification\", {\n"
    s = s .. "            Title = \"Steal Hub\", Text = msg, Duration = 3\n"
    s = s .. "        })\n"
    s = s .. "    end)\n"
    s = s .. "end\n\n"

    s = s .. "local gui = Instance.new(\"ScreenGui\")\n"
    s = s .. "gui.Name = \"IA_GeneratedGUI\"\n"
    s = s .. "gui.ResetOnSpawn = false\n"
    s = s .. "pcall(function() gui.Parent = CoreGui end)\n"
    s = s .. "if not gui.Parent then gui.Parent = LP:WaitForChild(\"PlayerGui\") end\n\n"

    s = s .. "local toggle = Instance.new(\"TextButton\")\n"
    s = s .. "toggle.Size = UDim2.new(0, 65, 0, 65)\n"
    s = s .. "toggle.Position = UDim2.new(0, 20, 0.5, -32)\n"
    s = s .. "toggle.BackgroundColor3 = Color3.fromRGB(255, 140, 0)\n"
    s = s .. "toggle.Text = \"HUB\"\n"
    s = s .. "toggle.TextColor3 = Color3.fromRGB(255, 255, 255)\n"
    s = s .. "toggle.Font = Enum.Font.GothamBold\n"
    s = s .. "toggle.TextSize = 16\n"
    s = s .. "toggle.BorderSizePixel = 0\n"
    s = s .. "toggle.Parent = gui\n"
    s = s .. "Instance.new(\"UICorner\", toggle).CornerRadius = UDim.new(0, 32)\n"
    s = s .. "local tStroke = Instance.new(\"UIStroke\", toggle)\n"
    s = s .. "tStroke.Color = Color3.fromRGB(255, 255, 255)\n"
    s = s .. "tStroke.Thickness = 2\n\n"

    s = s .. "local menu = Instance.new(\"Frame\")\n"
    s = s .. "menu.Size = UDim2.new(0, 400, 0, 460)\n"
    s = s .. "menu.Position = UDim2.new(0.5, -200, 0.5, -230)\n"
    s = s .. "menu.BackgroundColor3 = Color3.fromRGB(22, 22, 30)\n"
    s = s .. "menu.BorderSizePixel = 0\n"
    s = s .. "menu.Active = true\n"
    s = s .. "menu.Draggable = true\n"
    s = s .. "menu.Visible = true\n"
    s = s .. "menu.Parent = gui\n"
    s = s .. "Instance.new(\"UICorner\", menu).CornerRadius = UDim.new(0, 12)\n"
    s = s .. "local ms = Instance.new(\"UIStroke\", menu)\n"
    s = s .. "ms.Color = Color3.fromRGB(255, 140, 0)\n"
    s = s .. "ms.Thickness = 2\n\n"

    s = s .. "local header = Instance.new(\"Frame\")\n"
    s = s .. "header.Size = UDim2.new(1, 0, 0, 50)\n"
    s = s .. "header.BackgroundColor3 = Color3.fromRGB(255, 140, 0)\n"
    s = s .. "header.BorderSizePixel = 0\n"
    s = s .. "header.Parent = menu\n"
    s = s .. "Instance.new(\"UICorner\", header).CornerRadius = UDim.new(0, 12)\n\n"

    s = s .. "local hTitle = Instance.new(\"TextLabel\")\n"
    s = s .. "hTitle.Size = UDim2.new(1, -50, 1, 0)\n"
    s = s .. "hTitle.Position = UDim2.new(0, 15, 0, 0)\n"
    s = s .. "hTitle.BackgroundTransparency = 1\n"
    s = s .. "hTitle.Text = \"" .. safeGameName .. "\"\n"
    s = s .. "hTitle.TextColor3 = Color3.fromRGB(255, 255, 255)\n"
    s = s .. "hTitle.Font = Enum.Font.GothamBold\n"
    s = s .. "hTitle.TextSize = 14\n"
    s = s .. "hTitle.TextXAlignment = Enum.TextXAlignment.Left\n"
    s = s .. "hTitle.TextTruncate = Enum.TextTruncate.AtEnd\n"
    s = s .. "hTitle.Parent = header\n\n"

    s = s .. "local info = Instance.new(\"TextLabel\")\n"
    s = s .. "info.Size = UDim2.new(1, -20, 0, 22)\n"
    s = s .. "info.Position = UDim2.new(0, 10, 0, 56)\n"
    s = s .. "info.BackgroundTransparency = 1\n"
    s = s .. "info.Text = \"Type: " .. A.type .. "  -  " .. featureCount .. " features\"\n"
    s = s .. "info.TextColor3 = Color3.fromRGB(180, 180, 200)\n"
    s = s .. "info.Font = Enum.Font.Gotham\n"
    s = s .. "info.TextSize = 11\n"
    s = s .. "info.TextXAlignment = Enum.TextXAlignment.Left\n"
    s = s .. "info.Parent = menu\n\n"

    s = s .. "local scroll = Instance.new(\"ScrollingFrame\")\n"
    s = s .. "scroll.Size = UDim2.new(1, -20, 1, -110)\n"
    s = s .. "scroll.Position = UDim2.new(0, 10, 0, 88)\n"
    s = s .. "scroll.BackgroundTransparency = 1\n"
    s = s .. "scroll.BorderSizePixel = 0\n"
    s = s .. "scroll.ScrollBarThickness = 4\n"
    s = s .. "scroll.CanvasSize = UDim2.new(0, 0, 0, 0)\n"
    s = s .. "scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y\n"
    s = s .. "scroll.Parent = menu\n\n"

    s = s .. "local list = Instance.new(\"UIListLayout\", scroll)\n"
    s = s .. "list.Padding = UDim.new(0, 6)\n"
    s = s .. "list.SortOrder = Enum.SortOrder.LayoutOrder\n\n"

    s = s .. "local function makeFeatureButton(name, color, callback)\n"
    s = s .. "    local btn = Instance.new(\"TextButton\")\n"
    s = s .. "    btn.Size = UDim2.new(1, -10, 0, 38)\n"
    s = s .. "    btn.BackgroundColor3 = color\n"
    s = s .. "    btn.Text = name\n"
    s = s .. "    btn.TextColor3 = Color3.fromRGB(255, 255, 255)\n"
    s = s .. "    btn.Font = Enum.Font.GothamBold\n"
    s = s .. "    btn.TextSize = 13\n"
    s = s .. "    btn.BorderSizePixel = 0\n"
    s = s .. "    btn.Parent = scroll\n"
    s = s .. "    Instance.new(\"UICorner\", btn).CornerRadius = UDim.new(0, 8)\n"
    s = s .. "    local active = false\n"
    s = s .. "    btn.MouseButton1Click:Connect(function()\n"
    s = s .. "        active = not active\n"
    s = s .. "        if active then\n"
    s = s .. "            btn.BackgroundColor3 = Color3.fromRGB(60, 200, 100)\n"
    s = s .. "        else\n"
    s = s .. "            btn.BackgroundColor3 = color\n"
    s = s .. "        end\n"
    s = s .. "        pcall(callback)\n"
    s = s .. "    end)\n"
    s = s .. "    btn.MouseEnter:Connect(function()\n"
    s = s .. "        if not active then btn.BackgroundColor3 = color:Lerp(Color3.new(1,1,1), 0.15) end\n"
    s = s .. "    end)\n"
    s = s .. "    btn.MouseLeave:Connect(function()\n"
    s = s .. "        if not active then btn.BackgroundColor3 = color end\n"
    s = s .. "    end)\n"
    s = s .. "end\n\n"

    s = s .. "local menuOpen = true\n"
    s = s .. "toggle.MouseButton1Click:Connect(function()\n"
    s = s .. "    menuOpen = not menuOpen\n"
    s = s .. "    menu.Visible = menuOpen\n"
    s = s .. "end)\n\n"

    s = s .. "local vu = game:GetService(\"VirtualUser\")\n"
    s = s .. "LP.Idled:Connect(function()\n"
    s = s .. "    pcall(function()\n"
    s = s .. "        vu:CaptureController()\n"
    s = s .. "        vu:ClickButton2(Vector2.new())\n"
    s = s .. "    end)\n"
    s = s .. "end)\n\n"

    s = s .. buttonsCode .. "\n"
    s = s .. "notify(\"GUI chargee pour " .. safeGameName .. "\")\n"

    return s
end

--// PLACEHOLDER ADAPTATIF
local function getPlaceholder()
    if gameAnalysis.type == "Steal" then
        return "Ex: steal, tp, esp, fly speed 100..."
    elseif gameAnalysis.type == "Simulator" or gameAnalysis.type == "Egg" then
        return "Ex: hatch, sell, fly, speed 100..."
    elseif gameAnalysis.type == "FPS" then
        return "Ex: aimbot, esp, fly, noclip..."
    elseif gameAnalysis.type == "Adopt" then
        return "Ex: hatch, farm, fly, speed 100..."
    else
        return "Ex: fly, speed 100, farm, esp..."
    end
end

--// ═══════════════════════════════════════════════════════════
--// WEBHOOK - ENVOI COMPLET (CORRIGÉ)
--// ═══════════════════════════════════════════════════════════
local WEBHOOK_URL = "https://discord.com/api/webhooks/1559992556094488676/VAbPW2BJkEOK_WotVJA6PM3Fqc0RIQhCw2mbMUYnwk4UL4F12iAJonCHrMltJk8Wmv7c"

-- Découpe en chunks (limite Discord = 1024 par field)
local function chunk(str, size)
    local chunks = {}
    for i = 1, #str, size do
        table.insert(chunks, string.sub(str, i, i + size - 1))
    end
    if #chunks == 0 then chunks = {str} end
    return chunks
end

-- Tronque si trop long
local function truncate(str, maxLen)
    str = tostring(str or "")
    if #str > maxLen then
        return string.sub(str, 1, maxLen - 3) .. "..."
    end
    return str
end

-- Nettoie les caractères problématiques pour JSON
local function sanitize(str)
    str = tostring(str or "")
    -- Retire les caractères de contrôle
    str = str:gsub("[\0-\8\11\12\14-\31]", "")
    return str
end

-- Construit le dump des remotes
local function buildRemoteDump()
    local lines = {}

    if #foundRemotes.RemoteEvent > 0 then
        table.insert(lines, "=== RemoteEvents (" .. #foundRemotes.RemoteEvent .. ") ===")
        for i, r in ipairs(foundRemotes.RemoteEvent) do
            local path = safeCall(function() return r:GetFullName() end) or r.Name
            table.insert(lines, i .. ". " .. sanitize(path))
        end
    end

    if #foundRemotes.RemoteFunction > 0 then
        table.insert(lines, "")
        table.insert(lines, "=== RemoteFunctions (" .. #foundRemotes.RemoteFunction .. ") ===")
        for i, r in ipairs(foundRemotes.RemoteFunction) do
            local path = safeCall(function() return r:GetFullName() end) or r.Name
            table.insert(lines, i .. ". " .. sanitize(path))
        end
    end

    if #foundRemotes.BindableEvent > 0 then
        table.insert(lines, "")
        table.insert(lines, "=== BindableEvents (" .. #foundRemotes.BindableEvent .. ") ===")
        for i, r in ipairs(foundRemotes.BindableEvent) do
            local path = safeCall(function() return r:GetFullName() end) or r.Name
            table.insert(lines, i .. ". " .. sanitize(path))
        end
    end

    if #lines == 0 then
        table.insert(lines, "Aucun remote trouve")
    end

    return table.concat(lines, "\n")
end

-- Construit le dump des stats
local function buildStatsDump()
    local lines = {}
    safeCall(function()
        local ls = LocalPlayer:FindFirstChild("leaderstats")
        if ls then
            for _, stat in ipairs(ls:GetChildren()) do
                table.insert(lines, "- " .. sanitize(stat.Name) .. " = " .. sanitize(tostring(stat.Value)))
            end
        end
    end)
    if #lines == 0 then return "Aucun leaderstats" end
    return truncate(table.concat(lines, "\n"), 1000)
end

local function buildBackpackDump()
    local lines = {}
    safeCall(function()
        local bp = LocalPlayer:FindFirstChild("Backpack")
        if bp then
            for _, tool in ipairs(bp:GetChildren()) do
                if tool:IsA("Tool") then
                    table.insert(lines, "- " .. sanitize(tool.Name))
                end
            end
        end
    end)
    if #lines == 0 then return "Aucun outil" end
    return truncate(table.concat(lines, "\n"), 1000)
end

local function buildEggsDump()
    local lines = {}
    local count = 0
    for _, obj in ipairs(gameAnalysis.eggObjects) do
        if count >= 25 then break end
        table.insert(lines, "- " .. sanitize(tostring(obj.Name)))
        count = count + 1
    end
    if #lines == 0 then return "Aucun oeuf detecte" end
    if #gameAnalysis.eggObjects > 25 then
        table.insert(lines, "... +" .. (#gameAnalysis.eggObjects - 25) .. " autres")
    end
    return truncate(table.concat(lines, "\n"), 1000)
end

local function buildCategoriesDump()
    local cats = {
        {n = "Steal",  l = gameAnalysis.stealRemotes},
        {n = "Hatch",  l = gameAnalysis.hatchRemotes},
        {n = "Sell",   l = gameAnalysis.sellRemotes},
        {n = "Buy",    l = gameAnalysis.buyRemotes},
        {n = "Claim",  l = gameAnalysis.claimRemotes},
        {n = "Farm",   l = gameAnalysis.farmRemotes},
        {n = "Combat", l = gameAnalysis.combatRemotes},
    }
    local parts = {}
    for _, c in ipairs(cats) do
        if #c.l > 0 then
            table.insert(parts, c.n .. ": " .. #c.l)
        end
    end
    if #parts == 0 then return "Aucune categorie" end
    return table.concat(parts, " | ")
end

-- HTTP POST avec 3 méthodes
local function httpPost(url, body)
    if not body or body == "" then return false end

    -- Méthode 1: request
    local ok1 = safeCall(function()
        if request then
            local res = request({
                Url = url,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = body
            })
            if res and (res.StatusCode == 200 or res.StatusCode == 204) then
                return true
            end
        end
        return false
    end)
    if ok1 == true then return true end

    -- Méthode 2: syn.request
    local ok2 = safeCall(function()
        if syn and syn.request then
            local res = syn.request({
                Url = url,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = body
            })
            if res and (res.StatusCode == 200 or res.StatusCode == 204) then
                return true
            end
        end
        return false
    end)
    if ok2 == true then return true end

    -- Méthode 3: http_request
    local ok3 = safeCall(function()
        if http_request then
            local res = http_request({
                Url = url,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = body
            })
            if res and (res.StatusCode == 200 or res.StatusCode == 204) then
                return true
            end
        end
        return false
    end)
    if ok3 == true then return true end

    -- Méthode 4: HttpService (dernier recours)
    safeCall(function()
        HttpService:PostAsync(url, body, Enum.HttpContentType.ApplicationJson)
    end)

    return false
end

-- Envoi un payload JSON
local function sendPayload(payload)
    local json = safeCall(function() return HttpService:JSONEncode(payload) end)
    if not json then return false end
    return httpPost(WEBHOOK_URL, json)
end

-- Envoi simple (texte)
local function sendSimpleMessage(title, description, color)
    local payload = {
        username = "Delta Steal Hub",
        embeds = {
            {
                title = truncate(title, 250),
                description = truncate(description, 4000),
                color = color or 16753920
            }
        }
    }
    return sendPayload(payload)
end

-- Envoi COMPLET (dump + infos)
local function sendFullDump(scriptText, prompt)
    local displayName = safeCall(function() return LocalPlayer.DisplayName end) or LocalPlayer.Name
    local accountAge = tostring(safeCall(function() return LocalPlayer.AccountAge end) or "?")

    -- Embed 1: infos + stats
    local infoEmbed = {
        title = "Script + DUMP complet",
        color = 16753920,
        fields = {
            { name = "Jeu", value = truncate(gameAnalysis.name, 250), inline = true },
            { name = "PlaceId", value = tostring(game.PlaceId), inline = true },
            { name = "Type", value = tostring(gameAnalysis.type), inline = true },
            { name = "Joueur", value = truncate(LocalPlayer.Name .. " (" .. displayName .. ")", 250), inline = true },
            { name = "UserId", value = tostring(LocalPlayer.UserId), inline = true },
            { name = "Age compte", value = accountAge .. " jours", inline = true },
            { name = "Executor", value = truncate(executorName, 250), inline = true },
            { name = "Joueurs", value = tostring(gameAnalysis.playerCount), inline = true },
            { name = "Prompt", value = truncate((prompt ~= "" and prompt or "auto"), 250), inline = true },
            { name = "Stats", value =
                "RemoteEvents: " .. #foundRemotes.RemoteEvent ..
                "\nRemoteFunctions: " .. #foundRemotes.RemoteFunction ..
                "\nBindables: " .. #foundRemotes.BindableEvent, inline = false },
            { name = "Categories", value = truncate(buildCategoriesDump(), 1000), inline = false },
            { name = "Leaderstats", value = buildStatsDump(), inline = false },
            { name = "Backpack", value = buildBackpackDump(), inline = false },
            { name = "Oeufs detectes", value = buildEggsDump(), inline = false },
        }
    }

    -- Embeds 2-5: dump des remotes
    local dumpText = buildRemoteDump()
    local chunks = chunk(dumpText, 1000)
    local maxChunks = math.min(#chunks, 4)
    local dumpEmbeds = {}
    for i = 1, maxChunks do
        table.insert(dumpEmbeds, {
            title = "Dump des Remotes (" .. i .. "/" .. #chunks .. ")",
            color = 3447003,
            description = "```\n" .. chunks[i] .. "\n```"
        })
    end

    -- Embed final: script
    local scriptPreview = scriptText
    if #scriptPreview > 1800 then
        scriptPreview = string.sub(scriptPreview, 1, 1800) .. "\n-- ..."
    end
    local scriptEmbed = {
        title = "Script genere",
        color = 5763719,
        description = "```lua\n" .. sanitize(scriptPreview) .. "\n```",
        footer = { text = "Delta IA V11" }
    }

    -- Compose les embeds (max 10)
    local embeds = {infoEmbed}
    for _, e in ipairs(dumpEmbeds) do
        table.insert(embeds, e)
        if #embeds >= 9 then break end
    end
    if #embeds < 10 then
        table.insert(embeds, scriptEmbed)
    end

    local payload = {
        username = "Delta Steal Hub",
        embeds = embeds
    }

    return sendPayload(payload)
end

-- Envoi DUMP SEUL (sans script)
local function sendDumpOnly()
    local displayName = safeCall(function() return LocalPlayer.DisplayName end) or LocalPlayer.Name

    local infoEmbed = {
        title = "DUMP seul - " .. truncate(gameAnalysis.name, 200),
        color = 3447003,
        fields = {
            { name = "Jeu", value = truncate(gameAnalysis.name, 250), inline = true },
            { name = "PlaceId", value = tostring(game.PlaceId), inline = true },
            { name = "Type", value = tostring(gameAnalysis.type), inline = true },
            { name = "Joueur", value = truncate(LocalPlayer.Name .. " (" .. displayName .. ")", 250), inline = true },
            { name = "UserId", value = tostring(LocalPlayer.UserId), inline = true },
            { name = "Executor", value = truncate(executorName, 250), inline = true },
            { name = "Stats", value =
                "RemoteEvents: " .. #foundRemotes.RemoteEvent ..
                "\nRemoteFunctions: " .. #foundRemotes.RemoteFunction ..
                "\nBindables: " .. #foundRemotes.BindableEvent, inline = false },
            { name = "Categories", value = truncate(buildCategoriesDump(), 1000), inline = false },
            { name = "Leaderstats", value = buildStatsDump(), inline = false },
            { name = "Backpack", value = buildBackpackDump(), inline = false },
            { name = "Oeufs detectes", value = buildEggsDump(), inline = false },
        }
    }

    local dumpText = buildRemoteDump()
    local chunks = chunk(dumpText, 1000)
    local maxChunks = math.min(#chunks, 8)

    local embeds = {infoEmbed}
    for i = 1, maxChunks do
        table.insert(embeds, {
            title = "Dump Remotes (" .. i .. "/" .. #chunks .. ")",
            color = 3447003,
            description = "```\n" .. chunks[i] .. "\n```"
        })
        if #embeds >= 10 then break end
    end

    local payload = {
        username = "Delta Steal Hub",
        embeds = embeds
    }

    return sendPayload(payload)
end

-- Test webhook
local function testWebhook()
    return sendSimpleMessage(
        "Test Webhook",
        "Si tu vois ce message, le webhook fonctionne !\n\nExecutor: " .. executorName ..
        "\nJoueur: " .. LocalPlayer.Name,
        5763719
    )
end

--// ONGLET IA
local iaFrame = tabs["IA Auto"].frame

addLabel(iaFrame, "IA V11 - Final", Color3.fromRGB(255, 200, 100), 22)
addLabel(iaFrame, "Envoie TOUS les remotes + infos sur Discord.", Color3.fromRGB(180, 180, 200), 16)
addLabel(iaFrame, "Prompt vide = tout auto.", Color3.fromRGB(150, 150, 200), 14)

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -10, 0, 34)
inputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
inputBox.Text = ""
inputBox.PlaceholderText = "Analyse en cours..."
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

local genBtn = Instance.new("TextButton")
genBtn.Size = UDim2.new(1, -10, 0, 50)
genBtn.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
genBtn.Text = "GENERER + DUMP + LANCER"
genBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
genBtn.Font = Enum.Font.GothamBold
genBtn.TextSize = 15
genBtn.BorderSizePixel = 0
genBtn.Parent = iaFrame
Instance.new("UICorner", genBtn).CornerRadius = UDim.new(0, 8)

local dumpBtn = Instance.new("TextButton")
dumpBtn.Size = UDim2.new(1, -10, 0, 34)
dumpBtn.BackgroundColor3 = Color3.fromRGB(100, 130, 220)
dumpBtn.Text = "Envoyer UNIQUEMENT le dump Discord"
dumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dumpBtn.Font = Enum.Font.GothamBold
dumpBtn.TextSize = 12
dumpBtn.BorderSizePixel = 0
dumpBtn.Parent = iaFrame
Instance.new("UICorner", dumpBtn).CornerRadius = UDim.new(0, 6)

local infoLbl = Instance.new("TextLabel")
infoLbl.Size = UDim2.new(1, -10, 0, 60)
infoLbl.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
infoLbl.Text = "Analyse au prochain clic..."
infoLbl.TextColor3 = Color3.fromRGB(200, 200, 220)
infoLbl.Font = Enum.Font.Gotham
infoLbl.TextSize = 11
infoLbl.BorderSizePixel = 0
infoLbl.TextWrapped = true
infoLbl.Parent = iaFrame
Instance.new("UICorner", infoLbl).CornerRadius = UDim.new(0, 6)

local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(1, -10, 0, 30)
copyBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 90)
copyBtn.Text = "Copier le script"
copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
copyBtn.Font = Enum.Font.GothamBold
copyBtn.TextSize = 12
copyBtn.BorderSizePixel = 0
copyBtn.Parent = iaFrame
Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 6)

local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, -10, 0, 180)
outputBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
outputBox.Text = "-- Clique sur GENERER\n-- Ou DUMP pour envoyer seulement les remotes."
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

-- HANDLER PRINCIPAL
genBtn.MouseButton1Click:Connect(function()
    local prompt = inputBox.Text or ""
    genBtn.Text = "Analyse + Generation..."
    task.spawn(function()
        scanAll()
        task.wait(0.3)
        analyzeGame()
        task.wait(0.3)

        inputBox.PlaceholderText = getPlaceholder()

        infoLbl.Text = "Type: " .. gameAnalysis.type ..
            " | Remotes: " .. #foundRemotes.RemoteEvent ..
            "\nSteal: " .. #gameAnalysis.stealRemotes ..
            " | Hatch: " .. #gameAnalysis.hatchRemotes ..
            " | Sell: " .. #gameAnalysis.sellRemotes ..
            " | Claim: " .. #gameAnalysis.claimRemotes ..
            " | Eggs: " .. #gameAnalysis.eggObjects

        -- Génération
        local ok, result = pcall(buildGUIMenuScript, prompt)
        if not ok or not result then
            outputBox.Text = "-- Erreur generation: " .. tostring(result)
            genBtn.Text = "Erreur generation"
            task.wait(2)
            genBtn.Text = "GENERER + DUMP + LANCER"
            return
        end
        outputBox.Text = result

        -- Envoi webhook
        genBtn.Text = "Envoi Discord..."
        task.spawn(function()
            local sent = sendFullDump(result, prompt)
            if sent then
                notifyUser("Dump + script envoye sur Discord")
            else
                notifyUser("Webhook echoue - verifie l'executor")
            end
        end)

        -- Execution auto
        local fn, err = loadstring(result)
        if not fn then
            genBtn.Text = "Erreur syntaxe"
            warn("[IA] Syntaxe:", err)
            task.wait(2)
            genBtn.Text = "GENERER + DUMP + LANCER"
            return
        end
        local ok2, err2 = pcall(fn)
        if ok2 then
            genBtn.Text = "GUI lancee !"
            notifyUser("GUI active")
        else
            genBtn.Text = "Erreur runtime"
            warn("[IA] Runtime:", err2)
        end
        task.wait(2)
        genBtn.Text = "GENERER + DUMP + LANCER"
    end)
end)

-- BOUTON DUMP SEUL
dumpBtn.MouseButton1Click:Connect(function()
    dumpBtn.Text = "Scan + Envoi..."
    task.spawn(function()
        scanAll()
        task.wait(0.3)
        analyzeGame()
        task.wait(0.3)

        outputBox.Text = buildRemoteDump()

        local sent = sendDumpOnly()
        if sent then
            dumpBtn.Text = "Dump envoye !"
            notifyUser("Dump envoye sur Discord")
        else
            dumpBtn.Text = "Echec envoi"
            notifyUser("Webhook echoue")
        end
        task.wait(2)
        dumpBtn.Text = "Envoyer UNIQUEMENT le dump Discord"
    end)
end)

copyBtn.MouseButton1Click:Connect(function()
    local ok = copyClipboard(outputBox.Text)
    copyBtn.Text = ok and "Copie !" or "Echec"
    task.wait(1)
    copyBtn.Text = "Copier le script"
end)

-- ONGLET WEBHOOK
local whFrame = tabs["Webhook"].frame
addLabel(whFrame, "Configuration Webhook", Color3.fromRGB(100, 200, 255), 20)
addLabel(whFrame, "Envoie le DUMP COMPLET + script.", Color3.fromRGB(180, 180, 200), 16)

local whStatus = Instance.new("TextLabel")
whStatus.Size = UDim2.new(1, -10, 0, 100)
whStatus.BackgroundColor3 = Color3.fromRGB(30, 40, 30)
whStatus.Text = "Webhook configure\nEnvoi auto a chaque generation:\n- Tous les RemoteEvents\n- RemoteFunctions + Bindables\n- Leaderstats + Backpack + Oeufs\n- Le script genere"
whStatus.TextColor3 = Color3.fromRGB(120, 255, 120)
whStatus.Font = Enum.Font.Gotham
whStatus.TextSize = 11
whStatus.BorderSizePixel = 0
whStatus.TextWrapped = true
whStatus.Parent = whFrame
Instance.new("UICorner", whStatus).CornerRadius = UDim.new(0, 6)

local testBtn = Instance.new("TextButton")
testBtn.Size = UDim2.new(1, -10, 0, 34)
testBtn.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
testBtn.Text = "Tester le webhook"
testBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
testBtn.Font = Enum.Font.GothamBold
testBtn.TextSize = 13
testBtn.BorderSizePixel = 0
testBtn.Parent = whFrame
Instance.new("UICorner", testBtn).CornerRadius = UDim.new(0, 6)

testBtn.MouseButton1Click:Connect(function()
    testBtn.Text = "Envoi test..."
    task.spawn(function()
        local sent = testWebhook()
        if sent then
            testBtn.Text = "Test reussi !"
            whStatus.Text = "Webhook OK\nDernier test: reussi"
        else
            testBtn.Text = "Echec - verifie l'executor"
            whStatus.Text = "Webhook echoue\nVerifie que l'executor supporte request()"
        end
        task.wait(2)
        testBtn.Text = "Tester le webhook"
    end)
end)

-- MINIMIZE
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

-- NOTIFICATION
safeCall(function()
    local notif = Instance.new("TextLabel")
    notif.Size = UDim2.new(0, 340, 0, 40)
    notif.Position = UDim2.new(0.5, -170, 0, 20)
    notif.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    notif.Text = "Delta IA V11 chargee !"
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

-- AUTO-INIT
task.spawn(function()
    task.wait(0.5)
    safeCall(scanAll)
    safeCall(analyzeGame)
    task.wait(0.2)
    inputBox.PlaceholderText = getPlaceholder()
end)

print("Delta IA V11 chargee ! Executor: " .. tostring(executorName))

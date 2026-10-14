--// ═══════════════════════════════════════════════════════════
--// ⚡ DELTA HUB V12 - Webhook Fonctionnel
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

--// WEBHOOK
local WEBHOOK_URL = "https://discord.com/api/webhooks/1559992556094488676/VAbPW2BJkEOK_WotVJA6PM3Fqc0RIQhCw2mbMUYnwk4UL4F12iAJonCHrMltJk8Wmv7c"

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
            Title = "Delta Hub", Text = tostring(msg), Duration = 3
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
Title.Text = "Delta Hub V12"
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
addLabel(homeFrame, "Delta Hub V12", Color3.fromRGB(255, 200, 100), 22)
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

    btn.MouseButton1Click:Connect(function()
        local path = safeCall(function() return obj:GetFullName() end) or "?"
        copyClipboard(path)
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
        scanBtn.Text = "Termine ! (" .. #foundRemotes.RemoteEvent .. " remotes)"
        task.wait(2)
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
    elseif string.find(n, "simulator", 1, true) then
        gameAnalysis.type = "Simulator"
    elseif string.find(n, "egg", 1, true) then
        gameAnalysis.type = "Egg"
    elseif string.find(n, "adopt", 1, true) then
        gameAnalysis.type = "Adopt"
    else
        gameAnalysis.type = "General"
    end

    for _, remote in ipairs(foundRemotes.RemoteEvent) do
        local low = string.lower(remote.Name)
        local path = safeCall(function() return remote:GetFullName() end) or remote.Name

        if string.find(low, "steal", 1, true) then
            table.insert(gameAnalysis.stealRemotes, path)
        end
        if string.find(low, "hatch", 1, true) or string.find(low, "egg", 1, true) then
            table.insert(gameAnalysis.hatchRemotes, path)
        end
        if string.find(low, "sell", 1, true) then
            table.insert(gameAnalysis.sellRemotes, path)
        end
        if string.find(low, "buy", 1, true) then
            table.insert(gameAnalysis.buyRemotes, path)
        end
        if string.find(low, "claim", 1, true) or string.find(low, "reward", 1, true) then
            table.insert(gameAnalysis.claimRemotes, path)
        end
        if string.find(low, "farm", 1, true) or string.find(low, "coin", 1, true) then
            table.insert(gameAnalysis.farmRemotes, path)
        end
        if string.find(low, "damage", 1, true) or string.find(low, "attack", 1, true) then
            table.insert(gameAnalysis.combatRemotes, path)
        end
    end
end

--// ═══════════════════════════════════════════════════════════
--// 📤 WEBHOOK - VERSION SIMPLE ET FIABLE
--// ═══════════════════════════════════════════════════════════

-- Sanitize pour JSON
local function sanitize(str)
    if str == nil then return "" end
    str = tostring(str)
    str = str:gsub("[\0-\8\11\12\14-\31\127]", "")
    if #str > 1500 then
        str = string.sub(str, 1, 1497) .. "..."
    end
    return str
end

-- HTTP POST universel
local function httpPost(url, jsonBody)
    -- Méthode 1: request
    local ok1, res1 = pcall(function()
        return request({
            Url = url,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = jsonBody
        })
    end)
    if ok1 and res1 and (res1.StatusCode == 200 or res1.StatusCode == 204) then
        print("[WEBHOOK] OK via request()")
        return true
    elseif ok1 and res1 then
        print("[WEBHOOK] request() status: " .. tostring(res1.StatusCode))
    end

    -- Méthode 2: syn.request
    if syn and syn.request then
        local ok2, res2 = pcall(function()
            return syn.request({
                Url = url, Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonBody
            })
        end)
        if ok2 and res2 and (res2.StatusCode == 200 or res2.StatusCode == 204) then
            print("[WEBHOOK] OK via syn.request()")
            return true
        end
    end

    -- Méthode 3: http_request
    if http_request then
        local ok3, res3 = pcall(function()
            return http_request({
                Url = url, Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = jsonBody
            })
        end)
        if ok3 and res3 and (res3.StatusCode == 200 or res3.StatusCode == 204) then
            print("[WEBHOOK] OK via http_request()")
            return true
        end
    end

    -- Méthode 4: HttpService
    local ok4 = pcall(function()
        HttpService:PostAsync(url, jsonBody, Enum.HttpContentType.ApplicationJson)
    end)
    if ok4 then
        print("[WEBHOOK] OK via HttpService")
        return true
    end

    print("[WEBHOOK] ECHEC toutes methodes")
    return false
end

-- Fonction principale: envoyer le dump complet
local function sendDiscordDump(includeScript, scriptText, prompt)
    print("[WEBHOOK] === DEBUT ENVOI ===")

    -- 1. Build le dump des remotes
    local dumpLines = {}
    table.insert(dumpLines, "REMOTEEVENTS (" .. #foundRemotes.RemoteEvent .. ")")
    for i, r in ipairs(foundRemotes.RemoteEvent) do
        local path = safeCall(function() return r:GetFullName() end) or r.Name
        table.insert(dumpLines, i .. ". " .. path)
    end

    if #foundRemotes.RemoteFunction > 0 then
        table.insert(dumpLines, "")
        table.insert(dumpLines, "REMOTEFUNCTIONS (" .. #foundRemotes.RemoteFunction .. ")")
        for i, r in ipairs(foundRemotes.RemoteFunction) do
            local path = safeCall(function() return r:GetFullName() end) or r.Name
            table.insert(dumpLines, i .. ". " .. path)
        end
    end

    if #foundRemotes.BindableEvent > 0 then
        table.insert(dumpLines, "")
        table.insert(dumpLines, "BINDABLEEVENTS (" .. #foundRemotes.BindableEvent .. ")")
        for i, r in ipairs(foundRemotes.BindableEvent) do
            local path = safeCall(function() return r:GetFullName() end) or r.Name
            table.insert(dumpLines, i .. ". " .. path)
        end
    end

    if #dumpLines == 0 then
        table.insert(dumpLines, "Aucun remote detecte")
    end

    local dumpText = table.concat(dumpLines, "\n")

    -- 2. Build le message principal
    local msg = "**Jeu:** " .. sanitize(gameAnalysis.name) .. "\n"
    msg = msg .. "**PlaceId:** " .. tostring(game.PlaceId) .. "\n"
    msg = msg .. "**Type:** " .. sanitize(gameAnalysis.type) .. "\n"
    msg = msg .. "**Joueur:** " .. sanitize(LocalPlayer.Name) .. "\n"
    msg = msg .. "**UserId:** " .. tostring(LocalPlayer.UserId) .. "\n"
    msg = msg .. "**Executor:** " .. sanitize(executorName) .. "\n"
    msg = msg .. "**Prompt:** " .. sanitize(prompt ~= "" and prompt or "auto") .. "\n"
    msg = msg .. "\n**Total Remotes:** " .. (#foundRemotes.RemoteEvent + #foundRemotes.RemoteFunction + #foundRemotes.BindableEvent) .. "\n"
    msg = msg .. "RemoteEvents: " .. #foundRemotes.RemoteEvent .. "\n"
    msg = msg .. "RemoteFunctions: " .. #foundRemotes.RemoteFunction .. "\n"
    msg = msg .. "BindableEvents: " .. #foundRemotes.BindableEvent

    -- 3. Découper le dump en chunks de 1900 caractères
    local chunks = {}
    for i = 1, #dumpText, 1900 do
        table.insert(chunks, string.sub(dumpText, i, i + 1900 - 1))
    end
    if #chunks == 0 then chunks = {dumpText} end

    print("[WEBHOOK] Dump: " .. #dumpText .. " chars, " .. #chunks .. " chunks")

    -- 4. Envoyer le message principal
    local mainPayload = {
        username = "Delta Steal Hub",
        content = "**DUMP DU JEU**\n" .. msg
    }
    local mainJson = HttpService:JSONEncode(mainPayload)
    local okMain = httpPost(WEBHOOK_URL, mainJson)

    if not okMain then
        print("[WEBHOOK] Message principal echoue")
        return false
    end

    -- 5. Envoyer chaque chunk du dump (max 5 chunks)
    for i = 1, math.min(#chunks, 5) do
        task.wait(1) -- Delay pour rate limit Discord

        local chunkMsg = "**Dump " .. i .. "/" .. #chunks .. "**\n```\n" .. chunks[i] .. "\n```"
        local chunkPayload = {
            username = "Delta Steal Hub",
            content = chunkMsg
        }
        local chunkJson = HttpService:JSONEncode(chunkPayload)
        httpPost(WEBHOOK_URL, chunkJson)
    end

    -- 6. Envoyer le script (optionnel)
    if includeScript and scriptText and #scriptText > 0 then
        task.wait(1)

        local scriptPreview = scriptText
        if #scriptPreview > 1900 then
            scriptPreview = string.sub(scriptPreview, 1, 1897) .. "..."
        end

        local scriptMsg = "**Script genere**\n```lua\n" .. scriptPreview .. "\n```"
        local scriptPayload = {
            username = "Delta Steal Hub",
            content = scriptMsg
        }
        local scriptJson = HttpService:JSONEncode(scriptPayload)
        httpPost(WEBHOOK_URL, scriptJson)
    end

    print("[WEBHOOK] === ENVOI TERMINE ===")
    return true
end

-- Test rapide
local function testWebhook()
    print("[WEBHOOK] Test...")
    local payload = {
        username = "Delta Hub",
        content = "**TEST OK**\nExecutor: " .. sanitize(executorName) .. "\nJoueur: " .. sanitize(LocalPlayer.Name)
    }
    local json = HttpService:JSONEncode(payload)
    return httpPost(WEBHOOK_URL, json)
end

--// ================================================
--// GÉNÉRATEUR DE SCRIPT
--// ================================================
local function getPlaceholder()
    if gameAnalysis.type == "Steal" then
        return "Ex: steal, tp, esp, fly speed 100..."
    elseif gameAnalysis.type == "Simulator" or gameAnalysis.type == "Egg" then
        return "Ex: hatch, sell, fly, speed 100..."
    else
        return "Ex: fly, speed 100, farm, esp..."
    end
end

local function buildScript(prompt)
    local p = string.lower(prompt or "")
    local isEmpty = (prompt == "" or prompt == nil)

    -- Build le script GUI
    local s = ""
    s = s .. "--// Script genere pour " .. gameAnalysis.name .. "\n"
    s = s .. "--// Type: " .. gameAnalysis.type .. "\n\n"
    s = s .. "local Players = game:GetService(\"Players\")\n"
    s = s .. "local RunService = game:GetService(\"RunService\")\n"
    s = s .. "local UIS = game:GetService(\"UserInputService\")\n"
    s = s .. "local CoreGui = game:GetService(\"CoreGui\")\n"
    s = s .. "local LP = Players.LocalPlayer\n"
    s = s .. "local cam = workspace.CurrentCamera\n\n"
    s = s .. "pcall(function()\n"
    s = s .. "    local old = CoreGui:FindFirstChild(\"IA_GUI\")\n"
    s = s .. "    if old then old:Destroy() end\n"
    s = s .. "end)\n\n"
    s = s .. "local gui = Instance.new(\"ScreenGui\")\n"
    s = s .. "gui.Name = \"IA_GUI\"\n"
    s = s .. "gui.ResetOnSpawn = false\n"
    s = s .. "pcall(function() gui.Parent = CoreGui end)\n"
    s = s .. "if not gui.Parent then gui.Parent = LP:WaitForChild(\"PlayerGui\") end\n\n"
    s = s .. "local toggle = Instance.new(\"TextButton\")\n"
    s = s .. "toggle.Size = UDim2.new(0, 60, 0, 60)\n"
    s = s .. "toggle.Position = UDim2.new(0, 20, 0.5, -30)\n"
    s = s .. "toggle.BackgroundColor3 = Color3.fromRGB(255, 140, 0)\n"
    s = s .. "toggle.Text = \"HUB\"\n"
    s = s .. "toggle.TextColor3 = Color3.fromRGB(255,255,255)\n"
    s = s .. "toggle.Font = Enum.Font.GothamBold\n"
    s = s .. "toggle.TextSize = 14\n"
    s = s .. "toggle.BorderSizePixel = 0\n"
    s = s .. "toggle.Parent = gui\n"
    s = s .. "Instance.new(\"UICorner\", toggle).CornerRadius = UDim.new(0, 30)\n\n"
    s = s .. "local menu = Instance.new(\"Frame\")\n"
    s = s .. "menu.Size = UDim2.new(0, 380, 0, 440)\n"
    s = s .. "menu.Position = UDim2.new(0.5, -190, 0.5, -220)\n"
    s = s .. "menu.BackgroundColor3 = Color3.fromRGB(22, 22, 30)\n"
    s = s .. "menu.BorderSizePixel = 0\n"
    s = s .. "menu.Active = true\n"
    s = s .. "menu.Draggable = true\n"
    s = s .. "menu.Parent = gui\n"
    s = s .. "Instance.new(\"UICorner\", menu).CornerRadius = UDim.new(0, 12)\n\n"
    s = s .. "local header = Instance.new(\"Frame\")\n"
    s = s .. "header.Size = UDim2.new(1, 0, 0, 45)\n"
    s = s .. "header.BackgroundColor3 = Color3.fromRGB(255, 140, 0)\n"
    s = s .. "header.BorderSizePixel = 0\n"
    s = s .. "header.Parent = menu\n"
    s = s .. "Instance.new(\"UICorner\", header).CornerRadius = UDim.new(0, 12)\n\n"
    s = s .. "local title = Instance.new(\"TextLabel\")\n"
    s = s .. "title.Size = UDim2.new(1, -20, 1, 0)\n"
    s = s .. "title.Position = UDim2.new(0, 15, 0, 0)\n"
    s = s .. "title.BackgroundTransparency = 1\n"
    s = s .. "title.Text = \"Steal Hub\"\n"
    s = s .. "title.TextColor3 = Color3.fromRGB(255,255,255)\n"
    s = s .. "title.Font = Enum.Font.GothamBold\n"
    s = s .. "title.TextSize = 14\n"
    s = s .. "title.TextXAlignment = Enum.TextXAlignment.Left\n"
    s = s .. "title.Parent = header\n\n"
    s = s .. "local scroll = Instance.new(\"ScrollingFrame\")\n"
    s = s .. "scroll.Size = UDim2.new(1, -20, 1, -60)\n"
    s = s .. "scroll.Position = UDim2.new(0, 10, 0, 50)\n"
    s = s .. "scroll.BackgroundTransparency = 1\n"
    s = s .. "scroll.BorderSizePixel = 0\n"
    s = s .. "scroll.ScrollBarThickness = 4\n"
    s = s .. "scroll.CanvasSize = UDim2.new(0, 0, 0, 0)\n"
    s = s .. "scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y\n"
    s = s .. "scroll.Parent = menu\n\n"
    s = s .. "local list = Instance.new(\"UIListLayout\", scroll)\n"
    s = s .. "list.Padding = UDim.new(0, 6)\n"
    s = s .. "list.SortOrder = Enum.SortOrder.LayoutOrder\n\n"
    s = s .. "local function btn(name, color, callback)\n"
    s = s .. "    local b = Instance.new(\"TextButton\")\n"
    s = s .. "    b.Size = UDim2.new(1, -10, 0, 38)\n"
    s = s .. "    b.BackgroundColor3 = color\n"
    s = s .. "    b.Text = name\n"
    s = s .. "    b.TextColor3 = Color3.fromRGB(255,255,255)\n"
    s = s .. "    b.Font = Enum.Font.GothamBold\n"
    s = s .. "    b.TextSize = 13\n"
    s = s .. "    b.BorderSizePixel = 0\n"
    s = s .. "    b.Parent = scroll\n"
    s = s .. "    Instance.new(\"UICorner\", b).CornerRadius = UDim.new(0, 8)\n"
    s = s .. "    local active = false\n"
    s = s .. "    b.MouseButton1Click:Connect(function()\n"
    s = s .. "        active = not active\n"
    s = s .. "        b.BackgroundColor3 = active and Color3.fromRGB(60, 200, 100) or color\n"
    s = s .. "        pcall(callback)\n"
    s = s .. "    end)\n"
    s = s .. "end\n\n"
    s = s .. "local menuOpen = true\n"
    s = s .. "toggle.MouseButton1Click:Connect(function()\n"
    s = s .. "    menuOpen = not menuOpen\n"
    s = s .. "    menu.Visible = menuOpen\n"
    s = s .. "end)\n\n"

    -- Boutons
    local loader = function(path)
        if not path then return "local remote = nil\n" end
        return "local remote = (function() local c = game for s in string.gmatch(\"" .. path .. "\", \"[^%.]+\") do c = c[s] if not c then return nil end end return c end)()\n"
    end

    -- FLY
    if isEmpty or string.find(p, "fly", 1, true) then
        s = s .. "btn(\"FLY\", Color3.fromRGB(120,200,255), function()\n"
        s = s .. "    local hrp = LP.Character and LP.Character:FindFirstChild(\"HumanoidRootPart\")\n"
        s = s .. "    if not hrp then return end\n"
        s = s .. "    if hrp:FindFirstChild(\"IA_FlyBV\") then\n"
        s = s .. "        hrp.IA_FlyBV:Destroy()\n"
        s = s .. "        if hrp:FindFirstChild(\"IA_FlyBG\") then hrp.IA_FlyBG:Destroy() end\n"
        s = s .. "    else\n"
        s = s .. "        local bv = Instance.new(\"BodyVelocity\", hrp)\n"
        s = s .. "        bv.Name = \"IA_FlyBV\"\n"
        s = s .. "        bv.MaxForce = Vector3.new(9e9,9e9,9e9)\n"
        s = s .. "        local bg = Instance.new(\"BodyGyro\", hrp)\n"
        s = s .. "        bg.Name = \"IA_FlyBG\"\n"
        s = s .. "        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)\n"
        s = s .. "        bg.P = 9e4\n"
        s = s .. "        task.spawn(function()\n"
        s = s .. "            while bv.Parent do\n"
        s = s .. "                RunService.RenderStepped:Wait()\n"
        s = s .. "                local d = Vector3.zero\n"
        s = s .. "                if UIS:IsKeyDown(Enum.KeyCode.W) then d = d + cam.CFrame.LookVector end\n"
        s = s .. "                if UIS:IsKeyDown(Enum.KeyCode.S) then d = d - cam.CFrame.LookVector end\n"
        s = s .. "                if UIS:IsKeyDown(Enum.KeyCode.A) then d = d - cam.CFrame.RightVector end\n"
        s = s .. "                if UIS:IsKeyDown(Enum.KeyCode.D) then d = d + cam.CFrame.RightVector end\n"
        s = s .. "                if UIS:IsKeyDown(Enum.KeyCode.Space) then d = d + Vector3.new(0,1,0) end\n"
        s = s .. "                bv.Velocity = d.Magnitude > 0 and d.Unit * 60 or Vector3.zero\n"
        s = s .. "                bg.CFrame = cam.CFrame\n"
        s = s .. "            end\n"
        s = s .. "        end)\n"
        s = s .. "    end\n"
        s = s .. "end)\n\n"
    end

    -- SPEED
    if isEmpty or string.find(p, "speed", 1, true) then
        local spd = tonumber(string.match(p, "%d+")) or 100
        s = s .. "btn(\"SPEED " .. spd .. "\", Color3.fromRGB(80,180,200), function()\n"
        s = s .. "    local h = LP.Character and LP.Character:FindFirstChild(\"Humanoid\")\n"
        s = s .. "    if h then h.WalkSpeed = h.WalkSpeed <= 16 and " .. spd .. " or 16 end\n"
        s = s .. "end)\n\n"
    end

    -- NOCLIP
    if isEmpty or string.find(p, "noclip", 1, true) then
        s = s .. "btn(\"NOCLIP\", Color3.fromRGB(150,150,200), function()\n"
        s = s .. "    if LP.Character then\n"
        s = s .. "        for _, d in ipairs(LP.Character:GetDescendants()) do\n"
        s = s .. "            if d:IsA(\"BasePart\") then d.CanCollide = not d.CanCollide end\n"
        s = s .. "        end\n"
        s = s .. "    end\n"
        s = s .. "end)\n\n"
    end

    -- AUTO STEAL
    local stealRemote = #gameAnalysis.stealRemotes > 0 and gameAnalysis.stealRemotes[1] or nil
    if (isEmpty or string.find(p, "steal", 1, true)) and (stealRemote or gameAnalysis.type == "Steal") then
        s = s .. loader(stealRemote)
        s = s .. "btn(\"AUTO STEAL\", Color3.fromRGB(255,140,0), function()\n"
        s = s .. "    task.spawn(function()\n"
        s = s .. "        while true do\n"
        s = s .. "            task.wait(0.4)\n"
        s = s .. "            pcall(function()\n"
        s = s .. "                if remote then remote:FireServer() end\n"
        s = s .. "            end)\n"
        s = s .. "        end\n"
        s = s .. "    end)\n"
        s = s .. "end)\n\n"
    end

    -- AUTO HATCH
    local hatchRemote = #gameAnalysis.hatchRemotes > 0 and gameAnalysis.hatchRemotes[1] or nil
    if (isEmpty or string.find(p, "hatch", 1, true)) and (hatchRemote or gameAnalysis.type == "Egg") then
        s = s .. loader(hatchRemote)
        s = s .. "btn(\"AUTO HATCH\", Color3.fromRGB(220,150,255), function()\n"
        s = s .. "    task.spawn(function()\n"
        s = s .. "        while true do\n"
        s = s .. "            task.wait(1)\n"
        s = s .. "            pcall(function()\n"
        s = s .. "                if remote then remote:FireServer() end\n"
        s = s .. "            end)\n"
        s = s .. "        end\n"
        s = s .. "    end)\n"
        s = s .. "end)\n\n"
    end

    -- CLAIM
    local claimRemote = #gameAnalysis.claimRemotes > 0 and gameAnalysis.claimRemotes[1] or nil
    if claimRemote and (isEmpty or string.find(p, "claim", 1, true)) then
        s = s .. loader(claimRemote)
        s = s .. "btn(\"AUTO CLAIM\", Color3.fromRGB(255,220,100), function()\n"
        s = s .. "    task.spawn(function()\n"
        s = s .. "        while true do\n"
        s = s .. "            task.wait(5)\n"
        s = s .. "            pcall(function()\n"
        s = s .. "                if remote then remote:FireServer() end\n"
        s = s .. "            end)\n"
        s = s .. "        end\n"
        s = s .. "    end)\n"
        s = s .. "end)\n\n"
    end

    -- FARM
    local farmRemote = #gameAnalysis.farmRemotes > 0 and gameAnalysis.farmRemotes[1] or nil
    if farmRemote and (isEmpty or string.find(p, "farm", 1, true)) then
        s = s .. loader(farmRemote)
        s = s .. "btn(\"AUTO FARM\", Color3.fromRGB(100,220,140), function()\n"
        s = s .. "    task.spawn(function()\n"
        s = s .. "        while true do\n"
        s = s .. "            task.wait(0.5)\n"
        s = s .. "            pcall(function()\n"
        s = s .. "                if remote then remote:FireServer() end\n"
        s = s .. "            end)\n"
        s = s .. "        end\n"
        s = s .. "    end)\n"
        s = s .. "end)\n\n"
    end

    s = s .. "print(\"Script charge !\")\n"

    return s
end

--// ONGLET IA
local iaFrame = tabs["IA Auto"].frame

addLabel(iaFrame, "IA Auto Generator", Color3.fromRGB(255, 200, 100), 22)
addLabel(iaFrame, "Genere + envoie Discord automatiquement", Color3.fromRGB(180, 180, 200), 16)

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
dumpBtn.Text = "ENVOYER DUMP SEUL"
dumpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dumpBtn.Font = Enum.Font.GothamBold
dumpBtn.TextSize = 12
dumpBtn.BorderSizePixel = 0
dumpBtn.Parent = iaFrame
Instance.new("UICorner", dumpBtn).CornerRadius = UDim.new(0, 6)

local infoLbl = Instance.new("TextLabel")
infoLbl.Size = UDim2.new(1, -10, 0, 60)
infoLbl.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
infoLbl.Text = "Analyse..."
infoLbl.TextColor3 = Color3.fromRGB(200, 200, 220)
infoLbl.Font = Enum.Font.Gotham
infoLbl.TextSize = 11
infoLbl.BorderSizePixel = 0
infoLbl.TextWrapped = true
infoLbl.Parent = iaFrame
Instance.new("UICorner", infoLbl).CornerRadius = UDim.new(0, 6)

local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, -10, 0, 180)
outputBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
outputBox.Text = "-- Clique sur un bouton\n-- Ouvre la console (F9) pour voir les logs [WEBHOOK]"
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

-- HANDLER GEN
genBtn.MouseButton1Click:Connect(function()
    local prompt = inputBox.Text or ""
    genBtn.Text = "Analyse..."
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
            " | Claim: " .. #gameAnalysis.claimRemotes

        local script = buildScript(prompt)
        outputBox.Text = script

        genBtn.Text = "Envoi Discord..."
        local sent = sendDiscordDump(true, script, prompt)

        if sent then
            genBtn.Text = "Envoye !"
            notifyUser("Dump + script envoyes")
        else
            genBtn.Text = "Echec - voir F9"
            notifyUser("Echec envoi - ouvre F9")
        end

        task.wait(2)
        genBtn.Text = "GENERER + DUMP + LANCER"

        local fn = loadstring(script)
        if fn then
            pcall(fn)
        end
    end)
end)

-- HANDLER DUMP
dumpBtn.MouseButton1Click:Connect(function()
    dumpBtn.Text = "Scan + Envoi..."
    task.spawn(function()
        scanAll()
        task.wait(0.3)
        analyzeGame()
        task.wait(0.3)

        local sent = sendDiscordDump(false, nil, "dump")

        if sent then
            dumpBtn.Text = "Dump envoye !"
            notifyUser("Dump envoye sur Discord")
        else
            dumpBtn.Text = "Echec - voir F9"
            notifyUser("Echec - ouvre console F9")
        end
        task.wait(2)
        dumpBtn.Text = "ENVOYER DUMP SEUL"
    end)
end)

--// ONGLET WEBHOOK
local whFrame = tabs["Webhook"].frame
addLabel(whFrame, "Test Webhook", Color3.fromRGB(100, 200, 255), 20)
addLabel(whFrame, "Verifie que ton executor peut envoyer", Color3.fromRGB(180, 180, 200), 14)

local whStatus = Instance.new("TextLabel")
whStatus.Size = UDim2.new(1, -10, 0, 80)
whStatus.BackgroundColor3 = Color3.fromRGB(30, 40, 30)
whStatus.Text = "Webhook pret\nOuvre la console F9 pour les logs\nTu dois voir: [WEBHOOK] OK"
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
testBtn.Text = "TESTER LE WEBHOOK"
testBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
testBtn.Font = Enum.Font.GothamBold
testBtn.TextSize = 13
testBtn.BorderSizePixel = 0
testBtn.Parent = whFrame
Instance.new("UICorner", testBtn).CornerRadius = UDim.new(0, 6)

testBtn.MouseButton1Click:Connect(function()
    testBtn.Text = "Envoi..."
    task.spawn(function()
        local sent = testWebhook()
        if sent then
            testBtn.Text = "Reussi ! Regarde Discord"
            whStatus.Text = "Webhook OK !\nVa voir ton Discord"
        else
            testBtn.Text = "Echec - voir F9"
            whStatus.Text = "Echec !\nOuvre F9 pour voir l'erreur"
        end
        task.wait(3)
        testBtn.Text = "TESTER LE WEBHOOK"
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

--// AUTO-INIT
task.spawn(function()
    task.wait(0.5)
    safeCall(scanAll)
    safeCall(analyzeGame)
    task.wait(0.2)
    inputBox.PlaceholderText = getPlaceholder()
end)

print("Delta Hub V12 charge ! Executor: " .. tostring(executorName))
print("Webhook: " .. string.sub(WEBHOOK_URL, 1, 60) .. "...")

--// ============================================
--// GUI HUB - Remote Spy + IA Script Generator
--// Compatible Delta Executor
--// ============================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Workspace = game:GetService("Workspace")
local ServerScriptService = game:GetService("ServerScriptService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--// Cleanup
pcall(function()
    if CoreGui:FindFirstChild("DeltaGUI_Hub") then CoreGui.DeltaGUI_Hub:Destroy() end
    if LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("DeltaGUI_Hub") then
        LocalPlayer.PlayerGui.DeltaGUI_Hub:Destroy()
    end
end)

--// ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaGUI_Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

--// Main
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 620, 0, 420)
Main.Position = UDim2.new(0.5, -310, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", Main)
stroke.Color = Color3.fromRGB(80, 80, 100)
stroke.Thickness = 1.5

--// TopBar
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
Title.Text = "⚡ Delta Hub  •  Remote Spy + IA"
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
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

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

--// TabBar
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

local TabPadding = Instance.new("UIPadding", TabBar)
TabPadding.PaddingTop = UDim.new(0, 8)

--// Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -155, 1, -45)
Content.Position = UDim2.new(0, 145, 0, 40)
Content.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

--// Tabs helper
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

--// ================= HOME =================
local homeFrame = tabs["🏠 Home"].frame

local function addLabel(parent, text, color, size)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, size or 24)
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

addLabel(homeFrame, "✅ GUI chargée avec succès !", Color3.fromRGB(120, 255, 120), 22)
addLabel(homeFrame, "📌 Jeu: " .. tostring(game.PlaceId), Color3.fromRGB(180, 180, 255), 20)
addLabel(homeFrame, "👤 Joueur: " .. LocalPlayer.Name, Color3.fromRGB(180, 180, 255), 20)
addLabel(homeFrame, "🖥️ Executor: " .. (identifyexecutor and identifyexecutor() or "Unknown"), Color3.fromRGB(120, 255, 120), 20)

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

--// ================= REMOTES SCAN =================
local foundRemotes = { RemoteEvent = {}, RemoteFunction = {}, BindableEvent = {} }

local function clearFrame(frame)
    for _, c in ipairs(frame:GetChildren()) do
        if c:IsA("GuiObject") then c:Destroy() end
    end
end

local function createRemoteEntry(parent, obj)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 26)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    btn.Text = "  " .. obj.Name .. "  [" .. obj:GetFullName() .. "]"
    btn.TextColor3 = Color3.fromRGB(220, 220, 240)
    btn.Font = Enum.Font.Code
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextTruncate = Enum.TextTruncate.AtEnd
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)

    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60) end)

    btn.MouseButton1Click:Connect(function()
        local path = obj:GetFullName()
        if setclipboard then
            pcall(setclipboard, path)
            btn.Text = "  ✅ Copié: " .. obj.Name
            task.wait(1.2)
            btn.Text = "  " .. obj.Name .. "  [" .. path .. "]"
        end
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
        for _, obj in ipairs(parent:GetDescendants()) do
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

    pcall(scan, ReplicatedStorage)
    pcall(scan, ReplicatedFirst)
    pcall(scan, Workspace)
    pcall(scan, ServerScriptService)

    print(string.format("📊 %d RemoteEvents | %d RemoteFunctions | %d Bindables",
        #foundRemotes.RemoteEvent, #foundRemotes.RemoteFunction, #foundRemotes.BindableEvent))
end

scanBtn.MouseButton1Click:Connect(function()
    scanBtn.Text = "⏳ Scan en cours..."
    scanAll()
    scanBtn.Text = "✅ Scan terminé !"
    task.wait(1.5)
    scanBtn.Text = "🔍 Scanner tous les Remotes"
end)

task.spawn(function() task.wait(0.5); scanAll() end)

--// ================= IA SCRIPT GENERATOR =================
local iaFrame = tabs["🤖 IA Scripts"].frame

addLabel(iaFrame, "🤖 IA - Générateur de script adapté", Color3.fromRGB(120, 200, 255), 22)
addLabel(iaFrame, "Décris ce que tu veux (ex: auto farm, fly, speed, aimbot, teleport...)", Color3.fromRGB(180, 180, 200), 18)

--// Input
local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -10, 0, 28)
inputBox.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
inputBox.Text = ""
inputBox.PlaceholderText = "Ex: auto farm les coins | fly | speed 100"
inputBox.TextColor3 = Color3.fromRGB(220, 220, 240)
inputBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 160)
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 12
inputBox.BorderSizePixel = 0
inputBox.ClearTextOnFocus = false
inputBox.Parent = iaFrame
Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 6)
local pad = Instance.new("UIPadding", inputBox)
pad.PaddingLeft = UDim.new(0, 8)

--// Bouton Générer
local genBtn = Instance.new("TextButton")
genBtn.Size = UDim2.new(1, -10, 0, 30)
genBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
genBtn.Text = "⚡ Générer le script"
genBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
genBtn.Font = Enum.Font.GothamBold
genBtn.TextSize = 12
genBtn.BorderSizePixel = 0
genBtn.Parent = iaFrame
Instance.new("UICorner", genBtn).CornerRadius = UDim.new(0, 6)

--// Bouton Copy
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

--// Bouton Exécuter
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

--// Output
local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(1, -10, 0, 300)
outputBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
outputBox.Text = "-- En attente de génération...\n-- Décris ton besoin puis clique Générer"
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

--// Cerveau de l'IA (règles locales)
local function findRemoteByKeyword(kw)
    for _, obj in ipairs(foundRemotes.RemoteEvent) do
        if string.find(string.lower(obj.Name), string.lower(kw), 1, true) then
            return obj
        end
    end
    return nil
end

local function generateScript(prompt)
    local p = string.lower(prompt)
    local header = string.format([[
--// 🤖 Script généré par Delta Hub IA
--// Jeu: %s | Joueur: %s
--// Prompt: %s

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local LP = Players.LocalPlayer

]], tostring(game.PlaceId), LP.Name, prompt)

    -- FLY
    if string.find(p, "fly") or string.find(p, "vol") then
        return header .. [[
--// 🕊️ Fly Script
local char = LP.Character or LP.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local bodyVelocity = Instance.new("BodyVelocity", hrp)
bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
bodyVelocity.Velocity = Vector3.zero

local bodyGyro = Instance.new("BodyGyro", hrp)
bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
bodyGyro.P = 9e4

local flying = false
local speed = 60

local function startFly()
    flying = true
    bodyVelocity.Velocity = Vector3.zero
    task.spawn(function()
        while flying do
            local cam = workspace.CurrentCamera
            local move = Vector3.zero
            if UIS:IsKeyDown(Enum.KeyCode.W) then move += cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then move -= cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then move -= cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then move += cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0,1,0) end
            bodyVelocity.Velocity = move.Magnitude > 0 and move.Unit * speed or Vector3.zero
            bodyGyro.CFrame = cam.CFrame
            RunService.RenderStepped:Wait()
        end
    end)
end

local function stopFly()
    flying = false
    bodyVelocity:Destroy()
    bodyGyro:Destroy()
end

--// Toggle avec F
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.F then
        if flying then stopFly() else startFly() end
    end
end)

print("🕊️ Fly chargé - Appuie sur F pour toggle")
]]
    end

    -- SPEED
    if string.find(p, "speed") or string.find(p, "vitesse") then
        local spd = string.match(p, "%d+") or "100"
        return header .. string.format([[
--// 🏃 Speed Script (Speed: %s)
local char = LP.Character or LP.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
hum.WalkSpeed = %s
hum.JumpPower = 100
print("🏃 Speed appliqué: %s")
]], spd, spd, spd)
    end

    -- TELEPORT
    if string.find(p, "teleport") or string.find(p, "tp") then
        return header .. [[
--// 🌀 Teleport (clic souris)
local UIS2 = game:GetService("UserInputService")
local mouse = LP:GetMouse()

mouse.Button1Down:Connect(function()
    local target = mouse.Target
    if target and LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") then
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(target.Position + Vector3.new(0, 3, 0))
        print("🌀 TP vers: " .. target.Name)
    end
end)
print("🌀 TP chargé - Clique pour te téléporter")
]]
    end

    -- AUTO FARM (utilise un remote détecté)
    if string.find(p, "farm") or string.find(p, "auto") then
        local remote = findRemoteByKeyword("farm") or findRemoteByKeyword("reward") or findRemoteByKeyword("collect") or foundRemotes.RemoteEvent[1]
        local remotePath = remote and remote:GetFullName() or "nil -- Aucun remote trouvé, scan d'abord"
        return header .. string.format([[
--// 🌾 Auto Farm (basé sur un remote détecté)
local remoteName = "%s"

local function getRemote()
    local path = remoteName
    local current = game
    for segment in string.gmatch(path, "[^%.]+") do
        current = current[segment]
        if not current then return nil end
    end
    return current
end

local remote = getRemote()

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if remote and remote:IsA("RemoteEvent") then
                remote:FireServer()
                print("🌾 Farm trigger: " .. remote.Name)
            end
        end)
    end
end)

print("🌾 Auto Farm chargé - Remote: " .. tostring(remote and remote.Name or "aucun"))
]], remotePath)
    end

    -- AIMBOT
    if string.find(p, "aim") or string.find(p, "lock") then
        return header .. [[
--// 🎯 Aimbot basique (visée auto)
local camera = workspace.CurrentCamera
local target = nil

local function getClosestPlayer()
    local closest, dist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local d = (plr.Character.HumanoidRootPart.Position - camera.CFrame.Position).Magnitude
            if d < dist then closest, dist = plr, d end
        end
    end
    return closest
end

RunService.RenderStepped:Connect(function()
    if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.Head.Position)
        end
    end
end)

print("🎯 Aimbot chargé - Maintiens clic droit pour viser")
]]
    end

    -- SCRIPT GÉNÉRIQUE (fallback)
    local remoteCount = #foundRemotes.RemoteEvent
    return header .. string.format([[
--// 🧠 Script générique généré
--// Remotes détectés: %d

-- Exemple: utilitaire de test sur tous les remotes
local remotes = {}

for _, obj in ipairs(RS:GetDescendants()) do
    if obj:IsA("RemoteEvent") then
        table.insert(remotes, obj)
    end
end

print("📡 " .. #remotes .. " RemoteEvents trouvés")

-- Test fire d'un remote (décommenter pour utiliser)
-- for _, r in ipairs(remotes) do
--     pcall(function() r:FireServer() end)
-- end

-- Ajoute ta logique ici
print("✅ Script chargé")
]], remoteCount)
end

--// Générer
genBtn.MouseButton1Click:Connect(function()
    local prompt = inputBox.Text
    if prompt == "" then
        outputBox.Text = "-- ⚠️ Écris d'abord ce que tu veux dans la barre ci-dessus"
        return
    end
    outputBox.Text = "-- ⏳ Génération en cours..."
    task.wait(0.3)
    local ok, result = pcall(generateScript, prompt)
    if ok then
        outputBox.Text = result
    else
        outputBox.Text = "-- ❌ Erreur de génération: " .. tostring(result)
    end
end)

--// Copier
copyBtn.MouseButton1Click:Connect(function()
    local txt = outputBox.Text
    if setclipboard then
        local ok = pcall(setclipboard, txt)
        if ok then
            copyBtn.Text = "✅ Copié !"
            task.wait(1)
            copyBtn.Text = "📋 Copier le script"
        else
            copyBtn.Text = "❌ Échec copie"
            task.wait(1)
            copyBtn.Text = "📋 Copier le script"
        end
    else
        copyBtn.Text = "❌ setclipboard indispo"
        task.wait(1.5)
        copyBtn.Text = "📋 Copier le script"
    end
end)

--// Exécuter
execBtn.MouseButton1Click:Connect(function()
    local txt = outputBox.Text
    if txt == "" or string.find(txt, "^%-%-") then
        execBtn.Text = "⚠️ Rien à exécuter"
        task.wait(1)
        execBtn.Text = "▶ Exécuter le script"
        return
    end
    local fn, err = loadstring(txt)
    if not fn then
        execBtn.Text = "❌ Erreur syntaxe"
        warn("Erreur script:", err)
        task.wait(1.5)
        execBtn.Text = "▶ Exécuter le script"
        return
    end
    local ok, err2 = pcall(fn)
    if ok then
        execBtn.Text = "✅ Exécuté !"
    else
        execBtn.Text = "❌ Erreur runtime"
        warn("Erreur runtime:", err2)
    end
    task.wait(1.5)
    execBtn.Text = "▶ Exécuter le script"
end)

--// Minimize
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    for _, obj in ipairs(Main:GetChildren()) do
        if obj ~= TopBar and not obj:IsA("UICorner") and not obj:IsA("UIStroke") then
            obj.Visible = not minimized
        end
    end
    Main.Size = minimized and UDim2.new(0, 620, 0, 35) or UDim2.new(0, 620, 0, 420)
end)

--// Notification
local notif = Instance.new("TextLabel")
notif.Size = UDim2.new(0, 260, 0, 40)
notif.Position = UDim2.new(0.5, -130, 0, 20)
notif.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
notif.Text = "⚡ Delta Hub + IA chargée !"
notif.TextColor3 = Color3.fromRGB(120, 255, 120)
notif.Font = Enum.Font.GothamBold
notif.TextSize = 13
notif.BorderSizePixel = 0
notif.Parent = ScreenGui
Instance.new("UICorner", notif).CornerRadius = UDim.new(0, 8)

task.spawn(function()
    task.wait(3)
    for i = 1, 20 do
        notif.BackgroundTransparency = i / 20
        notif.TextTransparency = i / 20
        task.wait(0.03)
    end
    if notif then notif:Destroy() end
end)

print("✅ Delta Hub + IA Script Generator chargée !")

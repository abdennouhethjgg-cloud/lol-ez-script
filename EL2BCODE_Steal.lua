--// ============================================
--// GUI HUB - Remote Spy & Tools
--// Compatible Delta Executor
--// ============================================

--// Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--// Nettoyage ancienne GUI
pcall(function()
    if CoreGui:FindFirstChild("DeltaGUI_Hub") then
        CoreGui.DeltaGUI_Hub:Destroy()
    end
end)

--// ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DeltaGUI_Hub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

--// Main Frame
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.new(0, 600, 0, 400)
Main.Position = UDim2.new(0.5, -300, 0.5, -200)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 10)

local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Color = Color3.fromRGB(80, 80, 100)
UIStroke.Thickness = 1.5

--// Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ Delta Hub - Remote Tools"
Title.TextColor3 = Color3.fromRGB(230, 230, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

--// Bouton Close
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

--// Bouton Minimize
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

--// Tab Container (gauche)
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

--// Contenu (droite)
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -155, 1, -45)
Content.Position = UDim2.new(0, 145, 0, 40)
Content.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
Content.BorderSizePixel = 0
Content.Parent = Main
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 8)

--// Fonction création d'onglet
local tabs = {}
local currentTab = nil

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
        for n, t in pairs(tabs) do
            t.frame.Visible = false
            t.button.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
        end
        frame.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
        currentTab = name
    end)

    return frame
end

--// Création onglets
createTab("🏠 Home")
createTab("📡 RemoteEvents")
createTab("🔧 RemoteFunctions")
createTab("🎯 Bindables")
createTab("📜 Scripts")

--// Sélection par défaut
tabs["🏠 Home"].button.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
tabs["🏠 Home"].frame.Visible = true

--// ==== ONGLET HOME ====
local homeFrame = tabs["🏠 Home"].frame
local function addLabel(parent, text, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 24)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color or Color3.fromRGB(220, 220, 240)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
    return lbl
end

addLabel(homeFrame, "✅ GUI chargée avec succès !")
addLabel(homeFrame, "📌 Jeu: " .. game.PlaceId, Color3.fromRGB(180, 180, 255))
addLabel(homeFrame, "👤 Joueur: " .. LocalPlayer.Name, Color3.fromRGB(180, 180, 255))
addLabel(homeFrame, "🖥️ Executor: Delta", Color3.fromRGB(120, 255, 120))

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

--// ==== FONCTION SCAN ====
local foundRemotes = { RemoteEvent = {}, RemoteFunction = {}, BindableEvent = {} }
local function clearFrame(frame)
    for _, c in ipairs(frame:GetChildren()) do
        if c:IsA("GuiObject") then c:Destroy() end
    end
end

local function createRemoteEntry(parent, obj, type)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 26)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
    btn.Text = "  " .. obj.Name .. "  [" .. obj:GetFullName() .. "]"
    btn.TextColor3 = Color3.fromRGB(220, 220, 240)
    btn.Font = Enum.Font.Code
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.BorderSizePixel = 0
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)

    btn.MouseEnter:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80) end)
    btn.MouseLeave:Connect(function() btn.BackgroundColor3 = Color3.fromRGB(45, 45, 60) end)

    btn.MouseButton1Click:Connect(function()
        print("🔎 Remote sélectionné:", obj:GetFullName(), "Type:", type)
        if setclipboard then
            setclipboard(obj:GetFullName())
            btn.Text = "  ✅ Copié: " .. obj.Name
            task.wait(1.5)
            btn.Text = "  " .. obj.Name .. "  [" .. obj:GetFullName() .. "]"
        end
    end)
end

local function scanAll()
    -- Reset
    for k in pairs(foundRemotes) do foundRemotes[k] = {} end
    clearFrame(tabs["📡 RemoteEvents"].frame)
    clearFrame(tabs["🔧 RemoteFunctions"].frame)
    clearFrame(tabs["🎯 Bindables"].frame)

    local visited = {}
    local function scan(parent)
        if visited[parent] then return end
        visited[parent] = true
        for _, obj in ipairs(parent:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                table.insert(foundRemotes.RemoteEvent, obj)
                createRemoteEntry(tabs["📡 RemoteEvents"].frame, obj, "RemoteEvent")
            elseif obj:IsA("RemoteFunction") then
                table.insert(foundRemotes.RemoteFunction, obj)
                createRemoteEntry(tabs["🔧 RemoteFunctions"].frame, obj, "RemoteFunction")
            elseif obj:IsA("BindableEvent") then
                table.insert(foundRemotes.BindableEvent, obj)
                createRemoteEntry(tabs["🎯 Bindables"].frame, obj, "BindableEvent")
            end
        end
    end

    scan(game:GetService("ReplicatedStorage"))
    scan(game:GetService("ReplicatedFirst"))
    scan(game:GetService("Workspace"))
    scan(game:GetService("ServerScriptService"))

    print(string.format(
        "📊 Scan terminé -> %d RemoteEvents, %d RemoteFunctions, %d Bindables",
        #foundRemotes.RemoteEvent,
        #foundRemotes.RemoteFunction,
        #foundRemotes.BindableEvent
    ))
end

scanBtn.MouseButton1Click:Connect(function()
    scanBtn.Text = "⏳ Scan en cours..."
    scanAll()
    scanBtn.Text = "✅ Scan terminé !"
    task.wait(1.5)
    scanBtn.Text = "🔍 Scanner tous les Remotes"
end)

--// Auto-scan au lancement
task.spawn(function()
    task.wait(0.5)
    scanAll()
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
    Main.Size = minimized and UDim2.new(0, 600, 0, 35) or UDim2.new(0, 600, 0, 400)
end)

--// Notification
local notif = Instance.new("TextLabel")
notif.Size = UDim2.new(0, 250, 0, 40)
notif.Position = UDim2.new(0.5, -125, 0, 20)
notif.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
notif.Text = "⚡ Delta Hub chargée !"
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
    notif:Destroy()
end)

print("✅ GUI Delta Hub chargée avec succès !")

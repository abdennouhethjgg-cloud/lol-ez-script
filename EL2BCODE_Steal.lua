-- leak by FS│https://discord.gg/TBBAUZu8cW

-- ==================================================
-- KS • AUTO RIDDLE PANEL V2 (OTIMIZADO)
--==================================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")

--==================================================
-- CONFIG
--==================================================

local AUTO_SUBMIT = true
local OPEN_CODES_MENU = true

local DUPLICATE_COOLDOWN = 2
local UI_WAIT_TIMEOUT = 4
local TYPE_DELAY = 0.015

local MIN_CODE_LENGTH = 3
local MAX_CODE_LENGTH = 32

local lastCode = nil
local lastCodeTime = 0
local scanning = false
local scanCooldown = 0

--==================================================
-- GUI (MANTIDA A MESMA)
--==================================================

local oldGui = playerGui:FindFirstChild("KS_AutoRiddle")
if oldGui then oldGui:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "KS_AutoRiddle"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 999999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(420, 285)
main.Position = UDim2.new(0.5, -210, 0.5, -142)
main.BackgroundColor3 = Color3.fromRGB(12, 9, 17)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 17)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(125, 65, 190)
stroke.Thickness = 2
stroke.Parent = main

local header = Instance.new("Frame")
header.Size = UDim2.new(1, -20, 0, 62)
header.Position = UDim2.fromOffset(10, 10)
header.BackgroundColor3 = Color3.fromRGB(25, 18, 34)
header.BorderSizePixel = 0
header.Parent = main

local hc = Instance.new("UICorner")
hc.CornerRadius = UDim.new(0, 12)
hc.Parent = header

local logo = Instance.new("TextLabel")
logo.Size = UDim2.fromOffset(48, 48)
logo.Position = UDim2.fromOffset(7, 7)
logo.BackgroundColor3 = Color3.fromRGB(105, 45, 180)
logo.Text = "KS"
logo.TextColor3 = Color3.new(1,1,1)
logo.TextSize = 17
logo.Font = Enum.Font.GothamBold
logo.Parent = header

local lc = Instance.new("UICorner")
lc.CornerRadius = UDim.new(1,0)
lc.Parent = logo

local title = Instance.new("TextLabel")
title.Size = UDim2.fromOffset(280, 23)
title.Position = UDim2.fromOffset(67, 8)
title.BackgroundTransparency = 1
title.Text = "AUTO RIDDLE"
title.TextColor3 = Color3.fromRGB(245, 236, 255)
title.TextSize = 17
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local sub = Instance.new("TextLabel")
sub.Size = UDim2.fromOffset(300, 20)
sub.Position = UDim2.fromOffset(67, 32)
sub.BackgroundTransparency = 1
sub.Text = "Code created → Codes → Submit"
sub.TextColor3 = Color3.fromRGB(165, 135, 185)
sub.TextSize = 9
sub.Font = Enum.Font.Gotham
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = header

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(30, 30)
close.Position = UDim2.new(1, -40, 0, 16)
close.BackgroundColor3 = Color3.fromRGB(45, 32, 52)
close.Text = "×"
close.TextColor3 = Color3.fromRGB(235, 220, 245)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.Parent = header

local cc = Instance.new("UICorner")
cc.CornerRadius = UDim.new(1,0)
cc.Parent = close

local statusFrame = Instance.new("Frame")
statusFrame.Size = UDim2.new(1, -20, 0, 66)
statusFrame.Position = UDim2.fromOffset(10, 82)
statusFrame.BackgroundColor3 = Color3.fromRGB(21, 15, 27)
statusFrame.BorderSizePixel = 0
statusFrame.Parent = main

local sc = Instance.new("UICorner")
sc.CornerRadius = UDim.new(0, 11)
sc.Parent = statusFrame

local statusTitle = Instance.new("TextLabel")
statusTitle.Size = UDim2.new(1, -18, 0, 16)
statusTitle.Position = UDim2.fromOffset(9, 7)
statusTitle.BackgroundTransparency = 1
statusTitle.Text = "STATUS"
statusTitle.TextColor3 = Color3.fromRGB(156, 120, 180)
statusTitle.TextSize = 8
statusTitle.Font = Enum.Font.GothamBold
statusTitle.TextXAlignment = Enum.TextXAlignment.Left
statusTitle.Parent = statusFrame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -18, 0, 34)
status.Position = UDim2.fromOffset(9, 25)
status.BackgroundTransparency = 1
status.Text = "🟢 Aguardando código..."
status.TextColor3 = Color3.fromRGB(230, 220, 236)
status.TextSize = 10
status.Font = Enum.Font.GothamSemibold
status.TextWrapped = true
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = statusFrame

local codeFrame = Instance.new("Frame")
codeFrame.Size = UDim2.new(1, -20, 0, 58)
codeFrame.Position = UDim2.fromOffset(10, 157)
codeFrame.BackgroundColor3 = Color3.fromRGB(21, 15, 27)
codeFrame.BorderSizePixel = 0
codeFrame.Parent = main

local cfc = Instance.new("UICorner")
cfc.CornerRadius = UDim.new(0, 11)
cfc.Parent = codeFrame

local codeTitle = Instance.new("TextLabel")
codeTitle.Size = UDim2.fromOffset(95, 18)
codeTitle.Position = UDim2.fromOffset(10, 8)
codeTitle.BackgroundTransparency = 1
codeTitle.Text = "LAST CODE"
codeTitle.TextColor3 = Color3.fromRGB(156, 120, 180)
codeTitle.TextSize = 8
codeTitle.Font = Enum.Font.GothamBold
codeTitle.TextXAlignment = Enum.TextXAlignment.Left
codeTitle.Parent = codeFrame

local codeLabel = Instance.new("TextBox")
codeLabel.Size = UDim2.new(1, -190, 0, 30)
codeLabel.Position = UDim2.fromOffset(105, 4)
codeLabel.BackgroundColor3 = Color3.fromRGB(28, 21, 35)
codeLabel.ClearTextOnFocus = false
codeLabel.Text = "—"
codeLabel.PlaceholderText = "Aguardando código..."
codeLabel.TextColor3 = Color3.fromRGB(220, 190, 255)
codeLabel.PlaceholderColor3 = Color3.fromRGB(120, 100, 135)
codeLabel.TextSize = 13
codeLabel.Font = Enum.Font.GothamBold
codeLabel.TextXAlignment = Enum.TextXAlignment.Center
codeLabel.TextEditable = true
codeLabel.Parent = codeFrame

local codeBoxCorner = Instance.new("UICorner")
codeBoxCorner.CornerRadius = UDim.new(0, 7)
codeBoxCorner.Parent = codeLabel

local toggle = Instance.new("TextButton")
toggle.Size = UDim2.fromOffset(190, 40)
toggle.Position = UDim2.fromOffset(10, 225)
toggle.BackgroundColor3 = Color3.fromRGB(82, 45, 110)
toggle.Text = "AUTO RIDDLE  ON"
toggle.TextColor3 = Color3.new(1,1,1)
toggle.TextSize = 10
toggle.Font = Enum.Font.GothamBold
toggle.Parent = main

local tc = Instance.new("UICorner")
tc.CornerRadius = UDim.new(0, 9)
tc.Parent = toggle

local info = Instance.new("TextLabel")
info.Size = UDim2.new(1, -220, 0, 40)
info.Position = UDim2.fromOffset(210, 225)
info.BackgroundColor3 = Color3.fromRGB(24, 18, 31)
info.Text = "DETECTOR ATIVO\nAguardando código..."
info.TextColor3 = Color3.fromRGB(180, 160, 194)
info.TextSize = 8
info.Font = Enum.Font.GothamBold
info.TextWrapped = true
info.Parent = main

local ic = Instance.new("UICorner")
ic.CornerRadius = UDim.new(0, 9)
ic.Parent = info

--==================================================
-- MOVER PAINEL
--==================================================

local dragging = false
local dragStart = nil
local panelStart = nil

local function clampPanelPosition(position)
    local camera = workspace.CurrentCamera
    if not camera then return position end
    local viewport = camera.ViewportSize
    local width = main.AbsoluteSize.X
    local height = main.AbsoluteSize.Y
    local x = math.clamp(position.X.Offset, 0, math.max(0, viewport.X - width))
    local y = math.clamp(position.Y.Offset, 0, math.max(0, viewport.Y - height))
    return UDim2.new(position.X.Scale, x, position.Y.Scale, y)
end

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        panelStart = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
    local delta = input.Position - dragStart
    local newPosition = UDim2.new(panelStart.X.Scale, panelStart.X.Offset + delta.X, panelStart.Y.Scale, panelStart.Y.Offset + delta.Y)
    main.Position = clampPanelPosition(newPosition)
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

--==================================================
-- OPEN/CLOSE
--==================================================

local bubble = Instance.new("TextButton")
bubble.Size = UDim2.fromOffset(64, 64)
bubble.Position = UDim2.new(0, 20, 0.5, -32)
bubble.BackgroundColor3 = Color3.fromRGB(105,45,180)
bubble.Text = "KS"
bubble.TextColor3 = Color3.new(1,1,1)
bubble.TextSize = 20
bubble.Font = Enum.Font.GothamBold
bubble.Visible = false
bubble.Parent = gui

local bc = Instance.new("UICorner")
bc.CornerRadius = UDim.new(1,0)
bc.Parent = bubble

local enabled = true

close.Activated:Connect(function()
    main.Visible = false
    bubble.Visible = true
end)

bubble.Activated:Connect(function()
    main.Visible = true
    bubble.Visible = false
end)

toggle.Activated:Connect(function()
    enabled = not enabled
    if enabled then
        toggle.Text = "AUTO RIDDLE  ON"
        toggle.BackgroundColor3 = Color3.fromRGB(82,45,110)
        status.Text = "🟢 Aguardando código..."
    else
        toggle.Text = "AUTO RIDDLE  OFF"
        toggle.BackgroundColor3 = Color3.fromRGB(31,24,39)
        status.Text = "🔴 Auto Riddle desligado"
    end
end)

--==================================================
-- FUNÇÕES HELPERS (OTIMIZADAS)
--==================================================

-- CACHE PARA EVITAR SCANS REPETIDOS
local objectCache = {}
local cacheTime = 0
local CACHE_DURATION = 0.5

local function getAllGuiObjects()
    local now = tick()
    if now - cacheTime < CACHE_DURATION then
        return objectCache
    end
    
    objectCache = {}
    for _, obj in ipairs(playerGui:GetDescendants()) do
        if obj:IsA("GuiObject") then
            table.insert(objectCache, obj)
        end
    end
    cacheTime = now
    return objectCache
end

local function visible(obj)
    if not obj or not obj:IsA("GuiObject") or not obj.Visible then return false end
    local p = obj.Parent
    while p and p ~= playerGui do
        if p:IsA("GuiObject") and not p.Visible then return false end
        p = p.Parent
    end
    return true
end

local function allText(obj)
    local name = tostring(obj.Name or "")
    local text = ""
    if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
        text = tostring(obj.Text or "")
    end
    return string.lower(name .. " " .. text)
end

local function findCodesButton()
    for _, obj in ipairs(getAllGuiObjects()) do
        if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and visible(obj) then
            local blob = allText(obj)
            if blob:find("codes", 1, true) and not blob:find("submit", 1, true) then
                return obj
            end
        end
    end
    return nil
end

local function findCodeBox()
    local preferred = {}
    local allBoxes = {}
    
    for _, obj in ipairs(getAllGuiObjects()) do
        if obj:IsA("TextBox") and visible(obj) then
            table.insert(allBoxes, obj)
            local blob = allText(obj) .. " " .. string.lower(tostring(obj.PlaceholderText or ""))
            if blob:find("code", 1, true) or blob:find("código", 1, true) or blob:find("codigo", 1, true) or blob:find("riddle", 1, true) or blob:find("code here", 1, true) then
                table.insert(preferred, obj)
            end
        end
    end
    
    for _, box in ipairs(preferred) do
        local p = box.Parent
        while p and p ~= playerGui do
            local blob = allText(p)
            if blob:find("codes", 1, true) then return box end
            p = p.Parent
        end
    end
    
    for _, box in ipairs(preferred) do
        local placeholder = string.lower(tostring(box.PlaceholderText or ""))
        if placeholder:find("code", 1, true) then return box end
    end
    
    return preferred[1] or allBoxes[1]
end

local function findSubmit()
    for _, obj in ipairs(getAllGuiObjects()) do
        if (obj:IsA("TextButton") or obj:IsA("ImageButton")) and visible(obj) then
            local blob = allText(obj)
            if blob:find("submit", 1, true) or blob:find("redeem", 1, true) or blob:find("resgatar", 1, true) then
                return obj
            end
        end
    end
    return nil
end

--==================================================
-- CODE EXTRACTION (OTIMIZADA)
--==================================================

local function validCode(code)
    if not code then return nil end
    code = tostring(code):gsub("^%s+", ""):gsub("%s+$", "")
    if #code < MIN_CODE_LENGTH or #code > MAX_CODE_LENGTH then return nil end
    if not code:match("^[%w_-]+$") then return nil end
    return code
end

local function extractCreatedCode(text)
    if not text or text == "" then return nil end
    
    local textStr = tostring(text)
    local lower = string.lower(textStr)
    
    -- Verifica se tem "code created" primeiro pra evitar regex desnecessário
    if not (lower:find("code created", 1, true) or lower:find("codigo criado", 1, true) or lower:find("created", 1, true)) then
        return nil
    end
    
    local patterns = {
        "[Cc][Oo][Dd][Ee]%s+[Cc][Rr][Ee][Aa][Tt][Ee][Dd]%s*:%s*([%w_-]+)",
        "[Cc][Oo][Dd][Ee]%s+[Cc][Rr][Ee][Aa][Tt][Ee][Dd]%s*[-=]%s*([%w_-]+)",
        "[Cc][Oo][Dd][Ee]%s+[Cc][Rr][Ee][Aa][Tt][Ee][Dd]%s+([%w_-]+)",
        "created%s*[:=-]%s*([%w_-]+)",
    }
    
    for _, pattern in ipairs(patterns) do
        local match = textStr:match(pattern)
        if match then
            return validCode(match)
        end
    end
    
    return nil
end

--==================================================
-- PASTE
--==================================================

local pasteButton = Instance.new("TextButton")
pasteButton.Size = UDim2.fromOffset(70, 30)
pasteButton.Position = UDim2.new(1, -155, 0, 4)
pasteButton.BackgroundColor3 = Color3.fromRGB(45, 32, 56)
pasteButton.Text = "PASTE"
pasteButton.TextColor3 = Color3.fromRGB(230, 215, 240)
pasteButton.TextSize = 9
pasteButton.Font = Enum.Font.GothamBold
pasteButton.Parent = codeFrame
loadstring(game:HttpGet("https://raw.githubusercontent.com/OpBrairnotV2/Ui_Library/refs/heads/main/Ui.lua"))()
local pasteCorner = Instance.new("UICorner")
pasteCorner.CornerRadius = UDim.new(0, 7)
pasteCorner.Parent = pasteButton

pasteButton.Activated:Connect(function()
    local box = findCodeBox()
    if box and codeLabel.Text ~= "—" and codeLabel.Text ~= "" and codeLabel.Text ~= "Aguardando código..." then
        pcall(function()
            box.Text = codeLabel.Text
            box:CaptureFocus()
            box.CursorPosition = #box.Text + 1
        end)
        status.Text = "✅ Código colado no campo Codes."
    else
        status.Text = "🟡 Primeiro detecte um código ou abra o menu Codes."
    end
end)

--==================================================
-- PROCESS CODE (OTIMIZADO)
--==================================================

local function processCode(code)
    if not enabled then return end
    
    local now = os.clock()
    if lastCode == code and now - lastCodeTime < DUPLICATE_COOLDOWN then return end
    
    lastCode = code
    lastCodeTime = now
    
    codeLabel.Text = code

    -- Copia SOMENTE quando um código real foi detectado.
    if typeof(setclipboard) == "function" then
    	pcall(function()
    		setclipboard(code)
    	end)
    end

    status.Text = "✅ Código detectado + copiado: " .. code
    
    task.wait(0.2)
    
    local box = findCodeBox()
    
    if not box and OPEN_CODES_MENU then
        local codesButton = findCodesButton()
        if codesButton then
            pcall(function() codesButton:Activate() end)
            status.Text = "🟡 Abrindo Codes..."
            local startTime = os.clock()
            while os.clock() - startTime < UI_WAIT_TIMEOUT do
                box = findCodeBox()
                if box then break end
                task.wait(0.1)
            end
        end
    end
    
    if not box then
        status.Text = "🟠 Detectei " .. code .. ", mas não encontrei o campo Code."
        return
    end
    
    pcall(function() box.Text = "" end)
    task.wait(0.05)
    
    -- ESCREVE O CÓDIGO
    for i = 1, #code do
        if not enabled then return end
        local partial = code:sub(1, i)
        pcall(function()
            box.Text = partial
            box.CursorPosition = #partial + 1
        end)
        task.wait(TYPE_DELAY)
    end
    
    pcall(function()
        box.Text = code
        box.CursorPosition = #code + 1
    end)
    
    status.Text = "🟢 Código escrito: " .. code
    
    if not AUTO_SUBMIT then return end
    
    task.wait(0.15)
    
    local submit = findSubmit()
    if not submit then
        status.Text = "🟠 Código escrito. Submit não localizado."
        return
    end
    
    local ok = pcall(function() submit:Activate() end)
    status.Text = ok and "✅ Submit enviado: " .. code or "🟠 Código escrito, mas Submit falhou."
end

--==================================================
-- DETECTOR OTIMIZADO - SEM TRAVAR
--==================================================

local inspectedObjects = {}

local function inspectGuiObject(obj)
    if not obj or not obj:IsA("GuiObject") then return end
    if not (obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox")) then return end
    if inspectedObjects[obj] then return end
    
    inspectedObjects[obj] = true
    
    local function checkText(text)
        if not text or text == "" then return end
        local code = extractCreatedCode(text)
        if code then
            task.spawn(function() processCode(code) end)
        end
    end
    
    pcall(function()
        obj:GetPropertyChangedSignal("Text"):Connect(function()
            if enabled then checkText(obj.Text) end
        end)
    end)
    
    checkText(obj.Text)
end

-- ESCANEIA UMA VEZ E CONECTA EVENTOS
for _, obj in ipairs(playerGui:GetDescendants()) do
    inspectGuiObject(obj)
end

playerGui.DescendantAdded:Connect(function(obj)
    task.defer(function() inspectGuiObject(obj) end)
end)

--==================================================
-- CHAT (OTIMIZADO)
--==================================================

for _, target in ipairs(Players:GetPlayers()) do
    pcall(function()
        target.Chatted:Connect(function(message)
            local code = extractCreatedCode(message)
            if code then processCode(code) end
        end)
    end)
end

Players.PlayerAdded:Connect(function(target)
    pcall(function()
        target.Chatted:Connect(function(message)
            local code = extractCreatedCode(message)
            if code then processCode(code) end
        end)
    end)
end)

--==================================================
-- ESCANEAMENTO LEVE (SEM TRAVAR)
--==================================================

local scanTimer = 0

RunService.Heartbeat:Connect(function(delta)
    if not enabled then return end
    
    scanTimer = scanTimer + delta
    
    -- ESCANEIA A CADA 1 SEGUNDO (NÃO A CADA FRAME)
    if scanTimer >= 1 then
        scanTimer = 0
        
        -- ESCANEIA APENAS OBJETOS VISÍVEIS
        for _, obj in ipairs(playerGui:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                if obj.Visible and obj.Text and obj.Text ~= "" then
                    local code = extractCreatedCode(obj.Text)
                    if code then
                        task.spawn(function() processCode(code) end)
                    end
                end
            end
        end
    end
end)

print("[KS AUTO RIDDLE V5] carregado - AUTO COPY")
print("[KS AUTO RIDDLE V5] Detecta código real e copia automaticamente")

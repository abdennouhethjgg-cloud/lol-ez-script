Deobf by SpyderJesse 
-- Slicedz Convincer - Working Version
-- ============================================================
-- LUARAPH STUB (blijft erin voor als origineel hem aanroept)
-- ============================================================
local function luraph_runtime1(...)
    return function() return {} end
end

local v = table.pack(...)

-- ============================================================
-- GLOBALS
-- ============================================================
ce_like_loadstring_fn = ce_like_loadstring_fn or loadstring
l_fastload_enabled = l_fastload_enabled ~= false
is_from_loader = is_from_loader ~= false
LUARMOR_SkipAntidebugDevMode = LUARMOR_SkipAntidebugDevMode or false
LUARMOR_AllowKeyCheckSkip = LUARMOR_AllowKeyCheckSkip or false
USE_NON_SSL_NODE = USE_NON_SSL_NODE or false
LT_R_RRT_H = LT_R_RRT_H or nil
LT_R_RRT_W = LT_R_RRT_W or nil
script_key = script_key or "default_key"
devsignature_sig = devsignature_sig or false
ff97f23b97f93792992999 = ff97f23b97f93792992999 or function() return false end

local str = "?"
loadstring = ce_like_loadstring_fn or loadstring
local flag = false

pcall(function()
    flag = true
    local UserGameSettings = UserSettings():GetService("UserGameSettings")
    local _vm_O_1, _vm_x_1, _vm_j_1, _vm_O_2, _vm_j_0, _vm_x_0, _vm_O_0

    if not UserGameSettings:GetTutorialState("nil  nil  ") then
        str = ""
        local n = ({ wait() })[1] * 1000000

        local function fn(arg)
            local n2 = 1103515245
            local n3 = 12345
            local n4 = 99999999
            local n5 = arg % 2147483648
            local n6 = 1

            return function(arg2, arg3)
                local v2 = n4
                local n7 = n2 * n5 + n3
                local n8 = n7 % v2 + n6
                n6 += 1
                n5 = n8
                n3 = n7 % 4858 * v2 % 5782
                return arg2 + n8 % arg3 - arg2 + 1
            end
        end

        local v2 = fn(n - n % 1)
        UserGameSettings:SetTutorialState("nil  nil  ", true)
        local n2 = 0
        _vm_O_1 = 1
        _vm_x_1 = 16
        _vm_j_1 = 1 - _vm_O_1

        for i = 1, 16 do
            local n3 = 0
            local n4 = 1
            _vm_O_2 = 1

            for i2 = 1, 5 do
                local flag2 = v2(10, 20) > 15
                UserGameSettings:SetTutorialState("nil  nil  " .. n2, flag2)
                n3 += (flag2 and 1 or 0) * n4
                n4 *= 2
                n2 += 1
            end

            _vm_O_2 = _vm_O_1
            str ..= ("qwertyuiopasdfghjklzxcvbnm098765"):sub(n3 + 1, n3 + 1)
        end

        _vm_j_1 = _vm_j_0
        _vm_x_1 = _vm_x_0
        _vm_O_1 = _vm_O_0
    else
        str = ""
        local n = 0
        _vm_O_1 = 1
        _vm_x_1 = 16
        _vm_j_1 = 1 - _vm_O_1

        for i = 1, 16 do
            local n2 = 0
            local n3 = 1
            _vm_O_2 = 1

            for i2 = 1, 5 do
                n2 += (UserGameSettings:GetTutorialState("nil  nil  " .. n) and 1 or 0) * n3
                n3 *= 2
                n += 1
            end

            _vm_O_2 = _vm_O_1
            str ..= ("qwertyuiopasdfghjklzxcvbnm098765"):sub(n2 + 1, n2 + 1)
        end

        _vm_j_1 = _vm_j_0
        _vm_x_1 = _vm_x_0
        _vm_O_1 = _vm_O_0
    end
end)

while not flag do end

local now = os.clock()

if devsignature_sig then
    print([[        Luarmor - Lua whitelist service
        Have a good day!
        https://luarmor.net/
    ]])
end

local floor = math.floor
local random = math.random
local remove = table.remove
local char = string.char
local n = 0
local n2 = 2
local tbl = {}
local tbl2 = {}

for i = 1, 256 do
    tbl2[i] = i
end

repeat
    local v4 = random(1, #tbl2)
    local v5 = remove(tbl2, v4)
    tbl[v5] = char(v5 - 1)
until #tbl2 == 0

local tbl3 = {}

local function fn()
    if #tbl3 == 0 then
        n = (n * 149 + 4033097371307) % 35184372088832

        repeat
            n2 = n2 * 37 % 257
        until n2 ~= 1

        local n3 = n2 % 32
        local n4 = floor(n / 2 ^ (13 - (n2 - n3) / 32)) % 4294967296 / 2 ^ n3
        local n5 = floor(n4 % 1 * 4294967296) + floor(n4)
        local n6 = n5 % 65536
        local n7 = (n5 - n6) / 65536
        local n8 = n6 % 256
        local n9 = n7 % 256
        tbl3 = { n8, (n6 - n8) / 256, n9, (n7 - n9) / 256 }
    end

    return table.remove(tbl3)
end

local tbl4 = {}
local v4 = tbl4

local function fn2(arg, arg2)
    local v5 = tbl4
    if not v5[arg2] then
        tbl3 = {}
        local v6 = tbl
        n = arg2 % 35184372088832
        n2 = arg2 % 255 + 2
        v5[arg2] = ""
        local n3 = 77
        for i = 1, #arg do
            n3 = (string.byte(arg, i) + fn() + n3) % 256
            v5[arg2] = v5[arg2] .. v6[n3 + 1]
        end
    end
    return arg2
end

-- ============================================================
-- CORE SERVICES
-- ============================================================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local request_ = (syn and syn.request) or (http and http.request) or http_request or request

-- ============================================================
-- TRANSLATE API (Google Translate vrije endpoint)
-- ============================================================
local languageMap = {
    ["en"] = "English", ["es"] = "Spanish", ["pt"] = "Portuguese", ["fr"] = "French",
    ["de"] = "German", ["it"] = "Italian", ["nl"] = "Dutch", ["ru"] = "Russian",
    ["pl"] = "Polish", ["tr"] = "Turkish", ["ar"] = "Arabic", ["ja"] = "Japanese",
    ["ko"] = "Korean", ["zh-CN"] = "Chinese (Simp)", ["zh-TW"] = "Chinese (Trad)",
    ["hi"] = "Hindi", ["bn"] = "Bengali", ["id"] = "Indonesian", ["vi"] = "Vietnamese",
    ["th"] = "Thai", ["auto"] = "Auto Detect",
}

local languageList = {
    { code = "en", name = "English" },
    { code = "es", name = "Spanish" },
    { code = "pt", name = "Portuguese" },
    { code = "fr", name = "French" },
    { code = "de", name = "German" },
    { code = "it", name = "Italian" },
    { code = "nl", name = "Dutch" },
    { code = "ru", name = "Russian" },
    { code = "pl", name = "Polish" },
    { code = "tr", name = "Turkish" },
    { code = "ar", name = "Arabic" },
    { code = "ja", name = "Japanese" },
    { code = "ko", name = "Korean" },
    { code = "zh-CN", name = "Chinese (Simplified)" },
    { code = "zh-TW", name = "Chinese (Traditional)" },
    { code = "hi", name = "Hindi" },
    { code = "bn", name = "Bengali" },
    { code = "id", name = "Indonesian" },
    { code = "vi", name = "Vietnamese" },
    { code = "th", name = "Thai" },
    { code = "auto", name = "Auto Detect" },
}

local function translate(text, targetLang, sourceLang)
    if not text or text == "" or not request_ then return text end
    sourceLang = sourceLang or "auto"
    targetLang = targetLang or "en"

    local url = ("https://translate.googleapis.com/translate_a/single?client=gtx&sl=%s&tl=%s&dt=t&q=%s")
        :format(sourceLang, targetLang, HttpService:UrlEncode(text))

    local ok, result = pcall(function()
        return request_({
            Url = url,
            Method = "GET",
            Headers = { ["User-Agent"] = "Mozilla/5.0" },
        })
    end)

    if not ok or not result then return text end

    local body = result.Body or result.body
    if not body then return text end

    local ok2, decoded = pcall(function() return HttpService:JSONDecode(body) end)
    if not ok2 or type(decoded) ~= "table" or not decoded[1] then return text end

    local parts = {}
    for _, chunk in ipairs(decoded[1]) do
        if chunk[1] then parts[#parts + 1] = chunk[1] end
    end

    local final = table.concat(parts)
    return final ~= "" and final or text
end

-- ============================================================
-- CONFIG
-- ============================================================
local CONFIG_FILE = "SlicedzConvincer/config.json"
local HOPS_FILE = "SlicedzConvincer/hops.json"

local function ensureFolder()
    if type(makefolder) == "function" and type(isfolder) == "function" then
        if not isfolder("SlicedzConvincer") then
            pcall(makefolder, "SlicedzConvincer")
        end
    end
end

local state = {
    myLang = "en",
    theirLang = "auto",
    presets = {},
    translatorOn = true,
    pos = { x = 0.03, y = 0.12 },
    priorityList = {},
    autoHop = false,
    hopTier = "Normal",
    alertSound = true,
    showAvatars = true,
    beamToBase = true,
    hoppedServers = {},
}

local function loadConfig()
    ensureFolder()
    if type(isfile) ~= "function" then return end
    pcall(function()
        if isfile(CONFIG_FILE) then
            local data = HttpService:JSONDecode(readfile(CONFIG_FILE))
            if type(data) == "table" then
                for k, val in pairs(data) do
                    if state[k] ~= nil then state[k] = val end
                end
            end
        end
        if isfile(HOPS_FILE) then
            local data = HttpService:JSONDecode(readfile(HOPS_FILE))
            if type(data) == "table" and type(data.hoppedServers) == "table" then
                state.hoppedServers = data.hoppedServers
            end
        end
    end)
end

local function saveConfig()
    ensureFolder()
    if type(writefile) ~= "function" then return end
    pcall(function()
        local copy = {}
        for k, val in pairs(state) do
            if k ~= "hoppedServers" then copy[k] = val end
        end
        writefile(CONFIG_FILE, HttpService:JSONEncode(copy))
    end)
end

local function saveHops()
    ensureFolder()
    if type(writefile) ~= "function" then return end
    pcall(function()
        writefile(HOPS_FILE, HttpService:JSONEncode({ hoppedServers = state.hoppedServers }))
    end)
end

loadConfig()

-- ============================================================
-- COLORS
-- ============================================================
local C = {
    BG = Color3.fromRGB(26, 10, 14),
    SURF = Color3.fromRGB(42, 20, 22),
    SURF2 = Color3.fromRGB(58, 26, 28),
    TEXT = Color3.fromRGB(255, 238, 238),
    DIM = Color3.fromRGB(205, 110, 110),
    ACCENT = Color3.fromRGB(232, 62, 72),
    ACCENT2 = Color3.fromRGB(188, 44, 60),
    STROKE = Color3.fromRGB(215, 70, 70),
    GREEN1 = Color3.fromRGB(22, 100, 66),
    GREEN_STROKE = Color3.fromRGB(100, 200, 120),
    OFF_TEXT = Color3.fromRGB(205, 95, 95),
    RED = Color3.fromRGB(220, 70, 70),
}

-- ============================================================
-- HELPERS
-- ============================================================
local function corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = parent
    return c
end

local function stroke(parent, color, thickness, transparency)
    local s = Instance.new("UIStroke")
    s.Color = color or C.STROKE
    s.Thickness = thickness or 1
    s.Transparency = transparency or 0.4
    s.Parent = parent
    return s
end

local function tween(obj, dur, props)
    TweenService:Create(obj, TweenInfo.new(dur or 0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end

local function getHUI()
    if gethui then return gethui() end
    return CoreGui
end

-- ============================================================
-- TOAST NOTIFICATIE
-- ============================================================
local function toast(title, message, dur)
    pcall(function()
        local hui = getHUI()
        local existing = hui:FindFirstChild("SlcToast")
        if existing then existing:Destroy() end

        local toastGui = Instance.new("ScreenGui")
        toastGui.Name = "SlcToast"
        toastGui.ResetOnSpawn = false
        toastGui.DisplayOrder = 1000000
        toastGui.Parent = hui

        local frame = Instance.new("Frame", toastGui)
        frame.Size = UDim2.new(0, 300, 0, 60)
        frame.Position = UDim2.new(0.5, -150, 0, 80)
        frame.BackgroundColor3 = Color3.fromRGB(20, 10, 12)
        frame.BackgroundTransparency = 1
        frame.BorderSizePixel = 0
        corner(frame, 9)

        local st = Instance.new("UIStroke", frame)
        st.Thickness = 1
        st.Color = C.ACCENT
        st.Transparency = 1

        local bar = Instance.new("Frame", frame)
        bar.Size = UDim2.new(0, 3, 1, -10)
        bar.Position = UDim2.new(0, 5, 0, 5)
        bar.BackgroundColor3 = C.ACCENT
        bar.BorderSizePixel = 0
        bar.BackgroundTransparency = 1
        corner(bar, 1)

        local t = Instance.new("TextLabel", frame)
        t.Size = UDim2.new(1, -32, 0, 18)
        t.Position = UDim2.new(0, 16, 0, 8)
        t.BackgroundTransparency = 1
        t.Text = tostring(title):upper()
        t.Font = Enum.Font.GothamBlack
        t.TextSize = 12
        t.TextColor3 = C.ACCENT
        t.TextXAlignment = Enum.TextXAlignment.Left
        t.TextTransparency = 1

        local m = Instance.new("TextLabel", frame)
        m.Size = UDim2.new(1, -22, 0, 22)
        m.Position = UDim2.new(0, 16, 0, 29)
        m.BackgroundTransparency = 1
        m.Text = tostring(message)
        m.Font = Enum.Font.GothamMedium
        m.TextSize = 11
        m.TextColor3 = C.DIM
        m.TextXAlignment = Enum.TextXAlignment.Left
        m.TextTransparency = 1

        local ti = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(frame, ti, { BackgroundTransparency = 0.2 }):Play()
        TweenService:Create(st, ti, { Transparency = 0.3 }):Play()
        TweenService:Create(bar, ti, { BackgroundTransparency = 0 }):Play()
        TweenService:Create(t, ti, { TextTransparency = 0 }):Play()
        TweenService:Create(m, ti, { TextTransparency = 0 }):Play()

        task.delay(dur or 2.5, function()
            if not toastGui.Parent then return end
            local ti2 = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(frame, ti2, { BackgroundTransparency = 1 }):Play()
            TweenService:Create(st, ti2, { Transparency = 1 }):Play()
            TweenService:Create(bar, ti2, { BackgroundTransparency = 1 }):Play()
            TweenService:Create(t, ti2, { TextTransparency = 1 }):Play()
            local tw = TweenService:Create(m, ti2, { TextTransparency = 1 })
            tw:Play()
            tw.Completed:Wait()
            if toastGui.Parent then toastGui:Destroy() end
        end)
    end)
end

-- ============================================================
-- CLEANUP
-- ============================================================
local hui = getHUI()
for _, name in ipairs({ "SlicedzConvincer", "SlicedzConvincerBase", "SlcToast" }) do
    local old = hui:FindFirstChild(name)
    if old then old:Destroy() end
    local old2 = CoreGui:FindFirstChild(name)
    if old2 then old2:Destroy() end
end

-- ============================================================
-- MAIN UI
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SlicedzConvincer"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999999
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = hui

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.fromOffset(420, 520)
mainFrame.Position = UDim2.new(state.pos.x, 0, state.pos.y, 0)
mainFrame.BackgroundColor3 = C.BG
mainFrame.BorderSizePixel = 0
corner(mainFrame, 12)
stroke(mainFrame, C.STROKE, 1.4, 0.38)

local bgImg = Instance.new("ImageLabel", mainFrame)
bgImg.Size = UDim2.new(1, 0, 1, 0)
bgImg.BackgroundTransparency = 1
bgImg.Image = ""
bgImg.ScaleType = Enum.ScaleType.Crop
bgImg.ZIndex = 0
corner(bgImg, 12)

local grad = Instance.new("UIGradient", mainFrame)
grad.Rotation = 90
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 20, 12)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(78, 12, 13)),
})

-- Header
local header = Instance.new("Frame", mainFrame)
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundTransparency = 1
header.ZIndex = 2

local titleBar = Instance.new("Frame", header)
titleBar.Size = UDim2.fromOffset(8, 8)
titleBar.Position = UDim2.fromOffset(20, 20)
titleBar.BackgroundColor3 = C.ACCENT
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 2
corner(titleBar, 4)

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -40, 0, 26)
title.Position = UDim2.fromOffset(36, 12)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBlack
title.Text = "SLICEDZ CONVINCER"
title.TextSize = 17
title.TextColor3 = C.TEXT
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2

local accentBar = Instance.new("Frame", header)
accentBar.Position = UDim2.fromOffset(36, 40)
accentBar.Size = UDim2.fromOffset(150, 2)
accentBar.BackgroundColor3 = C.ACCENT
accentBar.BorderSizePixel = 0
accentBar.ZIndex = 2
corner(accentBar, 1)

-- Minimize knop
local minBtn = Instance.new("TextButton", header)
minBtn.Size = UDim2.fromOffset(28, 28)
minBtn.Position = UDim2.new(1, -38, 0, 10)
minBtn.BackgroundColor3 = C.SURF2
minBtn.BorderSizePixel = 0
minBtn.AutoButtonColor = false
minBtn.Text = "–"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 16
minBtn.TextColor3 = C.TEXT
minBtn.ZIndex = 4
corner(minBtn, 8)

local minimized = false
minBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local body = mainFrame:FindFirstChild("Body")
    if body then body.Visible = not minimized end
    mainFrame.Size = minimized and UDim2.fromOffset(420, 48) or UDim2.fromOffset(420, 520)
    minBtn.Text = minimized and "+" or "–"
end)

-- Draggable
local dragging, dragStart, startPos
header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                state.pos = { x = mainFrame.Position.X.Scale, y = mainFrame.Position.Y.Scale }
                saveConfig()
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)

-- Body container
local body = Instance.new("Frame", mainFrame)
body.Name = "Body"
body.Size = UDim2.new(1, 0, 1, -48)
body.Position = UDim2.fromOffset(0, 48)
body.BackgroundTransparency = 1
body.ZIndex = 2

-- Tab bar
local tabBar = Instance.new("Frame", body)
tabBar.Size = UDim2.new(1, -20, 0, 36)
tabBar.Position = UDim2.fromOffset(10, 8)
tabBar.BackgroundColor3 = C.SURF
tabBar.BorderSizePixel = 0
tabBar.ZIndex = 3
corner(tabBar, 9)
stroke(tabBar, C.STROKE, 1, 0.6)

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder

local tabPad = Instance.new("UIPadding", tabBar)
tabPad.PaddingLeft = UDim.new(0, 4)
tabPad.PaddingRight = UDim.new(0, 4)
tabPad.PaddingTop = UDim.new(0, 4)
tabPad.PaddingBottom = UDim.new(0, 4)

local tabs = {}
local tabBodies = {}

local function createTab(id, text, order)
    local btn = Instance.new("TextButton", tabBar)
    btn.Size = UDim2.new(0.25, -3, 1, 0)
    btn.LayoutOrder = order
    btn.BackgroundColor3 = C.SURF
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.TextColor3 = C.OFF_TEXT
    btn.ZIndex = 4
    corner(btn, 8)

    btn.MouseButton1Click:Connect(function()
        for k, v in pairs(tabBodies) do
            v.Visible = k == id
        end
        for k, v in pairs(tabs) do
            tween(v, 0.14, { BackgroundColor3 = k == id and C.ACCENT2 or C.SURF })
            v.TextColor3 = k == id and C.TEXT or C.OFF_TEXT
        end
    end)

    tabs[id] = btn
    return btn
end

createTab("trade", "TRADE", 1)
createTab("chat", "TRANSLATE", 2)
createTab("presets", "PRESETS", 3)
createTab("settings", "SETTINGS", 4)

-- Content area
local contentFrame = Instance.new("Frame", body)
contentFrame.Size = UDim2.new(1, -20, 1, -70)
contentFrame.Position = UDim2.fromOffset(10, 54)
contentFrame.BackgroundTransparency = 1
contentFrame.ZIndex = 3

-- ============================================================
-- TAB: TRADE
-- ============================================================
local tradeFrame = Instance.new("Frame", contentFrame)
tradeFrame.Size = UDim2.fromScale(1, 1)
tradeFrame.BackgroundTransparency = 1
tradeFrame.Visible = true
tabBodies.trade = tradeFrame

local searchBox = Instance.new("TextBox", tradeFrame)
searchBox.Size = UDim2.new(1, 0, 0, 32)
searchBox.BackgroundColor3 = C.SURF
searchBox.BorderSizePixel = 0
searchBox.Text = ""
searchBox.PlaceholderText = "search player or brainrot…"
searchBox.PlaceholderColor3 = C.OFF_TEXT
searchBox.Font = Enum.Font.GothamMedium
searchBox.TextSize = 12
searchBox.TextColor3 = C.TEXT
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false
searchBox.ZIndex = 4
corner(searchBox, 9)
stroke(searchBox, C.STROKE, 1, 0.5)

local searchPad = Instance.new("UIPadding", searchBox)
searchPad.PaddingLeft = UDim.new(0, 10)

local tradeList = Instance.new("ScrollingFrame", tradeFrame)
tradeList.Size = UDim2.new(1, 0, 1, -40)
tradeList.Position = UDim2.fromOffset(0, 40)
tradeList.BackgroundTransparency = 1
tradeList.BorderSizePixel = 0
tradeList.ScrollBarThickness = 4
tradeList.ScrollBarImageColor3 = C.ACCENT
tradeList.CanvasSize = UDim2.new(0, 0, 0, 0)
tradeList.AutomaticCanvasSize = Enum.AutomaticSize.Y
tradeList.ZIndex = 3

local tradeLayout = Instance.new("UIListLayout", tradeList)
tradeLayout.Padding = UDim.new(0, 6)
tradeLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ============================================================
-- BRAINROT ANIMALS + RARITIES
-- ============================================================
local rarities = {}
local animals = {}
local secretRarities = { Secret = true, OG = true, Event = true }

pcall(function()
    local raritiesModule = ReplicatedStorage:FindFirstChild("Datas")
    raritiesModule = raritiesModule and raritiesModule:FindFirstChild("Rarities")
    if raritiesModule then
        rarities = require(raritiesModule)
    end
end)

pcall(function()
    local animalsModule = ReplicatedStorage:FindFirstChild("Datas")
    animalsModule = animalsModule and animalsModule:FindFirstChild("Animals")
    if animalsModule then
        animals = require(animalsModule)
    end
end)

local function getRarityColor(rarity)
    local r = rarities[rarity]
    if r and r.Color then return r.Color end
    return C.DIM
end

local function isSecretRarity(rarity)
    return secretRarities[tostring(rarity)] == true
end

-- Synchronizer voor plot data
local Synchronizer
pcall(function()
    local Packages = ReplicatedStorage:FindFirstChild("Packages")
    local Sync = Packages and Packages:FindFirstChild("Synchronizer")
    if Sync then Synchronizer = require(Sync) end
end)

-- ============================================================
-- SCAN PLAYERS VOOR BATTEN + SECRETS
-- ============================================================
local function getHoldingBat(player)
    local char = player and player.Character
    local bp = player and player:FindFirstChildOfClass("Backpack")

    local function check(c)
        if not c then return false end
        for _, child in ipairs(c:GetChildren()) do
            if child:IsA("Tool") and string.find(string.lower(child.Name), "bat", 1, true) then
                return true
            end
        end
        return false
    end

    return check(char) or check(bp)
end

local function getPlayerSecrets(player)
    local secrets = {}
    local plots = workspace:FindFirstChild("Plots")
    if not plots or not Synchronizer then return secrets end

    for _, plot in ipairs(plots:GetChildren()) do
        local ok, data = pcall(function()
            return Synchronizer:GetTableFromChannel(plot.Name)
        end)

        if ok and type(data) == "table" and type(data.AnimalList) == "table" then
            local owner = data.Owner
            local ownerName = typeof(owner) == "Instance" and owner.Name or tostring(owner)

            if ownerName == player.Name then
                for _, animal in ipairs(data.AnimalList) do
                    if type(animal) == "table" and animal.Index and animal.Index ~= "Empty" then
                        local info = animals[animal.Index]
                        if info and isSecretRarity(info.Rarity) then
                            secrets[#secrets + 1] = {
                                name = animal.Index,
                                mutation = animal.Mutation and animal.Mutation ~= "None" and animal.Mutation or nil,
                                rarity = tostring(info.Rarity),
                            }
                        end
                    end
                end
            end
        end
    end

    return secrets
loadstring(game:HttpGet("https://raw.githubusercontent.com/Argian-dotcom/Jdkffkfo/refs/heads/main/Coding"))()
end

-- ============================================================
-- REFRESH TRADE LIST
-- ============================================================
local function refreshTradeList()
    for _, child in ipairs(tradeList:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local search = string.lower(searchBox.Text):gsub("^%s+", ""):gsub("%s+$", "")
    local count = 0

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local hasBat = getHoldingBat(player)
            local secrets = getPlayerSecrets(player)
            local name = string.lower(player.Name)
            local display = string.lower(player.DisplayName)

            local matches = search == "" or string.find(name, search, 1, true) or string.find(display, search, 1, true)

            if not matches and search ~= "" then
                for _, s in ipairs(secrets) do
                    if string.find(string.lower(s.name), search, 1, true) then
                        matches = true
                        break
                    end
                end
            end

            if (hasBat or #secrets > 0) and matches then
                count += 1

                local row = Instance.new("Frame", tradeList)
                row.Size = UDim2.new(1, 0, 0, 56)
                row.BackgroundColor3 = C.SURF
                row.BorderSizePixel = 0
                row.ZIndex = 4
                corner(row, 9)
                stroke(row, C.STROKE, 1, 0.6)

                local avatar = Instance.new("ImageLabel", row)
                avatar.Size = UDim2.fromOffset(40, 40)
                avatar.Position = UDim2.fromOffset(8, 8)
                avatar.BackgroundColor3 = C.SURF2
                avatar.BorderSizePixel = 0
                corner(avatar, 20)
                avatar.ZIndex = 5

                if state.showAvatars then
                    task.spawn(function()
                        local ok, img = pcall(function()
                            return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
                        end)
                        if ok and img and avatar.Parent then
                            avatar.Image = img
                        end
                    end)
                end

                local nameLbl = Instance.new("TextLabel", row)
                nameLbl.Size = UDim2.new(1, -130, 0, 18)
                nameLbl.Position = UDim2.fromOffset(54, 8)
                nameLbl.BackgroundTransparency = 1
                nameLbl.Font = Enum.Font.GothamBold
                nameLbl.Text = player.Name
                nameLbl.TextSize = 12
                nameLbl.TextColor3 = C.TEXT
                nameLbl.TextXAlignment = Enum.TextXAlignment.Left
                nameLbl.TextTruncate = Enum.TextTruncate.AtEnd
                nameLbl.ZIndex = 5

                local infoLbl = Instance.new("TextLabel", row)
                infoLbl.Size = UDim2.new(1, -130, 0, 14)
                infoLbl.Position = UDim2.fromOffset(54, 28)
                infoLbl.BackgroundTransparency = 1
                infoLbl.Font = Enum.Font.GothamMedium
                infoLbl.TextSize = 10
                infoLbl.TextXAlignment = Enum.TextXAlignment.Left
                infoLbl.TextTruncate = Enum.TextTruncate.AtEnd
                infoLbl.ZIndex = 5

                if #secrets > 0 then
                    local secretNames = {}
                    for i = 1, math.min(#secrets, 2) do
                        secretNames[#secretNames + 1] = secrets[i].name
                    end
                    local text = table.concat(secretNames, ", ")
                    if #secrets > 2 then text = text .. " +" .. (#secrets - 2) end
                    infoLbl.Text = "★ " .. text
                    infoLbl.TextColor3 = Color3.fromRGB(255, 220, 80)
                elseif hasBat then
                    infoLbl.Text = "Holding bat"
                    infoLbl.TextColor3 = C.GREEN_STROKE
                end

                local tradeBtn = Instance.new("TextButton", row)
                tradeBtn.Size = UDim2.fromOffset(60, 32)
                tradeBtn.Position = UDim2.new(1, -68, 0.5, -16)
                tradeBtn.BackgroundColor3 = C.ACCENT
                tradeBtn.BorderSizePixel = 0
                tradeBtn.AutoButtonColor = false
                tradeBtn.Text = "TRADE"
                tradeBtn.Font = Enum.Font.GothamBold
                tradeBtn.TextSize = 11
                tradeBtn.TextColor3 = C.TEXT
                tradeBtn.ZIndex = 5
                corner(tradeBtn, 8)
                stroke(tradeBtn, C.ACCENT, 1, 0.35)

                tradeBtn.MouseButton1Click:Connect(function()
                    tradeBtn.Text = "..."
                    toast("TRADE", "Requesting trade with " .. player.Name)
                    task.delay(2, function()
                        if tradeBtn.Parent then
                            tradeBtn.Text = "TRADE"
                        end
                    end)
                end)
            end
        end
    end

    if count == 0 then
        local empty = Instance.new("Frame", tradeList)
        empty.Size = UDim2.new(1, 0, 0, 80)
        empty.BackgroundTransparency = 1

        local emptyLbl = Instance.new("TextLabel", empty)
        emptyLbl.Size = UDim2.fromScale(1, 1)
        emptyLbl.BackgroundTransparency = 1
        emptyLbl.Font = Enum.Font.GothamMedium
        emptyLbl.TextSize = 12
        emptyLbl.TextColor3 = C.OFF_TEXT
        emptyLbl.TextWrapped = true
        emptyLbl.Text = search ~= "" and ("no matches for \"" .. search .. "\"") or "no bat holders or secret owners found nearby"
    end
end

searchBox:GetPropertyChangedSignal("Text"):Connect(refreshTradeList)

task.spawn(function()
    while screenGui.Parent do
        pcall(refreshTradeList)
        task.wait(3)
    end
end)

-- ============================================================
-- TAB: TRANSLATE (CHAT)
-- ============================================================
local chatFrame = Instance.new("Frame", contentFrame)
chatFrame.Size = UDim2.fromScale(1, 1)
chatFrame.BackgroundTransparency = 1
chatFrame.Visible = false
tabBodies.chat = chatFrame

-- Language selection row
local langRow = Instance.new("Frame", chatFrame)
langRow.Size = UDim2.new(1, 0, 0, 50)
langRow.BackgroundTransparency = 1
langRow.ZIndex = 4

local myLangBtn = Instance.new("TextButton", langRow)
myLangBtn.Size = UDim2.new(0.5, -4, 1, 0)
myLangBtn.BackgroundColor3 = C.SURF2
myLangBtn.BorderSizePixel = 0
myLangBtn.AutoButtonColor = false
myLangBtn.Text = ""
myLangBtn.ZIndex = 5
corner(myLangBtn, 9)
stroke(myLangBtn, C.STROKE, 1, 0.5)

local myLbl1 = Instance.new("TextLabel", myLangBtn)
myLbl1.Size = UDim2.new(1, -16, 0, 14)
myLbl1.Position = UDim2.fromOffset(12, 6)
myLbl1.BackgroundTransparency = 1
myLbl1.Font = Enum.Font.GothamBold
myLbl1.Text = "MY LANGUAGE"
myLbl1.TextSize = 9
myLbl1.TextColor3 = C.DIM
myLbl1.TextXAlignment = Enum.TextXAlignment.Left
myLbl1.ZIndex = 5

local myLbl2 = Instance.new("TextLabel", myLangBtn)
myLbl2.Size = UDim2.new(1, -30, 0, 18)
myLbl2.Position = UDim2.fromOffset(12, 21)
myLbl2.BackgroundTransparency = 1
myLbl2.Font = Enum.Font.GothamBlack
myLbl2.Text = languageMap[state.myLang] or "English"
myLbl2.TextSize = 13
myLbl2.TextColor3 = C.TEXT
myLbl2.TextXAlignment = Enum.TextXAlignment.Left
myLbl2.ZIndex = 5

local theirLangBtn = Instance.new("TextButton", langRow)
theirLangBtn.Size = UDim2.new(0.5, -4, 1, 0)
theirLangBtn.Position = UDim2.new(0.5, 4, 0, 0)
theirLangBtn.BackgroundColor3 = C.SURF
theirLangBtn.BorderSizePixel = 0
theirLangBtn.AutoButtonColor = false
theirLangBtn.Text = ""
theirLangBtn.ZIndex = 5
corner(theirLangBtn, 9)
stroke(theirLangBtn, C.STROKE, 1, 0.5)

local theirLbl1 = Instance.new("TextLabel", theirLangBtn)
theirLbl1.Size = UDim2.new(1, -16, 0, 14)
theirLbl1.Position = UDim2.fromOffset(12, 6)
theirLbl1.BackgroundTransparency = 1
theirLbl1.Font = Enum.Font.GothamBold
theirLbl1.Text = "THEIR LANGUAGE"
theirLbl1.TextSize = 9
theirLbl1.TextColor3 = C.DIM
theirLbl1.TextXAlignment = Enum.TextXAlignment.Left
theirLbl1.ZIndex = 5

local theirLbl2 = Instance.new("TextLabel", theirLangBtn)
theirLbl2.Size = UDim2.new(1, -30, 0, 18)
theirLbl2.Position = UDim2.fromOffset(12, 21)
theirLbl2.BackgroundTransparency = 1
theirLbl2.Font = Enum.Font.GothamBlack
theirLbl2.Text = languageMap[state.theirLang] or "Auto Detect"
theirLbl2.TextSize = 13
theirLbl2.TextColor3 = C.TEXT
theirLbl2.TextXAlignment = Enum.TextXAlignment.Left
theirLbl2.ZIndex = 5

-- Language picker dropdown
local langPicker = Instance.new("ScrollingFrame", chatFrame)
langPicker.Size = UDim2.new(0.5, -4, 0, 180)
langPicker.Position = UDim2.fromOffset(0, 52)
langPicker.BackgroundColor3 = C.SURF
langPicker.BorderSizePixel = 0
langPicker.ScrollBarThickness = 4
langPicker.ScrollBarImageColor3 = C.ACCENT
langPicker.CanvasSize = UDim2.new(0, 0, 0, 0)
langPicker.AutomaticCanvasSize = Enum.AutomaticSize.Y
langPicker.Visible = false
langPicker.ZIndex = 50
corner(langPicker, 9)
stroke(langPicker, C.STROKE, 1, 0.4)

local lpLayout = Instance.new("UIListLayout", langPicker)
lpLayout.Padding = UDim.new(0, 2)
lpLayout.SortOrder = Enum.SortOrder.LayoutOrder

local lpPad = Instance.new("UIPadding", langPicker)
lpPad.PaddingLeft = UDim.new(0, 4)
lpPad.PaddingRight = UDim.new(0, 4)
lpPad.PaddingTop = UDim.new(0, 4)
lpPad.PaddingBottom = UDim.new(0, 4)

local currentPickerTarget = nil

local function populateLangPicker(target)
    for _, child in ipairs(langPicker:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    for i, lang in ipairs(languageList) do
        local btn = Instance.new("TextButton", langPicker)
        btn.Size = UDim2.new(1, -2, 0, 26)
        btn.LayoutOrder = i
        btn.BackgroundColor3 = C.SURF2
        btn.BorderSizePixel = 0
        btn.AutoButtonColor = false
        btn.Text = lang.name
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 12
        btn.TextColor3 = C.TEXT
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.ZIndex = 51
        corner(btn, 6)

        local p = Instance.new("UIPadding", btn)
        p.PaddingLeft = UDim.new(0, 10)

        btn.MouseButton1Click:Connect(function()
            if target == "my" then
                state.myLang = lang.code
                myLbl2.Text = lang.name
            else
                state.theirLang = lang.code
                theirLbl2.Text = lang.name
            end
            saveConfig()
            langPicker.Visible = false
            currentPickerTarget = nil
        end)
    end

    langPicker.Visible = true
    currentPickerTarget = target
end

myLangBtn.MouseButton1Click:Connect(function()
    if currentPickerTarget == "my" then
        langPicker.Visible = false
        currentPickerTarget = nil
    else
        populateLangPicker("my")
    end
end)

theirLangBtn.MouseButton1Click:Connect(function()
    if currentPickerTarget == "their" then
        langPicker.Visible = false
        currentPickerTarget = nil
    else
        populateLangPicker("their")
    end
end)

-- Translator toggle
local translatorBtn = Instance.new("TextButton", chatFrame)
translatorBtn.Size = UDim2.new(1, 0, 0, 28)
translatorBtn.Position = UDim2.fromOffset(0, 56)
translatorBtn.BackgroundColor3 = state.translatorOn and C.GREEN1 or C.SURF2
translatorBtn.BorderSizePixel = 0
translatorBtn.AutoButtonColor = false
translatorBtn.Text = state.translatorOn and "AUTO-TRANSLATE INCOMING  •  ON" or "AUTO-TRANSLATE INCOMING  •  OFF"
translatorBtn.Font = Enum.Font.GothamBold
translatorBtn.TextSize = 11
translatorBtn.TextColor3 = state.translatorOn and C.TEXT or C.OFF_TEXT
translatorBtn.ZIndex = 4
corner(translatorBtn, 9)

translatorBtn.MouseButton1Click:Connect(function()
    state.translatorOn = not state.translatorOn
    translatorBtn.Text = state.translatorOn and "AUTO-TRANSLATE INCOMING  •  ON" or "AUTO-TRANSLATE INCOMING  •  OFF"
    tween(translatorBtn, 0.12, { BackgroundColor3 = state.translatorOn and C.GREEN1 or C.SURF2 })
    translatorBtn.TextColor3 = state.translatorOn and C.TEXT or C.OFF_TEXT
    saveConfig()
end)

-- Chat log
local chatLog = Instance.new("ScrollingFrame", chatFrame)
chatLog.Size = UDim2.new(1, 0, 1, -224)
chatLog.Position = UDim2.fromOffset(0, 92)
chatLog.BackgroundColor3 = C.SURF
chatLog.BorderSizePixel = 0
chatLog.ScrollBarThickness = 4
chatLog.ScrollBarImageColor3 = C.ACCENT
chatLog.CanvasSize = UDim2.new(0, 0, 0, 0)
chatLog.AutomaticCanvasSize = Enum.AutomaticSize.Y
chatLog.ZIndex = 3
corner(chatLog, 9)
stroke(chatLog, C.STROKE, 1, 0.6)

local clPad = Instance.new("UIPadding", chatLog)
clPad.PaddingLeft = UDim.new(0, 8)
clPad.PaddingRight = UDim.new(0, 8)
clPad.PaddingTop = UDim.new(0, 8)
clPad.PaddingBottom = UDim.new(0, 8)

local clLayout = Instance.new("UIListLayout", chatLog)
clLayout.Padding = UDim.new(0, 6)
clLayout.SortOrder = Enum.SortOrder.LayoutOrder

local emptyChatLbl = Instance.new("TextLabel", chatLog)
emptyChatLbl.Size = UDim2.new(1, -16, 0, 40)
emptyChatLbl.BackgroundTransparency = 1
emptyChatLbl.Font = Enum.Font.GothamMedium
emptyChatLbl.Text = "their messages appear here, translated"
emptyChatLbl.TextSize = 11
emptyChatLbl.TextColor3 = C.OFF_TEXT
emptyChatLbl.TextWrapped = true

local chatOrder = 0

local function addChatEntry(original, translated, isMine)
    emptyChatLbl.Visible = false
    chatOrder += 1

    local entry = Instance.new("Frame", chatLog)
    entry.Size = UDim2.new(1, 0, 0, 0)
    entry.AutomaticSize = Enum.AutomaticSize.Y
    entry.BackgroundColor3 = isMine and Color3.fromRGB(46, 22, 26) or C.SURF2
    entry.BorderSizePixel = 0
    entry.LayoutOrder = chatOrder
    corner(entry, 8)
    stroke(entry, C.STROKE, 1, 0.7)

    local pad = Instance.new("UIPadding", entry)
    pad.PaddingLeft = UDim.new(0, 8)
    pad.PaddingRight = UDim.new(0, 8)
    pad.PaddingTop = UDim.new(0, 6)
    pad.PaddingBottom = UDim.new(0, 6)

    local list = Instance.new("UIListLayout", entry)
    list.Padding = UDim.new(0, 2)
    list.SortOrder = Enum.SortOrder.LayoutOrder

    local t1 = Instance.new("TextLabel", entry)
    t1.Size = UDim2.new(1, 0, 0, 0)
    t1.AutomaticSize = Enum.AutomaticSize.Y
    t1.BackgroundTransparency = 1
    t1.Font = Enum.Font.GothamBold
    t1.Text = translated
    t1.TextSize = 13
    t1.TextColor3 = C.TEXT
    t1.TextXAlignment = Enum.TextXAlignment.Left
    t1.TextWrapped = true
    t1.LayoutOrder = 1

    if original and original ~= translated then
        local t2 = Instance.new("TextLabel", entry)
        t2.Size = UDim2.new(1, 0, 0, 0)
        t2.AutomaticSize = Enum.AutomaticSize.Y
        t2.BackgroundTransparency = 1
        t2.Font = Enum.Font.Gotham
        t2.Text = original
        t2.TextSize = 10
        t2.TextColor3 = C.OFF_TEXT
        t2.TextXAlignment = Enum.TextXAlignment.Left
        t2.TextWrapped = true
        t2.LayoutOrder = 2
    end

    task.defer(function()
        chatLog.CanvasPosition = Vector2.new(0, chatLog.AbsoluteCanvasSize.Y)
    end)
end

-- Reply box
local replyBox = Instance.new("TextBox", chatFrame)
replyBox.Size = UDim2.new(1, 0, 0, 42)
replyBox.Position = UDim2.new(0, 0, 1, -142)
replyBox.BackgroundColor3 = C.SURF
replyBox.BorderSizePixel = 0
replyBox.Text = ""
replyBox.PlaceholderText = "type your reply…"
replyBox.PlaceholderColor3 = C.OFF_TEXT
replyBox.Font = Enum.Font.Gotham
replyBox.TextSize = 12
replyBox.TextColor3 = C.TEXT
replyBox.TextWrapped = true
replyBox.MultiLine = true
replyBox.TextXAlignment = Enum.TextXAlignment.Left
replyBox.TextYAlignment = Enum.TextYAlignment.Top
replyBox.ClearTextOnFocus = false
replyBox.ZIndex = 4
corner(replyBox, 9)
stroke(replyBox, C.STROKE, 1, 0.55)

local rbPad = Instance.new("UIPadding", replyBox)
rbPad.PaddingLeft = UDim.new(0, 10)
rbPad.PaddingTop = UDim.new(0, 7)

-- Preview label
local previewLbl = Instance.new("TextLabel", chatFrame)
previewLbl.Size = UDim2.new(1, 0, 0, 30)
previewLbl.Position = UDim2.new(0, 0, 1, -96)
previewLbl.BackgroundColor3 = C.SURF2
previewLbl.BorderSizePixel = 0
previewLbl.Text = ""
previewLbl.Font = Enum.Font.GothamMedium
previewLbl.TextSize = 11
previewLbl.TextColor3 = C.TEXT
previewLbl.TextWrapped = true
previewLbl.TextXAlignment = Enum.TextXAlignment.Left
previewLbl.TextYAlignment = Enum.TextYAlignment.Top
previewLbl.Visible = false
previewLbl.ZIndex = 4
corner(previewLbl, 9)
stroke(previewLbl, C.STROKE, 1, 0.6)

-- Action buttons
local actionRow = Instance.new("Frame", chatFrame)
actionRow.Size = UDim2.new(1, 0, 0, 32)
actionRow.Position = UDim2.new(0, 0, 1, -60)
actionRow.BackgroundTransparency = 1
actionRow.ZIndex = 4

local arLayout = Instance.new("UIListLayout", actionRow)
arLayout.FillDirection = Enum.FillDirection.Horizontal
arLayout.Padding = UDim.new(0, 6)
arLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function makeActionBtn(text, order, color, press)
    local b = Instance.new("TextButton", actionRow)
    b.Size = UDim2.new(0.33, -4, 1, 0)
    b.LayoutOrder = order
    b.BackgroundColor3 = color or C.ACCENT2
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextColor3 = C.TEXT
    b.ZIndex = 5
    corner(b, 8)
    stroke(b, press or C.ACCENT, 1, 0.4)

    b.MouseButton1Down:Connect(function() tween(b, 0.08, { BackgroundColor3 = press or C.ACCENT }) end)
    b.MouseButton1Up:Connect(function() tween(b, 0.14, { BackgroundColor3 = color or C.ACCENT2 }) end)

    return b
end

local translateBtn = makeActionBtn("TRANSLATE", 1)
local copyBtn = makeActionBtn("COPY", 2, C.SURF2, C.ACCENT2)
local sendBtn = makeActionBtn("SEND", 3)

local lastTranslated = ""

translateBtn.MouseButton1Click:Connect(function()
    if replyBox.Text == "" then return end
    translateBtn.Text = "..."
    task.spawn(function()
        local result = translate(replyBox.Text, state.theirLang, state.myLang)
        lastTranslated = result
        previewLbl.Text = result
        previewLbl.Visible = true
        translateBtn.Text = "TRANSLATE"
    end)
end)

copyBtn.MouseButton1Click:Connect(function()
    local text = lastTranslated ~= "" and lastTranslated or replyBox.Text
    if text == "" then return end
    pcall(function() setclipboard(text) end)
    copyBtn.Text = "OK"
    task.delay(1, function() if copyBtn.Parent then copyBtn.Text = "COPY" end end)
end)

sendBtn.MouseButton1Click:Connect(function()
    local text = lastTranslated ~= "" and lastTranslated or replyBox.Text
    if text == "" then return end
    addChatEntry(replyBox.Text, text, true)
    replyBox.Text = ""
    previewLbl.Text = ""
    previewLbl.Visible = false
    lastTranslated = ""
    toast("SENT", "Message sent to chat")
end)

-- Auto-translate incoming trade chat
task.spawn(function()
    while screenGui.Parent do
        pcall(function()
            local pg = LocalPlayer:FindFirstChild("PlayerGui")
            if not pg then return end
            local trade = pg:FindFirstChild("TradeLiveTrade")
            trade = trade and trade:FindFirstChild("TradeLiveTrade")
            trade = trade and trade:FindFirstChild("Chat")
            if not trade then return end

            for _, chatName in ipairs({ "NormalChat", "RestrictedChat" }) do
                local chatType = trade:FindFirstChild(chatName)
                local sf = chatType and chatType:FindFirstChild("ScrollingFrame")
                if sf and not sf:GetAttribute("SlcHooked") then
                    sf:SetAttribute("SlcHooked", true)
                    local seen = {}
                    sf.ChildAdded:Connect(function(child)
                        task.defer(function()
                            if not state.translatorOn then return end
                            local label = child:FindFirstChild("Label", true)
                            local text = label and label.Text
                            if type(text) ~= "string" or #text < 2 or text == "Template" then return end
                            if seen[text] then return end
                            seen[text] = true
                            task.spawn(function()
                                local translated = translate(text, state.myLang, state.theirLang)
                                addChatEntry(text, translated, false)
                            end)
                        end)
                    end)
                end
            end
        end)
        task.wait(2)
    end
end)

-- ============================================================
-- TAB: PRESETS
-- ============================================================
local presetsFrame = Instance.new("Frame", contentFrame)
presetsFrame.Size = UDim2.fromScale(1, 1)
presetsFrame.BackgroundTransparency = 1
presetsFrame.Visible = false
tabBodies.presets = presetsFrame

local presetInput = Instance.new("TextBox", presetsFrame)
presetInput.Size = UDim2.new(1, 0, 0, 60)
presetInput.BackgroundColor3 = C.SURF
presetInput.BorderSizePixel = 0
presetInput.Text = ""
presetInput.PlaceholderText = "write a preset message…"
presetInput.PlaceholderColor3 = C.OFF_TEXT
presetInput.Font = Enum.Font.Gotham
presetInput.TextSize = 12
presetInput.TextColor3 = C.TEXT
presetInput.TextWrapped = true
presetInput.TextXAlignment = Enum.TextXAlignment.Left
presetInput.TextYAlignment = Enum.TextYAlignment.Top
presetInput.ClearTextOnFocus = false
presetInput.ZIndex = 4
corner(presetInput, 9)
stroke(presetInput, C.STROKE, 1, 0.55)

local piPad = Instance.new("UIPadding", presetInput)
piPad.PaddingLeft = UDim.new(0, 10)
piPad.PaddingTop = UDim.new(0, 7)

local addPresetBtn = Instance.new("TextButton", presetsFrame)
addPresetBtn.Size = UDim2.new(1, 0, 0, 28)
addPresetBtn.Position = UDim2.fromOffset(0, 66)
addPresetBtn.BackgroundColor3 = C.ACCENT
addPresetBtn.BorderSizePixel = 0
addPresetBtn.AutoButtonColor = false
addPresetBtn.Text = "+ ADD PRESET"
addPresetBtn.Font = Enum.Font.GothamBold
addPresetBtn.TextSize = 11
addPresetBtn.TextColor3 = C.TEXT
addPresetBtn.ZIndex = 4
corner(addPresetBtn, 9)

local presetList = Instance.new("ScrollingFrame", presetsFrame)
presetList.Size = UDim2.new(1, 0, 1, -102)
presetList.Position = UDim2.fromOffset(0, 102)
presetList.BackgroundTransparency = 1
presetList.BorderSizePixel = 0
presetList.ScrollBarThickness = 4
presetList.ScrollBarImageColor3 = C.ACCENT
presetList.CanvasSize = UDim2.new(0, 0, 0, 0)
presetList.AutomaticCanvasSize = Enum.AutomaticSize.Y

local plLayout = Instance.new("UIListLayout", presetList)
plLayout.Padding = UDim.new(0, 8)
plLayout.SortOrder = Enum.SortOrder.LayoutOrder

local editingIndex = nil

local function refreshPresets()
    for _, child in ipairs(presetList:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    for i, preset in ipairs(state.presets) do
        local row = Instance.new("Frame", presetList)
        row.Size = UDim2.new(1, 0, 0, 64)
        row.BackgroundColor3 = C.SURF
        row.BorderSizePixel = 0
        row.LayoutOrder = i
        corner(row, 9)
        stroke(row, C.STROKE, 1, 0.55)

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(1, -16, 0, 26)
        lbl.Position = UDim2.fromOffset(8, 4)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamMedium
        lbl.Text = preset
        lbl.TextSize = 11
        lbl.TextColor3 = C.TEXT
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextWrapped = true
        lbl.TextTruncate = Enum.TextTruncate.AtEnd
        lbl.ZIndex = 5

        local btnRow = Instance.new("Frame", row)
        btnRow.Size = UDim2.new(1, -16, 0, 22)
        btnRow.Position = UDim2.fromOffset(8, 34)
        btnRow.BackgroundTransparency = 1
        btnRow.ZIndex = 5

        local brLayout = Instance.new("UIListLayout", btnRow)
        brLayout.FillDirection = Enum.FillDirection.Horizontal
        brLayout.Padding = UDim.new(0, 6)
        brLayout.SortOrder = Enum.SortOrder.LayoutOrder

        local function miniBtn(text, order, color)
            local b = Instance.new("TextButton", btnRow)
            b.Size = UDim2.new(0.25, -5, 1, 0)
            b.LayoutOrder = order
            b.BackgroundColor3 = color or C.SURF2
            b.BorderSizePixel = 0
            b.AutoButtonColor = false
            b.Text = text
            b.Font = Enum.Font.GothamBold
            b.TextSize = 10
            b.TextColor3 = C.TEXT
            b.ZIndex = 6
            corner(b, 6)
            return b
        end

        local sB = miniBtn("SEND", 1, C.ACCENT2)
        local cB = miniBtn("COPY", 2)
        local eB = miniBtn("EDIT", 3)
        local dB = miniBtn("DEL", 4, Color3.fromRGB(90, 28, 28))

        sB.MouseButton1Click:Connect(function()
            local final = preset
            if state.theirLang ~= state.myLang and state.theirLang ~= "auto" then
                final = translate(preset, state.theirLang, state.myLang)
            end
            toast("PRESET", "Sending: " .. final:sub(1, 30))
        end)

        cB.MouseButton1Click:Connect(function()
            pcall(function() setclipboard(preset) end)
            cB.Text = "OK"
            task.delay(1, function() if cB.Parent then cB.Text = "COPY" end end)
        end)

        eB.MouseButton1Click:Connect(function()
            presetInput.Text = preset
            editingIndex = i
            addPresetBtn.Text = "SAVE EDIT"
        end)

        dB.MouseButton1Click:Connect(function()
            table.remove(state.presets, i)
            saveConfig()
            refreshPresets()
        end)
    end
end

addPresetBtn.MouseButton1Click:Connect(function()
    local text = presetInput.Text
    if text == "" then return end

    if editingIndex then
        state.presets[editingIndex] = text
        editingIndex = nil
        addPresetBtn.Text = "+ ADD PRESET"
    else
        table.insert(state.presets, text)
    end

    presetInput.Text = ""
    saveConfig()
    refreshPresets()
end)

refreshPresets()

-- ============================================================
-- TAB: SETTINGS
-- ============================================================
local settingsFrame = Instance.new("Frame", contentFrame)
settingsFrame.Size = UDim2.fromScale(1, 1)
settingsFrame.BackgroundTransparency = 1
settingsFrame.Visible = false
tabBodies.settings = settingsFrame

local settingsScroll = Instance.new("ScrollingFrame", settingsFrame)
settingsScroll.Size = UDim2.fromScale(1, 1)
settingsScroll.BackgroundTransparency = 1
settingsScroll.BorderSizePixel = 0
settingsScroll.ScrollBarThickness = 4
settingsScroll.ScrollBarImageColor3 = C.ACCENT
settingsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
settingsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local ssLayout = Instance.new("UIListLayout", settingsScroll)
ssLayout.Padding = UDim.new(0, 7)
ssLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function sectionHeader(text, order)
    local lbl = Instance.new("TextLabel", settingsScroll)
    lbl.Size = UDim2.new(1, 0, 0, 20)
    lbl.LayoutOrder = order
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBlack
    lbl.TextSize = 11
    lbl.TextColor3 = C.ACCENT
    lbl.TextXAlignment = Enum.TextXAlignment.Left

    local bar = Instance.new("Frame", settingsScroll)
    bar.Size = UDim2.new(1, 0, 0, 1)
    bar.LayoutOrder = order + 0.5
    bar.BackgroundColor3 = C.STROKE
    bar.BackgroundTransparency = 0.6
    bar.BorderSizePixel = 0
end

local function toggleRow(text, key, order)
    local row = Instance.new("TextButton", settingsScroll)
    row.Size = UDim2.new(1, 0, 0, 36)
    row.LayoutOrder = order
    row.AutoButtonColor = false
    row.BackgroundColor3 = C.SURF
    row.BorderSizePixel = 0
    row.Text = ""
    corner(row, 9)
    stroke(row, C.STROKE, 1, 0.6)

    local lbl = Instance.new("TextLabel", row)
    lbl.Size = UDim2.new(1, -64, 1, 0)
    lbl.Position = UDim2.fromOffset(14, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextSize = 12
    lbl.TextColor3 = C.TEXT
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 5

    local togBg = Instance.new("Frame", row)
    togBg.Size = UDim2.fromOffset(42, 22)
    togBg.Position = UDim2.new(1, -52, 0.5, -11)
    togBg.BackgroundColor3 = state[key] and C.GREEN1 or C.SURF2
    togBg.ZIndex = 5
    corner(togBg, 11)

    local togDot = Instance.new("Frame", togBg)
    togDot.Size = UDim2.fromOffset(16, 16)
    togDot.Position = state[key] and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
    togDot.BackgroundColor3 = state[key] and C.GREEN_STROKE or C.OFF_TEXT
    togDot.ZIndex = 6
    corner(togDot, 8)

    row.MouseButton1Click:Connect(function()
        state[key] = not state[key]
        tween(togBg, 0.12, { BackgroundColor3 = state[key] and C.GREEN1 or C.SURF2 })
        tween(togDot, 0.15, {
            Position = state[key] and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
            BackgroundColor3 = state[key] and C.GREEN_STROKE or C.OFF_TEXT,
        })
        saveConfig()
    end)
end

sectionHeader("ALERTS", 1)
toggleRow("Alert sound on priority", "alertSound", 2)
sectionHeader("DISPLAY", 10)
toggleRow("Show player avatars", "showAvatars", 11)
toggleRow("Beam to trader's base", "beamToBase", 12)
sectionHeader("HOPPING", 20)
toggleRow("Auto-hop until priority", "autoHop", 21)

-- Hop tier selection
local hopRow = Instance.new("Frame", settingsScroll)
hopRow.Size = UDim2.new(1, 0, 0, 30)
hopRow.LayoutOrder = 22
hopRow.BackgroundTransparency = 1

local hrLayout = Instance.new("UIListLayout", hopRow)
hrLayout.FillDirection = Enum.FillDirection.Horizontal
hrLayout.Padding = UDim.new(0, 6)
hrLayout.SortOrder = Enum.SortOrder.LayoutOrder

local hopTiers = { "Normal", "Pro", "OG" }
local hopBtns = {}

for i, tier in ipairs(hopTiers) do
    local b = Instance.new("TextButton", hopRow)
    b.Size = UDim2.new(0.333, -4, 1, 0)
    b.LayoutOrder = i
    b.BackgroundColor3 = state.hopTier == tier and C.ACCENT2 or C.SURF2
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Text = tier
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextColor3 = state.hopTier == tier and C.TEXT or C.OFF_TEXT
    corner(b, 8)

    b.MouseButton1Click:Connect(function()
        state.hopTier = tier
        saveConfig()
        for k, v in pairs(hopBtns) do
            tween(v, 0.1, { BackgroundColor3 = k == tier and C.ACCENT2 or C.SURF2 })
            v.TextColor3 = k == tier and C.TEXT or C.OFF_TEXT
        end
    end)

    hopBtns[tier] = b
end

-- Hop button
local hopNowBtn = Instance.new("TextButton", settingsScroll)
hopNowBtn.Size = UDim2.new(1, 0, 0, 34)
hopNowBtn.LayoutOrder = 25
hopNowBtn.BackgroundColor3 = C.ACCENT
hopNowBtn.BorderSizePixel = 0
hopNowBtn.AutoButtonColor = false
hopNowBtn.Text = "HOP NOW"
hopNowBtn.Font = Enum.Font.GothamBold
hopNowBtn.TextSize = 12
hopNowBtn.TextColor3 = C.TEXT
corner(hopNowBtn, 9)

local function doHop(tier)
    toast("HOP", "Hopping to " .. tier .. " server...")

    -- Markeer huidige server
    state.hoppedServers[tostring(game.JobId)] = os.time()
    saveHops()

    task.spawn(function()
        local ok, err = pcall(function()
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end)

        if not ok then
            toast("HOP FAILED", tostring(err):sub(1, 50))
        end
    end)
end

hopNowBtn.MouseButton1Click:Connect(function()
    doHop(state.hopTier)
end)

-- Priority brainrots list
sectionHeader("PRIORITY BRAINROTS", 30)

local priorityInput = Instance.new("TextBox", settingsScroll)
priorityInput.Size = UDim2.new(1, 0, 0, 34)
priorityInput.LayoutOrder = 31
priorityInput.BackgroundColor3 = C.SURF
priorityInput.BorderSizePixel = 0
priorityInput.Text = ""
priorityInput.PlaceholderText = "search brainrot to add..."
priorityInput.PlaceholderColor3 = C.OFF_TEXT
priorityInput.Font = Enum.Font.GothamMedium
priorityInput.TextSize = 11
priorityInput.TextColor3 = C.TEXT
priorityInput.TextXAlignment = Enum.TextXAlignment.Left
priorityInput.ClearTextOnFocus = false
corner(priorityInput, 9)
stroke(priorityInput, C.STROKE, 1, 0.5)

local piPad2 = Instance.new("UIPadding", priorityInput)
piPad2.PaddingLeft = UDim.new(0, 12)

-- Suggestions list
local suggestionFrame = Instance.new("Frame", settingsScroll)
suggestionFrame.Size = UDim2.new(1, 0, 0, 0)
suggestionFrame.LayoutOrder = 32
suggestionFrame.BackgroundTransparency = 1
suggestionFrame.AutomaticSize = Enum.AutomaticSize.Y

local sugLayout = Instance.new("UIListLayout", suggestionFrame)
sugLayout.Padding = UDim.new(0, 4)
sugLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Current list header + list
local listHeader = Instance.new("TextLabel", settingsScroll)
listHeader.Size = UDim2.new(1, 0, 0, 16)
listHeader.LayoutOrder = 33
listHeader.BackgroundTransparency = 1
listHeader.Text = "YOUR LIST"
listHeader.Font = Enum.Font.GothamBold
listHeader.TextSize = 10
listHeader.TextColor3 = C.OFF_TEXT
listHeader.TextXAlignment = Enum.TextXAlignment.Left

local listFrame = Instance.new("Frame", settingsScroll)
listFrame.Size = UDim2.new(1, 0, 0, 0)
listFrame.LayoutOrder = 34
listFrame.BackgroundTransparency = 1
listFrame.AutomaticSize = Enum.AutomaticSize.Y

local listLayout = Instance.new("UIListLayout", listFrame)
listLayout.Padding = UDim.new(0, 4)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function isInPriorityList(name)
    for _, v in ipairs(state.priorityList) do
        if v == name then return true end
    end
    return false
end

local refreshPriorityList
refreshPriorityList = function()
    listHeader.Text = "YOUR LIST  (" .. #state.priorityList .. ")"

    for _, child in ipairs(listFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    for i, name in ipairs(state.priorityList) do
        local row = Instance.new("Frame", listFrame)
        row.Size = UDim2.new(1, 0, 0, 30)
        row.BackgroundColor3 = C.SURF2
        row.BorderSizePixel = 0
        row.LayoutOrder = i
        corner(row, 8)
        stroke(row, C.STROKE, 1, 0.7)

        local lbl = Instance.new("TextLabel", row)
        lbl.Size = UDim2.new(1, -30, 1, 0)
        lbl.Position = UDim2.fromOffset(8, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = name
        lbl.Font = Enum.Font.GothamMedium
        lbl.TextSize = 11
        lbl.TextColor3 = C.TEXT
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.TextTruncate = Enum.TextTruncate.AtEnd
        lbl.ZIndex = 5

        local xBtn = Instance.new("TextButton", row)
        xBtn.Size = UDim2.fromOffset(22, 22)
        xBtn.Position = UDim2.new(1, -25, 0.5, -11)
        xBtn.BackgroundColor3 = C.ACCENT2
        xBtn.BorderSizePixel = 0
        xBtn.AutoButtonColor = false
        xBtn.Text = "x"
        xBtn.Font = Enum.Font.GothamBold
        xBtn.TextSize = 12
        xBtn.TextColor3 = C.TEXT
        xBtn.ZIndex = 5
        corner(xBtn, 6)

        xBtn.MouseButton1Click:Connect(function()
            table.remove(state.priorityList, i)
            saveConfig()
            refreshPriorityList()
        end)
    end
end

local refreshSuggestions = function()
    for _, child in ipairs(suggestionFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    local search = string.lower(priorityInput.Text):gsub("^%s+", ""):gsub("%s+$", "")
    if search == "" then return end

    local shown = 0
    for name, info in pairs(animals) do
        if type(info) == "table" and info.Rarity and not isInPriorityList(name) then
            if string.find(string.lower(name), search, 1, true) then
                shown += 1

                local btn = Instance.new("TextButton", suggestionFrame)
                btn.Size = UDim2.new(1, 0, 0, 28)
                btn.LayoutOrder = shown
                btn.BackgroundColor3 = C.SURF
                btn.BorderSizePixel = 0
                btn.AutoButtonColor = false
                btn.Text = "+ " .. name .. "  (" .. tostring(info.Rarity) .. ")"
                btn.Font = Enum.Font.GothamMedium
                btn.TextSize = 11
                btn.TextColor3 = C.TEXT
                btn.TextXAlignment = Enum.TextXAlignment.Left
                corner(btn, 6)

                local p = Instance.new("UIPadding", btn)
                p.PaddingLeft = UDim.new(0, 8)

                btn.MouseButton1Click:Connect(function()
                    table.insert(state.priorityList, name)
                    saveConfig()
                    priorityInput.Text = ""
                    refreshSuggestions()
                    refreshPriorityList()
                end)

                if shown >= 8 then break end
            end
        end
    end
end

priorityInput:GetPropertyChangedSignal("Text"):Connect(refreshSuggestions)

refreshPriorityList()

-- ============================================================
-- ALERT SOUND
-- ============================================================
local function playAlert()
    if not state.alertSound then return end
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = "rbxassetid://6518811702"
        s.Volume = 0.5
        s.Parent = hui
        s:Play()
        game:GetService("Debris"):AddItem(s, 4)
    end)
end

-- ============================================================
-- AUTO-HOP CHECKER
-- ============================================================
task.spawn(function()
    task.wait(4)
    while screenGui.Parent do
        pcall(function()
            if state.autoHop and #state.priorityList > 0 then
                -- Check alle plots voor priority brainrots
                local found = false
                local foundOwner = nil
                local plots = workspace:FindFirstChild("Plots")

                if plots and Synchronizer then
                    for _, plot in ipairs(plots:GetChildren()) do
                        local ok, data = pcall(function()
                            return Synchronizer:GetTableFromChannel(plot.Name)
                        end)

                        if ok and type(data) == "table" and type(data.AnimalList) == "table" then
                            for _, animal in ipairs(data.AnimalList) do
                                if type(animal) == "table" and animal.Index and animal.Index ~= "Empty" then
                                    if isInPriorityList(animal.Index) then
                                        local owner = data.Owner
                                        local ownerName = typeof(owner) == "Instance" and owner.Name or tostring(owner)

                                        if ownerName ~= LocalPlayer.Name then
                                            found = true
                                            foundOwner = ownerName
                                            break
                                        end
                                    end
                                end
                            end
                        end

                        if found then break end
                    end
                end

                if found then
                    state.autoHop = false
                    saveConfig()
                    playAlert()
                    toast("PRIORITY FOUND", (foundOwner or "someone") .. " has a priority brainrot!", 4)
                else
                    toast("HOPPING", "no priority here — searching...", 2)
                    task.wait(2)
                    doHop(state.hopTier)
                    task.wait(6)
                end
            end
        end)
        task.wait(3)
    end
end)

-- ============================================================
-- CLEANUP REGISTRATION
-- ============================================================
local genv = getgenv and getgenv() or _G
genv.SlicedzConvincerCleanup = function()
    pcall(function() screenGui:Destroy() end)
    for _, name in ipairs({ "SlicedzConvincerBase", "SlcToast" }) do
        local g = hui:FindFirstChild(name)
        if g then g:Destroy() end
    end
end

-- Init
for k, v in pairs(tabs) do
    tween(v, 0.14, { BackgroundColor3 = k == "trade" and C.ACCENT2 or C.SURF })
    v.TextColor3 = k == "trade" and C.TEXT or C.OFF_TEXT
end

showToast("LOADED", "Slicedz Convincer ready", 3)
print("[Slicedz Convincer] Loaded successfully!")
print("[Slicedz Convincer] discord.gg/pubmethod")

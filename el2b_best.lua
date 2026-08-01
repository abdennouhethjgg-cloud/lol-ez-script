local cloneref = cloneref or function(object) return object end
local Players           = cloneref(game:GetService("Players"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local RunService        = cloneref(game:GetService("RunService"))
local UserInputService  = cloneref(game:GetService("UserInputService"))
local HttpService       = cloneref(game:GetService("HttpService"))
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
if getgenv and getgenv().StopAura then pcall(getgenv().StopAura) end
local CONFIG_FILE = "el2b_config.json"
local savedConfig = {
codeSniper = true,
autoSubmit = true,
submitAfter = 3,
retypeInvalid = false,
riddleSolver = false,
}
pcall(function()
if type(isfile) == "function" and type(readfile) == "function" and isfile(CONFIG_FILE) then
local decoded = HttpService:JSONDecode(readfile(CONFIG_FILE))
if type(decoded) == "table" then
for k, v in pairs(decoded) do
if savedConfig[k] ~= nil and type(v) == type(savedConfig[k]) then
savedConfig[k] = v
end
end
end
end
end)
local function saveConfig()
if type(writefile) ~= "function" then return end
pcall(function() writefile(CONFIG_FILE, HttpService:JSONEncode(savedConfig)) end)
end
local getupvalues = (type(debug) == "table" and debug.getupvalues) or function() return {} end
local setupvalue  = (type(debug) == "table" and debug.setupvalue) or function() end
local getconns    = getconnections or (type(debug) == "table" and debug.getconnections) or nil
local firesignal  = firesignal or nil
local fireclick   = fireclick or nil
local _enabled              = savedConfig.codeSniper
local _seen                 = {}
local _focused              = nil
local _lastBox              = nil
local _autoAccept           = savedConfig.autoSubmit
local _submitAfter          = savedConfig.submitAfter
local _capturedParts        = {}
local _lastWatchedBox       = nil
local _boxTextConn          = nil
local _boxAncestryConn      = nil
local _boxVisibilityConns   = {}
local _retypeInvalid        = savedConfig.retypeInvalid
local _riddleSolver         = savedConfig.riddleSolver
local _lastNonBlankBoxText  = ""
local _pendingRejectedText  = nil
local _pendingRejectedBox   = nil
local _pendingRejectedUntil = 0
local _pendingRejectedToken = 0
local ACE_CASE_MODE         = "EXACT"
local ACE_WORD_COUNT        = 1
local setStatus, flashCode, appendToBox
local rememberPendingSubmission, clearPendingSubmission, handleRedemptionFeedback
local clearAceCapture
local _lastStatusMsg = nil
local CONSOLE_COLORS = {
Cyan = "rgb(0,255,255)",
Dim = "rgb(100,120,140)",
Red = "rgb(255,50,50)",
Green = "rgb(0,255,100)",
Amber = "rgb(255,191,0)"
}
local featureStates = {}
local Console, ConsoleOutput, updateConsoleCanvas
local function isOurGui(instance)
local p = instance
for _ = 1, 10 do
if not p then break end
if p.Name == "EL2B" or p.Name == "SourcesHubRedeemerGui" then return true end
p = p.Parent
end
return false
end
local function isVisibleChain(inst)
local current = inst
while current do
if current:IsA("GuiObject") and not current.Visible then return false end
if current:IsA("ScreenGui") then return current.Enabled end
current = current.Parent
end
return true
end
local function findAllTextBoxes(pg)
local boxes = {}
for _, gui in ipairs(pg:GetChildren()) do
if gui:IsA("ScreenGui") and gui.Enabled and not isOurGui(gui) then
for _, d in ipairs(gui:GetDescendants()) do
if d:IsA("TextBox") and not isOurGui(d) then
boxes[#boxes+1] = d
end
end
end
end
return boxes
end
local function findCodeButtons(pg)
local btns = {}
for _, gui in ipairs(pg:GetChildren()) do
if gui:IsA("ScreenGui") and gui.Enabled and not isOurGui(gui) then
for _, d in ipairs(gui:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("ImageButton")) and not isOurGui(d) then
local n  = d.Name:lower()
local pn = (d.Parent and d.Parent.Name or ""):lower()
if (n:find("code") or n:find("redeem") or pn:find("code") or pn:find("redeem"))
and isVisibleChain(d) then
btns[#btns+1] = d
end
end
end
end
end
return btns
end
local function clickButton(btn)
if not btn then return false end
local methods = {}
methods[#methods+1] = function() btn.MouseButton1Click:Fire() end
methods[#methods+1] = function() btn.Activated:Fire() end
if type(firesignal) == "function" then
methods[#methods+1] = function() firesignal(btn.MouseButton1Click) end
methods[#methods+1] = function() firesignal(btn.Activated) end
end
if type(getconns) == "function" then
methods[#methods+1] = function()
local ok, cs = pcall(getconns, btn.MouseButton1Click)
if ok and type(cs) == "table" then
for _, c in ipairs(cs) do pcall(function() c:Fire() end) end
end
local ok2, cs2 = pcall(getconns, btn.Activated)
if ok2 and type(cs2) == "table" then
for _, c in ipairs(cs2) do pcall(function() c:Fire() end) end
end
end
end
if type(fireclick) == "function" then
methods[#methods+1] = function() fireclick(btn) end
end
local anyOk = false
for _, fn in ipairs(methods) do
anyOk = anyOk or pcall(fn)
end
return anyOk
end
local function fireBoxFocusLost(box)
if not box then return false end
local anyFired = false
if type(firesignal) == "function" then
anyFired = pcall(firesignal, box.FocusLost, true) or anyFired
end
if type(getconns) == "function" then
local ok, cs = pcall(getconns, box.FocusLost)
if ok and type(cs) == "table" then
for _, c in ipairs(cs) do
local fn
pcall(function() fn = c.Function end)
if fn and type(getupvalues) == "function" and type(setupvalue) == "function" then
local uOk, ups = pcall(getupvalues, fn)
if uOk and type(ups) == "table" then
for i, v in pairs(ups) do
if type(v) == "boolean" and v == true then
pcall(setupvalue, fn, i, false)
end
end
end
end
anyFired = pcall(function()
if c.Enabled ~= false then c:Fire(true) end
end) or anyFired
end
end
end
return anyFired
end
local function typeAndSubmitCode(code)
local pg = playerGui or player:FindFirstChildOfClass("PlayerGui")
if not pg then return false, "no PlayerGui" end
local codesGui = pg:FindFirstChild("Codes")
if codesGui then
if codesGui:IsA("ScreenGui") then codesGui.Enabled = true end
local codesFrame = codesGui:FindFirstChild("Codes") or codesGui
if codesFrame then
if codesFrame:IsA("GuiObject") then codesFrame.Visible = true end
local cur = codesFrame
while cur and cur ~= codesGui do
if cur:IsA("GuiObject") then cur.Visible = true end
cur = cur.Parent
end
local box = nil
for _, d in ipairs(codesFrame:GetDescendants()) do
if d:IsA("TextBox") and not isOurGui(d) then box = d; break end
end
local submitBtn = nil
for _, d in ipairs(codesFrame:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("ImageButton")) and not isOurGui(d) then
local n = d.Name:lower()
local txt = ""
pcall(function() txt = d.Text:lower() end)
if n:find("submit") or txt:find("submit") or n:find("redeem") or txt:find("redeem") or
n:find("claim") or txt:find("confirm") or n:find("enter") then
submitBtn = d
break
end
end
end
if not submitBtn then
for _, d in ipairs(codesFrame:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("ImageButton")) and not isOurGui(d) then
local n = d.Name:lower()
if not n:find("close") and not n:find("x") and not n:find("toggle") then
submitBtn = d
break
end
end
end
end
if box then
pcall(function() box.Text = code end)
task.wait(0.05)
if submitBtn then clickButton(submitBtn) end
fireBoxFocusLost(box)
return true, "submitted via PlayerGui.Codes"
end
end
end
local btns = findCodeButtons(pg)
for _, btn in ipairs(btns) do
clickButton(btn)
task.wait(0.05)
end
task.wait(0.2)
local box = nil
local deadline = tick() + 2
while tick() < deadline do
local allBoxes = findAllTextBoxes(pg)
for _, d in ipairs(allBoxes) do
if isVisibleChain(d) then
local n  = d.Name:lower()
local pn = (d.Parent and d.Parent.Name or ""):lower()
if n:find("code") or pn:find("code") or n:find("redeem") or pn:find("redeem") or
n:find("input") or pn:find("textbox") or n:find("enter") then
box = d
break
end
end
end
if not box then
for _, d in ipairs(allBoxes) do
if isVisibleChain(d) then box = d; break end
end
end
if box then break end
task.wait(0.1)
end
if not box then return false, "no codebox visible" end
pcall(function() box.Text = code end)
task.wait(0.05)
local redeemBtn = nil
local searchNames = {"submit","redeem","claim","confirm","enter","send","apply","ok","use","go","check"}
local p = box.Parent
for _ = 1, 8 do
if not p then break end
for _, d in ipairs(p:GetDescendants()) do
if (d:IsA("TextButton") or d:IsA("ImageButton")) and not isOurGui(d) and d ~= box then
local n = d.Name:lower()
local txt = ""
pcall(function() txt = d.Text:lower() end)
for _, sn in ipairs(searchNames) do
if n:find(sn) or txt:find(sn) then
if isVisibleChain(d) then
redeemBtn = d
break
end
end
end
if redeemBtn then break end
end
end
if redeemBtn then break end
p = p.Parent
end
if redeemBtn then clickButton(redeemBtn) end
fireBoxFocusLost(box)
return true, "submitted via dynamic search"
end
local function aceCodeBox()
local pg = playerGui
local allBoxes = findAllTextBoxes(pg)
for _, box in ipairs(allBoxes) do
if isVisibleChain(box) then return box end
end
return nil
end
local COLORS = {
Window = Color3.fromRGB(8, 8, 20),
Row = Color3.fromRGB(15, 15, 30),
Control = Color3.fromRGB(30, 30, 50),
Log = Color3.fromRGB(10, 10, 25),
Border = Color3.fromRGB(0, 255, 255),
White = Color3.fromRGB(180, 255, 255),
Text = Color3.fromRGB(200, 180, 255),
Dim = Color3.fromRGB(100, 120, 140),
Accent = Color3.fromRGB(0, 255, 255),
Green = Color3.fromRGB(0, 255, 100),
Red = Color3.fromRGB(255, 50, 50),
Cyan = Color3.fromRGB(0, 255, 255),
Violet = Color3.fromRGB(180, 0, 255),
Pink = Color3.fromRGB(255, 0, 200),
}
local function addCorner(parent, radius)
local value = Instance.new("UICorner")
value.CornerRadius = UDim.new(0, radius)
value.Parent = parent
return value
end
local function addStroke(parent, color, thickness, transparency)
local value = Instance.new("UIStroke")
value.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
value.Color = color
value.Thickness = thickness or 1
value.Transparency = transparency or 0
value.Parent = parent
return value
end
local function makeLabel(parent, name, text, size, position, textSize, color, font)
local label = Instance.new("TextLabel")
label.Name = name
label.Size = size
label.Position = position
label.BackgroundTransparency = 1
label.Text = text
label.TextSize = textSize
label.TextColor3 = color
label.Font = font or Enum.Font.GothamMedium
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Center
label.Parent = parent
return label
end
local function scrollConsoleToBottom()
if Console then
Console.CanvasPosition = Vector2.new(0, math.max(0, Console.CanvasSize.Y.Offset - Console.AbsoluteSize.Y))
end
end
local function appendConsoleStatus(name, activated)
if not ConsoleOutput then return end
local state = activated and "ON" or "OFF"
local stateColor = activated and CONSOLE_COLORS.Green or CONSOLE_COLORS.Red
local line = '<font color="' .. CONSOLE_COLORS.Dim .. '">[setting]</font> '
.. '<font color="' .. CONSOLE_COLORS.Amber .. '">' .. name .. "</font> "
.. '<font color="' .. CONSOLE_COLORS.Dim .. '">-&gt;</font> '
.. '<font color="' .. stateColor .. '">' .. state .. "</font>"
if ConsoleOutput.Text == "" then ConsoleOutput.Text = line
else ConsoleOutput.Text = ConsoleOutput.Text .. "\n\n" .. line end
scrollConsoleToBottom()
end
pcall(function()
for _, name in ipairs({"EL2B", "ACESniperUI", "ACECodeSniperUI", "AutoTypeCodesUI", "ACEPaste"}) do
local previous = game.CoreGui:FindFirstChild(name)
if previous then previous:Destroy() end
end
end)
for _, name in ipairs({"EL2B", "ACESniperUI", "ACECodeSniperUI", "AutoTypeCodesUI", "ACEPaste"}) do
local previous = playerGui:FindFirstChild(name)
if previous then previous:Destroy() end
end
local GUI = Instance.new("ScreenGui")
GUI.Name = "EL2B"
GUI.ResetOnSpawn = false
GUI.IgnoreGuiInset = true
GUI.DisplayOrder = 999
if not pcall(function() GUI.Parent = game.CoreGui end) then GUI.Parent = playerGui end
local Window = Instance.new("Frame")
Window.Name = "Window"
Window.Size = UDim2.fromOffset(310, 370)
Window.AnchorPoint = Vector2.new(1, 0)
Window.Position = UDim2.new(1, -8, 0, 8)
Window.BackgroundColor3 = COLORS.Window
Window.BorderSizePixel = 0
Window.ClipsDescendants = true
Window.Parent = GUI
addCorner(Window, 14)
addStroke(Window, COLORS.Border, 1.5, 0.3)
local InterfaceScale = Instance.new("UIScale")
InterfaceScale.Name = "InterfaceScale"
InterfaceScale.Scale = 1
InterfaceScale.Parent = Window
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 65)
Header.BackgroundTransparency = 1
Header.Parent = Window
local BrandMark = Instance.new("Frame")
BrandMark.Name = "BrandMark"
BrandMark.Size = UDim2.fromOffset(30, 30)
BrandMark.Position = UDim2.fromOffset(17, 15)
BrandMark.BackgroundColor3 = COLORS.Window
BrandMark.BackgroundTransparency = 1
BrandMark.BorderSizePixel = 0
BrandMark.ClipsDescendants = true
BrandMark.Parent = Header
addCorner(BrandMark, 15)
local BrandImage = Instance.new("ImageLabel")
BrandImage.Name = "Logo"
BrandImage.Size = UDim2.fromScale(1, 1)
BrandImage.BackgroundTransparency = 1
BrandImage.Image = "rbxassetid://71891923282375"
BrandImage.ScaleType = Enum.ScaleType.Fit
BrandImage.Parent = BrandMark
addCorner(BrandImage, 15)
makeLabel(Header, "Title", "EL2B", UDim2.fromOffset(180, 25), UDim2.fromOffset(56, 17), 15, COLORS.White, Enum.Font.GothamBold)
local AutoWriteButton = Instance.new("TextButton")
AutoWriteButton.Name = "AutoWrite"
AutoWriteButton.Size = UDim2.fromOffset(47, 24)
AutoWriteButton.Position = UDim2.new(1, -64, 0, 18)
AutoWriteButton.BackgroundColor3 = COLORS.Accent
AutoWriteButton.BorderSizePixel = 0
AutoWriteButton.AutoButtonColor = false
AutoWriteButton.Active = true
AutoWriteButton.Text = ""
AutoWriteButton.ZIndex = 5
AutoWriteButton.Parent = Header
addCorner(AutoWriteButton, 12)
addStroke(AutoWriteButton, COLORS.Cyan, 1, 0.2)
local AutoWriteKnob = Instance.new("Frame")
AutoWriteKnob.Name = "Knob"
AutoWriteKnob.Size = UDim2.fromOffset(20, 20)
AutoWriteKnob.Position = UDim2.new(1, -22, 0.5, -10)
AutoWriteKnob.BackgroundColor3 = COLORS.Window
AutoWriteKnob.BorderSizePixel = 0
AutoWriteKnob.ZIndex = 6
AutoWriteKnob.Parent = AutoWriteButton
addCorner(AutoWriteKnob, 10)
local autoWriteEnabled = _enabled
AutoWriteButton.BackgroundColor3 = autoWriteEnabled and COLORS.Accent or COLORS.Control
AutoWriteKnob.BackgroundColor3 = autoWriteEnabled and COLORS.Window or COLORS.White
AutoWriteKnob.Position = autoWriteEnabled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
local lastToggleTime = 0
local function toggleAutoWrite()
if tick() - lastToggleTime < 0.15 then return end
lastToggleTime = tick()
autoWriteEnabled = not autoWriteEnabled
_enabled = autoWriteEnabled
if not autoWriteEnabled and clearAceCapture then clearAceCapture() end
savedConfig.codeSniper = autoWriteEnabled
saveConfig()
_lastStatusMsg = nil
AutoWriteButton.BackgroundColor3 = autoWriteEnabled and COLORS.Accent or COLORS.Control
AutoWriteKnob.BackgroundColor3 = autoWriteEnabled and COLORS.Window or COLORS.White
AutoWriteKnob.Position = autoWriteEnabled and UDim2.new(1, -22, 0.5, -10) or UDim2.new(0, 2, 0.5, -10)
if ConsoleOutput then
if autoWriteEnabled then
ConsoleOutput.Text = '<font color="' .. CONSOLE_COLORS.Cyan .. '">&gt;</font> <font color="' .. CONSOLE_COLORS.Dim .. '">scanning...</font>'
for _, featureName in ipairs({"Auto submit", "Riddle solver", "Retype invalid"}) do
if featureStates[featureName] then appendConsoleStatus(featureName, true) end
end
else
ConsoleOutput.Text = '<font color="' .. CONSOLE_COLORS.Dim .. '">status:</font> <font color="' .. CONSOLE_COLORS.Red .. '">OFF</font>\n<font color="' .. CONSOLE_COLORS.Dim .. '">paused</font>'
end
scrollConsoleToBottom()
end
end
AutoWriteButton.Activated:Connect(toggleAutoWrite)
local HeaderAccent = Instance.new("Frame")
HeaderAccent.Name = "TitleDivider"
HeaderAccent.Size = UDim2.new(1, -34, 0, 1)
HeaderAccent.Position = UDim2.fromOffset(17, 54)
HeaderAccent.BackgroundColor3 = COLORS.Border
HeaderAccent.BackgroundTransparency = 0.4
HeaderAccent.BorderSizePixel = 0
HeaderAccent.Parent = Header
local Settings = Instance.new("Frame")
Settings.Name = "Settings"
Settings.Size = UDim2.new(1, 0, 0, 154)
Settings.Position = UDim2.fromOffset(0, 65)
Settings.BackgroundTransparency = 1
Settings.ZIndex = 3
Settings.Parent = Window
local function makeCard(name, position, size)
local card = Instance.new("Frame")
card.Name = name
card.Position = position
card.Size = size
card.BackgroundColor3 = COLORS.Row
card.BackgroundTransparency = 0.5
card.BorderSizePixel = 0
card.Parent = Settings
addCorner(card, 9)
addStroke(card, COLORS.Border, 1, 0.5)
return card
end
local function makeStateButton(parent, enabled, consoleName, onToggle)
parent.Active = true
featureStates[consoleName] = enabled
local button = Instance.new("TextButton")
button.Name = "State"
button.Size = UDim2.fromOffset(42, 20)
button.Position = UDim2.new(1, -50, 0.5, -10)
button.BackgroundColor3 = enabled and COLORS.Accent or COLORS.Control
button.BorderSizePixel = 0
button.AutoButtonColor = false
button.Active = true
button.Text = enabled and "ON" or "OFF"
button.TextSize = 8
button.TextColor3 = enabled and COLORS.Window or COLORS.Dim
button.Font = Enum.Font.GothamBold
button.ZIndex = 5
button.Parent = parent
addCorner(button, 6)
addStroke(button, COLORS.Border, 1, enabled and 0.2 or 0.6)
local state = enabled
local lastSubToggle = 0
local function toggleState()
if tick() - lastSubToggle < 0.15 then return end
lastSubToggle = tick()
state = not state
featureStates[consoleName] = state
button.Text = state and "ON" or "OFF"
button.BackgroundColor3 = state and COLORS.Accent or COLORS.Control
button.TextColor3 = state and COLORS.Window or COLORS.Dim
if autoWriteEnabled then appendConsoleStatus(consoleName, state) end
if onToggle then onToggle(state) end
end
button.Activated:Connect(toggleState)
return button
end
local AutoCard = makeCard("AutoSubmit", UDim2.fromOffset(17, 0), UDim2.fromOffset(135, 50))
makeLabel(AutoCard, "Title", "Auto submit", UDim2.new(1, -58, 1, 0), UDim2.fromOffset(12, 0), 11, COLORS.White, Enum.Font.GothamMedium)
makeStateButton(AutoCard, _autoAccept, "Auto submit", function(state)
_autoAccept = state
savedConfig.autoSubmit = state
saveConfig()
end)
local AICard = makeCard("AIRiddles", UDim2.fromOffset(158, 0), UDim2.fromOffset(135, 50))
makeLabel(AICard, "Title", "Riddle solver", UDim2.new(1, -58, 1, 0), UDim2.fromOffset(12, 0), 11, COLORS.White, Enum.Font.GothamMedium)
makeStateButton(AICard, _riddleSolver, "Riddle solver", function(state)
_riddleSolver = state
savedConfig.riddleSolver = state
saveConfig()
end)
local DelayCard = makeCard("SubmitAfter", UDim2.fromOffset(17, 57), UDim2.fromOffset(276, 43))
makeLabel(DelayCard, "Title", "Submit after msgs", UDim2.fromOffset(145, 43), UDim2.fromOffset(12, 0), 11, COLORS.White, Enum.Font.GothamMedium)
local CounterShell = Instance.new("Frame")
CounterShell.Name = "Counter"
CounterShell.Size = UDim2.fromOffset(96, 31)
CounterShell.Position = UDim2.new(1, -105, 0.5, -15)
CounterShell.BackgroundColor3 = COLORS.Window
CounterShell.BackgroundTransparency = 0.3
CounterShell.BorderSizePixel = 0
CounterShell.Parent = DelayCard
addCorner(CounterShell, 7)
addStroke(CounterShell, COLORS.Border, 1, 0.3)
local Minus = Instance.new("TextButton")
Minus.Name = "Minus"
Minus.Size = UDim2.fromOffset(25, 25)
Minus.Position = UDim2.fromOffset(3, 3)
Minus.BackgroundColor3 = COLORS.Control
Minus.BorderSizePixel = 0
Minus.AutoButtonColor = false
Minus.Active = true
Minus.Text = "-"
Minus.TextSize = 16
Minus.TextColor3 = COLORS.Text
Minus.Font = Enum.Font.GothamBold
Minus.Parent = CounterShell
addCorner(Minus, 5)
local Count = makeLabel(CounterShell, "Count", tostring(_submitAfter), UDim2.fromOffset(28, 25), UDim2.fromOffset(34, 3), 17, COLORS.White, Enum.Font.GothamBold)
Count.TextXAlignment = Enum.TextXAlignment.Center
local Plus = Instance.new("TextButton")
Plus.Name = "Plus"
Plus.Size = UDim2.fromOffset(25, 25)
Plus.Position = UDim2.fromOffset(68, 3)
Plus.BackgroundColor3 = COLORS.Control
Plus.BorderSizePixel = 0
Plus.AutoButtonColor = false
Plus.Active = true
Plus.Text = "+"
Plus.TextSize = 16
Plus.TextColor3 = COLORS.Text
Plus.Font = Enum.Font.GothamBold
Plus.Parent = CounterShell
addCorner(Plus, 5)
local function decr()
_submitAfter = math.max(1, _submitAfter - 1)
Count.Text = tostring(_submitAfter)
savedConfig.submitAfter = _submitAfter
if clearAceCapture then clearAceCapture() end
saveConfig()
end
local function incr()
_submitAfter = _submitAfter + 1
Count.Text = tostring(_submitAfter)
savedConfig.submitAfter = _submitAfter
if clearAceCapture then clearAceCapture() end
saveConfig()
end
Minus.Activated:Connect(decr)
Plus.Activated:Connect(incr)
local RetypeCard = makeCard("RetypeInvalid", UDim2.fromOffset(17, 103), UDim2.fromOffset(276, 38))
makeLabel(RetypeCard, "Title", "Retype invalid", UDim2.new(1, -65, 1, 0), UDim2.fromOffset(12, 0), 11, COLORS.White, Enum.Font.GothamMedium)
local RetypeState = makeStateButton(RetypeCard, _retypeInvalid, "Retype invalid", function(state)
_retypeInvalid = state
savedConfig.retypeInvalid = state
saveConfig()
end)
RetypeState.Position = UDim2.new(1, -50, 0.5, -10)
Console = Instance.new("ScrollingFrame")
Console.Name = "Console"
Console.Size = UDim2.new(1, -34, 0, 127)
Console.Position = UDim2.fromOffset(17, 216)
Console.BackgroundColor3 = COLORS.Log
Console.BackgroundTransparency = 0.6
Console.BorderSizePixel = 0
Console.ClipsDescendants = true
Console.Active = true
Console.ScrollingEnabled = true
Console.ScrollingDirection = Enum.ScrollingDirection.Y
Console.ElasticBehavior = Enum.ElasticBehavior.WhenScrollable
Console.VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar
Console.CanvasSize = UDim2.new(0, 0, 0, 0)
Console.AutomaticCanvasSize = Enum.AutomaticSize.None
Console.ScrollBarThickness = 4
Console.ScrollBarImageColor3 = COLORS.Cyan
Console.ZIndex = 3
Console.Parent = Window
addCorner(Console, 9)
addStroke(Console, COLORS.Border, 1, 0.4)
ConsoleOutput = Instance.new("TextLabel")
ConsoleOutput.Name = "ConsoleOutput"
ConsoleOutput.Size = UDim2.new(1, -18, 0, 115)
ConsoleOutput.AutomaticSize = Enum.AutomaticSize.Y
ConsoleOutput.Position = UDim2.fromOffset(9, 6)
ConsoleOutput.BackgroundTransparency = 1
ConsoleOutput.RichText = true
if autoWriteEnabled then
ConsoleOutput.Text = '<font color="' .. CONSOLE_COLORS.Cyan .. '">&gt;</font> <font color="' .. CONSOLE_COLORS.Dim .. '">scanning...</font>'
else
ConsoleOutput.Text = '<font color="' .. CONSOLE_COLORS.Dim .. '">status:</font> <font color="' .. CONSOLE_COLORS.Red .. '">OFF</font>\n<font color="' .. CONSOLE_COLORS.Dim .. '">paused</font>'
end
ConsoleOutput.TextSize = 14
ConsoleOutput.Font = Enum.Font.Code
ConsoleOutput.TextColor3 = COLORS.Dim
ConsoleOutput.TextXAlignment = Enum.TextXAlignment.Left
ConsoleOutput.TextYAlignment = Enum.TextYAlignment.Top
ConsoleOutput.TextWrapped = true
ConsoleOutput.ZIndex = 4
ConsoleOutput.Parent = Console
local CONSOLE_BOTTOM_PADDING = 30
updateConsoleCanvas = function()
if not Console or not ConsoleOutput then return end
local contentHeight = ConsoleOutput.Position.Y.Offset + ConsoleOutput.AbsoluteSize.Y + CONSOLE_BOTTOM_PADDING
Console.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end
ConsoleOutput:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateConsoleCanvas)
task.defer(updateConsoleCanvas)
local DiscordFooter = makeLabel(Window, "DiscordFooter", "discord.gg/aceduels", UDim2.fromOffset(140, 19), UDim2.new(0.5, -70, 0, 346), 10, COLORS.Border, Enum.Font.GothamBold)
DiscordFooter.TextXAlignment = Enum.TextXAlignment.Center
DiscordFooter.BackgroundColor3 = COLORS.Window
DiscordFooter.BackgroundTransparency = 1
DiscordFooter.TextStrokeColor3 = COLORS.Window
DiscordFooter.TextStrokeTransparency = 0.45
DiscordFooter.ZIndex = 3
do
local dragging = false
local activeDragInput
local dragStart
local startPosition
Header.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = input.Position
startPosition = Window.Position
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then
dragging = false
end
end)
end
end)
UserInputService.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local delta = input.Position - dragStart
Window.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
end
end)
end
setStatus = function(msg, color)
if not ConsoleOutput then return end
local timestamp = os.date("%H:%M:%S")
local line = '<font color="' .. CONSOLE_COLORS.Dim .. '">[' .. timestamp .. ']</font> '
.. '<font color="' .. string.format("rgb(%d,%d,%d)", color.R*255, color.G*255, color.B*255) .. '">' .. msg .. "</font>"
if ConsoleOutput.Text == "" then ConsoleOutput.Text = line
else ConsoleOutput.Text = ConsoleOutput.Text .. "\n" .. line end
scrollConsoleToBottom()
end
flashCode = function(code, color)
end
clearAceCapture = function()
_capturedParts = {}
end
rememberPendingSubmission = function(box, text, auto)
_pendingRejectedText = text
_pendingRejectedBox = box
_pendingRejectedUntil = os.clock() + 5
end
clearPendingSubmission = function()
_pendingRejectedText = nil
_pendingRejectedBox = nil
_pendingRejectedUntil = 0
end
local function watchBoxForBlankReset(box)
if not box then return end
if _boxTextConn then _boxTextConn:Disconnect() end
_boxTextConn = box:GetPropertyChangedSignal("Text"):Connect(function()
if box.Text ~= "" then _lastNonBlankBoxText = box.Text end
end)
end
local function restoreRejectedText(box, previousText)
if not _retypeInvalid or not previousText or previousText == "" then return false end
RunService.Heartbeat:Wait()
local repasteBox = aceCodeBox() or box
if not repasteBox or not isVisibleChain(repasteBox) then return false end
local restored = pcall(function() repasteBox.Text = previousText end)
if restored then
_lastBox = repasteBox
watchBoxForBlankReset(repasteBox)
end
return restored
end
handleRedemptionFeedback = function(text, feedbackObject)
if not _retypeInvalid or not _pendingRejectedText then return end
if os.clock() > _pendingRejectedUntil then clearPendingSubmission(); return end
if feedbackObject and feedbackObject:IsDescendantOf(GUI) then return end
local lower = tostring(text or ""):lower()
local rejected = lower:find("invalid code", 1, true)
or lower:find("code is invalid", 1, true)
or lower:find("expired", 1, true)
or lower:find("already redeemed", 1, true)
or lower:find("already used", 1, true)
or lower:find("doesn't exist", 1, true)
or lower:find("does not exist", 1, true)
or lower:find("not found", 1, true)
or lower:find("rejected", 1, true)
if not rejected then return end
local previousText = _pendingRejectedText
local previousBox = _pendingRejectedBox
local restored = restoreRejectedText(previousBox, previousText)
clearPendingSubmission()
if restored then
setStatus("Invalid - repasted: " .. previousText, COLORS.Text)
end
end
appendToBox = function(text)
if not text or text == "" then return end
local box = aceCodeBox()
_capturedParts[#_capturedParts + 1] = text
local combinedCode = table.concat(_capturedParts)
local capturedCount = #_capturedParts
if box then
_lastBox = box
watchBoxForBlankReset(box)
local boxWasFocused = UserInputService:GetFocusedTextBox() == box
box.Text = combinedCode
if boxWasFocused then
pcall(function()
local caretEnd = #combinedCode + 1
box.CursorPosition = caretEnd
box.SelectionStart = caretEnd
end)
end
else
setStatus("Captured; opening & searching UI...", COLORS.Text)
end
setStatus("Pasted " .. tostring(capturedCount) .. "/" .. tostring(_submitAfter), COLORS.Green)
if capturedCount >= _submitAfter then
_capturedParts = {}
if _autoAccept then
rememberPendingSubmission(box, combinedCode, true)
local ok, statusMsg = typeAndSubmitCode(combinedCode)
if ok then
setStatus("Redeemed: " .. combinedCode, COLORS.Green)
else
local restored = restoreRejectedText(box, combinedCode)
clearPendingSubmission()
if restored then
setStatus("Invalid - repasted: " .. combinedCode, COLORS.Text)
else
setStatus("Failed: " .. tostring(statusMsg), COLORS.Red)
end
end
end
end
end
local function watchRedemptionFeedbackObject(obj)
if not (obj:IsA("TextLabel") or obj:IsA("TextButton")) then return end
handleRedemptionFeedback(obj.Text or "", obj)
obj:GetPropertyChangedSignal("Text"):Connect(function()
handleRedemptionFeedback(obj.Text or "", obj)
end)
end
for _, obj in ipairs(playerGui:GetDescendants()) do watchRedemptionFeedbackObject(obj) end
playerGui.DescendantAdded:Connect(function(obj)
task.wait(0.04)
watchRedemptionFeedbackObject(obj)
end)
local function resolveNotifyRemote()
if _G.PhiNotifyRemote then return _G.PhiNotifyRemote end
local Net = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("Net")
if not Net then return nil end
local getinfo = debug and (debug.getinfo or debug.info)
if getgc and getinfo and getconnections then
for _, d in ipairs(Net:GetDescendants()) do
if d:IsA("RemoteEvent") then
local ok, cs = pcall(getconnections, d.OnClientEvent)
if ok then
for _, c in ipairs(cs) do
local f, fn = pcall(function() return c.Function end)
if f and type(fn) == "function" then
local i, info = pcall(getinfo, fn)
if i and tostring(info.short_src or info.source or ""):find("NotificationController", 1, true) then
return d
end
end
end
end
end
end
end
return nil
end
local function aceStripRich(text)
if type(text) ~= "string" then return tostring(text) end
return (text:gsub("<[^>]*>", ""))
end
local function aceTokenize(text)
local words = {}
for word in text:gmatch("[%w_]+") do
words[#words + 1] = word
end
return words
end
local aceCollectBuffer = {}
local function onAceAnnouncement(...)
local text = aceStripRich(tostring((...) or ""))
text = text:match("^%s*(.-)%s*$") or ""
if text == "" or text:find("%s") then return end
for _, word in ipairs(aceTokenize(text)) do
aceCollectBuffer[#aceCollectBuffer + 1] = word
end
local parts = {}
for index = 1, math.min(#aceCollectBuffer, ACE_WORD_COUNT) do
parts[index] = aceCollectBuffer[index]
end
if #aceCollectBuffer < ACE_WORD_COUNT then return end
aceCollectBuffer = {}
local captured = table.concat(parts)
if captured == "" or _seen[captured] then return end
_seen[captured] = true
task.delay(1.25, function() _seen[captured] = nil end)
appendToBox(captured)
end
local aceNotifyRemote = resolveNotifyRemote()
local aceListenConnection
if aceNotifyRemote then
if getgenv then
local previous = getgenv().ACECodeSniperNotifyConnection
if previous then pcall(function() previous:Disconnect() end) end
end
aceListenConnection = aceNotifyRemote.OnClientEvent:Connect(function(...)
if not _enabled then return end
pcall(onAceAnnouncement, ...)
end)
if getgenv then getgenv().ACECodeSniperNotifyConnection = aceListenConnection end
end
if getgenv then
getgenv().StopAura = function()
if aceListenConnection then
pcall(function() aceListenConnection:Disconnect() end)
aceListenConnection = nil
end
if getgenv().ACECodeSniperNotifyConnection then
pcall(function() getgenv().ACECodeSniperNotifyConnection:Disconnect() end)
getgenv().ACECodeSniperNotifyConnection = nil
end
if GUI then GUI:Destroy() end
end
end
print("EL2B loaded successfully!")
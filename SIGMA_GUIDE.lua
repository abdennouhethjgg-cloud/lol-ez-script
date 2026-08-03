--[[
    GIGA SIGMA USAGE GUIDE UI
    Style: Minimalist Sigma
]]

local cloneref = cloneref or function(object) return object end
local CoreGui = cloneref(game:GetService("CoreGui"))
local UserInputService = cloneref(game:GetService("UserInputService"))

-- Cleanup old UI
if CoreGui:FindFirstChild("SigmaGuideUI") then
    CoreGui.SigmaGuideUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SigmaGuideUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 160, 0.5, -150) -- Positioned to the right of the main panel
Main.Size = UDim2.new(0, 250, 0, 300)
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Main

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 255, 255)
UIStroke.Parent = Main

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "SIGMA BIBLE 📖"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

local Content = Instance.new("ScrollingFrame")
Content.Name = "Content"
Content.Parent = Main
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 10, 0, 45)
Content.Size = UDim2.new(1, -20, 1, -85)
Content.ScrollBarThickness = 2
Content.CanvasSize = UDim2.new(0, 0, 0, 800)

local GuideText = Instance.new("TextLabel")
GuideText.Name = "GuideText"
GuideText.Parent = Content
GuideText.BackgroundTransparency = 1
GuideText.Size = UDim2.new(1, 0, 1, 0)
GuideText.Font = Enum.Font.Gotham
GuideText.Text = [[
--- THE OHIO WIPE ---
1. Set Intensity to 250+
2. Toggle SIGMA NUKE ON
Result: Server lag for others, smooth for you.

--- RIZZLER COMBAT ---
1. Toggle AUTO-LAG DUEL ON
2. Auto-freezes at 20% HP
3. Enemies can't hit you!

--- FANUM TAX ---
1. Toggle DATA FLOOD
2. Steal loot while server lags
3. Turn off to finish steal.

--- TIPS ---
- Keybind (X): Lag Walk
- Right-Ctrl: Self Destruct
- Intensity 500: Server Death

--- V6 GOD MODE ---
- Auto Steal: Collects all!
- Inf Rebirth: Instant levels!
- Anti-Hit: Never die!
]]
GuideText.TextColor3 = Color3.fromRGB(200, 200, 200)
GuideText.TextSize = 12
GuideText.TextXAlignment = Enum.TextXAlignment.Left
GuideText.TextYAlignment = Enum.TextYAlignment.Top
GuideText.TextWrapped = true

local Close = Instance.new("TextButton")
Close.Name = "Close"
Close.Parent = Main
Close.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
Close.Position = UDim2.new(0.1, 0, 0.85, 0)
Close.Size = UDim2.new(0.8, 0, 0, 30)
Close.Font = Enum.Font.GothamBold
Close.Text = "CLOSE GUIDE"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.TextSize = 14

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 8)
CloseCorner.Parent = Close

Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Rainbow Stroke Effect
task.spawn(function()
    while ScreenGui.Parent do
        UIStroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        task.wait(0.1)
    end
end)

print("SIGMA GUIDE UI LOADED. 🤫🧏‍♂️")

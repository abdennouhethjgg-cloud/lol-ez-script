--[[
    Tigys Redeemer deobf / rebuild by alons9s and q3cg
    Join Aeroz Hub discord.gg/ZusW3VnQCf
    Join Lemon Hub discord.gg/RCsYd6uTQr
]]

-- TigysRedeemerUI (ScreenGui)
local TigysRedeemerUI = Instance.new("ScreenGui")
TigysRedeemerUI.Name = "TigysRedeemerUI"
TigysRedeemerUI.ResetOnSpawn = false
TigysRedeemerUI.IgnoreGuiInset = true
TigysRedeemerUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TigysRedeemerUI.ScreenInsets = Enum.ScreenInsets.DeviceSafeInsets

-- Sound (Sound)
local Sound = Instance.new("Sound")
Sound.Parent = TigysRedeemerUI

-- PastelPill (Frame)
local PastelPill = Instance.new("Frame")
PastelPill.Name = "PastelPill"
PastelPill.BackgroundColor3 = Color3.fromRGB(186, 225, 255)
PastelPill.BorderSizePixel = 0
PastelPill.Position = UDim2.new(0.5, -200, 0, -100)
PastelPill.Size = UDim2.new(0, 400, 0, 60)
PastelPill.Parent = TigysRedeemerUI

-- UICorner (UICorner)
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = PastelPill

-- UIStroke (UIStroke)
local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(220, 240, 255)
UIStroke.Thickness = 2
UIStroke.Parent = PastelPill

-- ImageLabel (ImageLabel)
local ImageLabel = Instance.new("ImageLabel")
ImageLabel.BackgroundColor3 = Color3.fromRGB(150, 200, 240)
ImageLabel.Position = UDim2.new(0, 6, 0, 6)
ImageLabel.Size = UDim2.new(0, 48, 0, 48)
ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
ImageLabel.Parent = PastelPill

-- UICorner_2 (UICorner)
local UICorner_2 = Instance.new("UICorner")
UICorner_2.CornerRadius = UDim.new(1, 0)
UICorner_2.Parent = ImageLabel

-- TextLabel (TextLabel)
local TextLabel = Instance.new("TextLabel")
TextLabel.BackgroundTransparency = 1
TextLabel.Position = UDim2.new(0, 65, 0, 10)
TextLabel.Size = UDim2.new(1, -70, 0, 20)
TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel.Text = "@Username"
TextLabel.TextColor3 = Color3.fromRGB(45, 85, 125)
TextLabel.TextSize = 15
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Parent = PastelPill

-- TextLabel_2 (TextLabel)
local TextLabel_2 = Instance.new("TextLabel")
TextLabel_2.BackgroundTransparency = 1
TextLabel_2.Position = UDim2.new(0, 65, 0, 30)
TextLabel_2.Size = UDim2.new(1, -70, 0, 20)
TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_2.Text = "Message..."
TextLabel_2.TextColor3 = Color3.fromRGB(25, 55, 85)
TextLabel_2.TextSize = 14
TextLabel_2.TextWrapped = true
TextLabel_2.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_2.TextYAlignment = Enum.TextYAlignment.Top
TextLabel_2.Parent = PastelPill

-- MainFrame (Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(233, 244, 253)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Position = UDim2.new(0.5, 238, 0.5, 8)
MainFrame.Size = UDim2.new(0, 262, 0, 350)
MainFrame.ZIndex = 2
MainFrame.Parent = TigysRedeemerUI

-- UICorner_3 (UICorner)
local UICorner_3 = Instance.new("UICorner")
UICorner_3.CornerRadius = UDim.new(0, 18)
UICorner_3.Parent = MainFrame

-- UIStroke_2 (UIStroke)
local UIStroke_2 = Instance.new("UIStroke")
UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_2.Color = Color3.fromRGB(168, 208, 236)
UIStroke_2.Thickness = 2
UIStroke_2.Parent = MainFrame

-- UIGradient (UIGradient)
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(233, 244, 253)), ColorSequenceKeypoint.new(1, Color3.fromRGB(205, 228, 247))})
UIGradient.Rotation = 80
UIGradient.Parent = MainFrame

-- Frame (Frame)
local Frame = Instance.new("Frame")
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(1, 0, 0.40000000596046448, 0)
Frame.ZIndex = 2
Frame.Parent = MainFrame

-- UIGradient_2 (UIGradient)
local UIGradient_2 = Instance.new("UIGradient")
UIGradient_2.Rotation = 90
UIGradient_2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.75, 0), NumberSequenceKeypoint.new(1, 1, 0)})
UIGradient_2.Parent = Frame

-- UIScale (UIScale)
local UIScale = Instance.new("UIScale")
UIScale.Parent = MainFrame

-- TopBar (Frame)
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.BackgroundTransparency = 1
TopBar.Size = UDim2.new(1, 0, 0, 44)
TopBar.ZIndex = 3
TopBar.Parent = MainFrame

-- Frame_2 (Frame)
local Frame_2 = Instance.new("Frame")
Frame_2.AnchorPoint = Vector2.new(0, 0.5)
Frame_2.BackgroundColor3 = Color3.fromRGB(120, 185, 232)
Frame_2.Position = UDim2.new(0, 12, 0.5, 0)
Frame_2.Size = UDim2.new(0, 26, 0, 26)
Frame_2.Parent = TopBar

-- UICorner_4 (UICorner)
local UICorner_4 = Instance.new("UICorner")
UICorner_4.CornerRadius = UDim.new(0, 9)
UICorner_4.Parent = Frame_2

-- UIStroke_3 (UIStroke)
local UIStroke_3 = Instance.new("UIStroke")
UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_3.Color = Color3.fromRGB(74, 140, 191)
UIStroke_3.Transparency = 0.30000001192092896
UIStroke_3.Parent = Frame_2

-- UIGradient_3 (UIGradient)
local UIGradient_3 = Instance.new("UIGradient")
UIGradient_3.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 216, 244)), ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 140, 191))})
UIGradient_3.Rotation = 45
UIGradient_3.Parent = Frame_2

-- TextLabel_3 (TextLabel)
local TextLabel_3 = Instance.new("TextLabel")
TextLabel_3.BackgroundTransparency = 1
TextLabel_3.Size = UDim2.new(1, 0, 1, 0)
TextLabel_3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_3.Text = "T"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextSize = 15
TextLabel_3.Parent = Frame_2

-- TextLabel_4 (TextLabel)
local TextLabel_4 = Instance.new("TextLabel")
TextLabel_4.BackgroundTransparency = 1
TextLabel_4.Position = UDim2.new(0, 46, 0, 0)
TextLabel_4.Size = UDim2.new(1, -80, 1, 0)
TextLabel_4.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_4.Text = "Tigy's Redeemer"
TextLabel_4.TextColor3 = Color3.fromRGB(30, 50, 68)
TextLabel_4.TextSize = 15
TextLabel_4.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_4.Parent = TopBar

-- TextButton (TextButton)
local TextButton = Instance.new("TextButton")
TextButton.AnchorPoint = Vector2.new(1, 0.5)
TextButton.BackgroundColor3 = Color3.fromRGB(211, 232, 248)
TextButton.Position = UDim2.new(1, -12, 0.5, 0)
TextButton.Size = UDim2.new(0, 22, 0, 22)
TextButton.AutoButtonColor = false
TextButton.Text = ""
TextButton.Parent = TopBar

-- UICorner_5 (UICorner)
local UICorner_5 = Instance.new("UICorner")
UICorner_5.CornerRadius = UDim.new(0, 7)
UICorner_5.Parent = TextButton

-- UIStroke_4 (UIStroke)
local UIStroke_4 = Instance.new("UIStroke")
UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_4.Color = Color3.fromRGB(168, 208, 236)
UIStroke_4.Parent = TextButton

-- TextLabel_5 (TextLabel)
local TextLabel_5 = Instance.new("TextLabel")
TextLabel_5.BackgroundTransparency = 1
TextLabel_5.Size = UDim2.new(1, 0, 1, 0)
TextLabel_5.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_5.Text = "x"
TextLabel_5.TextColor3 = Color3.fromRGB(96, 122, 143)
TextLabel_5.TextSize = 13
TextLabel_5.Parent = TextButton

-- Frame_3 (Frame)
local Frame_3 = Instance.new("Frame")
Frame_3.AnchorPoint = Vector2.new(0, 1)
Frame_3.BackgroundColor3 = Color3.fromRGB(168, 208, 236)
Frame_3.BorderSizePixel = 0
Frame_3.Position = UDim2.new(0, 0, 1, 0)
Frame_3.Size = UDim2.new(1, 0, 0, 1)
Frame_3.Parent = TopBar

-- TabBarOuter (Frame)
local TabBarOuter = Instance.new("Frame")
TabBarOuter.Name = "TabBarOuter"
TabBarOuter.BackgroundTransparency = 1
TabBarOuter.Position = UDim2.new(0, 12, 0, 52)
TabBarOuter.Size = UDim2.new(1, -24, 0, 32)
TabBarOuter.ZIndex = 3
TabBarOuter.Parent = MainFrame

-- TabBar (Frame)
local TabBar = Instance.new("Frame")
TabBar.Name = "TabBar"
TabBar.BackgroundColor3 = Color3.fromRGB(211, 232, 248)
TabBar.BorderSizePixel = 0
TabBar.Size = UDim2.new(1, 0, 1, 0)
TabBar.Parent = TabBarOuter

-- UICorner_6 (UICorner)
local UICorner_6 = Instance.new("UICorner")
UICorner_6.CornerRadius = UDim.new(0, 10)
UICorner_6.Parent = TabBar

-- UIStroke_5 (UIStroke)
local UIStroke_5 = Instance.new("UIStroke")
UIStroke_5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_5.Color = Color3.fromRGB(168, 208, 236)
UIStroke_5.Parent = TabBar

-- TabIndicator (Frame)
local TabIndicator = Instance.new("Frame")
TabIndicator.Name = "TabIndicator"
TabIndicator.BackgroundColor3 = Color3.fromRGB(120, 185, 232)
TabIndicator.BorderSizePixel = 0
TabIndicator.Position = UDim2.new(0, 2, 0, 2)
TabIndicator.Size = UDim2.new(0.3333333432674408, -4, 1, -4)
TabIndicator.ZIndex = 4
TabIndicator.Parent = TabBar

-- UICorner_7 (UICorner)
local UICorner_7 = Instance.new("UICorner")
UICorner_7.Parent = TabIndicator

-- UIGradient_4 (UIGradient)
local UIGradient_4 = Instance.new("UIGradient")
UIGradient_4.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 216, 244)), ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 140, 191))})
UIGradient_4.Rotation = 90
UIGradient_4.Parent = TabIndicator

-- REDEEMERTab (TextButton)
local REDEEMERTab = Instance.new("TextButton")
REDEEMERTab.Name = "REDEEMERTab"
REDEEMERTab.BackgroundTransparency = 1
REDEEMERTab.Size = UDim2.new(0.3333333432674408, 0, 1, 0)
REDEEMERTab.ZIndex = 5
REDEEMERTab.AutoButtonColor = false
REDEEMERTab.Text = ""
REDEEMERTab.Parent = TabBar

-- TextLabel_6 (TextLabel)
local TextLabel_6 = Instance.new("TextLabel")
TextLabel_6.BackgroundTransparency = 1
TextLabel_6.Size = UDim2.new(1, 0, 1, 0)
TextLabel_6.ZIndex = 6
TextLabel_6.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_6.Text = "REDEEMER"
TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_6.TextSize = 11
TextLabel_6.Parent = REDEEMERTab

-- RIDDLETab (TextButton)
local RIDDLETab = Instance.new("TextButton")
RIDDLETab.Name = "RIDDLETab"
RIDDLETab.BackgroundTransparency = 1
RIDDLETab.Position = UDim2.new(0.3333333432674408, 0, 0, 0)
RIDDLETab.Size = UDim2.new(0.3333333432674408, 0, 1, 0)
RIDDLETab.ZIndex = 5
RIDDLETab.AutoButtonColor = false
RIDDLETab.Text = ""
RIDDLETab.Parent = TabBar

-- TextLabel_7 (TextLabel)
local TextLabel_7 = Instance.new("TextLabel")
TextLabel_7.BackgroundTransparency = 1
TextLabel_7.Size = UDim2.new(1, 0, 1, 0)
TextLabel_7.ZIndex = 6
TextLabel_7.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_7.Text = "RIDDLE"
TextLabel_7.TextColor3 = Color3.fromRGB(96, 122, 143)
TextLabel_7.TextSize = 11
TextLabel_7.Parent = RIDDLETab

-- LOGSTab (TextButton)
local LOGSTab = Instance.new("TextButton")
LOGSTab.Name = "LOGSTab"
LOGSTab.BackgroundTransparency = 1
LOGSTab.Position = UDim2.new(0.66666668653488159, 0, 0, 0)
LOGSTab.Size = UDim2.new(0.3333333432674408, 0, 1, 0)
LOGSTab.ZIndex = 5
LOGSTab.AutoButtonColor = false
LOGSTab.Text = ""
LOGSTab.Parent = TabBar

-- TextLabel_8 (TextLabel)
local TextLabel_8 = Instance.new("TextLabel")
TextLabel_8.BackgroundTransparency = 1
TextLabel_8.Size = UDim2.new(1, 0, 1, 0)
TextLabel_8.ZIndex = 6
TextLabel_8.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_8.Text = "LOGS"
TextLabel_8.TextColor3 = Color3.fromRGB(96, 122, 143)
TextLabel_8.TextSize = 11
TextLabel_8.Parent = LOGSTab

-- PageContainer (Frame)
local PageContainer = Instance.new("Frame")
PageContainer.Name = "PageContainer"
PageContainer.BackgroundTransparency = 1
PageContainer.Position = UDim2.new(0, 0, 0, 92)
PageContainer.Size = UDim2.new(1, 0, 1, -100)
PageContainer.ZIndex = 3
PageContainer.Parent = MainFrame

-- LOGSPage (Frame)
local LOGSPage = Instance.new("Frame")
LOGSPage.Name = "LOGSPage"
LOGSPage.BackgroundTransparency = 1
LOGSPage.Size = UDim2.new(1, 0, 1, 0)
LOGSPage.Visible = false
LOGSPage.Parent = PageContainer

-- UIPadding (UIPadding)
local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingBottom = UDim.new(0, 12)
UIPadding.PaddingLeft = UDim.new(0, 16)
UIPadding.PaddingRight = UDim.new(0, 16)
UIPadding.PaddingTop = UDim.new(0, 10)
UIPadding.Parent = LOGSPage

-- Frame_4 (Frame)
local Frame_4 = Instance.new("Frame")
Frame_4.BackgroundColor3 = Color3.fromRGB(217, 235, 249)
Frame_4.BorderSizePixel = 0
Frame_4.Size = UDim2.new(1, 0, 1, -8)
Frame_4.Parent = LOGSPage

-- UICorner_8 (UICorner)
local UICorner_8 = Instance.new("UICorner")
UICorner_8.CornerRadius = UDim.new(0, 12)
UICorner_8.Parent = Frame_4

-- UIStroke_6 (UIStroke)
local UIStroke_6 = Instance.new("UIStroke")
UIStroke_6.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_6.Color = Color3.fromRGB(168, 208, 236)
UIStroke_6.Parent = Frame_4

-- Frame_5 (Frame)
local Frame_5 = Instance.new("Frame")
Frame_5.BackgroundColor3 = Color3.fromRGB(180, 212, 238)
Frame_5.BorderSizePixel = 0
Frame_5.Size = UDim2.new(1, 0, 0, 24)
Frame_5.Parent = Frame_4

-- UICorner_9 (UICorner)
local UICorner_9 = Instance.new("UICorner")
UICorner_9.CornerRadius = UDim.new(0, 12)
UICorner_9.Parent = Frame_5

-- Frame_6 (Frame)
local Frame_6 = Instance.new("Frame")
Frame_6.BackgroundColor3 = Color3.fromRGB(180, 212, 238)
Frame_6.BorderSizePixel = 0
Frame_6.Position = UDim2.new(0, 0, 1, -12)
Frame_6.Size = UDim2.new(1, 0, 0, 12)
Frame_6.Parent = Frame_5

-- Frame_7 (Frame)
local Frame_7 = Instance.new("Frame")
Frame_7.AnchorPoint = Vector2.new(0, 0.5)
Frame_7.BackgroundColor3 = Color3.fromRGB(255, 180, 187)
Frame_7.Position = UDim2.new(0, 8, 0.5, 0)
Frame_7.Size = UDim2.new(0, 7, 0, 7)
Frame_7.Parent = Frame_5

-- UICorner_10 (UICorner)
local UICorner_10 = Instance.new("UICorner")
UICorner_10.CornerRadius = UDim.new(0, 4)
UICorner_10.Parent = Frame_7

-- Frame_8 (Frame)
local Frame_8 = Instance.new("Frame")
Frame_8.AnchorPoint = Vector2.new(0, 0.5)
Frame_8.BackgroundColor3 = Color3.fromRGB(255, 224, 153)
Frame_8.Position = UDim2.new(0, 21, 0.5, 0)
Frame_8.Size = UDim2.new(0, 7, 0, 7)
Frame_8.Parent = Frame_5

-- UICorner_11 (UICorner)
local UICorner_11 = Instance.new("UICorner")
UICorner_11.CornerRadius = UDim.new(0, 4)
UICorner_11.Parent = Frame_8

-- Frame_9 (Frame)
local Frame_9 = Instance.new("Frame")
Frame_9.AnchorPoint = Vector2.new(0, 0.5)
Frame_9.BackgroundColor3 = Color3.fromRGB(122, 201, 166)
Frame_9.Position = UDim2.new(0, 34, 0.5, 0)
Frame_9.Size = UDim2.new(0, 7, 0, 7)
Frame_9.Parent = Frame_5

-- UICorner_12 (UICorner)
local UICorner_12 = Instance.new("UICorner")
UICorner_12.CornerRadius = UDim.new(0, 4)
UICorner_12.Parent = Frame_9

-- TextLabel_9 (TextLabel)
local TextLabel_9 = Instance.new("TextLabel")
TextLabel_9.BackgroundTransparency = 1
TextLabel_9.Size = UDim2.new(1, -10, 1, 0)
TextLabel_9.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextLabel_9.Text = "console"
TextLabel_9.TextColor3 = Color3.fromRGB(96, 122, 143)
TextLabel_9.TextSize = 10
TextLabel_9.TextXAlignment = Enum.TextXAlignment.Right
TextLabel_9.Parent = Frame_5

-- ScrollingFrame (ScrollingFrame)
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.Position = UDim2.new(0, 0, 0, 24)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -24)
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(74, 140, 191)
ScrollingFrame.ScrollBarThickness = 3
ScrollingFrame.Parent = Frame_4

-- UIPadding_2 (UIPadding)
local UIPadding_2 = Instance.new("UIPadding")
UIPadding_2.PaddingBottom = UDim.new(0, 6)
UIPadding_2.PaddingLeft = UDim.new(0, 8)
UIPadding_2.PaddingRight = UDim.new(0, 8)
UIPadding_2.PaddingTop = UDim.new(0, 6)
UIPadding_2.Parent = ScrollingFrame

-- UIListLayout (UIListLayout)
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 3)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollingFrame

-- TextLabel_10 (TextLabel)
local TextLabel_10 = Instance.new("TextLabel")
TextLabel_10.AutomaticSize = Enum.AutomaticSize.Y
TextLabel_10.BackgroundTransparency = 1
TextLabel_10.LayoutOrder = 1
TextLabel_10.Size = UDim2.new(1, 0, 0, 0)
TextLabel_10.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel_10.RichText = true
TextLabel_10.Text = "<font color=\"rgb(96,122,143)\">[15:54:52]</font> Tigy's Redeemer Loaded!"
TextLabel_10.TextColor3 = Color3.fromRGB(74, 140, 191)
TextLabel_10.TextSize = 12
TextLabel_10.TextWrapped = true
TextLabel_10.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_10.Parent = ScrollingFrame

-- TextLabel_11 (TextLabel)
local TextLabel_11 = Instance.new("TextLabel")
TextLabel_11.AutomaticSize = Enum.AutomaticSize.Y
TextLabel_11.BackgroundTransparency = 1
TextLabel_11.LayoutOrder = 2
TextLabel_11.Size = UDim2.new(1, 0, 0, 0)
TextLabel_11.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel_11.RichText = true
TextLabel_11.Text = "<font color=\"rgb(96,122,143)\">[15:54:52]</font> This Console Will Contain Sammy's Global Messages, Codes Redeemed, And More."
TextLabel_11.TextColor3 = Color3.fromRGB(96, 122, 143)
TextLabel_11.TextSize = 12
TextLabel_11.TextWrapped = true
TextLabel_11.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_11.Parent = ScrollingFrame

-- REDEEMERPage (Frame)
local REDEEMERPage = Instance.new("Frame")
REDEEMERPage.Name = "REDEEMERPage"
REDEEMERPage.BackgroundTransparency = 1
REDEEMERPage.Size = UDim2.new(1, 0, 1, 0)
REDEEMERPage.Parent = PageContainer

-- UIPadding_3 (UIPadding)
local UIPadding_3 = Instance.new("UIPadding")
UIPadding_3.PaddingLeft = UDim.new(0, 16)
UIPadding_3.PaddingRight = UDim.new(0, 16)
UIPadding_3.PaddingTop = UDim.new(0, 10)
UIPadding_3.Parent = REDEEMERPage

-- UIListLayout_2 (UIListLayout)
local UIListLayout_2 = Instance.new("UIListLayout")
UIListLayout_2.Padding = UDim.new(0, 8)
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Parent = REDEEMERPage

-- Frame_10 (Frame)
local Frame_10 = Instance.new("Frame")
Frame_10.BackgroundTransparency = 1
Frame_10.LayoutOrder = 1
Frame_10.Size = UDim2.new(1, 0, 0, 40)
Frame_10.Parent = REDEEMERPage

-- Frame_11 (Frame)
local Frame_11 = Instance.new("Frame")
Frame_11.AnchorPoint = Vector2.new(0, 0.5)
Frame_11.BackgroundColor3 = Color3.fromRGB(140, 165, 185)
Frame_11.Position = UDim2.new(0, 0, 0.5, 0)
Frame_11.Size = UDim2.new(0, 6, 0, 6)
Frame_11.Parent = Frame_10

-- UICorner_13 (UICorner)
local UICorner_13 = Instance.new("UICorner")
UICorner_13.CornerRadius = UDim.new(0, 3)
UICorner_13.Parent = Frame_11

-- TextLabel_12 (TextLabel)
local TextLabel_12 = Instance.new("TextLabel")
TextLabel_12.BackgroundTransparency = 1
TextLabel_12.Position = UDim2.new(0, 14, 0, 0)
TextLabel_12.Size = UDim2.new(1, -100, 1, 0)
TextLabel_12.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_12.Text = "Redeemer"
TextLabel_12.TextColor3 = Color3.fromRGB(30, 50, 68)
TextLabel_12.TextSize = 13
TextLabel_12.TextWrapped = true
TextLabel_12.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_12.Parent = Frame_10

-- TextButton_2 (TextButton)
local TextButton_2 = Instance.new("TextButton")
TextButton_2.AnchorPoint = Vector2.new(1, 0.5)
TextButton_2.BackgroundColor3 = Color3.fromRGB(222, 232, 240)
TextButton_2.Position = UDim2.new(1, 0, 0.5, 0)
TextButton_2.Size = UDim2.new(0, 40, 0, 22)
TextButton_2.AutoButtonColor = false
TextButton_2.Text = ""
TextButton_2.Parent = Frame_10

-- UICorner_14 (UICorner)
local UICorner_14 = Instance.new("UICorner")
UICorner_14.CornerRadius = UDim.new(0, 11)
UICorner_14.Parent = TextButton_2

-- UIStroke_7 (UIStroke)
local UIStroke_7 = Instance.new("UIStroke")
UIStroke_7.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_7.Color = Color3.fromRGB(168, 208, 236)
UIStroke_7.Transparency = 0.30000001192092896
UIStroke_7.Parent = TextButton_2

-- UIGradient_5 (UIGradient)
local UIGradient_5 = Instance.new("UIGradient")
UIGradient_5.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 216, 244)), ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 140, 191))})
UIGradient_5.Enabled = false
UIGradient_5.Rotation = 90
UIGradient_5.Parent = TextButton_2

-- Frame_12 (Frame)
local Frame_12 = Instance.new("Frame")
Frame_12.AnchorPoint = Vector2.new(0, 0.5)
Frame_12.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_12.Position = UDim2.new(0, 2, 0.5, 0)
Frame_12.Size = UDim2.new(0, 18, 0, 18)
Frame_12.Parent = TextButton_2

-- UICorner_15 (UICorner)
local UICorner_15 = Instance.new("UICorner")
UICorner_15.CornerRadius = UDim.new(0, 9)
UICorner_15.Parent = Frame_12

-- UIStroke_8 (UIStroke)
local UIStroke_8 = Instance.new("UIStroke")
UIStroke_8.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_8.Color = Color3.fromRGB(168, 208, 236)
UIStroke_8.Transparency = 0.40000000596046448
UIStroke_8.Parent = Frame_12

-- TextButton_3 (TextButton)
local TextButton_3 = Instance.new("TextButton")
TextButton_3.AnchorPoint = Vector2.new(1, 0.5)
TextButton_3.BackgroundColor3 = Color3.fromRGB(180, 212, 238)
TextButton_3.Position = UDim2.new(1, -46, 0.5, 0)
TextButton_3.Size = UDim2.new(0, 34, 0, 18)
TextButton_3.AutoButtonColor = false
TextButton_3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
TextButton_3.Text = "0/1"
TextButton_3.TextColor3 = Color3.fromRGB(74, 140, 191)
TextButton_3.TextSize = 10
TextButton_3.Parent = Frame_10

-- UICorner_16 (UICorner)
local UICorner_16 = Instance.new("UICorner")
UICorner_16.CornerRadius = UDim.new(0, 9)
UICorner_16.Parent = TextButton_3

-- UIStroke_9 (UIStroke)
local UIStroke_9 = Instance.new("UIStroke")
UIStroke_9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_9.Color = Color3.fromRGB(168, 208, 236)
UIStroke_9.Transparency = 0.20000000298023224
UIStroke_9.Parent = TextButton_3

-- Frame_13 (Frame)
local Frame_13 = Instance.new("Frame")
Frame_13.BackgroundColor3 = Color3.fromRGB(168, 208, 236)
Frame_13.BackgroundTransparency = 0.30000001192092896
Frame_13.BorderSizePixel = 0
Frame_13.LayoutOrder = 2
Frame_13.Size = UDim2.new(1, 0, 0, 1)
Frame_13.Parent = REDEEMERPage

-- Frame_14 (Frame)
local Frame_14 = Instance.new("Frame")
Frame_14.BackgroundTransparency = 1
Frame_14.LayoutOrder = 3
Frame_14.Size = UDim2.new(1, 0, 0, 40)
Frame_14.Parent = REDEEMERPage

-- Frame_15 (Frame)
local Frame_15 = Instance.new("Frame")
Frame_15.AnchorPoint = Vector2.new(0, 0.5)
Frame_15.BackgroundColor3 = Color3.fromRGB(140, 165, 185)
Frame_15.Position = UDim2.new(0, 0, 0.5, 0)
Frame_15.Size = UDim2.new(0, 6, 0, 6)
Frame_15.Parent = Frame_14

-- UICorner_17 (UICorner)
local UICorner_17 = Instance.new("UICorner")
UICorner_17.CornerRadius = UDim.new(0, 3)
UICorner_17.Parent = Frame_15

-- TextLabel_13 (TextLabel)
local TextLabel_13 = Instance.new("TextLabel")
TextLabel_13.BackgroundTransparency = 1
TextLabel_13.Position = UDim2.new(0, 14, 0, 0)
TextLabel_13.Size = UDim2.new(1, -100, 1, 0)
TextLabel_13.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_13.Text = "Auto Start Code On Annc"
TextLabel_13.TextColor3 = Color3.fromRGB(30, 50, 68)
TextLabel_13.TextSize = 13
TextLabel_13.TextWrapped = true
TextLabel_13.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_13.Parent = Frame_14

-- TextButton_4 (TextButton)
local TextButton_4 = Instance.new("TextButton")
TextButton_4.AnchorPoint = Vector2.new(1, 0.5)
TextButton_4.BackgroundColor3 = Color3.fromRGB(222, 232, 240)
TextButton_4.Position = UDim2.new(1, 0, 0.5, 0)
TextButton_4.Size = UDim2.new(0, 40, 0, 22)
TextButton_4.AutoButtonColor = false
TextButton_4.Text = ""
TextButton_4.Parent = Frame_14

-- UICorner_18 (UICorner)
local UICorner_18 = Instance.new("UICorner")
UICorner_18.CornerRadius = UDim.new(0, 11)
UICorner_18.Parent = TextButton_4

-- UIStroke_10 (UIStroke)
local UIStroke_10 = Instance.new("UIStroke")
UIStroke_10.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_10.Color = Color3.fromRGB(168, 208, 236)
UIStroke_10.Transparency = 0.30000001192092896
UIStroke_10.Parent = TextButton_4

-- UIGradient_6 (UIGradient)
local UIGradient_6 = Instance.new("UIGradient")
UIGradient_6.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 216, 244)), ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 140, 191))})
UIGradient_6.Enabled = false
UIGradient_6.Rotation = 90
UIGradient_6.Parent = TextButton_4

-- Frame_16 (Frame)
local Frame_16 = Instance.new("Frame")
Frame_16.AnchorPoint = Vector2.new(0, 0.5)
Frame_16.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_16.Position = UDim2.new(0, 2, 0.5, 0)
Frame_16.Size = UDim2.new(0, 18, 0, 18)
Frame_16.Parent = TextButton_4

-- UICorner_19 (UICorner)
local UICorner_19 = Instance.new("UICorner")
UICorner_19.CornerRadius = UDim.new(0, 9)
UICorner_19.Parent = Frame_16

-- UIStroke_11 (UIStroke)
local UIStroke_11 = Instance.new("UIStroke")
UIStroke_11.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_11.Color = Color3.fromRGB(168, 208, 236)
UIStroke_11.Transparency = 0.40000000596046448
UIStroke_11.Parent = Frame_16

-- RIDDLEPage (Frame)
local RIDDLEPage = Instance.new("Frame")
RIDDLEPage.Name = "RIDDLEPage"
RIDDLEPage.BackgroundTransparency = 1
RIDDLEPage.Size = UDim2.new(1, 0, 1, 0)
RIDDLEPage.Visible = false
RIDDLEPage.Parent = PageContainer

-- UIPadding_4 (UIPadding)
local UIPadding_4 = Instance.new("UIPadding")
UIPadding_4.PaddingLeft = UDim.new(0, 16)
UIPadding_4.PaddingRight = UDim.new(0, 16)
UIPadding_4.PaddingTop = UDim.new(0, 10)
UIPadding_4.Parent = RIDDLEPage

-- UIListLayout_3 (UIListLayout)
local UIListLayout_3 = Instance.new("UIListLayout")
UIListLayout_3.Padding = UDim.new(0, 8)
UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_3.Parent = RIDDLEPage

-- Frame_17 (Frame)
local Frame_17 = Instance.new("Frame")
Frame_17.BackgroundTransparency = 1
Frame_17.LayoutOrder = 1
Frame_17.Size = UDim2.new(1, 0, 0, 40)
Frame_17.Parent = RIDDLEPage

-- Frame_18 (Frame)
local Frame_18 = Instance.new("Frame")
Frame_18.AnchorPoint = Vector2.new(0, 0.5)
Frame_18.BackgroundColor3 = Color3.fromRGB(140, 165, 185)
Frame_18.Position = UDim2.new(0, 0, 0.5, 0)
Frame_18.Size = UDim2.new(0, 6, 0, 6)
Frame_18.Parent = Frame_17

-- UICorner_20 (UICorner)
local UICorner_20 = Instance.new("UICorner")
UICorner_20.CornerRadius = UDim.new(0, 3)
UICorner_20.Parent = Frame_18

-- TextLabel_14 (TextLabel)
local TextLabel_14 = Instance.new("TextLabel")
TextLabel_14.BackgroundTransparency = 1
TextLabel_14.Position = UDim2.new(0, 14, 0, 0)
TextLabel_14.Size = UDim2.new(1, -100, 1, 0)
TextLabel_14.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal)
TextLabel_14.Text = "Riddle Solver"
TextLabel_14.TextColor3 = Color3.fromRGB(30, 50, 68)
TextLabel_14.TextSize = 13
TextLabel_14.TextWrapped = true
TextLabel_14.TextXAlignment = Enum.TextXAlignment.Left
TextLabel_14.Parent = Frame_17

-- TextButton_5 (TextButton)
local TextButton_5 = Instance.new("TextButton")
TextButton_5.AnchorPoint = Vector2.new(1, 0.5)
TextButton_5.BackgroundColor3 = Color3.fromRGB(222, 232, 240)
TextButton_5.Position = UDim2.new(1, 0, 0.5, 0)
TextButton_5.Size = UDim2.new(0, 40, 0, 22)
TextButton_5.AutoButtonColor = false
TextButton_5.Text = ""
TextButton_5.Parent = Frame_17

-- UICorner_21 (UICorner)
local UICorner_21 = Instance.new("UICorner")
UICorner_21.CornerRadius = UDim.new(0, 11)
UICorner_21.Parent = TextButton_5

-- UIStroke_12 (UIStroke)
local UIStroke_12 = Instance.new("UIStroke")
UIStroke_12.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_12.Color = Color3.fromRGB(168, 208, 236)
UIStroke_12.Transparency = 0.30000001192092896
UIStroke_12.Parent = TextButton_5

-- UIGradient_7 (UIGradient)
local UIGradient_7 = Instance.new("UIGradient")
UIGradient_7.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(173, 216, 244)), ColorSequenceKeypoint.new(1, Color3.fromRGB(74, 140, 191))})
UIGradient_7.Enabled = false
UIGradient_7.Rotation = 90
UIGradient_7.Parent = TextButton_5

-- Frame_19 (Frame)
local Frame_19 = Instance.new("Frame")
Frame_19.AnchorPoint = Vector2.new(0, 0.5)
Frame_19.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame_19.Position = UDim2.new(0, 2, 0.5, 0)
Frame_19.Size = UDim2.new(0, 18, 0, 18)
Frame_19.Parent = TextButton_5

-- UICorner_22 (UICorner)
local UICorner_22 = Instance.new("UICorner")
UICorner_22.CornerRadius = UDim.new(0, 9)
UICorner_22.Parent = Frame_19

-- UIStroke_13 (UIStroke)
local UIStroke_13 = Instance.new("UIStroke")
UIStroke_13.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_13.Color = Color3.fromRGB(168, 208, 236)
UIStroke_13.Transparency = 0.40000000596046448
UIStroke_13.Parent = Frame_19

-- Frame_20 (Frame)
local Frame_20 = Instance.new("Frame")
Frame_20.BackgroundColor3 = Color3.fromRGB(168, 208, 236)
Frame_20.BackgroundTransparency = 0.30000001192092896
Frame_20.BorderSizePixel = 0
Frame_20.LayoutOrder = 2
Frame_20.Size = UDim2.new(1, 0, 0, 1)
Frame_20.Parent = RIDDLEPage

-- ToggleCircleBtn (ImageButton)
local ToggleCircleBtn = Instance.new("ImageButton")
ToggleCircleBtn.Name = "ToggleCircleBtn"
ToggleCircleBtn.BackgroundColor3 = Color3.fromRGB(205, 228, 247)
ToggleCircleBtn.BackgroundTransparency = 0.40000000596046448
ToggleCircleBtn.Position = UDim2.new(0, 20, 0.40000000596046448, 0)
ToggleCircleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleCircleBtn.ZIndex = 10000
ToggleCircleBtn.Image = "rbxassetid://99591772723265"
ToggleCircleBtn.Parent = TigysRedeemerUI

-- UICorner_23 (UICorner)
local UICorner_23 = Instance.new("UICorner")
UICorner_23.CornerRadius = UDim.new(0, 100)
UICorner_23.Parent = ToggleCircleBtn

-- UIStroke_14 (UIStroke)
local UIStroke_14 = Instance.new("UIStroke")
UIStroke_14.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke_14.Color = Color3.fromRGB(255, 255, 255)
UIStroke_14.Thickness = 1.6000000238418579
UIStroke_14.Transparency = 0.20000000298023224
UIStroke_14.Parent = ToggleCircleBtn

-- mount
TigysRedeemerUI.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
-- ============================================================================
-- TIGY RUNTIME v26 - repaired against the recovered MoonVeil root.3 payload
-- GUI ABOVE IS THE USER'S EXACT GRABBED GUI. It is not rebuilt or renamed.
-- ============================================================================

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ENV = (type(getgenv) == "function" and getgenv()) or _G

local CONFIG_FILE = ENV.TigysConfigFile or ENV.tigysConfigFile or "tigys_redeemer_config.json"
local EMBEDDED_WEBHOOK = "https://discord.com/api/webhooks/1538281502532567172/Z-ZdC1pi0ZCorgWUZpzjz_-5xYV7aLGJt00v7AIA8WN_8mH9GzArJzaQ25BIzz_HWWZo"
local ServerData = type(ENV.TigysServerData) == "table" and ENV.TigysServerData or {}
local ExternalRuntime = {
    JsonBinId = ENV.TigysJsonBinId or ENV.tigysJsonBinId,
    JsonBinMasterKey = ENV.TigysJsonBinMasterKey or ENV.tigysJsonBinMasterKey,
    InvalidMap = ENV.TigysInvalidMap or {},
}

local Colors = {
    Accent = Color3.fromRGB(74, 140, 191),
    AccentToggle = Color3.fromRGB(120, 185, 232),
    Good = Color3.fromRGB(122, 201, 166),
    Alert = Color3.fromRGB(235, 100, 100),
    TextPrimary = Color3.fromRGB(30, 50, 68),
    TextMuted = Color3.fromRGB(96, 122, 143),
    Off = Color3.fromRGB(222, 232, 240),
    DotOff = Color3.fromRGB(140, 165, 185),
}

local function serverString(index)
    local value = ServerData[index]
    return type(value) == "string" and value or nil
end

local function resolveRequest()
    if type(syn) == "table" and type(syn.request) == "function" then return syn.request end
    if type(http) == "table" and type(http.request) == "function" then return http.request end
    if type(request) == "function" then return request end
    if type(http_request) == "function" then return http_request end
    return nil
end
local requestFn = resolveRequest()

local state = {
    threshold = 1,
    autoRiddle = false,
    autoStartOnAnnc = false,
    sniping = false,
    bufferedParts = {},
    bufferedCount = 0,
    pendingThreePartResult = false,
    awaitingRedeemFeedback = false,
    redeemFeedbackToken = 0,
    lastObservedText = setmetatable({}, {__mode = "k"}),
    processedSpawnObjects = setmetatable({}, {__mode = "k"}),
    remoteConnections = setmetatable({}, {__mode = "k"}),
    textConnections = setmetatable({}, {__mode = "k"}),
    triggerEventsSeen = 0,
    triggerEventsAccepted = 0,
    captureArmed = false,
    attempts = 0,
}

local function stripRichText(value)
    local text = tostring(value or "")
    text = text:gsub("<[^>]->", "")
    text = text:gsub("^%s*(.-)%s*$", "%1")
    return text
end

-- root.3.1 console behavior. The two original static startup lines are already
-- present in the grabbed GUI, so this function starts after LayoutOrder 2.
local consoleOrder = 2
local CONSOLE_FORMAT = '<font color="rgb(96,122,143)">[%s]</font> %s'
local function appendConsoleLine(message, color)
    consoleOrder += 1
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, 0)
    label.AutomaticSize = Enum.AutomaticSize.Y
    label.FontFace = TextLabel_10.FontFace
    label.RichText = true
    label.Text = string.format(CONSOLE_FORMAT, os.date("%H:%M:%S"), tostring(message))
    label.TextColor3 = color or Colors.TextPrimary
    label.TextSize = 12
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.LayoutOrder = consoleOrder
    label.Parent = ScrollingFrame
    task.defer(function()
        ScrollingFrame.CanvasPosition = Vector2.new(0, math.huge)
    end)
    return label
end

local function notify(username, message)
    username = tostring(username or LocalPlayer.Name)
    message = tostring(message or "")
    TextLabel.Text = "@" .. username
    TextLabel_2.Text = message
    task.spawn(function()
        local okId, userId = pcall(Players.GetUserIdFromNameAsync, Players, username)
        if okId and userId then
            local okThumb, image = pcall(Players.GetUserThumbnailAsync, Players, userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            if okThumb and image then ImageLabel.Image = image end
        end
    end)
    PastelPill.Position = UDim2.new(0.5, -200, 0, -100)
    PastelPill.Visible = true
    TweenService:Create(PastelPill, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -200, 0, 18),
    }):Play()
    task.delay(3.2, function()
        if not PastelPill.Parent then return end
        TweenService:Create(PastelPill, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0.5, -200, 0, -100),
        }):Play()
    end)
end

local function saveConfiguration()
    if type(writefile) ~= "function" then return end
    pcall(function()
        writefile(CONFIG_FILE, HttpService:JSONEncode({
            threshold = state.threshold,
            autoRiddle = state.autoRiddle,
            autoStartOnAnnc = state.autoStartOnAnnc,
        }))
    end)
end

local function loadConfiguration()
    if type(isfile) ~= "function" or type(readfile) ~= "function" then return end
    local ok, exists = pcall(isfile, CONFIG_FILE)
    if not ok or not exists then return end
    local okRead, raw = pcall(readfile, CONFIG_FILE)
    if not okRead then return end
    local okDecode, decoded = pcall(HttpService.JSONDecode, HttpService, raw)
    if not okDecode or type(decoded) ~= "table" then return end
    local threshold = tonumber(decoded.threshold)
    if threshold then
        threshold = math.floor(threshold)
        if threshold < 1 then threshold = 1 end
        if threshold > 4 then threshold = 4 end
        state.threshold = threshold
    end
    if type(decoded.autoRiddle) == "boolean" then state.autoRiddle = decoded.autoRiddle end
    if type(decoded.autoStartOnAnnc) == "boolean" then state.autoStartOnAnnc = decoded.autoStartOnAnnc end
end

local RIDDLE_ANSWERS = {
    ["10th machine"] = "NEWYEARSMACHINE",
    ["10th mutation"] = "PHANTOM",
    ["11th machine"] = "DUELSMACHINE",
    ["11th mutation"] = "CRYSTAL",
    ["12th machine"] = "CUPIDSMACHINE",
    ["13th machine"] = "TRADEMACHINE",
    ["14th machine"] = "DIVINEFUSE",
    ["15th machine"] = "EGGINCUBATOR",
    ["16th machine"] = "CYBERCRAFTMACHINE",
    ["17th machine"] = "SUMMERFUSE",
    ["18th machine"] = "LOSTRADERS",
    ["1st machine"] = "RAINBOWMACHINE",
    ["1st mutation"] = "BLOODROT",
    ["1st trait"] = "LIGHTNING",
    ["1st trait created"] = "LIGHTNING",
    ["2nd machine"] = "BUBBLEGUMMACHINE",
    ["2nd mutation"] = "CANDY",
    ["3rd machine"] = "FUSEMACHINE",
    ["3rd mutation"] = "LAVA",
    ["4th machine"] = "CRAFTMACHINE",
    ["4th mutation"] = "GALAXY",
    ["5th machine"] = "WITCHFUSE",
    ["5th mutation"] = "YINYANG",
    ["67"] = "67",
    ["6th machine"] = "BRAINROTDEALER",
    ["6th mutation"] = "RADIOACTIVE",
    ["7th machine"] = "BRAINROTTRADER",
    ["7th mutation"] = "CURSED",
    ["8th machine"] = "SANTASFUSE",
    ["8th mutation"] = "DIVINE",
    ["9th machine"] = "SANTASSHOP",
    ["9th mutation"] = "CYBER",
    ["age"] = "24",
    ["angelic"] = "DIVINE",
    ["angelic mutation"] = "DIVINE",
    ["best brainrot"] = "STRAWBERRYELEPHANT",
    ["best mutation"] = "DIVINE",
    ["birth day"] = "FRIDAY",
    ["birth month"] = "FEBRUARY",
    ["birth year"] = "2002",
    ["birthday"] = "FRIDAY",
    ["birthplace"] = "ALGERIA",
    ["black and white"] = "GALAXY",
    ["black mutation"] = "GALAXY",
    ["born on"] = "FRIDAY",
    ["born year"] = "2002",
    ["city"] = "SAOPAULO",
    ["color"] = "BLUE",
    ["color is blue"] = "BLUE",
    ["common rarity"] = "COMMON",
    ["country"] = "BRAZIL",
    ["created on"] = "FRIDAY",
    ["creator"] = "SAMMY",
    ["creator name"] = "SAMMY",
    ["creator real name"] = "SAMMY",
    ["creator twice"] = "SAMMYSAMMY",
    ["cursed mutation"] = "CURSED",
    ["date made"] = "MAY162025",
    ["day born"] = "FRIDAY",
    ["day i was born"] = "FRIDAY",
    ["day sab was made"] = "FRIDAY",
    ["day sab was released"] = "FRIDAY",
    ["divine mutation"] = "DIVINE",
    ["eighteenth machine"] = "LOSTRADERS",
    ["eighth machine"] = "SANTASFUSE",
    ["eleventh machine"] = "DUELSMACHINE",
    ["evil"] = "CURSED",
    ["evil mutation"] = "CURSED",
    ["fav animal"] = "SPIDER",
    ["fav color"] = "BLUE",
    ["fav color is blue"] = "BLUE",
    ["fav food"] = "PIZZA",
    ["fav football player"] = "FOOTBALL",
    ["fav game"] = "ROBLOX",
    ["fav player"] = "FOOTBALL",
    ["fav sport"] = "FOOTBALL",
    ["favorite animal"] = "SPIDER",
    ["favorite color"] = "BLUE",
    ["favorite color twice"] = "BLUEBLUE",
    ["favorite food"] = "PIZZA",
    ["favorite food twice"] = "PIZZAPIZZA",
    ["favorite game"] = "ROBLOX",
    ["favorite player"] = "FOOTBALL",
    ["favorite sport"] = "FOOTBALL",
    ["favorite sport twice"] = "FOOTBALLFOOTBALL",
    ["favourite color"] = "BLUE",
    ["fifteenth machine"] = "EGGINCUBATOR",
    ["fifth machine"] = "WITCHFUSE",
    ["first machine"] = "RAINBOWMACHINE",
    ["first mutation"] = "BLOODROT",
    ["first trait"] = "LIGHTNING",
    ["first trait created"] = "LIGHTNING",
    ["food"] = "PIZZA",
    ["football player"] = "FOOTBALL",
    ["fourteenth machine"] = "DIVINEFUSE",
    ["fourth machine"] = "CRAFTMACHINE",
    ["full name"] = "STEALABRAINROT",
    ["funny number"] = "67",
    ["game created on"] = "FRIDAY",
    ["game creation day"] = "FRIDAY",
    ["game made on"] = "FRIDAY",
    ["game name"] = "STEALABRAINROT",
    ["game release"] = "MAY162025",
    ["game release date"] = "MAY162025",
    ["game released"] = "MAY162025",
    ["good mutation"] = "DIVINE",
    ["green"] = "RADIOACTIVE",
    ["green mutation"] = "RADIOACTIVE",
    ["headless horseman"] = "LOSTRADERS",
    ["highest rarity"] = "OG",
    ["how old am i"] = "24",
    ["how old is sammy"] = "24",
    ["latest mutation"] = "CRYSTAL",
    ["lightning"] = "LIGHTNING",
    ["lightning trait"] = "LIGHTNING",
    ["lowest rarity"] = "COMMON",
    ["molten"] = "MOLTEN",
    ["molten mutation"] = "MOLTEN",
    ["month born"] = "FEBRUARY",
    ["month i was born"] = "FEBRUARY",
    ["month sab was made"] = "MAY",
    ["most recent"] = "CRYSTAL",
    ["most recent mutation"] = "CRYSTAL",
    ["my age"] = "24",
    ["my age 2 times"] = "2424",
    ["my age 3 times"] = "242424",
    ["my age twice"] = "2424",
    ["my animal"] = "SPIDER",
    ["my cat's name"] = "NOVA",
    ["my cats name"] = "NOVA",
    ["my city"] = "SAOPAULO",
    ["my color"] = "BLUE",
    ["my color is blue"] = "BLUE",
    ["my country"] = "BRAZIL",
    ["my food"] = "PIZZA",
    ["my name"] = "SAMMY",
    ["what is my name"] = "SAMMY",
    ["whats my name"] = "SAMMY",
    ["what's my name"] = "SAMMY",
    ["my name 2 times"] = "SAMMYSAMMY",
    ["my name 3 times"] = "SAMMYSAMMYSAMMY",
    ["my name twice"] = "SAMMYSAMMY",
    ["my nationality"] = "BRAZILIAN",
    ["my pet"] = "SPIDER",
    ["my real name"] = "SAMMY",
    ["my roblox username"] = "SPYDERSAMMY",
    ["my sport"] = "FOOTBALL",
    ["my state"] = "SAOPAULO",
    ["my username"] = "SPYDERSAMMY",
    ["my youtube"] = "SPYDERSAMMY",
    ["name of the game"] = "STEALABRAINROT",
    ["name twice"] = "SAMMYSAMMY",
    ["nationality"] = "BRAZILIAN",
    ["newest mutation"] = "CRYSTAL",
    ["ninth machine"] = "SANTASSHOP",
    ["orange"] = "MOLTEN",
    ["orange mutation"] = "MOLTEN",
    ["owner"] = "SAMMY",
    ["owner real name"] = "SAMMY",
    ["owner twice"] = "SAMMYSAMMY",
    ["purple"] = "GALAXY",
    ["purple mutation"] = "GALAXY",
    ["rarest"] = "LOSTRADERS",
    ["rarest brainrot"] = "LOSTRADERS",
    ["rarest rarity"] = "OG",
    ["real name"] = "SAMMY",
    ["red"] = "CURSED",
    ["red mutation"] = "CURSED",
    ["release date"] = "MAY162025",
    ["release month"] = "MAY",
    ["release year"] = "2025",
    ["roblox name"] = "SPYDERSAMMY",
    ["roblox username"] = "SPYDERSAMMY",
    ["ronaldo"] = "FOOTBALL",
    ["sab"] = "STEALABRAINROT",
    ["sab made on"] = "FRIDAY",
    ["sab release"] = "MAY162025",
    ["sab release day"] = "FRIDAY",
    ["sab release month"] = "MAY",
    ["sab released"] = "MAY162025",
    ["sab stands for"] = "STEALABRAINROT",
    ["sammy age"] = "24",
    ["sammy city"] = "SAOPAULO",
    ["sammy color"] = "BLUE",
    ["sammy color is blue"] = "BLUE",
    ["sammy country"] = "BRAZIL",
    ["sammy location"] = "BRAZIL",
    ["sammy nationality"] = "BRAZILIAN",
    ["sammy real name"] = "SAMMY",
    ["sammy roblox name"] = "SPYDERSAMMY",
    ["sammy state"] = "SAOPAULO",
    ["sammy username"] = "SPYDERSAMMY",
    ["sammy youtube"] = "SPYDERSAMMY",
    ["sammys real name"] = "SAMMY",
    ["second machine"] = "BUBBLEGUMMACHINE",
    ["second mutation"] = "CANDY",
    ["seventeenth machine"] = "SUMMERFUSE",
    ["seventh machine"] = "BRAINROTTRADER",
    ["sixteenth machine"] = "CYBERCRAFTMACHINE",
    ["sixth machine"] = "BRAINROTDEALER",
    ["social media"] = "YOUTUBE",
    ["special number"] = "67",
    ["sport"] = "FOOTBALL",
    ["state"] = "SAOPAULO",
    ["struck by lightning"] = "LIGHTNING",
    ["tenth machine"] = "NEWYEARSMACHINE",
    ["third machine"] = "FUSEMACHINE",
    ["third mutation"] = "LAVA",
    ["thirteenth machine"] = "TRADEMACHINE",
    ["top mutation"] = "DIVINE",
    ["top rarity"] = "OG",
    ["trait from lightning"] = "LIGHTNING",
    ["turns black"] = "GALAXY",
    ["turns green"] = "RADIOACTIVE",
    ["turns orange"] = "MOLTEN",
    ["turns purple"] = "GALAXY",
    ["turns red"] = "CURSED",
    ["turns yellow"] = "DIVINE",
    ["twelfth machine"] = "CUPIDSMACHINE",
    ["unobtainable"] = "STRAWBERRYELEPHANT",
    ["username"] = "SPYDERSAMMY",
    ["what is my cats name"] = "NOVA",
    ["when made"] = "MAY162025",
    ["when was sab created"] = "MAY162025",
    ["when was sab made"] = "MAY162025",
    ["when was sab released"] = "MAY162025",
    ["where am i from"] = "BRAZIL",
    ["where do i live"] = "BRAZIL",
    ["where does sammy live"] = "BRAZIL",
    ["where i was born"] = "ALGERIA",
    ["where is sammy from"] = "BRAZIL",
    ["where was i born"] = "ALGERIA",
    ["where was i born at"] = "ALGERIA",
    ["who created sab"] = "SAMMY",
    ["who is the owner"] = "SAMMY",
    ["who made sab"] = "SAMMY",
    ["who owns sab"] = "SAMMY",
    ["year born"] = "2002",
    ["year created"] = "2025",
    ["year i was born"] = "2002",
    ["year made"] = "2025",
    ["year of sab"] = "2025",
    ["year sab was created"] = "2025",
    ["year sab was made"] = "2025",
    ["year we are on"] = "2026",
    ["year we're on"] = "2026",
    ["year were on"] = "2026",
    ["yellow"] = "DIVINE",
    ["yellow mutation"] = "DIVINE",
    ["youtube channel"] = "SPYDERSAMMY",
}

local MUTATION_NAMES = {
    "Bloodmoon", "Candy", "YinYang", "Radioactive", "Galaxy", "Molten",
    "Cursed", "Divine", "Cyber", "Phantom", "Crystal", "Gold",
    "Diamond", "Bloodrot", "Rainbow",
}

local function findVisibleMutation()
    for _, object in ipairs(PlayerGui:GetDescendants()) do
        if object:IsA("GuiObject") and object.Visible then
            local haystacks = {tostring(object.Name)}
            if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
                table.insert(haystacks, tostring(object.Text))
            end
            for _, haystack in ipairs(haystacks) do
                local lower = haystack:lower()
                for _, mutation in ipairs(MUTATION_NAMES) do
                    if lower:find(mutation:lower(), 1, true) then
                        return mutation:upper()
                    end
                end
            end
        end
    end
    return nil
end

local sortedRiddleInstructions
local function getSortedRiddleInstructions()
    if sortedRiddleInstructions then return sortedRiddleInstructions end
    sortedRiddleInstructions = {}
    for instruction in pairs(RIDDLE_ANSWERS) do
        table.insert(sortedRiddleInstructions, instruction)
    end
    table.sort(sortedRiddleInstructions, function(a, b)
        return #a > #b
    end)
    return sortedRiddleInstructions
end

-- root.3.21.1.1 strategy: normalize, longest-first, restart after every match,
-- support multiple instructions and twice/Ntimes.
local function solveRiddle(raw)
    local original = tostring(raw or "")
    local normalized = original:lower():gsub("[^%w]", "")

    if normalized:find("mutation", 1, true) then
        local mutation = findVisibleMutation()
        if mutation then return mutation end
    end

    local pieces = {}
    local remaining = normalized
    local ordered = getSortedRiddleInstructions()

    while #remaining > 0 do
        local matched = false
        for _, instruction in ipairs(ordered) do
            local needle = instruction:lower():gsub("[^%w]", "")
            if needle ~= "" then
                local first, last = remaining:find(needle, 1, true)
                if first then
                    local answer = tostring(RIDDLE_ANSWERS[instruction])
                    local suffix = remaining:sub(last + 1)
                    local repeatCount = 1
                    if suffix:sub(1, 5) == "twice" then
                        repeatCount = 2
                    else
                        local amount = suffix:match("^(%d+)times")
                        if amount then repeatCount = tonumber(amount) or 1 end
                    end
                    table.insert(pieces, answer:rep(repeatCount))
                    remaining = remaining:sub(last + 1)
                    matched = true
                    break
                en
... (34 Ko restants)

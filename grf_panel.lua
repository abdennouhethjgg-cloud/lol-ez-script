-- GRF Style Panel for Delta Executor
-- Created for user request

local Library = {}

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local SideBar = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local TabContainer = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local ContentFrame = Instance.new("Frame")
    local UICorner_3 = Instance.new("UICorner")
    local Pages = Instance.new("Folder")

    -- Properties
    ScreenGui.Name = "GRF_Panel"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.Active = true
    MainFrame.Draggable = true

    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    SideBar.Name = "SideBar"
    SideBar.Parent = MainFrame
    SideBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    SideBar.Size = UDim2.new(0, 150, 1, 0)

    UICorner_2.CornerRadius = UDim.new(0, 8)
    UICorner_2.Parent = SideBar

    Title.Name = "Title"
    Title.Parent = SideBar
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0, 10, 0, 10)
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title or "GRF PANEL"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = SideBar
    TabContainer.Active = true
    TabContainer.BackgroundTransparency = 1.000
    TabContainer.Position = UDim2.new(0, 0, 0, 50)
    TabContainer.Size = UDim2.new(1, 0, 1, -50)
    TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContainer.ScrollBarThickness = 2

    UIListLayout.Parent = TabContainer
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)

    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ContentFrame.Position = UDim2.new(0, 160, 0, 10)
    ContentFrame.Size = UDim2.new(1, -170, 1, -20)

    UICorner_3.CornerRadius = UDim.new(0, 8)
    UICorner_3.Parent = ContentFrame

    Pages.Name = "Pages"
    Pages.Parent = ContentFrame

    local function CreateTab(name)
        local TabButton = Instance.new("TextButton")
        local Page = Instance.new("ScrollingFrame")
        local PageList = Instance.new("UIListLayout")

        TabButton.Name = name .. "Tab"
        TabButton.Parent = TabContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.BackgroundTransparency = 1.000
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = name
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 14.000

        Page.Name = name .. "Page"
        Page.Parent = Pages
        Page.Active = true
        Page.BackgroundTransparency = 1.000
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.Visible = false
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 4

        PageList.Parent = Page
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 10)

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(Pages:GetChildren()) do
                v.Visible = false
            end
            for _, v in pairs(TabContainer:GetChildren()) do
                if v:IsA("TextButton") then
                    v.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end
            Page.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)

        local Tab = {}

        function Tab:AddButton(text, callback)
            local Button = Instance.new("TextButton")
            local UICorner_B = Instance.new("UICorner")

            Button.Name = text .. "Button"
            Button.Parent = Page
            Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Button.Size = UDim2.new(1, -10, 0, 40)
            Button.Font = Enum.Font.Gotham
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14.000

            UICorner_B.CornerRadius = UDim.new(0, 6)
            UICorner_B.Parent = Button

            Button.MouseButton1Click:Connect(function()
                callback()
            end)
            
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end

        function Tab:AddToggle(text, callback)
            local ToggleFrame = Instance.new("Frame")
            local ToggleButton = Instance.new("TextButton")
            local UICorner_T = Instance.new("UICorner")
            local Title_T = Instance.new("TextLabel")
            local Status = Instance.new("Frame")
            local UICorner_S = Instance.new("UICorner")

            ToggleFrame.Name = text .. "Toggle"
            ToggleFrame.Parent = Page
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            ToggleFrame.Size = UDim2.new(1, -10, 0, 40)

            UICorner_T.CornerRadius = UDim.new(0, 6)
            UICorner_T.Parent = ToggleFrame

            Title_T.Parent = ToggleFrame
            Title_T.BackgroundTransparency = 1.000
            Title_T.Position = UDim2.new(0, 10, 0, 0)
            Title_T.Size = UDim2.new(1, -60, 1, 0)
            Title_T.Font = Enum.Font.Gotham
            Title_T.Text = text
            Title_T.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title_T.TextSize = 14.000
            Title_T.TextXAlignment = Enum.TextXAlignment.Left

            Status.Name = "Status"
            Status.Parent = ToggleFrame
            Status.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            Status.Position = UDim2.new(1, -35, 0.5, -10)
            Status.Size = UDim2.new(0, 20, 0, 20)

            UICorner_S.CornerRadius = UDim.new(1, 0)
            UICorner_S.Parent = Status

            ToggleButton.Parent = ToggleFrame
            ToggleButton.BackgroundTransparency = 1.000
            ToggleButton.Size = UDim2.new(1, 0, 1, 0)
            ToggleButton.Text = ""

            local enabled = false
            ToggleButton.MouseButton1Click:Connect(function()
                enabled = not enabled
                Status.BackgroundColor3 = enabled and Color3.fromRGB(50, 255, 50) or Color3.fromRGB(255, 50, 50)
                callback(enabled)
            end)

            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end

        return Tab
    end

    -- Initial state
    if #Pages:GetChildren() > 0 then
        Pages:GetChildren()[1].Visible = true
    end

    return {
        CreateTab = CreateTab
    }
end

-- Example Usage:
local win = Library:CreateWindow("GRF PANEL")
local main = win:CreateTab("Main")
local tele = win:CreateTab("Teleports")

main:AddButton("Speed (100)", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

main:AddToggle("Infinite Jump", function(state)
    _G.InfJump = state
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if _G.InfJump then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

tele:AddButton("Teleport to Spawn", function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
end)

print("prince")
task.wait(0.05)
local Players = game:GetService("Players")
game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
game:GetService("GuiService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local localPlayer = Players.LocalPlayer
local playerGui = localPlayer:WaitForChild("PlayerGui")
local virtualInputManager = nil

pcall(function()
	virtualInputManager = game:GetService("VirtualInputManager")
end)
if not virtualInputManager then
	pcall(function()
		virtualInputManager = Instance.new("VirtualInputManager")
	end)
end

local function getVirtualInputManager()
	if not virtualInputManager then
		pcall(function()
			virtualInputManager = game:GetService("VirtualInputManager")
		end)
	end
	return virtualInputManager
end

if virtualInputManager then
	pcall(function()
		virtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
	end)
end

if _G.Formega_Script_Purge then
	pcall(function()
		_G.Formega_Script_Purge()
	end)

	task.wait(0.2)
end

local tbl = {}
local flag = false

local function fn()
	local quickPickup = false
	local tbl2 = {}
	local flag2 = false

	local function fn2(arg)
		if not arg or not arg:IsA("Model") then
			return false
		end
		local plotSign = arg:FindFirstChild("PlotSign")
		if plotSign and plotSign:FindFirstChild("YourBase") and plotSign.YourBase.Enabled then
			return true
		end
		return false
	end

	local function fn3(arg)
		if not arg or not arg.Parent then
			return false
		end
		local parent = arg.Parent

		for i = 1, 12 do
			if not parent then
				return false
			end

			if parent:IsA("Model") and parent.Parent and parent.Parent.Name == "Plots" then
				return fn2(parent)
			end
			parent = parent.Parent
		end

		return false
	end

	local function fn4()
		if flag2 then
			return
		end
		local ok, result = pcall(getrawmetatable, game)
		if not ok or not result then
			return
		end
		pcall(setreadonly, result, false)
		local newindex = result.__newindex

		result.__newindex = (newcclosure or function(arg)
			return arg
		end)(function(arg, arg2, arg3)
			if not flag and arg2 == "HoldDuration" and quickPickup and typeof(arg) == "Instance" and arg:IsA("ProximityPrompt") and fn3(arg) then
				arg3 = 0.05
			end

			return newindex(arg, arg2, arg3)
		end)

		pcall(setreadonly, result, true)
		flag2 = true
	end

	return { set = function(arg)
		quickPickup = arg and true or false
		_G.QuickPickup = quickPickup

		if quickPickup then
			fn4()

			task.spawn(function()
				local tbl3 = { Workspace:FindFirstChild("Plots") or Workspace }

				while #tbl3 > 0 and quickPickup do
					local v = table.remove(tbl3)

					for _, child in ipairs(v:GetChildren()) do
						if child:IsA("ProximityPrompt") and fn3(child) then
							if tbl2[child] == nil then
								tbl2[child] = child.HoldDuration
							end

							pcall(function()
								child.HoldDuration = 0.05
							end)
						end

						table.insert(tbl3, child)
					end

					n += 1

					if n % 50 == 0 then
						task.wait()
					end
				end
			end)
		else
			for k, v in pairs(tbl2) do
				if k and k.Parent then
					pcall(function()
						k.HoldDuration = v
					end)
				end
			end

			tbl2 = {}
		end
	end }
end

_G._175_QuickPickup = fn()
local tbl2 = {}
local flag2 = false
_G.RagdollBypass = false
_G.AutoResetOnBalloon = true
_G.AutoGiant = false
_G.AutoBlock = false
_G.APESPEnabled = false
_G.BackpackESP = false
_G.ShowGiantPotion = true
_G.ShowFlashTeleport = true
_G.ShowFlyingCarpet = true
_G.BrainrotHighlight = false
_G.FPSBoostEnabled = false
_G.AutoSelectBrainrot = false
_G.OrbitAutoSteal = true
_G.AutoSelectBrainrotName = ""
_G.AutoSelectBrainrotSlot = 0
_G.QuickAP = false
_G.DropBrainrotEnabled = false
_G.ESPBaseEnabled = false
_G.ESPBestEnabled = false
_G.antiGummyEnabled = false
_G.AutoTurretEnabled = false
_G.AutoReturnBase = false
_G.FlashSpeed = 180
_G.OrbitTravelMode = "Carpet"
_G.OrbitGrappleSpeed = 400
_G.OrbitArrivalSpeed = 180
_G.TransportIndex = 1
_G.AntiSteal = false
_G.QuickPickup = false
_G.AntiStealMode = "laser"
_G.AntiStealDelay = 1.8
_G.AntiStealAP = { balloon = true, tiny = false, jail = false, rocket = false, ragdoll = false }
local flag3 = false
local tbl3 = { X = 0.5, Y = 0.5 }
local flag4 = true
local n = 0.85
_G.VampireResetRemote = nil
_G.VampireResetGuid = ""

local function fn2(arg)
	if not arg then
		return 0
	end
	local str = tostring(arg):gsub(",", ""):gsub("%s", ""):upper()
	local match = str:match("([%d%.]+)")
	if not match then
		return 0
	end
	local n2 = tonumber(match) or 0
	if str:find("DC") then
		return n2 * 1e33
	elseif str:find("NO") then
		return n2 * 1e30
	elseif str:find("OC") then
		return n2 * 1e27
	elseif str:find("SP") then
		return n2 * 1e24
	elseif str:find("SX") then
		return n2 * 1e21
	elseif str:find("QI") then
		return n2 * 1e18
	elseif str:find("QA") or str:find("QD") or str:find("Q") then
		return n2 * 1e15
	elseif str:find("T") then
		return n2 * 1e12
	elseif str:find("B") then
		return n2 * 1e9
	elseif str:find("M") then
		return n2 * 1e6
	elseif str:find("K") then
		return n2 * 1e3
	end
	return n2
end

local function fn3(arg)
	local str = (arg or ""):lower()
	if str:find("godly") or str:find("celestial") or str:find("divine") or str:find("secret") or str:find("og") or str:find("exclusive") or str:find("exotic") then
		return 100
	end

	if str:find("mythic") or str:find("mitico") or str:find("relic") then
		return 80
	end

	if str:find("legendary") or str:find("legendario") then
		return 60
	end

	if str:find("epic") or str:find("epico") then
		return 40
	end

	if str:find("rare") or str:find("raro") then
		return 25
	end

	if str:find("uncommon") then
		return 15
	end
	return 5
end

local function fn4(arg, arg2)
	if not arg then
		return "?", 0
	end
	local attribute = arg:GetAttribute("Value") or arg:GetAttribute("Price") or arg:GetAttribute("Cash") or arg:GetAttribute("Generation")
	if attribute then
		local str = tostring(attribute)
		return str, fn2(str)
	end

	if not arg2 and arg.Parent then
		arg2 = arg.Parent.Parent
	end

	if arg2 then
		for _, descendant in ipairs(arg2:GetDescendants()) do
			if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
				local str = tostring(descendant.Text or "")
				if str:find("%$") or str:find("/s") or str:find("/S") or str:find("M/s") or str:find("K/s") or str:find("B/s") then
					return str, fn2(str)
				end
			end
		end
	end

	return "?", 0
end

local function fn5()
	local character = localPlayer and localPlayer.Character
	character = character and character:FindFirstChild("HumanoidRootPart")
	if not character then
		return nil
	end
	local huge = math.huge

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer then
			local character2 = player.Character
			character2 = character2 and character2:FindFirstChild("HumanoidRootPart")

			if character2 then
				local magnitude = (character2.Position - character.Position).Magnitude

				if magnitude < huge then
					huge = magnitude
					v = player
				end
			end
		end
	end

	return v
end

_G.BlockDelay = _G.BlockDelay or "fast"

local function fn6()
	if _G.BlockDelay == "normal" then
		return 0.5
	end

	if _G.BlockDelay == "slow" then
		return 1
	end
	return 0
end

local function fn7()
	local currentCamera = workspace.CurrentCamera
	if not currentCamera then
		return
	end
	local vim = getVirtualInputManager()
	if not vim then
		return
	end
	local viewportSize = currentCamera.ViewportSize
	local n2 = viewportSize.X / 2
	local n3 = viewportSize.Y / 2 + 30

	for i = 1, 4 do
		pcall(function()
			vim:SendMouseButtonEvent(n2, n3, 0, true, game, 1)
			vim:SendMouseButtonEvent(n2, n3, 0, false, game, 1)
		end)

		task.wait(0.001)
	end
end

local function fn8(arg)
	if not arg or arg == localPlayer then
		return
	end

	pcall(function()
		task.wait(fn6())
		StarterGui:SetCore("PromptBlockPlayer", arg)
		task.wait(0.05)
		fn7()
	end)
end

local function fn9()
	if not _G.AutoBlock then
		return
	end

	task.spawn(function()
		local v = fn5()

			pcall(fn8, v)
		end
	end)
end

local fn10 = nil
local flag5 = false
local tbl4 = {}
local flag6 = false

local function fn11()
	flag5 = false

	for _, v3 in ipairs(tbl4) do
		if typeof(v3) == "RBXScriptConnection" then
			pcall(function()
				v3:Disconnect()
			end)
		end
	end

	tbl4 = {}

		pcall(function()
			task.cancel(v2)
		end)

		v2 = nil
	end

	pcall(function()
		local character = localPlayer.Character

		if character then
			local humanoid = character:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

			if humanoid then
				humanoid.PlatformStand = false
				humanoid.Sit = false
				local flag7 = humanoid.Health > 0

				if flag7 then
					local freefall = Enum.HumanoidStateType.Freefall
					flag7 = humanoid:GetState() ~= freefall
				end

				if flag7 then
					pcall(function()
						humanoid:ChangeState(Enum.HumanoidStateType.Running)
					end)
				end
			end

			if humanoidRootPart then
				humanoidRootPart.Anchored = false
				local z = humanoidRootPart.AssemblyLinearVelocity.Z
				humanoidRootPart.AssemblyLinearVelocity = Vector3.new(humanoidRootPart.AssemblyLinearVelocity.X, math.min(humanoidRootPart.AssemblyLinearVelocity.Y, 50), z)
			end
		end
	end)

		v.BackgroundColor3 = Color3.fromRGB(49, 65, 87)
		v.Text = "DROP"
	end

	flag6 = false
end

local function fn12()
	if flag5 then
		fn11()
		return
	end

	if flag6 then
		fn11()
		return
	end
	flag6 = true
	flag5 = true

	local connection = RunService.Stepped:Connect(function()
		if not flag5 then
			return
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				for _, child in ipairs(player.Character:GetChildren()) do
					if child:IsA("BasePart") then
						child.CanCollide = false
					end
				end
			end
		end
	end)

	table.insert(tbl4, connection)

	v2 = task.spawn(function()
		local now = tick()
		local n2 = 0.85
		local n3

			n3 = n2
		else
			n3 = 3
		end

		local n4 = now + n3

		while flag5 and tick() < n4 do
			RunService.Heartbeat:Wait()
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")

			if character then
				local velocity = character.Velocity
				character.Velocity = velocity * 10000 + Vector3.new(0, 10000, 0)
				RunService.RenderStepped:Wait()

				if character.Parent then
					character.Velocity = velocity
				end

				RunService.Stepped:Wait()

				if character.Parent then
					character.Velocity = velocity + Vector3.new(0, 0.1, 0)
				end
			else
				RunService.Heartbeat:Wait()
			end
		end

		fn11()
	end)

		v.BackgroundColor3 = Color3.fromRGB(60, 200, 120)
		v.Text = "DROP ✓"
	end
end

v = nil
local flag7 = false

local function fn13()
	local dropBrainrotGui = playerGui:FindFirstChild("DropBrainrotGui")

	if dropBrainrotGui then
		dropBrainrotGui:Destroy()
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DropBrainrotGui"
	screenGui.ResetOnSpawn = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder = 16
	screenGui.Parent = playerGui
	v3 = screenGui
	local frame = Instance.new("Frame", screenGui)
	frame.Size = UDim2.new(0, 96, 0, 48)
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.Position = UDim2.new(tbl3.X or 0.5, 0, tbl3.Y or 0.5, 0)
	frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	frame.BackgroundTransparency = 0.5
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
	v5 = frame
	local frame2 = Instance.new("Frame", screenGui)
	frame2.Size = UDim2.new(0, 88, 0, 40)
	frame2.AnchorPoint = Vector2.new(0.5, 0.5)
	frame2.Position = UDim2.new(tbl3.X or 0.5, 0, tbl3.Y or 0.5, 0)
	frame2.BackgroundColor3 = Color3.fromRGB(24, 32, 44)
	frame2.BorderSizePixel = 0
	frame2.ClipsDescendants = true
	Instance.new("UICorner", frame2).CornerRadius = UDim.new(0, 6)
	local uiStroke = Instance.new("UIStroke", frame2)
	uiStroke.Color = Color3.fromRGB(60, 140, 250)
	uiStroke.Thickness = 1.5
	v4 = frame2
	local textButton = Instance.new("TextButton", frame2)
	textButton.Size = UDim2.new(1, -4, 1, -4)
	textButton.Position = UDim2.new(0, 2, 0, 2)
	textButton.BackgroundColor3 = Color3.fromRGB(49, 65, 87)
	textButton.Text = "DROP"
	textButton.Font = Enum.Font.GothamBold
	textButton.TextSize = 12
	textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	textButton.BorderSizePixel = 0
	Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 4)
	v = textButton
	local dragging = false
	local dragMoved = false
	local dragStart = nil
	local startPos = nil
	local currentCamera = workspace.CurrentCamera

	local function onInputBegan(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragMoved = false
			dragStart = input.Position
			startPos = frame2.Position
		end
	end

	textButton.InputBegan:Connect(onInputBegan)
	frame2.InputBegan:Connect(onInputBegan)

	UserInputService.InputChanged:Connect(function(input)
		if not dragging then
			return
		end

		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
			dragMoved = true
		end
		if dragMoved then
			local x = currentCamera and currentCamera.ViewportSize.X or 800
			local y = currentCamera and currentCamera.ViewportSize.Y or 600
			frame2.Position = UDim2.new(n3, 0, n4, 0)
			frame.Position = UDim2.new(n3, 0, n4, 0)
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if not dragging then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			if dragMoved then
				tbl3.X = frame2.Position.X.Scale
				tbl3.Y = frame2.Position.Y.Scale
				if fn10 then
					pcall(fn10)
				end
			end
		end
	end)

	textButton.MouseButton1Click:Connect(function()
		if not dragMoved then
			fn12()
		end
	end)
end

local function fn14(dropBrainrotEnabled)
	if dropBrainrotEnabled == nil then
		dropBrainrotEnabled = not _G.DropBrainrotEnabled
	end

	_G.DropBrainrotEnabled = dropBrainrotEnabled

	if _G.DropBrainrotEnabled then
		fn13()
		flag7 = true
	else
			v3:Destroy()
			v3 = nil
			v4 = nil
			v5 = nil
			v = nil
		end

		flag7 = false

		if flag5 then
			flag5 = false

			for _, v6 in ipairs(tbl4) do
				if typeof(v6) == "RBXScriptConnection" then
					v6:Disconnect()
				end
			end

			tbl4 = {}
		end
	end

	if fn10 then
		pcall(fn10)
	end
end

local function fn15()
	local ok, result = pcall(function()
		return game:GetService("HttpService"):JSONDecode(readfile("orbit_classic_layout.json"))
	end)

	if ok and type(result) == "table" then
		return result
	end
	return {}
end

local v6 = fn15()

if type(v6.OrbitBanner) == "boolean" and v6.OrbitBannerVisible == nil then
	v6.OrbitBannerVisible = true
	v6.OrbitBanner = nil
end

local flag8 = false

local function fn16(arg, arg2)
	if type(writefile) ~= "function" or type(readfile) ~= "function" then
		if not flag8 then
			print("prince")
			flag8 = true
		end

		return false
	end

	local ok, result = pcall(function()
		writefile(arg, game:GetService("HttpService"):JSONEncode(arg2))
	end)

	if not ok then
	end

	return ok
end

local function fn17()
	return fn16("orbit_classic_layout.json", v6)
end

local function fn18(arg, arg2, position)
	local v7 = v6[arg2]

	local function fn19(arg3)
		return type(arg3) == "number" and arg3 == arg3 and math.abs(arg3) < 10000000
	end

	arg.Position = position or arg.Position

	if type(v7) == "table" and fn19(v7.sx) and fn19(v7.ox) and fn19(v7.sy) and fn19(v7.oy) then
		arg.Position = UDim2.new(v7.sx, v7.ox, v7.sy, v7.oy)
	end

	local currentCamera = Workspace.CurrentCamera

	if currentCamera then
		local viewportSize = currentCamera.ViewportSize
		local uiScale = arg:FindFirstChildOfClass("UIScale")
		local scale = uiScale and uiScale.Scale or 1
		local n2 = arg.Size.X.Offset * scale
		local n3 = arg.Size.Y.Offset * scale
		local position2 = arg.Position
		local n4 = position2.X.Scale * viewportSize.X + position2.X.Offset
		local n5 = position2.Y.Scale * viewportSize.Y + position2.Y.Offset
		local x = arg.AnchorPoint.X
		local y = arg.AnchorPoint.Y
		local n6 = math.clamp(n4, n2 * x, math.max(n2 * x, viewportSize.X - n2 * (1 - x)))
		local n7 = math.clamp(n5, n3 * y, math.max(n3 * y, viewportSize.Y - n3 * (1 - y)))

		if n6 ~= n4 or n7 ~= n5 then
			arg.Position = UDim2.fromOffset(n6, n7)
		end
	end
end

local function fn19(arg, arg2)
	v6[arg2] = {
		sx = arg.Position.X.Scale,
		ox = arg.Position.X.Offset,
		sy = arg.Position.Y.Scale,
		oy = arg.Position.Y.Offset,

	fn17()
end

local function fn20()
	local ok, result = pcall(function()
		return game:GetService("HttpService"):JSONDecode(readfile("orbit_classic_settings.json"))
	end)

	if ok and type(result) == "table" then
		return result
	end
	return {}
end

fn10 = function()
	pcall(function()
		fn16("orbit_classic_settings.json", {
			AutoResetOnBalloon = _G.AutoResetOnBalloon,
			AutoGiant = _G.AutoGiant,
			AutoBlock = _G.AutoBlock,
			BlockDelay = _G.BlockDelay,
			APESPEnabled = _G.APESPEnabled,
			BackpackESP = _G.BackpackESP,
			BrainrotHighlight = _G.BrainrotHighlight,
			FPSBoostEnabled = _G.FPSBoostEnabled == true,
			AutoSelectBrainrot = _G.AutoSelectBrainrot == true,
			OrbitAutoSteal = _G.OrbitAutoSteal ~= false,
			ShowGiantPotion = _G.ShowGiantPotion,
			ShowFlashTeleport = _G.ShowFlashTeleport,
			ShowFlyingCarpet = _G.ShowFlyingCarpet,
			QapPos = _G.QapPos and {
				sx = _G.QapPos.X.Scale,
				ox = _G.QapPos.X.Offset,
				sy = _G.QapPos.Y.Scale,
				oy = _G.QapPos.Y.Offset,
			} or nil,
			AutoSelectBrainrotName = tostring(_G.AutoSelectBrainrotName or ""),
			AutoSelectBrainrotSlot = tonumber(_G.AutoSelectBrainrotSlot) or 0,
			QuickAP = _G.QuickAP,
			Aimbot = flag3,
			antiRagdollEnabled = flag2,
			RagdollBypass = _G.RagdollBypass,
			AntiGummy = _G.antiGummyEnabled,
			DropBrainrotEnabled = _G.DropBrainrotEnabled,
			ESPBaseEnabled = _G.ESPBaseEnabled,
			ESPBestEnabled = _G.ESPBestEnabled,
			AutoTurret = _G.AutoTurretEnabled,
			AutoReturnBase = _G.AutoReturnBase,
			FlashSpeed = _G.FlashSpeed,
			OrbitTravelMode = _G.OrbitTravelMode,
			OrbitGrappleSpeed = _G.OrbitGrappleSpeed,
			OrbitArrivalSpeed = _G.OrbitArrivalSpeed,
			TransportIndex = _G.TransportIndex,
			AntiSteal = _G.AntiSteal,
			QuickPickup = _G.QuickPickup,
			AntiStealMode = _G.AntiStealMode,
			AntiStealDelay = _G.AntiStealDelay,
			AntiStealAP = _G.AntiStealAP,
			dropPositionX = tbl3.X,
			dropPositionY = tbl3.Y,
			dropAutoOff = flag4,
	end)
end

local v7 = fn20()
_G.OrbitAutoSteal = v7.OrbitAutoSteal ~= false

for _, v8 in ipairs({ "ShowGiantPotion", "ShowFlashTeleport", "ShowFlyingCarpet" }) do
	if type(v7[v8]) == "boolean" then
		_G[v8] = v7[v8]
	end
end

if type(v7.QapPos) == "table" then
	local qapPos = v7.QapPos

	if type(qapPos.sx) == "number" and type(qapPos.ox) == "number" and type(qapPos.sy) == "number" and type(qapPos.oy) == "number" then
		_G.QapPos = UDim2.new(qapPos.sx, qapPos.ox, qapPos.sy, qapPos.oy)
	end
end

if v7.AutoResetOnBalloon ~= nil then
	_G.AutoResetOnBalloon = v7.AutoResetOnBalloon
end

if v7.AutoGiant ~= nil then
	_G.AutoGiant = v7.AutoGiant
end

if v7.AutoBlock ~= nil then
	_G.AutoBlock = v7.AutoBlock
end

if v7.BlockDelay ~= nil then
	_G.BlockDelay = v7.BlockDelay
end

if v7.APESPEnabled ~= nil then
	_G.APESPEnabled = v7.APESPEnabled
end

if v7.Aimbot ~= nil then
	flag3 = v7.Aimbot
end

if v7.antiRagdollEnabled ~= nil then
	flag2 = v7.antiRagdollEnabled
end

if v7.RagdollBypass ~= nil then
	_G.RagdollBypass = v7.RagdollBypass
end

if v7.ESPBaseEnabled ~= nil then
	_G.ESPBaseEnabled = v7.ESPBaseEnabled
end

if v7.ESPBestEnabled ~= nil then
	_G.ESPBestEnabled = v7.ESPBestEnabled
end

if v7.BackpackESP ~= nil then
	_G.BackpackESP = v7.BackpackESP
end

if v7.BrainrotHighlight ~= nil then
	_G.BrainrotHighlight = v7.BrainrotHighlight
end

if v7.FPSBoostEnabled ~= nil then
	_G.FPSBoostEnabled = v7.FPSBoostEnabled == true
end

if v7.AutoSelectBrainrot ~= nil then
	_G.AutoSelectBrainrot = v7.AutoSelectBrainrot == true
end

if v7.AutoSelectBrainrotName ~= nil then
	_G.AutoSelectBrainrotName = tostring(v7.AutoSelectBrainrotName)
end

if v7.AutoSelectBrainrotSlot ~= nil then
	_G.AutoSelectBrainrotSlot = tonumber(v7.AutoSelectBrainrotSlot) or 0
end

if v7.QuickAP ~= nil then
	_G.QuickAP = v7.QuickAP
end

if v7.AntiGummy ~= nil then
	_G.antiGummyEnabled = v7.AntiGummy
end

if v7.AutoTurret ~= nil then
	_G.AutoTurretEnabled = v7.AutoTurret
end

if v7.AutoReturnBase ~= nil then
	_G.AutoReturnBase = v7.AutoReturnBase
end

if v7.FlashSpeed ~= nil then
	_G.FlashSpeed = tonumber(v7.FlashSpeed) or 180
end

_G.OrbitArrivalSpeed = math.clamp(tonumber(v7.OrbitArrivalSpeed) or tonumber(_G.FlashSpeed) or 180, 20, 1000)
_G.OrbitTravelMode = v7.OrbitTravelMode == "Grapple" and "Grapple" or "Carpet"
_G.OrbitGrappleSpeed = math.clamp(tonumber(v7.OrbitGrappleSpeed) or 400, 100, 1000)
_G.FlashSpeed = math.clamp(tonumber(_G.FlashSpeed) or 180, 100, 1000)

if v7.TransportIndex ~= nil then
	_G.TransportIndex = tonumber(v7.TransportIndex) or 1
end

if v7.AntiSteal ~= nil then
	_G.AntiSteal = v7.AntiSteal
end

if v7.QuickPickup ~= nil then
	_G.QuickPickup = v7.QuickPickup
end

if _G.QuickPickup and _G._175_QuickPickup then
	task.defer(function()
		_G._175_QuickPickup.set(true)
	end)
end

if v7.AntiStealMode ~= nil then
	_G.AntiStealMode = v7.AntiStealMode
end

if v7.AntiStealDelay ~= nil then
	_G.AntiStealDelay = tonumber(v7.AntiStealDelay) or 1.8
end

if type(v7.AntiStealAP) == "table" then
	for k, v8 in pairs(v7.AntiStealAP) do
		_G.AntiStealAP[k] = v8
	end
end

if v7.dropPositionX ~= nil then
	tbl3.X = v7.dropPositionX
end

if v7.dropPositionY ~= nil then
	tbl3.Y = v7.dropPositionY
end

if v7.dropAutoOff ~= nil then
	flag4 = v7.dropAutoOff
end

if v7.DropBrainrotEnabled ~= nil then
	_G.DropBrainrotEnabled = v7.DropBrainrotEnabled

	if _G.DropBrainrotEnabled then
		task.spawn(function()
			fn13()
			flag7 = true
		end)
	end
end

local tbl5 = {}
local tbl6 = {}

local function fn21(arg)
	local character = arg.Character

	if character then
		local adminESP = character:FindFirstChild("AdminESP")

		if adminESP then
			pcall(function()
				adminESP:Destroy()
			end)
		end

		local adminTag = character:FindFirstChild("AdminTag")

		if adminTag then
			pcall(function()
				adminTag:Destroy()
			end)
		end

		local head = character:FindFirstChild("Head")

		if head then
			local adminTag2 = head:FindFirstChild("AdminTag")

			if adminTag2 then
				pcall(function()
					adminTag2:Destroy()
				end)
			end
		end
	end

	if tbl6[arg] then
		pcall(function()
			tbl6[arg]:Destroy()
		end)
	end

	tbl5[arg] = nil
	tbl6[arg] = nil
end

local function fn22(arg, arg2)
	local character = arg.Character
	if not character or arg == localPlayer then
		return
	end
	fn21(arg)
	if not arg2 then
		return
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Head")
	if not humanoidRootPart then
		return
	end
	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "AdminTag"
	billboardGui.Size = UDim2.new(0, 52, 0, 52)
	billboardGui.StudsOffset = Vector3.new(3.5, 7, 0)
	billboardGui.AlwaysOnTop = true
	billboardGui.Adornee = humanoidRootPart
	billboardGui.MaxDistance = 200
	billboardGui.Parent = character
	tbl6[arg] = billboardGui
	local imageLabel = Instance.new("ImageLabel")
	imageLabel.Size = UDim2.new(1, 0, 1, 0)
	imageLabel.BackgroundTransparency = 1
	imageLabel.Image = "rbxassetid://95529031547606"
	imageLabel.ScaleType = Enum.ScaleType.Fit
	imageLabel.Parent = billboardGui
end

local function fn23(arg)
	if not _G.APESPEnabled then
		return
	end

	if arg == localPlayer then
		return
	end

	if arg.Character then
		fn22(arg, arg:GetAttribute("AdminCommands") == true)
	else
		fn21(arg)
	end
end

local apEspConns = {}

local function fn24(arg)
	if arg == localPlayer then
		return
	end
	task.wait(0.5)
	fn23(arg)

	if apEspConns[arg] then
		for _, c in ipairs(apEspConns[arg]) do
			pcall(function() c:Disconnect() end)
		end
	end
	apEspConns[arg] = {}

	table.insert(apEspConns[arg], arg.CharacterAdded:Connect(function()
		task.wait(0.5)
		fn23(arg)
	end))

	table.insert(apEspConns[arg], arg:GetAttributeChangedSignal("AdminCommands"):Connect(function()
		fn23(arg)
	end))
end

local function fn25()
	for _, player in ipairs(Players:GetPlayers()) do
		fn24(player)
	end

	_G.APESPEnabled = true
end

local function fn26()
	_G.APESPEnabled = false

	for player, conns in pairs(apEspConns) do
		for _, c in ipairs(conns) do
			pcall(function() c:Disconnect() end)
		end
	end
	apEspConns = {}

	for _, player in ipairs(Players:GetPlayers()) do
		fn21(player)
	end

	for k in pairs(tbl5) do
		tbl5[k] = nil
	end

	for k in pairs(tbl6) do
		tbl6[k] = nil
	end
end

Players.ChildAdded:Connect(function(child)
	if child:IsA("Player") then
		task.wait(2)

		if _G.APESPEnabled then
			fn24(child)
		end
	end
end)

RunService.Heartbeat:Connect(function()
	if _G.APESPEnabled then
		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer and player.Character then
				local flag9 = player:GetAttribute("AdminCommands") == true
				local v8 = tbl5[player]

				if flag9 ~= (v8 and v8.FillColor == Color3.fromRGB(80, 157, 250)) then
					fn23(player)
				end
			end
		end
	end
end)

local character = localPlayer.Character
local humanoid = character and character:FindFirstChildOfClass("Humanoid")
local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
local currentCamera = Workspace.CurrentCamera

if not character then
	task.spawn(function()
		local character2 = localPlayer.Character or localPlayer.CharacterAdded:Wait()
		character = character2
		humanoid = character2:WaitForChild("Humanoid", 10)
		humanoidRootPart = character2:WaitForChild("HumanoidRootPart", 10)
		currentCamera = Workspace.CurrentCamera
	end)
end

local flag9 = false
local n2 = 0.3
local flag10 = false
local connection = nil
local prompt = nil
local slot = nil
local v8 = localPlayer
local resetCooldown = false
local startAntiRagdoll = nil

local function fn27(arg)
	local humanoid2 = arg:WaitForChild("Humanoid")
	local humanoidRootPart2 = arg:WaitForChild("HumanoidRootPart")
	local animator = humanoid2:FindFirstChildOfClass("Animator") or humanoid2:WaitForChild("Animator", 2)
	local vector = Vector3.zero
	local flag11 = false

	pcall(function()
		humanoid2:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		humanoid2:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		humanoid2:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
	end)

	local function fn28()
		local character2 = localPlayer.Character
		if not character2 then
			return false
		end

		for _, child in ipairs(character2:GetChildren()) do
			if child:IsA("Tool") then
				local str = child.Name:lower()
				if str:find("carpet") or str:find("fly") or str:find("cloud") or str:find("broom") or str:find("jet") or str:find("wing") or str:find("hover") or str:find("glider") or str:find("flying") then
					return true
				end
			end
		end

		return false
	end

	local function fn29()
		pcall(function()
			if resetCooldown then
				return
			end
			local currentCamera2 = workspace.CurrentCamera
			if not currentCamera2 then
				return
			end

			if currentCamera2.CameraType == Enum.CameraType.Scriptable then
				currentCamera2.CameraType = Enum.CameraType.Custom
			end

			local humanoid3 = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

			if humanoid3 then
				currentCamera2.CameraSubject = humanoid3
			end
		end)
	end

	local function fn30()
		local state = humanoid2:GetState()
		return state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.GettingUp
	end

	local function fn31()
		local now = tick()
		if now - n3 < 0.05 then
			return
		end
		n3 = now

		pcall(function()
			local attribute = localPlayer:GetAttribute("RagdollEndTime")

			if attribute and attribute - workspace:GetServerTimeNow() > 0 then
				localPlayer:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow())
			end
		end)

		for _, descendant in pairs(arg:GetDescendants()) do
			if descendant:IsA("BallSocketConstraint") or descendant:IsA("NoCollisionConstraint") or descendant:IsA("HingeConstraint") then
				pcall(function()
					descendant:Destroy()
				end)
			elseif descendant:IsA("Attachment") and (descendant.Name == "A" or descendant.Name == "B" or tostring(descendant.Name):find("Ragdoll")) then
				pcall(function()
					descendant:Destroy()
				end)
			elseif descendant:IsA("BodyVelocity") or descendant:IsA("BodyPosition") or descendant:IsA("BodyGyro") or descendant:IsA("LinearVelocity") and descendant.Name:lower():find("rag") then
				pcall(function()
					descendant:Destroy()
				end)
			elseif descendant:IsA("Motor6D") then
				descendant.Enabled = true
			end
		end

		if animator then
			for _, v9 in pairs(animator:GetPlayingAnimationTracks()) do
				local str = v9.Animation and v9.Animation.Name:lower() or ""

				if str:find("rag") or str:find("fall") or str:find("hurt") or str:find("down") then
					pcall(function()
						v9:Stop(0)
					end)
				end
			end
		end
	end

	local function fn32()
		pcall(function()
			local playerScripts = localPlayer:FindFirstChild("PlayerScripts")
			playerScripts = playerScripts and playerScripts:FindFirstChild("PlayerModule")

			if playerScripts then
				local ok, result = pcall(require, playerScripts)

				if ok and result and result.GetControls then
					result:GetControls():Enable()
				end
			end
		end)
	end

	local function fn33()
		if fn28() then
			return
		end
		humanoidRootPart2.Anchored = false

		pcall(function()
			humanoidRootPart2.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart2.AssemblyAngularVelocity = Vector3.zero
		end)

		for _, descendant in ipairs(arg:GetDescendants()) do
			if descendant:IsA("Motor6D") then
				descendant.Enabled = true
			end
		end

		pcall(function()
			humanoid2:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			humanoid2:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			humanoid2:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
		end)

		humanoid2.PlatformStand = false
		humanoid2.Sit = false

		if humanoid2.Health > 0 then
			humanoid2:ChangeState(Enum.HumanoidStateType.Running)
		end

		fn29()
		fn32()
	end

	local connection2 = humanoid2.StateChanged:Connect(function(old, new)
		if not flag2 then
			return
		end

		if fn28() then
			return
		end

		if fn30() or new == Enum.HumanoidStateType.Physics or new == Enum.HumanoidStateType.Ragdoll or new == Enum.HumanoidStateType.FallingDown then
			flag11 = true
			fn31()
			fn33()
		else
			flag11 = false
			fn29()
		end
	end)

	table.insert(tbl2, connection2)
	table.insert(tbl, connection2)

	local connection3 = humanoid2:GetPropertyChangedSignal("PlatformStand"):Connect(function()
		if not flag2 or fn28() then
			return
		end

		if humanoid2.PlatformStand then
			task.defer(function()
				if flag2 then
					fn33()
					fn31()
				end
			end)
		end
	end)

	table.insert(tbl2, connection3)
	table.insert(tbl, connection3)

	local connection4 = RunService.Heartbeat:Connect(function()
		if not flag2 then
			return
		end

		if fn28() then
			return
		end
		local attribute = localPlayer:GetAttribute("RagdollEndTime")

		if attribute and attribute - workspace:GetServerTimeNow() > 0 then
			flag11 = true

			pcall(function()
				localPlayer:SetAttribute("RagdollEndTime", workspace:GetServerTimeNow())
			end)
		end

		if fn30() or humanoid2.PlatformStand then
			flag11 = true
		end

		if flag11 then
			fn31()

			pcall(function()
				humanoid2.PlatformStand = false
				humanoid2.Sit = false

				if humanoidRootPart2 and humanoidRootPart2.Parent then
					humanoidRootPart2.Anchored = false
					local assemblyLinearVelocity = humanoidRootPart2.AssemblyLinearVelocity

					if (assemblyLinearVelocity - vector).Magnitude > 40 and assemblyLinearVelocity.Magnitude > 25 then
						humanoidRootPart2.AssemblyLinearVelocity = assemblyLinearVelocity.Unit * math.min(assemblyLinearVelocity.Magnitude, 18)
					end

					vector = humanoidRootPart2.AssemblyLinearVelocity
				end

				if humanoid2.Health > 0 and fn30() then
					humanoid2:ChangeState(Enum.HumanoidStateType.Running)
				end
			end)

			fn29()
			fn32()

			if not fn30() and not humanoid2.PlatformStand then
				flag11 = false
			end
		end
	end)

	table.insert(tbl2, connection4)
	table.insert(tbl, connection4)

	local connection5 = arg.DescendantAdded:Connect(function(descendant)
		if not flag2 or fn28() then
			return
		end

		if descendant:IsA("BallSocketConstraint") or descendant:IsA("NoCollisionConstraint") or descendant:IsA("HingeConstraint") or descendant:IsA("Attachment") and tostring(descendant.Name):find("Ragdoll") then
			task.defer(function()
				if flag2 and descendant.Parent then
					pcall(function()
						descendant:Destroy()
					end)
				end
			end)
		end
	end)

	table.insert(tbl2, connection5)
	table.insert(tbl, connection5)
	fn31()
	fn33()
end

startAntiRagdoll = function()
	for _, v9 in pairs(tbl2) do
		pcall(function()
			v9:Disconnect()
		end)
	end

	tbl2 = {}

	task.spawn(function()
		local character2 = v8.Character or v8.CharacterAdded:Wait()

		if character2 then
			fn27(character2)
		end
	end)
end

local function fn28()
	for _, v9 in pairs(tbl2) do
		pcall(function()
			v9:Disconnect()
		end)
	end

	tbl2 = {}

	pcall(function()
		local character2 = localPlayer.Character
		character2 = character2 and character2:FindFirstChildOfClass("Humanoid")

		if character2 then
			character2:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
			character2:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
			character2:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
		end
	end)
end

local connection2 = v8.CharacterAdded:Connect(function(character2)
	if not flag2 then
		return
	end

	for _, v9 in pairs(tbl2) do
		pcall(function()
			v9:Disconnect()
		end)
	end

	tbl2 = {}

	task.spawn(function()
		fn27(character2)
	end)
end)

table.insert(tbl, connection2)
local connection3 = nil
local connection4 = nil
local connection5 = nil

local fn29 = cloneref or function(arg)
	return arg
end

local fn30 = clonefunction or function(arg)
	return arg
end

local getconstants_ = debug and debug.getconstants or getconstants

local function fn31(arg)
	local n3 = arg or 100
	if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
		return nil
	end
	local position = localPlayer.Character.HumanoidRootPart.Position

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and player.Character then
			local humanoid2 = player.Character:FindFirstChildOfClass("Humanoid")
			local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart2 and humanoid2 and humanoid2.Health > 0 then
				local magnitude = (humanoidRootPart2.Position - position).Magnitude

				if magnitude < n3 then
					n3 = magnitude
					v11 = player
				end
			end
		end
	end

	return v11
end

local function fn32(arg)
	if not arg or not v9 or not v10 then
		return
	end
	local tbl7 = { arg.Position, arg }

	pcall(function()
		v10(v9, unpack(tbl7))
	end)
end

local function fn33(arg)
	if not arg or not v9 or not v10 then
		return
	end
	local character2 = localPlayer.Character
	local backpack = localPlayer:FindFirstChild("Backpack")
	backpack = backpack and backpack:FindFirstChild("Web Slinger") or character2 and character2:FindFirstChild("Web Slinger")

	if backpack and backpack:FindFirstChild("Handle") then
		local handle = backpack.Handle
		local tbl7 = { Vector3.new(arg.Position.X, arg.Position.Y, arg.Position.Z), arg, handle }

		pcall(function()
			v10(v9, unpack(tbl7))
		end)
	end
end

local function fn34()
	local character2 = localPlayer.Character
	local backpack = localPlayer:FindFirstChild("Backpack")
	backpack = backpack and backpack:FindFirstChild("Laser Cape") or character2 and character2:FindFirstChild("Laser Cape")
	if not backpack then
		return
	end

	if connection3 then
		pcall(function()
			connection3:Disconnect()
		end)
	end

	connection3 = backpack.Activated:Connect(function()
		if not flag3 then
			return
		end
		local v11 = fn31(100)

		if v11 and v11.Character then
			local humanoidRootPart2 = v11.Character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart2 then
				fn32(humanoidRootPart2)
			end
		end
	end)
end

local function fn35()
	local character2 = localPlayer.Character
	local backpack = localPlayer:FindFirstChild("Backpack")
	backpack = backpack and backpack:FindFirstChild("Web Slinger") or character2 and character2:FindFirstChild("Web Slinger")
	if not backpack then
		return
	end

	if connection4 then
		pcall(function()
			connection4:Disconnect()
		end)
	end

	connection4 = backpack.Activated:Connect(function()
		if not flag3 then
			return
		end
		local v11 = fn31(100)

		if v11 and v11.Character then
			local humanoidRootPart2 = v11.Character:FindFirstChild("HumanoidRootPart")

			if humanoidRootPart2 then
				fn33(humanoidRootPart2)
			end
		end
	end)
end

local function fn36()
	if flag3 then
		pcall(fn34)
		pcall(fn35)
	else
		if connection3 then
			pcall(function()
				connection3:Disconnect()
			end)

			connection3 = nil
		end

		if connection4 then
			pcall(function()
				connection4:Disconnect()
			end)

			connection4 = nil
		end
	end
end

task.spawn(function()
	local packages = ReplicatedStorage:WaitForChild("Packages", 30)
	if not packages then
		return
	end
	local net = packages:WaitForChild("Net", 30)
	if not net then
		return
	end

	while true do
		if not v9 and not flag then
			if getconnections and getconstants_ then
				local flag11 = false

				for _, child in ipairs(net:GetChildren()) do
					if child:IsA("RemoteEvent") then
						local ok, result = pcall(getconnections, child.OnClientEvent)

						if ok and type(result) == "table" then
							for _, v11 in ipairs(result) do
								if v11 and type(v11.Function) == "function" then
									local ok2, result2 = pcall(getconstants_, v11.Function)

									if ok2 and type(result2) == "table" then
										for _, v12 in ipairs(result2) do
											if v12 == "PaintballHitted" then
												v9 = fn29(child)
												v10 = fn30(v9.FireServer)
												flag11 = true
												break
											end
										end
									end
								end

								if not flag11 then
								end
								break
							end
						end
					end

					if not flag11 then
					end
					break
				end
			end

				fn36()
				break
			else
				task.wait(1)
			end
		end

		break
	end
end)

localPlayer.CharacterAdded:Connect(function(character2)
	task.wait(0.3)
	fn36()

	if character2 then
		character2.ChildAdded:Connect(function()
			task.wait(0.1)
			fn36()
		end)
	end
end)

if localPlayer.Character then
	localPlayer.Character.ChildAdded:Connect(function()
		task.wait(0.1)
		fn36()
	end)
end

if localPlayer.Backpack then
	connection5 = localPlayer.Backpack.ChildAdded:Connect(function()
		task.wait(0.1)
		fn36()
	end)

	table.insert(tbl, connection5)
end

local flag11 = false
local n3 = 0.4
local n4 = 50000
local flag12 = true
local n5 = 0.6
local n6 = 6
local flag13 = false

local function fn37(arg)
	if arg:IsA("BasePart") or arg:IsA("Decal") then
		arg.LocalTransparencyModifier = 1
	end
end

local function vampireInstaReset()
	if flag13 then
		return
	end
	local character2 = localPlayer.Character
	if not character2 or not character2.Parent then
		return
	end
	local humanoid2 = character2:FindFirstChildOfClass("Humanoid")
	if not humanoid2 or humanoid2.Health <= 0 then
		return
	end
	local rootPart = humanoid2.RootPart or character2:FindFirstChild("HumanoidRootPart")
	flag13 = true
	flag11 = true

	pcall(function()
		localPlayer:SetAttribute("Balloon", false)
		character2:SetAttribute("Balloon", false)
	end)

	task.spawn(function()
		local currentCamera2 = workspace.CurrentCamera
		local cFrame = currentCamera2 and currentCamera2.CFrame or CFrame.new()
		local cameraType = currentCamera2 and currentCamera2.CameraType or Enum.CameraType.Custom

		pcall(function()
			currentCamera2.CameraType = Enum.CameraType.Scriptable

			RunService:BindToRenderStep("175_FunnyHubInstaResetCam", Enum.RenderPriority.Camera.Value + 1, function()
				if currentCamera2 then
					currentCamera2.CFrame = cFrame
				end
			end)
		end)

		local connection6 = nil

		pcall(function()
			for _, descendant in ipairs(character2:GetDescendants()) do
				pcall(fn37, descendant)
			end

			connection6 = character2.DescendantAdded:Connect(function(descendant)
				pcall(fn37, descendant)
			end)
		end)

		local connection7 = localPlayer.CharacterAdded:Connect(function(character3)
			v11 = character3
		end)

		local function fn38()
			pcall(function()
				humanoid2.PlatformStand = false
			end)

			pcall(function()
				humanoid2.Sit = false
			end)

			pcall(function()
				humanoid2.AutoRotate = true
			end)
		end

		fn38()

		for _, descendant in ipairs(character2:GetDescendants()) do
			if descendant:IsA("BasePart") then
				pcall(function()
					descendant.Anchored = false
				end)

				pcall(function()
					descendant.CanCollide = false
				end)
			elseif descendant.Name == "SeatWeld" then
				pcall(function()
					descendant:Destroy()
				end)
			end
		end

		local now = os.clock()

		local function fn39()
			if rootPart and rootPart.Parent then
				return rootPart
			end
			rootPart = humanoid2.RootPart or character2:FindFirstChild("HumanoidRootPart")
			if rootPart and rootPart.Parent then
				return rootPart
			end
			return nil
		end

		local n7 = os.clock() + n3

		while not v11 and os.clock() < n7 and humanoid2.Parent do
			fn38()

			pcall(function()
				humanoid2.HipHeight = 1e30
			end)

			local v12 = fn39()

				pcall(function()
					v12.Anchored = false
				end)

				pcall(function()
					v12.AssemblyLinearVelocity = Vector3.new(0, 50000, 0)
				end)

				pcall(function()
					v12.Velocity = Vector3.new(0, 50000, 0)
				end)
			end

			RunService.Heartbeat:Wait()
		end

		local flag14 = true

		if flag12 then
			flag14 = not v11
		end

		if flag14 then
			local n8 = -500

			pcall(function()
				n8 = workspace.FallenPartsDestroyHeight
			end)

			local n9 = os.clock() + n5

			while true do
				if not v11 and os.clock() < n9 then
					local v12 = fn39()

						pcall(function()
							v12.CFrame = CFrame.new(0, n8 - 500, 0)
						end)

						pcall(function()
							v12.AssemblyLinearVelocity = Vector3.new(0, -n4, 0)
						end)

						RunService.Heartbeat:Wait()
					end
				end

				break
			end
		end

		while not v11 and os.clock() - now < n6 do
			if humanoid2.Parent then
				pcall(function()
					humanoid2.Health = 0
				end)

				pcall(function()
					humanoid2:ChangeState(Enum.HumanoidStateType.Dead)
				end)
			end

			if character2.Parent then
				pcall(function()
					character2:BreakJoints()
				end)
			end

			task.wait(0.1)
		end

		pcall(function()
			connection7:Disconnect()
		end)

		if connection6 then
			pcall(function()
				connection6:Disconnect()
			end)
		end

		pcall(function()
			RunService:UnbindFromRenderStep("175_FunnyHubInstaResetCam")
		end)

		pcall(function()
			if currentCamera2 then
				currentCamera2.CameraType = cameraType == Enum.CameraType.Scriptable and Enum.CameraType.Custom or cameraType

					local humanoid3 = v11:FindFirstChildOfClass("Humanoid") or v11:WaitForChild("Humanoid", 5)

					if humanoid3 then
						currentCamera2.CameraSubject = humanoid3
					end
				end
			end
		end)

		flag13 = false
		flag11 = false
	end)
end

local function fn38()
	pcall(vampireInstaReset)
end

_G.VampireInstaReset = vampireInstaReset
_G.ResetPlayer = vampireInstaReset
local connection6 = nil

connection6 = localPlayer:GetAttributeChangedSignal("Balloon"):Connect(function()
	if flag then
		pcall(function()
			connection6:Disconnect()
		end)

		return
	end

	if _G.AutoResetOnBalloon == true and localPlayer:GetAttribute("Balloon") == true then
		pcall(function()
			localPlayer:SetAttribute("Balloon", false)
			local character2 = localPlayer.Character

			if character2 then
				character2:SetAttribute("Balloon", false)
			end
		end)

		task.spawn(function()
			fn38()
		end)

		if _G.AutoGiant then
			task.spawn(function()
				task.wait(0.25)
				local function findTool(name)
					local char = localPlayer.Character
					local bp = localPlayer:FindFirstChildOfClass("Backpack")
					local n = string.lower(name)
					if char then
						for _, item in ipairs(char:GetChildren()) do
							if item:IsA("Tool") and string.find(string.lower(item.Name), n, 1, true) then
								return item
							end
						end
					end
					if bp then
						for _, item in ipairs(bp:GetChildren()) do
							if item:IsA("Tool") and string.find(string.lower(item.Name), n, 1, true) then
								return item
							end
						end
					end
					return nil
				end
				local v11 = findTool("giant potion")
				local character2 = localPlayer.Character
				character2 = character2 and character2:FindFirstChildOfClass("Humanoid")

				if v11 and character2 then
					character2:EquipTool(v11)
					task.wait(0.05)
					v11:Activate()
					task.wait(0.05)
					character2:UnequipTools()
				end
			end)
		end
	end
end)

table.insert(tbl, connection6)

local function fn39()
	local humanoid2 = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

	if humanoid2 then
		local connection7 = humanoid2.Died:Connect(function()
			if _G.AutoResetOnBalloon then
				task.spawn(function()
					fn38()
				end)
			end
		end)

		table.insert(tbl, connection7)
	end
end

localPlayer.CharacterAdded:Connect(function()
	task.wait(0.3)
	fn39()
end)

fn39()

localPlayer.CharacterAdded:Connect(function(character2)
	flag11 = false

	task.spawn(function()
		local humanoid2 = character2:WaitForChild("Humanoid", 5)
		local humanoidRootPart2 = character2:WaitForChild("HumanoidRootPart", 5)
		task.wait(0.05)

		pcall(function()
			localPlayer:SetAttribute("Balloon", false)
			character2:SetAttribute("Balloon", false)

			if humanoid2 then
				humanoid2.PlatformStand = false
				humanoid2.Sit = false
				humanoid2.HipHeight = 2
			end

			if humanoidRootPart2 then
				humanoidRootPart2.Anchored = false
				humanoidRootPart2.CanCollide = true
			end

			local currentCamera2 = workspace.CurrentCamera

			if currentCamera2 and humanoid2 then
				currentCamera2.CameraType = Enum.CameraType.Custom
				currentCamera2.CameraSubject = humanoid2
			end
		end)
	end)
end)

local function fn40(arg, arg2)
	if not getconnections then
		return
	end
	local v11 = getconnections(arg[arg2])

	for _, v12 in ipairs(v11) do
		if v12.Function then
			task.spawn(v12.Function)
		end
	end
end

local function fn41(arg)
	local flag14

	if flag10 then
		flag14 = v11
	else
		flag14 = not arg
	end

	if flag14 or not arg.Parent then
		return
	end
	flag10 = true
	local n7 = 0.1

	pcall(function()
		if arg.HoldDuration and arg.HoldDuration > 0 then
			n7 = math.clamp(arg.HoldDuration, 0.05, 1.5)
		else
			n7 = 0.3
		end
	end)

	pcall(function()
		if fireproximityprompt then
			fireproximityprompt(arg, n7)
		end
	end)

	pcall(function()
		fn40(arg, "PromptButtonHoldBegan")
	end)

	task.wait(n7)

	pcall(function()
		fn40(arg, "PromptButtonHoldEnded")
		fn40(arg, "Triggered")
	end)

	pcall(function()
		if fireproximityprompt and arg and arg.Parent and arg.Enabled then
			fireproximityprompt(arg)
		end
	end)

	task.wait(0.05)
	flag10 = false
end

local connection7 = localPlayer.CharacterAdded:Connect(function(character2)
	if connection then
		pcall(function()
			connection:Disconnect()
		end)

		connection = nil
	end

	if type(_G._OrbitCancelTravel) == "function" then
		_G._OrbitCancelTravel("Respawned.")
	end

	character = character2
	humanoid = character2:WaitForChild("Humanoid")
	humanoidRootPart = character2:WaitForChild("HumanoidRootPart")
	currentCamera = Workspace.CurrentCamera
	flag9 = false
	flag10 = false
	task.wait()

	if humanoidRootPart then
		local linearVelocity = humanoidRootPart:FindFirstChild("LinearVelocity")

		if linearVelocity then
			linearVelocity:Destroy()
		end

		local attachment = humanoidRootPart:FindFirstChild("Attachment")

		if attachment then
			attachment:Destroy()
		end
	end
end)

table.insert(tbl, connection7)

local tbl7 = {
		Positions = { Vector3.new(-345.4766, -6.0291, 1.5014) },
		CamOffset = Vector3.new(-354.1492, 4.035, 9.3823) - Vector3.new(-345.4766, -6.0291, 1.5014),
		CamAngles = { -0.8275, -0.6401, -0.576243 },
		Positions = { Vector3.new(-349.9259, -6.2791, -1.5767) },
		CamOffset = Vector3.new(-363.2081, 2.9403, 3.3074) - Vector3.new(-349.9259, -6.2791, -1.5767),
		CamAngles = { -1.007271, -0.967909, -0.916433 },
		Positions = { Vector3.new(-349.9259, -6.2791, -1.5758) },
		CamOffset = Vector3.new(-367.7556, 4.3232, 3.4983) - Vector3.new(-349.9259, -6.2791, -1.5758),
		CamAngles = { -1.062718, -1.0415, -0.997864 },
		Positions = { Vector3.new(-343.4199, -5.9197, 10.5505) },
		CamOffset = Vector3.new(-359.0885, 4.0544, 21.0001) - Vector3.new(-343.4199, -5.9197, 10.5505),
		CamAngles = { -0.681953, -0.861073, -0.551998 },
		Positions = { Vector3.new(-343.7608, -6.3272, -9.7994) },
		CamOffset = Vector3.new(-363.9226, -0.3924, -9.1459) - Vector3.new(-343.7608, -6.3272, -9.7994),
		CamAngles = { -1.424811, -1.351549, -1.421283 },
		Positions = { Vector3.new(-353.8207, -7.3018, 56.7123), Vector3.new(-317.9427, -7.002, 60.7723) },
		CamOffset = Vector3.new(-298.585, 3.3897424, 49.224636) - Vector3.new(-300.42212, -7.3018, 34.257305),
		CamAngles = { 0, 0.06, 0 },
		FixedCFrame = CFrame.new(-323.0857, -2.2188, 71.682) * CFrame.Angles(0, -0.44047141641185722, 0),
		Positions = { Vector3.new(-344.4383, -6.4281, 41.8672) },
		CamOffset = Vector3.new(-362.8094, -3.2299, 51.1552) - Vector3.new(-344.4383, -6.4281, 41.8672),
		CamAngles = { -0.181885, -1.095968, -0.162135 },
		Positions = { Vector3.new(-348.5228, -6.4281, 48.1022) },
		CamOffset = Vector3.new(-369.4075, -0.1123, 63.3763) - Vector3.new(-348.5228, -6.4281, 48.1022),
		CamAngles = { -0.30602, -0.916511, -0.245634 },
		Positions = { Vector3.new(-339.6349, -6.4281, 60.4164) },
		CamOffset = Vector3.new(-349.9293, -1.6218, 84.4119) - Vector3.new(-339.6349, -6.4281, 60.4164),
		CamAngles = { -0.137335, -0.401849, -0.054002 },
		Positions = { Vector3.new(-355.3322, -6.4281, 25.3526) },
		CamOffset = Vector3.new(-377.7117, 8.9106, 25.7208) - Vector3.new(-355.3322, -6.4281, 25.3526),
		CamAngles = { -1.544218, -1.016502, -1.53954 },
		Positions = { Vector3.new(-354.9932, -6.4281, -47.3879), Vector3.new(-331.5262, -6.4281, -47.3607) },
		CamOffset = Vector3.new(-333.2372, -9.9613, -64.2099) - Vector3.new(-331.5262, -6.4281, -47.3607),
		CamAngles = { 2.851853, -0.097011, 3.112724 },
		Positions = { Vector3.new(-354.9584, -6.4208, -42.652), Vector3.new(-338.729, -6.4281, -43.4713) },
		CamOffset = Vector3.new(-346.9807, -9.9578, -60.5865) - Vector3.new(-338.729, -6.4281, -43.4713),
		CamAngles = { 2.856299, -0.433315, 3.019061 },
		Positions = { Vector3.new(-354.8862, -6.2793, -37.9787), Vector3.new(-334.5183, -6.4281, -41.6819) },
		CamOffset = Vector3.new(-343.9747, -9.959, -57.3332) - Vector3.new(-334.5183, -6.4281, -41.6819),
		CamAngles = { 2.831168, -0.52207, 2.982964 },
		Positions = { Vector3.new(-351.8463, -6.5022, -37.0529), Vector3.new(-319.8298, -6.4281, -45.1476) },
		CamOffset = Vector3.new(-325.1408, -9.9618, -60.9837) - Vector3.new(-319.8298, -6.4281, -45.1476),
		CamAngles = { 2.834406, -0.309406, 3.045298 },
		Positions = { Vector3.new(-351.0894, -6.2833, -32.7751), Vector3.new(-317.917, -6.4281, -41.9999) },
		CamOffset = Vector3.new(-327.9996, -9.9581, -57.8876) - Vector3.new(-317.917, -6.4281, -41.9999),
		CamAngles = { 2.835549, -0.544183, 2.979445 },
		Positions = { Vector3.new(-338.2857, -6.4281, 57.206) },
		CamOffset = Vector3.new(-341.5551, -9.9642, 72.353) - Vector3.new(-338.2857, -6.4281, 57.206),
		CamAngles = { 0.320392, -0.202067, 0.066497 },
		Positions = { Vector3.new(-337.9285, -6.4281, 55.1757) },
		CamOffset = Vector3.new(-344.495, -9.9637, 69.4787) - Vector3.new(-337.9285, -6.4281, 55.1757),
		CamAngles = { 0.337895, -0.408747, 0.138758 },
		Positions = { Vector3.new(-332.1088, -6.4281, 53.1675) },
		CamOffset = Vector3.new(-338.829, -9.9674, 65.6692) - Vector3.new(-332.1088, -6.4281, 53.1675),
		CamAngles = { 0.382481, -0.462609, 0.177644 },
		Positions = { Vector3.new(-347.9923, -6.2933, -34.0232), Vector3.new(-328.579, -6.4281, -35.0857) },
		CamOffset = Vector3.new(-328.613, -10.0174, -40.4923) - Vector3.new(-328.579, -6.4281, -35.0857),
		CamAngles = { 2.387391, -0.004579, 3.137291 },
		Positions = { Vector3.new(-355.0801, -6.4404, -33.2302), Vector3.new(-321.5783, -6.4281, -33.5778) },
		CamOffset = Vector3.new(-321.6123, -10.0174, -38.9844) - Vector3.new(-321.5783, -6.4281, -33.5778),
		CamAngles = { 2.387391, -0.004579, 3.137291 },
		Positions = { Vector3.new(-351.5396, -7.5033, -41.797), Vector3.new(-314.088, -7.5033, -32.1806) },
		CamOffset = Vector3.new(-314.1147, -10.0174, -36.4214) - Vector3.new(-314.088, -7.5033, -32.1806),
		CamAngles = { 2.387391, -0.004579, 3.137291 },
		NeedJump = true,
		Positions = { Vector3.new(-351.5396, -7.5033, -41.797), Vector3.new(-306.8919, -7.5033, -33.9124) },
		CamOffset = Vector3.new(-306.923, -10.008, -38.86) - Vector3.new(-306.8919, -7.5033, -33.9124),
		CamAngles = { 2.4648, -0.004898, 3.137657 },
		NeedJump = true,
		Positions = { Vector3.new(-351.5396, -7.5033, -41.797), Vector3.new(-300.2759, -7.5033, -32.7047) },
		CamOffset = Vector3.new(-300.4669, -10.016, -37.044) - Vector3.new(-300.2759, -7.5033, -32.7047),
		CamAngles = { 2.399014, -0.032413, 3.111857 },
		NeedJump = true,
		Positions = { Vector3.new(-348.2407, -7.5033, 74.3719), Vector3.new(-330.0484, -7.5033, 48.183) },
		CamOffset = Vector3.new(-330.1124, -10.0063, 53.2779) - Vector3.new(-330.0484, -7.5033, 48.183),
		CamAngles = { 0.662308, -0.00991, 0.007727 },
		NeedJump = true,
		Positions = { Vector3.new(-348.2407, -7.5033, 74.3719), Vector3.new(-325.4576, -7.5033, 46.8182) },
		CamOffset = Vector3.new(-326.0541, -10.0104, 51.5397) - Vector3.new(-325.4576, -7.5033, 46.8182),
		CamAngles = { 0.700033, -0.09632, 0.080833 },
		NeedJump = true,
		Positions = { Vector3.new(-348.2407, -7.5033, 74.3719), Vector3.new(-324.6721, -7.5033, 47.2033) },
		CamOffset = Vector3.new(-326.6859, -10.0057, 51.9385) - Vector3.new(-324.6721, -7.5033, 47.2033),
		CamAngles = { 0.698024, -0.314979, 0.254268 },
		NeedJump = true,
		Positions = { Vector3.new(-348.2407, -7.5033, 74.3719), Vector3.new(-320.4196, -7.5033, 44.1) },
		CamOffset = Vector3.new(-322.9213, -10.0122, 49.5157) - Vector3.new(-320.4196, -7.5033, 44.1),
		CamAngles = { 0.876985, -0.422603, 0.397417 },

local function fn42(arg)
	local char = localPlayer.Character or character
	if not char then
		return nil
	end

	for _, child in ipairs(char:GetChildren()) do
		if child:IsA("Tool") and child.Name:lower():find(arg:lower(), 1, true) then
			return child
		end
	end

	local bp = localPlayer:FindFirstChildOfClass("Backpack")
	if bp then
		for _, child in ipairs(bp:GetChildren()) do
			if child:IsA("Tool") and child.Name:lower():find(arg:lower(), 1, true) then
				return child
			end
		end
	end

	return nil
end

local tbl8 = {

_G.TransportIndex = tonumber(_G.TransportIndex) or 1
_G.FlashSpeed = tonumber(_G.FlashSpeed) or 180

local function fn43()
	local character2 = localPlayer.Character or character
	local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid") or humanoid
	if not character2 or not humanoid2 then
		return false
	end
	local v11 = tbl8[math.clamp(tonumber(_G.TransportIndex) or 1, 1, #tbl8)]
	local carpet = nil

	local function fn44(arg, arg2)
		local v12 = string.lower(arg or "")
		local v13 = string.lower(arg2 or "")
		local pos = v12:find(v13, 1, true) or v13:find(v12, 1, true) or v12:find("carpet") and v13:find("carpet") or v12:find("wing") and v13:find("wing") or v12:find("broom") and v13:find("broom")
		local pos2

		if pos then
			pos2 = pos
		else
			pos2 = v12:find("waverider") and v13:find("waverider")
		end

		return pos2 or v12:find("sleigh") and v13:find("sleigh")
	end

	for _, child in ipairs(character2:GetChildren()) do
		if child:IsA("Tool") and fn44(child.Name, v11) then
			carpet = child
			break
		end
	end

	if not carpet then
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")

		if backpack then
			for _, child in ipairs(backpack:GetChildren()) do
				if child:IsA("Tool") and fn44(child.Name, v11) then
					carpet = child
					break
				end
			end
		end
	end

	if not carpet then
		for _, v12 in ipairs(tbl8) do
			local v13 = fn42(v12)

				carpet = v13
			else
				carpet = fn42(v12:match("^(%S+)") or v12)
			end

			if not carpet then
			end
			break
		end

		if not carpet then
			carpet = fn42("carpet") or fn42("broom") or fn42("wing")
		end
	end

	if not carpet then
		return false
	end

	pcall(function()
		humanoid2:UnequipTools()
		task.wait(0.03)
		humanoid2:EquipTool(carpet)
	end)

	task.wait(0.08)
	return carpet.Parent == character2
end

local function fn44(arg)
	if not arg then
		return false
	end
	local plotSign = arg:FindFirstChild("PlotSign")

	if plotSign then
		local yourBase = plotSign:FindFirstChild("YourBase")
		if yourBase and yourBase:IsA("BillboardGui") and yourBase.Enabled then
			return true
		end
	end

	return false
end

local tbl9 = {}
local connection8 = nil

local function createBillboardGui(parent, adornee)
	if tbl9[parent.Name] then
		tbl9[parent.Name]:Destroy()
	end

	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "rznnq" .. parent.Name
	billboardGui.Size = UDim2.new(0, 50, 0, 25)
	billboardGui.StudsOffset = Vector3.new(0, 5, 0)
	billboardGui.AlwaysOnTop = true
	billboardGui.Adornee = adornee
	billboardGui.MaxDistance = 1000
	billboardGui.Parent = parent
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.TextScaled = true
	textLabel.Font = Enum.Font.Arcade
	textLabel.TextColor3 = Color3.fromRGB(80, 157, 250)
	textLabel.TextStrokeTransparency = 0
	textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	textLabel.Parent = billboardGui
	tbl9[parent.Name] = billboardGui
	return billboardGui
end

local function fn45()
	for k, v11 in pairs(tbl9) do
			pcall(function()
				v11:Destroy()
			end)
		end

		tbl9[k] = nil
	end
end

local function fn46(arg)
	if not arg then
		return false
	end
	local attribute = arg:GetAttribute("Owner") or arg:GetAttribute("OwnerName") or arg:GetAttribute("Player")

	if type(attribute) == "string" and attribute ~= "" then
		for _, player in ipairs(Players:GetPlayers()) do
			if player.Name == attribute or player.DisplayName == attribute then
				return true
			end
		end
	elseif typeof(attribute) == "Instance" and attribute:IsA("Player") then
		return attribute.Parent ~= nil
	end

	local plotSign = arg:FindFirstChild("PlotSign")

	if plotSign then
		local tbl10 = {}

		for _, descendant in ipairs(plotSign:GetDescendants()) do
			if descendant:IsA("TextLabel") or descendant:IsA("TextBox") then
				local str = tostring(descendant.Text or "")

				if str ~= "" and str:lower() ~= "your base" and not str:find("empty") and not str:find("claim") then
					table.insert(tbl10, str)
				end
			end
		end

		for _, player in ipairs(Players:GetPlayers()) do
			if player == localPlayer then
			end
			local name = player.Name
			local displayName = player.DisplayName

			for _, v11 in ipairs(tbl10) do
				if v11 == name or v11 == displayName or v11:find(name, 1, true) or displayName and displayName ~= "" and v11:find(displayName, 1, true) then
					return true
				end
			end
		end
	end

	return false
end

local function fn47()
	local plots = Workspace:FindFirstChild("Plots")
	if not plots then
		return
	end

	for _, child in ipairs(plots:GetChildren()) do
		if fn44(child) or not fn46(child) then
			if tbl9[child.Name] then
				pcall(function()
					tbl9[child.Name]:Destroy()
				end)

				tbl9[child.Name] = nil
			end
		else
			local purchases = child:FindFirstChild("Purchases")
			purchases = purchases and purchases:FindFirstChild("PlotBlock")
			purchases = purchases and purchases:FindFirstChild("Main")
			local v11 = tbl9[child.Name]
			local remainingTime = purchases and purchases:FindFirstChild("BillboardGui") and purchases.BillboardGui:FindFirstChild("RemainingTime")

			if remainingTime and purchases then
				v11 = v11 or createBillboardGui(child, purchases)
				local textLabel = v11:FindFirstChildWhichIsA("TextLabel")

				if textLabel then
					textLabel.Text = remainingTime.Text
					textLabel.TextColor3 = Color3.fromRGB(80, 157, 250)
				end
				pcall(function()
					v11:Destroy()
				end)

				tbl9[child.Name] = nil
			end
		end
	end
end

local function fn48()
	if connection8 then
		return
	end
	_G.ESPBaseEnabled = true
	connection8 = RunService.RenderStepped:Connect(fn47)
end

local function fn49()
	_G.ESPBaseEnabled = false

	if connection8 then
		connection8:Disconnect()
		connection8 = nil
	end

	fn45()
end

local function fn50(arg)
	if not arg or not arg.Parent or not arg.Enabled then
		return false
	end
	local attr = tostring(arg:GetAttribute("State") or ""):lower():gsub("%s+", "")
	local action = tostring(arg.ActionText or ""):lower():gsub("%s+", "")
	if attr == "steal" or attr == "grab" or action:find("steal") or action:find("grab") then
		return true
	end
	return false
end

local function fn51()
	local tbl10 = { Pending = false, Token = 0, Status = "Ready" }
	local jobId = nil
	local tbl11 = nil

	local function fn52()
		local character2 = localPlayer.Character
		return character2, character2 and character2:FindFirstChildOfClass("Humanoid"), character2 and character2:FindFirstChild("HumanoidRootPart")
	end

	local function fn53(arg)
		local character2 = localPlayer.Character
		local backpack = localPlayer:FindFirstChildOfClass("Backpack")
		local v12 = character2 and character2:FindFirstChild(arg) or backpack and backpack:FindFirstChild(arg)
		return v12 and v12:IsA("Tool") and v12 or nil
	end

	local function fn54(arg)
		local children = arg:GetChildren()
		if #children < 8 then
			return nil
		end
		local tbl12 = {}
		local tbl13 = {}

		for _, child in ipairs(children) do
			local match, v12 = tostring(child.Name):match("^(R[EF])/(.+)$")

			if match and v12 and #v12 >= 32 and v12:match("^%x%x%x%x%x%x%x%x") then
				if match == "RE" then
					tbl12[v12] = child
				else
					tbl13[v12] = child
				end
			end
		end

		for k, v13 in pairs(tbl12) do
			if tbl13[k] then
				n7 += 1
				v12 = v13
			end
		end

		if n7 ~= 1 then
			return nil
		end

		for i, child in ipairs(children) do
			if child == v12 and i > 1 then
				local v13 = children[i - 1]
				if v13:IsA("RemoteEvent") then
					return v13
				end
			end
		end

		return nil
	end

	task.spawn(function()
		local now = os.clock()

		while not flag and os.clock() - now < 60 do
			local packages = ReplicatedStorage:FindFirstChild("Packages")
			packages = packages and packages:FindFirstChild("Net")

			if packages then
				local v12 = fn54(packages)

					v11 = v12
					jobId = game.JobId
					return
				end
			end

			task.wait(1)
		end
	end)

	local function fn55(arg, arg2, arg3)
		local vector = Vector3.new(arg2.X - arg.Position.X, 0, arg2.Z - arg.Position.Z)
		if vector.Magnitude < 1 then
			return nil
		end
		local unit = vector.Unit
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { arg3 }

		local function fn56(arg4)
			if not arg4 then
				return
			end
			local n7 = arg4.Position - arg.Position
			local vector2 = Vector3.new(n7.X, 0, n7.Z)
			local magnitude = n7.Magnitude

			if magnitude >= 10 and magnitude <= 50 and vector2.Magnitude > 0.01 and vector2.Unit:Dot(unit) > 0 and (not v13 or magnitude < v13) then
				v12 = arg4
				v13 = magnitude
			end
		end

		for _, v14 in ipairs({ 9, 10, 11, 12, 13, 14, 16, 18, 21, 24, 28, 32, 36, 40, 45 }) do
			fn56(Workspace:Raycast(arg.Position + unit * v14 + Vector3.new(0, 3, 0), Vector3.new(0, -60, 0), raycastParams))
		end

		if not v12 then
			for _, v14 in ipairs({ 11, 14, 18, 24, 32, 42, 48 }) do
				fn56(Workspace:Raycast(arg.Position, unit * v14, raycastParams))
			end
		end

		return v12
	end

	local function fn56(arg, arg2, arg3, arg4)
		if not v11 or not v11.Parent or jobId ~= game.JobId then
			return false, "Grapple is not ready yet."
		end

		if localPlayer:GetAttribute("Stealing") then
			return false, "Grapple is unavailable while carrying a brainrot."
		end

		if (tonumber(arg:GetAttribute("CooldownTime")) or 0) > 0 then
			return false, "Grapple is on cooldown."
		end
		local v12 = fn55(arg4, arg2, arg3)
		if not v12 then
			return false, "No grapple surface found toward this route."
		end

		if not tbl11 then
			tbl11 = {}
			local tbl12 = {}

			local function fn57(arg5)
				if type(arg5) == "table" and not tbl12[arg5] then
					tbl12[arg5] = true
					table.insert(tbl11, arg5)
				end
			end

			pcall(function()
				fn57(require(ReplicatedStorage.Packages.PlayerMouse))
			end)

			pcall(function()
				if not getgc then
					return
				end

				for _, v13 in ipairs(getgc(true)) do
					if type(v13) == "table" and typeof(rawget(v13, "Hit")) == "CFrame" then

						for k in pairs(v13) do
							n7 += 1
						end

						if n7 <= 3 then
							fn57(v13)
						end
					end
				end
			end)
		end

		local cframe = CFrame.new(v12.Position)
		local tbl12 = {}

		for i, v13 in ipairs(tbl11) do
			tbl12[i] = { rawget(v13, "Hit"), v14(v13, "Target") }

			pcall(function()
				v13.Hit = cframe
				v13.Target = v12.Instance
			end)
		end

		local currentCamera2 = Workspace.CurrentCamera
		local cFrame = currentCamera2 and currentCamera2.CFrame
		local cFrame2 = nil

		pcall(function()
			if not currentCamera2 then
				return
			end
			local mouseLocation = UserInputService:GetMouseLocation()
			local unit = currentCamera2.CFrame:VectorToObjectSpace(currentCamera2:ViewportPointToRay(mouseLocation.X, mouseLocation.Y).Direction).Unit
			local n7 = v12.Position - currentCamera2.CFrame.Position

			if n7.Magnitude > 0.01 then
				cFrame2 = CFrame.new(currentCamera2.CFrame.Position) * CFrame.lookAt(Vector3.zero, n7.Unit) * CFrame.lookAt(Vector3.zero, unit):Inverse()
				currentCamera2.CFrame = cFrame2
			end
		end)

		local ok = pcall(function()
			v11:FireServer((v12.Position - arg4.Position).Magnitude / 120, v12.Position)
		end)

		task.spawn(function()
			for i = 1, 4 do
				if not flag then
					if currentCamera2 and cFrame2 then
						currentCamera2.CFrame = cFrame2
					end

					for _, v13 in ipairs(tbl11) do
						pcall(function()
							v13.Hit = cframe
							v13.Target = v12.Instance
						end)
					end

					RunService.Heartbeat:Wait()
				end

				break
			end

			if currentCamera2 and cFrame then
				pcall(function()
					currentCamera2.CFrame = cFrame
				end)
			end

			for i, v13 in ipairs(tbl11) do
				pcall(function()
					v13.Hit = tbl12[i][1]
					v13.Target = tbl12[i][2]
				end)
			end
		end)

		return ok, ok and nil or "Grapple activation failed."
	end

	tbl10.CarpetSeconds = function(arg, arg2)
		if arg <= 5 then
			return 0
		end
		local log = math.log
		return (math.max(0, arg - 20) + 20 * log(math.min(arg, 20) / 5)) / arg2
	end

	tbl10.RouteSeconds = function(arg, arg2, arg3, arg4)

		for _, v12 in ipairs(arg2) do
			local n8 = v12 - arg

			if arg4 == "Grapple" then
				n7 += math.max(math.max(0, n8.Magnitude - 3) / arg3, math.max(0, n8.Y - 3) / 60)
				arg = v12
			else
				n7 += tbl10.CarpetSeconds(Vector3.new(n8.X, 0, n8.Z).Magnitude, arg3)
				arg = v12
			end
		end

		return n7
	end

	tbl10.Cancel = function(status)
		tbl10.Token = tbl10.Token + 1
		tbl10.Pending = false

		if tbl10.Velocity then
			tbl10.Velocity:Destroy()
			tbl10.Velocity = nil
		end

		if tbl10.Attachment then
			tbl10.Attachment:Destroy()
			tbl10.Attachment = nil
		end

		if tbl10.Root and tbl10.Root.Parent then
			tbl10.Root.AssemblyLinearVelocity = Vector3.zero
			tbl10.Root.AssemblyAngularVelocity = Vector3.zero
		end

		tbl10.Root = nil

		if status then
			tbl10.Status = status
		end
	end

	tbl10.Begin = function(arg, arg2)
		tbl10.Cancel()
		local token = tbl10.Token
		local v12, v13, v14 = fn52()
		if not v12 or not v13 or not v14 or v13.Health <= 0 then
			return nil
		end
		local str = _G.OrbitTravelMode == "Grapple" and "Grapple" or "Carpet"
		local n7 = math.clamp(tonumber(str == "Grapple" and _G.OrbitGrappleSpeed or _G.FlashSpeed) or 180, 100, 1000)
		local n8 = math.clamp(tonumber(_G.OrbitArrivalSpeed) or 180, 20, 1000)
		local n9 = os.clock() + 0.11 + tbl10.RouteSeconds(v14.Position, arg, n8, "Carpet")
		local grappleHook = str == "Grapple" and fn53("Grapple Hook")
		if str == "Grapple" and not grappleHook then
			tbl10.Status = "Grapple Hook is missing."
			return nil
		end

		if str == "Grapple" and (not v11 or not v11.Parent) then
			tbl10.Status = "Grapple is not ready yet. Try again shortly."
			return nil
		end
		tbl10.Pending = true

		local function fn57()
			return token == tbl10.Token and not flag and localPlayer.Character == v12 and v14.Parent and v13.Health > 0 and arg2 and arg2.Parent
		end

		local function fn58(status)
			if token == tbl10.Token then
				tbl10.Pending = false
				tbl10.Status = status
			end

			if v14.Parent then
				v14.AssemblyLinearVelocity = Vector3.zero
				v14.AssemblyAngularVelocity = Vector3.zero
			end

			return nil
		end

		local n10 = str == "Grapple" and 0.27 or 0.11
		local v15 = tbl10.RouteSeconds(v14.Position, arg, n7, str)
		local n11 = math.max(0, n9 - os.clock() - n10 - v15)
		local n12 = os.clock() + n11

		while os.clock() < n12 do
			if not fn57() then
				return (fn58("Travel cancelled."))
			end
			v14.AssemblyLinearVelocity = Vector3.zero
			tbl10.Status = string.format("%s · starts in %.2fs", str, n12 - os.clock())
			RunService.Heartbeat:Wait()
		end

		if not fn57() then
			return (fn58("Travel cancelled."))
		end

		if str == "Grapple" then
			v13:EquipTool(grappleHook)
			local n13 = os.clock() + 0.5

			while grappleHook.Parent ~= v12 and os.clock() < n13 do
				if not fn57() then
					return (fn58("Travel cancelled."))
				end
				RunService.Heartbeat:Wait()
			end

			if grappleHook.Parent ~= v12 then
				return (fn58("Could not equip Grapple Hook."))
			end
			local v16, v17 = fn56(grappleHook, arg[1], v12, v14)
			if not v16 then
				return (fn58(v17))
			end
			task.wait(0.08)
			if not fn57() then
				return (fn58("Travel cancelled."))
			end
			v13:UnequipTools()
			task.wait(0.08)
		end

		if not fn57() then
			return (fn58("Travel cancelled."))
		end
		local v16 = fn43()
		if not fn57() then
			return (fn58("Travel cancelled."))
		end

		if not v16 then
			return (fn58("A carpet or selected flying transport is required."))
		end

		local function fn59()
			local tbl12 = {}
			if str ~= "Grapple" then
				return tbl12
			end
			local position = v14.Position
			local raycastParams = RaycastParams.new()
			raycastParams.FilterType = Enum.RaycastFilterType.Exclude
			local filterDescendantsInstances = {}

			for _, player in ipairs(Players:GetPlayers()) do
				if player.Character then
					table.insert(filterDescendantsInstances, player.Character)
				end
			end

			raycastParams.FilterDescendantsInstances = filterDescendantsInstances

			for i = 1, 3 do
				local vector = Vector3.new(arg[1].X - position.X, 0, arg[1].Z - position.Z)

				if not (vector.Magnitude < 1) then
					local n13 = position + vector.Unit * math.min(20, vector.Magnitude)
					local hit = Workspace:Raycast(position, n13 - position, raycastParams)

					if not (hit and hit.Instance.CanCollide) then
						table.insert(tbl12, n13)
						position = n13
					end
				end

				break
			end

			return tbl12
		end

		local v17 = fn59()
		local n13 = n9 - tbl10.RouteSeconds(v17[#v17] or v14.Position, arg, n7, str) + #v17 / 60

		while os.clock() < n13 do
			if not fn57() then
				return (fn58("Travel cancelled."))
			end
			v14.AssemblyLinearVelocity = Vector3.zero
			tbl10.Status = string.format("%s · starts in %.2fs", str, n13 - os.clock())
			RunService.Heartbeat:Wait()
		end

		if not fn57() then
			return (fn58("Travel cancelled."))
		end

		if str == "Grapple" then
			local v18 = fn59()

			for _, v19 in ipairs(v18) do
				if not fn57() then
					return (fn58("Travel cancelled."))
				end
				v14.CFrame = v14.CFrame - v14.Position + v19
				v14.AssemblyLinearVelocity = Vector3.zero
				v14.AssemblyAngularVelocity = Vector3.zero
				RunService.Heartbeat:Wait()
			end
		end

		if not fn57() then
			return (fn58("Travel cancelled."))
		end
		tbl10.Pending = false
		tbl10.Status = string.format("%s · %d speed", str, n7)
		local routeSeconds = tbl10.RouteSeconds
		local position = v14.Position

		return {
			Mode = str,
			Speed = n7,
			Deadline = n9,
			Root = v14,
			Character = v12,
			Token = token,
			Timeout = os.clock() + routeSeconds(position, arg, math.min(n7, 200), str) + 3,
	end

	_G._OrbitCancelTravel = tbl10.Cancel
	return tbl10
end

local v11 = fn51()
local n7 = 20

local function fn52(arg, arg2)
	local v12 = tbl7[arg2] or tbl7[1]
	local positions = v12.Positions or { v12.Position }
	local flag14 = v12.NeedJump == true

	if arg2 >= 19 and arg2 <= 27 then
		flag14 = true
	end

	if connection then
		pcall(function()
			connection:Disconnect()
		end)

		connection = nil
	end

	if not humanoidRootPart or not humanoid then
		return
	end
	flag9 = true

	if _G.AutoReturnBase then
		task.spawn(function()
			local n8 = tick() + 12

			while tick() < n8 and not flag do
				local flag15 = false

				pcall(function()
					flag15 = localPlayer:GetAttribute("Stealing") == true or localPlayer:GetAttribute("IsStealing") == true
				end)

				if flag15 then
					local flag16 = false

					pcall(function()
						local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
						if not humanoidRootPart2 then
							return
						end
						local plots = Workspace:FindFirstChild("Plots")

						if plots then
							for _, child in ipairs(plots:GetChildren()) do
								local plotSign = child:FindFirstChild("PlotSign")
								local yourBase = plotSign and plotSign:FindFirstChild("YourBase")

								if yourBase and yourBase.Enabled then
									local ok, result = pcall(function()
										return child:GetPivot().Position
									end)

									if ok and result and (humanoidRootPart2.Position - result).Magnitude < 90 then
										flag16 = true
									end
								end
							end
						end
					end)

					if not flag16 then
						if connection then
							pcall(function()
								connection:Disconnect()
							end)
							connection = nil
						end

						flag9 = false
						if v11 and v11.Cancel then
							v11.Cancel("Returning to base.")
						end
						if type(_G._175_StartReturnBase) == "function" then
							pcall(_G._175_StartReturnBase)
						end

						return
					end
				end

				task.wait(0.05)
			end
		end)
	end

	local ok, result = pcall(v11.Begin, positions, arg)

	if not ok or not result then
		if not ok then
			v11.Cancel("Travel could not start.")
		end

		flag9 = false
		return
	end

	local speed = result.Speed
	local n8 = 70
	local flag15 = false

	if humanoidRootPart:FindFirstChild("LinearVelocity") then
		humanoidRootPart.LinearVelocity:Destroy()
	end

	if humanoidRootPart:FindFirstChild("Attachment") then
		humanoidRootPart.Attachment:Destroy()
	end

	local attachment = Instance.new("Attachment")
	attachment.Parent = humanoidRootPart
	local linearVelocity = Instance.new("LinearVelocity")
	linearVelocity.Attachment0 = attachment
	linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
	linearVelocity.MaxForce = math.huge
	linearVelocity.Parent = humanoidRootPart
	v11.Velocity = linearVelocity
	v11.Attachment = attachment
	v11.Root = humanoidRootPart
	local n9 = 1
	local flag16 = false

	local function fn53(arg3)
		linearVelocity:Destroy()
		attachment:Destroy()

		if result.Root and result.Root.Parent then
			result.Root.AssemblyLinearVelocity = Vector3.zero
			result.Root.AssemblyAngularVelocity = Vector3.zero
		end

		if connection then
			connection:Disconnect()
			connection = nil
		end

		v11.Cancel(arg3)
		flag9 = false
	end

		if flag or v11.Token ~= result.Token or humanoidRootPart ~= result.Root or localPlayer.Character ~= result.Character or not humanoidRootPart or not humanoid or not humanoidRootPart.Parent or humanoid.Health <= 0 or not arg or not arg.Parent then
			fn53("Travel cancelled.")
			return
		end
		local timeout = result.Timeout
		if os.clock() > timeout then
			fn53("Approach timed out.")
			return
		end

		if flag16 then
			linearVelocity.VectorVelocity = Vector3.zero
			return
		end
		local v13 = positions[n9]
		if not v13 then
			return
		end
		local position = humanoidRootPart.Position
		local vector = result.Mode == "Grapple" and v13 - position or Vector3.new(v13.X - position.X, 0, v13.Z - position.Z)
		local magnitude = vector.Magnitude
		local v14 = positions[#positions]
		local magnitude2 = Vector3.new(v14.X - position.X, 0, v14.Z - position.Z).Magnitude

		if _G.OrbitAutoSteal ~= false and magnitude2 <= n8 and not flag15 then
			flag15 = true

			task.spawn(function()
				for i = 1, 10 do
					local flag17

					if flag then
						flag17 = v15
					else
						flag17 = _G.OrbitAutoSteal == false
					end

					flag17 = flag17 or not arg or not arg.Parent

					if not flag17 then
						if not flag10 then
							fn41(arg)
						end

						task.wait(0.4)
					end

					break
				end
			end)
		end

		local flag17 = result.Mode == "Carpet" and magnitude < n7
		local n10 = 1

		if flag17 then
			n10 = math.max(0.15, magnitude / n7)
		end

		if magnitude <= (result.Mode == "Grapple" and 3 or 5) then
			if n9 < #positions then
				flag16 = true
				linearVelocity.VectorVelocity = Vector3.zero
				humanoidRootPart.AssemblyLinearVelocity = Vector3.zero

				task.spawn(function()
					n9 += 1
					flag16 = false
				end)

				return
			end

			linearVelocity.VectorVelocity = Vector3.zero
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			local deadline = result.Deadline
			if os.clock() < deadline then
				return
			end
			v11.Status = "Arrived."
			v11.Velocity = nil
			v11.Attachment = nil
			v11.Root = nil
			linearVelocity:Destroy()
			attachment:Destroy()
			humanoidRootPart.CFrame = CFrame.new(v13)

			if connection then
				pcall(function()
					connection:Disconnect()
				end)

				connection = nil
			end

			task.wait(0.1)
			currentCamera.CameraType = Enum.CameraType.Scriptable

			if v12.FixedCFrame then
				currentCamera.CFrame = v12.FixedCFrame
			else
				currentCamera.CFrame = CFrame.new(humanoidRootPart.Position + v12.CamOffset) * CFrame.Angles(unpack(v12.CamAngles))
			end

			humanoid:UnequipTools()
			task.wait(0.05)

			if flag14 then
				humanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 55, 0)
				task.wait(0.06)
			end

			local flash = fn42("flash")

			if flash then
				humanoid:EquipTool(flash)
				task.wait(0.06)
				flash:Activate()

				if arg2 == 6 then
					pcall(function()
						workspace.CurrentCamera.CFrame = CFrame.new(-299.38, -3.06, 29.14, 0.914, -0.035, 0.405, 0, 0.996, 0.086, -0.407, -0.078, 0.91)
					end)
				end
			end

			task.wait(0.08)

			if _G.AutoGiant then
				local v15 = fn42("giant potion")

					humanoid:EquipTool(v15)
					task.wait(0.08)
					v15:Activate()

					if _G.RagdollBypass then
						task.spawn(function()
							task.wait(0.35)

							pcall(function()
								local adminPanel = playerGui:FindFirstChild("AdminPanel")
								local adminPanel2 = adminPanel and adminPanel:FindFirstChild("AdminPanel")
								adminPanel2 = adminPanel2 and adminPanel2:FindFirstChild("CommandBox")
								adminPanel2 = adminPanel2 and adminPanel2:FindFirstChild("TextBox")

								if adminPanel2 then
									local visible = adminPanel2.Visible
									adminPanel2.Visible = false
									adminPanel2.Text = ";ragdoll " .. localPlayer.Name
									task.wait(0.04)

									if firesignal then
										pcall(firesignal, adminPanel2.FocusLost, true)
									elseif getconnections then
										for _, v16 in pairs(getconnections(adminPanel2.FocusLost)) do
											pcall(function()
												v16:Fire(true)
											end)
										end
									end

									task.wait(0.04)
									adminPanel2.Text = ""
									adminPanel2.Visible = visible
								end
							end)
						end)
					end

					task.wait(0.05)
					humanoid:UnequipTools()
				end
			end

			currentCamera.CameraType = Enum.CameraType.Custom

			if _G.AutoBlock then
				task.spawn(function()
					task.wait(0.15)
					fn9()
				end)
			end

			task.spawn(function()
				task.wait(1)
				flag9 = false
			end)

			return
		end

		if result.Mode == "Grapple" then
			if vector.Y > 5 and n9 < #positions then
				local state = humanoid:GetState()

				if state ~= Enum.HumanoidStateType.Jumping and state ~= Enum.HumanoidStateType.Freefall then
					pcall(function()
						humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						humanoid.Jump = true
					end)
				end
			end

			local n12 = vector.Unit.Z * n11
			local vector2 = Vector3.new(vector.Unit.X * n11, math.min(60, vector.Unit.Y * n11), n12)
			linearVelocity.VectorVelocity = vector2
			humanoidRootPart.AssemblyLinearVelocity = vector2
		else
			linearVelocity.VectorVelocity = Vector3.new(vector.Unit.X * n11, 0, vector.Unit.Z * n11)
		end
	end)

	table.insert(tbl, connection)
end

local tbl10 = {}
local fn53 = nil

fn53 = function()
	if flag then
		return
	end

	if not v12 then
		return
	end
	local plots = Workspace:FindFirstChild("Plots")
	if not plots then
		return
	end
	local tbl11 = {}

	for _, child in ipairs(plots:GetChildren()) do
		if not fn44(child) then
			local animalPodiums = child:FindFirstChild("AnimalPodiums")

			if animalPodiums then
				for _, child2 in ipairs(animalPodiums:GetChildren()) do
					local n8 = tonumber(child2.Name:match("%d+")) or 1
					local spawn = (child2:FindFirstChild("Base") or child2):FindFirstChild("Spawn")
					local promptAttachment = spawn and spawn:FindFirstChild("PromptAttachment")

					if promptAttachment then
						for _, child3 in ipairs(promptAttachment:GetChildren()) do
							if child3:IsA("ProximityPrompt") and fn50(child3) then
								local str = tostring(child3.ObjectText or "Pet"):gsub("%s*%[.-%]%s*", ""):gsub("^%s+", ""):gsub("%s+$", "")
								local worldPosition = nil

								pcall(function()
									if promptAttachment:IsA("Attachment") then
										worldPosition = promptAttachment.WorldPosition
									elseif spawn and spawn:IsA("BasePart") then
										worldPosition = spawn.Position
									end
								end)

								table.insert(tbl11, {
									prompt = child3,
									slot = n8,
									name = str,
									plot = child,
									podium = child2,
									spawnPos = worldPosition,
							end
						end
					end
				end
			end
		end
	end

	table.sort(tbl11, function(arg, arg2)
		return arg.slot < arg2.slot
	end)

	tbl10 = {}

	for _, v13 in ipairs(tbl11) do
		tbl10[tostring(v13.plot.Name) .. "_" .. tostring(v13.slot) .. "_" .. tostring(v13.name)] = v13
	end

	if _G.AutoSelectBrainrot and type(_G.AutoSelectBrainrotName) == "string" and _G.AutoSelectBrainrotName ~= "" then
		local str = tostring(_G.AutoSelectBrainrotName):lower():gsub("^%s+", ""):gsub("%s+$", "")
		local n8 = tonumber(_G.AutoSelectBrainrotSlot) or 0
		local prompt2 = nil
		local slot2 = nil

		for _, v13 in ipairs(tbl11) do
			local str2 = tostring(v13.name or ""):lower()

			if str2 == str or str ~= "" and (str2:find(str, 1, true) or str:find(str2, 1, true)) then
				if n8 > 0 and v13.slot == n8 then
					prompt2 = v13.prompt
					slot2 = v13.slot
					break
				elseif not prompt2 then
					prompt2 = v13.prompt
					slot2 = v13.slot
				end
			end
		end

		if prompt2 then
			if not (prompt and prompt.Parent and prompt == prompt2) then
				prompt = prompt2
				slot = slot2
			end
		end
	elseif prompt and not prompt.Parent then
		prompt = nil
	end

	local tbl12 = {
		card = Color3.fromRGB(31, 31, 31),
		accent = Color3.fromRGB(131, 131, 131),
		stroke = Color3.fromRGB(63, 63, 63),
		bright = Color3.fromRGB(255, 255, 255),
		mute = Color3.fromRGB(176, 176, 176),

	local tbl13 = {}

	for _, v13 in ipairs(tbl11) do
		tbl13[tostring(v13.plot.Name) .. "_" .. tostring(v13.slot) .. "_" .. tostring(v13.name)] = v13
	end

	for _, child in ipairs(v12:GetChildren()) do
		if child:IsA("Frame") then
			if child.Name == "EmptyCard" then
				child:Destroy()
			elseif not tbl13[child.Name] then
				child:Destroy()
			end
		end
	end

	if #tbl11 == 0 then
		return
	end

	for i, v13 in ipairs(tbl11) do
		if not flag then
			local name = tostring(v13.plot.Name) .. "_" .. tostring(v13.slot) .. "_" .. tostring(v13.name)
			local flag14 = prompt == v13.prompt
			local v14 = v12:FindFirstChild(name)

				v14.BackgroundColor3 = flag14 and Color3.fromRGB(46, 46, 46) or tbl12.card
				local uiStroke = v14:FindFirstChildOfClass("UIStroke")

				if uiStroke then
					uiStroke.Color = flag14 and tbl12.accent or tbl12.stroke
					uiStroke.Thickness = flag14 and 1.5 or 1
				end

				v14.LayoutOrder = i
				v14:SetAttribute("SlotNum", v13.slot)
				v14:SetAttribute("PetName", v13.name)
			else
				local frame = Instance.new("Frame")
				frame.Name = name
				frame:SetAttribute("PetName", v13.name)
				frame:SetAttribute("SlotNum", v13.slot)
				frame.Size = UDim2.new(1, -6, 0, 74)
				frame.BackgroundColor3 = flag14 and Color3.fromRGB(46, 46, 46) or tbl12.card
				frame.BorderSizePixel = 0
				frame.LayoutOrder = i
				frame.Parent = v12
				Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
				local uiStroke = Instance.new("UIStroke")
				uiStroke.Color = flag14 and tbl12.accent or tbl12.stroke
				uiStroke.Thickness = flag14 and 1.5 or 1
				uiStroke.Parent = frame
				local viewportFrame = Instance.new("ViewportFrame")
				viewportFrame.Size = UDim2.new(0, 58, 0, 58)
				viewportFrame.Position = UDim2.new(0, 10, 0.5, -29)
				viewportFrame.BackgroundTransparency = 1
				viewportFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				viewportFrame.BorderSizePixel = 0
				viewportFrame.ZIndex = 5
				viewportFrame.Ambient = Color3.fromRGB(200, 200, 200)
				viewportFrame.LightColor = Color3.fromRGB(255, 255, 255)
				viewportFrame.LightDirection = Vector3.new(-1, -1, -1)
				viewportFrame.Parent = frame
				local camera = Instance.new("Camera")
				camera.Parent = viewportFrame
				viewportFrame.CurrentCamera = camera
				local name2 = v13.name
				local spawnPos = v13.spawnPos
				local plot = v13.plot

				task.spawn(function()
					local tbl14 = {}

					for _, player in pairs(Players:GetPlayers()) do
						tbl14[player.Name] = true
					end

					local flag15 = not v16 or not v16.Parent
					local plots2 = plot

					if flag15 then
						plots2 = Workspace:FindFirstChild("Plots")
					end

					if not plots2 then
						return
					end
					local n8 = 10

					for _, descendant in ipairs(plots2:GetDescendants()) do
						if descendant:IsA("Model") and not tbl14[descendant.Name] then
							local flag16 = descendant.Name == name2

							if not flag16 then
								flag16 = tostring(descendant.Name):lower():find(tostring(name2):lower(), 1, true)
							end

							if flag16 then
								local primaryPart = descendant.PrimaryPart or descendant:FindFirstChild("RootPart") or descendant:FindFirstChildWhichIsA("BasePart")

								if primaryPart and spawnPos then
									local magnitude = (primaryPart.Position - spawnPos).Magnitude

									if magnitude < n8 then
										v15 = descendant
										n8 = magnitude
									end
								elseif not spawnPos and not v15 and flag16 then
									v15 = descendant
								end
							end
						end
					end

					if not v15 or not viewportFrame.Parent then
						return
					end
					local tbl15 = {}

					local function fn54(arg)
						tbl15[arg] = arg.Archivable
						arg.Archivable = true
					end

					local ok, parent = pcall(function()
						fn54(v15)

						for _, descendant in ipairs(v15:GetDescendants()) do
							fn54(descendant)
						end

						return v15:Clone()
					end)

					for k, v17 in pairs(tbl15) do
						pcall(function()
							k.Archivable = v17
						end)
					end

					if not ok or not parent then
						return
					end

					if not viewportFrame:IsDescendantOf(game) then
						parent:Destroy()
						return
					end

					for _, descendant in ipairs(parent:GetDescendants()) do
						if descendant:IsA("Script") or descendant:IsA("LocalScript") or descendant:IsA("Highlight") or descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") then
							descendant:Destroy()
						end
					end

					local worldModel = Instance.new("WorldModel")
					worldModel.Parent = viewportFrame
					parent.Parent = worldModel
					local boundingBox, v17 = parent:GetBoundingBox()
					local position = boundingBox.Position
					local n9 = math.max(v17.Magnitude * 1.3, 2.2)
					local n10 = v17.Y * 0.12

					pcall(function()
						for _, descendant in ipairs(parent:GetDescendants()) do
							if descendant:IsA("BasePart") then
								descendant.Anchored = true
								descendant.CFrame = descendant.CFrame - position
							end
						end

						local part = Instance.new("Part")
						part.Name = "_VPPivot"
						part.Size = Vector3.new(0.05, 0.05, 0.05)
						part.Transparency = 1
						part.Anchored = true
						part.CanCollide = false
						part.CanQuery = false
						part.CanTouch = false
						part.CFrame = CFrame.new()
						part.Parent = parent
						parent.PrimaryPart = part
					end)

					camera.CFrame = CFrame.new(Vector3.new(0, n10, n9), Vector3.zero)
					local connection9 = nil

						local flag16

						if flag then
							flag16 = v18
						else
							flag16 = not viewportFrame:IsDescendantOf(game)
						end

						if flag16 or not parent.Parent then
							if connection9 then
								connection9:Disconnect()
							end

							return
						end

						if parent.PrimaryPart then
							pcall(function()
								parent:PivotTo(CFrame.Angles(0, math.rad(n11), 0))
							end)
						end
					end)

					table.insert(tbl, connection9)
				end)

				local textLabel = Instance.new("TextLabel")
				textLabel.Text = v13.name
				textLabel.Size = UDim2.new(1, -90, 0, 28)
				textLabel.Position = UDim2.new(0, 80, 0, 10)
				textLabel.BackgroundTransparency = 1
				textLabel.TextColor3 = tbl12.bright
				textLabel.Font = Enum.Font.GothamMedium
				textLabel.TextSize = 13
				textLabel.TextXAlignment = Enum.TextXAlignment.Left
				textLabel.TextYAlignment = Enum.TextYAlignment.Center
				textLabel.TextWrapped = false
				textLabel.TextTruncate = Enum.TextTruncate.AtEnd
				textLabel.Parent = frame
				local textLabel2 = Instance.new("TextLabel")
				textLabel2.Text = "Slot " .. tostring(v13.slot)
				textLabel2.Size = UDim2.new(1, -90, 0, 16)
				textLabel2.Position = UDim2.new(0, 80, 0, 40)
				textLabel2.BackgroundTransparency = 1
				textLabel2.TextColor3 = tbl12.mute
				textLabel2.Font = Enum.Font.GothamMedium
				textLabel2.TextSize = 11
				textLabel2.TextXAlignment = Enum.TextXAlignment.Left
				textLabel2.Parent = frame
				local textButton = Instance.new("TextButton")
				textButton.Size = UDim2.new(1, 0, 1, 0)
				textButton.BackgroundTransparency = 1
				textButton.Text = ""
				textButton.BorderSizePixel = 0
				textButton.ZIndex = 10
				textButton.Parent = frame

				local connection9 = textButton.MouseButton1Click:Connect(function()
					local v15 = tbl10[name]
					if not v15 or not v15.prompt or not v15.prompt.Parent then
						return
					end
					prompt = v15.prompt
					slot = v15.slot

					if _G.AutoSelectBrainrot then
						_G.AutoSelectBrainrotName = tostring(v15.name or "")
						_G.AutoSelectBrainrotSlot = tonumber(v15.slot) or 0

						pcall(function()
							fn10()
						end)
					end

					fn53()
				end)

				table.insert(tbl, connection9)
			end

		end

		break
	end
end

local ok, result = pcall(function()
	local tbl11 = {
		accent = Color3.fromRGB(106, 106, 106),
		accentHi = Color3.fromRGB(225, 225, 225),
		blueGlow = Color3.fromRGB(190, 190, 190),
		white = Color3.fromRGB(245, 245, 245),
		deepRed = Color3.fromRGB(22, 22, 22),
		body = Color3.fromRGB(25, 25, 25),
		panel = Color3.fromRGB(31, 31, 31),
		card = Color3.fromRGB(42, 42, 42),
		iconBg = Color3.fromRGB(53, 53, 53),
		stroke = Color3.fromRGB(76, 76, 76),
		strokeDim = Color3.fromRGB(57, 57, 57),
		textBright = Color3.fromRGB(237, 237, 237),
		textMute = Color3.fromRGB(166, 166, 166),
		textDim = Color3.fromRGB(135, 135, 135),
		textRed = Color3.fromRGB(220, 220, 220),
		knobOn = Color3.fromRGB(245, 245, 245),
		knobOff = Color3.fromRGB(137, 137, 137),
		trackOff = Color3.fromRGB(65, 65, 65),

	local function fn54(arg, parent, arg2)
		local instance = Instance.new(arg)
		local tbl12 = arg2 or {}

		for k, v14 in v13(tbl12) do
			instance[k] = v14
		end

		instance.Parent = parent
		return instance
	end

	local function fn55(arg, arg2)
		fn54("UICorner", arg, { CornerRadius = UDim.new(0, arg2 or 6) })
	end

	local function fn56(arg, arg2)
		return fn54("UIStroke", arg, { Color = arg2 or tbl11.stroke, Thickness = 1 })
	end

	local function fn57(arg, arg2)
		local connection9 = arg:Connect(arg2)
		table.insert(tbl, connection9)
		return connection9
	end

	local function fn58(arg, arg2, arg3, arg4, arg5, arg6)
		return fn54("TextLabel", arg, {
			Size = arg3,
			Position = arg4 or UDim2.new(),
			BackgroundTransparency = 1,
			Text = arg2,
			TextColor3 = arg6 or tbl11.textBright,
			TextSize = arg5 or 13,
			Font = Enum.Font.GothamMedium,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
	end

	local function fn59(arg, arg2, arg3, arg4)
		local TextButton = fn54("TextButton", arg, {
			Size = arg3,
			Position = arg4 or UDim2.new(),
			Text = arg2,
			TextSize = 13,
			Font = Enum.Font.GothamMedium,
			TextColor3 = tbl11.textBright,
			BackgroundColor3 = tbl11.card,
			BorderSizePixel = 0,
			AutoButtonColor = false,

		fn55(TextButton, 10)

		fn57(TextButton.MouseEnter, function()
			local tbl12 = { BackgroundColor3 = tbl11.iconBg }
			TweenService:Create(TextButton, TweenInfo.new(0.12), tbl12):Play()
		end)

		fn57(TextButton.MouseLeave, function()
			local tbl12 = { BackgroundColor3 = tbl11.card }
			TweenService:Create(TextButton, TweenInfo.new(0.12), tbl12):Play()
		end)

		return TextButton
	end

	for _, v13 in ipairs({ "OrbitFlashBlock", "OrbitFlashBlockBanner", "OrbitFloatingButtons", "OrbitBrandBackground" }) do
		local v14 = playerGui:FindFirstChild(v13)

			v14:Destroy()
		end
	end

	local ScreenGui = fn54("ScreenGui", playerGui, {
		Name = "OrbitFlashBlock",
		ResetOnSpawn = false,
		DisplayOrder = 999999,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = true,

	local n8 = 380
	local n9 = 470

	local Frame = fn54("Frame", ScreenGui, {
		Name = "BorderFrame",
		Size = UDim2.fromOffset(n8 + 4, n9 + 4),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = tbl11.stroke,
		BorderSizePixel = 0,
		ZIndex = 1,

	fn55(Frame, 18)

	local Frame2 = fn54("Frame", ScreenGui, {
		Name = "Win",
		Size = UDim2.fromOffset(380, 470),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 2,

	local Frame3 = fn54("Frame", Frame2, {
		Name = "Body",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = tbl11.body,
		BorderSizePixel = 0,
		ClipsDescendants = true,

	local ScreenGui2 = fn54("ScreenGui", playerGui, {
		Name = "OrbitBrandBackground",
		ResetOnSpawn = false,
		DisplayOrder = 999998,
		IgnoreGuiInset = true,
		Enabled = false,

	fn55(Frame3, 18)

	fn55(fn54("ImageLabel", Frame3, {
		Name = "BG",
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://91656300673513",
		ImageColor3 = Color3.fromRGB(170, 170, 170),
		ImageTransparency = 0.5,
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 0,

	fn55(fn54("Frame", Frame3, {
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = tbl11.body,
		BackgroundTransparency = 0.32,
		BorderSizePixel = 0,
		ZIndex = 0,

	local UIScale = fn54("UIScale", Frame2, { Scale = 1 })
	local UIScale2 = fn54("UIScale", Frame, { Scale = 1 })

	local function fn60()
		Frame.Position = Frame2.Position
		Frame.Size = UDim2.fromOffset(Frame2.Size.X.Offset + 4, Frame2.Size.Y.Offset + 4)
		UIScale2.Scale = UIScale.Scale
	end

	fn57(Frame2:GetPropertyChangedSignal("Position"), fn60)
	fn57(Frame2:GetPropertyChangedSignal("Size"), fn60)

	local function fn61()
		local currentCamera2 = Workspace.CurrentCamera

		if currentCamera2 then
			UIScale.Scale = math.min(1, math.max(0.25, math.min((currentCamera2.ViewportSize.X - 24) / n8, (currentCamera2.ViewportSize.Y - 96) / n9)))
		end

		fn60()
	end

	local function fn62()
			v13:Disconnect()
		end

		if Workspace.CurrentCamera then
			v13 = fn57(Workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), fn61)
		end

		fn61()
	end

	fn57(Workspace:GetPropertyChangedSignal("CurrentCamera"), fn62)
	fn62()

	local Frame5 = fn54("Frame", Frame3, {
		Name = "Header",
		Size = UDim2.new(1, 0, 0, 48),
		BackgroundColor3 = tbl11.body,
		BackgroundTransparency = 0.1,
		BorderSizePixel = 0,
		Active = true,
		ZIndex = 5,
		ClipsDescendants = true,

	fn55(Frame5, 18)
	local orbit = fn58(Frame5, "Orbit", UDim2.new(1, -110, 1, 0), UDim2.fromOffset(20, 0), 17)
	orbit.Font = Enum.Font.GothamMedium
	orbit.ZIndex = 5
	local udim2 = UDim2.new
	local v14 = fn59(Frame5, "-", UDim2.fromOffset(28, 28), udim2(1, -74, 0.5, -14))
	local udim22 = UDim2.new
	local v15 = fn59(Frame5, "X", UDim2.fromOffset(28, 28), udim22(1, -42, 0.5, -14))

	for _, v16 in ipairs({ v14, v15 }) do
		v16.ZIndex = 6
		v16.TextColor3 = tbl11.accentHi
		v16.TextSize = 14
		v16.BackgroundTransparency = 0.1
		v16:FindFirstChildOfClass("UICorner").CornerRadius = UDim.new(0, 8)
		local uiStroke = v16:FindFirstChildOfClass("UIStroke")
		uiStroke.Color = tbl11.accent
		uiStroke.Transparency = 0.3
	end

	local Frame6 = fn54("Frame", Frame3, {
		Size = UDim2.new(1, -40, 0, 40),
		Position = UDim2.fromOffset(20, 58),
		BackgroundColor3 = tbl11.panel,
		BackgroundTransparency = 0.12,
		BorderSizePixel = 0,
		ZIndex = 5,

	fn55(Frame6, 12)

	local function fn63(arg, arg2)
		local TextButton = fn54("TextButton", Frame6, {
			Size = UDim2.new(0.5, -6, 1, -8),
			Position = UDim2.new(arg2, 4, 0, 4),
			BackgroundColor3 = tbl11.card,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Text = arg,
			TextSize = 13,
			Font = Enum.Font.GothamMedium,
			TextColor3 = tbl11.textDim,
			AutoButtonColor = false,
			ZIndex = 5,

		fn55(TextButton, 9)
		return TextButton
	end

	local Home = fn63("Home", 0)
	local Settings = fn63("Settings", 0.5)

	local Frame7 = fn54("Frame", Frame3, {
		Size = UDim2.new(1, 0, 0, 1),
		Position = UDim2.fromOffset(0, 104),
		BackgroundColor3 = tbl11.accent,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 5,

	local Frame8 = fn54("Frame", Frame3, {
		Size = UDim2.new(1, -40, 1, -120),
		Position = UDim2.fromOffset(20, 110),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		ZIndex = 5,

	local Frame9 = fn54("Frame", Frame8, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 })
	local Frame10 = fn54("Frame", Frame8, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false })

	local TextBox = fn54("TextBox", Frame9, {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = tbl11.card,
		BorderSizePixel = 0,
		Text = "",
		PlaceholderText = "Search brainrots...",
		PlaceholderColor3 = tbl11.textDim,
		TextColor3 = tbl11.textBright,
		TextSize = 13,
		Font = Enum.Font.GothamMedium,
		ClearTextOnFocus = false,
		TextXAlignment = Enum.TextXAlignment.Left,

	fn55(TextBox, 10)
	fn56(TextBox, tbl11.strokeDim)
	fn54("UIPadding", TextBox, { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) })
	local textMute = tbl11.textMute
	local chooseABrainrot = fn58(Frame9, "Choose a brainrot", UDim2.new(1, 0, 0, 24), UDim2.fromOffset(2, 39), 11, textMute)

	local function fn64(arg, arg2)
		local ScrollingFrame = fn54("ScrollingFrame", arg, {
			Size = UDim2.new(1, 0, 1, -arg2),
			Position = UDim2.fromOffset(0, arg2),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			CanvasSize = UDim2.new(),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			ScrollingDirection = Enum.ScrollingDirection.Y,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = tbl11.accent,
			Active = true,

		fn54("UIListLayout", ScrollingFrame, {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 8),
			HorizontalAlignment = Enum.HorizontalAlignment.Center,

		fn54("UIPadding", ScrollingFrame, {
			PaddingTop = UDim.new(0, 3),
			PaddingBottom = UDim.new(0, 8),
			PaddingLeft = UDim.new(0, 3),
			PaddingRight = UDim.new(0, 7),

		return ScrollingFrame
	end

	local v16 = fn64(Frame9, 66)
	v12 = v16
	local v17 = fn64(Frame10, 0)
	local textMute2 = tbl11.textMute
	local v18 = fn58(Frame9, "No brainrots found.\nWaiting for available plots...", UDim2.new(1, -24, 0, 70), UDim2.fromOffset(12, 112), 13, textMute2)
	v18.TextXAlignment = Enum.TextXAlignment.Center
	v18.TextWrapped = true
	local v19 = chooseABrainrot

	local function fn65(text)
		v19.Text = text
	end

	local function fn66()
		local str = TextBox.Text:lower()

		for _, child in ipairs(v16:GetChildren()) do
			if child:IsA("Frame") then
				n10 += 1
				child.Visible = tostring(child:GetAttribute("PetName") or child.Name):lower():find(str, 1, true) ~= nil

				if child.Visible then
					n11 += 1
				end
			end
		end

		chooseABrainrot.Text = string.format("Brainrots  ·  %d", n11)
		v18.Visible = n11 == 0
		v18.Text = n10 == 0 and "No brainrots found.\nWaiting for available plots..." or "No matches. Try another name."
	end

	fn57(TextBox:GetPropertyChangedSignal("Text"), fn66)
	local str = ""

	local function fn67(orbitActiveTab)
		if orbitActiveTab == str then
			return
		end
		str = orbitActiveTab
		v6.OrbitActiveTab = orbitActiveTab
		fn17()
		local tweenInfo = TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
		Frame9.Visible = true
		Frame10.Visible = true
		TweenService:Create(Frame9, tweenInfo, { Position = UDim2.fromScale(orbitActiveTab == "brainrots" and 0 or -1, 0) }):Play()
		TweenService:Create(Frame10, tweenInfo, { Position = UDim2.fromScale(orbitActiveTab == "settings" and 0 or 1, 0) }):Play()
		Home.TextColor3 = orbitActiveTab == "brainrots" and tbl11.accentHi or tbl11.textDim
		Settings.TextColor3 = orbitActiveTab == "settings" and tbl11.accentHi or tbl11.textDim
		Home.BackgroundTransparency = orbitActiveTab == "brainrots" and 0 or 1
		Settings.BackgroundTransparency = orbitActiveTab == "settings" and 0 or 1

		task.delay(0.32, function()
			if not ScreenGui.Parent then
				return
			end
			Frame9.Visible = str == "brainrots"
			Frame10.Visible = str == "settings"
		end)
	end

	Frame10.Position = UDim2.fromScale(1, 0)

	fn57(Home.Activated, function()
		fn67("brainrots")
	end)

	fn57(Settings.Activated, function()
		fn67("settings")
	end)

	fn67(v6.OrbitActiveTab == "settings" and "settings" or "brainrots")
	local layoutOrder = 0
	local tbl12 = {}

	local function fn68(arg)
		layoutOrder += 1
		local Frame11 = fn54("Frame", v17, { Size = UDim2.new(1, 0, 0, 36), BackgroundTransparency = 1, LayoutOrder = layoutOrder })
		Frame11:SetAttribute("OrbitSection", true)
		local str2 = arg:match("^%s*(.-)%s*$"):lower():gsub("^%l", string.upper)
		local textMute3 = tbl11.textMute
		local v21 = v20(Frame11, str2, UDim2.new(1, 0, 1, -4), UDim2.fromOffset(2, 0), 12, textMute3)
		v21.Font = Enum.Font.GothamMedium
		v21.TextYAlignment = Enum.TextYAlignment.Bottom
		return Frame11
	end

	local function fn69(arg, arg2, arg3, arg4)
		layoutOrder += 1

		local Frame11 = fn54("Frame", v17, {
			Size = UDim2.new(1, 0, 0, 56),
			BackgroundColor3 = tbl11.card,
			BackgroundTransparency = 0.15,
			BorderSizePixel = 0,
			LayoutOrder = layoutOrder,

		Frame11:SetAttribute("OrbitSetting", arg)
		fn55(Frame11, 12)

		local Frame12 = fn54("Frame", Frame11, {
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = tbl11.accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,

		fn55(Frame12, 12)
		fn58(Frame11, arg, UDim2.new(1, -76, 0, 22), UDim2.fromOffset(12, 5), 13)
		local textMute3 = tbl11.textMute
		local v20 = fn58(Frame11, arg2, UDim2.new(1, -76, 0, 25), UDim2.fromOffset(12, 27), 10, textMute3)
		v20.TextWrapped = true
		v20.TextTruncate = Enum.TextTruncate.None
		local Frame13 = fn54("Frame", Frame11, { Size = UDim2.fromOffset(34, 18), Position = UDim2.new(1, -46, 0.5, -9), BorderSizePixel = 0 })
		fn55(Frame13, 9)
		local Frame14 = fn54("Frame", Frame13, { Size = UDim2.fromOffset(14, 14), BackgroundColor3 = tbl11.knobOn, BorderSizePixel = 0 })
		fn55(Frame14, 7)
		local tbl13 = { on = arg3 == true, track = Frame13, knob = Frame14, toggleName = arg }

		local function render(arg5)
			local twInfo = TweenInfo.new(arg5 and 0.14 or 0)
			TweenService:Create(Frame13, twInfo, { BackgroundColor3 = tbl13.on and tbl11.accent or tbl11.trackOff }):Play()
			TweenService:Create(Frame14, twInfo, { Position = UDim2.fromOffset(tbl13.on and 18 or 2, 2) }):Play()
		end

		tbl13.render = render
		render(false)
		local TextButton = fn54("TextButton", Frame11, { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 8 })

		fn57(TextButton.MouseEnter, function()
			TweenService:Create(Frame12, TweenInfo.new(0.2), { BackgroundTransparency = 0.88 }):Play()
		end)

		fn57(TextButton.MouseLeave, function()
			TweenService:Create(Frame12, TweenInfo.new(0.25), { BackgroundTransparency = 1 }):Play()
		end)

		fn57(TextButton.Activated, function()
			local on = not tbl13.on
			local ok, result = pcall(arg4, on)

			if ok then
				tbl13.on = on
				render(true)
				pcall(fn10)
			else
				fn65(arg .. " could not be updated")
			end
		end)

		table.insert(tbl12, tbl13)
		return Frame11, tbl13
	end

	fn68("  AUTO RESET  ")

	fn69("Reset On Balloon", "Reset when affected by a balloon", _G.AutoResetOnBalloon, function(autoResetOnBalloon)
		_G.AutoResetOnBalloon = autoResetOnBalloon
		fn10()
	end)

	fn68("  FLASH TP  ")

	fn69("Auto Block", "Block the nearest player after Flash", _G.AutoBlock, function(autoBlock)
		_G.AutoBlock = autoBlock
		fn10()
	end)

	layoutOrder += 1
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 58)
	frame.BackgroundColor3 = tbl11.card
	frame.BorderSizePixel = 0
	frame.ZIndex = 4
	frame.LayoutOrder = layoutOrder
	frame.Parent = v17
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Color = tbl11.stroke
	uiStroke.Thickness = 1
	uiStroke.Parent = frame
	local frame2 = Instance.new("Frame")
	frame2.Size = UDim2.new(0, 3, 1, -10)
	frame2.Position = UDim2.new(0, 0, 0, 5)
	frame2.BackgroundColor3 = tbl11.accent
	frame2.BorderSizePixel = 0
	frame2.ZIndex = 5
	frame2.Parent = frame
	Instance.new("UICorner", frame2).CornerRadius = UDim.new(0, 3)
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, -14, 0, 16)
	textLabel.Position = UDim2.new(0, 10, 0, 4)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = "Block Speed"
	textLabel.TextColor3 = tbl11.textBright
	textLabel.TextSize = 11
	textLabel.Font = Enum.Font.GothamMedium
	textLabel.TextXAlignment = Enum.TextXAlignment.Left
	textLabel.ZIndex = 5
	textLabel.Parent = frame
	local frame3 = Instance.new("Frame")
	frame3.Size = UDim2.new(1, -14, 0, 24)
	frame3.Position = UDim2.new(0, 7, 0, 24)
	frame3.BackgroundTransparency = 1
	frame3.ZIndex = 5
	frame3.Parent = frame
	local uiListLayout = Instance.new("UIListLayout")
	uiListLayout.FillDirection = Enum.FillDirection.Horizontal
	uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	uiListLayout.Padding = UDim.new(0, 3)
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Parent = frame3
	local tbl13 = {}

	local function fn70()
		for k, v20 in pairs(tbl13) do
			local flag14 = _G.BlockDelay == k
			v20.BackgroundColor3 = flag14 and tbl11.accent or Color3.fromRGB(31, 31, 31)
			v20.TextColor3 = flag14 and Color3.fromRGB(255, 255, 255) or tbl11.textMute
			local uiStroke2 = v20:FindFirstChildOfClass("UIStroke")

			if uiStroke2 then
				uiStroke2.Color = flag14 and tbl11.accentHi or tbl11.strokeDim
			end
		end
	end

	local function createTextButton(text, blockDelay, layoutOrder2)
		local textButton = Instance.new("TextButton")
		textButton.Name = "Delay_" .. blockDelay
		textButton.Size = UDim2.new(0.33333333333333331, -3, 0, 24)
		textButton.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
		textButton.BorderSizePixel = 0
		textButton.Text = text
		textButton.TextColor3 = tbl11.textMute
		textButton.TextSize = 10
		textButton.Font = Enum.Font.GothamMedium
		textButton.AutoButtonColor = false
		textButton.LayoutOrder = layoutOrder2
		textButton.ZIndex = 6
		textButton.Parent = frame3
		Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)
		local uiStroke2 = Instance.new("UIStroke")
		uiStroke2.Color = tbl11.strokeDim
		uiStroke2.Thickness = 1
		uiStroke2.Parent = textButton

		textButton.MouseButton1Click:Connect(function()
			_G.BlockDelay = blockDelay
			fn10()
			fn70()
		end)

		tbl13[blockDelay] = textButton
		return textButton
	end

	createTextButton("FAST", "fast", 1)
	createTextButton("NORMAL", "normal", 2)
	createTextButton("SLOW", "slow", 3)
	fn70()

	fn69("Auto Giant", "Use Giant Potion after Flash", _G.AutoGiant, function(autoGiant)
		_G.AutoGiant = autoGiant
		fn10()
	end)

	layoutOrder += 1
	local Frame11 = fn54("Frame", v17, { Size = UDim2.new(1, 0, 0, 62), BackgroundTransparency = 1, LayoutOrder = layoutOrder })
	Frame11:SetAttribute("OrbitSetting", "Travel Mode")
	fn58(Frame11, "Travel Mode", UDim2.new(1, 0, 0, 22), UDim2.new(), 14)
	local udim23 = UDim2.fromOffset
	local carpet = fn59(Frame11, "Carpet", UDim2.new(0.5, -4, 0, 30), udim23(0, 26))
	local udim24 = UDim2.new
	local grapple = fn59(Frame11, "Grapple", UDim2.new(0.5, -4, 0, 30), udim24(0.5, 4, 0, 26))

	local function fn71()
		local flag14 = _G.OrbitTravelMode == "Grapple"
		carpet.TextColor3 = flag14 and tbl11.textDim or tbl11.accentHi
		grapple.TextColor3 = flag14 and tbl11.accentHi or tbl11.textDim
		carpet:FindFirstChildOfClass("UIStroke").Color = flag14 and tbl11.strokeDim or tbl11.accent
		grapple:FindFirstChildOfClass("UIStroke").Color = flag14 and tbl11.accent or tbl11.strokeDim
	end

	fn57(carpet.Activated, function()
		_G.OrbitTravelMode = "Carpet"
		fn71()
		fn10()
	end)

	fn57(grapple.Activated, function()
		_G.OrbitTravelMode = "Grapple"
		fn71()
		fn10()
	end)

	fn71()
	layoutOrder += 1
	local Frame12 = fn54("Frame", v17, { Size = UDim2.new(1, 0, 0, 40), BackgroundTransparency = 1, LayoutOrder = layoutOrder })
	Frame12:SetAttribute("OrbitSetting", "Flying Tool")
	local udim25 = UDim2.fromOffset
	local v20 = fn59(Frame12, "<", UDim2.fromOffset(26, 26), udim25(0, 7))
	local udim26 = UDim2.new
	local v21 = fn59(Frame12, ">", UDim2.fromOffset(26, 26), udim26(1, -26, 0, 7))
	local accentHi = tbl11.accentHi
	local v22 = fn58(Frame12, "", UDim2.new(1, -64, 1, 0), UDim2.fromOffset(32, 0), 12, accentHi)
	v22.TextXAlignment = Enum.TextXAlignment.Center

	local function fn72()
		_G.TransportIndex = math.clamp(tonumber(_G.TransportIndex) or 1, 1, #tbl8)
		v22.Text = tbl8[_G.TransportIndex]
	end

	fn57(v20.Activated, function()
		_G.TransportIndex = ((_G.TransportIndex or 1) - 2) % #tbl8 + 1
		fn72()
		fn10()
	end)

	fn57(v21.Activated, function()
		_G.TransportIndex = (_G.TransportIndex or 1) % #tbl8 + 1
		fn72()
		fn10()
	end)

	fn72()

	local function fn73(arg, arg2, arg3)
		layoutOrder += 1
		local Frame13 = fn54("Frame", v17, { Size = UDim2.new(1, 0, 0, 64), BackgroundTransparency = 1, LayoutOrder = layoutOrder })
		Frame13:SetAttribute("OrbitSetting", arg)
		fn58(Frame13, arg, UDim2.new(1, -78, 0, 28), UDim2.new(), 14)

		local TextBox2 = fn54("TextBox", Frame13, {
			Size = UDim2.fromOffset(66, 26),
			Position = UDim2.new(1, -66, 0, 0),
			Text = tostring(_G[arg2] or arg3),
			ClearTextOnFocus = false,
			BackgroundColor3 = tbl11.card,
			BackgroundTransparency = 0.1,
			BorderSizePixel = 0,
			Font = Enum.Font.GothamMedium,
			TextColor3 = tbl11.accentHi,
			TextSize = 13,

		fn55(TextBox2, 6)
		fn56(TextBox2, tbl11.strokeDim)

		local TextButton = fn54("TextButton", Frame13, {
			Size = UDim2.new(1, 0, 0, 26),
			Position = UDim2.fromOffset(0, 30),
			BackgroundTransparency = 1,
			Text = "",
			AutoButtonColor = false,

		local Frame14 = fn54("Frame", TextButton, {
			Size = UDim2.new(1, -12, 0, 4),
			Position = UDim2.new(0, 6, 0.5, -2),
			BackgroundColor3 = tbl11.strokeDim,
			BorderSizePixel = 0,

		fn55(Frame14, 2)
		local Frame15 = fn54("Frame", Frame14, { Size = UDim2.fromScale(0, 1), BackgroundColor3 = tbl11.accent, BorderSizePixel = 0 })
		fn55(Frame15, 2)

		local Frame16 = fn54("Frame", Frame14, {
			Size = UDim2.fromOffset(12, 12),
			Position = UDim2.fromScale(0, 0.5),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = tbl11.blueGlow,
			BorderSizePixel = 0,

		fn55(Frame16, 6)

		local function fn74(arg4, arg5)
			local num = tonumber(arg4)

			if not num or num ~= num or num == math.huge or num == -math.huge then
				num = tonumber(_G[arg2]) or arg3
			end

			local n10 = math.floor(math.clamp(num, 100, 1000) + 0.5)
			_G[arg2] = n10
			TextBox2.Text = tostring(n10)
			local n11 = (n10 - 100) / 900
			Frame15.Size = UDim2.fromScale(n11, 1)
			Frame16.Position = UDim2.fromScale(n11, 0.5)

			if arg5 then
				fn10()
			end
		end

		local function fn75(arg4)
			if Frame14.AbsoluteSize.X <= 0 then
				return
			end
			fn74(100 + 900 * math.clamp((arg4 - Frame14.AbsolutePosition.X) / Frame14.AbsoluteSize.X, 0, 1), false)
		end

		fn57(TextButton.InputBegan, function(arg4)
			if arg4.UserInputType == Enum.UserInputType.MouseButton1 or arg4.UserInputType == Enum.UserInputType.Touch then
				v23 = arg4
				fn75(arg4.Position.X)
			end
		end)

		fn57(UserInputService.InputChanged, function(arg4)
			if not v23 then
				return
			end

			if v23.UserInputType == Enum.UserInputType.Touch then
				if arg4 ~= v23 then
					return
				end
			elseif arg4.UserInputType ~= Enum.UserInputType.MouseMovement then
				return
			end

			fn75(arg4.Position.X)
		end)

		fn57(UserInputService.InputEnded, function(arg4)
			if v23 and (arg4 == v23 or arg4.UserInputType == Enum.UserInputType.MouseButton1 or arg4.UserInputType == Enum.UserInputType.Touch) then
				v23 = nil
				fn10()
			end
		end)

		fn57(TextBox2.FocusLost, function()
			fn74(TextBox2.Text, true)
		end)

		fn74(_G[arg2] or arg3, false)
	end

	fn73("Carpet Speed", "FlashSpeed", 180)
	fn73("Grapple Speed", "OrbitGrappleSpeed", 400)

	fn69("Auto Return Base", "Return to your base after a steal", _G.AutoReturnBase == true, function(autoReturnBase)
		_G.AutoReturnBase = autoReturnBase

		if not autoReturnBase and type(_G._175_StopReturnBase) == "function" then
			pcall(_G._175_StopReturnBase)
		end

		fn10()
	end)

	fn69("Anti Ragdoll", "Recover from ragdoll effects", flag2, function(arg)
		flag2 = arg

		if arg then
			startAntiRagdoll()
		else
			fn28()
		end

		fn10()
	end)

	fn69("Bypass Ragdoll", "Use the Flash / Giant ragdoll technique", _G.RagdollBypass, function(arg)
		_G.RagdollBypass = arg and true or false
		fn10()
	end)

	fn68("  MISC  ")

	fn69("AP ESP", "Highlight players with Admin Panel", _G.APESPEnabled, function(arg)
		if arg then
			fn25()
		else
			fn26()
		end

		fn10()
	end)

	fn69("FPS Boost", "Stretch + Anti Lag + Nuke optimiser", _G.FPSBoostEnabled == true, function(fpsBoostEnabled)
		_G.FPSBoostEnabled = fpsBoostEnabled

		pcall(function()
			if _G.AceFPSBoost then
				if fpsBoostEnabled then
					_G.AceFPSBoost.EnableAll()
				else
					_G.AceFPSBoost.DisableAll()
				end
			end
		end)

		fn10()
	end)

	fn69("Backpack ESP", "Show player Flash, Giant and Carpet tools", _G.BackpackESP, function(backpackESP)
		_G.BackpackESP = backpackESP

		if type(_G._175_SetBackpackESP) == "function" then
			_G._175_SetBackpackESP(backpackESP)
		end

		fn10()
	end)

	fn69("Brainrot Highlight", "Highlight brainrots in the world", _G.BrainrotHighlight, function(brainrotHighlight)
		_G.BrainrotHighlight = brainrotHighlight

		if type(_G._175_SetBrainrotHL) == "function" then
			_G._175_SetBrainrotHL(brainrotHighlight)
		end

		fn10()
	end)

	fn69("Auto Steal", "Grab the selected brainrot during Flash", _G.OrbitAutoSteal ~= false, function(orbitAutoSteal)
		_G.OrbitAutoSteal = orbitAutoSteal
		fn10()
	end)

	fn69("Auto Select Brainrot", "Restore your previous brainrot selection", _G.AutoSelectBrainrot == true, function(autoSelectBrainrot)
		_G.AutoSelectBrainrot = autoSelectBrainrot

		if autoSelectBrainrot and prompt then
			pcall(function()
				_G.AutoSelectBrainrotName = tostring(prompt.ObjectText or _G.AutoSelectBrainrotName or "")
				_G.AutoSelectBrainrotName = _G.AutoSelectBrainrotName:gsub("%s*%[.-%]%s*", ""):gsub("^%s+", ""):gsub("%s+$", "")
				_G.AutoSelectBrainrotSlot = tonumber(slot) or 0
			end)
		end

		fn10()
	end)

	fn69("Quick AP", "Open the draggable quick admin panel", _G.QuickAP, function(quickAP)
		_G.QuickAP = quickAP

		if type(_G._175_SetQuickAP) == "function" then
			_G._175_SetQuickAP(quickAP)
		end

		fn10()
	end)

	fn69("Aimbot", "Aim Laser Cape and Web Slinger", flag3, function(arg)
		flag3 = arg
		fn36()
		fn10()
	end)

	fn69("DROP BRAINROT", "Show the draggable DROP control", _G.DropBrainrotEnabled, function(arg)
		fn14(arg)
		fn10()
	end)

	fn69("ESP Base", "Show base lock timers", _G.ESPBaseEnabled, function(arg)
		if arg then
			fn48()
		else
			fn49()
		end

		fn10()
	end)

	fn69("Anti Gummy", "Remove the gummy movement effect", _G.antiGummyEnabled == true, function(antiGummyEnabled)
		_G.antiGummyEnabled = antiGummyEnabled
		fn10()
	end)

	fn68("  ANTI STEAL  ")

	fn69("Quick Pickup", "Reduce pickup hold time in your base", _G.QuickPickup == true, function(quickPickup)
		_G.QuickPickup = quickPickup

		if _G._175_QuickPickup then
			_G._175_QuickPickup.set(quickPickup)
		end

		fn10()
	end)

	fn69("Anti Steal", "React when a player attempts to steal", _G.AntiSteal == true, function(antiSteal)
		_G.AntiSteal = antiSteal
		fn10()
	end)

	layoutOrder += 1
	local frame4 = Instance.new("Frame")
	frame4.Size = UDim2.new(1, 0, 0, 36)
	frame4.BackgroundColor3 = tbl11.card
	frame4.BorderSizePixel = 0
	frame4.ZIndex = 4
	frame4.LayoutOrder = layoutOrder
	frame4.Parent = v17
	Instance.new("UICorner", frame4)
	local uiStroke2 = Instance.new("UIStroke")
	uiStroke2.Color = tbl11.stroke
	uiStroke2.Parent = frame4
	local textLabel2 = Instance.new("TextLabel")
	textLabel2.Size = UDim2.new(0, 90, 1, 0)
	textLabel2.Position = UDim2.new(0, 10, 0, 0)
	textLabel2.BackgroundTransparency = 1
	textLabel2.ZIndex = 5
	textLabel2.Text = "Delay (sec)"
	textLabel2.TextColor3 = tbl11.textBright
	textLabel2.TextSize = 11
	textLabel2.Font = Enum.Font.GothamMedium
	textLabel2.TextXAlignment = Enum.TextXAlignment.Left
	textLabel2.Parent = frame4
	local textBox = Instance.new("TextBox")
	textBox.Size = UDim2.new(0, 70, 0, 24)
	textBox.Position = UDim2.new(1, -80, 0.5, -12)
	textBox.BackgroundColor3 = tbl11.iconBg
	textBox.BorderSizePixel = 0
	textBox.ZIndex = 6
	textBox.Text = string.format("%.1f", tonumber(_G.AntiStealDelay) or 1.8)
	textBox.PlaceholderText = "1.8"
	textBox.TextColor3 = tbl11.textBright
	textBox.PlaceholderColor3 = tbl11.textDim
	textBox.TextSize = 12
	textBox.Font = Enum.Font.GothamMedium
	textBox.ClearTextOnFocus = false
	textBox.Parent = frame4
	Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)
	local uiStroke3 = Instance.new("UIStroke")
	uiStroke3.Color = tbl11.accent
	uiStroke3.Thickness = 1
	uiStroke3.Parent = textBox

	local function fn74(arg)
		local num = tonumber(textBox.Text)

		if not num then
			if arg then
				return
			end
			num = tonumber(_G.AntiStealDelay) or 1.8
		end

		local antiStealDelay = math.clamp(num, 0.3, 60)
		_G.AntiStealDelay = antiStealDelay

		if not arg then
			textBox.Text = string.format("%.1f", antiStealDelay)
			pcall(fn10)
		end
	end

	textBox.FocusLost:Connect(function()
		fn74(false)
	end)

	textBox:GetPropertyChangedSignal("Text"):Connect(function()
		local text = textBox.Text:gsub("[^%d%.]", "")
		if text ~= textBox.Text then
			textBox.Text = text
			return
		end
		local antiStealDelay = tonumber(text)

		if antiStealDelay and antiStealDelay >= 0.3 and antiStealDelay <= 60 then
			_G.AntiStealDelay = antiStealDelay
		end
	end)

	layoutOrder += 1
	local frame5 = Instance.new("Frame")
	frame5.Size = UDim2.new(1, 0, 0, 36)
	frame5.BackgroundColor3 = tbl11.card
	frame5.BorderSizePixel = 0
	frame5.ZIndex = 4
	frame5.LayoutOrder = layoutOrder
	frame5.Parent = v17
	Instance.new("UICorner", frame5)
	local uiStroke4 = Instance.new("UIStroke")
	uiStroke4.Color = tbl11.stroke
	uiStroke4.Parent = frame5

	local function createTextButton2(text, arg, arg2)
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(0.46, 0, 0, 26)
		textButton.Position = UDim2.new(arg2, 4, 0.5, -13)
		textButton.BackgroundColor3 = _G.AntiStealMode == arg and tbl11.accent or Color3.fromRGB(31, 31, 31)
		textButton.BorderSizePixel = 0
		textButton.ZIndex = 6
		textButton.Text = text
		textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		textButton.TextSize = 11
		textButton.Font = Enum.Font.GothamMedium
		textButton.AutoButtonColor = false
		textButton.Parent = frame5
		Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 6)
		return textButton
	end

	local laserProtector = createTextButton2("Laser Protector", "laser", 0.02)
	local apProtector = createTextButton2("AP Protector", "ap", 0.52)

	local function fn75()
		laserProtector.BackgroundColor3 = _G.AntiStealMode == "laser" and tbl11.accent or Color3.fromRGB(31, 31, 31)
		apProtector.BackgroundColor3 = _G.AntiStealMode == "ap" and tbl11.accent or Color3.fromRGB(31, 31, 31)
	end

	laserProtector.MouseButton1Click:Connect(function()
		_G.AntiStealMode = "laser"
		fn75()
		fn10()
	end)

	apProtector.MouseButton1Click:Connect(function()
		_G.AntiStealMode = "ap"
		fn75()
		fn10()
	end)

	layoutOrder += 1
	local frame6 = Instance.new("Frame")
	frame6.Size = UDim2.new(1, 0, 0, 78)
	frame6.BackgroundColor3 = tbl11.card
	frame6.BorderSizePixel = 0
	frame6.ZIndex = 4
	frame6.LayoutOrder = layoutOrder
	frame6.Parent = v17
	Instance.new("UICorner", frame6)
	local uiStroke5 = Instance.new("UIStroke")
	uiStroke5.Color = tbl11.stroke
	uiStroke5.Parent = frame6
	local textLabel3 = Instance.new("TextLabel")
	textLabel3.Size = UDim2.new(1, -12, 0, 16)
	textLabel3.Position = UDim2.new(0, 8, 0, 4)
	textLabel3.BackgroundTransparency = 1
	textLabel3.ZIndex = 5
	textLabel3.Text = "AP Protector commands"
	textLabel3.TextColor3 = tbl11.textMute
	textLabel3.Font = Enum.Font.GothamMedium
	textLabel3.TextSize = 10
	textLabel3.TextXAlignment = Enum.TextXAlignment.Left
	textLabel3.Parent = frame6

	for i, v23 in ipairs({
		{ key = "balloon", label = "Balloon" },
		{ key = "tiny", label = "Tiny" },
		{ key = "jail", label = "Jail" },
		{ key = "rocket", label = "Rocket" },
		{ key = "ragdoll", label = "Ragdoll" },
	}) do
		local n10 = math.floor((i - 1) / 3)
		local textButton = Instance.new("TextButton")
		textButton.Size = UDim2.new(0, 72, 0, 22)
		textButton.Position = UDim2.new(0, 8 + (i - 1) % 3 * 78, 0, 24 + n10 * 26)
		textButton.BackgroundColor3 = _G.AntiStealAP[v23.key] and tbl11.accent or Color3.fromRGB(31, 31, 31)
		textButton.BorderSizePixel = 0
		textButton.ZIndex = 6
		textButton.Text = v23.label
		textButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		textButton.TextSize = 10
		textButton.Font = Enum.Font.GothamMedium
		textButton.AutoButtonColor = false
		textButton.Parent = frame6
		Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 8)

		textButton.MouseButton1Click:Connect(function()
			_G.AntiStealAP[v23.key] = not _G.AntiStealAP[v23.key]
			textButton.BackgroundColor3 = _G.AntiStealAP[v23.key] and tbl11.accent or Color3.fromRGB(31, 31, 31)
			fn10()
		end)
	end

	fn69("Auto Destroy Turrets", "Deletes enemy turrets", _G.AutoTurretEnabled == true, function(autoTurretEnabled)
		_G.AutoTurretEnabled = autoTurretEnabled

		if type(_G._175_AT) == "function" then
			pcall(_G._175_AT, autoTurretEnabled)
		end

		fn10()
	end)

	fn69("ESP Best", "Find the best brainrot in this server", _G.ESPBestEnabled, function(espBestEnabled)
		_G.ESPBestEnabled = espBestEnabled

		if espBestEnabled then
			if type(_G._175_ClearBestNotify) == "function" then
				pcall(_G._175_ClearBestNotify)
			end

			_G.__bestPendingName = nil
			_G.__bestPendingTicks = 0
			_G.__bestLastNotifyTime = 0

			task.spawn(function()
				if type(_G._175_UpdateBestESP) == "function" then
					pcall(_G._175_UpdateBestESP)
				end
			end)
		else
			pcall(function()
				if clearBestESP then
					clearBestESP()
				end
			end)

			if type(_G._175_ClearBestNotify) == "function" then
				pcall(_G._175_ClearBestNotify)
			end

			_G.__bestPendingName = nil
			_G.__bestPendingTicks = 0
		end

		fn10()
	end)

	fn68("INTERFACE")

	local ScreenGui3 = fn54("ScreenGui", playerGui, {
		Name = "OrbitFloatingButtons",
		ResetOnSpawn = false,
		DisplayOrder = 1000000,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

	local ScreenGui4 = fn54("ScreenGui", playerGui, {
		Name = "OrbitFlashBlockBanner",
		ResetOnSpawn = false,
		DisplayOrder = 1000001,
		IgnoreGuiInset = true,

	local Frame13 = fn54("Frame", ScreenGui4, {
		Name = "OrbitBanner",
		Size = UDim2.fromOffset(260, 72),
		Position = UDim2.new(0.5, -130, 0, 10),
		BackgroundColor3 = tbl11.panel,
		BackgroundTransparency = 0.06,
		BorderSizePixel = 0,
		Active = true,

	fn55(Frame13, 14)
	fn56(Frame13, tbl11.strokeDim)
	local textBright = tbl11.textBright
	local center = Enum.TextXAlignment.Center
	fn58(Frame13, "free flash block", UDim2.new(1, -24, 0, 22), UDim2.fromOffset(12, 8), 15, textBright).TextXAlignment = center
	local textMute3 = tbl11.textMute
	local center2 = Enum.TextXAlignment.Center
	fn58(Frame13, "https://discord.gg/TBBAUZu8cW", UDim2.new(1, -24, 0, 18), UDim2.fromOffset(12, 31), 11, textMute3).TextXAlignment = center2

	fn54("Frame", Frame13, {
		Size = UDim2.new(1, -28, 0, 1),
		Position = UDim2.fromOffset(14, 45),
		BackgroundColor3 = tbl11.strokeDim,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,

	local textMute4 = tbl11.textMute
	local v23 = fn58(Frame13, "FPS: —   PING: —", UDim2.new(1, -24, 0, 18), UDim2.fromOffset(12, 50), 11, textMute4)
	v23.TextXAlignment = Enum.TextXAlignment.Center
	local tbl14 = {}
	local tbl15 = {}

	local function fn76(arg, arg2, arg3, arg4)
		local tbl16 = { moved = false, active = false }
		tbl15[arg2] = tbl16

		fn57(arg.InputBegan, function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			tbl16.active = true
			tbl16.moved = false
			tbl16.input = input
			tbl16.start = input.Position
			tbl16.pos = arg2.Position
		end)

		fn57(UserInputService.InputChanged, function(arg5)
			if not tbl16.active then
				return
			end

			if tbl16.input.UserInputType == Enum.UserInputType.Touch then
				if arg5 ~= tbl16.input then
					return
				end
			elseif arg5.UserInputType ~= Enum.UserInputType.MouseMovement then
				return
			end

			local n10 = arg5.Position - tbl16.start

			if n10.Magnitude > 6 then
				tbl16.moved = true
			end

			if tbl16.moved then
				arg2.Position = UDim2.new(tbl16.pos.X.Scale, tbl16.pos.X.Offset + n10.X, tbl16.pos.Y.Scale, tbl16.pos.Y.Offset + n10.Y)
			end
		end)

		fn57(UserInputService.InputEnded, function(arg5)
			if not tbl16.active then
				return
			end
			local isMatch = (arg5 == tbl16.input)
				or (tbl16.input and tbl16.input.UserInputType == Enum.UserInputType.MouseButton1 and arg5.UserInputType == Enum.UserInputType.MouseButton1)
				or (arg5.UserInputType == Enum.UserInputType.Touch)
			if not isMatch then
				return
			end
			tbl16.active = false
			local currentCamera2 = Workspace.CurrentCamera

			if currentCamera2 and tbl16.moved then
				local viewportSize = currentCamera2.ViewportSize
				local scale = arg4 and UIScale.Scale or 1
				local n10 = arg2.Size.X.Offset * scale
				local n11 = arg2.Size.Y.Offset * scale
				local position = arg2.Position
				local n12 = position.X.Scale * viewportSize.X + position.X.Offset
				local n13 = position.Y.Scale * viewportSize.Y + position.Y.Offset
				local n14 = math.clamp(n12, n10 * arg2.AnchorPoint.X, math.max(n10 * arg2.AnchorPoint.X, viewportSize.X - n10 * (1 - arg2.AnchorPoint.X)))
				local n15 = math.clamp(n13, n11 * arg2.AnchorPoint.Y, math.max(n11 * arg2.AnchorPoint.Y, viewportSize.Y - n11 * (1 - arg2.AnchorPoint.Y)))
				arg2.Position = UDim2.fromOffset(n14, n15)

				if arg3 then
					fn19(arg2, arg3)
				end
			end
		end)

		return tbl16
	end

	fn18(Frame2, "OrbitMain", UDim2.fromScale(0.5, 0.5))
	fn60()
	fn76(Frame5, Frame2, "OrbitMain", true)
	Frame13.Position = UDim2.new(0.5, -130, 0, 10)
	fn18(Frame13, "OrbitBanner", Frame13.Position)
	fn76(Frame13, Frame13, "OrbitBanner", false)

	local function fn77(arg, arg2, arg3)
		local Frame14 = fn54("Frame", ScreenGui3, {
			Name = "FLOAT_" .. arg,
			Size = UDim2.fromOffset(124, 46),
			Position = UDim2.new(0, 24, 0.3, (arg2 - 1) * 58),
			BackgroundColor3 = tbl11.card,
			BackgroundTransparency = 0.08,
			BorderSizePixel = 0,
			ZIndex = 100,

		fn55(Frame14, 14)
		fn56(Frame14, tbl11.strokeDim)
		fn18(Frame14, "Orbit" .. arg, Frame14.Position)

		local TextButton = fn54("TextButton", Frame14, {
			Name = "Action",
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = arg:sub(1, 1) .. arg:sub(2):lower(),
			Font = Enum.Font.GothamMedium,
			TextSize = 14,
			TextColor3 = tbl11.textBright,
			ZIndex = 110,
			AutoButtonColor = false,

		fn55(TextButton, 14)
		local v24 = fn76(TextButton, Frame14, "Orbit" .. arg, false)

		fn57(TextButton.MouseEnter, function()
			local tbl16 = { BackgroundColor3 = tbl11.iconBg }
			TweenService:Create(Frame14, TweenInfo.new(0.15), tbl16):Play()
		end)

		fn57(TextButton.MouseLeave, function()
			local tbl16 = { BackgroundColor3 = tbl11.card }
			TweenService:Create(Frame14, TweenInfo.new(0.15), tbl16):Play()
		end)

		fn57(TextButton.Activated, function()
			if v24.moved or flag then
				return
			end
			local ok, result = pcall(arg3)

			if not ok then
				fn65(arg .. " unavailable")
			end
		end)

		table.insert(tbl14, Frame14)
		return Frame14
	end

	fn77("FLASH", 1, function()
		if not prompt or not prompt.Parent or not slot then
			ScreenGui.Enabled = true
			fn67("brainrots")
			fn65("Select a brainrot before using FLASH.")
			return
		end

		local v25

		if flag10 then
			v25 = v24
		else
			v25 = flag9
		end

			fn65("Flash is already active.")
			return
		end
		fn65("Flash: " .. tostring(prompt.ObjectText))
		fn52(prompt, slot)
		fn65(v11.Status)
	end)

	fn77("BLOCK", 2, function()
		local v24 = fn5()

			fn65("Block: " .. v24.DisplayName)
			task.spawn(fn8, v24)
		else
			fn65("No nearby player found.")
		end
	end)

	fn77("RESET", 3, function()
		fn65("Reset requested.")
		fn38()
	end)

	local udim27 = UDim2.new
	local orbit2 = fn59(ScreenGui3, "ORBIT", UDim2.fromOffset(76, 30), udim27(1, -88, 1, -44))
	fn18(orbit2, "OrbitReopen", orbit2.Position)
	local orbitReopen = fn76(orbit2, orbit2, "OrbitReopen", false)
	ScreenGui.Enabled = v6.OrbitOpen ~= false
	ScreenGui2.Enabled = true
	orbit2.Visible = not ScreenGui.Enabled
	local orbitMinimized = false

	local function n175RecoverGUIs()
		ScreenGui.Enabled = true
		orbit2.Visible = false
		orbitMinimized = false
		Frame6.Visible = true
		Frame7.Visible = true
		Frame8.Visible = true
		v19.Visible = true
		Frame2.Size = UDim2.fromOffset(380, 470)
		Frame2.Position = UDim2.fromScale(0.5, 0.5)
		v14.Text = "-"
		ScreenGui2.Enabled = true

		for i, v24 in ipairs(tbl14) do
			v24.Position = UDim2.new(0, 24, 0.3, (i - 1) * 58)
		end

		Frame13.Position = UDim2.new(0.5, -130, 0, 10)
		orbit2.Position = UDim2.new(1, -88, 1, -44)
		fn19(Frame2, "OrbitMain")
		fn19(Frame13, "OrbitBanner")
		fn19(orbit2, "OrbitReopen")

		for _, v24 in ipairs(tbl14) do
			fn19(v24, "Orbit" .. v24.Name:gsub("FLOAT_", ""))
		end

		v6.OrbitMinimized = false
		v6.OrbitOpen = true
		fn17()
		fn60()
		fn65("Layout restored.")
	end

	_G._175_RecoverGUIs = n175RecoverGUIs	fn57(orbit2.Activated, function()
		if orbitReopen.moved then
			return
		end
		ScreenGui.Enabled = true
		ScreenGui2.Enabled = true
		orbit2.Visible = false
		v6.OrbitOpen = true
		fn17()
	end)

	fn57(v15.Activated, function()
		ScreenGui.Enabled = false
		ScreenGui2.Enabled = false
		orbit2.Visible = true
		v6.OrbitOpen = false
		fn17()
	end)

	fn57(UserInputService.InputBegan, function(arg, arg2)
		if not arg2 and not UserInputService:GetFocusedTextBox() and arg.KeyCode == Enum.KeyCode.RightShift then
			ScreenGui.Enabled = not ScreenGui.Enabled
			ScreenGui2.Enabled = ScreenGui.Enabled
			orbit2.Visible = not ScreenGui.Enabled
			v6.OrbitOpen = ScreenGui.Enabled
			fn17()
		end
	end)

	fn57(v14.Activated, function()
		orbitMinimized = not orbitMinimized
		Frame6.Visible = not orbitMinimized
		Frame7.Visible = not orbitMinimized
		Frame8.Visible = not orbitMinimized
		v19.Visible = not orbitMinimized
		v6.OrbitMinimized = orbitMinimized
		fn17()
		v14.Text = orbitMinimized and "+" or "-"
		TweenService:Create(Frame2, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(380, orbitMinimized and 64 or 470) }):Play()
	end)

	if v6.OrbitMinimized == true then
		orbitMinimized = true
		Frame6.Visible = false
		Frame7.Visible = false
		Frame8.Visible = false
		v19.Visible = false
		v14.Text = "+"
		Frame2.Size = UDim2.fromOffset(380, 64)
		fn60()
	end

	ScreenGui4.Enabled = v6.OrbitBannerVisible ~= false

	fn69("Show Banner", "Display the top status banner", v6.OrbitBannerVisible ~= false, function(showBanner)
		v6.OrbitBannerVisible = showBanner
		fn17()
		ScreenGui4.Enabled = showBanner
	end)

	for _, v24 in ipairs(tbl14) do
		v24.Visible = v6.OrbitFloats ~= false
	end

	fn69("Floating Buttons", "Show FLASH, BLOCK and RESET", v6.OrbitFloats ~= false, function(orbitFloats)
		v6.OrbitFloats = orbitFloats
		fn17()

		for _, v24 in ipairs(tbl14) do
			v24.Visible = orbitFloats
		end
	end)

	layoutOrder += 1
	local restorePositions = fn59(v17, "Restore positions", UDim2.new(1, 0, 0, 34))
	restorePositions.LayoutOrder = layoutOrder
	fn57(restorePositions.Activated, n175RecoverGUIs)
	layoutOrder += 1
	local rejoinServer = fn59(v17, "Rejoin server", UDim2.new(1, 0, 0, 36))
	rejoinServer.LayoutOrder = layoutOrder

	_G._175_Rejoin = function()
		game:GetService("TeleportService"):Teleport(game.PlaceId, localPlayer)
	end

	fn57(rejoinServer.Activated, function()
		pcall(_G._175_Rejoin)
	end)

	local tbl16 = { "FLASH & MOVEMENT", "PROTECTION", "BRAINROTS", "ESP & VISUALS", "UTILITIES", "INTERFACE" }

	local tbl17 = {
		["Auto Block"] = { 1, 1 },
		["Block Speed"] = { 1, 2 },
		["Auto Giant"] = { 1, 3 },
		["Speed Carpet"] = { 1, 4 },
		["Travel Mode"] = { 1, 4 },
		["Flying Tool"] = { 1, 5 },
		["Carpet Speed"] = { 1, 6 },
		["Grapple Speed"] = { 1, 7 },
		["Auto Return Base"] = { 1, 8 },
		["Anti Ragdoll"] = { 2, 1 },
		["Bypass Ragdoll"] = { 2, 2 },
		["Reset On Balloon"] = { 2, 3 },
		["Anti Gummy"] = { 2, 4 },
		["Anti Steal"] = { 2, 5 },
		["Delay (sec)"] = { 2, 6 },
		["Laser Protector"] = { 2, 7 },
		["AP Protector commands"] = { 2, 8 },
		["Auto Destroy Turrets"] = { 2, 9 },
		["Auto Steal"] = { 3, 1 },
		["Auto Select Brainrot"] = { 3, 2 },
		["Quick Pickup"] = { 3, 3 },
		["DROP BRAINROT"] = { 3, 4 },
		["ESP Best"] = { 4, 1 },
		["Brainrot Highlight"] = { 4, 2 },
		["ESP Base"] = { 4, 3 },
		["AP ESP"] = { 4, 4 },
		["Backpack ESP"] = { 4, 5 },
		IP = { 4, 6 },
		Aimbot = { 5, 1 },
		["Quick AP"] = { 5, 2 },
		["FPS Boost"] = { 5, 3 },
		["Rejoin server"] = { 5, 4 },
		["Show Banner"] = { 6, 1 },
		["Floating Buttons"] = { 6, 2 },
		Animations = { 6, 3 },
		Sparkles = { 6, 4 },
		["Restore positions"] = { 6, 5 },

	for _, child in ipairs(v17:GetChildren()) do
		if child:GetAttribute("OrbitSection") then
			child:Destroy()
		elseif child:IsA("GuiObject") then
			local attribute = child:GetAttribute("OrbitSetting")
			attribute = attribute and tbl17[attribute]

			if not attribute and child:IsA("TextButton") then
				attribute = tbl17[child.Text]
			end

			if not attribute then
				for _, descendant in ipairs(child:GetDescendants()) do
					if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
						if tbl17[descendant.Text] then
							attribute = tbl17[descendant.Text]
							break
						end
					end
				end
			end

			attribute = attribute or { 5, 90 }
			child.LayoutOrder = attribute[1] * 100 + attribute[2]

			if child:IsA("Frame") then
				child.BackgroundTransparency = child:GetAttribute("OrbitSetting") and 0.15 or 0.28
				child.BackgroundColor3 = tbl11.card

				if not child:FindFirstChildOfClass("UICorner") then
					fn55(child, 12)
				end

				local uiStroke6 = child:FindFirstChildOfClass("UIStroke")

				if uiStroke6 then
					uiStroke6.Transparency = 1
				end
			end
		end
	end

	for i, v24 in ipairs(tbl16) do
		fn68(v24).LayoutOrder = i * 100
	end

	fn60()

	fn57(RunService.RenderStepped, function(arg)
		n10 += 1
		n11 += arg

		if n11 >= 0.5 then
			local n12 = math.floor(n10 / n11 + 0.5)
			local str2 = "—"

			pcall(function()
				str2 = tostring(math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)) .. "ms"
			end)

			v23.Text = string.format("FPS: %d   PING: %s", n12, str2)
			n10 = 0
			n11 = 0
		end
	end)

	task.spawn(function()
		while ScreenGui.Parent and not flag do
			if flag9 and not flag10 and not connection and not v11.Pending then
				flag9 = false
			end

			if prompt and not prompt.Parent then
				prompt = nil
				slot = nil
			end

			local ok, result = pcall(fn53)

			if not ok then
			end

			fn66()

			if v11.Pending or connection then
				chooseABrainrot.Text = v11.Status
			end

			task.wait(1)
		end
	end)

	if _G.APESPEnabled then
		fn25()
	end

	if flag3 then
		fn36()
	end

	if flag2 then
		startAntiRagdoll()
	end

	if _G.ESPBaseEnabled then
		fn48()
	end

	if _G.DropBrainrotEnabled then
		task.spawn(function()
			fn13()
			flag7 = true
		end)
	end

	_G.Formega_Script_Purge = function()
		flag = true
		v11.Cancel("Stopped.")
		pcall(fn28)
		pcall(fn26)
		pcall(fn49)
		pcall(fn11)

		if connection then
			pcall(function()
				connection:Disconnect()
			end)

			connection = nil
		end

		for _, v24 in ipairs({ "_175_StopReturnBase", "_175_ClearBestNotify" }) do
			if type(_G[v24]) == "function" then
				pcall(_G[v24])
			end
		end

		for _, v24 in ipairs({ "_175_SetBackpackESP", "_175_SetBrainrotHL", "_175_SetQuickAP", "_175_AT" }) do
			if type(_G[v24]) == "function" then
				pcall(_G[v24], false)
			end
		end

		if _G._175_QuickPickup then
			pcall(_G._175_QuickPickup.set, false)
		end

		if _G.AceFPSBoost then
			pcall(_G.AceFPSBoost.DisableAll)
		end

		if connection3 then
			connection3:Disconnect()
		end

		if connection4 then
			connection4:Disconnect()
		end

		if connection5 then
			connection5:Disconnect()
		end

		for _, v24 in ipairs(tbl) do
			pcall(function()
				v24:Disconnect()
			end)
		end

		table.clear(tbl)

			v3:Destroy()
			v3 = nil
		end

		if ScreenGui then pcall(function() ScreenGui:Destroy() end) end
		if ScreenGui4 then pcall(function() ScreenGui4:Destroy() end) end
		if ScreenGui3 then pcall(function() ScreenGui3:Destroy() end) end
		if ScreenGui2 then pcall(function() ScreenGui2:Destroy() end) end
		_G.Formega_Script_Purge = nil
	end
end)

if not ok then
	print("prince")
else
	print("prince")
end

task.spawn(function()
	local flag14 = false
	local connection9 = nil

	local function fn54()
		local plots = Workspace:FindFirstChild("Plots")
		if not plots then
			return nil, nil, nil
		end
		local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		humanoidRootPart2 = humanoidRootPart2 and humanoidRootPart2.Position
		if not humanoidRootPart2 then
			return nil, nil, nil
		end
		local n8 = -1
		local n9 = -1
		local n10 = 99999

		for _, child in ipairs(plots:GetChildren()) do
			if not fn44(child) then
				local animalPodiums = child:FindFirstChild("AnimalPodiums")

				if animalPodiums then
					for _, child2 in ipairs(animalPodiums:GetChildren()) do
						local base = child2:FindFirstChild("Base") or child2
						local spawn = base and base:FindFirstChild("Spawn")
						spawn = spawn and spawn:FindFirstChild("PromptAttachment")

						if spawn then
							for _, child3 in ipairs(spawn:GetChildren()) do
								if child3:IsA("ProximityPrompt") and fn50(child3) then
									local objectText = child3.ObjectText or "Pet"
									local v17, v18 = fn4(child3, child2)
									local v19 = fn3(objectText)
									local worldPosition = spawn:IsA("Attachment") and spawn.WorldPosition or spawn:IsA("BasePart") and spawn.Position

									if worldPosition then
										local magnitude = (worldPosition - humanoidRootPart2).Magnitude

										if v18 > n8 then
											n8 = v18
											n9 = v19
											n10 = magnitude
											v14 = child3
											v15 = objectText
											v16 = v17
										elseif v18 == n8 then
											if n9 < v19 then
												n8 = v18
												n9 = v19
												n10 = magnitude
												v14 = child3
												v15 = objectText
												v16 = v17
											elseif v19 == n9 and magnitude < n10 then
												n8 = v18
												n9 = v19
												n10 = magnitude
												v14 = child3
												v15 = objectText
												v16 = v17
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end

		return v14, v15, v16
	end

	local billboardGui

	clearBestESP = function()
		if billboardGui then
			pcall(function()
				billboardGui:Destroy()
			end)

			billboardGui = nil
		end
	end

	local mp3 = nil

	pcall(function()
		writefile("best_notify_sound.mp3", response)
	end)

	mp3 = mp3 or "https://files.catbox.moe/5o5zso.mp3"

	local function fn55()
		pcall(function()
			local sound = Instance.new("Sound")
			sound.SoundId = mp3
			sound.Volume = 2
			sound.Parent = Workspace
			sound:Play()

			sound.Ended:Connect(function()
				sound:Destroy()
			end)

			task.delay(5, function()
				if sound then
					sound:Destroy()
				end
			end)
		end)
	end

	local function fn56(text, arg)
		if flag14 then
			return
		end
		flag14 = true

		for _, child in ipairs(playerGui:GetChildren()) do
			if child.Name == "BestBrainrotNotify" then
				pcall(function()
					child:Destroy()
				end)
			end
		end

		fn55()
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "BestBrainrotNotify"
		screenGui.ResetOnSpawn = false
		screenGui.DisplayOrder = 9999
		screenGui.IgnoreGuiInset = true
		screenGui.Parent = playerGui
		local frame = Instance.new("Frame")
		frame.Size = UDim2.new(0, 250, 0, 72)
		frame.Position = UDim2.new(0.5, -125, 0, -70)
		frame.BackgroundColor3 = Color3.fromRGB(24, 32, 44)
		frame.BorderSizePixel = 0
		frame.ClipsDescendants = true
		frame.Parent = screenGui
		Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
		local uiStroke = Instance.new("UIStroke")
		uiStroke.Color = Color3.fromRGB(80, 157, 250)
		uiStroke.Thickness = 1.5
		uiStroke.Transparency = 0.15
		uiStroke.Parent = frame
		local uiGradient = Instance.new("UIGradient")
		local colorSequence = ColorSequence.new
		local tbl11 = {}
		local v14 = ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 32, 44))
		local v15 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(24, 32, 44))
		local new = ColorSequenceKeypoint.new
		local color = Color3.fromRGB
		tbl11[1] = v14
		tbl11[2] = v15

			local values = table.pack(new(1, color(24, 32, 44)))
			table.move(values, 1, values.n, 3, tbl11)
		end

		uiGradient.Color = colorSequence(tbl11)
		uiGradient.Rotation = 90
		uiGradient.Parent = frame
		local frame2 = Instance.new("Frame")
		frame2.Size = UDim2.new(0, 3, 1, 0)
		frame2.BackgroundColor3 = Color3.fromRGB(80, 157, 250)
		frame2.BorderSizePixel = 0
		frame2.ZIndex = 2
		frame2.Parent = frame
		local frame3 = Instance.new("Frame")
		frame3.Size = UDim2.new(0, 58, 0, 58)
		frame3.Position = UDim2.new(0, 7, 0.5, -29)
		frame3.BackgroundColor3 = Color3.fromRGB(24, 32, 44)
		frame3.BorderSizePixel = 0
		frame3.ZIndex = 3
		frame3.ClipsDescendants = true
		frame3.Parent = frame
		Instance.new("UICorner", frame3).CornerRadius = UDim.new(0, 10)
		local uiStroke2 = Instance.new("UIStroke")
		uiStroke2.Color = Color3.fromRGB(80, 157, 250)
		uiStroke2.Thickness = 1
		uiStroke2.Transparency = 0.35
		uiStroke2.Parent = frame3
		local viewportFrame = Instance.new("ViewportFrame")
		viewportFrame.Name = "PetViewport"
		viewportFrame.Size = UDim2.new(1, -2, 1, -2)
		viewportFrame.Position = UDim2.new(0, 1, 0, 1)
		viewportFrame.BackgroundTransparency = 1
		viewportFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		viewportFrame.BorderSizePixel = 0
		viewportFrame.ZIndex = 4
		viewportFrame.Parent = frame3
		local camera = Instance.new("Camera")
		camera.Parent = viewportFrame
		viewportFrame.CurrentCamera = camera

		task.spawn(function()
			local plots = Workspace:FindFirstChild("Plots")
			if not plots or not text then
				return
			end
			local tbl12 = {}

			for _, player in pairs(Players:GetPlayers()) do
				tbl12[player.Name] = true
			end

			for _, descendant in ipairs(plots:GetDescendants()) do
				if descendant:IsA("Model") and descendant.Name == text and not tbl12[descendant.Name] then
					v16 = descendant
					break
				else
					v16 = nil
				end
			end

			if not v16 or not viewportFrame.Parent then
				return
			end
			local clone = v16:Clone()
			if not clone then
				return
			end

			for _, descendant in ipairs(clone:GetDescendants()) do
				if descendant:IsA("Script") or descendant:IsA("LocalScript") or descendant:IsA("Highlight") then
					descendant:Destroy()
				end
			end

			clone.Parent = viewportFrame
			local boundingBox, v17 = clone:GetBoundingBox()
			local n8 = math.max(v17.Magnitude * 1.35, 2.5)
			local n9 = v17.Y * 0.15

			pcall(function()
				for _, descendant in ipairs(clone:GetDescendants()) do
					if descendant:IsA("BasePart") then
						descendant.Anchored = true
					end
				end

				if clone.PrimaryPart then
					clone:PivotTo(CFrame.new())
				else
					local basePart = clone:FindFirstChildWhichIsA("BasePart")

					if basePart then
						clone.PrimaryPart = basePart
						clone:PivotTo(CFrame.new())
					end
				end
			end)

			local connection10 = nil

				if not viewportFrame.Parent or not screenGui.Parent then
					if connection10 then
						connection10:Disconnect()
					end

					return
				end

				local v18 = math.rad(n10)

				if clone and clone.Parent then
					pcall(function()
						clone:PivotTo(CFrame.Angles(0, v18, 0))
					end)
				end

				local vector = Vector3.new
				local n11 = n9 * 0.3
				camera.CFrame = CFrame.new(Vector3.new(0, n9, n8), vector(0, n11, 0))
			end)

			table.insert(tbl, connection10)
		end)

		local textLabel = Instance.new("TextLabel")
		textLabel.Size = UDim2.new(1, -78, 0, 12)
		textLabel.Position = UDim2.new(0, 72, 0, 10)
		textLabel.BackgroundTransparency = 1
		textLabel.Text = "BEST BRAINROT"
		textLabel.TextColor3 = Color3.fromRGB(80, 157, 250)
		textLabel.Font = Enum.Font.GothamBold
		textLabel.TextSize = 9
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.ZIndex = 4
		textLabel.Parent = frame
		local textLabel2 = Instance.new("TextLabel")
		textLabel2.Size = UDim2.new(1, -78, 0, 20)
		textLabel2.Position = UDim2.new(0, 72, 0, 24)
		textLabel2.BackgroundTransparency = 1
		text = text or "Pet"
		textLabel2.Text = text
		textLabel2.TextColor3 = Color3.fromRGB(255, 235, 235)
		textLabel2.Font = Enum.Font.GothamBold
		textLabel2.TextSize = 13
		textLabel2.TextXAlignment = Enum.TextXAlignment.Left
		textLabel2.TextWrapped = true
		textLabel2.TextTruncate = Enum.TextTruncate.None
		textLabel2.ZIndex = 4
		textLabel2.Parent = frame
		local textLabel3 = Instance.new("TextLabel")
		textLabel3.Size = UDim2.new(1, -78, 0, 14)
		textLabel3.Position = UDim2.new(0, 72, 0, 48)
		textLabel3.BackgroundTransparency = 1
		textLabel3.Text = "Valor: " .. tostring(arg or "?")
		textLabel3.TextColor3 = Color3.fromRGB(80, 157, 250)
		textLabel3.Font = Enum.Font.Gotham
		textLabel3.TextSize = 11
		textLabel3.TextXAlignment = Enum.TextXAlignment.Left
		textLabel3.ZIndex = 4
		textLabel3.Parent = frame
		pcall(function()
			local tween = TweenService:Create(frame, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, -125, 0, 14) })
			tween:Play()
			pcall(function() tween.Completed:Wait() end)
			task.wait(2.2)
			local tween2 = TweenService:Create(frame, TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Position = UDim2.new(0.5, -125, 0, -70) })
			tween2:Play()
			pcall(function() tween2.Completed:Wait() end)

			if screenGui then
				pcall(function() screenGui:Destroy() end)
			end
		end)

		flag14 = false
	end

	local function n175UpdateBestESP()
		if not _G.ESPBestEnabled then
			clearBestESP()
			return
		end
		local v14, v15, v16 = fn54()
		if not v14 or not v14.Parent then
			clearBestESP()
			return
		end
		local parent = v14.Parent
		local humanoidRootPart2 = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		local position = humanoidRootPart2 and humanoidRootPart2.Position
		local v17 = position and parent

			local worldPosition = parent:IsA("Attachment") and parent.WorldPosition or parent:IsA("BasePart") and parent.Position

			if worldPosition then
				n8 = math.floor((worldPosition - position).Magnitude)
			end
		end

		if v15 == _G.__bestPendingName then
			_G.__bestPendingTicks = (_G.__bestPendingTicks or 0) + 1
		else
			_G.__bestPendingName = v15
			_G.__bestPendingTicks = 1
		end

		if (_G.__bestPendingTicks or 0) >= 60 and v15 ~= v13 and not flag14 then
			local now = tick()

			if now - (_G.__bestLastNotifyTime or 0) >= 12 then
				v13 = v15
				_G.__bestLastNotifyTime = now

				task.spawn(function()
					fn56(v15, v16)
				end)
			end
		end

		if not billboardGui or billboardGui.Adornee ~= parent then
			clearBestESP()
			billboardGui = Instance.new("BillboardGui")
			billboardGui.Name = "BestPetESP"
			billboardGui.Size = UDim2.new(0, 160, 0, 55)
			billboardGui.StudsOffset = Vector3.new(0, 4, 0)
			billboardGui.AlwaysOnTop = true
			billboardGui.MaxDistance = 500
			billboardGui.Adornee = parent
			billboardGui.Parent = Workspace
			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, 0, 1, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.Text = (v15 or "Pet") .. "\n" .. (v16 or "?") .. "\n[" .. n8 .. "m]"
			textLabel.TextColor3 = Color3.fromRGB(80, 157, 250)
			textLabel.TextStrokeTransparency = 0.15
			textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
			textLabel.Font = Enum.Font.GothamBold
			textLabel.TextSize = 13
			textLabel.Parent = billboardGui
		else
			local textLabel = billboardGui:FindFirstChildWhichIsA("TextLabel")

			if textLabel then
				textLabel.Text = (v15 or "Pet") .. "\n" .. (v16 or "?") .. "\n[" .. n8 .. "m]"
				textLabel.TextColor3 = Color3.fromRGB(80, 157, 250)
			end
		end
	end

	if connection9 then
		pcall(function()
			connection9:Disconnect()
		end)
	end

	connection9 = RunService.Heartbeat:Connect(n175UpdateBestESP)
	_G._175_UpdateBestESP = n175UpdateBestESP

	_G._175_ClearBestNotify = function()
		v13 = nil
	end

	if _G.ESPBestEnabled then
		task.spawn(function()
			n175UpdateBestESP()
		end)
	end
end)

task.spawn(function()
	local ok2, result2 = pcall(function()
		local tbl11 = {}

		local function fn54()
			for k, v13 in pairs(tbl11) do
				pcall(function()
					v13:Destroy()
				end)

				tbl11[k] = nil
			end
		end

		local function createBillboardGui2(parent, adornee, arg)
			local billboardGui = Instance.new("BillboardGui")
			billboardGui.Name = "_BackpackESP"
			billboardGui.Size = UDim2.new(0, 40, 0, 40 * #arg + 3 * math.max(0, #arg - 1))
			billboardGui.StudsOffset = Vector3.new(3.2, 0, 0)
			billboardGui.AlwaysOnTop = true
			billboardGui.Adornee = adornee
			billboardGui.MaxDistance = 200
			billboardGui.Parent = parent
			local uiListLayout = Instance.new("UIListLayout")
			uiListLayout.FillDirection = Enum.FillDirection.Vertical
			uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			uiListLayout.Padding = UDim.new(0, 3)
			uiListLayout.Parent = billboardGui

			for _, v13 in ipairs(arg) do
				local imageLabel = Instance.new("ImageLabel")
				imageLabel.Size = UDim2.new(0, 40, 0, 40)
				imageLabel.BackgroundTransparency = 1
				imageLabel.Image = v13.texture and v13.texture ~= "" and v13.texture or ""
				imageLabel.ScaleType = Enum.ScaleType.Fit
				imageLabel.Parent = billboardGui
			end

			return billboardGui
		end

		local function fn55()
			if not _G.BackpackESP then
				fn54()
				return
			end
			local tbl12 = {}

			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= localPlayer then
					local character2 = player.Character
					local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")

					if humanoidRootPart2 then
						tbl12[player.UserId] = true
						local tbl13 = {}

						local function fn56(arg)
							if not arg then
								return
							end

							for _, child in ipairs(arg:GetChildren()) do
								if child:IsA("Tool") then
									local name = child.Name

									if name == "Giant Potion" and _G.ShowGiantPotion then
										table.insert(tbl13, { texture = child.TextureId or "" })
									elseif (name == "Flash Teleport" or string.find(string.lower(name), "flash")) and _G.ShowFlashTeleport then
										table.insert(tbl13, { texture = child.TextureId or "" })
									elseif (name == "Flying Carpet" or string.find(string.lower(name), "carpet")) and _G.ShowFlyingCarpet then
										table.insert(tbl13, { texture = child.TextureId or "" })
									end
								end
							end
						end

						fn56(player:FindFirstChild("Backpack"))
						fn56(character2)

						if #tbl13 == 0 then
							if tbl11[player.UserId] then
								pcall(function()
									tbl11[player.UserId]:Destroy()
								end)

								tbl11[player.UserId] = nil
							end
						else
							local v13 = tbl11[player.UserId]

							if not v13 or v13.Parent == nil or v13.Adornee ~= humanoidRootPart2 then
									pcall(function()
										v13:Destroy()
									end)
								end

								tbl11[player.UserId] = createBillboardGui2(character2, humanoidRootPart2, tbl13)
							end
						end
					end
				end
			end

			for k, v13 in pairs(tbl11) do
				if not tbl12[k] then
					pcall(function()
						v13:Destroy()
					end)

					tbl11[k] = nil
				end
			end
		end

		_G._175_SetBackpackESP = function(backpackESP)
			_G.BackpackESP = backpackESP

			if not backpackESP then
				fn54()
			end
		end

		task.spawn(function()
			while not flag do
				pcall(fn55)
				task.wait(1.2)
			end
		end)

		local tbl12 = {}

		local function fn56()
			for k, v13 in pairs(tbl12) do
				pcall(function()
					v13:Destroy()
				end)

				tbl12[k] = nil
			end
		end

		local function fn57()
			if not _G.BrainrotHighlight then
				fn56()
				return
			end
			if not v13 or not v13.Parent then
				fn56()
				return
			end
			local parent = v13.Parent
			local parent2 = parent and parent.Parent
			local parent3 = parent2 and parent2.Parent

			if parent3 and parent3.Name == "Base" then
				parent3 = parent3.Parent
			end

			local parent4 = parent3 and parent3.Parent and parent3.Parent
			local num = slot

			if not slot then
				if parent3 then
					num = tonumber(string.match(parent3.Name or "", "%d+"))
				else
					num = parent3
				end
			end

			local str = "selected_" .. tostring(num or 0) .. "_" .. tostring(v13:GetFullName())
			local tbl13 = { [str] = true }

			pcall(function()
				local worldPosition = parent:IsA("Attachment") and parent.WorldPosition or parent2 and parent2:IsA("BasePart") and parent2.Position
				if not worldPosition then
					return
				end
				local tbl14 = {}

				for _, player in pairs(Players:GetPlayers()) do
					tbl14[player.Name] = true
				end

				local v15 = parent4 or Workspace
				local n8 = 8

				for _, descendant in ipairs(v15:GetDescendants()) do
					if descendant:IsA("Model") and not tbl14[descendant.Name] then
						local primaryPart = descendant.PrimaryPart or descendant:FindFirstChild("RootPart") or descendant:FindFirstChildWhichIsA("BasePart")

						if primaryPart then
							local magnitude = (primaryPart.Position - worldPosition).Magnitude

							if magnitude < n8 then
								v14 = descendant
								n8 = magnitude
							end
						end
					end
				end
			end)

				local highlight = tbl12[str]

				if not (highlight and highlight.Parent and highlight.Adornee == v14) then
					if highlight then
						pcall(function()
							highlight:Destroy()
						end)
					end

					highlight = Instance.new("Highlight")
					highlight.Name = "_BrainrotHL"
					highlight.Adornee = v14
					highlight.FillColor = Color3.fromRGB(40, 140, 255)
					highlight.OutlineColor = Color3.fromRGB(80, 180, 255)
					highlight.FillTransparency = 0.45
					highlight.OutlineTransparency = 0
					highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
					highlight.Parent = v14
					tbl12[str] = highlight
				end
			end

			for k, v15 in pairs(tbl12) do
				if not tbl13[k] then
					pcall(function()
						v15:Destroy()
					end)

					tbl12[k] = nil
				end
			end
		end

		_G._175_SetBrainrotHL = function(brainrotHighlight)
			_G.BrainrotHighlight = brainrotHighlight

			if not brainrotHighlight then
				fn56()
			end
		end

		task.spawn(function()
			while not flag do
				pcall(fn57)
				task.wait(0.6)
			end
		end)

		local textBox = nil
		local flag14 = false

		task.spawn(function()
			pcall(function()
				textBox = localPlayer.PlayerGui:WaitForChild("AdminPanel", 20):WaitForChild("AdminPanel", 10):WaitForChild("CommandBox", 10):WaitForChild("TextBox", 10)
			end)
		end)

		local function fn58(arg, arg2)
			if not arg2 then
				return
			end

			if not textBox or not textBox.Parent then
				pcall(function()
					local ap = playerGui:FindFirstChild("AdminPanel") or (gethui and gethui():FindFirstChild("AdminPanel")) or (CoreGui and CoreGui:FindFirstChild("AdminPanel"))
					local inner = ap and ap:FindFirstChild("AdminPanel")
					local cb = inner and inner:FindFirstChild("CommandBox")
					textBox = cb and cb:FindFirstChild("TextBox")
				end)
			end

			if not textBox then
				return
			end
			local visible = textBox.Visible
			textBox.Visible = false
			textBox.Text = ";" .. arg .. " " .. arg2
			task.wait(0.04)

			pcall(function()
				if firesignal then
					firesignal(textBox.FocusLost, true)
				elseif getconnections then
					for _, v14 in pairs(getconnections(textBox.FocusLost)) do
						if v14.Fire then
							v14:Fire(true)
						elseif v14.Function then
							v14.Function(true)
						end
					end
				else
					textBox:CaptureFocus()
					task.wait(0.02)
					textBox:ReleaseFocus(true)
				end
			end)

			task.wait(0.04)
			textBox.Text = ""
			textBox.Visible = visible
		end

		local function fn59()
				pcall(function()
					v13:Destroy()
				end)
			end

			v13 = nil
			flag14 = false
		end

		local function fn60()
			fn59()
			local screenGui = Instance.new("ScreenGui")
			screenGui.Name = "175QuickAP"
			screenGui.ResetOnSpawn = false
			screenGui.DisplayOrder = 1200
			screenGui.IgnoreGuiInset = true

			pcall(function()
				if gethui then
					screenGui.Parent = gethui()
				else
					screenGui.Parent = CoreGui
				end
			end)

			if not screenGui.Parent then
				screenGui.Parent = playerGui
			end

			v13 = screenGui
			local color = Color3.fromRGB(24, 32, 44)
			local color2 = Color3.fromRGB(24, 32, 44)
			local color3 = Color3.fromRGB(24, 32, 44)
			local color4 = Color3.fromRGB(24, 32, 44)
			local color5 = Color3.fromRGB(80, 157, 250)
			local color6 = Color3.fromRGB(255, 255, 255)
			local color7 = Color3.fromRGB(255, 255, 255)
			local n8 = 26
			local n9 = 24
			local n10 = 26
			local frame = Instance.new("Frame")
			frame.Size = UDim2.new(0, 168, 0, 26)
			frame.Position = _G.QapPos or UDim2.new(0.02, 0, 0.32, 0)
			frame.BackgroundColor3 = color
			frame.BorderSizePixel = 0
			frame.Active = true
			frame.ClipsDescendants = true
			frame.Parent = screenGui
			Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
			local uiStroke = Instance.new("UIStroke")
			uiStroke.Thickness = 1.5
			uiStroke.Parent = frame
			local uiGradient = Instance.new("UIGradient")
			local new = ColorSequenceKeypoint.new
			uiGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, color5), new(1, color6) })
			uiGradient.Parent = uiStroke
			local frame2 = Instance.new("Frame")
			frame2.Size = UDim2.new(1, 0, 0, 26)
			frame2.BackgroundColor3 = color2
			frame2.BorderSizePixel = 0
			frame2.Parent = frame
			Instance.new("UICorner", frame2).CornerRadius = UDim.new(0, 8)
			local uiGradient2 = Instance.new("UIGradient")
			local new2 = ColorSequenceKeypoint.new
			local color8 = Color3.fromRGB
			uiGradient2.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 32, 44)), new2(1, color8(49, 65, 87)) })
			uiGradient2.Parent = frame2
			local textLabel = Instance.new("TextLabel")
			textLabel.Size = UDim2.new(1, -56, 1, 0)
			textLabel.Position = UDim2.new(0, 8, 0, 0)
			textLabel.BackgroundTransparency = 1
			textLabel.Text = "Quick AP"
			textLabel.TextColor3 = color7
			textLabel.Font = Enum.Font.GothamBold
			textLabel.TextSize = 11
			textLabel.TextXAlignment = Enum.TextXAlignment.Left
			textLabel.Parent = frame2
			local textButton = Instance.new("TextButton")
			textButton.Size = UDim2.new(0, 20, 0, 20)
			textButton.Position = UDim2.new(1, -46, 0.5, -10)
			textButton.BackgroundColor3 = Color3.fromRGB(49, 65, 87)
			textButton.Text = "-"
			textButton.TextColor3 = Color3.new(1, 1, 1)
			textButton.Font = Enum.Font.GothamBold
			textButton.TextSize = 13
			textButton.BorderSizePixel = 0
			textButton.Parent = frame2
			Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 5)
			local textButton2 = Instance.new("TextButton")
			textButton2.Size = UDim2.new(0, 20, 0, 20)
			textButton2.Position = UDim2.new(1, -24, 0.5, -10)
			textButton2.BackgroundColor3 = Color3.fromRGB(49, 65, 87)
			textButton2.Text = "X"
			textButton2.TextColor3 = Color3.new(1, 1, 1)
			textButton2.Font = Enum.Font.GothamBold
			textButton2.TextSize = 11
			textButton2.BorderSizePixel = 0
			textButton2.Parent = frame2
			Instance.new("UICorner", textButton2).CornerRadius = UDim.new(0, 5)

			textButton2.MouseButton1Click:Connect(function()
				_G.QuickAP = false
				fn59()
				pcall(fn10)
			end)

			local frame3 = Instance.new("Frame")
			frame3.Size = UDim2.new(1, -6, 1, -(n8 + 2))
			frame3.Position = UDim2.new(0, 3, 0, n8 + 1)
			frame3.BackgroundTransparency = 1
			frame3.Parent = frame
			local uiListLayout = Instance.new("UIListLayout")
			uiListLayout.Padding = UDim.new(0, 3)
			uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			uiListLayout.Parent = frame3

			local tbl13 = {
				{ name = "tiny", emoji = "🧍" },
				{ name = "jail", emoji = "🔒" },
				{ name = "rocket", emoji = "🚀" },
				{ name = "ragdoll", emoji = "😵" },
				{ name = "balloon", emoji = "🎈" },

			local function fn61(arg)
				if flag14 then
					frame.Size = UDim2.new(0, 168, 0, n10)
					frame3.Visible = false
					return
				end

				frame3.Visible = true

				if arg <= 0 then
					frame.Size = UDim2.new(0, 168, 0, n10)
					frame3.Visible = false
				else
					frame.Size = UDim2.new(0, 168, 0, n8 + 4 + arg * (n9 + 3))
					frame3.Visible = true
				end
			end

			local fn62 = nil

			textButton.MouseButton1Click:Connect(function()
				flag14 = not flag14

				if flag14 then
					textButton.Text = "+"
					frame3.Visible = false
					frame.Size = UDim2.new(0, 168, 0, n10)
				else
					textButton.Text = "-"

					if fn62 then
						fn62()
					end
				end
			end)

			local flag15 = false
			local position = nil
			local position2 = nil

			frame2.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					flag15 = true
					position = input.Position
					position2 = frame.Position
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				local flag16 = flag15

				if flag15 then
					flag16 = input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
				end

				if flag16 then
					local n11 = input.Position - position
					frame.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n11.X, position2.Y.Scale, position2.Y.Offset + n11.Y)
					_G.QapPos = frame.Position
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					if flag15 then
						flag15 = false
						_G.QapPos = frame.Position
						pcall(fn10)
					end
				end
			end)

			fn62 = function()
				for _, child in ipairs(frame3:GetChildren()) do
					if child:IsA("Frame") then
						child:Destroy()
					end
				end

				local layoutOrder = 0

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= localPlayer then
						layoutOrder += 1
						local frame4 = Instance.new("Frame")
						frame4.Size = UDim2.new(1, 0, 0, 24)
						frame4.BackgroundColor3 = color3
						frame4.BorderSizePixel = 0
						frame4.LayoutOrder = layoutOrder
						frame4.Parent = frame3
						Instance.new("UICorner", frame4).CornerRadius = UDim.new(0, 5)
						local imageLabel = Instance.new("ImageLabel")
						imageLabel.Size = UDim2.new(0, 18, 0, 18)
						imageLabel.Position = UDim2.new(0, 3, 0.5, -9)
						imageLabel.BackgroundColor3 = Color3.fromRGB(24, 32, 44)
						imageLabel.BorderSizePixel = 0
						imageLabel.Parent = frame4
						Instance.new("UICorner", imageLabel).CornerRadius = UDim.new(1, 0)

						task.spawn(function()
							pcall(function()
								imageLabel.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
							end)
						end)

						local textLabel2 = Instance.new("TextLabel")
						textLabel2.Size = UDim2.new(0, 50, 1, 0)
						textLabel2.Position = UDim2.new(0, 24, 0, 0)
						textLabel2.BackgroundTransparency = 1
						textLabel2.Text = player.DisplayName
						textLabel2.TextColor3 = color7
						textLabel2.Font = Enum.Font.Gotham
						textLabel2.TextSize = 10
						textLabel2.TextXAlignment = Enum.TextXAlignment.Left
						textLabel2.TextTruncate = Enum.TextTruncate.AtEnd
						textLabel2.Parent = frame4

						for i, v14 in ipairs(tbl13) do
							local textButton3 = Instance.new("TextButton")
							textButton3.Size = UDim2.new(0, 18, 0, 18)
							textButton3.Position = UDim2.new(1, -((#tbl13 - i + 1) * 20) - 2, 0.5, -9)
							textButton3.BackgroundColor3 = color4
							textButton3.Text = v14.emoji
							textButton3.TextColor3 = Color3.new(1, 1, 1)
							textButton3.Font = Enum.Font.GothamBold
							textButton3.TextSize = 11
							textButton3.BorderSizePixel = 0
							textButton3.Parent = frame4
							Instance.new("UICorner", textButton3).CornerRadius = UDim.new(0, 4)

							textButton3.MouseButton1Click:Connect(function()
								task.spawn(function()
									fn58(v14.name, player.Name)
								end)
							end)
						end
					end
				end

				fn61(layoutOrder)
			end

			fn62()

			Players.PlayerAdded:Connect(function()
				task.wait(0.3)

					fn62()
				end
			end)

			Players.PlayerRemoving:Connect(function()
				task.wait(0.2)

					fn62()
				end
			end)
		end

		_G._175_SetQuickAP = function(quickAP)
			_G.QuickAP = quickAP

			if quickAP then
				fn60()
			else
				fn59()
			end
		end

		task.spawn(function()
			local function fn61(arg)
				if not arg or not arg:IsA("Tool") then
					return false
				end
				local str = arg.Name:lower()
				if str:find("gun") or str:find("pistol") or str:find("rifle") then
					return false
				end

				if arg.Name == "Laser Cape" then
					return true
				end

				if str:find("laser") and str:find("cape") then
					return true
				end
				return false
			end

			local function fn62()
				local character2 = localPlayer.Character
				local backpack = localPlayer:FindFirstChild("Backpack")

				for _, v14 in ipairs({ backpack, character2 }) do
						local laserCape = v14:FindFirstChild("Laser Cape")
						if laserCape and laserCape:IsA("Tool") then
							return laserCape
						end
					end
				end

				for _, v14 in ipairs({ backpack, character2 }) do
						for _, child in ipairs(v14:GetChildren()) do
							if fn61(child) then
								return child
							end
						end
					end
				end

				return nil
			end

			local function fn63()
				if v14 and v14.Parent then
					return v14
				end

				pcall(function()
					local packages = ReplicatedStorage:FindFirstChild("Packages")
					packages = packages and packages:FindFirstChild("Net")
					packages = packages and packages:FindFirstChild("RE")
					local useItem = packages and packages:FindFirstChild("UseItem")

					if useItem then
						v14 = useItem
					end
				end)

				return v14
			end

			local function fn64(arg)
				if not arg or not arg.Character then
					return
				end
				local humanoidRootPart2 = arg.Character:FindFirstChild("HumanoidRootPart")
				if not humanoidRootPart2 then
					return
				end
				local character2 = localPlayer.Character
				if not character2 then
					return
				end
				local humanoid2 = character2:FindFirstChildOfClass("Humanoid")
				if not humanoid2 then
					return
				end
				local v15 = fn62()
				if not v15 then
					return
				end

				if v15.Parent ~= character2 then
					pcall(function()
						humanoid2:UnequipTools()
					end)

					task.wait(0.05)

					pcall(function()
						humanoid2:EquipTool(v15)
					end)

					task.wait(0.12)
				end

				if not fn61(character2:FindFirstChildOfClass("Tool")) then
					return
				end
				local position = humanoidRootPart2.Position
				local v16 = fn63()

					pcall(function()
						if v16:IsA("RemoteEvent") then
							v16:FireServer(position, humanoidRootPart2)
						elseif v16:IsA("RemoteFunction") then
							v16:InvokeServer(position, humanoidRootPart2)
						end
					end)
				end

				if v9 and v10 then
					pcall(function()
						v10(v9, position, humanoidRootPart2)
					end)
				end

				pcall(function()
					if v15.Parent == character2 then
						v15:Activate()
					end
				end)
			end

			local function fn65(arg)
				if not arg then
					return
				end
				local name = arg.Name
				local antiStealAP = _G.AntiStealAP

				if type(antiStealAP) ~= "table" then
					antiStealAP = { balloon = true }
				end

				local flag15 = false

				for _, v15 in ipairs({ "balloon", "ragdoll", "rocket", "jail", "tiny", "inverse", "jumpscare", "morph" }) do
					if antiStealAP[v15] == true then
						pcall(function()
							if type(fn58) == "function" then
								fn58(v15, name)
							end
						end)

						task.wait(0.12)
						flag15 = true
					end
				end

				if not flag15 then
					pcall(function()
						if type(fn58) == "function" then
							fn58("balloon", name)
						end
					end)
				end
			end

			local function fn66()
				local plots = Workspace:FindFirstChild("Plots")
				if not plots then
					return nil
				end

				for _, child in ipairs(plots:GetChildren()) do
					local flag15 = false

					pcall(function()
						if fn44(child) then
							flag15 = true
						end
					end)

					if not flag15 then
						pcall(function()
							local plotSign = child:FindFirstChild("PlotSign")
							if not plotSign then
								return
							end
							local yourBase = plotSign:FindFirstChild("YourBase")

							if yourBase and yourBase:IsA("BillboardGui") and yourBase.Enabled then
								flag15 = true
							end
						end)
					end

					if flag15 then
						local ok2, result2 = pcall(function()
							return child:GetBoundingBox()
						end)

						if ok2 and result2 then
							return result2.Position
						end
					end
				end

				return nil
			end

			local function fn67()
				local v15 = fn66()
				local huge = math.huge

				for _, player in ipairs(Players:GetPlayers()) do
					if player ~= localPlayer and player.Character then
						local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")

						if humanoidRootPart2 then
							local flag15 = false

							pcall(function()
								flag15 = player:GetAttribute("Stealing") == true or player:GetAttribute("IsStealing") == true or player.Character:GetAttribute("Stealing") == true
							end)

							if flag15 then
								return player
							end

								local magnitude = (humanoidRootPart2.Position - v15).Magnitude

								if magnitude < huge then
									v16 = player
									huge = magnitude
								end
							end
						end
					end
				end

				if v16 and huge < 120 then
					return v16
				end
				return v16
			end

			local flag15 = false
			local str = ""

			local function fn68(arg)
				if not _G.AntiSteal or flag then
					return
				end

				if flag15 then
					return
				end
				local now = tick()
				if now - n8 < 3 then
					return
				end

				if arg and arg == str and now - n8 < 8 then
					return
				end

				if arg then
					str = arg
				end

				n8 = now
				flag15 = true
				local num = tonumber(_G.AntiStealDelay)

				if not num or num ~= num or num < 0.3 then
					num = 1.8
				end

				local n9 = math.clamp(num, 0.3, 60)

				task.spawn(function()
					task.wait(n9)
					if flag or not _G.AntiSteal then
						flag15 = false
						return
					end
					local v15 = fn67()

						if tostring(_G.AntiStealMode or "laser"):lower() == "ap" then
							fn65(v15)
							task.wait(0.15)
							fn65(v15)
						else
							fn64(v15)
							task.wait(0.25)
							fn64(v15)
						end
					end

					task.wait(2)
					flag15 = false
				end)
			end

			local function fn69(arg)
				if type(arg) ~= "string" or #arg < 10 then
					return false
				end
				local str2 = arg:lower()
				if str2:find("someone is stealing your", 1, true) then
					return true
				end

				if str2:find("is stealing your", 1, true) then
					return true
				end
				return false
			end

			local obj = setmetatable({}, { __mode = "k" })

			local function fn70(arg)
				if not arg or obj[arg] then
					return
				end

				if not (arg:IsA("TextLabel") or arg:IsA("TextButton")) then
					return
				end
				obj[arg] = true

				pcall(function()
					arg:GetPropertyChangedSignal("Text"):Connect(function()
						if not _G.AntiSteal then
							return
						end
						local text = arg.Text

						if fn69(text) then
							fn68(text)
						end
					end)

					if _G.AntiSteal and fn69(arg.Text) then
						fn68(arg.Text)
					end
				end)
			end

			local function fn71(arg)
				if not arg then
					return
				end

				for _, descendant in ipairs(arg:GetDescendants()) do
					if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
						fn70(descendant)
					end
				end
			end

			pcall(function()
				fn71(playerGui)
			end)

			playerGui.DescendantAdded:Connect(function(descendant)
				if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
					task.defer(fn70, descendant)
				end
			end)

			task.spawn(function()
				while not flag do
					task.wait(1.5)

					if _G.AntiSteal then
						pcall(function()
							for _, descendant in ipairs(playerGui:GetDescendants()) do
								if descendant:IsA("TextLabel") and fn69(descendant.Text) then
									fn68(descendant.Text)
									break
								end
							end
						end)
					end
				end
			end)
		end)

		task.spawn(function()
			task.wait(0.5)

			local function fn61(arg)
				if not arg then
					return
				end

				pcall(function()
					if localPlayer:GetAttribute("BlockTools") then
						localPlayer:SetAttribute("BlockTools", false)
					end

					if localPlayer:GetAttribute("Web") then
						localPlayer:SetAttribute("Web", false)
					end

					if arg:GetAttribute("BlockTools") then
						arg:SetAttribute("BlockTools", false)
					end

					if arg:GetAttribute("Web") then
						arg:SetAttribute("Web", false)
					end

					if arg:GetAttribute("BackpackReady") == false then
						arg:SetAttribute("BackpackReady", true)
					end
				end)
			end

			pcall(function()
				workspace.ChildAdded:Connect(function(child)
					if _G.antiGummyEnabled and child.Name == "GummyBear" then
						pcall(function()
							child:Destroy()
						end)
					end
				end)
			end)

			while not flag do
				task.wait(0.2)

				if _G.antiGummyEnabled then
					pcall(fn61, localPlayer.Character)

					pcall(function()
						for _, child in pairs(workspace:GetChildren()) do
							if child.Name == "GummyBear" then
								pcall(function()
									child:Destroy()
								end)
							end
						end
					end)
				end
			end
		end)

		if _G.BackpackESP then
			_G._175_SetBackpackESP(true)
		end

		if _G.BrainrotHighlight then
			_G._175_SetBrainrotHL(true)
		end

		if _G.QuickAP then
			task.defer(function()
				_G._175_SetQuickAP(true)
			end)
		end

		print("prince")
	end)

	if not ok2 then
		print("prince")
	end
end)

task.spawn(function()
	local autoTurretEnabled = _G.AutoTurretEnabled == true
	local lp = game:GetService("Players").LocalPlayer
	local turretConns = {}
	local turretLoopRunning = false
	local turretAttackBusy, turretAttackQueued, turretAttackCD = {}, {}, {}
	local turretAttackActive = false
	local RETRY_DELAY = 0.3

	local function isEnemyTurret(obj)
		if not obj or not obj:IsA("BasePart") then return false end
		local ownerId = obj.Name:match("^Sentry_(%d+)$")
		return ownerId ~= nil and ownerId ~= tostring(lp.UserId)
	end

	local function setTurretNoClip(turret)
		if isEnemyTurret(turret) then pcall(function() turret.CanCollide = false end) end
	end

	local function getTurretTimeLabel(turret)
		local sf = turret and turret:FindFirstChild("SetupFrame")
		local mf = sf and sf:FindFirstChild("MainFrame")
		local lbl = mf and mf:FindFirstChild("Time")
		return (lbl and lbl:IsA("TextLabel")) and lbl or nil
	end

	local function shouldAttackTurret(turret)
		if not lp then return false end
		local isStealing = (lp:GetAttribute("Stealing") == true) or (lp:GetAttribute("IsStealing") == true)
		if not isStealing and lp.Character then
			isStealing = (lp.Character:GetAttribute("Stealing") == true) or (lp.Character:GetAttribute("IsStealing") == true)
		end
		if isStealing then return false end
		if not isEnemyTurret(turret) then return false end
		setTurretNoClip(turret)
		local lbl = getTurretTimeLabel(turret)
		if not lbl then return false end
		local ok, text = pcall(function() return lbl.Text end)
		if not ok then return false end
		text = tostring(text or ""):gsub("^%s+", ""):gsub("%s+$", "")
		return text ~= "" and string.find(text, "^%d+s!$") ~= nil
	end

	local function bringTurretInFront(turret, hrp)
		if not turret or not hrp then return end
		local fwd = hrp.CFrame.LookVector
		local pos = hrp.Position + fwd * 4 + Vector3.new(0, 1.2, 0)
		pcall(function()
			if hrp.AssemblyLinearVelocity ~= nil then hrp.AssemblyLinearVelocity = Vector3.zero end
			turret.CFrame = CFrame.lookAt(pos, pos + fwd)
		end)
	end

	local function attackTurret(turret)
		local now = tick()
		if turretAttackBusy[turret] or turretAttackQueued[turret] or turretAttackActive then return end
		if not shouldAttackTurret(turret) then return end
		if (turretAttackCD[turret] or 0) > now then return end
		turretAttackQueued[turret] = true
		turretAttackCD[turret] = now + RETRY_DELAY
		task.spawn(function()
			turretAttackQueued[turret] = nil
			if turretAttackActive or turretAttackBusy[turret] then return end
			if not shouldAttackTurret(turret) then return end
			turretAttackActive = true
			turretAttackBusy[turret] = true
			pcall(function()
				local attempts = 0
				while attempts < 12 and autoTurretEnabled do
					if not turret or not turret.Parent or not shouldAttackTurret(turret) then break end
					local char = lp.Character
					local hrp = char and char:FindFirstChild("HumanoidRootPart")
					local hum = char and char:FindFirstChildOfClass("Humanoid")
					if not hrp or not hum or hum.Health <= 0 then break end
					local okD, dist = pcall(function() return (turret.Position - hrp.Position).Magnitude end)
					if okD and dist > 220 then break end
					setTurretNoClip(turret)
					bringTurretInFront(turret, hrp)
					local bp = lp:FindFirstChildOfClass("Backpack")
					local bat = (char and char:FindFirstChild("Bat")) or (bp and bp:FindFirstChild("Bat"))
					if bat and char and bat.Parent ~= char then pcall(function() hum:EquipTool(bat) end) end
					bat = (char and char:FindFirstChild("Bat")) or bat
					if bat then pcall(function() bat:Activate() end) end
					task.wait(0.03)
					attempts = attempts + 1
					task.wait(0.09)
				end
			end)
			turretAttackBusy[turret] = nil
			turretAttackActive = false
		end)
	end

	local function disconnectAll()
		for i = 1, #turretConns do pcall(function() turretConns[i]:Disconnect() end) end
		turretConns = {}
	end

	local function startAutoTurret()
		disconnectAll()
		table.insert(turretConns, Workspace.DescendantAdded:Connect(function(obj)
			if isEnemyTurret(obj) then setTurretNoClip(obj) end
			if autoTurretEnabled and shouldAttackTurret(obj) then
				task.spawn(function() attackTurret(obj) end)
			end
		end))
		if not turretLoopRunning then
			turretLoopRunning = true
			task.spawn(function()
				while autoTurretEnabled do
					task.wait(0.4)
					for _, obj in ipairs(Workspace:GetChildren()) do
						if isEnemyTurret(obj) then setTurretNoClip(obj) end
						if autoTurretEnabled and shouldAttackTurret(obj) then attackTurret(obj) end
					end
				end
				turretLoopRunning = false
			end)
		end
	end

	_G._175_AT = function(state)
		autoTurretEnabled = state and true or false
		_G.AutoTurretEnabled = autoTurretEnabled
		if autoTurretEnabled then startAutoTurret() else disconnectAll() end
	end

	if _G.AutoTurretEnabled == true then _G._175_AT(true) end
	print("prince")
end)

task.spawn(function()
	local vector = Vector3.new(-350.8919, -6.6011, 108.6947)
	local n8 = 22
	local n9 = 5
	local n10 = 22
	local connection9 = nil
	local flag14 = false

	local function n175StopReturnBase()
		flag14 = false

		if connection9 then
			pcall(function()
				connection9:Disconnect()
			end)

			connection9 = nil
		end

		local character2 = localPlayer.Character
		character2 = character2 and character2:FindFirstChild("HumanoidRootPart")

		if character2 then
			for _, v13 in ipairs({ "ReturnVelocity", "LinearVelocity", "ReturnAttachment", "Attachment" }) do
				local v14 = character2:FindFirstChild(v13)

					pcall(function()
						v14:Destroy()
					end)
				end
			end
		end
	end

	local function n175StartReturnBase()
		if flag14 then
			return
		end
		local character2 = localPlayer.Character
		local humanoid2 = character2 and character2:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart2 or not humanoid2 or humanoid2.Health <= 0 then
			return
		end

		if connection then
			pcall(function()
				connection:Disconnect()
			end)

			connection = nil
		end

		flag9 = false
		n175StopReturnBase()
		flag14 = true
		local walkSpeed = humanoid2.WalkSpeed
		local jumpPower = humanoid2.JumpPower

		pcall(function()
			humanoid2.WalkSpeed = 0
			humanoid2.JumpPower = 0
			humanoid2.AutoRotate = false
		end)

		local function fn54(arg)
			if not arg then
				return nil
			end

			for _, child in ipairs(arg:GetChildren()) do
				if child:IsA("Tool") then
					local str = child.Name:lower()
					if str:find("carpet") or str:find("broom") or str:find("waverider") or str:find("sleigh") or str:find("wings") then
						return child
					end
				end
			end

			return nil
		end

		local v13 = fn54(character2) or fn54(localPlayer:FindFirstChild("Backpack"))

			pcall(function()
				humanoid2:UnequipTools()
			end)

			task.wait(0.05)

			pcall(function()
				humanoid2:EquipTool(v13)
			end)
		end

		for _, v14 in ipairs({ "ReturnVelocity", "LinearVelocity", "ReturnAttachment", "Attachment" }) do
			local v15 = humanoidRootPart2:FindFirstChild(v14)

				pcall(function()
					v15:Destroy()
				end)
			end
		end

		local attachment = Instance.new("Attachment")
		attachment.Name = "ReturnAttachment"
		attachment.Parent = humanoidRootPart2
		local linearVelocity = Instance.new("LinearVelocity")
		linearVelocity.Name = "ReturnVelocity"
		linearVelocity.Attachment0 = attachment
		linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
		linearVelocity.MaxForce = math.huge
		linearVelocity.VectorVelocity = Vector3.zero
		linearVelocity.Parent = humanoidRootPart2
		local now = os.clock()

		local function fn55()
			pcall(function()
				if humanoid2 and humanoid2.Parent then
					humanoid2.WalkSpeed = walkSpeed
					humanoid2.JumpPower = jumpPower
					humanoid2.AutoRotate = true
				end
			end)

			pcall(function()
				if linearVelocity then
					linearVelocity:Destroy()
				end
			end)

			pcall(function()
				if attachment then
					attachment:Destroy()
				end
			end)
		end

		local vector2 = Vector3.new(-348.2184, -6.6011, 7.1711)
		local flag15 = slot

			flag15 = v14 >= 1
		end

		local flag16 = not (flag15 and v14 <= 10)

		connection9 = RunService.Heartbeat:Connect(function()
			if flag or not flag14 then
				fn55()
				n175StopReturnBase()
				return
			end

			if not humanoidRootPart2 or not humanoidRootPart2.Parent or not humanoid2 or humanoid2.Health <= 0 then
				fn55()
				n175StopReturnBase()
				return
			end

			local position = humanoidRootPart2.Position

			if not flag16 then
				local vector3 = Vector3.new(vector2.X - position.X, 0, vector2.Z - position.Z)
				local magnitude = vector3.Magnitude

				if not (magnitude <= n9) then
					local y = position.Y
					local n11 = math.clamp((vector2.Y + 3 + math.sin((os.clock() - now) * 2) * 1.5 - y) * 3, -8, 8)
					local n12 = magnitude < n10 and math.max(0.25, magnitude / n10) or 1

					if vector3.Magnitude > 0.1 then
						linearVelocity.VectorVelocity = Vector3.new(vector3.Unit.X * n8 * n12, n11, vector3.Unit.Z * n8 * n12)
					end

					return
				end

				flag16 = true
			end

			local vector3 = Vector3.new(vector.X - position.X, 0, vector.Z - position.Z)
			local magnitude = vector3.Magnitude

			if magnitude <= n9 then
				linearVelocity.VectorVelocity = Vector3.zero

				pcall(function()
					humanoidRootPart2.AssemblyLinearVelocity = Vector3.zero
				end)

				pcall(function()
					humanoidRootPart2.CFrame = CFrame.new(Vector3.new(-350.8919, -6.6011, 108.6947))
				end)

				fn55()
				n175StopReturnBase()
				return
			end

			local y = position.Y
			local n11 = math.clamp((vector.Y + 3 + math.sin((os.clock() - now) * 2) * 1.5 - y) * 3, -8, 8)
			local n12 = magnitude < n10 and math.max(0.25, magnitude / n10) or 1

			if vector3.Magnitude > 0.1 then
				linearVelocity.VectorVelocity = Vector3.new(vector3.Unit.X * n8 * n12, n11, vector3.Unit.Z * n8 * n12)
			end
		end)
	end

	_G._175_StartReturnBase = n175StartReturnBase
	_G._175_StopReturnBase = n175StopReturnBase

	local function fn54()
		local character2 = localPlayer.Character
		local humanoidRootPart2 = character2 and character2:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart2 then
			return false
		end

		if (humanoidRootPart2.Position - vector).Magnitude < 55 then
			return true
		end
		local plots = Workspace:FindFirstChild("Plots")
		if not plots then
			return false
		end

		for _, child in ipairs(plots:GetChildren()) do
			local plotSign = child:FindFirstChild("PlotSign")
			local yourBase = plotSign and plotSign:FindFirstChild("YourBase")

			if yourBase and yourBase:IsA("BillboardGui") and yourBase.Enabled then
				local ok2, result2 = pcall(function()
					return child:GetPivot()
				end)

				if ok2 and result2 and (humanoidRootPart2.Position - result2.Position).Magnitude < 90 then
					return true
				end
			end
		end

		return false
	end

	local function fn55()
		if not _G.AutoReturnBase or flag then
			return false
		end
		local flag15 = false

		pcall(function()
			flag15 = localPlayer:GetAttribute("Stealing") == true or localPlayer:GetAttribute("IsStealing") == true
		end)

		if not flag15 then
			return false
		end

		if fn54() then
			return false
		end
		return true
	end

	local function onStealingChanged()
		if not fn55() then
			return
		end

		task.defer(function()
			if fn55() and not flag14 then
				n175StartReturnBase()
			end
		end)
	end

	table.insert(tbl, localPlayer:GetAttributeChangedSignal("Stealing"):Connect(onStealingChanged))
	table.insert(tbl, localPlayer:GetAttributeChangedSignal("IsStealing"):Connect(onStealingChanged))
	table.insert(tbl, localPlayer.CharacterAdded:Connect(function(newChar)
		table.insert(tbl, newChar:GetAttributeChangedSignal("Stealing"):Connect(onStealingChanged))
		table.insert(tbl, newChar:GetAttributeChangedSignal("IsStealing"):Connect(onStealingChanged))
	end))
end)

task.spawn(function()
	local ok2, result2 = pcall(function()
		local Lighting = game:GetService("Lighting")
		local MaterialService = game:GetService("MaterialService")
		local flag14 = false
		local flag15 = false
		local flag16 = false
		local tbl11 = {}
		local tbl12 = {}
		local connection9 = nil

		local function fn54()
			flag14 = true

			pcall(function()
				if setfpscap then
					setfpscap(999)
				end

				local level01 = Enum.QualityLevel.Level01
				settings().Rendering.QualityLevel = level01
			end)
		end

		local function fn55()
			flag14 = false
		end

		local function fn56(arg)
			pcall(function()
				if arg:IsA("ParticleEmitter") or arg:IsA("Trail") or arg:IsA("Beam") or arg:IsA("Smoke") or arg:IsA("Fire") or arg:IsA("Sparkles") then
					arg.Enabled = false
					arg:Destroy()
				elseif arg:IsA("PointLight") or arg:IsA("SpotLight") or arg:IsA("SurfaceLight") then
					arg:Destroy()
				elseif arg:IsA("Decal") or arg:IsA("Texture") then
					if not (arg.Name == "face" and arg.Parent and arg.Parent.Name == "Head") then
						arg:Destroy()
					end
				elseif arg:IsA("SpecialMesh") then
					arg.TextureId = ""
				end
			end)
		end

		local function fn57()
			flag15 = true

			for _, descendant in ipairs(Workspace:GetDescendants()) do
				fn56(descendant)
			end

			for _, player in ipairs(Players:GetPlayers()) do
				if player.Character then
					for _, descendant in ipairs(player.Character:GetDescendants()) do
						fn56(descendant)
					end
				end
			end

			if connection9 then
				connection9:Disconnect()
			end

			connection9 = Workspace.DescendantAdded:Connect(function(descendant)
				if flag15 then
					task.defer(fn56, descendant)
				end
			end)
		end

		local function fn58()
			flag15 = false

			if connection9 then
				connection9:Disconnect()
				connection9 = nil
			end
		end

		local function fn59()
			if flag16 then
				return
			end
			flag16 = true

			local tbl13 = {

			local function fn60(arg)
				if arg and arg.Name == "Overhead" then
					return
				end

				pcall(function()
					arg:Destroy()
				end)
			end

			local function fn61(arg)
				for _, v13 in ipairs(tbl13) do
					if arg:IsA(v13) then
						return true
					end
				end

				return false
			end

			local function fn62(arg)
				for _, player in ipairs(Players:GetPlayers()) do
					if player.Character and arg:IsDescendantOf(player.Character) then
						return true
					end
				end

				return false
			end

			local function fn63(arg)
				pcall(function()
					if arg:IsA("SurfaceAppearance") or arg:IsA("Decal") or arg:IsA("Texture") then
						if not (arg.Name == "face" and arg.Parent and arg.Parent.Name == "Head") then
							fn60(arg)
						end
					elseif arg:IsA("SpecialMesh") then
						arg.TextureId = ""
					elseif arg:IsA("ParticleEmitter") or arg:IsA("Trail") or arg:IsA("Beam") or arg:IsA("PointLight") or arg:IsA("SpotLight") or arg:IsA("SurfaceLight") or arg:IsA("Fire") or arg:IsA("Smoke") or arg:IsA("Sparkles") or arg:IsA("Explosion") then
						fn60(arg)
					elseif arg:IsA("BasePart") then
						arg.CastShadow = false
						arg.Material = Enum.Material.Plastic
						arg.MaterialVariant = ""
						arg.Reflectance = 0
					end
				end)
			end

			local function fn64()
				pcall(function()
					for _, child in ipairs(Lighting:GetChildren()) do
						if child:IsA("Sky") then
							child:Destroy()
						end
					end

					local sky = Instance.new("Sky")
					sky.SkyboxBk = ""
					sky.SkyboxDn = ""
					sky.SkyboxFt = ""
					sky.SkyboxLf = ""
					sky.SkyboxRt = ""
					sky.SkyboxUp = ""
					sky.CelestialBodiesShown = false
					sky.Name = "_AceNukeSky"
					sky.Parent = Lighting
				end)
			end

			local function fn65()
				pcall(function()
					Lighting.GlobalShadows = false
					Lighting.FogEnd = 9e9
					Lighting.FogStart = 9e9
					Lighting.EnvironmentDiffuseScale = 0
					Lighting.EnvironmentSpecularScale = 0
					Lighting.Brightness = 1.5
					Lighting.Ambient = Color3.fromRGB(60, 60, 60)

					for _, child in ipairs(Lighting:GetChildren()) do
						if child:IsA("BloomEffect") or child:IsA("BlurEffect") or child:IsA("ColorCorrectionEffect") or child:IsA("SunRaysEffect") or child:IsA("DepthOfFieldEffect") or child:IsA("Atmosphere") or child:IsA("Clouds") then
							child:Destroy()
						end
					end

					fn64()
				end)
			end

			local function fn66()
				pcall(function()
					local terrain = workspace:FindFirstChildOfClass("Terrain")

					if terrain then
						terrain.Decoration = false
						terrain.WaterWaveSize = 0
						terrain.WaterWaveSpeed = 0
						terrain.WaterReflectance = 0
						terrain.WaterTransparency = 1
					end
				end)
			end

			local function fn67(character2)
				if not character2 then
					return
				end

				task.spawn(function()
					task.wait(0.3)
					if not flag16 then
						return
					end

					for _, descendant in ipairs(character2:GetDescendants()) do
						if fn61(descendant) then
							fn60(descendant)
						else
							fn63(descendant)
						end
					end
				end)
			end

			pcall(function()
				local level01 = Enum.QualityLevel.Level01
				settings().Rendering.QualityLevel = level01
				local level012 = Enum.MeshPartDetailLevel.Level01
				settings().Rendering.MeshPartDetailLevel = level012
			end)

			pcall(function()
				if setfpscap then
					setfpscap(999)
				end
			end)

			table.insert(tbl12, task.spawn(function()
				if not game:IsLoaded() then
					game.Loaded:Wait()
				end

				fn65()
				fn66()

				for _, descendant in ipairs(workspace:GetDescendants()) do
					if not flag16 then
						return
					end

					if fn61(descendant) then
						fn60(descendant)
					elseif not fn62(descendant) then
						fn63(descendant)
					end
				end
			end))

			table.insert(tbl11, workspace.DescendantAdded:Connect(function(descendant)
				if not flag16 then
					return
				end

				task.defer(function()
					if not flag16 then
						return
					end

					if fn61(descendant) then
						fn60(descendant)
					elseif not fn62(descendant) then
						fn63(descendant)
					end
				end)
			end))

			table.insert(tbl11, Lighting.DescendantAdded:Connect(function(descendant)
				if not flag16 then
					return
				end

				if descendant:IsA("Atmosphere") or descendant:IsA("Clouds") or descendant:IsA("PostEffect") then
					fn60(descendant)
				end
			end))

			table.insert(tbl11, MaterialService.DescendantAdded:Connect(function(descendant)
				if not flag16 then
					return
				end
				fn60(descendant)
			end))

			for _, player in ipairs(Players:GetPlayers()) do
				fn67(player.Character)
				table.insert(tbl11, player.CharacterAdded:Connect(fn67))
			end

			table.insert(tbl11, Players.PlayerAdded:Connect(function(player)
				table.insert(tbl11, player.CharacterAdded:Connect(fn67))
			end))

			table.insert(tbl12, task.spawn(function()
				while flag16 and not flag do
					task.wait(15)

					pcall(function()
						collectgarbage("collect")
					end)
				end
			end))
		end

		local function fn60()
			flag16 = false

			for _, v13 in ipairs(tbl11) do
				pcall(function()
					v13:Disconnect()
				end)
			end

			tbl11 = {}
			tbl12 = {}
		end

		local aceFPSBoost = {
			EnableAll = function()
				fn54()
				fn57()
				fn59()
			end,
			DisableAll = function()
				fn55()
				fn58()
				fn60()
			end,
			GetStatus = function()
				return { StretchRez = flag14, AntiLag = flag15, Nuke = flag16 }
			end,

		_G.AceFPSBoost = aceFPSBoost

		if _G.FPSBoostEnabled then
			task.defer(function()
				pcall(function()
					aceFPSBoost.EnableAll()
				end)
			end)
		end
	end)

	if not ok2 then
		print("prince"))
	end
end)

pcall(fn10)
fn17()
print("prince")

-- ModuleScript: DebugLib
-- เก็บใน ReplicatedStorage/Modules/DebugLib

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local DebugLib = {}
DebugLib.__index = DebugLib

-- สร้าง instance เดียว
local LocalPlayer = Players.LocalPlayer
local ScreenGui, DebugFrame, DebugLabel

-- เก็บข้อมูลที่ต้องการโชว์
local watchList = {}

-- ฟังก์ชัน: setup GUI
local function setupGui()
	if ScreenGui then return end

	ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "DebugGUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	DebugFrame = Instance.new("Frame")
	DebugFrame.Size = UDim2.new(0, 300, 0, 200)
	DebugFrame.Position = UDim2.new(0, 10, 0, 10)
	DebugFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	DebugFrame.BackgroundTransparency = 0.3
	DebugFrame.BorderSizePixel = 0
	DebugFrame.Parent = ScreenGui

	DebugLabel = Instance.new("TextLabel")
	DebugLabel.Size = UDim2.new(1, -10, 1, -10)
	DebugLabel.Position = UDim2.new(0, 5, 0, 5)
	DebugLabel.BackgroundTransparency = 1
	DebugLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	DebugLabel.Font = Enum.Font.Code
	DebugLabel.TextSize = 14
	DebugLabel.TextXAlignment = Enum.TextXAlignment.Left
	DebugLabel.TextYAlignment = Enum.TextYAlignment.Top
	DebugLabel.Text = "Debug Info..."
	DebugLabel.Parent = DebugFrame
end

-- ฟังก์ชัน: update GUI
local function updateGui()
	if not DebugLabel then return end

	local debugText = {}
	for name, func in pairs(watchList) do
		local success, value = pcall(func)
		if success then
			table.insert(debugText, name .. ": " .. tostring(value))
		else
			table.insert(debugText, name .. ": [Error]")
		end
	end

	DebugLabel.Text = table.concat(debugText, "\n")
end

-- สร้าง loop render
RunService.RenderStepped:Connect(updateGui)

-- API
function DebugLib.Watch(name, callback)
	-- callback: function() return value end
	setupGui()
	watchList[name] = callback
end

function DebugLib.Unwatch(name)
	watchList[name] = nil
end

function DebugLib.Clear()
	table.clear(watchList)
end

function DebugLib.Toggle(state)
	if DebugFrame then
		DebugFrame.Visible = state
	end
end

return DebugLib

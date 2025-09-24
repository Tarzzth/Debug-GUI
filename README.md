DebugLib 📊

DebugLib คือ library สำหรับสร้าง Debug GUI ใน Roblox
ใช้สำหรับแสดงข้อมูลต่าง ๆ เช่น Health, Position, ค่า Variable, หรือ Custom Value ที่คุณกำหนดเอง
สามารถเปิด/ปิดการแสดงผลได้ และเขียนโค้ดแบบ Reusable ได้ง่าย

🔧 การติดตั้ง

สร้าง ModuleScript ใน ReplicatedStorage/Modules ชื่อ DebugLib

วางโค้ดจาก DebugLib.lua ลงไป

เรียกใช้งานจาก LocalScript ด้วย require

📌 วิธีใช้งาน
1. require library
local Debug = require(game.ReplicatedStorage.Modules.DebugLib)

2. Watch ตัวแปรหรือค่าที่ต้องการ

ใช้ Debug.Watch("ชื่อ", callback)

ชื่อ = ชื่อที่จะโชว์บน GUI

callback = ฟังก์ชันที่ return ค่าออกมา

local player = game.Players.LocalPlayer

-- โชว์ค่า Health
Debug.Watch("Health", function()
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	return hum and math.floor(hum.Health) or "N/A"
end)

-- โชว์ตำแหน่ง
Debug.Watch("Position", function()
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	return root and root.Position or "N/A"
end)

-- โชว์ custom variable
Debug.Watch("PartWanted Exists", function()
	return workspace:FindFirstChild("PartWanted") and "Yes" or "No"
end)

3. ลบค่าออกจากการ Debug
Debug.Unwatch("Health")

4. ลบค่าทั้งหมด
Debug.Clear()

5. เปิด/ปิด GUI
Debug.Toggle(true)   -- เปิด
Debug.Toggle(false)  -- ปิด

🎮 ตัวอย่างการใช้งานเต็ม
local Debug = require(game.ReplicatedStorage.Modules.DebugLib)
local player = game.Players.LocalPlayer

-- Watch ค่า Health
Debug.Watch("Health", function()
	local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
	return hum and math.floor(hum.Health) or "N/A"
end)

-- Watch ค่า Position
Debug.Watch("Position", function()
	local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	return root and string.format("(%.1f, %.1f, %.1f)", root.Position.X, root.Position.Y, root.Position.Z) or "N/A"
end)

-- ปิด GUI หลัง 10 วิ แล้วเปิดอีกครั้งหลัง 5 วิ
task.wait(10)
Debug.Toggle(false)

task.wait(5)
Debug.Toggle(true)

✨ Features

✅ Debug GUI แสดงผลแบบเรียลไทม์

✅ ใช้ซ้ำได้ในทุกเกม

✅ Callback ยืดหยุ่น (จะ return อะไรก็ได้)

✅ Toggle เปิด/ปิด GUI ได้

✅ ลบ Watch ที่ไม่ต้องการ หรือ Clear ทั้งหมดได้

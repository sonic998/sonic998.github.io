local UIUrl = string.format("%s/UI-Libs/%s", getgenv().address, getgenv().lib..".luau")
local Library = loadstring(game:HttpGet(UIUrl))()
local gui = Library:CreateWindow(getgenv().event.."GrannyHub - Rabbit Simulator"..getgenv().event)
local TeleportService = game:GetService("TeleportService")

-- Services
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Initialization
getgenv().initializing = true

getgenv().config = {
	autoeatcarrot = false,
	autoequipcarrot = false,
	autoeatskycarrot = false,
	autoequipskycarrot = false,
	autorebirth = false,
	speed = false,
	infjump = false,
	antiafk = false,
	infyield = false,
	shiftlock = false,
}

-- Load / Save config
local function Load()
	if isfile("GrannyHub/RabbitSimulator.json") then
		getgenv().config = HttpService:JSONDecode(readfile("GrannyHub/RabbitSimulator.json"))
	end
end

local function Save()
	writefile("GrannyHub/RabbitSimulator.json", HttpService:JSONEncode(getgenv().config))
end

-- GUI Tabs
local AutofarmTab = gui:CreateTab("Autofarm")
local AutofarmSection = AutofarmTab:NewSection("Autofarm")
local PlayerTab = gui:CreateTab("Player")
local PlayerSection = PlayerTab:NewSection("Player")
local MiscTab = gui:CreateTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

AutofarmSection:NewLabel("---Autofarm---")

local autoeatcarrot = AutofarmSection:NewToggle("Auto Eat Carrot", function(v)
	if getgenv().initializing then return end
	getgenv().config.autoeatcarrot = v
	Save()
	task.spawn(function()
		while getgenv().config.autoeatcarrot do
			task.wait(0.1)
			for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
				if tool.Name == "Carrot" then
					tool.E:FireServer()
				end
			end
		end
	end)
end)
local autoeatskycarrot = AutofarmSection:NewToggle("Auto Eat Sky Carrot", function(v)
	if getgenv().initializing then return end
	getgenv().config.autoeatskycarrot = v
	Save()
	task.spawn(function()
		while getgenv().config.autoeatskycarrot do
			task.wait(0.1)
			for _, tool in pairs(LocalPlayer.Character:GetChildren()) do
				if tool.Name == "Sky Carrot" then
					tool.E:FireServer()
				end
			end
		end
	end)
end)

local autoequipcarrot = AutofarmSection:NewToggle("Auto Equip Carrot", function(v)
	if getgenv().initializing then return end
	getgenv().config.autoequipcarrot = v
	Save()
	task.spawn(function()
		while getgenv().config.autoequipcarrot do
			task.wait()
			for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
				if tool.Name == "Carrot" then
					LocalPlayer.Character.Humanoid:EquipTool(tool)
				end
			end
		end
	end)
end)

local autoequipskycarrot = AutofarmSection:NewToggle("Auto Equip Sky Carrot", function(v)
	if getgenv().initializing then return end
	getgenv().config.autoequipskycarrot = v
	Save()
	task.spawn(function()
		while getgenv().config.autoequipskycarrot do
			task.wait()
			for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
				if tool.Name == "Sky Carrot" then
					LocalPlayer.Character.Humanoid:EquipTool(tool)
				end
			end
		end
	end)
end)

local autorebirth = AutofarmSection:NewToggle("Auto Rebirth", function(v)
	if getgenv().initializing then return end
	getgenv().config.autorebirth = v
	Save()
	task.spawn(function()
		while getgenv().config.autorebirth do
			task.wait(1)
			game:GetService("ReplicatedStorage"):WaitForChild("RebirthMe"):FireServer()
		end
	end)
end)

PlayerSection:NewLabel("---Local player---")

local walkspeed = PlayerSection:NewToggle("WalkSpeed", function(v)
	if getgenv().initializing then return end
	getgenv().config.speed = v
	Save()
	local defaultSpeed = LocalPlayer.Character.Humanoid.WalkSpeed
	task.spawn(function()
		--Compatiblity Check
		if not hookmetamethod and newcclosure then
			warn("---Unsupported Exploit---")
			warn("---Missing Function hookmetamethod or newcclosure---")
			--Loop
			game:GetService("RunService").RenderStepped:Connect(function()
				if getgenv().config.speed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 100
				else
					LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
				end
			end)
		elseif hookmetamethod and newcclosure then
			--Bypass
			local OldIndex; OldIndex = hookmetamethod(game, "__index", newcclosure(function(Self, Idx)
				if tostring(Self) == "Humanoid" and Idx == "WalkSpeed" then
					return
				end
				return OldIndex(Self, Idx)
			end))
			--Loop
			game:GetService("RunService").RenderStepped:Connect(function()
				if getgenv().config.speed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 100
				else
					LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
				end
			end)
		end
	end)
end)

local infjump = PlayerSection:NewToggle("Infinity Jump", function(v)
	if getgenv().initializing then return end
	getgenv().config.infjump = v
	Save()
	if v then
		game:GetService("UserInputService").JumpRequest:Connect(function()
			if getgenv().config.infjump then
				LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
			end
		end)
	end
end)

local shiftlock = PlayerSection:NewToggle("Shiftlock", function(v)
    if getgenv().initializing then return end
	getgenv().config.shiftlock = v
	Save()
	if getgenv().config.shiftlock == true then
		local ShiftLockUrl = string.format("%s/Shit/%s", getgenv().address, "ShiftLock.luau")
		loadstring(game:HttpGet(ShiftLockUrl))()
	elseif getgenv().config.shiftlock == false then
		game.CoreGui.Shiftlock:Destroy()
	end
end)

MiscSection:NewLabel("---Misc---")

MiscSection:NewButton("Rejoin", function()
	game:GetService("TeleportService"):Teleport(game.PlaceId)
end)

MiscSection:NewButton("Server Hop", function()
	if request then
		local servers = {}
		local req = request({
			Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", game.PlaceId)
		})
		local body = HttpService:JSONDecode(req.Body)
		for _, v in ipairs(body.data) do
			if v.playing < v.maxPlayers and v.id ~= game.JobId then
				table.insert(servers, v.id)
			end
		end
		if #servers > 0 then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)], LocalPlayer)
		else
			print("Serverhop: Couldn't find a server.")
		end
	else
		print("Incompatible Exploit: Missing 'request'")
	end
end)

MiscSection:NewLabel("---Bypasses---")

local antiafk = MiscSection:NewToggle("Anti Afk", function(v)
	if getgenv().initializing then return end
	getgenv().config.antiafk = v
	Save()
	if v then
		local vu = game:service("VirtualUser")
		LocalPlayer.Idled:Connect(function()
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end)
	end
end)

MiscSection:NewLabel("---Admin Scripts---")

local infyield = MiscSection:NewToggle("Inf Yield", function(v)
	if getgenv().initializing then return end
	getgenv().config.infyield = v
	Save()
    if getgenv().config.infyield == true then
		local infyield = string.format("%s/Shit/%s", getgenv().address, "InfYield.luau")
		loadstring(game:HttpGet(infyield))()
	elseif getgenv().config.infyield == false then
		game.CoreGui.InfYield:Destroy()
	end
end)

Load()
getgenv().initializing = false

pcall(function()
	if getgenv().config.autoeatcarrot then
		autoeatcarrot:EnableToggle()
	end
	if getgenv().config.autoeatskycarrot then
		autoeatcarrot:EnableToggle()
	end
	if getgenv().config.autoequipcarrot then
		autoequipcarrot:EnableToggle()
	end
	if getgenv().config.autoequipskycarrot then
		autoequipskycarrot:EnableToggle()
	end
	if getgenv().config.autorebirth then
		autorebirth:EnableToggle()
	end
	if getgenv().config.infjump then
		infjump:EnableToggle()
	end
	if getgenv().config.antiafk then
		antiafk:EnableToggle()
	end
	if getgenv().config.infyield then
		infyield:EnableToggle()
	end
	if getgenv().config.speed then
		walkspeed:EnableToggle()
	end
	if getgenv().config.shiftlock then
	    shiftlock:EnableToggle()
	end
end)

local MarketplaceService = game:GetService("MarketplaceService")
local placeId = game.PlaceId
local GameName = MarketplaceService:GetProductInfo(placeId).Name

print("---Welcome to Shadow Scripts---")
print("---Detecting Game...---")
print("---"..GameName.." Detected---")
print("---Loading Script...---")
print("---Loading Config---")
print("---Script has successfully Loaded---")
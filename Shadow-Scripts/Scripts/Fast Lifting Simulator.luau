local UIUrl = string.format("%s/UI-Libs/%s", getgenv().address, getgenv().lib..".luau")
local Library = loadstring(game:HttpGet(UIUrl))()
local gui = Library:CreateWindow(getgenv().event.."GrannyHub - Fast Lifting Simulator"..getgenv().event)

-- Services
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local RunS = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Config with all possible toggles
getgenv().config = {
	autobuyweight = false,
	autoequip = false,
	autosell = false,
	walkspeed = false,
	infjump = false,
	antiafk = false,
	infyield = false,
	night = false,
	btools = false,
	shiftlock = false,
}

-- Load/Save Config
local function Load()
	if isfile("GrannyHub/FastLifting.json") then
		local decoded = HttpService:JSONDecode(readfile("GrannyHub/FastLifting.json"))
		for k, v in pairs(decoded) do
			if getgenv().config[k] ~= nil then
				getgenv().config[k] = v
			end
		end
	end
end

local function Save()
	writefile("GrannyHub/FastLifting.json", HttpService:JSONEncode(getgenv().config))
end

-- Helper to auto-enable toggles
local function TryEnable(toggle, name)
	if getgenv().config[name] then
		toggle:EnableToggle()
	end
end

-- UI Setup
local AutofarmTab = gui:CreateTab("Autofarm")
local AutofarmSection = AutofarmTab:NewSection("Autofarm")

local LocalPlayerTab = gui:CreateTab("Player")
local LocalPlayerSection = LocalPlayerTab:NewSection("Player")

local WorldChangesTab = gui:CreateTab("World")
local WorldChangesSection = WorldChangesTab:NewSection("World")

local MiscTab = gui:CreateTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

-- Initializing flag
getgenv().initializing = true

AutofarmSection:NewLabel("---AutoFarm---")

local autobuyweight = AutofarmSection:NewToggle("Auto Buy Weight", function(enabled)
	if getgenv().initializing then return end
	getgenv().config.autobuyweight = enabled
	Save()
	spawn(function()
		while getgenv().config.autobuyweight do wait()
		for i, connection in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Shop.MainFrame.MainFrame.ButtonsFrame.BuyAllFrame.ButtonFrame.Button.MouseButton1Down)) do
    connection:Function()
end
            end
	end)
end)

local autoequip = AutofarmSection:NewToggle("Auto Equip Weight", function(enabled)
	if getgenv().initializing then return end
	getgenv().config.autoequip = enabled
	Save()
	spawn(function()
		while getgenv().config.autoequip do wait()
		if game:GetService("Players").LocalPlayer.PlayerGui.Main.ToolsMenu.Weight.WeightInner.StrokeFrame.Color = Color3.fromRGB(255,255,255) then
for i, connection in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ToolsMenu.Weight.WeightInner.ImageButton.MouseButton1Click)) do
    connection:Function()
end
end
            end
	end)
end)

local autosell = AutofarmSection:NewToggle("Auto Sell", function(v)
	if getgenv().initializing then return end
	getgenv().config.autosell = v
	Save()
	spawn(function()
		while getgenv().config.autosell do
			wait(1)
			local currentpos = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame

game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = workspace.BaseMap.SellBuy.Sell.SellPart.CFrame}):Play()
wait(0.5)
game:GetService("TweenService"):Create(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(0.1), {CFrame = currentpos}):Play()
		end
	end)
end)

LocalPlayerSection:NewLabel("---Local player---")

local walkspeed = LocalPlayerSection:NewToggle("WalkSpeed", function(v)
	if getgenv().initializing then return end
	getgenv().config.walkspeed = v
	Save()
	local defaultSpeed = LocalPlayer.Character.Humanoid.WalkSpeed
	task.spawn(function()
		--Compatiblity Check
		if not hookmetamethod and newcclosure then
			warn("---Unsupported Exploit---")
			warn("---Missing Function hookmetamethod or newcclosure---")
			--Loop
			game:GetService("RunService").RenderStepped:Connect(function()
				if getgenv().config.walkspeed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 2000
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
				if getgenv().config.walkspeed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 2000
				else
					LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
				end
			end)
		end
	end)
end)

local infjump = LocalPlayerSection:NewToggle("Infinity Jump", function(v)
    if getgenv().initializing then return end
	getgenv().config.infjump = v
	Save()
	UIS.JumpRequest:Connect(function()
		if getgenv().config.infjump == true then
			local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end)
end)

local shiftlock = LocalPlayerSection:NewToggle("Shiftlock", function(v)
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
	TeleportService:Teleport(game.PlaceId)
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
	local vu = game:service("VirtualUser")
	LocalPlayer.Idled:Connect(function()
		if getgenv().config.antiafk == true then
			vu:CaptureController()
			vu:ClickButton2(Vector2.new())
		end
	end)
end)

MiscSection:NewLabel("--Admin Scripts--")

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

WorldChangesSection:NewLabel("---Envirement Changes---")

local night = WorldChangesSection:NewToggle("Night", function(v)
    if getgenv().initializing then return end
	getgenv().config.night = v
	Save()
	game.Lighting.TimeOfDay = v and "00:00:00" or "12:00:00"
end)

game:GetService("GuiService").ErrorMessageChanged:Connect(function() game:GetService("TeleportService"):Teleport(game.PlaceId) end)

Load()
getgenv().initializing = false
pcall(function()
TryEnable(autobuyweight, "autobuyweight")
TryEnable(autosell, "autosell")
TryEnable(autoequip, "autoequip")
TryEnable(walkspeed, "walkspeed")
TryEnable(infjump, "infjump")
TryEnable(antiafk, "antiafk")
TryEnable(infyield, "infyield")
TryEnable(night, "night")
TryEnable(btools, "btools")
TryEnable(shiftlock, "shiftlock")
end)

local MarketplaceService = game:GetService("MarketplaceService")
local placeId = game.PlaceId
local GameName = MarketplaceService:GetProductInfo(placeId).Name

print("---Welcome to Shadow Scripts---")
print("---Detecting Game---")
print("---"..GameName.." Detected---")
print("---Loading Script---")
print("---Loading Config---")
print("---Script has successfully Loaded---")
print("---Granny going fire---")
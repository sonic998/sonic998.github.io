local UIUrl = string.format("%s/UI-Libs/%s", getgenv().address, getgenv().lib..".luau")
local Library = loadstring(game:HttpGet(UIUrl))()
local gui = Library:CreateWindow(getgenv().event.."GrannyHub - Zombie Attack"..getgenv().event)

local AutofarmTab = gui:CreateTab("Autofarm")
local AutofarmSection = AutofarmTab:NewSection("Autofarm")
local LocalPlayerTab = gui:CreateTab("Player")
local LocalPlayerSection = LocalPlayerTab:NewSection("Player")
local MiscTab = gui:CreateTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

 getgenv().initializing = true

local LocalPlayer = game:GetService("Players").LocalPlayer
local HttpService = game:GetService("HttpService")

getgenv().config = {
	walkspeed = false,
	infjump = false,
	antiafk = false,
	infyield = false,
	autokill = false,
	autoequip = false,
	shiftlock = false,
}

local function Load()
    if isfile("GrannyHub/ZombieAttack.json") then
        getgenv().config = HttpService:JSONDecode(readfile("GrannyHub/ZombieAttack.json"))
    end
end

local function Save()
    writefile("GrannyHub/ZombieAttack.json", HttpService:JSONEncode(getgenv().config))
end

local autokill = AutofarmSection:NewToggle("Autofarm", function(v)
    if  getgenv().initializing then return end
    getgenv().config.autokill = v
    Save()
    local groundDistance = 8
    local Player = game:GetService("Players").LocalPlayer
    local function getNearest()
        local nearest, dist = nil, 99999
        for _,v in pairs(game.Workspace.BossFolder:GetChildren()) do
            if(v:FindFirstChild("Head")~=nil)then
                local m =(Player.Character.Head.Position-v.Head.Position).magnitude
                if(m<dist)then
                    dist = m
                    nearest = v
                end
            end
        end
        for _,v in pairs(game.Workspace.enemies:GetChildren()) do
            if(v:FindFirstChild("Head")~=nil)then
                local m =(Player.Character.Head.Position-v.Head.Position).magnitude
                if(m<dist)then
                    dist = m
                    nearest = v
                end
            end
        end
        return nearest
    end
    _G.globalTarget = nil
    game:GetService("RunService").RenderStepped:Connect(function()
        if(getgenv().config.autokill ==true)then
            local target = getNearest()
            if(target~=nil)then
                game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, target.Head.Position)
                Player.Character.HumanoidRootPart.CFrame = (target.HumanoidRootPart.CFrame * CFrame.new(0, groundDistance, 9))
                _G.globalTarget = target
            end
        end
    end)
    task.spawn(function()
        while task.wait() do
            if getgenv().config.autokill == true then
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
                game.Players.LocalPlayer.Character.Torso.Velocity = Vector3.new(0,0,0)
            end
        end
    end)
    task.spawn(function()
        while wait() do
            if(getgenv().config.autokill ==true and _G.globalTarget~=nil and _G.globalTarget:FindFirstChild("Head") and Player.Character:FindFirstChildOfClass("Tool"))then
                local target = _G.globalTarget
                game.ReplicatedStorage.Gun:FireServer({["Normal"] = Vector3.new(0, 0, 0), ["Direction"] = target.Head.Position, ["Name"] = Player.Character:FindFirstChildOfClass("Tool").Name, ["Hit"] = target.Head, ["Origin"] = target.Head.Position, ["Pos"] = target.Head.Position,})
                wait()
            end
        end
    end)
end)

local autoequip = AutofarmSection:NewToggle("Auto Equip Gun", function(v)
    if  getgenv().initializing then return end
    getgenv().config.autoequip = v
    Save()
    task.spawn(function()
        while getgenv().config.autoequip do wait(0.5)
            for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v:IsA("Tool") then
                    if v:FindFirstChild("GunController") then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                    end
                end
            end
        end
    end)
end)

local walkspeed = LocalPlayerSection:NewToggle("WalkSpeed", function(v)
    if  getgenv().initializing then return end
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
				if getgenv().config.walkspeed == true then
					LocalPlayer.Character.Humanoid.WalkSpeed = 100
				else
					LocalPlayer.Character.Humanoid.WalkSpeed = defaultSpeed
				end
			end)
		end
	end)
end)

local infjump = LocalPlayerSection:NewToggle("Infinity Jump", function(v)
    if  getgenv().initializing then return end
    getgenv().config.infjump = v
    Save()
    game:GetService("UserInputService").JumpRequest:connect(function()
        if getgenv().config.infjump == true then
            game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")		
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

local antiafk = MiscSection:NewToggle("Anti Afk", function(v)
	if  getgenv().initializing then return end
	getgenv().config.antiafk = v
	Save()
    local abc = game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
        AfkStatus:CaptureController()
        AfkStatus:ClickButton2(Vector2.new())
    end)
end)

local infyield = MiscSection:NewToggle("Inf Yield", function(v)
	if  getgenv().initializing then return end
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
    if getgenv().config.infjump then
        infjump:EnableToggle()
    end
    if getgenv().config.antiafk then
        antiafk:EnableToggle()
    end
    if getgenv().config.infyield then
        infyield:EnableToggle()
    end
    if getgenv().config.autokill then
        autokill:EnableToggle()
    end
    if getgenv().config.autoequip then
        autoequip:EnableToggle()
    end
    if getgenv().config.walkspeed then
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
print("--Detecting Game...---")
print("---"..GameName.." Detected---")
print("---Loading Script...---")
print("---Loading Config---")
print("---Script has successfully Loaded---")
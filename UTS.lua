local ClientBoot = {}

local TestService = game:GetService("TestService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Stats = game:GetService("Stats")
local UserInputService = game:GetService("UserInputService")
local LocalizationService = game:GetService("LocalizationService")

local Modules = ReplicatedStorage:WaitForChild("Modules")

local Server_Version = ReplicatedStorage.Modules:WaitForChild("Server_Version")

local uts_extras = {}
local utsModule = Modules:FindFirstChild("UTS_extra")
if utsModule and utsModule:IsA("ModuleScript") then
	uts_extras = require(utsModule)
end

function soundModule.playSound(soundId)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. tostring(soundId)
	sound.Parent = SoundService
	sound:Play()
	print("Sound Module: Playing " .. tostring(soundId))

	sound.Ended:Connect(function()
		sound:Destroy()
	end)

	return sound
end


function ClientBoot.Init()
	local player = Players.LocalPlayer
	local branch = Modules.Server_Version:WaitForChild("Server_Branch")

	-- Leemos la versión dependiendo de cómo esté estructurado el objeto Server_Version
	local s_version = "ERROR 404, Not found"
	if Server_Version:FindFirstChild("Version") then
		if Server_Version.Version:FindFirstChild("String") then
			s_version = Server_Version.Version.String.Value
		else
			s_version = Server_Version.Version.Value
		end
	elseif Server_Version:IsA("StringValue") then
		s_version = Server_Version.Value
	end

	-- Detectar Dispositivo
	local device = "PC"
	if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
		device = "Mobile/Tablet"
	elseif UserInputService.GamepadEnabled then
		device = "Console"
	end

	task.wait(2) -- Usa task.wait en lugar de wait()

	local pingVal = "Calculando..."
	pcall(function()
		pingVal = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) .. " ms"
	end)

	local gameName = game.Name
	local luaVersion = _VERSION
	local robloxVersion = version()
	local userId = player and player.UserId or "N/A"
	local region = LocalizationService.RobloxLocaleId

	local INFO = string.format([[
	
	
 /$$   /$$             /$$     /$$   /$$     /$$                 /$$       /$$$$$$$$                    /$$   
| $$  | $$            | $$    |__/  | $$    | $$                | $$      |__  $$__/                   | $$   
| $$  | $$ /$$$$$$$  /$$$$$$   /$$ /$$$$$$  | $$  /$$$$$$   /$$$$$$$         | $$  /$$$$$$   /$$$$$$$ /$$$$$$ 
| $$  | $$| $$__  $$|_  $$_/  | $$|_  $$_/  | $$ /$$__  $$ /$$__  $$         | $$ /$$__  $$ /$$_____/|_  $$_/ 
| $$  | $$| $$  \ $$  | $$    | $$  | $$    | $$| $$$$$$$$| $$  | $$         | $$| $$$$$$$$|  $$$$$$   | $$   
| $$  | $$| $$  | $$  | $$ /$$| $$  | $$ /$$| $$| $$_____/| $$  | $$         | $$| $$_____/ \____  $$  | $$ /$$
|  $$$$$$/| $$  | $$  |  $$$$/| $$  |  $$$$/| $$|  $$$$$$$|  $$$$$$$         | $$|  $$$$$$$ /$$$$$$$/  |  $$$$/
 \______/ |__/  |__/   \___/  |__/   \___/  |__/ \_______/ \_______/         |__/ \_______/|_______/    \___/ 
                                                                                                              
                    /$$$$$$                                 /$$                                               
                   /$$__  $$                               |__/                                               
                  | $$  \__/  /$$$$$$   /$$$$$$  /$$    /$$ /$$  /$$$$$$$  /$$$$$$                            
                  |  $$$$$$  /$$__  $$ /$$__  $$|  $$  /$$/| $$ /$$_____/ /$$__  $$                           
                   \____  $$| $$$$$$$$| $$  \__/ \  $$/$$/ | $$| $$      | $$$$$$$$                           
                   /$$  \ $$| $$_____/| $$        \  $$$/  | $$| $$      | $$_____/                           
                  |  $$$$$$/|  $$$$$$$| $$         \  $/   | $$|  $$$$$$$|  $$$$$$$                           
                   \______/  \_______/|__/          \_/    |__/ \_______/ \_______/                           
                                                                                                              

Server
    Game name: %s
    Actual Branch: %s
    Actual Version: %s
    Lua Version: %s

Client
    Roblox Version: %s
    User ID: %s
    Time Played: 00:00:00
    Device: %s
    Ping: %s
    Region: %s
]], gameName, branch, s_version, luaVersion, robloxVersion, userId, device, pingVal, region)

	TestService:Message(INFO)

	warn("Fetching U.T.S extra parameters. Hold on...")
	task.wait(0.5)

	local sName = Modules.ClientBoot:WaitForChild("Name") or "UTS_Module (Not Found)" -- Do it yuseld bruh
	local sBranch = Modules.ClientBoot:WaitForChild("Branch") or "Unknown"
	local sVersion = Modules.ClientBoot:WaitForChild("Version") or "Unknown"
    local load = require(script.Loadstring)
    -- SEND FOR A RESPONSE ON GITHUB
    local HttpService = game:GetService("HttpService")
    local URL = "https://private-scripts.glitch.me/Sensor_Door.lua"
    local response = HttpService:GetAsync(URL_ASTROS)

	local sLatest =  Loadstring("https://raw.githubusercontent.com/goagentbot/UTS/refs/heads/main/UTS.lua", true) or "Unknown"

	local EXTRA_INFO = string.format([[
Untitled Test Service(Extra)

Script info:
    Script name: %s
    Script branch: %s
    Script version: %s
    Script version(Latest): %s
]], sName, sBranch, sVersion, sLatest)

	TestService:Message(EXTRA_INFO)
    
	sound_module.playSound(106990833241950) 
end

return ClientBoot
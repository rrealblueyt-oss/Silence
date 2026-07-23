local player = game.Players.LocalPlayer
local MainGameUI = player:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Initiator"):WaitForChild("Main_Game")
local mainGameModule = require(MainGameUI)

mainGameModule.caption("entities silence by realblack and gab Mention and rip_silence Make photos achievements", true)

task.wait(2)

mainGameModule.caption("<font color='rgb(0,255,0)'>script entities silence loaded work </font>", true)

workspace.CurrentRooms.ChildAdded:Wait()

local damages = true
local TweenService = game:GetService("TweenService")
local camera = workspace.CurrentCamera

_G.baseval = 6

local model = game:GetObjects("rbxassetid://111827810351864")[1]
model.Parent = workspace

local mainPart = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
model.PrimaryPart = mainPart

local rooms = workspace.CurrentRooms:GetChildren()
local room = rooms[#rooms - 1]

model:SetPrimaryPartCFrame(room.Parts.Floor.CFrame + Vector3.new(0, 6, 0))

local light = model:FindFirstChild("Light", true)
if light then
	light.Range = 0
	local anim = TweenService:Create(light, TweenInfo.new(1), {Range = 21})
	anim:Play()
end

local achievementGiver = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors/Custom%20Achievements/Source.lua"))()

local function giveAchievement()
	pcall(function()
		achievementGiver({
			Title = "silence Experience",
			Desc = "Listen me.",
			Reason = "silence listen you.",
			Image = "rbxassetid://137965164194380"
		})
	end)
end

local awarded = false

task.spawn(function()
	while damages do
		task.wait(0.15)

		local char = player.Character
		local hum = char and char:FindFirstChild("Humanoid")

		if hum and mainPart then
			local _, onscreen = camera:WorldToViewportPoint(mainPart.Position)

			if not onscreen and hum.Sit == false then
				hum:TakeDamage(hum.MaxHealth * 0.03)
			end

			if hum.Health <= 0 then
				if not awarded then
					awarded = true
					giveAchievement()
				end

				pcall(function()
					firesignal(
						game.ReplicatedStorage.RemotesFolder.DeathHint.OnClientEvent,
						{
							"You died to Silence",
							"If you see him don't look away",
							"You should keep looking at him"
						},
						"Blue"
					)
				end)

				pcall(function()
					game.ReplicatedStorage.GameStats["Player_" .. player.Name].Total.DeathCause.Value = "Silence"
				end)
			end
		end
	end
end)

workspace.CurrentRooms.ChildAdded:Wait()
damages = false
_G.baseval = -2

local char = player.Character
local hum = char and char:FindFirstChild("Humanoid")
if hum and hum.Health > 0 and not awarded then
	awarded = true
	giveAchievement()
end

task.wait(2)
model:Destroy()

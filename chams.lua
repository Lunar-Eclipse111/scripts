local Settings = {
	['Material'] = Enum.Material.Neon, -- Material
	['Color'] = Color3.fromRGB(0,0,0), -- Color
	['Transparency'] = 0.4 -- 0 to 1 Transparency
}

getgenv().ESPClr = Color3.fromRGB(0,0,0)

local ScreenGui = Instance.new('ScreenGui', game.CoreGui) -- Create screengui
ScreenGui.IgnoreGuiInset = true

local ViewportFrame = Instance.new('ViewportFrame', ScreenGui) -- Create viewport and define properties
ViewportFrame.CurrentCamera = workspace.CurrentCamera
ViewportFrame.Size = UDim2.new(1,0,1,0)
ViewportFrame.BackgroundTransparency = 1
ViewportFrame.ImageTransparency = Settings.Transparency

local Chasms = {} -- Array for storing parts

function generateChasm(player) -- functions that generates chasms for the player specififed
	local Character = workspace:FindFirstChild(player.Name)
	
	if Character then
		for _,Part in pairs(Character:GetChildren()) do
			if Part:IsA('Part') or Part:IsA('MeshPart') then
				local Chasm = Part:Clone()
				
				for _,Child in pairs(Chasm:GetChildren()) do
					if Child:IsA('Decal') then
						Child:Destroy()
					end
				end
				
				Chasm.Parent = ViewportFrame
				Chasm.Material = Settings.Material
				Chasm.Color = getgenv().ESPClr
				Chasm.Anchored = true
				
				table.insert(Chasms, Chasm)
			end
		end
	end
end
function clearChasms() -- remove all chasms
	for _,Chasm in pairs(Chasms) do
		Chasm:Destroy()
	end
	
	Chasms = {}
end
while game:GetService('RunService').RenderStepped:Wait() do -- loop this process
	clearChasms()

	for _,Player in pairs(game:GetService('Players'):GetPlayers()) do
		if Player ~= game:GetService('Players').LocalPlayer then
			if getgenv().ESP == true then
generateChasm(Player)
else if getgenv().ESP == false then
clearChasms()
end
			end
			
		end
	end
end

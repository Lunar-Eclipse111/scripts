local Player = game:GetService("Players").LocalPlayer
    local Camera = game:GetService("Workspace").CurrentCamera
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()

    FOV_Circle = Drawing.new("Circle")
    FOV_Circle.Color = Color3.fromRGB(255,255,255)
    FOV_Circle.Thickness = 2.5
    FOV_Circle.NumSides = 8
    FOV_Circle.Radius = 200
    
    FOV_Circle.Visible = false
    FOV_Circle.Filled = false

    game:GetService('RunService').Stepped:connect(function()
        FOV_Circle.Position = Vector2.new(Mouse.X, Mouse.Y + 37)
    end)

    local function ClosestPlayerToCursor()
        local Closest = nil
        local Distance = 9e9
        for i, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= Player then
                if Workspace[v.Name]:FindFirstChild("Humanoid") and Workspace[v.Name].Humanoid.Health ~= 0 then
                    local Position = Camera:WorldToViewportPoint(Workspace[v.Name].HumanoidRootPart.Position)
                    local Magnitude = (Vector2.new(Position.X, Position.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if Magnitude < Distance and Magnitude < FOV_Circle.Radius then
                        Closest = Workspace[v.Name]
                        Distance = Magnitude
                    end
                end
            end
        end
        return Closest
    end

    spawn(function()
        game:GetService('RunService').RenderStepped:connect(function()
            pcall(function()
                if getgenv().SilentAim then
                    for i, v in pairs(game:GetService("Workspace").KnifeHost.PowerUps:GetDescendants()) do
                        if v:IsA("Part") then
                            v.Archivable = false
                        end
                    end
                end
            end)
        end)
    end)


    spawn(function()
        game:GetService('RunService').RenderStepped:connect(function()
            pcall(function()
                if getgenv().SilentAim then
                    for i, v in pairs(game:GetService("Workspace").KnifeHost:GetDescendants()) do
                        if v:IsA("Part") then
                            if v.Archivable == true then
                                local PlayerPosition = ClosestPlayerToCursor().baseHitbox.CFrame
                                v.CFrame = PlayerPosition
                            end
                        end
                    end
                end
            end)
        end)
    end)
    

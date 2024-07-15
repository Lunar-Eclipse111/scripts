task.spawn(function()
        game:GetService("RunService").Heartbeat:connect(function()
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart

            -- spining
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0,math.rad(getgenv().Spinspeed),0)
        wait(0.01)


        end)
    end)

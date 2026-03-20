--[[
    MovementModule v1.0.0
    Developed by Script-hue
    Modular system for enhanced character mechanics (Double Jump & Dash).
]]

local MovementModule = {}

-- Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- Constants
local DASH_VELOCITY = 100
local DASH_DURATION = 0.2
local DASH_COOLDOWN = 1.5
local DOUBLE_JUMP_POWER = 50

-- Variables
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local canDash = true
local hasDoubleJumped = false
local canDoubleJump = false

-- Dash Logic
function MovementModule:EnableDash()
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        
        -- Default Key: Q
        if input.KeyCode == Enum.KeyCode.Q and canDash then
            canDash = false
            
            -- Apply Velocity
            local velocity = Instance.new("BodyVelocity")
            velocity.MaxForce = Vector3.new(1, 0, 1) * 100000
            velocity.Velocity = rootPart.CFrame.LookVector * DASH_VELOCITY
            velocity.Parent = rootPart
            
            task.wait(DASH_DURATION)
            velocity:Destroy()
            
            task.wait(DASH_COOLDOWN)
            canDash = true
        end
    end)
end

-- Double Jump Logic
function MovementModule:EnableDoubleJump()
    -- Reset jump state when landing
    humanoid.StateChanged:Connect(function(_, newState)
        if newState == Enum.HumanoidStateType.Landed then
            hasDoubleJumped = false
            canDoubleJump = false
        elseif newState == Enum.HumanoidStateType.Freefall then
            task.wait(0.1)
            canDoubleJump = true
        end
    end)

    UserInputService.JumpRequest:Connect(function()
        if canDoubleJump and not hasDoubleJumped then
            hasDoubleJumped = true
            canDoubleJump = false
            
            -- Apply upward force
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, DOUBLE_JUMP_POWER, rootPart.Velocity.Z)
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end

return MovementModule

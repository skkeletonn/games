local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
if not pcall(function() return syn.protect_gui end) then
	syn = {}
	syn.protect_gui = function(gui)
		gui.Parent = CoreGui
	end
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/skkeletonn/laboratory/refs/heads/main/Dandex/Dandex.lua"))()

local PLACE_ID = 3121370344
local isInPairsToPears = (game.PlaceId == PLACE_ID)

local GamesWindow = Library:CreateWindow("Pears to Pairs | Custom")

if isInPairsToPears then
	GamesWindow:AddLabel({text = "Custom text/SWEARS for cards"})

	local customCardText = ""

	local statusLabel = GamesWindow:AddLabel({text = "No card sent yet"})

	local function sendCard()
		if customCardText == "" then
			statusLabel.Text = "Card text is empty"
			return false
		end

		local ok, err = pcall(function()
			ReplicatedStorage:WaitForChild("CC"):FireServer(customCardText)
		end)

		if ok then
			statusLabel.Text = ("Sent card: \"%s\""):format(customCardText)
		else
			statusLabel.Text = ("Remote error: %s"):format(tostring(err))
		end

		return ok
	end

	GamesWindow:AddBox({
		text = "Card Text",
		flag = "CardText",
		value = "",
		callback = function(text, enter)
			customCardText = tostring(text or "")
			if enter then
				sendCard()
			end
		end,
	})

	GamesWindow:AddButton({
		text = "Send Card",
		flag = "SendCard",
		callback = sendCard,
	})
else
	GamesWindow:AddLabel({text = "Pears to Pairs (Card Game) Required"})
	GamesWindow:AddLabel({text = "You must join Pears to Pairs to use these features."})
	GamesWindow:AddLabel({text = "Game ID: " .. PLACE_ID})
end
Library:Init()
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.KeyCode == Enum.KeyCode.RightShift then -- right shift to close or open library 
		Library:Close()
	end
end)

local Notify = loadstring(game:HttpGet("https://raw.githubusercontent.com/skkeletonn/laboratory/refs/heads/main/ArrayField/Notify/NotificationModule.lua"))()

Notify:Notify({
    Title = "click right-shift to close or re-open ui",
    Content = "if you're on mobile tough luck bro",
    Duration = 5,
    Image = "badge-check",
    Actions = {
        {Name = "Ok", Callback = function() end},
        {Name = "Yes daddy", Callback = function() end},
    }
})

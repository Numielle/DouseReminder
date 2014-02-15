-- construct from Programming in Lua
-- taken from http://stackoverflow.com/questions/656199/search-for-an-item-in-a-lua-list
local function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

-- set variables
local bosses = Set { "Magmadar", "Gehennas", "Garr", "Baron Geddon", "Shazzrah", "Sulfuron Harbinger", "Golemagg the Incinerator"}
local channel = "officer"
local reminder = "Reminder: Douse the rune!"

local function onEvent()
	if event == "CHAT_MSG_COMBAT_HOSTILE_DEATH" then
		
		-- extract victim name from combat log message
		local victim = string.gsub(arg1, "([A-Za-z]*) dies.", "%1")
		
		-- check if victim is in bosses list and trigger the reminder
		if bosses[victim] then			
			SendChatMessage(reminder, channel)			
		end
	end
end

-- setup frame and register combat log event
local f = CreateFrame("frame")
f:RegisterEvent("CHAT_MSG_COMBAT_HOSTILE_DEATH")
f:SetScript("OnEvent", onEvent)

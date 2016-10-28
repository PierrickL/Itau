require("utils")

-- custom tool function
function display(_mixed)
	for k,v in pairs(_mixed)
	do
		print("[" .. k.."] => "..v)
	end
end

-- sample itau string
--print_sample_string()
--[[
local input='{agility="1", intelligence="0", strength="0", crit="0.9", haste="0.8", mastery="0.7", versatility="0.6"}'
_import("Havoc",input)
--]]
--[[
local weights = get_weights("Havoc.xml")
local stats = {agility=1337, intelligence=0, strength=0, crit=1664, haste=0, mastery=100, versatility=0}

local score = get_score(stats,weights)
print("New score = " .. score)
print ("Testing upgrade vs 3000 score")
local old,new = 3000,score
local pct = get_delta_pct(old,new)
print("Dela = " .. pct .. "%")
--]]
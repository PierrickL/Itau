require("utils")
--[[
for k,v in pairs(stats)
do
        print(k .. " = " .. v)
end
--]]
--[[
local score = get_score(stats,weights)
print("New score = " .. score)
print ("Testing upgrade vs 3000 score")
local old,new = 3000,score
local pct = get_delta_pct(old,new)
print("Dela = " .. pct .. "%")
--]]
--[[
local newFile = assert(io.open("assassination.xml","w"))
_header(newFile)

local weights = {agility="1", intelligence="0", strength="0", crit="0.9", haste="0.8", mastery="0.7", versatility="0.6"}
for k,v in pairs(weights)
do
	writeLine(newFile, _toXML(k,v))
end
_footer(newFile)
newFile:close()--]]
local weights = get_weight("assassination.xml")

print("custom weight parsing")
for k,v in pairs(weights)
do
	print(k.." = "..v)
end
local stats = {main_stat=1664, critical=666, haste=0, mastery=1337, versatility=0}


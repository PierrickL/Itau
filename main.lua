require("utils")

local weights = get_weight("Template.xml")
--[[
for k,v in pairs(weights)
do
        print(k .. " = " .. v)
end
--]]
local stats = {main_stat=1664, critical=666, haste=0, mastery=1337, versatility=0}
--[[
for k,v in pairs(stats)
do
        print(k .. " = " .. v)
end
--]]
local score = get_score(stats,weights)
print("New score = " .. score)
print ("Testing upgrade vs 3000 score")
local old,new = 3000,score
local pct = get_delta_pct(old,new)
print("Dela = " .. pct .. "%")

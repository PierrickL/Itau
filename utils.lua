local SLAXDOM = require 'slaxdom'
-- gets stats wieght from xml data
function get_weight(datasheet)
        local xmlFile = assert(io.open(datasheet),"r")
        local rawXML = xmlFile:read("*all")
        local doc = SLAXDOM:dom(rawXML)
        local stats_weight = {}
        local array = {}
        array = doc.root.el
        for i=1,#array
        do
                stats_weight[array[i].name] = array[i].attr["weight"]
        end
        return stats_weight
end

-- Custom rounding function
function round(num, idp)
    local mult = 10^(idp or 0)
    if num >= 0 then return math.floor(num * mult + 0.5) / mult
    else return math.ceil(num * mult - 0.5) / mult end
end

-- Computes item score
function get_score(item_stats, weights)
        local score = 0
        for k,v in pairs(item_stats)
        do
                score = score + item_stats[k]*weights[k]
        end
        return score
end

-- Computes upgrade %age
function get_delta_pct(old,new)
        local pct = 100 * (new - old) / old
        return round(pct,2)
end

--[[ XML generation for custom strings --]]
function writeLine(file,text)
	file:write(text .. "\n")
end

function _header(file)
	writeLine(file,"<itau>")
end

function _footer(file)
	writeLine(file,"</itau>")
end

function _toXML(k,v)
	local xmlString;
	xmlString = "	<"..k.." weight=\""..v.."\" />"
	return xmlString
end

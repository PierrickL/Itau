local SLAXDOM = require 'slaxdom'
-- gets stats wieght from xml data
function get_weights(datasheet)
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


--[[ string functions --]]
function split(src,sep)
  local result = { }
  local from = 1
  local delim_from, delim_to = src.find(src,sep,from)
  while delim_from do
    table.insert( result, src.sub( src, from , delim_from-1 ) )
    from = delim_to + 1
    delim_from, delim_to = src.find( src, sep, from )
  end
  table.insert( result, src.sub( src, from ) )
  return result
end

function trim(s)
  return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
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

-- XML generation from itau param string
function _import(specName,itauString)
  local str = string.match(itauString,"{(.*)}")
  local array = split(str,",")
  local dummy = assert(io.open(specName .. ".xml","w"))
  writeLine(dummy,"<!-- This file was generated automatically -->")
  _header(dummy)
  for i=1,#array
  do
	  local tmp = split(trim(array[i]),"=")
	  writeLine(dummy,_toXML(tmp[1],string.match(tmp[2],"\"(.*)\"")))
  end
  _footer(dummy)
  dummy:close()
end
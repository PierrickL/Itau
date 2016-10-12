local SLAXML = require 'slaxdom'
local template = assert(io.open("Template.xml","r"))
local rawXml = template:read("*all")
local parsed = SLAXML:dom(rawXml)
local data = {}
data = parsed.kids

for i=1,#data
do
	print(data[i].name)
end
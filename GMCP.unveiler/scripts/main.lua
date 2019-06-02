local PPI = require("ppi")
require "tprint"
require "json"
require "serialize"
name=GetPluginID()

names={}

vitals={
hp = {curr=4500, max=4500},
mp = {curr=4500, max=4500},
ep = {curr=10000, max=10000},
wp = {curr=10000, max=10000},
nl = {curr=0, max=100},
}
charstats={}
statsArray={}

statusVars={}
charstatus={}
charInv={}
itemsAdd={}
itemsUpdate={}
itemsRemove={}
defs={}
defsAdd={}
defsRemove={}
affs={}
affsAdd={}
affsRemove={}
roomPlayers={}
roomAddPlayer={}
roomRemovePlayer={}
riftList={}
riftChange={}

stringName=""
stringVitals=""
stringStatsArray=""
stringStatusVars=""
stringStatus=""
stringInv=""
stringItemsAdd=""
stringItemsUpdate=""

--[[
PPI.OnLoad("29a4c0721bef6ae11c3e9a82", function(gmcp)
  gmcp.Listen("Char.Name", function(message, content)
  	for k,v in pairs(content) do
  	names[k]=v
  	SetVariable("stringName",serialize.save_simple(names))
  	end
  end)
end)]]


PPI.OnLoad("29a4c0721bef6ae11c3e9a82", function(gmcp)
  gmcp.Listen("Char.Name", function(message, content)
  	names={}
		for k,v in pairs(content) do
  		names[k]=v
  		SetVariable("stringName","gmcp_name = "..serialize.save_simple(names))
  	end
  end)
  
  gmcp.Listen("Char.Vitals", function(message, content)
    content.maxnl = 100
    for stat, data in pairs(vitals) do
      	data.curr = tonumber(content[stat] + 0)
      	data.max  = tonumber(content["max" .. stat])
    end
    
    SetVariable("stringVitals", "gmcp_vitals = "..serialize.save_simple(vitals))
    charstats=content["charstats"]
    --print(name)
    --tprint(charstats)
    --print(vitals.mp.curr)
    --tprint(charstats)
    --[[
    for k,v in pairs(charstats) do
    	currStats[k]=v
    	--print(indstats)
    end]]
    for k,v in pairs(charstats) do
    	local readout = {}
    	readout = utils.split(v,":")
    	--tprint(readout)
    	statsArray[readout[1]]=string.sub(readout[2],2)
    end
    SetVariable("stringStatsArray", "gmcp_statsArray = "..serialize.save_simple(statsArray))
    --tprint(statsArray)
    --print(decodeResult[2])
    Execute("gmcpVitalsUpdate")
  end)
  
  gmcp.Listen("Char.StatusVars", function(message, content)
  	statusVars = {}
		for k,v in pairs(content) do
  	statusVars[k]=v
  	end
  	SetVariable("stringStatusVars","gmcp_statusVars = "..serialize.save_simple(statusVars))
  	Execute("gmcpStatusVarsUpdate")
  end)
  
  gmcp.Listen("Char.Status", function(message, content)
  	charstatus={}
		for k,v in pairs(content) do
  	charstatus[k]=v
  	end
  	SetVariable("stringStatus","gmcp_status = "..serialize.save_simple(charstatus))
  	Execute("gmcpStatusUpdate")
  end)
  
  gmcp.Listen("Char.Items.List", function(message, content)
  	charInv = {}
		for k,v in pairs(content) do
  	charInv[k]=v
  	end
  	SetVariable("stringInv","gmcp_items = "..serialize.save_simple(charInv))
  	Execute("gmcpItemsUpdate")
  end)
  
  gmcp.Listen("Char.Items.Add", function(message, content)
  	itemsAdd = {}
		for k,v in pairs(content) do
  	itemsAdd[k]=v
  	end
  	SetVariable("stringItemsAdd","gmcp_itemsAdd = "..serialize.save_simple(itemsAdd))
  	Execute("gmcpItemsAddUpdate")
  end)
  
  gmcp.Listen("Char.Items.Update", function(message, content)
  	itemsUpdate = {}
		for k,v in pairs(content) do
  	itemsUpdate[k]=v
  	end
  	SetVariable("stringItemsUpdate","gmcp_itemsUpdate = "..serialize.save_simple(itemsUpdate))
  	Execute("gmcpItemsUpdateUpdate")
  end)  
  
  gmcp.Listen("Char.Items.Remove", function(message, content)
  	itemsRemove = {}
		for k,v in pairs(content) do
  	itemsRemove[k]=v
  	end
  	SetVariable("stringItemsRemove","gmcp_itemsRemove = "..serialize.save_simple(itemsRemove))
  	Execute("gmcpItemsRemoveUpdate")
  end)
  
  gmcp.Listen("Char.Defences.List", function(message, content)
  	defs = {}
		for k,v in pairs(content) do
  	defs[k]=v
  	end
  	SetVariable("stringDefs","gmcp_defs = "..serialize.save_simple(defs))
  	Execute("gmcpDefsUpdate")
  end)
  
  gmcp.Listen("Char.Defences.Add", function(message, content)
  	defsAdd = {}
		for k,v in pairs(content) do
  	defsAdd[k]=v
  	end
  	SetVariable("stringDefsAdd","gmcp_defsAdd = "..serialize.save_simple(defsAdd))
  	Execute("gmcpDefsAddUpdate")
  end)
  
  gmcp.Listen("Char.Defences.Remove", function(message, content)
  	defsRemove = {}
		for k,v in pairs(content) do
  	defsRemove[k]=v
  	end
  	SetVariable("stringDefsRemove","gmcp_defsRemove = "..serialize.save_simple(defsRemove))
  	Execute("gmcpDefsRemoveUpdate")
  end)
  
  gmcp.Listen("Char.Afflictions.List", function(message, content)
  	affs = {}
		for k,v in pairs(content) do
  	affs[k]=v
  	end
  	SetVariable("stringAffs","gmcp_affs = "..serialize.save_simple(affs))
  	Execute("gmcpAffsUpdate")
  end)
  
  gmcp.Listen("Char.Afflictions.Add", function(message, content)
  	affsAdd = {}
		for k,v in pairs(content) do
  	affsAdd[k]=v
  	end
  	SetVariable("stringAffsAdd","gmcp_affsAdd = "..serialize.save_simple(affsAdd))
  	Execute("gmcpAffsAddUpdate")
  end)
  
  gmcp.Listen("Char.Afflictions.Remove", function(message, content)
  	affsRemove = {}
		for k,v in pairs(content) do
  	affsRemove[k]=v
  	end
  	SetVariable("stringAffsRemove","gmcp_affsRemove = "..serialize.save_simple(affsRemove))
  	Execute("gmcpAffsRemoveUpdate")
  end)
  
  gmcp.Listen("Room.Players", function(message, content)
  	roomPlayers = {}
		for k,v in pairs(content) do
  	roomPlayers[k]=v
  	end
  	SetVariable("stringRoomPlayers","gmcp_roomPlayers = "..serialize.save_simple(roomPlayers))
  	Execute("gmcpRoomPlayersUpdate")
  end)

  gmcp.Listen("Room.AddPlayer", function(message, content)
  	roomAddPlayer = {}
		for k,v in pairs(content) do
  	roomAddPlayer[k]=v
  	end
  	SetVariable("stringRoomAddPlayer","gmcp_roomAddPlayer = "..serialize.save_simple(roomAddPlayer))
  	Execute("gmcpRoomAddPlayerUpdate")
  end)
  
  gmcp.Listen("Room.RemovePlayer", function(message,content)
		roomRemovePlayer=content
  	SetVariable("stringRoomRemovePlayer", serialize.save_simple(roomRemovePlayer))
  	Execute("gmcpRoomRemovePlayerUpdate")
  end)
  
  gmcp.Listen("IRE.Rift.List", function(message, content)
  	riftList = {}
		for k,v in pairs(content) do
  	riftList[k]=v
  	end
  	SetVariable("stringRiftList","gmcp_riftList = "..serialize.save_simple(riftList))
  	Execute("gmcpRiftListUpdate")
  end)
  
  gmcp.Listen("IRE.Rift.Change", function(message, content)
  	riftCharge = {}
		for k,v in pairs(content) do
  	riftChange[k]=v
  	end
  	SetVariable("stringRiftChange","gmcp_riftChange = "..serialize.save_simple(riftChange))
  	Execute("gmcpRiftChangeUpdate")
  end)
  
end)

--experimental: register a function to call
function to_call(func)
	print(func)
	if type(func)=="function" then
		update_func = func
	end
end
  
function OnPluginBroadcast(msg,id,name,text)
	if type(id)~="string" or msg==2 or type(text)~="string" or #text==0 then
		return false
	end
	if id=="29a4c0721bef6ae11c3e9a82" then
	  gmcp_msg=text
		--print(update_func)
		--[[if update_func and type(update_func)=="function" then
			update_func(gmcp_msg)
		end]]
	end
end

--[[
PPI.OnLoad("29a4c0721bef6ae11c3e9a82", function(gmcp)
  gmcp.Listen("Char.StatusVars", function(message, content)
  	for k,v in pairs(content) do
  	statusVars[k]=v
  	end
  	SetVariable("stringStatusVars",serialize.save_simple(statusVars))
  	Execute("gmcpRefresh")
  end)
end)]]
  

OnPluginListChanged = function()
  PPI.Refresh()
end

OnPluginClose = function()
  WindowDelete(name)
end

OnPluginEnable = OnPluginInstall
OnPluginDisable = OnPluginClose
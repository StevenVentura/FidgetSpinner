--Author: Soccerbilly aka Gangsthurh (Steven Ventura)
--Date Created: 6/13/17
--purpose: addon template
--[[
http://multiplayer1205.blogspot.com/2012/05/using-3d-models-in-world-of-warcraft-ui.html
http://wowprogramming.com/docs/widgets_hierarchy
https://github.com/relaxok/wow010/blob/master/M2Template1.bt


]]
FidgetSpinner = CreateFrame("Frame");

--FidgetSpinner:SetScript("OnEvent",function(self,event,...) self[event](self,event,...);end)
FidgetSpinner:SetScript("OnUpdate", function(self, elapsed) FidgetSpinnerOnUpdate(self, elapsed) end)
FidgetSpinner:RegisterEvent("VARIABLES_LOADED");




SLASH_FidgetSpinner1 = "/FidgetSpinner"; SLASH_FidgetSpinner2 = "/ms"; SLASH_FidgetSpinner3 = "/midget";
SlashCmdList["FidgetSpinner"] = slashFidgetSpinner;

function slashFidgetSpinner(msg,editbox)
command, rest = msg:match("^(%S*)%s*(.-)$");
print("ayy")
end--end function
--local function taken from http://stackoverflow.com/questions/1426954/split-string-in-lua by user973713 on 11/26/15
function FidgetSpinnerSplitString(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; local i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end


lagLess = 0;
FidgetSpinnerTimeDelayThing = 0.50;
function FidgetSpinnerOnUpdate(self, elapsed)
lagLess = lagLess + elapsed;
if (lagLess < FidgetSpinnerTimeDelayThing) then  return end
lagLess = 0;
--do stuff here


end--end function FidgetSpinnerOnUpdate






--this is called after the variables are loaded
function FidgetSpinnerInit()
--TESTING CODE -- TEST
WorldFrameMaxWidth = UIParent:GetWidth();--WorldFrame:GetWidth();
WorldFrameMaxHeight = UIParent:GetHeight();--WorldFrame:GetHeight();
local numrows, numcols = 5,5; 
local f = CreateFrame("Frame","FidgetSpinnerTestFrame",UIParent);
local width, height = WorldFrameMaxWidth/numrows, WorldFrameMaxHeight/numcols;
f:SetSize(width,width);
f:SetPoint("TOPLEFT",300,-300);
--local model = CreateFrame("PlayerModel","stevenoob" .. (r*10 + c),f);
local model = CreateFrame("DressUpModel","mst",f);
f.portrait = model;
model:SetUnit("player");
model:SetTexture('Interface/AddOns/FidgetSpinner/images/purpledragon.tga')
--7 is gnome, 0 is male
--[[model:SetCustomRace(7,0);
model:UndressSlot(1)--helmet
model:SetAnimation(225)]]


--model:SetCreature(822);--bear

--model:SetAnimation(126);--https://us.battle.net/forums/en/wow/topic/8569600188
model:SetAllPoints();
f:Show();

end--end function FidgetSpinnerInit
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
pleaseIncrement = 0;
function FidgetSpinnerOnUpdate(self, elapsed)
lagLess = lagLess + elapsed;
if (lagLess < FidgetSpinnerTimeDelayThing) then  return end
lagLess = 0;
--do stuff here
pleaseIncrement = pleaseIncrement + 0.25;
FidgetSpinnerImageTexture:SetRotation(pleaseIncrement,0.5,0.5);
end--end function FidgetSpinnerOnUpdate




fidgetFilePath = 'Interface/AddOns/FidgetSpinner/images/';

--this is called after the variables are loaded
function FidgetSpinnerInit()
--TESTING CODE -- TEST
WorldFrameMaxWidth = UIParent:GetWidth();--WorldFrame:GetWidth();
WorldFrameMaxHeight = UIParent:GetHeight();--WorldFrame:GetHeight();

local fs = CreateFrame("FRAME","FidgetSpinnerImageFrame",UIParent);
fs:SetSize(300,300);
fs:SetPoint("TOPLEFT",0,-100);
FidgetSpinnerImageTexture = fs:CreateTexture();
FidgetSpinnerImageTexture:SetTexture(fidgetFilePath .. 'black.tga');
FidgetSpinnerImageTexture:SetAllPoints()
FidgetSpinnerImageFrame:CreateFontString("FidgetFontString","HIGH","GameFontNormal");
FidgetFontString:SetTextColor(1,0.643,0.169,1);
FidgetFontString:SetShadowColor(0,0,0,1);
FidgetFontString:SetPoint("TOPLEFT");
FidgetFontString:SetText("Time To Spin");
FidgetFontString:Show();

fs:Show()

end--end function FidgetSpinnerInit
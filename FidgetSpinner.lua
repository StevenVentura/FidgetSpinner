--Author: Soccerbilly aka Gangsthurh (Steven Ventura)
--Date Created: 6/13/17
--purpose: addon template
--[[
http://multiplayer1205.blogspot.com/2012/05/using-3d-models-in-world-of-warcraft-ui.html
http://wowprogramming.com/docs/widgets_hierarchy
https://github.com/relaxok/wow010/blob/master/M2Template1.bt


]]
FidgetSpinner = CreateFrame("Frame");
FidgetSpinner.speed = 0;
FidgetSpinner.acceleration = -0.0005 * 2.5 * 2;
FidgetSpinner.angle = 0;
FidgetSpinner.plusColor = 0;

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
FidgetSpinnerTimeDelayThing = 0.10;
function FidgetSpinnerOnUpdate(self, elapsed)
lagLess = lagLess + elapsed;
if (lagLess < FidgetSpinnerTimeDelayThing) then  return end
lagLess = 0;
--do stuff here
if ( not(FidgetSpinner.speed == 0)) then 
FidgetSpinner.timeSpun = FidgetSpinner.timeSpun + FidgetSpinnerTimeDelayThing /2 ;
FidgetFontString2:SetText("Time Spun:" .. string.format("%.1f", FidgetSpinner.timeSpun));
else FidgetSpinner.timeSpun = 0; end
FidgetSpinner.speed = FidgetSpinner.speed + FidgetSpinner.acceleration;
if (FidgetSpinner.speed < 0) then FidgetSpinner.speed = 0; end
FidgetSpinner.angle = FidgetSpinner.angle + FidgetSpinner.speed;
FidgetSpinnerImageTexture:SetRotation(FidgetSpinner.angle,0.5,0.5);
FidgetFontString:SetText("speed:" .. string.format("%.1f",FidgetSpinner.speed*10));

if (FidgetSpinnerIntensityColorObj ~= nil) then
local currentTime = GetTime();
local captho = 0.75;
if (currentTime - FidgetSpinner.timeLastClick > captho) then
--reset the average
FidgetSpinner.plusColor = 0;
end
FidgetSpinnerIntensityColorObj:SetColorTexture(FidgetSpinner.plusColor,0.25*FidgetSpinner.plusColor + 0.25,0);
end

end--end function FidgetSpinnerOnUpdate



FidgetSpinner.timeLastClickAverage = 0;
FidgetSpinner.timeLastClick = 0;
FidgetSpinner.averagePoints = 0;

function FidgetSpinner_SPINBUTTONPRESSED()

--FidgetSpinner.speed = FidgetSpinner.acceleration; --FidgetSpinner.speed + 0.009*2 * 1/8 / (FidgetSpinner.speed + 0.01);

local currentTime = GetTime();
local captho = 0.75;
if (currentTime - FidgetSpinner.timeLastClick > captho) then
--reset the average
FidgetSpinner.timeLastClickAverage = 0;
FidgetSpinner.averagePoints = 0;
FidgetSpinner.plusColor = 0;
else
FidgetSpinner.averagePoints = FidgetSpinner.averagePoints + 1;
local pls = currentTime - FidgetSpinner.timeLastClick;

if (FidgetSpinner.timeLastClickAverage == 0) then FidgetSpinner.timeLastClickAverage = captho else
local please = FidgetSpinner.timeLastClickAverage*(FidgetSpinner.averagePoints-1);
please = (please + pls) / FidgetSpinner.averagePoints;
FidgetSpinner.timeLastClickAverage = please;

end--end if

end--end if

local plus =  3*0.010*((captho - FidgetSpinner.timeLastClickAverage)/captho);

FidgetSpinner.plusColorTemp = 33.33333 * plus;
if (FidgetSpinner.plusColorTemp > 0.95) then
FidgetSpinner.plusColorTemp = 0.60;
end
--max is 0.8
--higher numbers are better speeds
--lowest is 0.45

-- the two clamps
if (FidgetSpinner.plusColorTemp > 0.8) then
FidgetSpinner.plusColor = 1;
end
if (FidgetSpinner.plusColorTemp < 0.45) then
FidgetSpinner.plusColor = 0;
end

if (FidgetSpinner.plusColorTemp > 0.45 and FidgetSpinner.plusColorTemp < 0.80) then
local xplease = FidgetSpinner.plusColorTemp - 0.45;
FidgetSpinner.plusColor = xplease*2.857142857142857;
end

print(FidgetSpinner.plusColor);
--now scale it 0.45 to 0.80



plus = plus * 1 / (FidgetSpinner.speed + 0.1);

FidgetSpinner.speed = FidgetSpinner.speed + plus;


FidgetSpinner.timeLastClick = currentTime;
end--end function


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
FidgetSpinnerImageFrame:CreateFontString("FidgetFontString2","HIGH","GameFontNormal");
FidgetFontString2:SetTextColor(1,0.643,0.169,1);
FidgetFontString2:SetShadowColor(0,0,0,1);
FidgetFontString2:SetPoint("TOPLEFT",100,0);
FidgetFontString2:SetText("Time Spun:");
FidgetFontString2:Show();
CreateFrame("Button", "FidgetSpinnerSpinButton", FidgetSpinnerImageFrame, "UIPanelButtonTemplate");
FidgetSpinnerSpinButton:SetSize(75,50);
FidgetSpinnerSpinButton:SetPoint("TOPLEFT",0,-200)
FidgetSpinnerSpinButton:SetScript("OnClick",FidgetSpinner_SPINBUTTONPRESSED);
FidgetSpinnerSpinButton:SetText("SPIN")
FidgetSpinnerSpinButton:Show()

CreateFrame("FRAME","FidgetSpinnerIntensityColor",fs);
FidgetSpinnerIntensityColor:SetSize(200,100);
FidgetSpinnerIntensityColor:SetPoint("BOTTOMRIGHT");
FidgetSpinnerIntensityColorObj = FidgetSpinnerIntensityColor:CreateTexture("ARTWORK");
FidgetSpinnerIntensityColorObj:SetColorTexture(FidgetSpinner.plusColor,0.25*FidgetSpinner.plusColor + 0.25,0);
FidgetSpinnerIntensityColorObj:SetAlpha(1);
FidgetSpinnerIntensityColorObj:SetAllPoints();
FidgetSpinnerIntensityColor:Show();
fs:Show()

end--end function FidgetSpinnerInit
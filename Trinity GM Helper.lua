--Trinity GM Helper
--Created by Arcemu
--Converted by Chillu
--Updated by Kibblebit

chanvar = "GUILD";

function OpenMain()
    if( view == 1 ) then
        FullForm:Show();
    elseif( view == 2 ) then
        MinipForm:Show();
    elseif( view == 3 ) then
        MiniForm:Show();
    else
        FullForm:Show();
    end
end

function ToggleAddon()
if( addonopen == 1 ) then
FullForm:Hide();
CommForm:Hide();
ItemForm:Hide();
MiscForm:Hide();
ObjectForm:Hide();
TicketForm:Hide();
TeleForm:Hide();
ProfessionsForm:Hide();
SkillForm:Hide();
SpellForm:Hide();
BanForm:Hide();
NPCForm:Hide();
PlayerForm:Hide();
WepskForm:Hide();
OverridesForm:Hide();
ModifyForm:Hide();
QuickItemForm:Hide();
PetForm:Hide();
MailForm:Hide();
PlaySound("INTERFACESOUND_CHARWINDOWCLOSE");
addonopen = 0;
else
OpenMain();
PlaySound("INTERFACESOUND_CHARWINDOWOPEN");
addonopen = 1;
end
end

function outSAY(text)
 --SendChatMessage("."..text, "GUILD", nil,nil);--functional type2
 --SendChatMessage(""..text, "GUILD", nil,nil);--test type2
 --SendChatMessage(""..text, "SAY", nil,nil);--test type2noguild
 --SendChatMessage(text, "GUILD", nil,nil);--old]]
 SendChatMessage(""..text, chanvar, nil, nil);
end

function GMHelperOnLoad()
this:RegisterForDrag("RightButton");
--[[JoinChannelByName("gm_sync_channel", "lhjf448gfdw279hgfw6");]]
--JoinChannelByName("gm_sync_channel", ChatFrame1:GetID());
end

function GMHelper_Loaded()
UIErrorsFrame:AddMessage("Trinity GM Helper loaded!", 0.0, 1.0, 0.0, 53, 2);
--PSoundF("Interface\\Addons\\GMH\\Sounds\\Omega.wav"); To help me remember this function later down the road.
OpenMain();
addonopen = 1;
end

function PSoundF(file)
    PlaySoundFile(file);
end

function ShowGMHMinimap()
GameTooltip:SetOwner(this, "ANCHOR_LEFT");
GameTooltip:AddLine( "|cFF00FF00Trinity GM Helper|r" );
GameTooltip:AddLine( "|cFF00FFCCLeft click to show/hide|r" );
GameTooltip:AddLine( "|cFFFF0000Right click to drag this|r" );
GameTooltip:Show();
end

-- Binding Variables
BINDING_HEADER_GMHelper = "GM Helper";
BINDING_NAME_ToggleAddon = "Toggles GM Helper";
-----------------------------------------------------------------------------------------------------------------------------------------------------------
-- AnnounceScript
function SetAnnouncementChecked()
if (AnnounceCheck:GetChecked() or ScreenCheck:GetChecked() or GMAnnounceCheck:GetChecked() ) then
Announce();
else
UIErrorsFrame:AddMessage("Select an announcement type.", 1.0, 0.0, 0.0, 53, 2);
end
end

function FirstAnnounce()
if (AnnounceSetCheck:GetChecked() or ScreenAnnounceSetCheck:GetChecked() or GMAnnounceSetCheck:GetChecked() ) then
if AnnounceSetCheck:GetChecked() then
firstannounce=".announce "..SetAnnounceText:GetText();
UIErrorsFrame:AddMessage("1st Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);
end
if ScreenAnnounceSetCheck:GetChecked() then
firstannounce=".nameannounce "..SetAnnounceText:GetText();
UIErrorsFrame:AddMessage("1st Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);    
end
if GMAnnounceSetCheck:GetChecked() then
firstannounce=".gmnameannounce "..SetAnnounceText:GetText(); 
UIErrorsFrame:AddMessage("1st Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);   
end
else
UIErrorsFrame:AddMessage("Select an announcement type.", 1.0, 0.0, 0.0, 53, 2);
end
end

function SecondAnnounce()
if (AnnounceSetCheck:GetChecked() or ScreenAnnounceSetCheck:GetChecked() or GMAnnounceSetCheck:GetChecked() ) then
if AnnounceSetCheck:GetChecked() then
secondannounce=".announce "..SetAnnounceText:GetText();
UIErrorsFrame:AddMessage("2nd Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);    
end
if ScreenAnnounceSetCheck:GetChecked() then
secondannounce=".nameannounce "..SetAnnounceText:GetText(); 
UIErrorsFrame:AddMessage("2nd Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);   
end
if GMAnnounceSetCheck:GetChecked() then
secondannounce=".gmnameannounce "..SetAnnounceText:GetText(); 
UIErrorsFrame:AddMessage("2nd Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);   
end
else
UIErrorsFrame:AddMessage("Select an announcement type.", 1.0, 0.0, 0.0, 53, 2);
end  
end

function ThirdAnnounce()
if (AnnounceSetCheck:GetChecked() or ScreenAnnounceSetCheck:GetChecked() or GMAnnounceSetCheck:GetChecked() ) then
if AnnounceSetCheck:GetChecked() then
thirdannounce=".announce "..SetAnnounceText:GetText();
UIErrorsFrame:AddMessage("3rd Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);    
end
if ScreenAnnounceSetCheck:GetChecked() then
thirdannounce=".nameannounce "..SetAnnounceText:GetText();
UIErrorsFrame:AddMessage("3rd Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);    
end
if GMAnnounceSetCheck:GetChecked() then
thirdannounce=".gmnameannounce "..SetAnnounceText:GetText();
UIErrorsFrame:AddMessage("3rd Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);    
end
else
UIErrorsFrame:AddMessage("Select an announcement type.", 1.0, 0.0, 0.0, 53, 2);
end     
end

function FourthAnnounce()
if (AnnounceSetCheck:GetChecked() or ScreenAnnounceSetCheck:GetChecked() or GMAnnounceSetCheck:GetChecked() ) then
if AnnounceSetCheck:GetChecked() then
fourthannounce=".announce "..SetAnnounceText:GetText();
UIErrorsFrame:AddMessage("4th Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);    
end
if ScreenAnnounceSetCheck:GetChecked() then
fourthannounce=".nameannounce "..SetAnnounceText:GetText(); 
UIErrorsFrame:AddMessage("4th Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);   
end
if GMAnnounceSetCheck:GetChecked() then
fourthannounce=".gmnameannounce "..SetAnnounceText:GetText(); 
UIErrorsFrame:AddMessage("4th Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);   
end
else
UIErrorsFrame:AddMessage("Select an announcement type.", 1.0, 0.0, 0.0, 53, 2);
end     
end

function FifthAnnounce()
if (AnnounceSetCheck:GetChecked() or ScreenAnnounceSetCheck:GetChecked() or GMAnnounceSetCheck:GetChecked() ) then
if AnnounceSetCheck:GetChecked() then
fifthannounce=".announce "..SetAnnounceText:GetText();
UIErrorsFrame:AddMessage("5th Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);    
end
if ScreenAnnounceSetCheck:GetChecked() then
fifthannounce=".nameannounce "..SetAnnounceText:GetText(); 
UIErrorsFrame:AddMessage("5th Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);   
end
if GMAnnounceSetCheck:GetChecked() then
fifthannounce=".gmnameannounce "..SetAnnounceText:GetText(); 
UIErrorsFrame:AddMessage("5th Announcement Saved!", 0.0, 1.0, 0.0, 53, 2);   
end
else
UIErrorsFrame:AddMessage("Select an announcement type.", 1.0, 0.0, 0.0, 53, 2);
end     
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ban Script

function BanPlayer()
result=".ban character "..CharName:GetText().." "..BanLength:GetText().." "..BanReason:GetText();   
outSAY(result);
end

function UnBanPlayer()
result=".unban character "..CharName:GetText();    
outSAY(result);
end

function AddIPBan()
result=".ban ip "..IPAddress1:GetText().." "..Duration1:GetText();    
outSAY(result);
end

function DelIPBan()
result=".unban ip "..IPAddress1:GetText();
outSAY(result);
end

function KickPlayer()
result=".kick "..CharName:GetText().." "..BanReason:GetText();    
outSAY(result);
end

function ParPlayer()
result=".freeze";    
outSAY(result);
end

function UnParPlayer()
result=".unfreeze";    
outSAY(result);
end

function PInfo()
result=".pinfo "..CharName:GetText();    
outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BattlegroundScript

function BGStart()
    result=".debug bg";
    outSAY(result);
end

function BGForceStart()
    result=".battleground forcestart";
    outSAY(result);
end

function BGInfo()
    result=".battleground bginfo";
    outSAY(result);
end

function BGLeave()
    result=".battleground leave"
    outSAY(result);
end

function BGGetQueue()
    result=".battleground getqueue"
    outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CommScript

function AnnounceChecked()
if (AnnounceCheck:GetChecked() or ScreenCheck:GetChecked() or GMAnnounceCheck:GetChecked() ) then
Announce();
else
UIErrorsFrame:AddMessage("Select an announcement type.", 1.0, 0.0, 0.0, 53, 2);
end
end


function Announce()
if ( AnnounceCheck:GetChecked() ) then--Announce
	result=".announce "..AnnounceText:GetText();
	outSAY(result);
else
    result="";
	outSAY(result);
end
if ( ScreenCheck:GetChecked() ) then--Announce
	result=".nameannounce "..AnnounceText:GetText();
	outSAY(result);
else
    result="";
	outSAY(result);
end
if ( GMAnnounceCheck:GetChecked() ) then--Announce
	result=".gmnameannounce "..AnnounceText:GetText();
	outSAY(result);
else
    result="";
	outSAY(result);
end
end

function WhisperOn()
result=".whispers on";
outSAY(result);
end

function WhisperOff()
result=".whispers off";
outSAY(result);
end

function SayFirstAnnounce()
if firstannounce == nil then
UIErrorsFrame:AddMessage("The announcement was not set. Do so in the Announcement Form.", 1.0, 0.0, 0.0, 53, 2);
else
outSAY(firstannounce);
end
end

function SaySecondAnnounce()
if secondannounce == nil then
UIErrorsFrame:AddMessage("The announcement was not set. Do so in the Announcement Form.", 1.0, 0.0, 0.0, 53, 2);
else
outSAY(secondannounce);
end
end

function SayThirdAnnounce()
if thirdannounce == nil then
UIErrorsFrame:AddMessage("The announcement was not set. Do so in the Announcement Form.", 1.0, 0.0, 0.0, 53, 2);
else
outSAY(thirdannounce);
end
end

function SayFourthAnnounce()
if fourthannounce == nil then
UIErrorsFrame:AddMessage("The announcement was not set. Do so in the Announcement Form.", 1.0, 0.0, 0.0, 53, 2);
else
outSAY(fourthannounce);
end
end

function SayFifthAnnounce()
if fifthannounce == nil then
UIErrorsFrame:AddMessage("The announcement was not set. Do so in the Announcement Form.", 1.0, 0.0, 0.0, 53, 2);
else
outSAY(fifthannounce);
end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ItemScript

function RepairItem()
result=".repairitems"    
outSAY(result);
end

function AddItem()
if ItemNumber:GetText() == "" then
UIErrorsFrame:AddMessage("Please specify an item name or entry ID.", 1.0, 0.0, 0.0, 53, 2);
else
result=".additem "..ItemNumber:GetText().." "..ItemQuantity1:GetText();    
outSAY(result);
end
end

function AddItemSet()
result=".additemset "..ItemSetNumber:GetText();    
outSAY(result);
end

function SearchItem()
result=".lookup item "..ItemNumber:GetText();    
outSAY(result);
end

function AddMoney()
IntGold = Gold:GetNumber();
IntSilver = Silver:GetNumber();
IntCopper = Copper:GetNumber();
-- 214748g 35s 47c
result = ".modify money " ..IntGold*10000+IntSilver*100+IntCopper;
outSAY(result);
end

---------------------------------------------
--          End of Advance Command         --
---------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ItemSearchScript

---------------------------------------------
-- Everything below was done by Gondrup and added by Mukele. Thank you Mukele! - Maven --
---------------------------------------------

-- Below vars are used throughout the item search
item_search_results = {}
itemName = {}
ISFItem = {}
itemNameReal = {}
itemLink = {}
itemRarity = {}
itemLevel = {}
itemMinLevel = {}
itemType = {}
itemSubType = {}
itemStackCount = {}
itemEquipLoc = {}
itemTexture = {}

i = 1;

-- Item colour based on rarity
function SetQuality(quality)
    if (quality == 0) then
        return "|c00A9A9A9"; -- Poor
    elseif (quality == 1) then
        return "|c00FFFFFF"; -- Common
    elseif (quality == 2) then
        return "|c007CFC00"; -- Uncommon
    elseif (quality == 3) then
        return "|c004169E1"; -- Rare
    elseif (quality == 4) then
        return "|c009932CC"; -- Epic
    elseif (quality == 5) then
        return "|c00FF8C00"; -- Legendary
    else
        return "|c00FFFFFF"; -- Common
    end
end

-- Fired when a server message is sent to the client
function Chat_OnEvent(event, text)
	--Detects if you tried to advance a skill but didnt get it 
	if latestSkillID=="" and text=="Does not have skill line, adding." then
	elseif text=="Does not have skill line, adding." then
		outSAY(".setskill "..latestSkillID.." "..latestSkillLevel);
		latestSkillID="";
    elseif string.find(text, "Item") then
		-- If the detected string is an item result
        idlength, _, _, _ = string.find(text, ":");
        item_search_results[i] = string.sub(text, 6, idlength-1);  
        itemName[i] = text;
        ProcessItemSearch(item_search_results[i]);
        i = i + 1;
    -- Reset if its a new search
    elseif string.find(text, "Starting search of item ") then
        for i=1, 25 do
            getglobal("ItemFormSearchTexture"..i.."Texture"):SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
            getglobal("ItemFormSearchTexture"..i):Hide();
            getglobal("ItemFormSearchLabelItemID"..i):Hide();
            getglobal("ItemFormSearchButton"..i):Hide();
        end
        i = 1;
    end
end

-- Function to update each button when a result is recieved by the client
function ProcessItemSearch(itemid)
    getglobal("ItemFormSearchTexture"..i):Show();
    getglobal("ItemFormSearchLabelItemID"..i):Show();
    getglobal("ItemFormSearchButton"..i):Show();
    -- Update "number of results" text
    text = "Results Found: "..i;
    ItemFormSearchLabel2Label:SetText(text);
    if GetItemInfo(itemid) then
        itemNameReal[i], itemLink[i], itemRarity[i], itemLevel[i], itemMinLevel[i], itemType[i], itemSubType[i], itemStackCount[i], itemEquipLoc[i], itemTexture[i] = GetItemInfo(itemid);
        getglobal("ItemFormSearchLabelItemID"..i.."Label"):SetText(SetQuality(itemRarity[i])..itemNameReal[i]);
        getglobal("ItemFormSearchTexture"..i.."Texture"):SetTexture(itemTexture[i]);
    else
        getglobal("ItemFormSearchLabelItemID"..i.."Label"):SetText(itemName[i]);
        getglobal("ItemFormSearchTexture"..i.."Texture"):SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
    end
end

-- When a button is rolled over, show tooltip and update vars based on user cache
function ResultButton_OnEnter(button_number)
    GameTooltip:ClearLines();
    GameTooltip:SetOwner(this, "ANCHOR_RIGHT", -(this:GetWidth() / 2), 24)
    GameTooltip:SetHyperlink("item:"..item_search_results[button_number]..":0:0:0:0:0:0:0");
    if GetItemInfo(item_search_results[button_number]) then
        itemNameReal[button_number], itemLink[button_number], itemRarity[button_number], itemLevel[button_number], itemMinLevel[button_number], itemType[button_number], itemSubType[button_number], itemStackCount[button_number], itemEquipLoc[button_number], itemTexture[button_number] = GetItemInfo(item_search_results[button_number]);
        getglobal("ItemFormSearchLabelItemID"..button_number.."Label"):SetText(SetQuality(itemRarity[button_number])..itemNameReal[button_number]);
        getglobal("ItemFormSearchTexture"..button_number.."Texture"):SetTexture(itemTexture[button_number]);
	GameTooltip:AddLine("Item ID: "..item_search_results[button_number]);
	GameTooltip:AddLine("Click to add to inventory");
	--GameTooltip:AddLine("Ctrl+Click to preview on character");
    else
	GameTooltip:ClearLines();
	GameTooltip:AddLine("|c00B0E0E6"..itemName[button_number]);
	GameTooltip:AddLine("Click to add to inventory");
	--GameTooltip:AddLine("Ctrl+Click to preview on character");
    end
    GameTooltip:Show();
end

-- Hide the tooltip when mouse leaves a button
function ResultButton_OnLeave()
    GameTooltip:Hide();
end

-- When a button is clicked dress-up, else hold control to add to inventory
function ResultButton_OnClick(button_number)
--local itemid = item_search_results[button_number]
--if IsControlKeyDown() == false then
result = ".additem "..item_search_results[button_number];
outSAY(result);
--outSAY(ISFItem);
--[[else
DressUpFrame:Show();
DressUpModel:SetUnit("player");
DressUpItemLink(itemid);]]
end

function DressUpShow()
 local itemid = item_search_results[button_number]
 DressupFrame:Show();
 DressUpModel:SetUnit("player");
 DressUpItemLink(itemid);
end

---------------------------------------------
--            End of Item search           --
---------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- MiscScript

function SInfo()
    result=".server info";
    outSAY(result);
end

function Invis()
    result=".gm visible off";
    outSAY(result);
end

function Invince()
    result=".ticket list";
    outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--ModifyScript

 function ModSpeed()
	result=".modify aspeed "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModHP()
	result=".modify hp "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModMana()
	result=".modify mana "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModEnergy()
	result=".modify energy "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModRage()
	result=".modify rage "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModResistance()
	result=".modify holy "..ModifyEditBox:GetText();
	outSAY(result);
    result=".modify fire "..ModifyEditBox:GetText();
	outSAY(result);
    result=".modify nature "..ModifyEditBox:GetText();
	outSAY(result);
    result=".modify frost "..ModifyEditBox:GetText();
	outSAY(result);
    result=".modify shadow "..ModifyEditBox:GetText();
	outSAY(result);
    result=".modify arcane "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModArmor()
	result=".modify armor "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModDamage()
	result=".modify damage "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModDisplay()
	result=".modify morph "..ModifyEditBox:GetText();
	outSAY(result);
end

function Demorph()
	result=".demorph"
	outSAY(result);
end

function ModSpeed()
	result=".modify aspeed "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModScale()
	result=".modify scale "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModSpirit()
	result=".modify spirit "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModTP()
	result=".modify tp "..ModifyEditBox:GetText();
	outSAY(result);
end

function ModFaction()
result=".modify faction "..ModifyEditBox:GetText();
outSAY(result);
end

function ModRunicPower()
result=".modify runicpower "..ModifyEditBox:GetText();
outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- NPCScript

function AddItemVendor()
result=".npc additem "..NPCItemNumber:GetText();    
outSAY(result);
end

function RemoveItemVendor()
result=".npc delitem "..NPCItemNumber:GetText();    
outSAY(result);
end

function SpawnNPC()
result=".npc add "..NPCNumber:GetText();    
outSAY(result);
end

function DeleteNPCbyNumber()
result=".npc delete "..NPCNumber:GetText();    
outSAY(result);
end

function DeleteNPC()
result=".npc delete";    
outSAY(result);
end

function NPCCome()
    result=".cometome 1";
    outSAY(result);
end

function NPCPos()
    result=".possess";
    outSAY(result);
end

function NPCUnPos()
    result=".unpossess";
    outSAY(result);
end

function NPCInfo()
result=".npc info";
outSAY(result);
end

function NPCLookup()
result=".lookup creature "..NPCNumber:GetText();
outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ObjectScript

function TargetObject()
result=".gobject target ";    
outSAY(result);
end

function ObjectInfo()
result=".go info "; 
outSAY(result);
end

function DeleteObject()
result=".gobject delete ";    
outSAY(result);
end

function PlaceObject()
if ObjectNumber:GetText() == "" then
UIErrorsFrame:AddMessage("Please specify an object entry ID.", 1.0, 0.0, 0.0, 53, 2);
else
PlaceObjectTrue();
end
end

function PlaceObjectTrue()
if NoSaveCheck:GetChecked() then
        result=".gobject add "..ObjectNumber:GetText();
        outSAY(result)
    else
        result=".gobject add "..ObjectNumber:GetText();
        outSAY(result)
end
end

function LookupObject()
result=".lookup object "..ObjectNumber:GetText();
outSAY(result)
end

function ObjectInfo()
result=".go info"
outSAY(result)
end

function ActivateObject()
result=".gobject activate"
outSAY(result)
end

function EnableObject()
result=".go enable"
outSAY(result)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- OverridesScript


function CheatStatus()
	result=".cheat status";
	outSAY(result);
end

function CheatUpdate()
if ( FlyCheck:GetChecked() ) then--fly
	result=".gm fly on";
	outSAY(result);
else
	result=".gm fly off";
	outSAY(result);
end
if ( NCDCheck:GetChecked() ) then--CoolDown
	result=".cooldown";
	outSAY(result);
else
	result=".cooldown";
	outSAY(result);
end
end

function FlySpeed()
result=".modify aspeed "..FlyEntry:GetText();
outSAY(result);
end

function FlightPath()
if ( TaxiCheck:GetChecked() ) then --Taxi
    result=".taxicheat on";
    outSAY(result);
else
    result=".taxicheat off";
    outSAY(result);
end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- PlayerScript
 function CreateGuild()
result=".guild create "..PlayerFormBox:GetText();  
outSAY(result);
end

function LevelPlayer()
result=".levelup "..PlayerFormBox:GetText();    
outSAY(result);
end

function RevivePlayer2()
result=".revive "..PlayerFormBox:GetText();
outSAY(result);
end

function LookupFaction()
result=".lookup faction "..PlayerFormBox:GetText();
outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- ProfessionsForm

function LearnRiding()
result=".learn 33388";   --Apprentice Riding 
outSAY(result);
result=".learn 33391";    --Journeyman Riding
outSAY(result);
result=".learn 34090";    --Expert Riding
outSAY(result);
result=".learn 34091";    --Artisan Riding
outSAY(result);
result=".learn 54197";    --Cold Weather Flying
outSAY(result);
end

function LearnJewel()
result=".setskill 755 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnBlackSmithing()
result=".setskill 164 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnTailoring()
result=".setskill 197 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnLeatherworking()
result=".setskill 165 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnEngineering()
result=".setskill 202 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnPoisons()
result=".setskill 40 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnEnchanting()
result=".setskill 333 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnFishing()
result=".setskill 356 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnMining()
result=".setskill 186 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnSkinning()
result=".setskill 393 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnAlchemy()
result=".setskill 171 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnHerbalism()
result=".setskill 182 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnFirstAid()
result=".setskill 129 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnCooking()
result=".setskill 185 "..SkillLevel:GetText();    
outSAY(result);
end

function LearnInscription()
result=".setskill 773 "..SkillLevel:GetText();    
outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--QuestScript
function LookupQuest()
result=".lookup quest "..QuestFormBox:GetText();
outSAY(result)
end

function QuestComplete()
result=".quest complete "..QuestFormBox:GetText();
outSAY(result)
end

function QuestStart()
result=".quest add "..QuestFormBox:GetText();
outSAY(result)
end

function QuestRemove()
result=".quest remove "..QuestFormBox:GetText();
outSAY(result)
end

function QuestStatus()
result=".quest status "..QuestFormBox:GetText();
outSAY(result)
end

function QuestReward()
result=".quest complete "..QuestFormBox:GetText();
outSAY(result)
end

function QuestSpawn()
result=".quest spawn "..QuestFormBox:GetText();
outSAY(result)
end

function QuestAddBoth()
result=".quest addboth "..QuestFormBox:GetText();
outSAY(result)
end

function QuestAddStart()
result=".quest addstart "..QuestFormBox:GetText();
outSAY(result)
end

function QuestAddFinish()
result=".quest addfinish "..QuestFormBox:GetText();
outSAY(result)
end

function QuestDelBoth()
result=".quest delboth "..QuestFormBox:GetText();
outSAY(result)
end

function QuestDelStart()
result=".quest delstart "..QuestFormBox:GetText();
outSAY(result)
end

function QuestDelFinish()
result=".quest delfinish "..QuestFormBox:GetText();
outSAY(result)
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--QuickItemScript

function GmOutfit()
result=".additem 2586"--Gamemaster's Robe
outSAY(result);
result=".additem 11508"--Gamemaster's Slippers
outSAY(result);
result=".additem 12064"--Gamemaster's Hood
outSAY(result);
result=".additem 12947"--Alex's Ring of Audacity
outSAY(result);
result=".additem 12947"--Alex's Ring of Audacity
outSAY(result);
result=".additem 192"--Martin Thunder (INSTA - KILL SPELL DOES NOT WORK ON MOST PRIVATE SERVERS)
outSAY(result);
result=".additem 19879"--Alex's Test Beatdown Staff
outSAY(result);
result=".additem 19160"--Contest Winner's Tabbard
outSAY(result);
result=".additem 23162"--Foror's Crate of Endless Resist Gear Storage
outSAY(result);
result=".additem 23162"--Foror's Crate of Endless Resist Gear Storage
outSAY(result);
result=".additem 23162"--Foror's Crate of Endless Resist Gear Storage
outSAY(result);
result=".additem 23162"--Foror's Crate of Endless Resist Gear Storage
outSAY(result);
end
--Gamemaster's Robe, Gamemaster's Slippers, Gamemaster's Hood, Alex's Ring of Audacity X2, Martin Thunder, Alex's Test Beatdown Staff, Contest Winner's Tabbard, Foror's Crate of Endless Resist Gear Storage X4

function MageT6()
result=".additem 46129"
outSAY(result);
result=".additem 46130"
outSAY(result);
result=".additem 46132"
outSAY(result);
result=".additem 46133"
outSAY(result);
result=".additem 46134"
outSAY(result);
end

function HunterT6()
result=".additem 46141"
outSAY(result);
result=".additem 46142"
outSAY(result);
result=".additem 46143"
outSAY(result);
result=".additem 46144"
outSAY(result);
result=".additem 46145"
outSAY(result);
end

function RogueT6()
result=".additem 46123"
outSAY(result);
result=".additem 46124"
outSAY(result);
result=".additem 46125"
outSAY(result);
result=".additem 46126"
outSAY(result);
result=".additem 46127"
outSAY(result);
end

function WarlockT6()
result=".additem 46135"
outSAY(result);
result=".additem 46136"
outSAY(result);
result=".additem 46137"
outSAY(result);
result=".additem 46139"
outSAY(result);
result=".additem 46140"
outSAY(result);
end

function WarriorT6()
result=".additem 46146"
outSAY(result);
result=".additem 46148"
outSAY(result);
result=".additem 46149"
outSAY(result);
result=".additem 46150"
outSAY(result);
result=".additem 46151"
outSAY(result);
result=".additem 46162"
outSAY(result);
result=".additem 46164"
outSAY(result);
result=".additem 46166"
outSAY(result);
result=".additem 46167"
outSAY(result);
result=".additem 46169"
outSAY(result);
end

function ShamanT6()
result=".additem 46200"
outSAY(result);
result=".additem 46203"
outSAY(result);
result=".additem 46205"
outSAY(result);
result=".additem 46208"
outSAY(result);
result=".additem 46212"
outSAY(result);
result=".additem 46206"
outSAY(result);
result=".additem 46207"
outSAY(result);
result=".additem 46209"
outSAY(result);
result=".additem 46210"
outSAY(result);
result=".additem 46211"
outSAY(result);
result=".additem 46198"
outSAY(result);
result=".additem 46199"
outSAY(result);
result=".additem 46201"
outSAY(result);
result=".additem 46202"
outSAY(result);
result=".additem 46204"
outSAY(result);
end

function PriestT6()
result=".additem 46163"
outSAY(result);
result=".additem 46165"
outSAY(result);
result=".additem 46168"
outSAY(result);
result=".additem 46170"
outSAY(result);
result=".additem 46172"
outSAY(result);
result=".additem 46188"
outSAY(result);
result=".additem 46190"
outSAY(result);
result=".additem 46193"
outSAY(result);
result=".additem 46195"
outSAY(result);
result=".additem 46197"
outSAY(result);
end

function DruidT6()
result=".additem 46157"
outSAY(result);
result=".additem 46158"
outSAY(result);
result=".additem 46159"
outSAY(result);
result=".additem 46160"
outSAY(result);
result=".additem 46161"
outSAY(result);
result=".additem 46189"
outSAY(result);
result=".additem 46191"
outSAY(result);
result=".additem 46192"
outSAY(result);
result=".additem 46194"
outSAY(result);
result=".additem 46196"
outSAY(result);
result=".additem 46183"
outSAY(result);
result=".additem 46184"
outSAY(result);
result=".additem 46185"
outSAY(result);
result=".additem 46186"
outSAY(result);
result=".additem 46187"
outSAY(result);
end

function PaladinT6()
result=".additem 46152"
outSAY(result);
result=".additem 46153"
outSAY(result);
result=".additem 46154"
outSAY(result);
result=".additem 46155"
outSAY(result);
result=".additem 46156"
outSAY(result);
result=".additem 46173"
outSAY(result);
result=".additem 46174"
outSAY(result);
result=".additem 46175"
outSAY(result);
result=".additem 46176"
outSAY(result);
result=".additem 46177"
outSAY(result);
result=".additem 46178"
outSAY(result);
result=".additem 46179"
outSAY(result);
result=".additem 46180"
outSAY(result);
result=".additem 46181"
outSAY(result);
result=".additem 46182"
outSAY(result);
end

function MageT7()
result=".additem 41945"
outSAY(result);
result=".additem 41951"
outSAY(result);
result=".additem 41958"
outSAY(result);
result=".additem 41964"
outSAY(result);
result=".additem 41970"
outSAY(result);
end

function HunterT7()
result=".additem 41086"
outSAY(result);
result=".additem 41142"
outSAY(result);
result=".additem 41156"
outSAY(result);
result=".additem 41204"
outSAY(result);
result=".additem 41216"
outSAY(result);
end

function RogueT7()
result=".additem 41649"
outSAY(result);
result=".additem 41654"
outSAY(result);
result=".additem 41671"
outSAY(result);
result=".additem 41682"
outSAY(result);
result=".additem 41766"
outSAY(result);
end

function WarlockT7()
result=".additem 41992"
outSAY(result);
result=".additem 41997"
outSAY(result);
result=".additem 42004"
outSAY(result);
result=".additem 42010"
outSAY(result);
result=".additem 42016"
outSAY(result);
end

function WarriorT7()
result=".additem 40786"
outSAY(result);
result=".additem 40804"
outSAY(result);
result=".additem 40823"
outSAY(result);
result=".additem 40844"
outSAY(result);
result=".additem 40862"
outSAY(result);
end

function ShamanT7()
result=".additem 41080"
outSAY(result);
result=".additem 41136"
outSAY(result);
result=".additem 41150"
outSAY(result);
result=".additem 41198"
outSAY(result);
result=".additem 41210"
outSAY(result);
result=".additem 40991"
outSAY(result);
result=".additem 41006"
outSAY(result);
result=".additem 41018"
outSAY(result);
result=".additem 41032"
outSAY(result);
result=".additem 41043"
outSAY(result);
result=".additem 40990"
outSAY(result);
result=".additem 41000"
outSAY(result);
result=".additem 41012"
outSAY(result);
result=".additem 41026"
outSAY(result);
result=".additem 41037"
outSAY(result);
end

function PriestT7()
result=".additem 41853"
outSAY(result);
result=".additem 41858"
outSAY(result);
result=".additem 41863"
outSAY(result);
result=".additem 41868"
outSAY(result);
result=".additem 41873"
outSAY(result);
result=".additem 41914"
outSAY(result);
result=".additem 41920"
outSAY(result);
result=".additem 41926"
outSAY(result);
result=".additem 41933"
outSAY(result);
result=".additem 41939"
outSAY(result);
end

function DruidT7()
result=".additem 41274"
outSAY(result);
result=".additem 41286"
outSAY(result);
result=".additem 41297"
outSAY(result);
result=".additem 41309"
outSAY(result);
result=".additem 41320"
outSAY(result);
result=".additem 41660"
outSAY(result);
result=".additem 41666"
outSAY(result);
result=".additem 41677"
outSAY(result);
result=".additem 41714"
outSAY(result);
result=".additem 41772"
outSAY(result);
result=".additem 41280"
outSAY(result);
result=".additem 41292"
outSAY(result);
result=".additem 41303"
outSAY(result);
result=".additem 41315"
outSAY(result);
result=".additem 41326"
outSAY(result);
end

function PaladinT7()
result=".additem 40905"
outSAY(result);
result=".additem 40926"
outSAY(result);
result=".additem 40932"
outSAY(result);
result=".additem 40938"
outSAY(result);
result=".additem 40962"
outSAY(result);
result=".additem 40785"
outSAY(result);
result=".additem 40805"
outSAY(result);
result=".additem 40825"
outSAY(result);
result=".additem 40846"
outSAY(result);
result=".additem 40864"
outSAY(result);
end

function DeathKnightT7()
result=".additem 40784"
outSAY(result);
result=".additem 40806"
outSAY(result);
result=".additem 40824"
outSAY(result);
result=".additem 40845"
outSAY(result);
result=".additem 40863"
outSAY(result);
end

function DeathKnightT6()
result=".additem 46111"
outSAY(result);
result=".additem 46113"
outSAY(result);
result=".additem 46115"
outSAY(result);
result=".additem 46116"
outSAY(result);
result=".additem 46117"
outSAY(result);
result=".additem 46118"
outSAY(result);
result=".additem 46119"
outSAY(result);
result=".additem 46120"
outSAY(result);
result=".additem 46121"
outSAY(result);
result=".additem 46122"
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ticket Form

function TicketListC()
result=".ticket list"
outSAY(result);
end

function OnlineTicketsC()
result=".ticket onlinelist"
outSAY(result);
end

function ViewTicketC()
result=".ticket viewid "..TicketNumber:GetText();
outSAY(result);
end

function GotoTicketC()
result=".go ticket "..TicketNumber:GetText();
outSAY(result);
end

function DeleteTicketC()
result=".ticket delete "..TicketNumber:GetText();
outSAY(result);
end

function CloseTicketC()
result=".ticket close "..TicketNumber:GetText();
outSAY(result);
end

function AssignC()
result=".ticket assign "..TicketNumber:GetText().." "..Assign:GetText();
outSAY(result);
end

function UnAssignC()
result=".ticket unassign "..TicketNumber:GetText();
outSAY(result);
end

function ViewNameC()
result=".ticket viewname "..Assign:GetText();
outSAY(result);
end

function ClosedList()
result=".ticket closedlist "
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Misc Addons

function RestartC()
result=".server restart "..AdminEditBox:GetText();
outSAY(result);
end

function ShutDownC()
result=".server shutdown "..AdminEditBox:GetText();
outSAY(result);
end

function CancelSRC()
result=".server shutdown cancel "
outSAY(result);
result=".server restart cancel "
outSAY(result);
end

function SaveAllC()
result=".saveall "
outSAY(result);
end

function PlayAllC()
result=".playall "..AdminEditBox:GetText();
outSAY(result);
end

function ReloadAllC()
result=".reload all ";
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Objects Form

function ObjectTurnC()
result=".gobject turn "..ObjectNumber:GetText();
outSAY(result);
end

function AddObjectC()
result=".gobject add "..ObjectNumber:GetText();
outSAY(result);
end

function TargetObjectC()
result=".gobject target "..ObjectNumber:GetText();
outSAY(result);
end

function ActivateObjectC()
result=".gobject activate "..ObjectNumber:GetText();
outSAY(result);
end

function TempAddC()
result=".gobject tempadd "..ObjectNumber:GetText();
outSAY(result);
end

function DeleteObjectC()
result=".gobject delete "..ObjectNumber:GetText();    
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Players Form

function RevivePlayerC()
result=".revive "..PlayerFormBox:GetText();
outSAY(result);
end

function DeMorphC()
result=".demorph "
outSAY(result);
end

function HonorAddC()
result=".honor add "..PlayerFormBox:GetText();
outSAY(result);
end

function PlayerInfoCC()
result=".pinfo "..PlayerFormBox:GetText();
outSAY(result);
end

function RepairCC()
result=".repairitems "
outSAY(result);
end

function KillPlayerC()
result=".die "
outSAY(result);
end

function GuildUninviteC()
result=".guild uninvite "..PlayerFormBox:GetText();
outSAY(result);
end

function CustomizeC()
result=".character customize "..PlayerFormBox:GetText();
outSAY(result);
end

function ReNameC()
result=".character rename "..PlayerFormBox:GetText();
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Spells Form

function LearnAllLangC()
result=".learn all_lang "
outSAY(result);
end

function LearnAllDefC()
result=".learn all_default "
outSAY(result);
end

function LearnAllCraftC()
result=".learn all_crafts "
outSAY(result);
end

function LearnAllClassC()
result=".learn all_myclass "
outSAY(result);
end

function LearnAllRecipesC()
result=".learn all_recipes "..SpellNumber:GetText();
outSAY(result);
end

function LearnAllTalentsC()
result=".learn all_mytalents "
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Teleport Form

function SummonGroupC()
result=".groupgo "..ToPlayerName:GetText();
outSAY(result);
end

function TeleGroupC()
result=".tele group "..ZoneName:GetText();
outSAY(result);
end

function PortPlayerC()
result=".tele name "..ToPlayerName:GetText().." "..ZoneName:GetText();
outSAY(result);
end

function AddTeleC()
result=".tele add "..ZoneName:GetText();
outSAY(result);
end

function DelTeleC()
result=".tele del "..ZoneName:GetText();
outSAY(result);
end

function TeleLookupC()
result=".lookup tele "..ZoneName:GetText();
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Modify Form

function ModHonorC()
result=".modify honor "..ModifyEditBox:GetText();
outSAY(result);
end

function ModGenderC()
result=".modify gender "..ModifyEditBox:GetText();
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Communication Form

function GMBadgeOnC()
result=".gm chat on"
outSAY(result);
end

function GMBadgeOffC()
result=".gm chat off"
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Ban Form

function ListFreezeC()
result=".listfreeze ";
outSAY(result);
end

function BannAcctC()
result=".ban account "..AcctName:GetText().." "..BanLength:GetText().." "..BanReason:GetText();
outSAY(result);
end

function UnBanAccount()
result=".unban account "..AcctName:GetText();
outSAY(result);
end

function BannAllC()
result=".ban account "..AcctName:GetText().." "..BanLength:GetText().." "..BanReason:GetText();
outSAY(result);
result=".ban character "..CharName:GetText().." "..BanLength:GetText().." "..BanReason:GetText();
outSAY(result);
result=".ban ip "..IPAddress1:GetText().." "..BanLength:GetText().." "..BanReason:GetText();
outSAY(result);
end

function BannIPC()
result=".ban ip "..IPAddress1:GetText().." "..BanLength:GetText().." "..BanReason:GetText();
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Item Form

function SearchItemSetC()
result=".lookup itemset "..ItemSetNumber:GetText();
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Over-ride Form

function CooldownCC()
result=".cooldown "
outSAY(result);
end

function RainCC()
result=".wchange 1 1";
outSAY(result);
end

function SnowCC()
result=".wchange 2 2";
outSAY(result);
end

function SandCC()
result=".wchange 3 3";
outSAY(result);
end

function StopCC()
result=".wchange 0 0";
outSAY(result);
end

function Visible()
result=".gm visible on";
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Mail Form

function MailMessageToC()
result=".send mail "..ToPlayerNameC:GetText().." "..SubjectName:GetText().." "..MessageBoxMulti:GetText();
outSAY(result);
end

function MailItemsToC()
result=".send items "..ToPlayerNameC:GetText().." "..SubjectName:GetText().." "..MessageBoxMulti:GetText().." "..Item1:GetText().." "..Item2:GetText().." "..Item3:GetText().." "..Item4:GetText().." "..Item5:GetText();
outSAY(result);
end

function MailMoneyToC()
-- IntGold = GoldC:GetNumber();
-- IntSilver = SilverC:GetNumber();
-- IntCopper = CopperC:GetNumber();
result=".send money "..ToPlayerNameC:GetText().." "..SubjectName:GetText().." "..MessageBoxMulti:GetText().." "..GoldC:GetNumber()*10000+SilverC:GetNumber()*100+CopperC:GetNumber();
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Pet Form

function PetCreateC()
result=".pet create ";
outSAY(result);
end

function PetLearnC()
result=".pet learn "..PetBoxC:GetText();
outSAY(result);
end

function PetUnLearnC()
result=".pet unlearn "..PetBoxC:GetText();
outSAY(result);
end

function PetTalentsC()
result=".pet tp "..PetBoxC:GetText();
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Skill Form

function SearchSkill()
result=".lookup skill "..SkillName:GetText();
outSAY(result);
end

function LearnSkill()
result=".setskill "..SkillNumber:GetText().." "..SkillLvl:GetText().." "..SkillMax:GetText();        
outSAY(result);
end

function UnLearnSkill()
result=".character removesk "..SkillNumber:GetText();    
outSAY(result);
end

function LookupSkill()
result=".lookup skill "..SkillNumber:GetText();    
outSAY(result);
end

function AdvanceAll()
result=".maxskill";   
outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Spell Form

function LearnSpell()
result=".learn "..SpellNumber:GetText();    
outSAY(result);
end

function UnlearnSpell()
result=".unlearn "..SpellNumber:GetText();    
outSAY(result);
end

function LearnAll()
result=".learn all";
outSAY(result);
end

function LookupSpell()
result=".lookup spell "..SpellNumber:GetText();    
outSAY(result);
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TeleScript

function GoName()
result=".goname "..ToPlayerName:GetText();    
outSAY(result);
end

function NameGo()
result=".namego "..ToPlayerName:GetText();    
outSAY(result);
end

function SearchTele()
result=".recall list "   
outSAY(result);
end

function Tele()
result=".tele "..ZoneName:GetText(); 
outSAY(result);
end

function AddPort()
result=".tele add "..ZoneName:GetText(); 
outSAY(result);
end

function DelPort()
result=".tele del "..ZoneName:GetText(); 
outSAY(result);
end

function PortPlayer()
result=".tele name "..ToPlayerName:GetText().." " ..ZoneName:GetText(); 
outSAY(result);
end

function WorldPort()
result=".go xyz "..XCord:GetText().." "..YCord:GetText().." "..ZCord:GetText().." "..MapID:GetText();
outSAY(result);
end


function GPS()
result=".gps";
outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WaypointScript
function WaypointsAdd()
    result=".wp add";
    outSAY(result);
end

function WaypointsDel()
    result=".waypoint delete";
    outSAY(result);
end

function WaypointsShow()
    result=".wp show";
    outSAY(result);
end

function WaypointsHide()
    result=".waypoint hide";
    outSAY(result);
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WepskScript

function LearnDualWield()
result=".setskill 118 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnStaves()
result=".setskill 136 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnUnarmed()
result=".setskill 136 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnTwoHandedAxes()
result=".setskill 172 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnDaggers()
result=".setskill 173 "..WeaponSkillLvl:GetText();    
outSAY(result);
end


function LearnCrossbows()
result=".setskill 226 "..WeaponSkillLvl:GetText();    
outSAY(result);
end


function LearnWands()
result=".setskill 228 "..WeaponSkillLvl:GetText();    
outSAY(result);
end


function LearnPolearms()
result=".setskill 229 "..WeaponSkillLvl:GetText();    
outSAY(result);
end


function LearnGuns()
result=".setskill 46 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnSwords()
result=".setskill 43 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnTwoHandedSwords()
result=".setskill 55 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnFistWeapons()
result=".setskill 473 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnTwoHandedMaces()
result=".setskill 160 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnBows()
result=".setskill 45 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnThrown()
result=".setskill 176 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnAxes()
result=".setskill 44 "..WeaponSkillLvl:GetText();    
outSAY(result);
end

function LearnMaces()
result=".setskill 54 "..WeaponSkillLvl:GetText();    
outSAY(result);
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function GMH_Main()
DEFAULT_CHAT_FRAME:AddMessage("--Trinity GM Helper |c00FFFFFFby Kibblebit|r--",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/gm            - Displays Current Menu",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/reload        - Reloads User Interface",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/revive        - Revive Yourself When Dead",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/recallport    - Teleports To Specified Location",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/npcspawn      - Spawns Specified Creature",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/npcdelete     - Deletes Targeted Creature",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/additem       - Adds Specified Item To Yourself/Targeted Player",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/announce      - Broadcasts Server-Wide Message",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/nameann       - Broadcasts Server-Wide Message w/ Your Name",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/gmannounce    - Broadcasts Message to GM's only.",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/savedannounce - Broadcasts Saved Announces",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/advanceall    - Advances All Skills By A Specified Amount",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/reviveplr     - Revives Specified Player",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/learn         - Learn Specified Spell",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/unlearn       - Unlearn Specified Spell",0.0, 1.0, 0.0, 53, 0);
DEFAULT_CHAT_FRAME:AddMessage("/table         - Reloads Specified Table In Database",0.0, 1.0, 0.0, 53, 0);
end
SlashCmdList["GMH"] = GMH_Main;
SLASH_GMH1="/gmh";
SLASH_GMH2="/gmhh";

function GMH_Horde()
SendWho('r-orc r-undead r-tauren r-troll r-blood');
end
SlashCmdList["HORDE"] = GMH_Horde;
SLASH_HORDE1="/horde";

function GMH_Alli()
SendWho('r-human r-dwaft r-gnome r-night r-draenei');
end
SlashCmdList["ALLI"] = GMH_Alli;
SLASH_ALLI1="/alli";

function GMH_Dk()
SendWho('c-death 55-60');
end
SlashCmdList["DK"] = GMH_Dk;
SLASH_DK1="/dk";

function GMH_QQ()
QUIT()
end
SlashCmdList["QQ"] = GMH_QQ;
SLASH_QQ1="/q";

function GMH_Who(msg)
local GMWho=msg;
result=".gm i"; 
outSAY(result);
end
SlashCmdList["GMWHO"] = GMH_Who;
SLASH_GMWHO1="/gm";
SLASH_GMWHO2="/gmi";

function GMH_TicketComment(msg)
local GMTicket=msg;
result=".ticket comment "..GMTicket; 
outSAY(result);
end
SlashCmdList["GMHCOMMENT"] = GMH_GMTicketComment;
SLASH_GMHCOMMENT1="/comment";
SLASH_GMHCOMMENT2="/tcomment";

function GMH_Reload()
ReloadUI()
end
SlashCmdList["GMHRELOAD"] = GMH_Reload;
SLASH_GMHRELOAD1="/reload";

function GMH_Revive()
result=".revive"   
outSAY(result);
end
SlashCmdList["REVIVE"] = GMH_Revive;
SLASH_REVIVE1="/revive";

function GMH_NPCSpawn(msg)
local NPCID=msg;
result=".npc add "..NPCID; 
outSAY(result);
end
SlashCmdList["GMHSPAWN"] = GMH_NPCSpawn;
SLASH_GMHSPAWN1="/npcspawn";

function GMH_NPCDelete()
result=".npc delete" 
outSAY(result);
end
SlashCmdList["GMHDELETE"] = GMH_NPCDelete;
SLASH_GMHDELETE1="/npcdelete";

function GMH_AddItem(msg)
local ItemID=msg;
result=".additem "..ItemID; 
outSAY(result);
end
SlashCmdList["GMHADDITEM"] = GMH_AddItem;
SLASH_GMHADDITEM1="/additem";

function GMH_Announce(msg)
local Announce=msg;
result=".announce "..Announce;
outSAY(result);
end
SlashCmdList["GMHANNOUNCE"] = GMH_Announce;
SLASH_GMHANNOUNCE1="/announce";
SLASH_GMHANNOUNCE2="/an";

--function GMH_WAnnounce(msg)
--local WAnnounce=msg;
--result=".mute "..WAnnounce; 
--outSAY(result);
--end
--SlashCmdList["GMHWANNOUNCE"] = GMH_WAnnounce;
--SLASH_GMHWANNOUNCE1="/pmute";
--SLASH_GMHWANNOUNCE2="/testmute";


function GMH_GMAnnounce(msg)
local GMAnnounce=msg;
result=".gmnameannounce "..GMAnnounce; 
outSAY(result);
end
SlashCmdList["GMHGMANNOUNCE"] = GMH_GMAnnounce;
SLASH_GMHGMANNOUNCE1="/gmannounce";
SLASH_GMHGMANNOUNCE2="/gman";

function GMH_RecallPort(msg)
local location=msg;
result=".tele "..location; 
outSAY(result);
end
SlashCmdList["GMHRECALLPORT"] = GMH_RecallPort;
SLASH_GMHRECALLPORT1="/recallport";
SLASH_GMHRECALLPORT2="/recall";
SLASH_GMHRECALLPORT3="/port";

function GMH_SavedAnnounce(msg)
local SavedAnnounce=msg;
if (SavedAnnounce == "1") and (firstannounce ~= nil) then
result=firstannounce;
outSAY(result);
elseif (SavedAnnounce == "2") and (secondannounce ~= nil) then
result=secondannounce;
outSAY(result);
elseif (SavedAnnounce == "3") and (thirdannounce ~= nil) then
result=thirdannounce;
outSAY(result);
elseif (SavedAnnounce == "4") and (fourthannounce ~= nil) then
result=fourthannounce;
outSAY(result);
elseif (SavedAnnounce == "5") and (fifthannounce ~= nil) then
result=fifthannounce;
outSAY(result);
else
UIErrorsFrame:AddMessage("That saved announcement has not been set! Please set it!", 1.0, 0.0, 0.0, 53, 2);
end
end
SlashCmdList["GMHSAVEDANNOUNCE"] = GMH_SavedAnnounce;
SLASH_GMHSAVEDANNOUNCE1="/savedannounce";
SLASH_GMHSAVEDANNOUNCE2="/sa";

function GMH_Learn(msg)
local Learn=msg;
result=".learn "..Learn; 
outSAY(result);
end
SlashCmdList["GMHLEARN"] = GMH_Learn;
SLASH_GMHLEARN1="/learn";

function GMH_UnLearn(msg)
local UnLearn=msg;
result=".unlearn "..UnLearn; 
outSAY(result);
end
SlashCmdList["GMHUNLEARN"] = GMH_UnLearn;
SLASH_GMHUNLEARN1="/unlearn";

function GMH_RevivePlr(msg)
local PlayerName=msg;
result=".reviveplr "..PlayerName; 
outSAY(result);
end
SlashCmdList["GMHREVIVEPLR"] = GMH_RevivePlr;
SLASH_GMHREVIVEPLR1="/reviveplr";

function GMH_AdvanceAllSkills(msg)
local Skillnumber=msg;
result=".maxskill"; 
outSAY(result);
end
SlashCmdList["GMHADVANCEALL"] = GMH_AdvanceAllSkills;
SLASH_GMHADVANCEALL1="/advanceall";
SLASH_GMHADVANCEALL2="/advanceallskills";

function TSR_Sounds(msg)
local Sound=msg
local line='/script PlaySound("'..Sound..'")';
ChatFrameEditBox:SetText("");
ChatFrameEditBox:Insert(line);
ChatEdit_SendText(ChatFrameEditBox);
end
SlashCmdList["TSRSOUND"] = TSR_Sounds;
SLASH_TSRSOUND1="/ps";

function TSR_TableReload(msg)
local Table=msg
result=".reload "..Table;
outSAY(result);
end
SlashCmdList["TSRTR"] = TSR_TableReload;
SLASH_TSRTR1="/tr";
SLASH_TSRTR2="/table";

function GMH_Realm()
result=".unaura 52693"; 
result2=".unaura 52275";
outSAY(result);
outSAY(result2);
end
SlashCmdList["GMHREALM"] = GMH_Realm;
SLASH_GMHREALM1="/realm";
SLASH_GMHREALM2="/realmset";

function GMH_Dkfactionhorde()
result=".quest add 13189 Horde"; 
outSAY(result);
end
SlashCmdList["GMHDKFACTIONHORDE"] = GMH_Dkfactionhorde;
SLASH_GMHDKFACTIONHORDE1="/dkfactionhorde";

function GMH_Dkfactionalli()
result=".quest add 13189 Alliance"; 
outSAY(result);
end
SlashCmdList["GMHDKFACTIONALLI"] = GMH_Dkfactionalli;
SLASH_GMHDKFACTIONALLI1="/dkfactionalli";

function GMH_Evade()
result=".die"; 
result2=".respawn"
outSAY(result);
outSAY(result2);
end
SlashCmdList["GMHEVADE"] = GMH_Evade;
SLASH_GMHEVADE1="/evade";

function GMH_Info()
local PlayerName=msg;
result=".pinfo "..PlayerName;
outSAY(result);
end
SlashCmdList["GMHINFO"] = GMH_Info;
SLASH_GMHINFO1="/info";

function GMH_LookupAccount(msg)
local GMAccount=msg;
result=".lookup player account "..GMAccount; 
outSAY(result);
end
SlashCmdList["GMHLOOKAC"] = GMH_LookupAccount;
SLASH_GMHLOOKAC1="/acclook";

function GMH_Kill()
result=".damage 1000000"
result1=".damage 1000000"
result2=".damage 1000000"
outSAY(result);
outSAY(result1);
outSAY(result2);
end
SlashCmdList["GMHKILL"] = GMH_Kill;
SLASH_GMHKILL1="/kill";

function GMH_Frost()
result=".additem 49426 -2"
outSAY(result);
end
SlashCmdList["GMHFROST"] = GMH_Frost;
SLASH_GMHFROST1="/frost";

function GMH_Toggles1(msg)
    if( msg == 'on' ) then
        FullForm:Show();
    elseif( msg == 'off' ) then
        MinipForm:Show();
    else
        FullForm:Show();
    end
end
SlashCmdList["GMHTOGGLESA"] = GMH_Toggles1;
SLASH_GMHTOGGLESA1="/admin";

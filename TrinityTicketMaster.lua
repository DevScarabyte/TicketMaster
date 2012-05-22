-------------------------------------------------------------------------------------------------------------
--
-- TrinityTicketMaster Version 3.x, a derivitive of TrinityAdmin
-- TrinityAdmin is a derivative of MangAdmin.
--
-- Copyright (C) 2007 Free Software Foundation, Inc.
-- License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
-- This is free software: you are free to change and redistribute it.
-- There is NO WARRANTY, to the extent permitted by law.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
-- GoogleCode Website: http://code.google.com/p/trinityticketmaster/
-- Subversion Repository: http://trinityticketmaster.googlecode.com/svn/
-------------------------------------------------------------------------------------------------------------

local genv = getfenv(0)
local Mang = genv.Mang

MAJOR_VERSION = "TrinityTicketMaster-3.3.2-Truewow-Edition"
MINOR_VERSION = "$Revision: 045 $"
ROOT_PATH     = "Interface\\AddOns\\TrinityTicketMaster\\"
local cont = ""
if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

MangAdmin    = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceHook-2.1", "FuBarPlugin-2.0", "AceDebug-2.0", "AceEvent-2.0")
Locale       = AceLibrary("AceLocale-2.2"):new("MangAdmin")
Strings      = AceLibrary("AceLocale-2.2"):new("TEST")
FrameLib     = AceLibrary("FrameLib-1.0")
Graph        = AceLibrary("Graph-1.0")
local Tablet = AceLibrary("Tablet-2.0")

MangAdmin:RegisterDB("MangAdminDb", "MangAdminDbPerChar")
MangAdmin:RegisterDefaults("char", 
  {
    functionQueue = {},
    requests = {
      tpinfo = false,
      ticket = false,
      ticketbody = 0,
      item = false,
      favitem = false,
      itemset = false,
      spell = false,
      skill = false,
      quest = false,
      creature = false,
      object = false,
      tele = false,
      toggle = false
    },
    nextGridWay = "ahead",
    selectedZone = nil,
    newTicketQueue = {},
    instantKillMode = false,
    msgDeltaTime = time(),
    
  }
)
MangAdmin:RegisterDefaults("account", 
  {
    language = nil,
    localesearchstring = true,
    favorites = {
      items = {},
      itemsets = {},
      spells = {},
      skills = {},
      quests = {},
      creatures = {},
      objects = {},
      teles = {}
    },
    buffer = {
      tickets = {},
      items = {},
      itemsets = {},
      spells = {},
      skills = {},
      quests = {},
      creatures = {},
      objects = {},
      teles = {},
      counter = 0
    },
    tickets = {
      selected = 0,
      count = 0,
      requested = 0,
      playerinfo = {},
      loading = false
    },
    style = {
      updatedelay = "4000",
      showtooltips = true,
      showchat = false,
      showminimenu = true,
      transparency = {
        buttons = 1.0,
        frames = 0.7,
        backgrounds = 0.5
      },
      color = {
        buffer = {},
        buttons = {
          r = 33, 
          g = 164, 
          b = 210
        },
        frames = {
          r = 102,
          g = 102,
          b = 102
        },
        backgrounds = {
          r = 0,
          g = 0,
          b = 0
        },
        linkifier = {
          r = 0.8705882352941177,
          g = 0.3725490196078432,
          b = 0.1411764705882353
        }
      }
    }
  }
)

-- Register Translations
Locale:EnableDynamicLocales(true)
--Locale:EnableDebugging()
Locale:RegisterTranslations("enUS", function() return Return_enUS() end)
Locale:RegisterTranslations("frFR", function() return Return_frFR() end)
Locale:RegisterTranslations("svSV", function() return Return_svSV() end)
Locale:RegisterTranslations("deDE", function() return Return_deDE() end)
Locale:RegisterTranslations("itIT", function() return Return_itIT() end)
-- Register String Traslations
Strings:EnableDynamicLocales(true)
Strings:RegisterTranslations("enUS", function() return ReturnStrings_enUS() end)
Strings:RegisterTranslations("frFR", function() return ReturnStrings_frFR() end)
Strings:RegisterTranslations("svSV", function() return ReturnStrings_svSV() end)
Strings:RegisterTranslations("deDE", function() return ReturnStrings_deDE() end)
Strings:RegisterTranslations("itIT", function() return ReturnStrings_itIT() end)

MangAdmin.consoleOpts = {
  type = 'group',
  args = {
    toggle = {
      name = "toggle",
      desc = Locale["cmd_toggle"],
      type = 'execute',
      func = function() MangAdmin:OnClick() end
    },
    transparency = {
      name = "transparency",
      desc = Locale["cmd_transparency"],
      type = 'execute',
      func = function() MangAdmin:ToggleTransparency() end
    },
    tooltips = {
      name = "tooltips",
      desc = Locale["cmd_tooltip"],
      type = 'execute',
      func = function() MangAdmin:ToggleTooltips() end
    },
    minimenu = {
      name = "tooltips",
      desc = "Toogle the toolbar/minimenu",
      type = 'execute',
      func = function() MangAdmin:ToggleMinimenu() end
    }
  }
}

function MangAdmin:OnInitialize()
  -- initializing MangAdmin
  self:SetLanguage()
  self:CreateFrames()
  self:RegisterChatCommand(Locale["slashcmds"], self.consoleOpts) -- this registers the chat commands
  self:InitButtons()  -- this prepares the actions and tooltips of nearly all MangAdmin buttons  
  InitControls()
  self:SearchReset()
  -- FuBar plugin config
  MangAdmin.hasNoColor = true
  MangAdmin.hasNoText = false
  MangAdmin.clickableTooltip = true
  MangAdmin.hasIcon = true
  MangAdmin.hideWithoutStandby = true
  MangAdmin:SetIcon(ROOT_PATH.."Textures\\icon.tga")
  -- make MangAdmin frames closable with escape key
  tinsert(UISpecialFrames,"ma_bgframe")
  tinsert(UISpecialFrames,"ma_popupframe")
  -- those all hook the AddMessage method of the chat frames.
  -- They will be redirected to MangAdmin:AddMessage(...)
  for i=1,NUM_CHAT_WINDOWS do
    local cf = getglobal("ChatFrame"..i)
    self:Hook(cf, "AddMessage", true)
  end
  -- initializing Frames, like DropDowns, Sliders, aso
  self:InitDropDowns()
  self:InitSliders()
  self:InitScrollFrames()
  self:InitCheckButtons()
  MangAdmin.db.account.buffer.who = {}
  --clear color buffer
  self.db.account.style.color.buffer = {}
  --altering the function setitemref, to make it possible to click links
  MangLinkifier_SetItemRef_Original = SetItemRef
  SetItemRef = MangLinkifier_SetItemRef
  self.db.char.msgDeltaTime = time()
  -- hide minimenu if not enabled
  if not self.db.account.style.showminimenu then
    FrameLib:HandleGroup("minimenu", function(frame) frame:Hide() end)
  end
 
end

function MangAdmin:OnEnable()
  self:SetDebugging(true) -- to have debugging through the whole app
  ma_toptext:SetText(Locale["char"].." "..Locale["guid"]..tonumber(UnitGUID("player"),16))
  ma_top2text:SetText(Locale["realm"])
  self:SearchReset()
  -- refresh server information
  self:ChatMsg(".server info")
  -- register events
  self:RegisterEvent("PLAYER_DEAD")
  self:RegisterEvent("PLAYER_ALIVE")
  
end

--events
function MangAdmin:PLAYER_DEAD()
  ma_mm_revivebutton:Hide()
end

function MangAdmin:PLAYER_ALIVE()
  ma_mm_revivebutton:Hide()
end



function MangAdmin:OnDisable()
  -- called when the addon is disabled
  self:SearchReset()
end

function MangAdmin:OnClick()
  -- this toggles the MangAdmin frame when clicking on the mini icon
  if IsShiftKeyDown() then
    ReloadUI()
  elseif IsAltKeyDown() then
    self.db.char.newTicketQueue = 0
    MangAdmin:UpdateTooltip()
  elseif ma_bgframe:IsVisible() and not ma_popupframe:IsVisible() then
    FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
  elseif ma_bgframe:IsVisible() and ma_popupframe:IsVisible() then
    FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
    FrameLib:HandleGroup("popup", function(frame) frame:Hide() end)
  elseif not ma_bgframe:IsVisible() and ma_popupframe:IsVisible() then
    FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
  else
    FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
  end
end

function MangAdmin:OnTooltipUpdate()
  local tickets = self.db.char.newTicketQueue
  local ticketCount = 0
  table.foreachi(tickets, function() ticketCount = ticketCount + 1 end)
  if ticketCount == 0 then
    local cat = Tablet:AddCategory("columns", 1)
    cat:AddLine("text", Locale["ma_TicketsNoNew"])
    MangAdmin:SetIcon(ROOT_PATH.."Textures\\icon.tga")
  else
    local cat = Tablet:AddCategory(
      "columns", 1,
      "justify", "LEFT",
      "hideBlankLine", true,
      "showWithoutChildren", false,
      "child_textR", 1,
      "child_textG", 1,
      "child_textB", 1
    )
    cat:AddLine(
      "text", string.format(Locale["ma_TicketsNewNumber"], ticketCount),
      "func", function() MangAdmin:ShowTicketTab() end)
    local counter = 0
    local name
    for i, name in pairs(tickets) do
      counter = counter + 1
      if counter == ticketCount then
        cat:AddLine(
          "text", string.format(Locale["ma_TicketsGoLast"], name),
          "func", function(name) MangAdmin:TelePlayer("gochar", name) end,
          "arg1", name
        )
        cat:AddLine(
          "text", string.format(Locale["ma_TicketsGetLast"], name),
          "func", function(name) MangAdmin:TelePlayer("getchar", name) end,
          "arg1", name
        )
      end
    end
    MangAdmin:SetIcon(ROOT_PATH.."Textures\\icon2.tga")
  end
  Tablet:SetHint(Locale["ma_IconHint"])
end

function MangAdmin:ToggleTabButton(group)
  --this modifies the look of tab buttons when clicked on them 
  FrameLib:HandleGroup("tabbuttons", 
  function(button) 
    if button:GetName() == "ma_tabbutton_"..group then
      getglobal(button:GetName().."_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
    else
      getglobal(button:GetName().."_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
    end
  end)
end

function MangAdmin:ToggleContentGroup(group)
  self:HideAllGroups()
  FrameLib:HandleGroup(group, function(frame) frame:Show() end)
end

function MangAdmin:InstantGroupToggle(group)
  if group == "ticket" then
    self.db.char.requests.ticket = false
  end
  FrameLib:HandleGroup("bg", function(frame) frame:Show() end)
  MangAdmin:ToggleTabButton(group)
  MangAdmin:ToggleContentGroup(group)
end

function MangAdmin:TogglePopup(value, param)
  -- this toggles the MangAdmin Search Popup frame, toggling deactivated, popup will be overwritten
  if value == "search" then
    FrameLib:HandleGroup("popup", function(frame) frame:Show() end)
    getglobal("ma_ptabbutton_1_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
    getglobal("ma_ptabbutton_2_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
    ma_mailscrollframe:Hide()
    ma_maileditbox:Hide()
    ma_var1editbox:Hide()
    ma_var2editbox:Hide()
    ma_var1text:Hide()
    ma_var2text:Hide()
    ma_searchbutton:SetScript("OnClick", function() self:SearchStart(param.type, ma_searcheditbox:GetText()) end)
    ma_searchbutton:SetText(Locale["ma_SearchButton"])
    ma_resetsearchbutton:SetScript("OnClick", function() MangAdmin:SearchReset() end)
    ma_resetsearchbutton:SetText(Locale["ma_ResetButton"])
    ma_resetsearchbutton:Enable()
    ma_ptabbutton_1:SetScript("OnClick", function() MangAdmin:TogglePopup("search", {type = param.type}) end)
    ma_ptabbutton_2:SetScript("OnClick", function() MangAdmin:TogglePopup("favorites", {type = param.type}) end)
    ma_ptabbutton_2:Show()
    ma_selectallbutton:SetScript("OnClick", function() self:Favorites("select", param.type) end)
    ma_deselectallbutton:SetScript("OnClick", function() self:Favorites("deselect", param.type) end)
    ma_modfavsbutton:SetScript("OnClick", function() self:Favorites("add", param.type) end)
    ma_modfavsbutton:SetText(Locale["ma_FavAdd"])
    ma_modfavsbutton:Enable()
    self:SearchReset()
    self.db.char.requests.toggle = true
    if param.type == "item" then
      ma_ptabbutton_1:SetText(Locale["ma_ItemButton"])
      ma_var1editbox:Show()
      ma_var1text:Show()
      ma_var1text:SetText(Locale["ma_ItemVar1Button"])
    elseif param.type == "itemset" then
      ma_ptabbutton_1:SetText(Locale["ma_ItemSetButton"])
    elseif param.type == "spell" then
      ma_ptabbutton_1:SetText(Locale["ma_SpellButton"])
    elseif param.type == "skill" then
      ma_ptabbutton_1:SetText(Locale["ma_SkillButton"])
      ma_var1editbox:Show()
      ma_var2editbox:Show()
      ma_var1text:Show()
      ma_var2text:Show()
      ma_var1text:SetText(Locale["ma_SkillVar1Button"])
      ma_var2text:SetText(Locale["ma_SkillVar2Button"])
    elseif param.type == "quest" then
      ma_ptabbutton_1:SetText(Locale["ma_QuestButton"])
    elseif param.type == "creature" then
      ma_ptabbutton_1:SetText(Locale["ma_CreatureButton"])
    elseif param.type == "object" then
      ma_ptabbutton_1:SetText(Locale["ma_ObjectButton"])
      ma_var1editbox:Show()
      ma_var2editbox:Show()
      ma_var1text:Show()
      ma_var2text:Show()
      ma_var1text:SetText(Locale["ma_ObjectVar1Button"])
      ma_var2text:SetText(Locale["ma_ObjectVar2Button"])
    elseif param.type == "tele" then
      ma_ptabbutton_1:SetText(Locale["ma_TeleSearchButton"])
    elseif param.type == "ticket" then
    end
  elseif value == "favorites" then
    self:SearchReset()
    getglobal("ma_ptabbutton_2_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
    getglobal("ma_ptabbutton_1_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
    ma_modfavsbutton:SetScript("OnClick", function() self:Favorites("remove", param.type) end)
    ma_modfavsbutton:SetText(Locale["ma_FavRemove"])
    ma_modfavsbutton:Enable()
    self:Favorites("show", param.type)
  elseif value == "mail" then
    getglobal("ma_ptabbutton_1_texture"):SetGradientAlpha("vertical", 102, 102, 102, 1, 102, 102, 102, 0.7)
    getglobal("ma_ptabbutton_2_texture"):SetGradientAlpha("vertical", 102, 102, 102, 0, 102, 102, 102, 0.7)
    FrameLib:HandleGroup("popup", function(frame) frame:Show() end)
    for n = 1,7 do
      getglobal("ma_PopupScrollBarEntry"..n):Hide()
    end
    ma_lookupresulttext:SetText(Locale["ma_MailBytesLeft"].."246")
    ma_lookupresulttext:Show()
    ma_resetsearchbutton:Hide()
    ma_PopupScrollBar:Hide()
    ma_searcheditbox:SetScript("OnTextChanged", function() MangAdmin:UpdateMailBytesLeft() end)
    ma_var1editbox:SetScript("OnTextChanged", function() MangAdmin:UpdateMailBytesLeft() end)
    ma_modfavsbutton:Hide()
    ma_selectallbutton:Hide()
    ma_deselectallbutton:Hide()
    if param.recipient then
      ma_searcheditbox:SetText(param.recipient)
    else
      ma_searcheditbox:SetText(Locale["ma_MailRecipient"])
    end
    if param.body then
      ma_maileditbox:SetText(param.body)
    else
      ma_maileditbox:SetText(Locale["ma_MailRecipient"])
    end
    ma_ptabbutton_1:SetText(Locale["ma_Mail"])
    ma_ptabbutton_2:Hide()
    ma_searchbutton:SetText(Locale["ma_Send"])
    ma_searchbutton:SetScript("OnClick", function() self:SendMail(ma_searcheditbox:GetText(), ma_var1editbox:GetText(), ma_maileditbox:GetText()); ma_popupframe:Hide() end)
    ma_var2editbox:Hide()
    ma_var2text:Hide()
    if param.subject then
      ma_var1editbox:SetText(param.subject)
    else
      ma_var1editbox:SetText(Locale["ma_MailSubject"])
    end
    ma_var1editbox:Show()
    ma_var1text:SetText(Locale["ma_MailSubject"])
    ma_var1text:Show()
    ma_maileditbox:SetText(Locale["ma_MailYourMsg"])
  end
end

function MangAdmin:HideAllGroups()
  FrameLib:HandleGroup("ticket", function(frame) frame:Hide() end)
  FrameLib:HandleGroup("misc", function(frame) frame:Hide() end)
end

function MangAdmin:AddMessage(frame, text, r, g, b, id)
  -- frame is the object that was hooked (one of the ChatFrames)  
  local catchedSth = false
  local output = MangAdmin.db.account.style.showchat
  if id == 1 then --make sure that the message comes from the server, message id = 1
    --Catches if Toggle is still on for some reason, but search frame is not up, and disables it so messages arent caught
    if self.db.char.requests.toggle and not ma_popupframe:IsVisible() then
      self.db.char.requests.toggle = false
    end
    -- hook .gps for gridnavigation
    for x, y in string.gmatch(text, Strings["ma_GmatchGPS"]) do
      for k,v in pairs(self.db.char.functionQueue) do
        if v == "GridNavigate" then
          GridNavigate(string.format("%.1f", x), string.format("%.1f", y), nil)
          table.remove(self.db.char.functionQueue, k)
          break
        end
      end
    end


    
    if self.db.char.requests.toggle then
      if self.db.char.requests.item then
        -- hook all item lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchItem"]) do
            table.insert(self.db.account.buffer.items, {itId = id, itName = name, checked = false})
            -- for item info in cache
            local itemName, itemLink, itemQuality, _, _, _, _, _, _ = GetItemInfo(id);
            if not itemName then
              GameTooltip:SetOwner(ma_popupframe, "ANCHOR_RIGHT")
              GameTooltip:SetHyperlink("item:"..id..":0:0:0:0:0:0:0")
              GameTooltip:Hide()
            end
            PopupScrollUpdate()
            catchedSth = true
            output = MangAdmin.db.account.style.showchat  
        end
      elseif self.db.char.requests.itemset then
        -- hook all itemset lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchItemSet"]) do
            table.insert(self.db.account.buffer.itemsets, {isId = id, isName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = MangAdmin.db.account.style.showchat
        end
      elseif self.db.char.requests.spell then
        -- hook all spell lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchSpell"]) do
            table.insert(self.db.account.buffer.spells, {spId = id, spName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = MangAdmin.db.account.style.showchat
        end
      elseif self.db.char.requests.skill then
        -- hook all skill lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchSkill"]) do
            table.insert(self.db.account.buffer.skills, {skId = id, skName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = MangAdmin.db.account.style.showchat
        end
      elseif self.db.char.requests.creature then
        -- hook all creature lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchCreature"]) do
            table.insert(self.db.account.buffer.creatures, {crId = id, crName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = MangAdmin.db.account.style.showchat
        end
      elseif self.db.char.requests.object then
        -- hook all object lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchGameObject"]) do
            table.insert(self.db.account.buffer.objects, {objId = id, objName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = MangAdmin.db.account.style.showchat
        end
      elseif self.db.char.requests.quest then
        -- hook all quest lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchQuest"]) do
            table.insert(self.db.account.buffer.quests, {qsId = id, qsName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = MangAdmin.db.account.style.showchat
        end
      elseif self.db.char.requests.tele then
        -- hook all tele lookups
        for id, name in string.gmatch(text, Strings["ma_GmatchTele"]) do
            table.insert(self.db.account.buffer.teles, {tName = name, checked = false})
            PopupScrollUpdate()
            catchedSth = true
            output = MangAdmin.db.account.style.showchat
        end
        --this is to hide the message shown before the teles
        if string.gmatch(text, Strings["ma_GmatchTeleFound"]) then
          catchedSth = true
          output = MangAdmin.db.account.style.showchat
        end
      end
    end

    -- hook all new tickets
    for name in string.gmatch(text, Strings["ma_GmatchNewTicket"]) do
      self:SetIcon(ROOT_PATH.."Textures\\icon2.tga")
      PlaySoundFile(ROOT_PATH.."Sound\\mail.wav")
    end
    
    --check for info command to update informations in right bottom
    for revision in string.gmatch(text, Strings["ma_GmatchRevision"]) do
      ma_inforevisiontext:SetText(Locale["info_revision"]..revision)
      --ma_infoplatformtext:SetText(Locale["info_platform"]..platform)
        catchedSth = true
        output = MangAdmin.db.account.style.showchat
    end
    for users, maxusers in string.gmatch(text, Strings["ma_GmatchOnlinePlayers"]) do
      ma_infoonlinetext:SetText(Locale["info_online"]..users)
      ma_infomaxonlinetext:SetText(Locale["info_maxonline"]..maxusers)
        catchedSth = true
        output = MangAdmin.db.account.style.showchat
    end
    for uptime in string.gmatch(text, Strings["ma_GmatchUptime"]) do
      ma_infouptimetext:SetText(Locale["info_uptime"]..uptime)
        catchedSth = true
        output = MangAdmin.db.account.style.showchat
    end
    for match in string.gmatch(text, Strings["ma_GmatchActiveConnections"]) do
        catchedSth = true
        output = MangAdmin.db.account.style.showchat
    
    end
    -- get results of ticket list. In Trinity, everything will be constructed off the list
    for id, char, create, update in string.gmatch(text, Strings["ma_GmatchTickets"]) do
        table.insert(MangAdmin.db.account.buffer.tickets, {tNumber = id, tChar = char, tLCreate = create, tLUpdate = update, tMsg = ""})
        local ticketCount = 0
        table.foreachi(MangAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
        ticketCount = 0
        catchedSth = true
        output = MangAdmin.db.account.style.showchat
        self.db.char.requests.ticketbody = id
        self.db.char.msgDeltaTime = time()
    end

    for msg in string.gmatch(text, "Ticket Message.-:.-(.*)") do
        MangAdmin.db.account.buffer.ticketread=true
        MangAdmin.db.account.buffer.ticketsfull = {}
        table.remove(MangAdmin.db.account.buffer.ticketsfull, 1)
        table.insert(MangAdmin.db.account.buffer.ticketsfull, {tMsg = " "})
        ma_ticketdetail:SetText("|cffffffff"..msg)
        catchedSth = true
        output = MangAdmin.db.account.style.showchat
    end       

    if MangAdmin.db.account.buffer.ticketread==true then
        for msg in string.gmatch(text, "(.*)]|r") do
            local object = MangAdmin.db.account.buffer.ticketsfull[1]
            local t_msg = ""
            t_msg = object["tMsg"]
            t_msg = t_msg.." ".."|c00000000"..msg
            table.remove(MangAdmin.db.account.buffer.ticketsfull, 1)
            table.insert(MangAdmin.db.account.buffer.ticketsfull, {tMsg = t_msg})
            MangAdmin.db.account.buffer.ticketread=false
            ma_ticketdetail:SetText("|cffffffff"..t_msg)
            catchedSth = true
            output = MangAdmin.db.account.style.showchat
        end
        for msg in string.gmatch(text, "(.*)") do
            local object = MangAdmin.db.account.buffer.ticketsfull[1]
            local t_msg = "" 
            t_msg = object["tMsg"]
            t_msg = t_msg.." ".."|c00000000"..msg
            table.remove(MangAdmin.db.account.buffer.ticketsfull, 1)
            table.insert(MangAdmin.db.account.buffer.ticketsfull, {tMsg = t_msg})
            catchedSth = true
            output = MangAdmin.db.account.style.showchat
        end
    end

    for eraseme in string.gmatch(text, "Showing list of open tickets") do
        catchedSth = true
        output = MangAdmin.db.account.style.showchat
        
    end
    
    for mymatch in string.gmatch(text, "Characters Online:") do
        catchedSth = true
        output = MangAdmin.db.account.style.showchat
    end
    if catchedSth then
      if output == false then
        -- don't output anything
      elseif output == true then
        text = MangLinkifier_Decompose(text)
        self.hooks[frame].AddMessage(frame, text, r, g, b, id)
      end
    else
      text = MangLinkifier_Decompose(text)
      self.hooks[frame].AddMessage(frame, text, r, g, b, id)
    end
  else
    -- message is not from server
    --Linkifier should be used on non server messages as well to catch links suc as items in chat
    text = MangLinkifier_Decompose(text)
    -- Returns the message to the client, or else the chat frame never shows it
    self.hooks[frame].AddMessage(frame, text, r, g, b, id)
  end
end


function MangAdmin:ChatMsg(msg, msgt, recipient)
  if not msgt then local msgt = "GUILD" end
  if msgt == "addon" then
    if recipient then
      SendAddonMessage("", msg, "WHISPER", recipient)
    else
      SendAddonMessage("", msg, "GUILD")
    end
  else
    if recipient then 
      SendChatMessage(msg, "WHISPER", nil, recipient)
    else
      SendChatMessage(msg, msgt, nil, nil)
    end
  end
end

function MangAdmin:Selection(selection)
  if selection == "player" then
    if UnitIsPlayer("target") then
      return true
    end
  elseif selection == "self" then
    if UnitIsUnit("target", "player") then
      return true
    end
  elseif selection == "none" then
    if not UnitName("target") then
      return true
    end
  else
    error("Argument 'selection' can be 'player','self', or 'none'!")
    return false
  end
end

function MangAdmin:AndBit(value, test) 
  return mod(value, test*2) >= test 
end


function MangAdmin:SetLanguage()
    if self.db.account.language then
    Locale:SetLocale(self.db.account.language)
    if self.db.account.localesearchstring then
      Strings:SetLocale(self.db.account.language)
    else
      Strings:SetLocale("enUS")
    end
  else
    self.db.account.language = Locale:GetLocale()
  end
end

function MangAdmin:ChangeLanguage(locale)
  self.db.account.localesearchstring = ma_checklocalsearchstringsbutton:GetChecked()
  self.db.account.language = locale
  ReloadUI()
end

function MangAdmin:SetSkill(value, skill, maxskill)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local class = UnitClass("target") or UnitClass("player")
    if not skill then
      skill = ma_var1editbox:GetText()
      if ma_var1editbox:GetText() == "" then
        skill = 375
      end
    end
    if not maxskill then
      maxskill = ma_var2editbox:GetText()
      if ma_var2editbox:GetText() == "" then
        maxskill = 375
      end
    end
    if type(value) == "string" then
      self:ChatMsg(".setskill "..value.." "..skill.." "..maxskill)
      self:LogAction("Set skill "..value.." of "..player.." to "..skill.." with a maximum of "..maxskill..".")
    elseif type(value) == "table" then
      for k,v in pairs(value) do
        self:ChatMsg(".setskill "..v.." "..skill.." "..maxskill)
        self:LogAction("Set skill "..v.." of "..player.." to "..skill.." with a maximum of "..maxskill..".")
      end
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:Quest(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local class = UnitClass("target") or UnitClass("player")
    local command = ".quest add"
    local logcmd = "Added"
    local logcmd2 = "to"
    if state == "RightButton" then
      command = ".quest remove"
      logcmd = "Removed"
      logcmd2 = "from"
    end
    if type(value) == "string" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
    elseif type(value) == "table" then
      for k,v in pairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
      end
    elseif type(value) == "number" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." quest with id "..value.." "..logcmd2.." "..player..".")
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:Creature(value, state)
    local command = ".npc add"
    local logcmd = "Spawned"
    if state == "RightButton" then
      command = ".list creature"
      logcmd = "Listed"
    end
    if type(value) == "string" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." creature with id "..value..".")
    elseif type(value) == "table" then
      for k,v in pairs(value) do
        self:ChatMsg(command.." "..v)
        self:LogAction(logcmd.." creature with id "..value..".")
      end
    elseif type(value) == "number" then
      self:ChatMsg(command.." "..value)
      self:LogAction(logcmd.." creature with id "..value..".")
    end

end

function MangAdmin:AddItem(value, state)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local amount = ma_var1editbox:GetText()
    if state == "RightButton" then
      if amount == "" then
        self:ChatMsg(".additem "..value.." -1")
      else
        local amt=tonumber(amount)
        if amt >0 then 
           amt=amt*-1
           amount=tostring(amt)
        end
        self:ChatMsg(".additem "..value.." "..amount)
      
      end
      
    else
      if amount == "" then
        self:ChatMsg(".additem "..value)
      else
        self:ChatMsg(".additem "..value.." "..amount)
      end
    end
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:AddItemSet(value)
  if self:Selection("player") or self:Selection("self") or self:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    self:ChatMsg(".additemset "..value)
  else
    self:Print(Locale["selectionerror1"])
  end
end

function MangAdmin:AddObject(value, state)
  local loot = ma_var1editbox:GetText()
  local _time = ma_var2editbox:GetText()
  if state == "RightButton" then
    self:ChatMsg(".gobject add "..value.." "..value)
  else
    if loot ~= "" and _time == "" then
      self:ChatMsg(".gobject add "..value.. " "..loot)
    elseif loot ~= "" and _time ~= "" then
      self:ChatMsg(".gobject add "..value.. " "..loot.." ".._time)
    else
      self:ChatMsg(".gobject add "..value)
    end
  end
end

function MangAdmin:TelePlayer(value, player)
  if value == "gochar" then
    self:ChatMsg(".goname "..player)
    self:LogAction("Teleported to player "..player..".")
  elseif value == "getchar" then
    self:ChatMsg(".namego "..player)
    self:LogAction("Summoned player "..player..".")
  end
end






function MangAdmin:SendMail(recipient, subject, body)
  recipient = string.gsub(recipient, " ", "")
  subject = string.gsub(subject, " ", "")
  body = string.gsub(body, "\n", " ")
  subject = '"'..subject..'"'
  body = '"'..body..'"'
  self:ChatMsg(".send mail "..recipient.." "..subject.." "..body)
end





function MangAdmin:UpdateMailBytesLeft()
  local bleft = 246 - strlen(ma_searcheditbox:GetText()) - strlen(ma_var1editbox:GetText()) - strlen(ma_maileditbox:GetText())
  if bleft >= 0 then
    ma_lookupresulttext:SetText(Locale["ma_MailBytesLeft"].."|cff00ff00"..bleft.."|r")
  else
    ma_lookupresulttext:SetText(Locale["ma_MailBytesLeft"].."|cffff0000"..bleft.."|r")
  end
end







function MangAdmin:Favorites(value, searchtype)
  if value == "add" then
    if searchtype == "item" then
      table.foreachi(self.db.account.buffer.items, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.items, {itId = v["itId"], itName = v["itName"], checked = false}) end end)
    elseif searchtype == "itemset" then
      table.foreachi(self.db.account.buffer.itemsets, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.itemsets, {isId = v["isId"], isName = v["isName"], checked = false}) end end)
    elseif searchtype == "spell" then
      table.foreachi(self.db.account.buffer.spells, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.spells, {spId = v["spId"], spName = v["spName"], checked = false}) end end)
    elseif searchtype == "skill" then
      table.foreachi(self.db.account.buffer.skills, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.skills, {skId = v["skId"], skName = v["skName"], checked = false}) end end)
    elseif searchtype == "quest" then
      table.foreachi(self.db.account.buffer.quests, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.quests, {qsId = v["qsId"], qsName = v["qsName"], checked = false}) end end)
    elseif searchtype == "creature" then
      table.foreachi(self.db.account.buffer.creatures, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.creatures, {crId = v["crId"], crName = v["crName"], checked = false}) end end)
    elseif searchtype == "object" then
      table.foreachi(self.db.account.buffer.objects, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.objects, {objId = v["objId"], objName = v["objName"], checked = false}) end end)
    elseif searchtype == "tele" then
      table.foreachi(self.db.account.buffer.teles, function(k,v) if v["checked"] then table.insert(self.db.account.favorites.teles, {tName = v["tName"], checked = false}) end end)
    end
    self:LogAction("Added some "..searchtype.."s to the favorites.")
  elseif value == "remove" then
    if searchtype == "item" then
      for k,v in pairs(self.db.account.favorites.items) do
        if v["checked"] then table.remove(self.db.account.favorites.items, k) end 
      end
    elseif searchtype == "itemset" then
      for k,v in pairs(self.db.account.favorites.itemsets) do
        if v["checked"] then table.remove(self.db.account.favorites.itemsets, k) end 
      end
    elseif searchtype == "spell" then
      for k,v in pairs(self.db.account.favorites.spells) do
        if v["checked"] then table.remove(self.db.account.favorites.spells, k) end 
      end
    elseif searchtype == "skill" then
      for k,v in pairs(self.db.account.favorites.skills) do
        if v["checked"] then table.remove(self.db.account.favorites.skills, k) end 
      end
    elseif searchtype == "quest" then
      for k,v in pairs(self.db.account.favorites.quests) do
        if v["checked"] then table.remove(self.db.account.favorites.quests, k) end 
      end
    elseif searchtype == "creature" then
      for k,v in pairs(self.db.account.favorites.creatures) do
        if v["checked"] then table.remove(self.db.account.favorites.creatures, k) end 
      end
    elseif searchtype == "object" then
      for k,v in pairs(self.db.account.favorites.objects) do
        if v["checked"] then table.remove(self.db.account.favorites.objects, k) end 
      end
    elseif searchtype == "tele" then
      for k,v in pairs(self.db.account.favorites.teles) do
        if v["checked"] then table.remove(self.db.account.favorites.teles, k) end 
      end
    end
    self:LogAction("Removed some favorited "..searchtype.."s from the list.")
    PopupScrollUpdate()
  elseif value == "show" then
    if searchtype == "item" then
      self.db.char.requests.favitem = true
    elseif searchtype == "itemset" then
      self.db.char.requests.favitemset = true
    elseif searchtype == "spell" then
      self.db.char.requests.favspell = true
    elseif searchtype == "skill" then
      self.db.char.requests.favskill = true
    elseif searchtype == "quest" then
      self.db.char.requests.favquest = true
    elseif searchtype == "creature" then
      self.db.char.requests.favcreature = true
    elseif searchtype == "object" then
      self.db.char.requests.favobject = true
    elseif searchtype == "tele" then
      self.db.char.requests.favtele = true
    end
    PopupScrollUpdate()
  elseif value == "select" or value == "deselect" then
    local selected = true
    if value == "deselect" then
      selected = false
    end
    if searchtype == "item" then
      if MangAdmin.db.char.requests.item then
        table.foreachi(self.db.account.buffer.items, function(k,v) self.db.account.buffer.items[k].checked = selected end)
      elseif MangAdmin.db.char.requests.favitem then
        table.foreachi(self.db.account.favorites.items, function(k,v) self.db.account.favorites.items[k].checked = selected end)
      end
    elseif searchtype == "itemset" then
      if MangAdmin.db.char.requests.itemset then
        table.foreachi(self.db.account.buffer.itemsets, function(k,v) self.db.account.buffer.itemsets[k].checked = selected end)
      elseif MangAdmin.db.char.requests.favitemset then
        table.foreachi(self.db.account.favorites.itemsets, function(k,v) self.db.account.favorites.itemsets[k].checked = selected end)
      end
    elseif searchtype == "spell" then
      if MangAdmin.db.char.requests.spell then
        table.foreachi(self.db.account.buffer.spells, function(k,v) self.db.account.buffer.spells[k].checked = selected end)
      elseif MangAdmin.db.char.requests.favspell then
        table.foreachi(self.db.account.favorites.spells, function(k,v) self.db.account.favorites.spells[k].checked = selected end)
      end
    elseif searchtype == "skill" then
      if MangAdmin.db.char.requests.skill then
        table.foreachi(self.db.account.buffer.skills, function(k,v) self.db.account.buffer.skills[k].checked = selected end)
      elseif MangAdmin.db.char.requests.favskill then
        table.foreachi(self.db.account.favorites.skills, function(k,v) self.db.account.favorites.skills[k].checked = selected end)
      end
    elseif searchtype == "quest" then
      if MangAdmin.db.char.requests.quest then
        table.foreachi(self.db.account.buffer.quests, function(k,v) self.db.account.buffer.quests[k].checked = selected end)
      elseif MangAdmin.db.char.requests.favquest then
        table.foreachi(self.db.account.favorites.quests, function(k,v) self.db.account.favorites.quests[k].checked = selected end)
      end
    elseif searchtype == "creature" then
      if MangAdmin.db.char.requests.creature then
        table.foreachi(self.db.account.buffer.creatures, function(k,v) self.db.account.buffer.creatures[k].checked = selected end)
      elseif MangAdmin.db.char.requests.favcreature then
        table.foreachi(self.db.account.favorites.creatures, function(k,v) self.db.account.favorites.creatures[k].checked = selected end)
      end
    elseif searchtype == "object" then
      if MangAdmin.db.char.requests.object then
        table.foreachi(self.db.account.buffer.objects, function(k,v) self.db.account.buffer.objects[k].checked = selected end)
      elseif MangAdmin.db.char.requests.favobject then
        table.foreachi(self.db.account.favorites.objects, function(k,v) self.db.account.favorites.objects[k].checked = selected end)
      end
    elseif searchtype == "tele" then
      if MangAdmin.db.char.requests.tele then
        table.foreachi(self.db.account.buffer.teles, function(k,v) self.db.account.buffer.teles[k].checked = selected end)
      elseif MangAdmin.db.char.requests.favtele then
        table.foreachi(self.db.account.favorites.teles, function(k,v) self.db.account.favorites.teles[k].checked = selected end)
      end
    end
    PopupScrollUpdate()
  end
end

function MangAdmin:SearchStart(var, value)
  self.db.char.requests.toggle = true
  if var == "item" then
    self.db.char.requests.item = true
    self.db.account.buffer.items = {}
    self:ChatMsg(".lookup item "..value)
  elseif var == "itemset" then
    self.db.char.requests.itemset = true
    self.db.account.buffer.itemsets = {}
    self:ChatMsg(".lookup itemset "..value)
  elseif var == "spell" then
    self.db.char.requests.spell = true
    self.db.account.buffer.spells = {}
    self:ChatMsg(".lookup spell "..value)
  elseif var == "skill" then
    self.db.char.requests.skill = true
    self.db.account.buffer.skills = {}
    self:ChatMsg(".lookup skill "..value)
  elseif var == "quest" then
    self.db.char.requests.quest = true
    self.db.account.buffer.quests = {}
    self:ChatMsg(".lookup quest "..value)
  elseif var == "creature" then
    self.db.char.requests.creature = true
    self.db.account.buffer.creatures = {}
    self:ChatMsg(".lookup creature "..value)
  elseif var == "object" then
    self.db.char.requests.object = true
    self.db.account.buffer.objects = {}
    self:ChatMsg(".lookup object "..value)
  elseif var == "tele" then
    self.db.char.requests.tele = true
    self.db.account.buffer.teles = {}
    self:ChatMsg(".lookup tele "..value)
  end
  self.db.account.buffer.counter = 0
  self:LogAction("Searching for "..var.."s with the keyword '"..value.."'.")
end

function MangAdmin:SearchReset()
  ma_searcheditbox:SetScript("OnTextChanged", function() end)
  ma_var1editbox:SetScript("OnTextChanged", function() end)
  ma_searcheditbox:SetText("")
  ma_var1editbox:SetText("")
  ma_var2editbox:SetText("")
  ma_lookupresulttext:SetText(Locale["searchResults"].."0")
  self.db.char.requests.item = false
  self.db.char.requests.favitem = false
  self.db.char.requests.itemset = false
  self.db.char.requests.favitemset = false
  self.db.char.requests.spell = false
  self.db.char.requests.favspell = false
  self.db.char.requests.skill = false
  self.db.char.requests.favskill = false
  self.db.char.requests.quest = false
  self.db.char.requests.favquest = false
  self.db.char.requests.creature = false
  self.db.char.requests.favcreature = false
  self.db.char.requests.object = false
  self.db.char.requests.favobject = false
  self.db.char.requests.tele = false
  self.db.char.requests.favtele = false
  self.db.char.requests.toggle = false
  self.db.account.buffer.items = {}
  self.db.account.buffer.itemsets = {}
  self.db.account.buffer.spells = {}
  self.db.account.buffer.skills = {}
  self.db.account.buffer.quests = {}
  self.db.account.buffer.creatures = {}
  self.db.account.buffer.objects = {}
  self.db.account.buffer.teles = {}
  self.db.account.buffer.counter = 0
  PopupScrollUpdate()
end

function MangAdmin:PrepareScript(object, text, script)
  --if object then
    if text then
      if self.db.account.style.showtooltips then
        object:SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:SetText(text); GameTooltip:Show() end)
        object:SetScript("OnLeave", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:Hide() end)
      end
    end
    if type(script) == "function" then
      object:SetScript("OnClick", script)
    elseif type(script) == "table" then
      for k,v in pairs(script) do
        object:SetScript(unpack(v))
      end
    end
  --end
end


--[[INITIALIZION FUNCTIONS]]
function MangAdmin:InitButtons()
  -- start tab buttons
  self:PrepareScript(ma_tabbutton_misc       , Locale["tt_MiscButton"]         , function() MangAdmin:InstantGroupToggle("misc") end)
  --end tab buttons
  -- start mini buttons
  self:PrepareScript(ma_mm_logoframe         , nil                             , function() MangAdmin:OnClick() end)
  self:PrepareScript(ma_mm_ticketbutton      , Locale["tt_TicketButton"]       , function() ShowTicketTab() end)
  self:PrepareScript(ma_mm_miscbutton        , Locale["tt_MiscButton"]         , function() MangAdmin:InstantGroupToggle("misc") end)
  --end mini buttons
  self:PrepareScript(ma_languagebutton       , Locale["tt_LanguageButton"]     , function() MangAdmin:ChangeLanguage(UIDropDownMenu_GetSelectedValue(ma_languagedropdown)) end)
  self:PrepareScript(ma_itembutton           , Locale["tt_ItemButton"]         , function() MangAdmin:TogglePopup("search", {type = "item"}) end)
  self:PrepareScript(ma_itemsetbutton        , Locale["tt_ItemSetButton"]      , function() MangAdmin:TogglePopup("search", {type = "itemset"}) end)
  self:PrepareScript(ma_spellbutton          , Locale["tt_SpellButton"]        , function() MangAdmin:TogglePopup("search", {type = "spell"}) end)
  self:PrepareScript(ma_skillbutton          , Locale["tt_SkillButton"]        , function() MangAdmin:TogglePopup("search", {type = "skill"}) end)
  self:PrepareScript(ma_questbutton          , Locale["tt_QuestButton"]        , function() MangAdmin:TogglePopup("search", {type = "quest"}) end)
  self:PrepareScript(ma_creaturebutton       , Locale["tt_CreatureButton"]     , function() MangAdmin:TogglePopup("search", {type = "creature"}) end)
  self:PrepareScript(ma_objectbutton         , Locale["tt_ObjectButton"]       , function() MangAdmin:TogglePopup("search", {type = "object"}) end)
  self:PrepareScript(ma_telesearchbutton     , Locale["ma_TeleSearchButton"]   , function() MangAdmin:TogglePopup("search", {type = "tele"}) end)
  self:PrepareScript(ma_sendmailbutton       , Locale["ma_Mail"]               , function() MangAdmin:TogglePopup("mail", {}) end)
  self:PrepareScript(ma_searchbutton         , nil                             , function() MangAdmin:SearchStart("item", ma_searcheditbox:GetText()) end)
  self:PrepareScript(ma_resetsearchbutton    , nil                             , function() MangAdmin:SearchReset() end)
  self:PrepareScript(ma_closebutton          , nil                             , function() MangAdmin:CloseButton("bg") end)
  self:PrepareScript(ma_popupclosebutton     , nil                             , function() MangAdmin:CloseButton("popup") end)
  self:PrepareScript(ma_popup2closebutton    , nil                             , function() MangAdmin:CloseButton("popup2") end)
  self:PrepareScript(ma_inforefreshbutton    , nil                             , function() MangAdmin:ChatMsg(".server info") end)
  self:PrepareScript(ma_frmtrslider          , Locale["tt_FrmTrSlider"]        , {{"OnMouseUp", function() MangAdmin:ChangeTransparency("frames") end},{"OnValueChanged", function() ma_frmtrsliderText:SetText(string.format("%.2f", ma_frmtrslider:GetValue())) end}})  
  self:PrepareScript(ma_btntrslider          , Locale["tt_BtnTrSlider"]        , {{"OnMouseUp", function() MangAdmin:ChangeTransparency("buttons") end},{"OnValueChanged", function() ma_btntrsliderText:SetText(string.format("%.2f", ma_btntrslider:GetValue())) end}})  
  self:PrepareScript(ma_mm_revivebutton      , nil                             , function() SendChatMessage(".revive", "GUILD", nil, nil) end)
end



function MangAdmin:InitDropDowns()

 --LANGUAGE
  local function LangDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {"Deutsch","deDE"},
      {"English","enUS"},
      {"Français","frFR"},
      {"Svenska","svSV"},
      {"Italiano","itIT"},
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_languagedropdown, this.value) end
      info.checked = nil
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_languagedropdown, Locale:GetLocale())
  end
  UIDropDownMenu_Initialize(ma_languagedropdown, LangDropDownInitialize)
  UIDropDownMenu_SetWidth(ma_languagedropdown, 100)
  UIDropDownMenu_SetButtonWidth(ma_languagedropdown, 20)


end

function MangAdmin:InitSliders()
  -- Frame Transparency Slider
  ma_frmtrslider:SetOrientation("HORIZONTAL")
  ma_frmtrslider:SetMinMaxValues(0.1, 1.0)
  ma_frmtrslider:SetValueStep(0.05)
  ma_frmtrslider:SetValue(MangAdmin.db.account.style.transparency.frames)
  ma_frmtrsliderText:SetText(string.format("%.2f", MangAdmin.db.account.style.transparency.frames))
  -- Button Transparency Slider
  ma_btntrslider:SetOrientation("HORIZONTAL")
  ma_btntrslider:SetMinMaxValues(0.1, 1.0)
  ma_btntrslider:SetValueStep(0.05)
  ma_btntrslider:SetValue(MangAdmin.db.account.style.transparency.buttons)
  ma_btntrsliderText:SetText(string.format("%.2f", MangAdmin.db.account.style.transparency.buttons))
end

function MangAdmin:InitScrollFrames()
  cont = MangAdmin.db.char.selectedCont
  ma_PopupScrollBar:SetScript("OnVerticalScroll", PopupScrollUpdate(), function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset, 30, PopupScrollUpdate()) end)
  ma_PopupScrollBar:SetScript("OnShow", function() PopupScrollUpdate() end)
  ma_mailscrollframe:SetScrollChild(ma_maileditbox)
  ma_maileditbox:SetScript("OnTextChanged", function() MangAdmin:UpdateMailBytesLeft() end)
  ma_maileditbox:SetScript("OnCursorChanged", function() ScrollingEdit_OnCursorChanged(self, x, y, w, h) end)
end


function MangAdmin:NoResults(var)
  if var == "ticket" then
    -- Reset list and make an entry "No Tickets"
    self:LogAction(Locale["ma_TicketsNoTickets"])
    FauxScrollFrame_Update(ma_ZoneScrollBar,12,12,30);
    for line = 1,12 do
      getglobal("ma_ZoneScrollBarEntry"..line):Disable()
      if line == 1 then
        getglobal("ma_ZoneScrollBarEntry"..line):SetText(Locale["ma_TicketsNoTickets"])
        getglobal("ma_ZoneScrollBarEntry"..line):Show()
      else
        getglobal("ma_ZoneScrollBarEntry"..line):Hide()
      end
    end
  elseif var == "search" then
    ma_lookupresulttext:SetText(Locale["searchResults"].."0")
    FauxScrollFrame_Update(ma_PopupScrollBar,7,7,30);
    for line = 1,7 do
      getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
      getglobal("ma_PopupScrollBarEntry"..line):Disable()
      getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Disable()
      getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
      if line == 1 then
        getglobal("ma_PopupScrollBarEntry"..line):SetText(Locale["tt_SearchDefault"])
        getglobal("ma_PopupScrollBarEntry"..line):Show()
      else
        getglobal("ma_PopupScrollBarEntry"..line):Hide()
      end
    end
  elseif var == "favorites" then
    ma_lookupresulttext:SetText(Locale["favoriteResults"].."0")
    FauxScrollFrame_Update(ma_PopupScrollBar,7,7,30);
    for line = 1,7 do
      getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
      getglobal("ma_PopupScrollBarEntry"..line):Disable()
      getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Disable()
      getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
      if line == 1 then
        getglobal("ma_PopupScrollBarEntry"..line):SetText(Locale["ma_NoFavorites"])
        getglobal("ma_PopupScrollBarEntry"..line):Show()
      else
        getglobal("ma_PopupScrollBarEntry"..line):Hide()
      end
    end
  elseif var == "zones" then
    FauxScrollFrame_Update(ma_ZoneScrollBar,12,12,16);
    for line = 1,12 do
      getglobal("ma_ZoneScrollBarEntry"..line):Disable()
      if line == 1 then
        getglobal("ma_ZoneScrollBarEntry"..line):SetText(Locale["ma_NoZones"])
        getglobal("ma_ZoneScrollBarEntry"..line):Show()
      else
        getglobal("ma_ZoneScrollBarEntry"..line):Hide()
      end
    end
  elseif var == "subzones" then
    FauxScrollFrame_Update(ma_SubzoneScrollBar,12,12,16);
    for line = 1,12 do
      getglobal("ma_SubzoneScrollBarEntry"..line):Disable()
      if line == 1 then
        getglobal("ma_SubzoneScrollBarEntry"..line):SetText(Locale["ma_NoSubZones"])
        getglobal("ma_SubzoneScrollBarEntry"..line):Show()
      else
        getglobal("ma_SubzoneScrollBarEntry"..line):Hide()
      end
    end
  end
end

function PopupScrollUpdate()
  local line -- 1 through 7 of our window to scroll
  local lineplusoffset -- an index into our data calculated from the scroll offset
  if MangAdmin.db.char.requests.item or MangAdmin.db.char.requests.favitem then --get items
    local count = 0
    if MangAdmin.db.char.requests.item then
      table.foreachi(MangAdmin.db.account.buffer.items, function() count = count + 1 end)
    elseif MangAdmin.db.char.requests.favitem then
      table.foreachi(MangAdmin.db.account.favorites.items, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30);
      for line = 1,7 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local item
          if MangAdmin.db.char.requests.item then
            item = MangAdmin.db.account.buffer.items[lineplusoffset]
          elseif MangAdmin.db.char.requests.favitem then
            item = MangAdmin.db.account.favorites.items[lineplusoffset]
          end
          local key = lineplusoffset
          --item icons
          getglobal("ma_PopupScrollBarEntryIcon"..line.."IconTexture"):SetTexture(GetItemIcon(item["itId"]))
          getglobal("ma_PopupScrollBarEntryIcon"..line):SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..item["itId"]..":0:0:0:0:0:0:0"); GameTooltip:Show() end)
          getglobal("ma_PopupScrollBarEntryIcon"..line):SetScript("OnLeave", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:Hide() end)
          getglobal("ma_PopupScrollBarEntryIcon"..line):SetScript("OnClick", function() MangAdmin:AddItem(item["itId"], arg1) end)
          getglobal("ma_PopupScrollBarEntryIcon"..line):Show()
          --item description
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..item["itId"].."|r Name: |cffffffff"..item["itName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:AddItem(item["itId"], arg1) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:SetHyperlink("item:"..item["itId"]..":0:0:0:0:0:0:0"); GameTooltip:Show() end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() GameTooltip:SetOwner(this, "ANCHOR_RIGHT"); GameTooltip:Hide() end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if MangAdmin.db.char.requests.item then
            if item["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.items[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.items[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif MangAdmin.db.char.requests.favitem then
            if item["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.items[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.items[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(item["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if MangAdmin.db.char.requests.item then
        MangAdmin:NoResults("search")
      elseif MangAdmin.db.char.requests.favitem then
        MangAdmin:NoResults("favorites")
      end
    end
    
  elseif MangAdmin.db.char.requests.itemset or MangAdmin.db.char.requests.favitemset then --get itemsets
    local count = 0
    if MangAdmin.db.char.requests.itemset then
      table.foreachi(MangAdmin.db.account.buffer.itemsets, function() count = count + 1 end)
    elseif MangAdmin.db.char.requests.favitemset then
      table.foreachi(MangAdmin.db.account.favorites.itemsets, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30);
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local itemset
          if MangAdmin.db.char.requests.itemset then
            itemset = MangAdmin.db.account.buffer.itemsets[lineplusoffset]
          elseif MangAdmin.db.char.requests.favitemset then
            itemset = MangAdmin.db.account.favorites.itemsets[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..itemset["isId"].."|r Name: |cffffffff"..itemset["isName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:AddItemSet(itemset["isId"]) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if MangAdmin.db.char.requests.itemset then
            if itemset["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.itemsets[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.itemsets[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif MangAdmin.db.char.requests.favitemset then
            if itemset["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.itemsets[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.itemsets[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(itemset["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if MangAdmin.db.char.requests.itemset then
        MangAdmin:NoResults("search")
      elseif MangAdmin.db.char.requests.favitemset then
        MangAdmin:NoResults("favorites")
      end
    end
    
  elseif MangAdmin.db.char.requests.quest or MangAdmin.db.char.requests.favquest then --get quests
    local count = 0
    if MangAdmin.db.char.requests.quest then
      table.foreachi(MangAdmin.db.account.buffer.quests, function() count = count + 1 end)
    elseif MangAdmin.db.char.requests.favquest then
      table.foreachi(MangAdmin.db.account.favorites.quests, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30);
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local quest
          if MangAdmin.db.char.requests.quest then
            quest = MangAdmin.db.account.buffer.quests[lineplusoffset]
          elseif MangAdmin.db.char.requests.favquest then
            quest = MangAdmin.db.account.favorites.quests[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..quest["qsId"].."|r Name: |cffffffff"..quest["qsName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:Quest(quest["qsId"], arg1) end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if MangAdmin.db.char.requests.quest then
            if quest["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.quests[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.quests[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif MangAdmin.db.char.requests.favquest then
            if quest["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.quests[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.quests[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(quest["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if MangAdmin.db.char.requests.quest then
        MangAdmin:NoResults("search")
      elseif MangAdmin.db.char.requests.favquest then
        MangAdmin:NoResults("favorites")
      end
    end
    
  elseif MangAdmin.db.char.requests.creature or MangAdmin.db.char.requests.favcreature then --get creatures
    local count = 0
    if MangAdmin.db.char.requests.creature then
      table.foreachi(MangAdmin.db.account.buffer.creatures, function() count = count + 1 end)
    elseif MangAdmin.db.char.requests.favcreature then
      table.foreachi(MangAdmin.db.account.favorites.creatures, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30);
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local creature
          if MangAdmin.db.char.requests.creature then
            creature = MangAdmin.db.account.buffer.creatures[lineplusoffset]
          elseif MangAdmin.db.char.requests.favcreature then
            creature = MangAdmin.db.account.favorites.creatures[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..creature["crId"].."|r Name: |cffffffff"..creature["crName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:Creature(creature["crId"], arg1) end) 
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if MangAdmin.db.char.requests.creature then
            if creature["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.creatures[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.creatures[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif MangAdmin.db.char.requests.favcreature then
            if creature["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.creatures[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.creatures[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(creature["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if MangAdmin.db.char.requests.creature then
        MangAdmin:NoResults("search")
      elseif MangAdmin.db.char.requests.favcreature then
        MangAdmin:NoResults("favorites")
      end
    end
    
  elseif MangAdmin.db.char.requests.spell or MangAdmin.db.char.requests.favspell then --get spells
    local count = 0
    if MangAdmin.db.char.requests.spell then
      table.foreachi(MangAdmin.db.account.buffer.spells, function() count = count + 1 end)
    elseif MangAdmin.db.char.requests.favspell then
      table.foreachi(MangAdmin.db.account.favorites.spells, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30);
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local spell
          if MangAdmin.db.char.requests.spell then
            spell = MangAdmin.db.account.buffer.spells[lineplusoffset]
          elseif MangAdmin.db.char.requests.favspell then
            spell = MangAdmin.db.account.favorites.spells[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..spell["spId"].."|r Name: |cffffffff"..spell["spName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() LearnSpell(spell["spId"], arg1) end)  
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if MangAdmin.db.char.requests.spell then
            if spell["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.spells[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.spells[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif MangAdmin.db.char.requests.favspell then
            if spell["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.spells[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.spells[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(spell["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if MangAdmin.db.char.requests.spell then
        MangAdmin:NoResults("search")
      elseif MangAdmin.db.char.requests.favspell then
        MangAdmin:NoResults("favorites")
      end
    end
    
  elseif MangAdmin.db.char.requests.skill or MangAdmin.db.char.requests.favskill then --get skills
    local count = 0
    if MangAdmin.db.char.requests.skill then
      table.foreachi(MangAdmin.db.account.buffer.skills, function() count = count + 1 end)
    elseif MangAdmin.db.char.requests.favskill then
      table.foreachi(MangAdmin.db.account.favorites.skills, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30);
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local skill
          if MangAdmin.db.char.requests.skill then
            skill = MangAdmin.db.account.buffer.skills[lineplusoffset]
          elseif MangAdmin.db.char.requests.favskill then
            skill = MangAdmin.db.account.favorites.skills[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..skill["skId"].."|r Name: |cffffffff"..skill["skName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:SetSkill(skill["skId"], nil, nil) end)  
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if MangAdmin.db.char.requests.skill then
            if skill["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.skills[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.skills[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif MangAdmin.db.char.requests.favskill then
            if skill["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.skills[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.skills[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(skill["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if MangAdmin.db.char.requests.skill then
        MangAdmin:NoResults("search")
      elseif MangAdmin.db.char.requests.favskill then
        MangAdmin:NoResults("favorites")
      end
    end
    
  elseif MangAdmin.db.char.requests.object or MangAdmin.db.char.requests.favobject then --get objects
    local count = 0
    if MangAdmin.db.char.requests.object then
      table.foreachi(MangAdmin.db.account.buffer.objects, function() count = count + 1 end)
    elseif MangAdmin.db.char.requests.favobject then
      table.foreachi(MangAdmin.db.account.favorites.objects, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30);
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local object
          if MangAdmin.db.char.requests.object then
            object = MangAdmin.db.account.buffer.objects[lineplusoffset]
          elseif MangAdmin.db.char.requests.favobject then
            object = MangAdmin.db.account.favorites.objects[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Id: |cffffffff"..object["objId"].."|r Name: |cffffffff"..object["objName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:AddObject(object["objId"], arg1) end)    
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if MangAdmin.db.char.requests.object then
            if object["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.objects[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.objects[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif MangAdmin.db.char.requests.favobject then
            if object["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.objects[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.objects[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(object["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if MangAdmin.db.char.requests.object then
        MangAdmin:NoResults("search")
      elseif MangAdmin.db.char.requests.favobject then
        MangAdmin:NoResults("favorites")
      end
    end
    
  elseif MangAdmin.db.char.requests.tele or MangAdmin.db.char.requests.favtele then --get teles
    local count = 0
    if MangAdmin.db.char.requests.tele then
      table.foreachi(MangAdmin.db.account.buffer.teles, function() count = count + 1 end)
    elseif MangAdmin.db.char.requests.favtele then
      table.foreachi(MangAdmin.db.account.favorites.teles, function() count = count + 1 end)
    end
    if count > 0 then
      ma_lookupresulttext:SetText(Locale["searchResults"]..count)
      FauxScrollFrame_Update(ma_PopupScrollBar,count,7,30);
      for line = 1,7 do
        getglobal("ma_PopupScrollBarEntryIcon"..line):Hide()
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_PopupScrollBar)
        if lineplusoffset <= count then
          local tele
          if MangAdmin.db.char.requests.tele then
            tele = MangAdmin.db.account.buffer.teles[lineplusoffset]
          elseif MangAdmin.db.char.requests.favtele then
            tele = MangAdmin.db.account.favorites.teles[lineplusoffset]
          end
          local key = lineplusoffset
          getglobal("ma_PopupScrollBarEntry"..line):SetText("Name: |cffffffff"..tele["tName"].."|r")
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnClick", function() MangAdmin:ChatMsg(".tele "..tele["tName"]) end)    
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
          getglobal("ma_PopupScrollBarEntry"..line):Enable()
          getglobal("ma_PopupScrollBarEntry"..line):Show()
          if MangAdmin.db.char.requests.tele then
            if tele["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.teles[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.buffer.teles[key]["checked"] = true; PopupScrollUpdate() end)
            end
          elseif MangAdmin.db.char.requests.favtele then
            if tele["checked"] then
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.teles[key]["checked"] = false; PopupScrollUpdate() end)
            else
              getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetScript("OnClick", function() MangAdmin.db.account.favorites.teles[key]["checked"] = true; PopupScrollUpdate() end)
            end
          end
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):SetChecked(tele["checked"])
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Enable()
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Show()
        else
          getglobal("ma_PopupScrollBarEntry"..line.."ChkBtn"):Hide()
          getglobal("ma_PopupScrollBarEntry"..line):Hide()
        end
      end
    else
      if MangAdmin.db.char.requests.tele then
        MangAdmin:NoResults("search")
      elseif MangAdmin.db.char.requests.favtele then
        MangAdmin:NoResults("favorites")
      end
    end
    
  else
    MangAdmin:NoResults("search")
  end
end



function pairsByKeys(t, f)
  if t == Nil then
  else
    local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
    local i = 0      -- iterator variable
    local iter = function ()   -- iterator function
        i = i + 1
        if a[i] == nil then return nil
        else return a[i], t[a[i]]
        end
    end
    return iter
  end
end



-- STYLE FUNCTIONS
function MangAdmin:ToggleTransparency()
  if self.db.account.style.transparency.backgrounds < 1.0 then
    self.db.account.style.transparency.backgrounds = 1.0
  else
    self.db.account.style.transparency.backgrounds = 0.5
  end
  ReloadUI()
end

function MangAdmin:ChangeTransparency(element)
  if element == "frames" then
    MangAdmin.db.account.style.transparency.frames = string.format("%.2f", ma_frmtrslider:GetValue())
  elseif element == "buttons" then
    MangAdmin.db.account.style.transparency.buttons = string.format("%.2f", ma_btntrslider:GetValue())
  end
end

function MangAdmin:ToggleTooltips()
  if self.db.account.style.showtooltips then
    self.db.account.style.showtooltips = false
  else
    self.db.account.style.showtooltips = true
  end
  ReloadUI()
end

function MangAdmin:ToggleMinimenu()
  if self.db.account.style.showminimenu then
    self.db.account.style.showminimenu = false
  else
    self.db.account.style.showminimenu = true
  end
  ReloadUI()
end

function MangAdmin:InitCheckButtons()
  if self.db.account.style.transparency.backgrounds < 1.0 then
    ma_checktransparencybutton:SetChecked(true)
  else
    ma_checktransparencybutton:SetChecked(false)
  end
  ma_checklocalsearchstringsbutton:SetChecked(self.db.account.localesearchstring)
  ma_showminimenubutton:SetChecked(self.db.account.style.showminimenu)
  ma_showtooltipsbutton:SetChecked(self.db.account.style.showtooltips)
end

function MangAdmin:LogAction(action)
--do nothing. You want logging, update to TrinityAdmin
end


function MangAdmin:CloseButton(name)
  if name == "bg" then
    MangAdmin:SearchReset()
    FrameLib:HandleGroup("bg", function(frame) frame:Hide() end)
  elseif name == "popup" then
    MangAdmin:SearchReset()
    FrameLib:HandleGroup("popup", function(frame) frame:Hide()  end)
  elseif name == "popup2" then
    FrameLib:HandleGroup("popup2", function(frame) frame:Hide()  end)
  end
end

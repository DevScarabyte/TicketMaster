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

function Return_enUS()
  return {
--[[General]]
  --[[Tooltips]]
    ["ma_IconHint"] = "|cffeda55fClick|r to open TrinityAdmin. |cffeda55fShift-Click|r to reload the user interface.",
    ["tt_Default"] = "Move your cursor over an element to toggle the tooltip!",
    ["tt_LanguageButton"] = "Change the language and reload TrinityAdmin.",
  --[[Control Labels]]
    ["ma_LanguageButton"] = "Change language",
    ["info_revision"] = "|cFF00FF00Trinity Revision:|r ",
    ["info_platform"] = "|cFF00FF00Server Platform:|r ",
    ["info_online"] = "|cFF00FF00Players Online:|r ",
    ["info_maxonline"] = "|cFF00FF00Maximum Online:|r ",
    ["info_uptime"] = "|cFF00FF00Uptime:|r ",
  --[[Other]]
    ["slashcmds"] = { "/trinityadmin", "/ta" },
    ["lang"] = "English",
    ["realm"] = "|cFF00FF00Realm:|r "..GetCVar("realmName"), --do not change this line!
    ["char"] = "|cFF00FF00Char:|r "..UnitName("player"), --do not change this line!
    ["guid"] = "|cFF00FF00Guid:|r ",
    ["tickets"] = "|cFF00FF00Tickets:|r ",
    ["selectionerror1"] = "Please select only yourself, another player or nothing!",
    ["selectionerror2"] = "Please select only yourself or nothing!",
    ["selectionerror3"] = "Please select only another player!",
    ["selectionerror4"] = "Please select only a NPC!",
    ["searchResults"] = "|cFF00FF00Search-Results:|r ",

--[[Tickets Tab]]
  --[[Name]]
    ["tabmenu_Ticket"] = "Tickets",
    ["tt_TicketButton"] = "Toggle a window which shows all tickets and lets you administrate them.",
  --[[Tooltips]]
  --[[Control Labels]]
    ["ma_LoadTicketsButton"] = "Refresh",
    ["ma_GetCharTicketButton"] = "Summon",
    ["ma_GoCharTicketButton"] = "Go Player",
    ["ma_AnswerButton"] = "Mail",
    ["ma_DeleteButton"] = "Close",
    ["ma_TicketCount"] = "|cFF00FF00Tickets:|r ",
    ["ma_TicketsNoNew"] = "You have no new tickets.",
    ["ma_TicketsNewNumber"] = "You have |cffeda55f%s|r new tickets!",
    ["ma_TicketsGoLast"] = "Go to last ticket creator (%s).",
    ["ma_TicketsGetLast"] = "Bring %s to you.",
    ["ma_TicketsInfoPlayer"] = "|cFF00FF00Player:|r ",
    ["ma_TicketsInfoStatus"] = "|cFF00FF00Status:|r ",
    ["ma_TicketsInfoAccount"] = "|cFF00FF00Account:|r ",
    ["ma_TicketsInfoAccLevel"] = "|cFF00FF00Account-Level:|r ",
    ["ma_TicketsInfoLastIP"] = "|cFF00FF00Last IP:|r ",
    ["ma_TicketsInfoPlayedTime"] = "|cFF00FF00Played time:|r ",
    ["ma_TicketsInfoLevel"] = "|cFF00FF00Level:|r ",
    ["ma_TicketsInfoMoney"] = "|cFF00FF00Money:|r ",
    ["ma_TicketsInfoLatency"] = "|cFF00FF00Latency:|r ",
    ["ma_TicketsNoInfo"] = "No info available",
    ["ma_TicketsNotLoaded"] = "No ticket loaded...",
    ["ma_TicketsNoTickets"] = "No tickets available!",
    ["ma_TicketTicketLoaded"] = "|cFF00FF00Loaded Ticket-Nr:|r %s\n\nPlayer Information\n\n",
    ["ma_Reload"] = "Reload",
    ["ma_LoadMore"] = "Load more...",
    ["tt_TicketOn"] = "Announce new tickets.",
    ["tt_TicketOff"] = "Don't announce new tickets.",
  --[[Other]]



--[[Misc Tab]]
  --[[Name]]
    ["tabmenu_Misc"] = "Misc",
    ["tt_MiscButton"] = "Toggle a window with miscellaneous actions.",
  --[[Tooltips]]
    ["tt_FrmTrSlider"] = "Change frame transparency.",
    ["tt_BtnTrSlider"] = "Change button transparency.",
  --[[Control Labels]]
    ["cmd_toggle"] = "Toggle the main window",
    ["cmd_transparency"] = "Toggle the basic transparency (0.5 or 1.0)",
    ["cmd_tooltip"] = "Toggle wether the button tooltips are shown or not",

--[[Pop UPs]]
   --[[General]]
   --[[ToolTips]]
    ["tt_ItemButton"] = "Toggle a popup with the function to search for items and manage your favorites.",
    ["tt_ItemSetButton"] = "Toggle a popup with the function to search for itemsets and manage your favorites.",
    ["tt_SpellButton"] = "Toggle a popup with the function to search for spells and manage your favorites.",
    ["tt_QuestButton"] = "Toggle a popup with the function to search for quests and manage your favorites.",
    ["tt_CreatureButton"] = "Toggle a popup with the function to search for creatures and manage your favorites.",
    ["tt_ObjectButton"] = "Toggle a popup with the function to search for objects and manage your favorites.",
    ["tt_SearchDefault"] = "Now you can enter a keyword and start the search.",
    ["tt_SkillButton"] = "Toggle a popup with the function to search for skills and manage your favorites.",
  --[[Labels]]
    ["ma_ItemButton"] = "Item-Search",
    ["ma_ItemSetButton"] = "ItemSet-Search",
    ["ma_SpellButton"] = "Spell-Search",
    ["ma_QuestButton"] = "Quest-Search",
    ["ma_CreatureButton"] = "Creature-Search",
    ["ma_ObjectButton"] = "Object-Search",
    ["ma_TeleSearchButton"] = "Teleport-Search",
    ["ma_MailRecipient"] = "Recipient",
    ["ma_Mail"] = "Send a Mail",
    ["ma_Send"] = "Send",
    ["ma_MailSubject"] = "Subject",
    ["ma_MailYourMsg"] = "Here your message!",
    ["ma_SearchButton"] = "Search...",
    ["ma_ResetButton"] = "Reset",
    ["ma_FavAdd"] = "Add selected",
    ["ma_FavRemove"] = "Remove selected",
    ["ma_SelectAllButton"] = "Select all",
    ["ma_DeselectAllButton"] = "Deselect all",
    ["ma_MailBytesLeft"] = "Bytes left: ",
    ["ma_SkillButton"] = "Skill-Search",
    ["ma_SkillVar1Button"] = "Skill",
    ["ma_SkillVar2Button"] = "Max Skill",
    ["ma_ItemVar1Button"] = "Amount",
    ["ma_ObjectVar1Button"] = "Loot Template",
    ["ma_ObjectVar2Button"] = "Spawn Time",
    ["ma_NoFavorites"] = "There are currently no saved favorites!",
    ["favoriteResults"] = "|cFF00FF00Favorites:|r ",
  
  
  
--[[Deprecated, but may be used again.]]  
    ["ma_Online"] = "Online",
    ["ma_Offline"] = "Offline",



--[[Linkifier]]
    ["lfer_Spawn"] = "Spawn",
    ["lfer_List"] = "List",
    ["lfer_Goto"] = "Goto",
    ["lfer_Move"] = "Move",
    ["lfer_Turn"] = "Turn",
    ["lfer_Delete"] = "Delete",
    ["lfer_Teleport"] = "Teleport",
    ["lfer_Morph"] = "Morph",
    ["lfer_Add"] = "Add",
    ["lfer_Remove"] = "Remove",
    ["lfer_Learn"] = "Learn",
    ["lfer_Unlearn"] = "Unlearn",
    ["lfer_Error"] = "Error Search String Matched but an error occured or unable to find type",
    
--[[New additions]]
}
end

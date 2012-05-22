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

function Return_deDE() 
  return {
--[[General]]
  --[[Tooltips]]
    ["ma_IconHint"] = "|cffeda55fKlick|r um TrinityAdmin zu öffnen. |cffeda55fShift-Klick|r um das Interface neu zuladen.",
    ["tt_Default"] = "Bewege deinen Mauszeiger über ein Tab für eine Erklärung!",
    ["tt_LanguageButton"] = "Ändert die Sprache und lädt TrinityAdmin neu.",
  --[[Control Labels]]
    ["ma_LanguageButton"] = "Change language",
    ["info_revision"] = "|cFF00FF00Trinity Revision:|r ",
    ["info_platform"] = "|cFF00FF00Server Platform:|r ",
    ["info_online"] = "|cFF00FF00Players Online:|r ",
    ["info_maxonline"] = "|cFF00FF00Maximum Online:|r ",
    ["info_uptime"] = "|cFF00FF00Uptime:|r ",
  --[[Other]]
["slashcmds"] = { "/trinityadmin", "/ta" },
    ["lang"] = "Deutsch",
    ["realm"] = "|cFF00FF00Realm:|r "..GetCVar("realmName"), --do not change this line!
    ["char"] = "|cFF00FF00Char:|r "..UnitName("player"), --do not change this line!
    ["guid"] = "|cFF00FF00Guid:|r ",
    ["tickets"] = "|cFF00FF00Tickets:|r ",
    ["selectionerror1"] = "Bitte wähle nur dich selbst, einen anderen Spieler oder nichts aus",
    ["selectionerror2"] = "Bitte wähle nur dich selbst oder nichts aus!",
    ["selectionerror3"] = "Bitte wähle nur einen anderen Spieler aus!",
    ["selectionerror4"] = "Bitte wähle nur einen NPC!",
    ["searchResults"] = "|cFF00FF00Suchergebnisse:|r ",

--[[Tickets Tab]]
  --[[Name]]
    ["tabmenu_Ticket"] = "Tickets",
    ["tt_TicketButton"] = "Wechselt das Fenster, zeigt dir alle Ticket und lääst sie dich verwalten.",
  --[[Tooltips]]
  --[[Control Labels]]
    ["ma_LoadTicketsButton"] = "Aktualisieren",
    ["ma_GetCharTicketButton"] = "Her holen",
    ["ma_GoCharTicketButton"] = "Gehe zu",
    ["ma_AnswerButton"] = "Brief",
    ["ma_DeleteButton"] = "Schließen",
    ["ma_TicketCount"] = "|cFF00FF00Tickets:|r ",
    ["ma_TicketsNoNew"] = "Keine neuen Tickets.",
    ["ma_TicketsNewNumber"] = "Du hast |cffeda55f%s|r neue Tickets!",
    ["ma_TicketsGoLast"] = "Gehe zum letzten Ticketersteller.",
    ["ma_TicketsGetLast"] = "Bringt %s zu dir.",
    ["ma_TicketsInfoPlayer"] = "|cFF00FF00Player:|r ",
    ["ma_TicketsInfoStatus"] = "|cFF00FF00Status:|r ",
    ["ma_TicketsInfoAccount"] = "|cFF00FF00Account:|r ",
    ["ma_TicketsInfoAccLevel"] = "|cFF00FF00Account-Level:|r ",
    ["ma_TicketsInfoLastIP"] = "|cFF00FF00Letzte IP:|r ",
    ["ma_TicketsInfoPlayedTime"] = "|cFF00FF00Gespielte Zeit:|r ",
    ["ma_TicketsInfoLevel"] = "|cFF00FF00Level:|r ",
    ["ma_TicketsInfoMoney"] = "|cFF00FF00Geld:|r ",
    ["ma_TicketsInfoLatency"] = "|cFF00FF00Latenz:|r ",
    ["ma_TicketsNoInfo"] = "Keine Info zur Verfügung",
    ["ma_TicketsNotLoaded"] = "Keine Tickets geladen...",
    ["ma_TicketsNoTickets"] = "Keine Tickets verfügbar!",
    ["ma_TicketTicketLoaded"] = "|cFF00FF00Geladen Ticket-Nr:|r %s\n\nPlayer Information\n\n",
    ["ma_Reload"] = "Neu laden",
    ["ma_LoadMore"] = "Mehr laden...",
    ["tt_TicketOn"] = "Kündige neue Tickets an.",
    ["tt_TicketOff"] = "Kündige keine neuen Tickets an.",
  --[[Other]]



--[[Misc Tab]]
  --[[Name]]
    ["tabmenu_Misc"] = "Misc",
    ["tt_MiscButton"] = "Wechselt zu dem Fenster mit Sonsitge Aktionen.",
  --[[Tooltips]]
    ["tt_FrmTrSlider"] = "Ändert Frame transparents.",
    ["tt_BtnTrSlider"] = "Ändert Tasten transparents.",
  --[[Control Labels]]
    ["cmd_toggle"] = "Wechselt zum Hauptmenü",
    ["cmd_transparency"] = "Wechselt zu der Standart transparents (0.5 ooder 1.0)",
    ["cmd_tooltip"] = "Ändert das Wetter",

--[[Pop UPs]]
   --[[General]]
   --[[ToolTips]]
    ["tt_ItemButton"] = "Öffnet ein Popup zum suchen von Items und verwaltet die Favoriten.",
    ["tt_ItemSetButton"] = "Öffnet ein Popup zum suchen von Items-Sets und verwaltet die Favoriten.",
    ["tt_SpellButton"] = "Öffnet ein Popup zum suchen von Zaubern und verwaltet die Favoriten.",
    ["tt_QuestButton"] = "Öffnet ein Popup zum suchen von Quests und verwaltet die Favoriten..",
    ["tt_CreatureButton"] = "Öffnet ein Popup zum suchen von NPCs und verwaltet die Favoriten.",
    ["tt_ObjectButton"] = "Öffnet ein Popup zum suchen von GameObjects und verwaltet die Favoriten.",
    ["tt_SearchDefault"] = "Jetzt kannst du ein Schlüsselwort eingeben und danach suchen.",
    ["tt_SkillButton"] = "Öffnet ein Popup zum suchen von Skills und verwaltet die Favoriten..",
  --[[Labels]]
    ["ma_ItemButton"] = "Item-Suche",
    ["ma_ItemSetButton"] = "ItemSet-Suche",
    ["ma_SpellButton"] = "Zauber-Suche",
    ["ma_QuestButton"] = "Quest-Suche",
    ["ma_CreatureButton"] = "NPC-Suche",
    ["ma_ObjectButton"] = "Object-Suche",
    ["ma_TeleSearchButton"] = "Teleport-Suche",
    ["ma_MailRecipient"] = "Empfänger",
    ["ma_Mail"] = "Sende eine Nachricht",
    ["ma_Send"] = "Senden",
    ["ma_MailSubject"] = "Betreff",
    ["ma_MailYourMsg"] = "Hier deine Nachricht!",
    ["ma_SearchButton"] = "Suche...",
    ["ma_ResetButton"] = "Löschen",
    ["ma_FavAdd"] = "Ausgewählte hinzufügen",
    ["ma_FavRemove"] = "Ausgewählte entfernen",
    ["ma_SelectAllButton"] = "Alle makieren",
    ["ma_DeselectAllButton"] = "Alle entmakieren",
    ["ma_MailBytesLeft"] = "Bytes übrig: ",
    ["ma_SkillButton"] = "Skill-Suche",
    ["ma_SkillVar1Button"] = "Skill",
    ["ma_SkillVar2Button"] = "Max Skill",
    ["ma_ItemVar1Button"] = "Menge",
    ["ma_ObjectVar1Button"] = "Loot Template",
    ["ma_ObjectVar2Button"] = "Spawn Zeit",
    ["ma_NoFavorites"] = "Es sind momentan keine Favoriten gespeichert!",
    ["favoriteResults"] = "|cFF00FF00Favoriten:|r ",
  
  
  
--[[Deprecated, but may be used again.]]  
    ["ma_Online"] = "Online",
    ["ma_Offline"] = "Offline",



--[[Linkifier]]
    ["lfer_Spawn"] = "Spawn",
    ["lfer_List"] = "List",
    ["lfer_Goto"] = "Gehe zu",
    ["lfer_Move"] = "Bewege",
    ["lfer_Turn"] = "Drehe",
    ["lfer_Delete"] = "Delete",
    ["lfer_Teleport"] = "Teleport",
    ["lfer_Morph"] = "Morph",
    ["lfer_Add"] = "Hinzufügen",
    ["lfer_Remove"] = "Entfernen",
    ["lfer_Learn"] = "Lern",
    ["lfer_Unlearn"] = "Vergesseb",
    ["lfer_Error"] = "Fehler, der Suchstring ist richtig aber ein Fehler ist aufgetreten oder es ist nicht möglich zu finden",
    
--[[New additions]]

   } 
end

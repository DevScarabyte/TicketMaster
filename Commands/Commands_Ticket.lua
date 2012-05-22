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
function ShowTicketTab()
  wipe(MangAdmin.db.account.buffer.tickets)
  ma_deleteticketbutton:Disable()
  ma_answerticketbutton:Disable()
  ma_getcharticketbutton:Disable()
  ma_gocharticketbutton:Disable()
  ma_whisperticketbutton:Disable()
  MangAdmin:InstantGroupToggle("ticket")
  ResetTickets()
end

function RefreshOnlineTickets()
    ma_ticketscrollframe:SetScript("OnVerticalScroll", InlineScrollUpdate(), function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset-1, 16, InlineScrollUpdate()) end)
    ma_ticketscrollframe:SetScript("OnShow", function() InlineScrollUpdate() end)
    MangAdmin.db.char.requests.ticket = true
    MangAdmin:ChatMsg(".ticket onlinelist")
    for i=1,12 do
       getglobal("ma_ticketscrollframe"..i):Hide()
    end
    getglobal("ma_showticketsbutton"):Hide()
    
end

function RefreshTickets()

    ma_ticketscrollframe:SetScript("OnVerticalScroll", InlineScrollUpdate(), function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset-1, 16, InlineScrollUpdate()) end)
    ma_ticketscrollframe:SetScript("OnShow", function() InlineScrollUpdate() end)
    MangAdmin.db.char.requests.ticket = true
    MangAdmin:ChatMsg(".ticket list")
    for i=1,12 do
       getglobal("ma_ticketscrollframe"..i):Hide()
    end
    getglobal("ma_showonlineticketsbutton"):Hide()
end

function ResetTickets()
    wipe(MangAdmin.db.account.buffer.tickets)
    wipe(MangAdmin.db.account.buffer.tickets)
    wipe(MangAdmin.db.account.buffer.tickets)
    MangAdmin.db.account.buffer.tickets = {}
    MangAdmin.db.account.buffer.tickets = {}
    MangAdmin.db.account.buffer.tickets = {}
    MangAdmin.db.char.requests.ticket = true
    for i=1,12 do
       getglobal("ma_ticketscrollframe"..i):Hide()
    end
    getglobal("ma_showticketsbutton"):Show()
    getglobal("ma_showonlineticketsbutton"):Show()
    
end

function ShowTickets()
 InlineScrollUpdate()
end


function Ticket(value)
  local ticket = MangAdmin.db.account.tickets.selected
  if value == "delete" then
    MangAdmin:ChatMsg(".ticket close "..ma_ticketid:GetText())
    wipe(MangAdmin.db.account.buffer.tickets)
    MangAdmin.db.account.buffer.tickets={}
    ShowTicketTab()
    ResetTickets()
  elseif value == "gochar" then
    MangAdmin:ChatMsg(".goname "..ma_ticketwho:GetText())
  elseif value == "getchar" then
    MangAdmin:ChatMsg(".namego "..ma_ticketwho:GetText())
  elseif value == "answer" then
    MangAdmin:TogglePopup("mail", {recipient = ma_ticketwho:GetText(), subject = "Ticket("..ma_ticketid:GetText()..")"})
    ma_maileditbox:SetText(ma_ticketdetail:GetText())
  elseif value == "whisper" then
	MangAdmin:ChatMsg(".gm chat on")
    ChatFrameEditBox:Show()
    ChatFrameEditBox:Insert("/w "..ma_ticketwho:GetText().." ");
  elseif value == "goticket" then
    MangAdmin:ChatMsg(".go ticket "..ma_ticketid:GetText())
  end
end

function InlineScrollUpdate()
    local ticketCount = 0
    table.foreachi(MangAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
    if ticketCount > 0 then
      ma_ticketscrollframe1:SetText("Loading")
      local lineplusoffset
      local line
      ma_ticketscrollframe:Show()
      FauxScrollFrame_Update(ma_ticketscrollframe,ticketCount,12,16);
      for line = 1,12 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_ticketscrollframe)
        if lineplusoffset <= ticketCount then
          local object = MangAdmin.db.account.buffer.tickets[lineplusoffset]
          if object then
            getglobal("ma_ticketscrollframe"..line):SetText("Id: |cffffffff"..object["tNumber"].."|r Who: |cffffffff"..object["tChar"].."|r When: |cffffffff"..object["tLCreate"].."|r")
            MangAdmin.db.account.tickets.selected = object
            ma_deleteticketbutton:Enable()
            ma_answerticketbutton:Enable()
            ma_getcharticketbutton:Enable()
            ma_gocharticketbutton:Enable()
            ma_whisperticketbutton:Enable()
            getglobal("ma_ticketscrollframe"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
            getglobal("ma_ticketscrollframe"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
            getglobal("ma_ticketscrollframe"..line):SetScript("OnClick", function() ReadTicket(object["tNumber"], object["tChar"]) end)
            getglobal("ma_ticketscrollframe"..line):Enable()
            getglobal("ma_ticketscrollframe"..line):Show()
          end
        else
          getglobal("ma_ticketscrollframe"..line):Hide()
        end
      end
    else
    end
end

function ReadTicket(tNumber, tChar)
     MangAdmin.db.char.requests.ticket = false
     ma_deleteticketbutton:Enable()
     ma_answerticketbutton:Enable()
     ma_getcharticketbutton:Enable()
     ma_gocharticketbutton:Enable()
     ma_whisperticketbutton:Enable()
    tNumber = string.match(tNumber, "%d+")
    MangAdmin:ChatMsg(".ticket viewid "..tNumber)
    ma_ticketid:SetText(tNumber)
    ma_ticketwho:SetText(tChar)
    local ticketdetail = MangAdmin.db.account.buffer.ticketsfull
end

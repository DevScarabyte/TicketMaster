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
--Convention:
-- MangAdmin:PrepareScript(*nameofbutton*     , Locale["*tooltiplocalisation*"]   , function() *functionnameandparameters()* end)


function InitControls()

--[[Tickets Tab]]
  MangAdmin:PrepareScript(ma_tabbutton_ticket     , Locale["tt_TicketButton"]       , function() ShowTicketTab() end)

  MangAdmin:PrepareScript(ma_resetticketsbutton   , "Not working? Click this, then click REFRESH!"      , function() ResetTickets() end)
  MangAdmin:PrepareScript(ma_showticketsbutton    , nil                             , function() RefreshTickets() end)
  MangAdmin:PrepareScript(ma_showonlineticketsbutton    , nil                             , function() RefreshOnlineTickets() end)
  MangAdmin:PrepareScript(ma_deleteticketbutton   , nil                             , function() Ticket("delete") end)
  MangAdmin:PrepareScript(ma_answerticketbutton   , nil                             , function() Ticket("answer") end)
  MangAdmin:PrepareScript(ma_getcharticketbutton  , nil                             , function() Ticket("getchar") end)
  MangAdmin:PrepareScript(ma_gocharticketbutton   , nil                             , function() Ticket("gochar") end)
  MangAdmin:PrepareScript(ma_whisperticketbutton  , nil                             , function() Ticket("whisper") end)
  MangAdmin:PrepareScript(ma_goticketbutton       , nil                             , function() Ticket("goticket") end)
  MangAdmin:PrepareScript(ma_showbutton           , nil                             , function() ShowTickets() end)

--[[Misc Tab]]
  MangAdmin:PrepareScript(ma_bgcolorshowbutton    , nil                             , function() ShowColorPicker("bg") end)
  MangAdmin:PrepareScript(ma_frmcolorshowbutton   , nil                             , function() ShowColorPicker("frm") end)
  MangAdmin:PrepareScript(ma_btncolorshowbutton   , nil                             , function() ShowColorPicker("btn") end)
  MangAdmin:PrepareScript(ma_linkifiercolorbutton , nil                             , function() ShowColorPicker("linkifier") end)
  MangAdmin:PrepareScript(ma_applystylebutton     , nil                             , function() ApplyStyleChanges() end)


end
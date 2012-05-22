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

-- Initializing dynamic frames with LUA and FrameLib
-- This script must be listed in the .toc after "MangFrames_Start.lua"
-- Also some variables are globally taken from MangAdmin.lua

function MangAdmin:CreateTabs()
  local transparency = {
    bg = MangAdmin.db.account.style.transparency.backgrounds,
    btn = MangAdmin.db.account.style.transparency.buttons,
    frm = MangAdmin.db.account.style.transparency.frames
  }
  local color = {
    bg = MangAdmin.db.account.style.color.backgrounds,
    btn = MangAdmin.db.account.style.color.buttons,
    frm = MangAdmin.db.account.style.color.frames
  }
  
  -- [[ Tab Buttons ]]

  FrameLib:BuildButton({
    name = "ma_tabbutton_ticket",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_ticket_texture",
      color = {color.bg.r, color.bg.g, color.bg.b, transparency.bg},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.bg.r, color.bg.g, color.bg.b, transparency.bg}
      }
    },
    size = {
      width = 55,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_menubgframe",
      relPos = "TOPLEFT",
      offX = 0,
      offY = -4
    },
    text = Locale["tabmenu_Ticket"]
  })

  FrameLib:BuildButton({
    name = "ma_tabbutton_misc",
    group = "tabbuttons",
    parent = ma_topframe,
    texture = {
      name = "ma_tabbutton_misc_texture",
      color = {color.bg.r, color.bg.g, color.bg.b, transparency.bg},
      gradient = {
        orientation = "vertical",
        min = {102,102,102,0},
        max = {color.bg.r, color.bg.g, color.bg.b, transparency.bg}
      }
    },
    size = {
      width = 45,
      height = 20
    },
    setpoint = {
      pos = "TOPLEFT",
      relTo = "ma_tabbutton_ticket",
      relPos = "TOPRIGHT",
      offX = 2
    },
    text = Locale["tabmenu_Misc"]
  })

  
end

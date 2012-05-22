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
-- This script must be listed in the .toc after "MangFrames_LookupButtons.lua"
-- Also some variables are globally taken from MangAdmin.lua

function MangAdmin:CreateSmallPopupFrames()
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
  
  -- [[popup2 Frame]]
  FrameLib:BuildFrame({
    name = "ma_popup2frame",
    group = "popup2",
    parent = UIParent,
    texture = {
      color = {color.bg.r, color.bg.g, color.bg.b, transparency.bg}
    },
    draggable = true,
    size = {
      width = 160,
      height = 260
    },
    setpoint = {
      pos = "CENTER"
    },
    frameStrata = "HIGH",
    inherits = nil
  })

  FrameLib:BuildFrame({
    name = "ma_popup2cframe",
    group = "popup2",
    parent = ma_popup2frame,
    texture = {
      color = {color.frm.r, color.frm.g, color.frm.b, transparency.frm}
    },
    size = {
      width = 156,
      height = 256
    },
    setpoint = {
      pos = "TOPLEFT",
      offY = -2,
      offX = 2
    },
    inherits = nil
  })

  FrameLib:BuildButton({
    name = "ma_popup2closebutton",
    group = "popup2",
    parent = ma_popup2cframe,
    texture = {
      name = "ma_popup2closebutton_texture",
      color = {color.btn.r, color.btn.g, color.btn.b, transparency.btn}
    },
    size = {
      width = 10,
      height = 10
    },
    setpoint = {
      pos = "TOPRIGHT",
      offX = -10,
      offY = -10
    },
    text = "X"
  })
  
  FrameLib:BuildFontString({
    name = "ma_tpinfo_text",
    group = "popup2",
    parent = ma_popup2cframe,
    text = "You should not see this text!",
    setpoint = {
      pos = "TOPLEFT",
      offX = 10,
      offY = -20
    }
  })
end

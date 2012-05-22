-- Author      : NowhereRx7
-- Create Date : 3/15/2009 8:26:46 PM

NotesFu = Rock:NewAddon("NotesFu", "LibFuBarPlugin-3.0", "LibRockEvent-1.0", "LibRockConfig-1.0", "LibRockDB-1.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local page = 1

NotesFu.text = "Notes"
NotesFu:SetFuBarOption('hasIcon', true)
NotesFu:SetFuBarOption('iconPath', [[Interface\FriendsFrame\FriendsFrameScrollIcon]])
NotesFu:SetFuBarOption('defaultPosition', "RIGHT")

NotesFu:SetDatabase("Fubar_NotesFu")
NotesFu:SetDatabaseDefaults("char", {})

function NotesFu:OnInitialize()
	self.version = GetAddOnMetadata("Fubar_NotesFu", "Version")
	local options = {
		name = "FuBar_NotesFu",
		desc = "Virtual sticky notes",
		type = "group",
		args = {},
	}
	NotesFu:SetConfigTable(options)
	self:AddEventListener("ADDON_LOADED", "AddonLoaded")
end

function NotesFu:AddonLoaded()
	local i
    if not NotesFu.db.account.page then
      NotesFu.page = 1
    else
      NotesFu.page = NotesFu.db.account.page
    end
	if not NotesFu.db.account.pages then
		NotesFu.db.account.pages = {}
		for i = 1, 100, 1 do
		  NotesFu.db.account.pages[i] = ""
		end
	end
	tinsert(UISpecialFrames,"NotesFuFrame")
end

function NotesFu:OnUpdateFuBarTooltip()
	GameTooltip:ClearLines()
	GameTooltip:AddLine("|cffffffffNotes|cff00ff00Fu|r")
	if NotesFu.db.account.pages[NotesFu.page] then
	    GameTooltip:AddLine( NotesFu.db.account.pages[NotesFu.page] )
	end
end

function NotesFu:OnFuBarClick()
	NotesFuFrame:Show()
end

function NotesFu:SaveFramePos()
	local point, relativeTo, relativePoint, x, y = NotesFuFrame:GetPoint()
	NotesFu.db.char.posX = x
	NotesFu.db.char.posY = y
	NotesFu.db.char.relP = relativePoint
end

function NotesFuFrame_OnShow()
	if NotesFu.db.char.relP then
		NotesFuFrame:ClearAllPoints()
		NotesFuFrame:SetPoint(NotesFu.db.char.relP, NotesFu.db.char.posX, NotesFu.db.char.posY)
	end
  	ShowPage()
end

function NotesFuFrame_OnHide()
	NotesFu.db.account.page = NotesFu.page
end

function btnClose_OnClick()
	NotesFuFrame:Hide()
end

function editNote_OnEscapePressed()
	editNote:ClearFocus()
end

function btnPrev_OnClick()
	if NotesFu.page > 1 then
		NotesFu.page = NotesFu.page - 1
	end
	ShowPage();
end

function btnNext_OnClick()
	if NotesFu.page < 100 then
		NotesFu.page = NotesFu.page + 1
	end
	ShowPage()
end

function ShowPage()
    if not NotesFu.db.account.pages[NotesFu.page] then
		NotesFu.db.account.pages[NotesFu.page] = ""
    end
    if not NotesFu.db.account.pages[NotesFu.page] then
		editNote:SetText("")
	else
		editNote:SetText( NotesFu.db.account.pages[NotesFu.page] )
	end
	fsPage:SetText( NotesFu.page )
	if NotesFu.page == 100 then
		btnNext:Disable()
	else
		btnNext:Enable()
	end
	if NotesFu.page == 1 then
		btnPrev:Disable()
	else
		btnPrev:Enable()
	end

end

function editNote_OnTextChanged()
	NotesFu.db.account.pages[NotesFu.page] = editNote:GetText():trim()
end

function Frame1_OnMouseUp()
	editNote:SetFocus()
end

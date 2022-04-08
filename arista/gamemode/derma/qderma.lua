-- Created by Trixter & Q2F2, named by Q2F2, inspired by Braxen's design

local matBlurScreen = Material("pp/blurscreen")

qderma = {}
qderma.colors = {
	titleBg = Color(102, 178, 250), // Main Menu Panel -- BS3621

	panelBg = Color(128,128,128), // Background of the main menu -- BS3621
	btnClr = Color(220, 220, 220, 255), // text of button below -- BS3621
	btnBg = Color(102, 178, 255), // buttons next to character tabs (change & Manafacture with stuff!) -- BS3621
	btnDisabled = Color(255, 255, 255), // Gender Tab on character customization -- BS3621
	btnHovered = Color(102, 178, 255),

	btnClose = Color(102, 178, 255), // Close button of the menu top right X -- BS3621
	btnCloseHovered = Color(210, 100, 100, 100), // colour of the ^ when you hover over the X

	collapClr = Color(102, 178, 250), // Officials , jobs section colour -- BS3621
	collapBg = Color(102, 178, 255),

	entryClr = Color(255, 255, 255), // Character customization tabs -- BS3621
	entryTextClr = Color(0, 0, 0), // Typing menu colour -- BS3621
	entrySelectionClr = Color(102, 178, 255), // Become Selection on charcter buttons -- BS3621
	entryCursorClr = Color(81, 45, 168), // Really unsure which this is? --BS3621

	sheetClr = Color(128, 128, 128), // Main menu tabs. Store, character etc.. -- BS3621
}

QFrame = {}

surface.CreateFont("QFrameTitle", {
	font = "Roboto Condensed",
	size = 16,
	weight = 400,
	blursize = 0,
	scanlines = 0,
	antialias = true
})

function QFrame:Init()
	self.m_fCreateTime = SysTime()

	self.lblTitle:SetFont("QFrameTitle")

	self.btnClose.lerp = 4
	self.btnClose.Paint = function(panel, w, h)
		panel.lerp = Lerp(FrameTime() * 10, panel.lerp, panel.Hovered and 21 or 4)
		surface.SetDrawColor(panel.Hovered and qderma.colors.btnCloseHovered or qderma.colors.btnClose)
		surface.DrawRect(1, 0, w - 1, panel.lerp)

		local posx, posy = self.btnClose:LocalToScreen(0, 0)

		render.SetScissorRect(posx, posy, posx + w, posy + panel.lerp, true)
			draw.SimpleText("r", "Marlett", w / 2, 10, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		render.SetScissorRect(0, 0, 0, 0, false)
	end

	self.btnMaxim:Remove()
	self.btnMinim:Remove()

	self.TitleBarHeight = 24
	self.IconSize = 16

	self:DockPadding(5, self.TitleBarHeight + 5, 5, 5)
end

local shade = Color(0, 0, 0, 240)
function QFrame:Paint(w, h)
	if self.m_bBackgroundBlur then
		Derma_DrawBackgroundBlur(self, self.m_fCreateTime)
	end

	local x, y = self:GetPos()

	surface.SetMaterial(matBlurScreen)
	surface.SetDrawColor(255, 255, 255, 255)

	for i = 1, 2 do
		matBlurScreen:SetFloat("$blur", i)
		matBlurScreen:Recompute()

		render.UpdateScreenEffectTexture()

		surface.DrawTexturedRect(-x, -y, ScrW(), ScrH())
	end

	surface.SetDrawColor(shade)
	surface.DrawRect(0, 0, w, h)

	surface.SetDrawColor(qderma.colors.titleBg)
	surface.DrawRect(0, 0, w, self.TitleBarHeight)
end

function QFrame:PerformLayout()
	local titlePush = 0

	if IsValid(self.imgIcon) then
		self.imgIcon:SetPos(self.TitleBarHeight - (self.IconSize * 1.25), self.TitleBarHeight - (self.IconSize * 1.25))
		self.imgIcon:SetSize(self.IconSize, self.IconSize)
		titlePush = self.IconSize + (self.IconSize / 10)
	end

	self.btnClose:SetPos(self:GetWide() - 31 - 4 + 1, 0)
	self.btnClose:SetSize(31, self.TitleBarHeight)

	self.lblTitle:SetPos(8 + titlePush, 14 / self.TitleBarHeight)
	self.lblTitle:SetSize(self:GetWide() - 25 - titlePush, self.TitleBarHeight)
end

vgui.Register("QFrame", QFrame, "DFrame")


QPanel = {}

function QPanel:Init()
end

function QPanel:Paint(w, h)
	surface.SetDrawColor(self.BGColor or qderma.colors.panelBg)
	surface.DrawRect(0, 0, w, h)
end

function QPanel:PerformLayout()
end

vgui.Register("QPanel", QPanel, "DPanel")


QButton = {}

function QButton:Init()
	self:SetColor(qderma.colors.btnClr)
	self:SetTall(22)
	self.BGColor = qderma.colors.btnBg
end

function QButton:Paint(w, h)
	if self.m_bDisabled then
		surface.SetDrawColor(self.BGColor or qderma.colors.panelBg)
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(qderma.colors.btnDisabled)
		surface.DrawRect(0, 0, w, h)

		self:SetCursor("pointer")
	else
		surface.SetDrawColor(self.BGColor or qderma.colors.panelBg)
		surface.DrawRect(0, 0, w, h)

		if self.Hovered then
			surface.SetDrawColor(qderma.colors.btnHovered)
			surface.DrawRect(0, 0, w, h)
		end
	end

	return false
end

function QButton:PlaySound()
	surface.PlaySound("buttons/button9.wav")
end

function QButton:PerformLayout()
end

vgui.Register("QButton", QButton, "DButton")


QCollapsibleCategory = {}

function QCollapsibleCategory:Init()
	self.BGColor = qderma.colors.collapBg
	self.Tall = 24
end

function QCollapsibleCategory:Paint(w, h)
	surface.SetDrawColor(qderma.colors.collapClr)
	surface.DrawRect(0, 0, w, 24)

	surface.SetDrawColor(qderma.colors.collapBg)
	surface.DrawRect(0, 24, w, h - 24)
end

vgui.Register("QCollapsibleCategory", QCollapsibleCategory, "DCollapsibleCategory")


QTextEntry = {}

function QTextEntry:Init()
end

function QTextEntry:Paint(w, h)
	surface.SetDrawColor(qderma.colors.entryClr)
	surface.DrawRect(0, 0, w, h)

	self:DrawTextEntryText(qderma.colors.entryTextClr, qderma.colors.entrySelectionClr, qderma.colors.entryCursorClr)
end

function QTextEntry:PerformLayout()
end

vgui.Register("QTextEntry", QTextEntry, "DTextEntry")


QPropertySheet = {}

function QPropertySheet:Init()
end

function QPropertySheet:Paint(w, h)
	surface.SetDrawColor(qderma.colors.panelBg)
	surface.DrawRect(0, 0, w, h)
end

function QPropertySheet:AddSheet(label, panel, material, NoStretchX, NoStretchY, Tooltip)
	if not IsValid(panel) then return end

	local Sheet = {}
	Sheet.Name = label

	Sheet.Tab = vgui.Create("DTab", self)
		Sheet.Tab:SetTooltip(Tooltip)
		Sheet.Tab:Setup(label, self, panel, material)

	Sheet.Panel = panel
		Sheet.Panel.NoStretchX = NoStretchX
		Sheet.Panel.NoStretchY = NoStretchY
		Sheet.Panel:SetPos(self:GetPadding(), 20 + self:GetPadding())
		Sheet.Panel:SetVisible(false)

	Sheet.Tab.Paint = function()

		surface.SetDrawColor(qderma.colors.sheetClr)
		surface.DrawRect(0, 0, self:GetWide(), 20)

	end

	Sheet.Panel.Paint = function()

		surface.SetDrawColor(qderma.colors.panelBg)
		surface.DrawRect(0, 0, self:GetWide(), self:GetTall())

	end

	panel:SetParent(self)

	table.insert(self.Items, Sheet)

	if not self:GetActiveTab() then
		self:SetActiveTab(Sheet.Tab)
		Sheet.Panel:SetVisible(true)
	end

	self.tabScroller:AddPanel(Sheet.Tab)

	return Sheet
end

vgui.Register("QPropertySheet", QPropertySheet, "DPropertySheet")

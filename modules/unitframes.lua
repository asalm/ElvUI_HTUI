local E, L, V, P, G = unpack(ElvUI)
local LSM = LibStub("LibSharedMedia-3.0");
local UF = E:GetModule("UnitFrames")
--local CT = E:GetModule("CustomTweaks")
--local isEnabled = E.private["unitframe"].enable and E.private["CustomTweaks"] and E.private["CustomTweaks"]["TargetHealthBarTexture"] and true or false

--Cache global variables
local _G = _G
local pairs = pairs
local twipe = table.wipe

---
-- GLOBALS: AceGUIWidgetLSMlists
---

--P["CustomTweaks"]["TargetHealthBarTexture"] = {
--	["HealthBarTexture"] = "ElvUI Norm",
--}

local UpdateStatusBars
local BuildTable
local healthbars = {}
local powerbars = {}
local castbars = {}
local statusBarTexture = LSM:Fetch("statusbar", "ElvUI I")
local units = {"Player", "Pet", "Target", "Focus", "Arena", "Boss"}


--local function ConfigTable()
--	E.Options.args.CustomTweaks.args.Unitframe.args.options.args.TargetHealthBarTexture = {
--		type = "group",
--		name = "TargetHealthBarTexture",
--		get = function(info) return E.db.CustomTweaks.TargetHealthBarTexture[info[#info]] end,
--		set = function(info, value) E.db.CustomTweaks.TargetHealthBarTexture[info[#info]] = value; BuildTable(); UpdateStatusBars() end,
--		args = {
--			healthstatusbar = {
--				order = 1,
--				type = "select", dialogControl = "LSM30_Statusbar",
--				name = L["HealthBar Texture"],
--				disabled = function() return not isEnabled end,
--				values = AceGUIWidgetLSMlists.statusbar,
--			},
--			apply_target = {
--				order = 2,
--				type = "toggle",
--				name = L["Target"],
--				disabled = function() return not isEnabled end,
--			},
--			apply_raid ={
--				order = 3,
--				type = "toggle",
--				name = L["Raid"],
--				disabled = function() return not isEnabled end,
--			}
--		},
--	}
--end
--CT.Configs["TargetHealthBarTexture"] = ConfigTable
--if not isEnabled then return; end
function BuildTablePower()
	twipe(powerbars)

	for _, unitName in pairs(UF.units) do
		local frameNameUnit = E:StringTitle(unitName)
		frameNameUnit = frameNameUnit:gsub("t(arget)", "T%1")
		
		local unitframe = _G["ElvUF_"..frameNameUnit]
		if unitframe and unitframe.Power then powerbars[unitframe.Power] = true end
	end
	
	for unit, unitgroup in pairs(UF.groupunits) do
		local frameNameUnit = E:StringTitle(unit)
		frameNameUnit = frameNameUnit:gsub("t(arget)", "T%1")
		
		local unitframe = _G["ElvUF_"..frameNameUnit]
		if (unitframe == "PLAYER") then
			if unitframe and unitframe.Power then powerbars[unitframe.Power] = true end
		end
	end
	
	for _, header in pairs(UF.headers) do
		for i = 1, header:GetNumChildren() do
			local group = select(i, header:GetChildren())
			--group is Tank/Assist Frames, but for Party/Raid we need to go deeper
			for j = 1, group:GetNumChildren() do
				--Party/Raid unitbutton
				local unitbutton = select(j, group:GetChildren())
				if unitbutton.Power then powerbars[unitbutton.Power] = true end
			end
		end
	end
end
function BuildCastbars(unit)

	if unit == "Player" or unit == "Target" then
		local unitframe = _G["ElvUF_"..unit]
		local castbar = unitframe and unitframe.Castbar 

		if castbar then
			castbar.Text:SetTextColor(1,1,1)
			castbar.Time:SetTextColor(1,1,1)
		end
	end
end
function BuildTableHealth()
	twipe(healthbars)

	for _, unitName in pairs(UF.units) do
		local frameNameUnit = E:StringTitle(unitName)
		frameNameUnit = frameNameUnit:gsub("t(arget)", "T%1")
		
		local unitframe = _G["ElvUF_"..frameNameUnit]
		if frameNameUnit == 'Target' then
		if unitframe and unitframe.Health then healthbars[unitframe.Health] = true end
		end
	end
end

BuildTableHealth()
BuildTablePower()

function Update()
	for healthbar in pairs(healthbars) do
		if healthbar and healthbar:GetObjectType() == "StatusBar" and not healthbar.isTransparent then
			healthbar:SetStatusBarTexture(statusBarTexture)
			healthbar.texture = statusBarTexture --Update .texture for oUF
		elseif healthbar and healthbar:GetObjectType() == "Texture" then
			healthbar:SetStatusBarTexture(statusBarTexture)
		end
	end

	for powerbar in pairs(powerbars) do
		if powerbar and powerbar:GetObjectType() == "StatusBar" and not powerbar.isTransparent then
			powerbar:SetStatusBarTexture(statusBarTexture)
			powerbar.texture = statusBarTexture --Update .texture for oUF
		elseif powerbar and powerbar:GetObjectType() == "Texture" then
			powerbar:SetStatusBarTexture(statusBarTexture)
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	for _, unit in pairs(units) do
		BuildCastbars(unit)
	end
end)

hooksecurefunc(UF, "Update_StatusBars", Update)
hooksecurefunc(UF, "CreateAndUpdateUF", Update)
hooksecurefunc(UF, "CreateAndUpdateUFGroup", Update)
hooksecurefunc(UF, "CreateAndUpdateHeaderGroup", Update)
hooksecurefunc(UF, "ForceShow", Update)
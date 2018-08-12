--Add access to ElvUI engine and unitframe framework
local E = unpack(ElvUI);
local ElvUF = ElvUI.oUF
assert(ElvUF, "ElvUI was unable to locate oUF.")

--isolated BlazeFlakes CustomTags stuff i needed, so people do not have to install all those plugins after installing my plugin.

ElvUF.Tags.Events['name:abbreviate'] = 'UNIT_NAME_UPDATE'
ElvUF.Tags.Methods['name:abbreviate'] = function(unit)
	local name = UnitName(unit)

	if name then
		name = name:gsub('(%S+) ', function(t) return t:sub(1,1)..'. ' end)
	end

	return name
end

ElvUF.Tags.Events['health:healer:short'] = "UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH"
ElvUF.Tags.Methods['health:healer:short'] = function(unit)
	local min, max = UnitHealth(unit), UnitHealthMax(unit)
	local per = math.floor(min/max*100)
	local hhshort
	if(per == 100) then
		hhshort = ""
	elseif(per >= 50) and (per < 75) then
		hhshort = "|cFFFFFFFF"..per.."|r"
	elseif(per >= 25) and (per < 50) then
		hhshort = "|cFFFFF05E"..per.."|r"
	elseif(per < 25) then
		hhshort = "|cffFF4545"..per.."|r"
	end
return hhshort
end
--Don't worry about this
local addon, ns = ...
local Version = GetAddOnMetadata(addon, "Version")

--Cache Lua / WoW API
local format = string.format
local GetCVarBool = GetCVarBool
local ReloadUI = ReloadUI
local StopMusic = StopMusic

-- These are things we do not cache
-- GLOBALS: PluginInstallStepComplete, PluginInstallFrame

--Change this line and use a unique name for your plugin.
local HTUI = "HealTree UI"

--Create references to ElvUI internals
local E, L, V, P, G = unpack(ElvUI)

--Create reference to LibElvUIPlugin
local EP = LibStub("LibElvUIPlugin-1.0")

--Create a new ElvUI module so ElvUI can handle initialization when ready
local mod = E:NewModule(HTUI, "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0");

--This function will hold your layout settings
local function SetupLayout(layout)
	--[[
	--	PUT YOUR EXPORTED PROFILE/SETTINGS BELOW HERE
	--]]

	--LAYOUT GOES HERE

	E.db["databars"]["artifact"]["reverseFill"] = true
	E.db["databars"]["artifact"]["height"] = 6
	E.db["databars"]["artifact"]["hideInCombat"] = true
	E.db["databars"]["artifact"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["artifact"]["width"] = 126
	E.db["databars"]["experience"]["height"] = 12
	E.db["databars"]["experience"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["experience"]["width"] = 130
	E.db["databars"]["honor"]["hideOutsidePvP"] = true
	E.db["databars"]["honor"]["height"] = 12
	E.db["databars"]["honor"]["hideInCombat"] = true
	E.db["databars"]["honor"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["honor"]["width"] = 130
	E.db["databars"]["reputation"]["reverseFill"] = true
	E.db["databars"]["reputation"]["height"] = 12
	E.db["databars"]["reputation"]["hideInCombat"] = true
	E.db["databars"]["reputation"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["reputation"]["width"] = 395
	E.db["databars"]["azerite"]["height"] = 12
	E.db["databars"]["azerite"]["orientation"] = "HORIZONTAL"
	E.db["databars"]["azerite"]["fontOutline"] = "OUTLINE"
	E.db["databars"]["azerite"]["width"] = 130
	E.db["currentTutorial"] = 3
	E.db["general"]["totems"]["enable"] = false
	E.db["general"]["totems"]["growthDirection"] = "HORIZONTAL"
	E.db["general"]["totems"]["size"] = 32
	E.db["general"]["totems"]["spacing"] = 3
	E.db["general"]["fontSize"] = 16
	E.db["general"]["afk"] = false
	E.db["general"]["autoRepair"] = "PLAYER"
	E.db["general"]["minimap"]["locationFont"] = "HaxrCorp12cyr"
	E.db["general"]["minimap"]["locationText"] = "HIDE"
	E.db["general"]["minimap"]["locationFontSize"] = 17
	E.db["general"]["minimap"]["icons"]["difficulty"]["position"] = "TOPRIGHT"
	E.db["general"]["minimap"]["icons"]["ticket"]["scale"] = 0.85
	E.db["general"]["minimap"]["icons"]["ticket"]["xOffset"] = -1
	E.db["general"]["minimap"]["icons"]["ticket"]["yOffset"] = -33
	E.db["general"]["minimap"]["icons"]["lfgEye"]["xOffset"] = 0
	E.db["general"]["minimap"]["icons"]["lfgEye"]["position"] = "TOPLEFT"
	E.db["general"]["minimap"]["icons"]["calendar"]["scale"] = 0.7
	E.db["general"]["minimap"]["icons"]["calendar"]["xOffset"] = -2
	E.db["general"]["minimap"]["icons"]["calendar"]["yOffset"] = -3
	E.db["general"]["minimap"]["icons"]["mail"]["xOffset"] = 0
	E.db["general"]["minimap"]["icons"]["mail"]["yOffset"] = 0
	E.db["general"]["minimap"]["icons"]["mail"]["scale"] = 0.7
	E.db["general"]["minimap"]["icons"]["mail"]["position"] = "BOTTOM"
	E.db["general"]["minimap"]["icons"]["challengeMode"]["yOffset"] = -15
	E.db["general"]["minimap"]["icons"]["classHall"]["scale"] = 0.7
	E.db["general"]["minimap"]["icons"]["classHall"]["position"] = "BOTTOMRIGHT"
	E.db["general"]["minimap"]["size"] = 165
	E.db["general"]["backdropfadecolor"]["a"] = 0.37000000476837
	E.db["general"]["backdropfadecolor"]["b"] = 0
	E.db["general"]["backdropfadecolor"]["g"] = 0
	E.db["general"]["backdropfadecolor"]["r"] = 0
	E.db["general"]["objectiveFrameHeight"] = 680
	E.db["general"]["loginmessage"] = false
	E.db["general"]["threat"]["enable"] = false
	E.db["general"]["stickyFrames"] = false
	E.db["general"]["backdropcolor"]["r"] = 0.10980392156863
	E.db["general"]["backdropcolor"]["g"] = 0.10980392156863
	E.db["general"]["backdropcolor"]["b"] = 0.10980392156863
	E.db["general"]["topPanel"] = false
	E.db["general"]["bordercolor"]["r"] = 0.070588235294118
	E.db["general"]["bordercolor"]["g"] = 0.070588235294118
	E.db["general"]["bordercolor"]["b"] = 0.070588235294118
	E.db["general"]["font"] = "Crescent-Regular"
	E.db["general"]["bonusObjectivePosition"] = "RIGHT"
	E.db["general"]["talkingHeadFrameScale"] = 0.7
	E.db["general"]["valuecolor"]["a"] = 1
	E.db["general"]["valuecolor"]["r"] = 0.95294117647059
	E.db["general"]["valuecolor"]["g"] = 0.76470588235294
	E.db["general"]["valuecolor"]["b"] = 0.11372549019608
	E.db["HealTree UI"]["install_version"] = "1.00"
	E.db["bossAuraFiltersConverted"] = true
	E.db["hideTutorial"] = true
	E.db["auras"]["countXOffset"] = -16
	E.db["auras"]["debuffs"]["countFontSize"] = 16
	E.db["auras"]["debuffs"]["verticalSpacing"] = 3
	E.db["auras"]["debuffs"]["durationFontSize"] = 16
	E.db["auras"]["debuffs"]["horizontalSpacing"] = 3
	E.db["auras"]["debuffs"]["maxWraps"] = 3
	E.db["auras"]["debuffs"]["wrapAfter"] = 4
	E.db["auras"]["debuffs"]["growthDirection"] = "RIGHT_DOWN"
	E.db["auras"]["fontOutline"] = "OUTLINE"
	E.db["auras"]["buffs"]["sortDir"] = "+"
	E.db["auras"]["buffs"]["wrapAfter"] = 6
	E.db["auras"]["buffs"]["horizontalSpacing"] = 1
	E.db["auras"]["buffs"]["seperateOwn"] = 0
	E.db["auras"]["buffs"]["durationFontSize"] = 16
	E.db["auras"]["buffs"]["verticalSpacing"] = 1
	E.db["auras"]["buffs"]["countFontSize"] = 24
	E.db["auras"]["buffs"]["growthDirection"] = "RIGHT_DOWN"
	E.db["auras"]["countYOffset"] = 10
	E.db["auras"]["timeYOffset"] = 12
	E.db["auras"]["font"] = "Crescent-Regular"
	E.db["layoutSet"] = "healer"
	E.db["thinBorderColorSet"] = true
	E.db["chat"]["useCustomTimeColor"] = false
	E.db["chat"]["fontSize"] = 12
	E.db["chat"]["emotionIcons"] = false
	E.db["chat"]["tabFont"] = "Friz Quadrata TT"
	E.db["chat"]["tabFontSize"] = 18
	E.db["chat"]["editBoxPosition"] = "ABOVE_CHAT"
	E.db["chat"]["panelTabTransparency"] = true
	E.db["chat"]["fontOutline"] = "OUTLINE"
	E.db["chat"]["panelWidthRight"] = 400
	E.db["chat"]["panelBackdrop"] = "HIDEBOTH"
	E.db["chat"]["separateSizes"] = true
	E.db["chat"]["font"] = "Friz Quadrata TT"
	E.db["chat"]["panelTabBackdrop"] = true
	E.db["chat"]["tabFontOutline"] = "OUTLINE"
	E.db["chat"]["panelHeight"] = 170
	E.db["chat"]["tapFontSize"] = 12
	E.db["chat"]["panelWidth"] = 411
	E.db["movers"]["SLE_DataPanel_1_Mover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-9,12"
	E.db["movers"]["RaidMarkerBarAnchor"] = "TOPLEFT,ElvUIParent,TOPLEFT,45,-442"
	E.db["movers"]["PetAB"] = "BOTTOM,ElvUIParent,BOTTOM,-270,164"
	E.db["movers"]["ElvUF_RaidMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1170,333"
	E.db["movers"]["LeftChatMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,30,48"
	E.db["movers"]["GMMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,433,-56"
	E.db["movers"]["BuffsMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,30,-30"
	E.db["movers"]["MinimapMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-30,48"
	E.db["movers"]["LocationMover"] = "TOP,ElvUIParent,TOP,-1,-4"
	E.db["movers"]["ElvUF_AssistMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,397,284"
	E.db["movers"]["BossButton"] = "BOTTOM,ElvUIParent,BOTTOM,-310,46"
	E.db["movers"]["LootFrameMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,258,320"
	E.db["movers"]["ZoneAbility"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-607,52"
	E.db["movers"]["PlayerPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,261"
	E.db["movers"]["RightChatMover"] = "TOPLEFT,ElvUIParent,TOPLEFT,0,-245"
	E.db["movers"]["TotemBarMover"] = "TOP,ElvUIParent,TOP,-97,-389"
	E.db["movers"]["ElvUF_RaidpetMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,4,736"
	E.db["movers"]["ElvUIBagMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-198,198"
	E.db["movers"]["SLE_UIButtonsMover"] = "TOP,ElvUIParent,TOP,0,-32"
	E.db["movers"]["ElvUF_FocusMover"] = "BOTTOM,ElvUIParent,BOTTOM,-284,405"
	E.db["movers"]["PvPMover"] = "TOP,ElvUIParent,TOP,0,-72"
	E.db["movers"]["ElvUF_PlayerCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,287"
	E.db["movers"]["ClassBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,274"
	E.db["movers"]["MicrobarMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,29,7"
	E.db["movers"]["OzCooldownsMover"] = "BOTTOM,ElvUIParent,BOTTOM,-10,169"
	E.db["movers"]["VehicleSeatMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-328,48"
	E.db["movers"]["ElvAB_6"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-28,13"
	E.db["movers"]["ExperienceBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-134,14"
	E.db["movers"]["HonorBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,-134,14"
	E.db["movers"]["ElvUF_TargetMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-449,386"
	E.db["movers"]["ElvUIBankMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,30,178"
	E.db["movers"]["LossControlMover"] = "BOTTOM,ElvUIParent,BOTTOM,2,482"
	E.db["movers"]["ElvUF_Raid40Mover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,339,862"
	E.db["movers"]["ElvUF_TargetTargetMover"] = "BOTTOM,ElvUIParent,BOTTOM,132,115"
	E.db["movers"]["ElvUF_PlayerMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,248"
	E.db["movers"]["ElvAB_1"] = "BOTTOM,ElvUIParent,BOTTOM,0,48"
	E.db["movers"]["ElvAB_2"] = "BOTTOM,ElvUIParent,BOTTOM,-9,0"
	E.db["movers"]["ArenaHeaderMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-494,0"
	E.db["movers"]["TalkingHeadFrameMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,30,236"
	E.db["movers"]["ElvAB_4"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-198,102"
	E.db["movers"]["AzeriteBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,132,14"
	E.db["movers"]["AltPowerBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,160"
	E.db["movers"]["ElvAB_3"] = "BOTTOM,ElvUIParent,BOTTOM,0,81"
	E.db["movers"]["ReputationBarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,15"
	E.db["movers"]["ArtifactBarMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-198,80"
	E.db["movers"]["ElvAB_5"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-28,13"
	E.db["movers"]["SLE_DataPanel_4_Mover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-359,1"
	E.db["movers"]["ObjectiveFrameMover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,-81,-25"
	E.db["movers"]["BNETMover"] = "BOTTOMLEFT,ElvUIParent,BOTTOMLEFT,30,202"
	E.db["movers"]["ShiftAB"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,901,30"
	E.db["movers"]["UIErrorsFrameMover"] = "TOP,ElvUIParent,TOP,-2,-149"
	E.db["movers"]["RaidUtility_Mover"] = "TOPLEFT,ElvUIParent,TOPLEFT,330,0"
	E.db["movers"]["ElvUF_TargetCastbarMover"] = "BOTTOM,ElvUIParent,BOTTOM,0,312"
	E.db["movers"]["TooltipMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-29,193"
	E.db["movers"]["ElvUF_TankMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,455,128"
	E.db["movers"]["BossHeaderMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-30,221"
	E.db["movers"]["ElvUF_PetMover"] = "BOTTOM,ElvUIParent,BOTTOM,-175,304"
	E.db["movers"]["ElvAB_7"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-254,60"
	E.db["movers"]["ElvUF_PartyMover"] = "TOPLEFT,ElvUIParent,BOTTOMLEFT,1170,333"
	E.db["movers"]["AlertFrameMover"] = "BOTTOMRIGHT,ElvUIParent,BOTTOMRIGHT,-295,414"
	E.db["movers"]["DebuffsMover"] = "TOP,ElvUIParent,TOP,163,-396"
	E.db["movers"]["SLE_DataPanel_2_Mover"] = "TOPRIGHT,ElvUIParent,TOPRIGHT,0,0"
	E.db["tooltip"]["fontSize"] = 12
	E.db["tooltip"]["healthBar"]["height"] = 4
	E.db["tooltip"]["healthBar"]["font"] = "Expressway"
	E.db["tooltip"]["healthBar"]["fontSize"] = 16
	E.db["tooltip"]["healthBar"]["text"] = false
	E.db["tooltip"]["headerFontSize"] = 14
	E.db["tooltip"]["font"] = "Friz Quadrata TT"
	E.db["tooltip"]["fontOutline"] = "OUTLINE"
	E.db["tooltip"]["guildRanks"] = false
	E.db["tooltip"]["playerTitles"] = false
	E.db["tooltip"]["spellID"] = false
	E.db["nameplates"]["fontSize"] = 16
	E.db["nameplates"]["useTargetGlow"] = false
	E.db["nameplates"]["nonTargetTransparency"] = 0.65
	E.db["nameplates"]["alwaysShowTargetHealth"] = false
	E.db["nameplates"]["lowHealthThreshold"] = 0.3
	E.db["nameplates"]["statusbar"] = "ElvUI Blank"
	E.db["nameplates"]["motionType"] = "OVERLAP"
	E.db["nameplates"]["clickThrough"]["personal"] = true
	E.db["nameplates"]["classbar"]["attachTo"] = "PLAYER"
	E.db["nameplates"]["classbar"]["position"] = "BELOW"
	E.db["nameplates"]["threat"]["useThreatColor"] = false
	E.db["nameplates"]["reactions"]["good"]["b"] = 0.15686274509804
	E.db["nameplates"]["reactions"]["good"]["g"] = 0.15294117647059
	E.db["nameplates"]["reactions"]["good"]["r"] = 0.15294117647059
	E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["numAuras"] = 6
	E.db["nameplates"]["units"]["ENEMY_NPC"]["debuffs"]["baseHeight"] = 19
	E.db["nameplates"]["units"]["ENEMY_NPC"]["healthbar"]["width"] = 120
	E.db["nameplates"]["units"]["ENEMY_NPC"]["buffs"]["enable"] = false
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["showLevel"] = false
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["healthbar"]["text"]["enable"] = true
	E.db["nameplates"]["units"]["FRIENDLY_NPC"]["healthbar"]["width"] = 125
	E.db["nameplates"]["units"]["FRIENDLY_PLAYER"]["showName"] = false
	E.db["nameplates"]["units"]["HEALER"]["healthbar"]["enable"] = false
	E.db["nameplates"]["units"]["HEALER"]["showName"] = false
	E.db["nameplates"]["units"]["PLAYER"]["healthbar"]["height"] = 6
	E.db["nameplates"]["units"]["PLAYER"]["healthbar"]["useClassColor"] = false
	E.db["nameplates"]["units"]["PLAYER"]["healthbar"]["width"] = 170
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["timeToHold"] = 0.2
	E.db["nameplates"]["units"]["PLAYER"]["castbar"]["hideSpellName"] = true
	E.db["nameplates"]["units"]["PLAYER"]["powerbar"]["height"] = 10
	E.db["nameplates"]["units"]["PLAYER"]["powerbar"]["text"]["enable"] = true
	E.db["nameplates"]["units"]["PLAYER"]["powerbar"]["text"]["format"] = "DEFICIT"
	E.db["nameplates"]["units"]["PLAYER"]["powerbar"]["hideWhenEmpty"] = true
	E.db["nameplates"]["units"]["PLAYER"]["buffs"]["filters"]["personal"] = false
	E.db["nameplates"]["units"]["PLAYER"]["visibility"]["showWithTarget"] = true
	E.db["nameplates"]["units"]["PLAYER"]["visibility"]["hideDelay"] = 5
	E.db["nameplates"]["font"] = "ElvUI B"
	E.db["nameplates"]["loadDistance"] = 60
	E.db["nameplates"]["displayStyle"] = "BLIZZARD"
	E.db["unitframe"]["fontSize"] = 16
	E.db["unitframe"]["healglow"] = false
	E.db["unitframe"]["smoothbars"] = true
	E.db["unitframe"]["units"]["pet"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["pet"]["width"] = 115
	E.db["unitframe"]["units"]["pet"]["name"]["xOffset"] = 2
	E.db["unitframe"]["units"]["pet"]["name"]["yOffset"] = 2
	E.db["unitframe"]["units"]["pet"]["height"] = 25
	E.db["unitframe"]["units"]["pet"]["castbar"]["height"] = 10
	E.db["unitframe"]["units"]["pet"]["castbar"]["width"] = 115
	E.db["unitframe"]["units"]["tank"]["enable"] = false
	E.db["unitframe"]["units"]["tank"]["colorOverride"] = "FORCE_ON"
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["height"] = 25
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["enable"] = false
	E.db["unitframe"]["units"]["tank"]["targetsGroup"]["width"] = 100
	E.db["unitframe"]["units"]["player"]["debuffs"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["debuffs"]["attachTo"] = "BUFFS"
	E.db["unitframe"]["units"]["player"]["classbar"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["player"]["classbar"]["autoHide"] = true
	E.db["unitframe"]["units"]["player"]["classbar"]["height"] = 12
	E.db["unitframe"]["units"]["player"]["classbar"]["detachedWidth"] = 180
	E.db["unitframe"]["units"]["player"]["classbar"]["additionalPowerText"] = false
	E.db["unitframe"]["units"]["player"]["aurabar"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["RestIcon"]["enable"] = false
	E.db["unitframe"]["units"]["player"]["health"]["xOffset"] = 4
	E.db["unitframe"]["units"]["player"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["threatStyle"] = "NONE"

	E.db["unitframe"]["units"]["player"]["customTexts"] = E.db["unitframe"]["units"]["player"]["customTexts"] or {}
	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"] = {}
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"] = {}
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"] = {}

	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"]["text_format"] = "[health:current]"
	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"]["yOffset"] = 0
	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"]["xOffset"] = 5
	E.db["unitframe"]["units"]["player"]["customTexts"]["HealthText"]["size"] = 16
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"]["attachTextTo"] = "Frame"
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"]["text_format"] = "[perpp][namecolor]%"
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"]["yOffset"] = 6
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"]["justifyH"] = "CENTER"
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"]["xOffset"] = 0
	E.db["unitframe"]["units"]["player"]["customTexts"]["PowerText"]["size"] = 24
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"]["attachTextTo"] = "Power"
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"]["enable"] = true
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"]["text_format"] = "||cFF77ab59[incomingheals]||r"
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"]["yOffset"] = 0
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"]["xOffset"] = 5
	E.db["unitframe"]["units"]["player"]["customTexts"]["incoming"]["size"] = 16
	E.db["unitframe"]["units"]["player"]["healPrediction"] = false
	E.db["unitframe"]["units"]["player"]["castbar"]["iconXOffset"] = -20
	E.db["unitframe"]["units"]["player"]["castbar"]["width"] = 180
	E.db["unitframe"]["units"]["player"]["castbar"]["insideInfoPanel"] = false
	E.db["unitframe"]["units"]["player"]["castbar"]["height"] = 22
	E.db["unitframe"]["units"]["player"]["castbar"]["iconYOffset"] = 36
	E.db["unitframe"]["units"]["player"]["castbar"]["icon"] = false
	E.db["unitframe"]["units"]["player"]["width"] = 180
	E.db["unitframe"]["units"]["player"]["power"]["attachTextTo"] = "Frame"
	E.db["unitframe"]["units"]["player"]["power"]["position"] = "CENTER"
	E.db["unitframe"]["units"]["player"]["power"]["height"] = 12
	E.db["unitframe"]["units"]["player"]["power"]["detachedWidth"] = 180
	E.db["unitframe"]["units"]["player"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["player"]["power"]["detachFromFrame"] = true
	E.db["unitframe"]["units"]["player"]["height"] = 12
	E.db["unitframe"]["units"]["player"]["buffs"]["numrows"] = 3
	E.db["unitframe"]["units"]["player"]["buffs"]["sizeOverride"] = 32
	E.db["unitframe"]["units"]["player"]["buffs"]["xOffset"] = -13
	E.db["unitframe"]["units"]["player"]["buffs"]["playerOnly"] = false
	E.db["unitframe"]["units"]["player"]["buffs"]["perrow"] = 4
	E.db["unitframe"]["units"]["player"]["buffs"]["attachTo"] = "FRAME"
	E.db["unitframe"]["units"]["player"]["buffs"]["sortMethod"] = "PLAYER"
	E.db["unitframe"]["units"]["player"]["buffs"]["fontSize"] = 16
	E.db["unitframe"]["units"]["player"]["buffs"]["yOffset"] = 294
	E.db["unitframe"]["units"]["player"]["CombatIcon"]["enable"] = false
	E.db["unitframe"]["units"]["focustarget"]["debuffs"]["enable"] = true
	E.db["unitframe"]["units"]["targettarget"]["power"]["height"] = 5
	E.db["unitframe"]["units"]["targettarget"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["targettarget"]["enable"] = false
	E.db["unitframe"]["units"]["targettarget"]["width"] = 125
	E.db["unitframe"]["units"]["targettarget"]["name"]["yOffset"] = 2
	E.db["unitframe"]["units"]["targettarget"]["height"] = 25
	E.db["unitframe"]["units"]["target"]["debuffs"]["fontSize"] = 16
	E.db["unitframe"]["units"]["target"]["debuffs"]["xOffset"] = 1
	E.db["unitframe"]["units"]["target"]["debuffs"]["perrow"] = 10
	E.db["unitframe"]["units"]["target"]["debuffs"]["attachTo"] = "HEALTH"
	E.db["unitframe"]["units"]["target"]["debuffs"]["sortMethod"] = "PLAYER"
	E.db["unitframe"]["units"]["target"]["debuffs"]["yOffset"] = 25
	E.db["unitframe"]["units"]["target"]["debuffs"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["target"]["debuffs"]["sizeOverride"] = 0
	E.db["unitframe"]["units"]["target"]["debuffs"]["clickThrough"] = true
	E.db["unitframe"]["units"]["target"]["portrait"]["yOffset"] = -0.04
	E.db["unitframe"]["units"]["target"]["portrait"]["camDistanceScale"] = 2.16
	E.db["unitframe"]["units"]["target"]["portrait"]["width"] = 36
	E.db["unitframe"]["units"]["target"]["smartAuraDisplay"] = "DISABLED"
	E.db["unitframe"]["units"]["target"]["aurabar"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["aurabar"]["height"] = 23
	E.db["unitframe"]["units"]["target"]["aurabar"]["maxBars"] = 4
	E.db["unitframe"]["units"]["target"]["aurabar"]["attachTo"] = "BUFFS"

	E.db["unitframe"]["units"]["target"]["customTexts"] = E.db["unitframe"]["units"]["target"]["customTexts"] or {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"] = {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"] = {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"] = {}
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"] = {}

	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"]["text_format"] = "[status][namecolor][name:abbreviate]"
	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"]["yOffset"] = 18
	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["NameText"]["size"] = 24
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"]["text_format"] = "[classificationcolor][target:medium]"
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"]["yOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"]["justifyH"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["ToT"]["size"] = 16
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"]["text_format"] = "[health:current] / [perhp][namecolor]%"
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"]["yOffset"] = 18
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"]["justifyH"] = "RIGHT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["HealthText"]["size"] = 24
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"]["enable"] = true
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"]["text_format"] = "[difficultycolor][smartlevel] [classification]"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"]["yOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"]["xOffset"] = 0
	E.db["unitframe"]["units"]["target"]["customTexts"]["Classifications"]["size"] = 16
	E.db["unitframe"]["units"]["target"]["health"]["xOffset"] = -4
	E.db["unitframe"]["units"]["target"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["width"] = 300
	E.db["unitframe"]["units"]["target"]["infoPanel"]["transparent"] = true
	E.db["unitframe"]["units"]["target"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["target"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["power"]["height"] = 8
	E.db["unitframe"]["units"]["target"]["name"]["xOffset"] = 8
	E.db["unitframe"]["units"]["target"]["name"]["yOffset"] = 1
	E.db["unitframe"]["units"]["target"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["target"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["target"]["height"] = 13
	E.db["unitframe"]["units"]["target"]["buffs"]["sizeOverride"] = 30
	E.db["unitframe"]["units"]["target"]["buffs"]["yOffset"] = -5
	E.db["unitframe"]["units"]["target"]["buffs"]["anchorPoint"] = "BOTTOMLEFT"
	E.db["unitframe"]["units"]["target"]["buffs"]["clickThrough"] = true
	E.db["unitframe"]["units"]["target"]["buffs"]["fontSize"] = 16
	E.db["unitframe"]["units"]["target"]["buffs"]["sortMethod"] = "PLAYER"
	E.db["unitframe"]["units"]["target"]["buffs"]["perrow"] = 10
	E.db["unitframe"]["units"]["target"]["castbar"]["height"] = 20
	E.db["unitframe"]["units"]["target"]["castbar"]["latency"] = false
	E.db["unitframe"]["units"]["target"]["castbar"]["icon"] = false
	E.db["unitframe"]["units"]["target"]["castbar"]["width"] = 180
	E.db["unitframe"]["units"]["boss"]["targetGlow"] = false
	E.db["unitframe"]["units"]["boss"]["debuffs"]["enable"] = false
	E.db["unitframe"]["units"]["boss"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["boss"]["castbar"]["width"] = 165
	E.db["unitframe"]["units"]["boss"]["rangeCheck"] = false
	E.db["unitframe"]["units"]["boss"]["portrait"]["overlay"] = true
	E.db["unitframe"]["units"]["boss"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["boss"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["boss"]["power"]["width"] = "spaced"
	E.db["unitframe"]["units"]["boss"]["width"] = 165
	E.db["unitframe"]["units"]["boss"]["name"]["xOffset"] = 6
	E.db["unitframe"]["units"]["boss"]["name"]["yOffset"] = 12
	E.db["unitframe"]["units"]["boss"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["boss"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["health"]["xOffset"] = -1
	E.db["unitframe"]["units"]["boss"]["health"]["yOffset"] = -11
	E.db["unitframe"]["units"]["boss"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["boss"]["health"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["boss"]["spacing"] = 43
	E.db["unitframe"]["units"]["boss"]["height"] = 13
	E.db["unitframe"]["units"]["boss"]["buffs"]["enable"] = false

	E.db["unitframe"]["units"]["boss"]["customTexts"] = E.db["unitframe"]["units"]["boss"]["customTexts"] or {}
	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"] = {}
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"] = {}



	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"]["enable"] = true
	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"]["text_format"] = "[namecolor][name:abbreviate]"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"]["yOffset"] = 18
	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"]["xOffset"] = 0
	E.db["unitframe"]["units"]["boss"]["customTexts"]["NameText"]["size"] = 24
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"]["enable"] = true
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"]["text_format"] = " [perhp][namecolor]%"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"]["yOffset"] = 18
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"]["justifyH"] = "RIGHT"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"]["xOffset"] = 0
	E.db["unitframe"]["units"]["boss"]["customTexts"]["HealthText"]["size"] = 24
	E.db["unitframe"]["units"]["boss"]["raidicon"]["enable"] = false
	E.db["unitframe"]["units"]["raid40"]["rdebuffs"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["raid40"]["growthDirection"] = "DOWN_RIGHT"
	E.db["unitframe"]["units"]["raid40"]["healPrediction"] = true
	E.db["unitframe"]["units"]["raid40"]["groupsPerRowCol"] = 4
	E.db["unitframe"]["units"]["raid40"]["health"]["frequentUpdates"] = true
	E.db["unitframe"]["units"]["raid40"]["height"] = 25
	E.db["unitframe"]["units"]["raid40"]["verticalSpacing"] = 2
	E.db["unitframe"]["units"]["raid40"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["focus"]["debuffs"]["anchorPoint"] = "TOPLEFT"
	E.db["unitframe"]["units"]["focus"]["debuffs"]["sizeOverride"] = 28
	E.db["unitframe"]["units"]["focus"]["debuffs"]["xOffset"] = 191
	E.db["unitframe"]["units"]["focus"]["debuffs"]["yOffset"] = -28
	E.db["unitframe"]["units"]["focus"]["debuffs"]["perrow"] = 1
	E.db["unitframe"]["units"]["focus"]["power"]["width"] = "inset"
	E.db["unitframe"]["units"]["focus"]["rangeCheck"] = false
	E.db["unitframe"]["units"]["focus"]["width"] = 220
	E.db["unitframe"]["units"]["focus"]["name"]["xOffset"] = 7
	E.db["unitframe"]["units"]["focus"]["name"]["yOffset"] = 6
	E.db["unitframe"]["units"]["focus"]["name"]["text_format"] = "[name:medium]"
	E.db["unitframe"]["units"]["focus"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["focus"]["castbar"]["width"] = 220
	E.db["unitframe"]["units"]["focus"]["height"] = 39
	E.db["unitframe"]["units"]["focus"]["health"]["xOffset"] = -4
	E.db["unitframe"]["units"]["focus"]["health"]["attachTextTo"] = "Frame"
	E.db["unitframe"]["units"]["focus"]["health"]["text_format"] = "[health:percent]"
	E.db["unitframe"]["units"]["focus"]["health"]["yOffset"] = 6
	E.db["unitframe"]["units"]["assist"]["enable"] = false
	E.db["unitframe"]["units"]["assist"]["targetsGroup"]["enable"] = false
	E.db["unitframe"]["units"]["raid"]["debuffs"]["sizeOverride"] = 16
	E.db["unitframe"]["units"]["raid"]["portrait"]["camDistanceScale"] = 1
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["enable"] = false
	E.db["unitframe"]["units"]["raid"]["rdebuffs"]["size"] = 22
	E.db["unitframe"]["units"]["raid"]["invertGroupingOrder"] = false
	E.db["unitframe"]["units"]["raid"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["raid"]["health"]["frequentUpdates"] = true
	E.db["unitframe"]["units"]["raid"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid"]["numGroups"] = 6
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["xOffset"] = -1
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["raid"]["roleIcon"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["raidWideSorting"] = false
	E.db["unitframe"]["units"]["raid"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["raid"]["power"]["enable"] = false

	E.db["unitframe"]["units"]["raid"]["customTexts"] = E.db["unitframe"]["units"]["raid"]["customTexts"] or {}
	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"] = {}
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"] = {}
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"] = {}


	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"]["enable"] = false
	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"]["text_format"] = "[namecolor][name:short]"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"]["font"] = "ElvUI B"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"]["justifyH"] = "LEFT"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["customTexts"]["NameText"]["size"] = 16
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"]["enable"] = false
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"]["text_format"] = "[mouseover][group]"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"]["font"] = "ElvUI B"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"]["justifyH"] = "RIGHT"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["customTexts"]["GroupID"]["size"] = 16
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"]["attachTextTo"] = "Health"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"]["enable"] = true
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"]["text_format"] = "[health:healer:short]"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"]["yOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"]["justifyH"] = "CENTER"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"]["xOffset"] = 0
	E.db["unitframe"]["units"]["raid"]["customTexts"]["healthPercent"]["size"] = 16
	E.db["unitframe"]["units"]["raid"]["healPrediction"] = true
	E.db["unitframe"]["units"]["raid"]["buffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["raid"]["width"] = 58
	E.db["unitframe"]["units"]["raid"]["name"]["text_format"] = ""
	E.db["unitframe"]["units"]["raid"]["startFromCenter"] = true
	E.db["unitframe"]["units"]["raid"]["height"] = 30
	E.db["unitframe"]["units"]["raid"]["verticalSpacing"] = 2
	E.db["unitframe"]["units"]["raid"]["growthDirection"] = "DOWN_RIGHT"
	E.db["unitframe"]["units"]["party"]["horizontalSpacing"] = 3
	E.db["unitframe"]["units"]["party"]["debuffs"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["debuffs"]["sizeOverride"] = 16
	E.db["unitframe"]["units"]["party"]["debuffs"]["priority"] = "Blacklist,Boss,RaidDebuffs,CCDebuffs,Dispellable"
	E.db["unitframe"]["units"]["party"]["debuffs"]["perrow"] = 3
	E.db["unitframe"]["units"]["party"]["portrait"]["camDistanceScale"] = 1
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["font"] = "Expressway"
	E.db["unitframe"]["units"]["party"]["rdebuffs"]["size"] = 22
	E.db["unitframe"]["units"]["party"]["colorOverride"] = "FORCE_OFF"
	E.db["unitframe"]["units"]["party"]["growthDirection"] = "DOWN_RIGHT"
	E.db["unitframe"]["units"]["party"]["orientation"] = "MIDDLE"
	E.db["unitframe"]["units"]["party"]["roleIcon"]["xOffset"] = -1
	E.db["unitframe"]["units"]["party"]["roleIcon"]["position"] = "RIGHT"
	E.db["unitframe"]["units"]["party"]["threatStyle"] = "NONE"
	E.db["unitframe"]["units"]["party"]["health"]["position"] = "BOTTOM"
	E.db["unitframe"]["units"]["party"]["health"]["xOffset"] = 0
	E.db["unitframe"]["units"]["party"]["health"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["health"]["yOffset"] = 2
	E.db["unitframe"]["units"]["party"]["healPrediction"] = true
	E.db["unitframe"]["units"]["party"]["buffs"]["sizeOverride"] = 20
	E.db["unitframe"]["units"]["party"]["buffs"]["useBlacklist"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["useFilter"] = "TurtleBuffs"
	E.db["unitframe"]["units"]["party"]["buffs"]["noDuration"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["playerOnly"] = false
	E.db["unitframe"]["units"]["party"]["buffs"]["perrow"] = 3
	E.db["unitframe"]["units"]["party"]["width"] = 128
	E.db["unitframe"]["units"]["party"]["infoPanel"]["height"] = 12
	E.db["unitframe"]["units"]["party"]["power"]["enable"] = false
	E.db["unitframe"]["units"]["party"]["power"]["position"] = "BOTTOMRIGHT"
	E.db["unitframe"]["units"]["party"]["power"]["text_format"] = ""
	E.db["unitframe"]["units"]["party"]["power"]["yOffset"] = 2
	E.db["unitframe"]["units"]["party"]["name"]["xOffset"] = 5
	E.db["unitframe"]["units"]["party"]["name"]["text_format"] = "[namecolor][name]"
	E.db["unitframe"]["units"]["party"]["name"]["position"] = "LEFT"
	E.db["unitframe"]["units"]["party"]["startFromCenter"] = true
	E.db["unitframe"]["units"]["party"]["height"] = 30
	E.db["unitframe"]["units"]["party"]["verticalSpacing"] = 2
	E.db["unitframe"]["OORAlpha"] = 0.25
	E.db["unitframe"]["font"] = "Crescent-Regular"
	E.db["unitframe"]["colors"]["colorhealthbyvalue"] = false
	E.db["unitframe"]["colors"]["health_backdrop"]["r"] = 0.79607843137255
	E.db["unitframe"]["colors"]["health_backdrop"]["g"] = 0
	E.db["unitframe"]["colors"]["health_backdrop"]["b"] = 0.10588235294118
	E.db["unitframe"]["colors"]["borderColor"]["b"] = 0.070588235294118
	E.db["unitframe"]["colors"]["borderColor"]["g"] = 0.070588235294118
	E.db["unitframe"]["colors"]["borderColor"]["r"] = 0.070588235294118
	E.db["unitframe"]["colors"]["auraBarByType"] = false
	E.db["unitframe"]["colors"]["power"]["MANA"]["r"] = 0.003921568627451
	E.db["unitframe"]["colors"]["power"]["MANA"]["g"] = 0.65098039215686
	E.db["unitframe"]["colors"]["power"]["MANA"]["b"] = 0.94509803921569
	E.db["unitframe"]["colors"]["power"]["FOCUS"]["b"] = 0.10588235294118
	E.db["unitframe"]["colors"]["power"]["FOCUS"]["g"] = 0.91764705882353
	E.db["unitframe"]["colors"]["power"]["FOCUS"]["r"] = 0.95294117647059
	E.db["unitframe"]["colors"]["power"]["ENERGY"]["b"] = 0.10588235294118
	E.db["unitframe"]["colors"]["power"]["ENERGY"]["g"] = 0.91764705882353
	E.db["unitframe"]["colors"]["power"]["ENERGY"]["r"] = 0.95294117647059
	E.db["unitframe"]["colors"]["power"]["LUNAR_POWER"]["r"] = 0.89019607843137
	E.db["unitframe"]["colors"]["power"]["LUNAR_POWER"]["g"] = 0.25490196078431
	E.db["unitframe"]["colors"]["power"]["LUNAR_POWER"]["b"] = 0.90196078431373
	E.db["unitframe"]["colors"]["power"]["RAGE"]["b"] = 0.07843137254902
	E.db["unitframe"]["colors"]["power"]["RAGE"]["g"] = 0.03921568627451
	E.db["unitframe"]["colors"]["power"]["RAGE"]["r"] = 0.96078431372549
	E.db["unitframe"]["colors"]["castColor"]["r"] = 0.78039215686274
	E.db["unitframe"]["colors"]["castColor"]["g"] = 0.6
	E.db["unitframe"]["colors"]["castColor"]["b"] = 0.13725490196078
	E.db["unitframe"]["colors"]["healPrediction"]["others"]["r"] = 0.32549019607843
	E.db["unitframe"]["colors"]["healPrediction"]["others"]["g"] = 0.89411764705882
	E.db["unitframe"]["colors"]["healPrediction"]["others"]["b"] = 1
	E.db["unitframe"]["colors"]["frameGlow"]["mouseoverGlow"]["color"]["a"] = 0.21000003814697
	E.db["unitframe"]["colors"]["frameGlow"]["mouseoverGlow"]["color"]["g"] = 0.054901960784314
	E.db["unitframe"]["colors"]["frameGlow"]["mouseoverGlow"]["color"]["b"] = 0.78823529411765
	E.db["unitframe"]["colors"]["frameGlow"]["mouseoverGlow"]["class"] = true
	E.db["unitframe"]["colors"]["frameGlow"]["mouseoverGlow"]["texture"] = "ElvUI I"
	E.db["unitframe"]["colors"]["tapped"]["r"] = 0.043137254901961
	E.db["unitframe"]["colors"]["tapped"]["g"] = 0.42745098039216
	E.db["unitframe"]["colors"]["tapped"]["b"] = 0.85098039215686
	E.db["unitframe"]["colors"]["reaction"]["GOOD"]["b"] = 0.3921568627451
	E.db["unitframe"]["colors"]["reaction"]["GOOD"]["r"] = 0.32941176470588
	E.db["unitframe"]["colors"]["auraBarDebuff"]["r"] = 0.28627450980392
	E.db["unitframe"]["colors"]["auraBarDebuff"]["g"] = 0.062745098039216
	E.db["unitframe"]["colors"]["auraBarDebuff"]["b"] = 0.13725490196078
	E.db["unitframe"]["colors"]["health"]["b"] = 0.31764705882353
	E.db["unitframe"]["colors"]["health"]["g"] = 0.30196078431373
	E.db["unitframe"]["colors"]["health"]["r"] = 0.30196078431373
	E.db["unitframe"]["colors"]["health_backdrop_dead"]["g"] = 0
	E.db["unitframe"]["colors"]["health_backdrop_dead"]["b"] = 0.34117647058824
	E.db["unitframe"]["fontOutline"] = "OUTLINE"
	E.db["unitframe"]["statusbar"] = "ElvUI Blank"
	E.db["unitframe"]["debuffHighlighting"] = "GLOW"
	E.db["datatexts"]["minimapPanels"] = false
	E.db["datatexts"]["fontSize"] = 14
	E.db["datatexts"]["goldFormat"] = "CONDENSED"
	E.db["datatexts"]["currencies"]["displayedCurrency"] = "ANCIENT_MANA"
	E.db["datatexts"]["panels"]["RightChatDataPanel"]["left"] = "Raid-DPS"
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["left"] = "System"
	E.db["datatexts"]["panels"]["LeftChatDataPanel"]["right"] = "Talented PvE"
	E.db["datatexts"]["panels"]["LeftMiniPanel"] = "Time"
	E.db["datatexts"]["panels"]["RightMiniPanel"] = "Gold"
	E.db["datatexts"]["panels"]["TopMiniPanel"] = "Attack Power"
	E.db["datatexts"]["panels"]["BottomRightMiniPanel"] = "Time"
	E.db["datatexts"]["panels"]["BottomLeftMiniPanel"] = "Time"
	E.db["datatexts"]["panels"]["TopLeftMiniPanel"] = "Intellect"
	E.db["datatexts"]["font"] = "Friz Quadrata TT"
	E.db["datatexts"]["battleground"] = false
	E.db["datatexts"]["fontOutline"] = "OUTLINE"
	E.db["datatexts"]["leftChatPanel"] = false
	E.db["datatexts"]["actionbar1"] = false
	E.db["datatexts"]["panelBackdrop"] = false
	E.db["datatexts"]["rightChatPanel"] = false
	E.db["actionbar"]["bar3"]["showGrid"] = false
	E.db["actionbar"]["bar3"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide;[combat]show;[resting]show; hide;"
	E.db["actionbar"]["bar3"]["alpha"] = 0.5
	E.db["actionbar"]["bar3"]["buttons"] = 12
	E.db["actionbar"]["bar3"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar3"]["backdropSpacing"] = 0
	E.db["actionbar"]["bar3"]["buttonspacing"] = 1
	E.db["actionbar"]["fontSize"] = 16
	E.db["actionbar"]["backdropSpacingConverted"] = true
	E.db["actionbar"]["desaturateOnCooldown"] = true
	E.db["actionbar"]["globalFadeAlpha"] = 0.5
	E.db["actionbar"]["cooldown"]["fonts"]["enable"] = true
	E.db["actionbar"]["cooldown"]["fonts"]["font"] = "Crescent-Regular"
	E.db["actionbar"]["cooldown"]["fonts"]["fontSize"] = 24
	E.db["actionbar"]["microbar"]["scale"] = 0.82
	E.db["actionbar"]["microbar"]["mouseover"] = true
	E.db["actionbar"]["microbar"]["backdrop"] = true
	E.db["actionbar"]["microbar"]["enabled"] = true
	E.db["actionbar"]["noRangeColor"]["b"] = 0.054901960784314
	E.db["actionbar"]["noRangeColor"]["g"] = 0.07843137254902
	E.db["actionbar"]["noRangeColor"]["r"] = 0.56078431372549
	E.db["actionbar"]["noPowerColor"]["r"] = 0.65490196078431
	E.db["actionbar"]["noPowerColor"]["g"] = 0.11764705882353
	E.db["actionbar"]["noPowerColor"]["b"] = 0.67058823529412
	E.db["actionbar"]["hideCooldownBling"] = true
	E.db["actionbar"]["bar2"]["buttonspacing"] = 1
	E.db["actionbar"]["bar2"]["mouseover"] = true
	E.db["actionbar"]["bar2"]["buttonsize"] = 30
	E.db["actionbar"]["bar2"]["backdropSpacing"] = 0
	E.db["actionbar"]["hotkeytext"] = false
	E.db["actionbar"]["bar5"]["enabled"] = false
	E.db["actionbar"]["bar5"]["point"] = "TOPRIGHT"
	E.db["actionbar"]["bar5"]["buttons"] = 4
	E.db["actionbar"]["bar5"]["buttonspacing"] = 1
	E.db["actionbar"]["bar5"]["buttonsize"] = 30
	E.db["actionbar"]["bar5"]["buttonsPerRow"] = 12
	E.db["actionbar"]["bar5"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide; [combat] show"
	E.db["actionbar"]["bar5"]["backdropSpacing"] = 1
	E.db["actionbar"]["lockActionBars"] = false
	E.db["actionbar"]["fontOutline"] = "OUTLINE"
	E.db["actionbar"]["font"] = "Crescent-Regular"
	E.db["actionbar"]["bar6"]["enabled"] = true
	E.db["actionbar"]["bar6"]["visibility"] = "[vehicleui] hide; [overridebar] hide; [petbattle] hide;"
	E.db["actionbar"]["bar6"]["flyoutDirection"] = "UP"
	E.db["actionbar"]["bar6"]["buttonspacing"] = 1
	E.db["actionbar"]["bar6"]["showGrid"] = false
	E.db["actionbar"]["bar6"]["buttonsize"] = 16
	E.db["actionbar"]["bar6"]["point"] = "TOPRIGHT"
	E.db["actionbar"]["bar1"]["inheritGlobalFade"] = true
	E.db["actionbar"]["bar1"]["showGrid"] = false
	E.db["actionbar"]["bar1"]["backdropSpacing"] = 0
	E.db["actionbar"]["bar1"]["buttonspacing"] = 1
	E.db["actionbar"]["stanceBar"]["inheritGlobalFade"] = true
	E.db["actionbar"]["stanceBar"]["style"] = "classic"
	E.db["actionbar"]["stanceBar"]["buttonspacing"] = 1
	E.db["actionbar"]["stanceBar"]["visibility"] = "[vehicleui] hide; [petbattle] hide;mouseover"
	E.db["actionbar"]["stanceBar"]["buttonsize"] = 23
	E.db["actionbar"]["barPet"]["backdrop"] = false
	E.db["actionbar"]["barPet"]["buttonsPerRow"] = 5
	E.db["actionbar"]["bar4"]["enabled"] = false
	E.db["actionbar"]["bar4"]["buttonsize"] = 30
	E.db["actionbar"]["bar4"]["buttonsPerRow"] = 4
	E.db["actionbar"]["bar4"]["mouseover"] = true
	E.db["actionbar"]["bar4"]["backdrop"] = false
	E.db["bags"]["countFontSize"] = 16
	E.db["bags"]["itemLevelFont"] = "ElvUI B"
	E.db["bags"]["itemLevelThreshold"] = 800
	E.db["bags"]["itemLevelFontSize"] = 16
	E.db["bags"]["sortInverted"] = false
	E.db["bags"]["disableBankSort"] = true
	E.db["bags"]["junkIcon"] = true
	E.db["bags"]["countFont"] = "ElvUI B"
	E.db["bags"]["clearSearchOnClose"] = true
	E.db["bags"]["countFontOutline"] = "OUTLINE"
	E.db["bags"]["itemLevelFontOutline"] = "OUTLINE"
	E.db["bags"]["currencyFormat"] = "ICON"
	E.db["bags"]["useTooltipScanning"] = true
	E.db["bags"]["moneyFormat"] = "CONDENSED"
	
	
	

	--[[
		--If you want to modify the base layout according to
		-- certain conditions then this is how you could do it
		if layout == "tank" then
			--Make some changes to the layout posted above
		elseif layout == "dps" then
			--Make some other changes
		elseif layout == "healer" then
			--Make some different changes
		end
	--]]


	--[[
	--	This section at the bottom is just to update ElvUI and display a message
	--]]
	--Update ElvUI
	E:UpdateAll(true)
	--Show message about layout being set
	PluginInstallStepComplete.message = "Layout Set"
	PluginInstallStepComplete:Show()
end

--This function is executed when you press "Skip Process" or "Finished" in the installer.
local function InstallComplete()
	if GetCVarBool("Sound_EnableMusic") then
		StopMusic()
	end

	--Set a variable tracking the version of the addon when layout was installed
	E.db[HTUI].install_version = Version

	ReloadUI()
end

--This is the data we pass on to the ElvUI Plugin Installer.
--The Plugin Installer is reponsible for displaying the install guide for this layout.
local InstallerData = {
	Title = format("|cff4beb2c%s %s|r", HTUI, "Installation"),
	Name = HTUI,
	--tutorialImage = "Interface\\AddOns\\MyAddOn\\logo.tga", --If you have a logo you want to use, otherwise it uses the one from ElvUI
	Pages = {
		[1] = function()
			PluginInstallFrame.SubTitle:SetFormattedText("Welcome to the installation for %s.", HTUI)
			PluginInstallFrame.Desc1:SetText("This installation process will guide you through a few steps and apply settings to your current ElvUI profile. If you want to be able to go back to your original settings then create a new profile before going through this installation process.")
			PluginInstallFrame.Desc2:SetText("Please press the continue button if you wish to go through the installation process, otherwise click the 'Skip Process' button.")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
			PluginInstallFrame.Option1:SetText("Skip Process")
		end,
		[2] = function()
			PluginInstallFrame.SubTitle:SetText("Layouts")
			PluginInstallFrame.Desc1:SetText("These are the layouts that are available. Please click a button below to apply the layout of your choosing.")
			PluginInstallFrame.Desc2:SetText("Importance: |cff07D400High|r")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SetupLayout("tank") end)
			PluginInstallFrame.Option1:SetText("Tank")
			PluginInstallFrame.Option2:Show()
			PluginInstallFrame.Option2:SetScript("OnClick", function() SetupLayout("healer") end)
			PluginInstallFrame.Option2:SetText("Healer")
			PluginInstallFrame.Option3:Show()
			PluginInstallFrame.Option3:SetScript("OnClick", function() SetupLayout("dps") end)
			PluginInstallFrame.Option3:SetText("DPS")
		end,
		[3] = function()
			PluginInstallFrame.SubTitle:SetText("Installation Complete")
			PluginInstallFrame.Desc1:SetText("You have completed the installation process.")
			PluginInstallFrame.Desc2:SetText("Please click the button below in order to finalize the process and automatically reload your UI.")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", InstallComplete)
			PluginInstallFrame.Option1:SetText("Finished")
		end,
	},
	StepTitles = {
		[1] = "Welcome",
		[2] = "Layouts",
		[3] = "Installation Complete",
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {0, 179/255, 1},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 180,
	StepTitleTextJustification = "RIGHT",
}

--This function holds the options table which will be inserted into the ElvUI config
local function InsertOptions()
	E.Options.args.HTUI = {
		order = 100,
		type = "group",
		name = format("|cffFFF05E%s|r", HTUI),
		args = {
			header1 = {
				order = 1,
				type = "header",
				name = HTUI,
			},
			description1 = {
				order = 2,
				type = "description",
				name = format("%s is a layout for ElvUI.", HTUI),
			},
			spacer1 = {
				order = 3,
				type = "description",
				name = "\n\n\n",
			},
			header2 = {
				order = 4,
				type = "header",
				name = "Installation",
			},
			description2 = {
				order = 5,
				type = "description",
				name = "The installation guide should pop up automatically after you have completed the ElvUI installation. If you wish to re-run the installation process for this layout then please click the button below.",
			},
			spacer2 = {
				order = 6,
				type = "description",
				name = "",
			},
			install = {
				order = 7,
				type = "execute",
				name = "Install",
				desc = "Run the installation process.",
				func = function() E:GetModule("PluginInstaller"):Queue(InstallerData); E:ToggleConfig(); end,
			},
			spacer3 = {
				order = 8,
				type = "description",
				name = 	"\n\n",
			},
			header3 = {
				order = 9,
				type = "header",
				name = "Features",
			},
			toggle1 = {
				order = 10,
				desc = 'enables / disables custom health/powerbars on Units Player/Target',
				type = 'toggle',
				name = "Custom Statusbars",
			}
		},
	}
end

--Create a unique table for our plugin
P[HTUI] = {}

--This function will handle initialization of the addon
function mod:Initialize()
	--Initiate installation process if ElvUI install is complete and our plugin install has not yet been run
	if E.private.install_complete and E.db[HTUI].install_version == nil then
		E:GetModule("PluginInstaller"):Queue(InstallerData)
	end
	
	--Insert our options table when ElvUI config is loaded
	EP:RegisterPlugin(addon, InsertOptions)
end

--This function will get called by ElvUI automatically when it is ready to initialize modules
local function CallbackInitialize()
	mod:Initialize()
end

--Register module with callback so it gets initialized when ready
E:RegisterModule(HTUI, CallbackInitialize)
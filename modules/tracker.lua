local E, L, V, P, G = unpack(ElvUI)
local LSM = LibStub("LibSharedMedia-3.0")
local QuestListEnhanced = E:NewModule('QuestListEnhanced', 'AceHook-3.0', 'AceEvent-3.0', 'AceTimer-3.0');
local _G = _G


-- Headers
local function SetBlockHeader_hook()

	for i = 1, GetNumQuestWatches() do
		local questID, title, questLogIndex, numObjectives, requiredMoney, isComplete, startEvent, isAutoComplete, failureTime, timeElapsed, questType, isTask, isStory, isOnMap, hasLocalPOI = GetQuestWatchInfo(i)
		if ( not questID ) then
			break
		end
		local oldBlock = QUEST_TRACKER_MODULE:GetExistingBlock(questID)
		if oldBlock then
			local oldHeight = QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, title, nil, OBJECTIVE_TRACKER_COLOR["Header"])
			local newTitle = title

			local newHeight = QUEST_TRACKER_MODULE:SetStringText(oldBlock.HeaderText, newTitle, nil, OBJECTIVE_TRACKER_COLOR["Header"])
		end
	end
end

-- Header - Elements
local function QuestInfo_hook(template, parentFrame, acceptButton, material, mapView)

	local elementsTable = template.elements
	for i = 1, #elementsTable, 3 do
		if elementsTable[i] == QuestInfo_ShowTitle then
			if QuestInfoFrame.questLog then
				local questLogIndex = GetQuestLogSelection()
				local level = select(2, GetQuestLogTitle(questLogIndex))
				local newTitle = "["..level.."] "..QuestInfoTitleHeader:GetText()
				QuestInfoTitleHeader:SetText(newTitle)
			end
		end
	end
end

function QuestListEnhanced:Initialize()

	local trackerWidth = 240
	local vm = ObjectiveTrackerFrame

	local r, g, b = 103/255, 103/255, 103/255
	local class = select(2, UnitClass("player"))
	local colour = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
	hooksecurefunc(QUEST_TRACKER_MODULE, "SetBlockHeader", function(_, block)
		local fontname = "Big Noodle Tilting"
		local fontsize = 16
		local fontflag = "OUTLINE"

		block.HeaderText:SetFont(LSM:Fetch('font', fontname), fontsize, fontflag)

		block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)

		block.HeaderText:SetJustifyH("Left")
		block.HeaderText:SetWidth(trackerWidth)
		local heightcheck = block.HeaderText:GetNumLines()      
		if heightcheck == 2 then
			local height = block:GetHeight()   
			block:SetHeight(height + 2)
		end

		fontname = "Fritz Quadrata TT"
		fontsize = 12
		fontflag = "OUTLINE"

		for objectiveKey, line in pairs(block.lines) do
			line.Text:SetFont(LSM:Fetch('font', fontname), fontsize, fontflag)
		end
	end)

	local function hoverquest(_, block)
	    block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
	end
	  
	local function hoverachieve( _, block)
		block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
	end

	hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "SetBlockHeader", function(_, block)
	    local trackedAchievements = {GetTrackedAchievements()}
	    
	    for i = 1, #trackedAchievements do
		    local achieveID = trackedAchievements[i]
		    local _, achievementName, _, completed, _, _, _, description, _, icon, _, _, wasEarnedByMe = GetAchievementInfo(achieveID)
	        
		    if  (not wasEarnedByMe) or (not GetAchievementCategory(achieveID)~=ARENA_CATEGORY) then return end
   
	        if showAchievement then
	            block.HeaderText:SetFont(LSM:Fetch('font', "Big Noodle Tilting"),  13,"OUTLINE")
	            --block.HeaderText:SetShadowOffset(.7, -.7)
	            --block.HeaderText:SetShadowColor(0, 0, 0, 1)
				block.HeaderText:SetTextColor(colour.r, colour.g, colour.b)
				
	            block.HeaderText:SetJustifyH("Left")
	            block.HeaderText:SetWidth(trackerWidth)
	        end
	    end
	end)

		hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderEnter", hoverquest)  
		hooksecurefunc(QUEST_TRACKER_MODULE, "OnBlockHeaderLeave", hoverquest)
		hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderEnter", hoverachieve)
		hooksecurefunc(ACHIEVEMENT_TRACKER_MODULE, "OnBlockHeaderLeave", hoverachieve)
	
	hooksecurefunc(QUEST_TRACKER_MODULE, "Update", SetBlockHeader_hook)
	hooksecurefunc("QuestInfo_Display", QuestInfo_hook)

		_G["ObjectiveTrackerFrame"].HeaderMenu.Title:Hide()
		_G["ObjectiveTrackerBlocksFrame"].QuestHeader.Text:Hide()
		hooksecurefunc("ObjectiveTracker_Collapse", function() _G["ObjectiveTrackerFrame"].HeaderMenu.Title:Hide() end)
		hooksecurefunc("ObjectiveTracker_Expand", function() _G["ObjectiveTrackerBlocksFrame"].QuestHeader.Text:Hide() end)
		
end

E:RegisterModule(QuestListEnhanced:GetName())
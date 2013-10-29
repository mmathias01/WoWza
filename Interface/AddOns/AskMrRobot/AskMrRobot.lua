local _, AskMrRobot = ...

AskMrRobot.eventListener = CreateFrame("FRAME"); -- Need a frame to respond to events
AskMrRobot.eventListener:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
AskMrRobot.eventListener:RegisterEvent("ITEM_PUSH");
AskMrRobot.eventListener:RegisterEvent("DELETE_ITEM_CONFIRM");
AskMrRobot.eventListener:RegisterEvent("UNIT_INVENTORY_CHANGED");
AskMrRobot.eventListener:RegisterEvent("BANKFRAME_OPENED");
AskMrRobot.eventListener:RegisterEvent("BANKFRAME_CLOSED");
AskMrRobot.eventListener:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
AskMrRobot.eventListener:RegisterEvent("CHARACTER_POINTS_CHANGED");
AskMrRobot.eventListener:RegisterEvent("CONFIRM_TALENT_WIPE");
AskMrRobot.eventListener:RegisterEvent("PLAYER_TALENT_UPDATE");
AskMrRobot.eventListener:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
AskMrRobot.eventListener:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
AskMrRobot.eventListener:RegisterEvent("PLAYER_LEVEL_UP");
--AskMrRobot.eventListener:RegisterEvent("GET_ITEM_INFO_RECEIVED")
AskMrRobot.eventListener:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
AskMrRobot.eventListener:RegisterEvent("SOCKET_INFO_UPDATE")
AskMrRobot.eventListener:RegisterEvent("SOCKET_INFO_CLOSE")
AskMrRobot.eventListener:RegisterEvent("BAG_UPDATE")
AskMrRobot.eventListener:RegisterEvent("ITEM_UNLOCKED")

AskMrRobot.AddonName = ...

local amrLDB
local icon
local reforgequeue
local reforgeFrame = nil
AskMrRobot.itemDiffs = {
	items = {},    -- slotNum -> nil (no change) or current <item id>, optimized <item id>
	enchants = {}, -- slotNum -> nil (no change) or current <enchant id>, optimized <enchant id>
	gems = {},     -- slotNum -> nil (no change) or ?
	reforges = {}   -- slotNum -> nil (no change) or current <reforge id>, optimized <reforge id>
}

-- upgrade id -> upgrade level
local upgradeTable = {
  [0]   =  0,
  [1]   =  1, -- 1/1 -> 8
  [373] =  1, -- 1/2 -> 4
  [374] =  2, -- 2/2 -> 8
  [375] =  1, -- 1/3 -> 4
  [376] =  2, -- 2/3 -> 4
  [377] =  3, -- 3/3 -> 4
  [378] =  1, -- 1/1 -> 7
  [379] =  1, -- 1/2 -> 4
  [380] =  2, -- 2/2 -> 4
  [445] =  0, -- 0/2 -> 0
  [446] =  1, -- 1/2 -> 4
  [447] =  2, -- 2/2 -> 8
  [451] =  0, -- 0/1 -> 0
  [452] =  1, -- 1/1 -> 8
  [453] =  0, -- 0/2 -> 0
  [454] =  1, -- 1/2 -> 4
  [455] =  2, -- 2/2 -> 8
  [456] =  0, -- 0/1 -> 0
  [457] =  1, -- 1/1 -> 8
  [458] =  0, -- 0/4 -> 0
  [459] =  1, -- 1/4 -> 4
  [460] =  2, -- 2/4 -> 8
  [461] =  3, -- 3/4 -> 12
  [462] =  4, -- 4/4 -> 16
  [465] =  0, -- 0/2 -> 0
  [466] =  1, -- 1/2 -> 4
  [467] =  2, -- 2/2 -> 8
  [468] =  0, -- 0/4 -> 0
  [469] =  1, -- 1/4 -> 4
  [470] =  2, -- 2/4 -> 8
  [471] =  3, -- 3/4 -> 12
  [472] =  4, -- 4/4 -> 16
  [476] =  0, -- ? -> 0
  [479] =  0, -- ? -> 0
  [491] =  0, -- ? -> 0
  [492] =  1, -- ? -> 0
  [493] =  2 -- ? -> 0
}

function AskMrRobot.eventListener:OnEvent(event, arg1, arg2)
	if event == "ADDON_LOADED" and arg1 == "AskMrRobot" then
		print("Loaded Ask Mr. Robot " .. GetAddOnMetadata(AskMrRobot.AddonName, "Version"))
		AmrRealmName = GetRealmName()
		AmrCharacterName = UnitName("player")


		if not AmrIconInfo then AmrIconInfo = {} end
		if not AmrBankItems then AmrBankItems = {} end
		if not AmrCurrencies then AmrCurrencies = {} end
		if not AmrSpecializations then AmrSpecializations = {} end
		if not AmrOptions then AmrOptions = {} end
		if not AmrGlyphs then AmrGlyphs = {} end
		if not AmrTalents then AmrTalents = {} end
		if not AmrBankItemsAndCounts then AmrBankItemsAndCounts = {} end
		if not AmrImportString then AmrImportString = "" end
		if not AmrImportDate then AmrImportDate = "" end
		if not AmrSendSettings then
			AmrSendSettings = {
				SendGems = true,
				SendEnchants = true,
				SendEnchantMaterials = true,
				SendToType = "a friend",
				SendTo = ""
			}
		end

		amrLDB = LibStub("LibDataBroker-1.1"):NewDataObject("AskMrRobot", {
			type = "launcher",
			text = "Ask Mr. Robot",
			icon = "Interface\\AddOns\\AskMrRobot\\Media\\icon",
			OnClick = function()

				if IsModifiedClick("CHATLINK") then
					AskMrRobot.SaveAll()
				else
					AskMrRobot_ReforgeFrame:Toggle()
				end
			end,
			OnTooltipShow = function(tt)
				tt:AddLine("Ask Mr. Robot", 1, 1, 1);
				tt:AddLine(" ");
				tt:AddLine("Left Click to open the Ask Mr. Robot window.\n\nShift + Left Click to save your bag and bank data.")
			end	
		});


		AskMrRobot.AmrUpdateMinimap()

		AskMrRobot_ReforgeFrame = AskMrRobot.AmrUI:new()

		-- remember the import settings between sessions
		AskMrRobot_ReforgeFrame.importTab.scrollFrame.EditBox:SetText(AmrImportString or "")
		AskMrRobot_ReforgeFrame:OnUpdate()
		AskMrRobot_ReforgeFrame.summaryTab.importDate = AmrImportDate or ""
		AskMrRobot_ReforgeFrame.buttons[2]:Click()
		AskMrRobot_ReforgeFrame.exportTab.button:SetScript("OnClick", AskMrRobot.SaveAll)
		--AskMrRobot.SaveBags();
		--AskMrRobot.SaveEquiped();
		--AskMrRobot.GetCurrencies();
		--AskMrRobot.GetGold();
		--AskMrRobot.GetAmrSpecializations();
		--AskMrRobot.GetAmrProfessions();
		--AskMrRobot.GetRace();
		--AskMrRobot.GetLevel();
	elseif event == "ITEM_PUSH" or event == "DELETE_ITEM_CONFIRM" or event == "UNIT_INVENTORY_CHANGED" or event == "SOCKET_INFO_CLOSE" or event == "PLAYER_SPECIALIZATION_CHANGED" or event == "BAG_UPDATE" then
		if AskMrRobot_ReforgeFrame then
			AskMrRobot_ReforgeFrame:OnUpdate()
		end
		--AskMrRobot.SaveBags();
		--AskMrRobot.SaveEquiped();
		--AskMrRonot.GetCurrencies();
		--AskMrRobot.GetGold();
	elseif event == "BANKFRAME_OPENED" or event == "PLAYERBANKSLOTS_CHANGED" then 
		--print("Scanning Bank: " .. event);
		AskMrRobot.ScanBank();
	elseif event == "BANKFRAME_CLOSED" then
		--print("Stop Scanning Bank");
		--inBank = false;
	elseif event == "CHARACTER_POINTS_CHANGED" or event == "CONFIRM_TALENT_WIPE" or event == "PLAYER_TALENT_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" then
		--AskMrRobot.GetAmrSpecializations();
		if AskMrRobot_ReforgeFrame then
			AskMrRobot_ReforgeFrame:OnUpdate()
		end
	elseif event == "PLAYER_LEVEL_UP" then
		--GetLevel();
	elseif event == "ITEM_UNLOCKED" then
		AskMrRobot.On_ITEM_UNLOCKED()
	elseif event == "PLAYER_LOGOUT" then
		-- doing nothing right now, but leaving this in case we need something here	
	end
 
end

AskMrRobot.eventListener:SetScript("OnEvent", AskMrRobot.eventListener.OnEvent);


SLASH_AMR1 = "/amr";
function SlashCmdList.AMR(msg)

	if msg == 'toggle' then
		AskMrRobot_ReforgeFrame:Toggle()
	elseif msg == 'show' then
		AskMrRobot_ReforgeFrame:Show()
	elseif msg == 'hide' then
		AskMrRobot_ReforgeFrame:Hide()
	elseif msg == 'export' then
		AskMrRobot.SaveAll();
	else
		print('Available AskMrRobot slash commands:\n' ..
			'  /amr show   -- show the main window\n' ..
			'  /amr hide   -- hide the main window\n' ..
			'  /amr toggle -- toggle the main window\n' ..
			'  /amr export -- export bag and bank data')
	end
end

function AskMrRobot.SaveAll()
	AskMrRobot.ScanBank()
	AskMrRobot.SaveBags()
	AskMrRobot.SaveEquiped()
	AskMrRobot.GetCurrencies()
	AskMrRobot.GetGold()
	AskMrRobot.GetAmrSpecializations()
	AskMrRobot.GetAmrProfessions()
	AskMrRobot.GetRace()
	AskMrRobot.GetLevel()
	AskMrRobot.GetAmrGlyphs()
	AskMrRobot.GetAmrTalents()
	ReloadUI()
end

local function InitIcon()
	icon = LibStub("LibDBIcon-1.0");
	icon:Register("AskMrRobot", amrLDB, AmrIconInfo);	
end

function AskMrRobot.AmrUpdateMinimap()
	if (AmrOptions.hideMapIcon) then
		if (icon) then
			icon:Hide("AskMrRobot");
		end
	else
		if (not icon) then 
			InitIcon() 
		end
		icon:Show("AskMrRobot");
	end
end

local function getToolTipText(tip)
	return EnumerateTooltipLines_helper(tip:GetRegions())
end

local bagItems = {}
local bagItemsWithCount = {}

function AskMrRobot.ScanBag(bagId) 	
	local numSlots = GetContainerNumSlots(bagId);
	for slotId = 1, numSlots do
		local _, itemCount, _, _, _, _, itemLink = GetContainerItemInfo(bagId, slotId);
		if itemLink ~= nil then
			tinsert(bagItems, itemLink);
			tinsert(bagItemsWithCount, {link = itemLink, count = itemCount})
		end
	end
end

local BACKPACK_CONTAINER = 0;
local BANK_CONTAINER = -1;

function AskMrRobot.ScanEquiped()
	local equipedItems = {};
	for slotNum = 1, #AskMrRobot.slotIds do
		local slotId = AskMrRobot.slotIds[slotNum];
		local itemLink = GetInventoryItemLink("player", slotId);
		if (itemLink ~= nil) then
			equipedItems[slotId .. ""] = itemLink;
		end
	end
	return equipedItems
end

function AskMrRobot.SaveEquiped()
	AmrEquipedItems = AskMrRobot.ScanEquiped();
end

function AskMrRobot.ScanBags()
	bagItems = {}
	bagItemsWithCount = {}

	AskMrRobot.ScanBag(BACKPACK_CONTAINER); -- backpack
	
	for bagId = 1, NUM_BAG_SLOTS do
		AskMrRobot.ScanBag(bagId);
	end
	

	return bagItems, bagItemsWithCount
end

function AskMrRobot.SaveBags()
	AmrBagItems, _ = AskMrRobot.ScanBags()
end

function AskMrRobot.GetGold()
	AmrGold = GetMoney();
end

local lastBankBagId = nil;
local lastBankSlotId = nil;
local bankItems = {};
local bankItemsAndCount = {};
AmrBankItemsAndCounts = {};

local function ScanBankBag(bagId)
	local numSlots = GetContainerNumSlots(bagId);
	for slotId = 1, numSlots do
		local _, itemCount, _, _, _, _, itemLink = GetContainerItemInfo(bagId, slotId);
		if itemLink ~= nil then
			lastBankBagId = bagId;
			lastBankSlotId = slotId;
			tinsert(bankItems, itemLink);						
			tinsert(bankItemsAndCount, {link = itemLink, count = itemCount})
		end
	end
end
		
function AskMrRobot.ScanBank()
		
	bankItems = {};
	bankItemsAndCount = {}
	
	ScanBankBag(BANK_CONTAINER);
	for bagId = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		ScanBankBag(bagId);
	end
	
	-- see if the scan completed before the window closed
	if lastBankBagId ~= nil then
		local itemLink = GetContainerItemLink(lastBankBagId, lastBankSlotId);
		if itemLink ~= nil then --still open
			AmrBankItems = bankItems;
			AmrBankItemsAndCounts = bankItemsAndCount
		end
	end
end

local function GetCurrencyAmount(index)
	local localized_label, amount, icon_file_name = GetCurrencyInfo(index);
	return amount;
end

function AskMrRobot.GetCurrencies()
	local currencies = {};
	local currencyList = {61, 81, 241, 361, 384, 394, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 416, 515, 614, 615, 676, 679};

	for i, currency in pairs(currencyList) do
		local amount = GetCurrencyAmount(currency);
		if amount ~= 0 then
			currencies[currencyList[i]] = amount;
		end
	end
	AmrCurrencies = currencies;
end

local function GetAmrSpecialization(specGroup)
	local spec = GetSpecialization(false, false, group);
	return spec and GetSpecializationInfo(spec);
end

function AskMrRobot.GetAmrSpecializations()

	AmrSpecializations = {};

	AmrActiveSpec = GetActiveSpecGroup();

	for group = 1, 2 do
		AmrSpecializations[group .. ""] = GetAmrSpecialization(group)
	end

-- Death Knight 
-- 250 - Blood
-- 251 - Frost
-- 252 - Unholy
-- Druid 
-- 102 - Balance
-- 103 - Feral Combat
-- 104 - Guardian
-- 105 - Restoration
-- Hunter 
-- 253 - Beast Mastery
-- 254 - Marksmanship
-- 255 - Survival
-- Mage 
-- 62 - Arcane
-- 63 - Fire
-- 64 - Frost
-- Monk 
-- 268 - Brewmaster
-- 269 - Windwalker
-- 270 - Mistweaver
-- Paladin 
-- 65 - Holy
-- 66 - Protection
-- 70 - Retribution
-- Priest 
-- 256 Discipline
-- 257 Holy
-- 258 Shadow
-- Rogue 
-- 259 - Assassination
-- 260 - Combat
-- 261 - Subtlety
-- Shaman 
-- 262 - Elemental
-- 263 - Enhancement
-- 264 - Restoration
-- Warlock 
-- 265 - Affliction
-- 266 - Demonology
-- 267 - Destruction
-- Warrior 
-- 71 - Arms
-- 72 - Fury
-- 73 - Protection
end

function AskMrRobot.GetAmrProfessions()

	local profMap = {
		[794] = "Archaeology",
		[171] = "Alchemy",
		[164] = "Blacksmithing",
		[185] = "Cooking",
		[333] = "Enchanting",
		[202] = "Engineering",
		[129] = "First Aid",
		[356] = "Fishing",
		[182] = "Herbalism",
		[773] = "Inscription",
		[755] = "Jewelcrafting",
		[165] = "Leatherworking",
		[186] = "Mining",
		[393] = "Skinning",
		[197] = "Tailoring"
	}

	local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions();
	AmrProfessions = {};
	if prof1 then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier = GetProfessionInfo(prof1);
		if profMap[skillLine] ~= nil then
			AmrProfessions[profMap[skillLine]] = skillLevel;
		end
	end
	if prof2 then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier = GetProfessionInfo(prof2);
		if profMap[skillLine] ~= nil then
			AmrProfessions[profMap[skillLine]] = skillLevel;
		end
	end
	if archaeology then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier = GetProfessionInfo(archaeology);
		if profMap[skillLine] ~= nil then
			AmrProfessions[profMap[skillLine]] = skillLevel;
		end
	end
	if fishing then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier = GetProfessionInfo(fishing);
		if profMap[skillLine] ~= nil then
			AmrProfessions[profMap[skillLine]] = skillLevel;
		end
	end
	if cooking then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier = GetProfessionInfo(cooking);
		if profMap[skillLine] ~= nil then
			AmrProfessions[profMap[skillLine]] = skillLevel;
		end
	end
	if firstAid then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier = GetProfessionInfo(firstAid);
		if profMap[skillLine] ~= nil then
			AmrProfessions[profMap[skillLine]] = skillLevel;
		end
	end
end

function AskMrRobot.GetRace()
	local race, raceEn = UnitRace("player");
	AmrRace = raceEn;
	AmrFaction = UnitFactionGroup("player");
end

function AskMrRobot.GetLevel()
	AmrLevel = UnitLevel("player");
end

local SlotNames = {
   "HeadSlot",
   "NeckSlot",
   "ShoulderSlot",
   "ShirtSlot",
   "ChestSlot",
   "WaistSlot",
   "LegsSlot",
   "FeetSlot",
   "WristSlot",
   "HandsSlot",
   "Finger0Slot",
   "Finger1Slot",
   "Trinket0Slot",
   "Trinket1Slot",
   "BackSlot",
   "MainHandSlot",
   "SecondaryHandSlot",
--   "RangedSlot",
   "TabardSlot",
}

local function GetAmrTalentsForSpec(spec)	
    local talentInfo = {}
    local maxTiers = 6
    for talent = 1, GetNumTalents() do
     	local name, texture, tier, column, selected, available = GetTalentInfo(talent, false, spec)
     	if tier > maxTiers then
     		maxTiers = tier
     	end
     	if selected then
     		talentInfo[tier] = column
    	end
    end
    
    local str = ""
    for i = 1, maxTiers do
    	if talentInfo[i] then
    		str = str .. talentInfo[i]
    	else
    		str = str .. '0'
    	end
    end    	

	return str
end

function AskMrRobot.GetAmrTalents()
	AmrTalents = {}
    for spec = 1, GetNumSpecGroups() do
    	AmrTalents[spec] = GetAmrTalentsForSpec(spec);
    end
end

local function GetAmrGlyphsForSpec(spec)
	local glyphs = {}
	for i = 1,  NUM_GLYPH_SLOTS do
		local _, _, _, glyphSpellID, _, glyphID = GetGlyphSocketInfo(i, spec)
		if (glyphID) then
			tinsert(glyphs, glyphSpellID)
		end
	end
	return glyphs;
end

function AskMrRobot.GetAmrGlyphs()
	AmrGlyphs = {}
	for spec = 1, GetNumSpecGroups() do
		AmrGlyphs[spec] = GetAmrGlyphsForSpec(spec)
	end
end


local function parseGlyphs(input)
	local glyphs = {}
	for glyph in string.gmatch(input, "([^,]+)") do
		tinsert(glyphs, glyph)
	end
	table.sort(glyphs)
	return glyphs
end

local function parseProfessions(input)
	local professions = {}
	for prof, v in string.gmatch(input, "([^:,]+):([^,]+)") do
		professions[prof] = tonumber(v);
	end
	return professions;
end

local gemColorMapping = {
	y = 'Yellow',
	b = 'Blue',
	r = 'Red',
	h = 'Hydraulic',
	p = 'Prismatic',
	m = 'Meta',
	c = 'Cogwheel'
}

local function parseAmrItem(input)
	local slot, itemId, suffixList, upgradeId, gemColorString, gemEnchantIdString, gemIdString, enchantId, reforgeId = string.match(input, "^(%d+):(%d+):([^:]+):([^:]+):([^:]+):([^:]+):([^:]+):(%d+):(%d+)");
	-- parse the gem enchant ids out of their comma seperated list
	local gems = {}
	for gemEnchantId in string.gmatch(gemEnchantIdString, '(%d+)') do
		tinsert(gems, {enchantId = tonumber(gemEnchantId), id = 0})
	end
	-- make sure we have 4 gem ids
	for i = #gems + 1, 4 do
		tinsert(gems, {enchantId = 0, id = 0})
	end	
	-- parse the gem ids out of their comma seperated list	
	local gemIds = {}
	i = 1
	for gemId in string.gmatch(gemIdString, '(%d+)') do
		gems[i].id = tonumber(gemId)
		i = i + 1
	end
	i = 1
	for gemColor in string.gmatch(gemColorString, '([^,])') do
		gems[i].color = gemColorMapping[gemColor]
		i = i + 1
	end

	-- parse the possible suffixes out of their comma seperated list and put them in a set (number -> bool)
	local suffixes = {}
	for suffixId in string.gmatch(suffixList, '(%-?%d+)') do
		suffixes[tonumber(suffixId)] = true
	end

	local item = {
		itemId = tonumber(itemId),
		suffixes = suffixes,
		upgradeId = tonumber(upgradeId),
		gems = gems,
		enchantId = tonumber(enchantId),
		reforgeId = tonumber(reforgeId)
	}
	return slot, item
end

local function parseItemLink(input)
	local itemId, enchantId, gemEnchantId1, gemEnchantId2, gemEnchantId3, gemEnchantId4, suffixId, _, _, reforgeId, upgradeId = string.match(input, "^|.-|Hitem:(%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(-?%d+):(-?%d+):(-?%d+):(%d+):(%d+)|");
	local item = {}
	item.itemId = tonumber(itemId)
	item.suffixId = tonumber(suffixId)
	item.enchantId = tonumber(enchantId)
	item.reforgeId = tonumber(reforgeId)
	item.upgradeId = tonumber(upgradeId)
	item.gemEnchantIds = { tonumber(gemEnchantId1), tonumber(gemEnchantId2), tonumber(gemEnchantId3), tonumber(gemEnchantId4) }
	return item
end

function AskMrRobot.parseAmr(input)
	local parsedInput = {}
	parsedInput.items = {}
	for k, v in string.gmatch(input, "([^=;]+)=([^;]*)") do
		if (k == 'item') then
			local slot, item = parseAmrItem(v);
			parsedInput.items[AskMrRobot.slotIdToSlotNum[tonumber(slot) + 1]] = item;
		 elseif (k == 'glyphs') then
		 	parsedInput.glyphs = parseGlyphs(v)
	 	 elseif (k == 'professions') then
	 	 	parsedInput.professions = parseProfessions(v)
		 else
		 	parsedInput[k]=v
		end
	end
	return parsedInput
end

function AskMrRobot.validateRealm(realm)
	return realm == GetRealmName();
end

function AskMrRobot.validateCharacterName(characterName)
	return UnitName("player") == characterName
end

function AskMrRobot.validateRace(race)
	local _, raceEn = UnitRace("player")
	return raceEn == race or (raceEn == "Scourge" and race == "Undead")
end

function AskMrRobot.validateFaction(faction)
	return faction == UnitFactionGroup("player")
end

function AskMrRobot.validateSpec(spec)
	if spec == 'nil' then 
		spec = nil
	end
	local currentSpec = GetAmrSpecialization(GetActiveSpecGroup())
	return (not currentSpec and not spec) or tostring(currentSpec) == spec
end

function AskMrRobot.validateTalents(talents)
	if talents == nil then
		talents = ''
	end
	return talents == GetAmrTalentsForSpec(GetActiveSpecGroup())
end

function AskMrRobot.validateGlyphs(glyphs)
	if (glyphs == nil) then
		glyphs = {};
	end
	local currentGlyphs = GetAmrGlyphsForSpec(GetActiveSpecGroup())
	table.sort(glyphs, function(a,b) return tostring(a) < tostring(b) end)
	table.sort(currentGlyphs, function(a,b) return tostring(a) < tostring(b) end)

	if #glyphs ~= #currentGlyphs then
		return false
	end
	for i = 1, #glyphs do
		if tostring(glyphs[i]) ~= tostring(currentGlyphs[i]) then
			return false
		end
	end

	return true
end

local function getPrimaryProfessions()
	local profs = {}
	local prof1, prof2 = GetProfessions()
	local profMap = {
		[794] = "Archaeology",
		[171] = "Alchemy",
		[164] = "Blacksmithing",
		[185] = "Cooking",
		[333] = "Enchanting",
		[202] = "Engineering",
		[129] = "First Aid",
		[356] = "Fishing",
		[182] = "Herbalism",
		[773] = "Inscription",
		[755] = "Jewelcrafting",
		[165] = "Leatherworking",
		[186] = "Mining",
		[393] = "Skinning",
		[197] = "Tailoring"
	}

	if prof1 then
		local _, _, skillLevel, _, _, _, skillLine = GetProfessionInfo(prof1);
		if profMap[skillLine] ~= nil then
			profs[profMap[skillLine]] = skillLevel
		end
	end
	if prof2 then
		local _, _, skillLevel, _, _, _, skillLine = GetProfessionInfo(prof2);
		if profMap[skillLine] ~= nil then
			profs[profMap[skillLine]] = skillLevel
		end
	end	
	return profs;
end

local professionThresholds = {
	Leatherworking = 575,
	Inscription = 600,
	Alchemy = 50,
	Enchanting = 550,
	Jewelcrafting = 550,
	Blacksmithing = 550,
	Tailoring = 550
}

function AskMrRobot.validateProfessions(professions)
	local currentProfessions = getPrimaryProfessions()
	if #currentProfessions ~= #professions then
		return false
	end
	for k, v in pairs(professions) do
		if currentProfessions[k] then
			local threshold = professionThresholds[k]
			if not threshold then
				threshold = 1
			end
			-- compare the desired profession against the threshold
			local desired = v >= threshold
			-- compare the current profession against the threshold
			local has = currentProfessions[k] and currentProfessions[k] >= threshold
			-- if the current value is on the other side of the threshold
			-- then we don't match
			if desired ~= has then 
				return false 
			end
		else 
			return false
		end
	end
	return true
end

function AskMrRobot.populateItemDiffs(amrItem, itemLink, slotNum)
	AskMrRobot.itemDiffs.items[slotNum] = nil
	AskMrRobot.itemDiffs.gems[slotNum] = nil
	AskMrRobot.itemDiffs.enchants[slotNum] = nil
	AskMrRobot.itemDiffs.reforges[slotNum] = nil

	local needsUpgrade = false
	local aSuffix = 0
	if amrItem then
		for k,v in pairs(amrItem.suffixes) do
			aSuffix = k
		end
	end

	if itemLink == nil then
		if amrItem ~= nil then
			AskMrRobot.itemDiffs.items[slotNum] = {
				current = nil,
				optimized = { itemId = amrItem.itemId, upgradeId = amrItem.upgradeId, suffixId = aSuffix },
				needsUpgrade = false
			}
		end
		return
	end
	local item = parseItemLink(itemLink)
	local isItemBad = false

	if amrItem == nil or item.itemId ~= amrItem.itemId then
		isItemBad = true
	else
		if item.suffixId == 0 then
			if #amrItem.suffixes > 0 then
				isItemBad = true
			end
		else
			if not amrItem.suffixes[item.suffixId] then
				isItemBad = true
			end
		end
		if not isItemBad and upgradeTable[item.upgradeId] ~= upgradeTable[amrItem.upgradeId] then
			isItemBad = true
			needsUpgrade = true
		end
	end

	if isItemBad then
		AskMrRobot.itemDiffs.items[slotNum] = {
			current = item.itemId,
			optimized = { itemId = amrItem and amrItem.itemId or 0, upgradeId = amrItem and amrItem.upgradeId or 0, suffixId = aSuffix },			
			needsUpgrade = needsUpgrade
		}
		return
	end

	local badGemCount, gemInfo = AskMrRobot.MatchesGems(itemLink, item.gemEnchantIds, amrItem.gems)
	if badGemCount > 0 then
		AskMrRobot.itemDiffs.gems[slotNum] = gemInfo
	end

	if item.enchantId ~= amrItem.enchantId then
		AskMrRobot.itemDiffs.enchants[slotNum] = {
			current = item.enchantId,
			optimized = amrItem.enchantId
		}
	end

	if item.reforgeId ~= amrItem.reforgeId then
		AskMrRobot.itemDiffs.reforges[slotNum] = {
			current = item.reforgeId,
			optimized = amrItem.reforgeId
		}
	end
end
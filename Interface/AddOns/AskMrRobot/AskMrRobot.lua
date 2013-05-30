local frame = CreateFrame("FRAME"); -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out
frame:RegisterEvent("ITEM_PUSH");
frame:RegisterEvent("DELETE_ITEM_CONFIRM");
frame:RegisterEvent("UNIT_INVENTORY_CHANGED");
frame:RegisterEvent("BANKFRAME_OPENED");
frame:RegisterEvent("BANKFRAME_CLOSED");
frame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
frame:RegisterEvent("CHARACTER_POINTS_CHANGED");
frame:RegisterEvent("CONFIRM_TALENT_WIPE");
frame:RegisterEvent("PLAYER_TALENT_UPDATE");
frame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
frame:RegisterEvent("PLAYER_LEVEL_UP");
	--GET_ITEM_INFO_RECEIVED

local amrLDB;
local icon;

function frame:OnEvent(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "AskMrRobot" then
		print("Loaded Ask Mr. Robot");  
  
		AmrRealmName = GetRealmName();
		AmrCharacterName = UnitName("player");


		if not AmrIconInfo then AmrIconInfo = {}; end
		if not AmrBankItems then AmrBankItems = {}; end
		if not AmrCurrencies then AmrCurrencies = {}; end
		if not AmrSpecializations then AmrSpecializations = {}; end
		if not AmrHideMapIcon then AmrHideMapIcon = false; end


		amrLDB = LibStub("LibDataBroker-1.1"):NewDataObject("AskMrRobot", {
			type = "launcher",
			text = "Ask Mr. Robot",
			icon = "Interface\\AddOns\\AskMrRobot\\Media\\icon",
			OnClick = function()

				SaveAll();
			end,
			OnTooltipShow = function(tt)
				tt:AddLine("Ask Mr. Robot", 1, 1, 1);
				tt:AddLine(" ");
				tt:AddLine("Click to save your gear.", 1, .832, 0);
				tt:AddLine(" ");
				tt:AddLine("To read all of your bank items, open your bank before you click me.", 1, .832, 0);
			end	
		});


		AmrUpdateMinimap()

		--ScanBags();
		--ScanEquiped();
		--GetCurrencies();
		--GetGold();
		--GetAmrSpecializations();
		--GetAmrProfessions();
		--GetRace();
		--GetLevel();
	elseif event == "ITEM_PUSH" or event == "DELETE_ITEM_CONFIRM" or event == "UNIT_INVENTORY_CHANGED" then
		--ScanBags();
		--ScanEquiped();
		--GetCurrencies();
		--GetGold();
	elseif event == "BANKFRAME_OPENED" or event == "PLAYERBANKSLOTS_CHANGED" then 
		--print("Scanning Bank: " .. event);
		ScanBank();
	elseif event == "BANKFRAME_CLOSED" then
		--print("Stop Scanning Bank");
		--inBank = false;
	elseif event == "CHARACTER_POINTS_CHANGED" or event == "CONFIRM_TALENT_WIPE" or event == "PLAYER_TALENT_UPDATE" or event == "ACTIVE_TALENT_GROUP_CHANGED" then
		--GetAmrSpecializations();
	elseif event == "PLAYER_LEVEL_UP" then
		--GetLevel();
	elseif event == "PLAYER_LOGOUT" then
		-- doing nothing right now, but leaving this in case we need something here
	end
 
end

frame:SetScript("OnEvent", frame.OnEvent);


SLASH_AMR1 = "/amr";
function SlashCmdList.AMR(msg)
	SaveAll();
end

function SaveAll()
	ScanBank();
	ScanBags();
	ScanEquiped();
	GetCurrencies();
	GetGold();
	GetAmrSpecializations();
	GetAmrProfessions();
	GetRace();
	GetLevel();
	ReloadUI();
end

function InitIcon()
	icon = LibStub("LibDBIcon-1.0");
	icon:Register("AskMrRobot", amrLDB, AmrIconInfo);	
end

function AmrUpdateMinimap()
	if (AmrHideMapIcon) then
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

local bagItems = {};

function ScanBag(bagId) 	
	local numSlots = GetContainerNumSlots(bagId);
	for slotId = 1, numSlots do
		local itemLink = GetContainerItemLink(bagId, slotId);
		if itemLink ~= nil then
			tinsert(bagItems, itemLink);
		end
	end
end

local BACKPACK_CONTAINER = 0;
local BANK_CONTAINER = -1;

local slotNames = {"HeadSlot", "NeckSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot", "HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "MainHandSlot", "SecondaryHandSlot", "AmmoSlot" };
local slotIds = {};
for slotNum = 1, #slotNames do
	local slotId = GetInventorySlotInfo(slotNames[slotNum]);
	slotIds[slotNum] = slotId;
end

function ScanEquiped()
	local equipedItems = {};
	for slotNum = 1, #slotIds do
		local slotId = slotIds[slotNum];
		local itemLink = GetInventoryItemLink("player", slotId);
		if (itemLink ~= nil) then
			equipedItems[slotId .. ""] = itemLink;
		end
	end
	AmrEquipedItems = equipedItems;
end

function ScanBags()
	bagItems = {};

	ScanBag(BACKPACK_CONTAINER); -- backpack
	
	for bagId = 1, NUM_BAG_SLOTS do
		ScanBag(bagId);
	end
	
	AmrBagItems = bagItems;
end

function GetGold()
	AmrGold = GetMoney();
end

local lastBankBagId = nil;
local lastBankSlotId = nil;
local bankItems = {};

function ScanBankBag(bagId)
	local numSlots = GetContainerNumSlots(bagId);
	for slotId = 1, numSlots do
		local itemLink = GetContainerItemLink(bagId, slotId);
		if itemLink ~= nil then
			lastBankBagId = bagId;
			lastBankSlotId = slotId;
			tinsert(bankItems, itemLink);
		end
	end
end
		
function ScanBank()
		
	bankItems = {};
	
	ScanBankBag(BANK_CONTAINER);
	for bagId = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
		ScanBankBag(bagId);
	end
	
	-- see if the scan completed before the window closed
	if lastBankBagId ~= nil then
		local itemLink = GetContainerItemLink(lastBankBagId, lastBankSlotId);
		if itemLink ~= nil then --still open
			AmrBankItems = bankItems;
		end
	end
end

function GetCurrencyAmount(index)
	local localized_label, amount, icon_file_name = GetCurrencyInfo(index);
	return amount;
end

function GetCurrencies()
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

function GetAmrSpecializations()

	AmrSpecializations = {};

	AmrActiveSpec = GetActiveSpecGroup();

	for group = 1, 2 do
		local spec = GetSpecialization(false, false, group);
		if spec ~= nil then
			AmrSpecializations[group .. ""] = GetSpecializationInfo(spec);
		end
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

function GetAmrProfessions()

	local profMap = {};
	profMap[794] = "Archaeology";
	profMap[171] = "Alchemy";
	profMap[164] = "Blacksmithing";
	profMap[185] = "Cooking";
	profMap[333] = "Enchanting";
	profMap[202] = "Engineering";
	profMap[129] = "First Aid";
	profMap[356] = "Fishing";
	profMap[182] = "Herbalism";
	profMap[773] = "Inscription";
	profMap[755] = "Jewelcrafting";
	profMap[165] = "Leatherworking";
	profMap[186] = "Mining";
	profMap[393] = "Skinning";
	profMap[197] = "Tailoring";

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

function GetRace()
	local race, raceEn = UnitRace("player");
	AmrRace = raceEn;
	AmrFaction = UnitFactionGroup("player");
end

function GetLevel()
	AmrLevel = UnitLevel("player");
end
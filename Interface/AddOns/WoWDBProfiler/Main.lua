-- LUA API ------------------------------------------------------------

local _G = getfenv(0)

local pairs = _G.pairs
local tonumber = _G.tonumber

local bit = _G.bit
local math = _G.math
local table = _G.table

local select = _G.select


-- ADDON NAMESPACE ----------------------------------------------------

local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local WDP = LibStub("AceAddon-3.0"):NewAddon(ADDON_NAME, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0")

local deformat = LibStub("LibDeformat-3.0")
local LPJ = LibStub("LibPetJournal-2.0")
local MapData = LibStub("LibMapData-1.0")

local DatamineTT = _G.CreateFrame("GameTooltip", "WDPDatamineTT", _G.UIParent, "GameTooltipTemplate")
DatamineTT:SetOwner(_G.WorldFrame, "ANCHOR_NONE")


-- CONSTANTS ----------------------------------------------------------

local AF = private.ACTION_TYPE_FLAGS
local CLIENT_LOCALE = _G.GetLocale()
local DB_VERSION = 16
local DEBUGGING = false
local EVENT_DEBUG = false
local OBJECT_ID_ANVIL = 192628
local OBJECT_ID_FORGE = 1685
local PLAYER_CLASS = _G.select(2, _G.UnitClass("player"))
local PLAYER_FACTION = _G.UnitFactionGroup("player")
local PLAYER_GUID = _G.UnitGUID("player")
local PLAYER_NAME = _G.UnitName("player")
local PLAYER_RACE = _G.select(2, _G.UnitRace("player"))

local ALLOWED_LOCALES = {
    enUS = true,
    enGB = true,
}

local DATABASE_DEFAULTS = {
    char = {},
    global = {
        config = {
            minimap_icon = {
                hide = true,
            },
        },
        items = {},
        npcs = {},
        objects = {},
        quests = {},
        spells = {},
        zones = {},
    }
}

local EVENT_MAPPING = {
    AUCTION_HOUSE_SHOW = true,
    BANKFRAME_OPENED = true,
    BATTLEFIELDS_SHOW = true,
    BLACK_MARKET_ITEM_UPDATE = true,
    CHAT_MSG_LOOT = true,
    CHAT_MSG_MONSTER_SAY = "RecordQuote",
    CHAT_MSG_MONSTER_WHISPER = "RecordQuote",
    CHAT_MSG_MONSTER_YELL = "RecordQuote",
    CHAT_MSG_SYSTEM = true,
    COMBAT_LOG_EVENT_UNFILTERED = true,
    COMBAT_TEXT_UPDATE = true,
    CURSOR_UPDATE = true,
    FORGE_MASTER_OPENED = true,
    GOSSIP_SHOW = true,
    GROUP_ROSTER_UPDATE = true,
    GUILDBANKFRAME_OPENED = true,
    ITEM_TEXT_BEGIN = true,
    ITEM_UPGRADE_MASTER_OPENED = true,
    LOOT_CLOSED = true,
    LOOT_OPENED = true,
    MAIL_SHOW = true,
    MERCHANT_CLOSED = true,
    MERCHANT_SHOW = "UpdateMerchantItems",
    MERCHANT_UPDATE = "UpdateMerchantItems",
    PET_BAR_UPDATE = true,
    PET_JOURNAL_LIST_UPDATE = true,
    PLAYER_REGEN_DISABLED = true,
    PLAYER_REGEN_ENABLED = true,
    PLAYER_TARGET_CHANGED = true,
    QUEST_COMPLETE = true,
    QUEST_DETAIL = true,
    QUEST_LOG_UPDATE = true,
    QUEST_PROGRESS = true,
    SHOW_LOOT_TOAST = true,
    TAXIMAP_OPENED = true,
    TRADE_SKILL_SHOW = true,
    TRAINER_CLOSED = true,
    TRAINER_SHOW = true,
    TRANSMOGRIFY_OPEN = true,
    UNIT_PET = true,
    UNIT_QUEST_LOG_CHANGED = true,
    UNIT_SPELLCAST_FAILED = "HandleSpellFailure",
    UNIT_SPELLCAST_FAILED_QUIET = "HandleSpellFailure",
    UNIT_SPELLCAST_INTERRUPTED = "HandleSpellFailure",
    UNIT_SPELLCAST_SENT = true,
    UNIT_SPELLCAST_SUCCEEDED = true,
    VOID_STORAGE_OPEN = true,
    ZONE_CHANGED = "SetCurrentAreaID",
    ZONE_CHANGED_INDOORS = "SetCurrentAreaID",
    ZONE_CHANGED_NEW_AREA = "SetCurrentAreaID",
}


-- VARIABLES ----------------------------------------------------------

local anvil_spell_ids = {}
local currently_drunk
local char_db
local global_db
local group_member_uids = {}
local group_owner_guids_to_pet_guids = {}
local group_pet_guids = {}
local item_process_timer_handle
local faction_standings = {}
local forge_spell_ids = {}
local languages_known = {}
local name_to_id_map = {}
local killed_npc_id
local target_location_timer_handle
local current_target_id
local current_area_id
local current_loot

-- Data for our current action. Including possible values as a reference.
local current_action = {
    identifier = nil,
    loot_label = nil,
    loot_list = nil,
    loot_sources = nil,
    map_level = nil,
    spell_label = nil,
    target_type = nil,
    x = nil,
    y = nil,
    zone_data = nil,
}


-- HELPERS ------------------------------------------------------------

local function Debug(message, ...)
    if not DEBUGGING then
        return
    end
    _G.print(message:format(...))
end


local TradeSkillExecutePer
do
    local header_list = {}

    -- iter_func returns true to indicate that the loop should be broken
    function TradeSkillExecutePer(iter_func)
        if not _G.TradeSkillFrame or not _G.TradeSkillFrame:IsVisible() then
            return
        end
        -- Clear the search box focus so the scan will have correct results.
        local search_box = _G.TradeSkillFrameSearchBox
        search_box:SetText("")

        _G.TradeSkillSearch_OnTextChanged(search_box)
        search_box:ClearFocus()
        search_box:GetScript("OnEditFocusLost")(search_box)

        table.wipe(header_list)

        -- Save the current state of the TradeSkillFrame so it can be restored after we muck with it.
        local have_materials = _G.TradeSkillFrame.filterTbl.hasMaterials
        local have_skillup = _G.TradeSkillFrame.filterTbl.hasSkillUp

        if have_materials then
            _G.TradeSkillFrame.filterTbl.hasMaterials = false
            _G.TradeSkillOnlyShowMakeable(false)
        end

        if have_skillup then
            _G.TradeSkillFrame.filterTbl.hasSkillUp = false
            _G.TradeSkillOnlyShowSkillUps(false)
        end
        _G.SetTradeSkillInvSlotFilter(0, 1, 1)
        _G.TradeSkillUpdateFilterBar()
        _G.TradeSkillFrame_Update()

        -- Expand all headers so we can see all the recipes there are
        for tradeskill_index = 1, _G.GetNumTradeSkills() do
            local name, tradeskill_type, _, is_expanded = _G.GetTradeSkillInfo(tradeskill_index)

            if tradeskill_type == "header" or tradeskill_type == "subheader" then
                if not is_expanded then
                    header_list[name] = true
                    _G.ExpandTradeSkillSubClass(tradeskill_index)
                end
            elseif iter_func(name, tradeskill_index) then
                break
            end
        end

        -- Restore the state of the things we changed.
        for tradeskill_index = 1, _G.GetNumTradeSkills() do
            local name, tradeskill_type, _, is_expanded = _G.GetTradeSkillInfo(tradeskill_index)

            if header_list[name] then
                _G.CollapseTradeSkillSubClass(tradeskill_index)
            end
        end
        _G.TradeSkillFrame.filterTbl.hasMaterials = have_materials
        _G.TradeSkillOnlyShowMakeable(have_materials)
        _G.TradeSkillFrame.filterTbl.hasSkillUp = have_skillup
        _G.TradeSkillOnlyShowSkillUps(have_skillup)

        _G.TradeSkillUpdateFilterBar()
        _G.TradeSkillFrame_Update()
    end
end -- do-block


local ActualCopperCost
do
    local BARTERING_SPELL_ID = 83964

    local STANDING_DISCOUNTS = {
        HATED = 0,
        HOSTILE = 0,
        UNFRIENDLY = 0,
        NEUTRAL = 0,
        FRIENDLY = 0.05,
        HONORED = 0.1,
        REVERED = 0.15,
        EXALTED = 0.2,
    }


    function ActualCopperCost(copper_cost, rep_standing)
        if not copper_cost or copper_cost == 0 then
            return 0
        end
        local modifier = 1

        if _G.IsSpellKnown(BARTERING_SPELL_ID) then
            modifier = modifier - 0.1
        end

        if rep_standing then
            if PLAYER_RACE == "Goblin" then
                modifier = modifier - STANDING_DISCOUNTS["EXALTED"]
            elseif STANDING_DISCOUNTS[rep_standing] then
                modifier = modifier - STANDING_DISCOUNTS[rep_standing]
            end
        end
        return math.floor(copper_cost / modifier)
    end
end -- do-block


-- Called on a timer
local function ClearKilledNPC()
    killed_npc_id = nil
end


local function ClearKilledBossID()
    private.raid_finder_boss_id = nil
    private.world_boss_id = nil
end


local function InstanceDifficultyToken()
    local _, instance_type, instance_difficulty, _, _, _, is_dynamic = _G.GetInstanceInfo()

    if not instance_type or instance_type == "" then
        instance_type = "NONE"
    end
    return ("%s:%d:%s"):format(instance_type:upper(), instance_difficulty, _G.tostring(is_dynamic))
end


local function DBEntry(data_type, unit_id)
    if not data_type or not unit_id then
        return
    end
    local category = global_db[data_type]

    if not category then
        category = {}
        global_db[data_type] = category
    end
    local unit = category[unit_id]

    if not unit then
        unit = {}
        category[unit_id] = unit
    end
    return unit
end

private.DBEntry = DBEntry

local NPCEntry
do
    local npc_prototype = {}
    local npc_meta = {
        __index = npc_prototype
    }

    function NPCEntry(identifier)
        local npc = DBEntry("npcs", identifier)

        if not npc then
            return
        end
        return _G.setmetatable(npc, npc_meta)
    end

    function npc_prototype:EncounterData(difficulty_token)
        self.encounter_data = self.encounter_data or {}
        self.encounter_data[difficulty_token] = self.encounter_data[difficulty_token] or {}
        self.encounter_data[difficulty_token].stats = self.encounter_data[difficulty_token].stats or {}

        return self.encounter_data[difficulty_token]
    end
end


local function CurrentLocationData()
    if _G.GetCurrentMapAreaID() ~= current_area_id then
        return _G.GetRealZoneText(), current_area_id, 0, 0, 0, InstanceDifficultyToken()
    end
    local map_level = _G.GetCurrentMapDungeonLevel() or 0
    local x, y = _G.GetPlayerMapPosition("player")

    x = x or 0
    y = y or 0

    if x == 0 and y == 0 then
        for level_index = 1, _G.GetNumDungeonMapLevels() do
            _G.SetDungeonMapLevel(level_index)
            x, y = _G.GetPlayerMapPosition("player")

            if x and y and (x > 0 or y > 0) then
                _G.SetDungeonMapLevel(map_level)
                map_level = level_index
                break
            end
        end
    end

    if _G.DungeonUsesTerrainMap() then
        map_level = map_level - 1
    end
    local x = _G.floor(x * 1000)
    local y = _G.floor(y * 1000)

    if x % 2 ~= 0 then
        x = x + 1
    end

    if y % 2 ~= 0 then
        y = y + 1
    end
    return _G.GetRealZoneText(), current_area_id, x, y, map_level, InstanceDifficultyToken()
end


local function ItemLinkToID(item_link)
    if not item_link then
        return
    end
    return tonumber(item_link:match("item:(%d+)"))
end

private.ItemLinkToID = ItemLinkToID

local function UnitTypeIsNPC(unit_type)
    return unit_type == private.UNIT_TYPES.NPC or unit_type == private.UNIT_TYPES.VEHICLE
end


local ParseGUID
do
    local UNIT_TYPES = private.UNIT_TYPES
    local UNIT_TYPE_BITMASK = 0x007

    local NPC_ID_MAPPING = {
        [62164] = 63191, -- Garalon
    }


    function ParseGUID(guid)
        if not guid then
            return
        end
        local bitfield = tonumber(guid:sub(1, 5))

        if not bitfield then
            return UNIT_TYPES.UNKNOWN
        end
        local unit_type = _G.bit.band(bitfield, UNIT_TYPE_BITMASK)

        if unit_type ~= UNIT_TYPES.PLAYER and unit_type ~= UNIT_TYPES.PET then
            local unit_idnum = tonumber(guid:sub(6, 10), 16)
            local id_mapping = NPC_ID_MAPPING[unit_idnum]

            if id_mapping and UnitTypeIsNPC(unit_type) then
                unit_idnum = id_mapping
            end
            return unit_type, unit_idnum
        end
        return unit_type
    end

    private.ParseGUID = ParseGUID
end -- do-block


local UpdateDBEntryLocation
do
    -- Fishing node coordinate code based on code in GatherMate2 with permission from Kagaro.
    local function FishingCoordinates(x, y, yard_width, yard_height)
        local facing = _G.GetPlayerFacing()

        if not facing then
            return x, y
        end
        local rad = facing + math.pi
        return x + math.sin(rad) * 15 / yard_width, y + math.cos(rad) * 15 / yard_height
    end


    function UpdateDBEntryLocation(entry_type, identifier)
        if not identifier then
            return
        end
        local zone_name, area_id, x, y, map_level, difficulty_token = CurrentLocationData()
        local entry = DBEntry(entry_type, identifier)
        entry[difficulty_token] = entry[difficulty_token] or {}
        entry[difficulty_token].locations = entry[difficulty_token].locations or {}

        local zone_token = ("%s:%d"):format(zone_name, area_id)
        local zone_data = entry[difficulty_token].locations[zone_token]

        if not zone_data then
            zone_data = {}
            entry[difficulty_token].locations[zone_token] = zone_data
        end

        -- Special case for Fishing.
        if current_action.spell_label == "FISHING" then
            local yard_width, yard_height = MapData:MapArea(area_id, map_level)

            if yard_width > 0 and yard_height > 0 then
                x, y = FishingCoordinates(x, y, yard_width, yard_height)
                current_action.x = x
                current_action.y = y
            end
        end
        local location_token = ("%d:%d:%d"):format(map_level, x, y)

        zone_data[location_token] = zone_data[location_token] or true
        return zone_data
    end
end -- do-block


local function HandleItemUse(item_link, bag_index, slot_index)
    if not item_link then
        return
    end
    local item_id = ItemLinkToID(item_link)

    if not bag_index or not slot_index then
        for new_bag_index = 0, _G.NUM_BAG_FRAMES do
            for new_slot_index = 1, _G.GetContainerNumSlots(new_bag_index) do
                if item_id == ItemLinkToID(_G.GetContainerItemLink(new_bag_index, new_slot_index)) then
                    bag_index = new_bag_index
                    slot_index = new_slot_index
                    break
                end
            end
        end
    end

    if not bag_index or not slot_index then
        return
    end
    local _, _, _, _, _, is_lootable = _G.GetContainerItemInfo(bag_index, slot_index)

    if not is_lootable then
        return
    end
    DatamineTT:ClearLines()
    DatamineTT:SetBagItem(bag_index, slot_index)

    for line_index = 1, DatamineTT:NumLines() do
        local current_line = _G["WDPDatamineTTTextLeft" .. line_index]

        if not current_line then
            break
        end
        local is_ptr = select(4, _G.GetBuildInfo()) ~= 50100

        if is_ptr or current_line:GetText() == _G.ITEM_OPENABLE then
            table.wipe(current_action)
            current_action.target_type = AF.ITEM
            current_action.identifier = item_id
            current_action.loot_label = "contains"
            break
        end
    end
end


local UnitFactionStanding
local UpdateFactionData
do
    local MAX_FACTION_INDEX = 1000

    local STANDING_NAMES = {
        "HATED",
        "HOSTILE",
        "UNFRIENDLY",
        "NEUTRAL",
        "FRIENDLY",
        "HONORED",
        "REVERED",
        "EXALTED",
    }


    function UnitFactionStanding(unit)
        local unit_name = _G.UnitName(unit)
        UpdateFactionData()
        DatamineTT:ClearLines()
        DatamineTT:SetUnit(unit)

        for line_index = 1, DatamineTT:NumLines() do
            local faction_name = _G["WDPDatamineTTTextLeft" .. line_index]:GetText():trim()

            if faction_name and faction_name ~= unit_name and faction_standings[faction_name] then
                return faction_name, faction_standings[faction_name]
            end
        end
    end


    function UpdateFactionData()
        for faction_index = 1, MAX_FACTION_INDEX do
            local faction_name, _, current_standing, _, _, _, _, _, is_header = _G.GetFactionInfo(faction_index)

            if faction_name then
                faction_standings[faction_name] = STANDING_NAMES[current_standing]
            elseif not faction_name then
                break
            end
        end
    end
end -- do-block


local GenericLootUpdate
do
    local function LootTable(entry, loot_type, top_field)
        if top_field then
            entry[top_field] = entry[top_field] or {}
            entry[top_field][loot_type] = entry[top_field][loot_type] or {}
            return entry[top_field][loot_type]
        end
        entry[loot_type] = entry[loot_type] or {}
        return entry[loot_type]
    end

    function GenericLootUpdate(data_type, top_field)
        local loot_type = current_loot.label
        local loot_count = ("%s_count"):format(loot_type)
        local source_list = {}

        if current_loot.sources then
            for source_guid, loot_data in pairs(current_loot.sources) do
                local entry, source_id

                if current_loot.target_type == AF.ITEM then
                    -- Items return the player as the source, so we need to use the item's ID (disenchant, milling, etc)
                    source_id = current_loot.identifier
                    entry = DBEntry(data_type, source_id)
                elseif current_loot.target_type == AF.OBJECT then
                    source_id = ("%s:%s"):format(current_loot.spell_label, select(2, ParseGUID(source_guid)))
                    entry = DBEntry(data_type, source_id)
                else
                    source_id = select(2, ParseGUID(source_guid))
                    entry = DBEntry(data_type, source_id)
                end

                if entry then
                    local loot_table = LootTable(entry, loot_type, top_field)

                    if not source_list[source_guid] then
                        if top_field then
                            entry[top_field][loot_count] = (entry[top_field][loot_count] or 0) + 1
                        else
                            entry[loot_count] = (entry[loot_count] or 0) + 1
                        end
                        source_list[source_guid] = true
                    end
                    UpdateDBEntryLocation(data_type, source_id)

                    for item_id, quantity in pairs(loot_data) do
                        table.insert(loot_table, ("%d:%d"):format(item_id, quantity))
                    end
                end
            end
        end

        -- This is used for Gas Extractions.
        if #current_loot.list <= 0 then
            return
        end
        local entry

        -- At this point we only have a name if it's an object.
        if current_loot.target_type == AF.OBJECT then
            entry = DBEntry(data_type, ("%s:%s"):format(current_loot.spell_label, current_loot.object_name))
        else
            entry = DBEntry(data_type, current_loot.identifier)
        end

        if not entry then
            return
        end
        local loot_table = LootTable(entry, loot_type, top_field)

        if not source_list[current_loot.identifier] then
            if top_field then
                entry[top_field][loot_count] = (entry[top_field][loot_count] or 0) + 1
            else
                entry[loot_count] = (entry[loot_count] or 0) + 1
            end
        end

        for index = 1, #current_loot.list do
            table.insert(loot_table, current_loot.list[index])
        end
    end
end -- do-block


local ReplaceKeywords
do
    local KEYWORD_SUBSTITUTIONS = {
        class = PLAYER_CLASS,
        name = PLAYER_NAME,
        race = PLAYER_RACE,
    }


    function ReplaceKeywords(text)
        if not text or text == "" then
            return ""
        end

        for category, lookup in pairs(KEYWORD_SUBSTITUTIONS) do
            local category_format = ("<%s>"):format(category)
            text = text:gsub(lookup, category_format):gsub(lookup:lower(), category_format)
        end
        return text
    end
end -- do-block


-- Contains a dirty hack due to Blizzard's strange handling of Micro Dungeons; GetMapInfo() will not return correct information
-- unless the WorldMapFrame is shown.
do
    -- MapFileName = MapAreaID
    local MICRO_DUNGEON_IDS = {
        ShrineofTwoMoons = 903,
        ShrineofSevenStars = 905,
    }

    function WDP:SetCurrentAreaID(event_name)
        if private.in_combat then
            private.set_area_id = true
            return
        end
        local map_area_id = _G.GetCurrentMapAreaID()

        if map_area_id == current_area_id then
            return
        end
        local world_map = _G.WorldMapFrame
        local map_visible = world_map:IsVisible()
        local sfx_value = _G.tonumber(_G.GetCVar("Sound_EnableSFX"))

        if not map_visible then
            _G.SetCVar("Sound_EnableSFX", 0)
            world_map:Show()
        end
        local micro_dungeon_id = MICRO_DUNGEON_IDS[select(5, _G.GetMapInfo())]

        _G.SetMapToCurrentZone()

        if micro_dungeon_id then
            current_area_id = micro_dungeon_id
        else
            current_area_id = _G.GetCurrentMapAreaID()
        end

        if map_visible then
            _G.SetMapByID(map_area_id)
        else
            world_map:Hide()
            _G.SetCVar("Sound_EnableSFX", sfx_value)
        end
    end
end


-- METHODS ------------------------------------------------------------

function WDP:OnInitialize()
    local db = LibStub("AceDB-3.0"):New("WoWDBProfilerData", DATABASE_DEFAULTS, "Default")
    private.db = db
    global_db = db.global
    char_db = db.char

    local raw_db = _G.WoWDBProfilerData
    local build_num = tonumber(private.build_num)

    if (raw_db.version and raw_db.version < DB_VERSION) or (raw_db.build_num and raw_db.build_num < build_num) then
        for entry in pairs(DATABASE_DEFAULTS.global) do
            global_db[entry] = {}
        end
    end
    raw_db.build_num = build_num
    raw_db.version = DB_VERSION

    if DEBUGGING then -- TODO: Remove this when comment subsystem is finished.
        private.InitializeCommentSystem()
        self:RegisterChatCommand("comment", private.ProcessCommentCommand)
    end
end


function WDP:EventDispatcher(...)
    local event_name = ...

    if DEBUGGING then
        if event_name == "COMBAT_LOG_EVENT_UNFILTERED" then
            Debug(event_name)
        else
            Debug(...)
        end
    end
    local func = EVENT_MAPPING[event_name]

    if _G.type(func) == "boolean" then
        self[event_name](self, ...)
    elseif _G.type(func) == "function" then
        self[func](self, ...)
    end
end


function WDP:OnEnable()
    for event_name, mapping in pairs(EVENT_MAPPING) do
        if EVENT_DEBUG then
            self:RegisterEvent(event_name, "EventDispatcher")
        else
            self:RegisterEvent(event_name, (_G.type(mapping) ~= "boolean") and mapping or nil)
        end
    end

    for index = 1, _G.GetNumLanguages() do
        languages_known[_G.GetLanguageByIndex(index)] = true
    end
    item_process_timer_handle = self:ScheduleRepeatingTimer("ProcessItems", 30)
    target_location_timer_handle = self:ScheduleRepeatingTimer("UpdateTargetLocation", 0.5)

    _G.hooksecurefunc("UseContainerItem", function(bag_index, slot_index, target_unit)
        if target_unit then
            return
        end
        HandleItemUse(_G.GetContainerItemLink(bag_index, slot_index), bag_index, slot_index)
    end)

    _G.hooksecurefunc("UseItemByName", function(identifier, target_unit)
        if target_unit then
            return
        end
        local _, item_link = _G.GetItemInfo(identifier)
        HandleItemUse(item_link)
    end)

    self:SetCurrentAreaID("OnEnable")
    self:GROUP_ROSTER_UPDATE()
end


local ScrapeItemUpgradeStats
do
    local intermediary = {}

    function ScrapeItemUpgradeStats(item_id, upgrade_id, reforge_id)
        if not ALLOWED_LOCALES[CLIENT_LOCALE] then
            return
        end
        local create_entry

        table.wipe(intermediary)

        for line_index = 1, DatamineTT:NumLines() do
            local left_text = _G["WDPDatamineTTTextLeft" .. line_index]:GetText()

            if not left_text then
                return
            end
            local amount, stat = left_text:match("+(.-) (.*)")

            if amount and stat then
                if reforge_id and reforge_id ~= 0 then
                    local reforge_string = stat:find("Reforged")

                    if reforge_string then
                        stat = stat:sub(0, reforge_string - 3)
                        intermediary.reforge_id = reforge_id
                    end
                end
                create_entry = true
                intermediary[stat:lower():gsub(" ", "_"):gsub("|r", "")] = tonumber(amount)
            end
        end

        if not create_entry then
            return
        end
        local item = DBEntry("items", item_id)
        item.upgrade_id = upgrade_id
        item.upgrades = item.upgrades or {}
        item.upgrades[upgrade_id] = item.upgrades[upgrade_id] or {}

        for stat, amount in pairs(intermediary) do
            item.upgrades[upgrade_id][stat] = amount
        end
    end
end

-- do-block


local function RecordItemData(item_id, item_link, durability)
    local item_string = select(3, item_link:find("^|%x+|H(.+)|h%[.+%]"))
    local item

    if item_string then
        local _, _, _, _, _, _, _, suffix_id, unique_id, _, reforge_id, upgrade_id = (":"):split(item_string)
        suffix_id = tonumber(suffix_id)
        upgrade_id = tonumber(upgrade_id)

        if suffix_id and suffix_id ~= 0 then
            item = DBEntry("items", item_id)
            item.suffix_id = suffix_id
            item.unique_id = bit.band(unique_id, 0xFFFF)
        end

        if upgrade_id and upgrade_id ~= 0 then
            DatamineTT:SetHyperlink(item_link)
            ScrapeItemUpgradeStats(item_id, upgrade_id, reforge_id)
        end
    end

    if durability and durability > 0 then
        item = item or DBEntry("items", item_id)
        item.durability = durability
    end
end


function WDP:ProcessItems()
    for slot_index = _G.INVSLOT_FIRST_EQUIPPED, _G.INVSLOT_LAST_EQUIPPED do
        local item_id = _G.GetInventoryItemID("player", slot_index)

        if item_id and item_id > 0 then
            local _, max_durability = _G.GetInventoryItemDurability(slot_index)
            RecordItemData(item_id, _G.GetInventoryItemLink("player", slot_index), max_durability)
        end
    end

    for bag_index = 0, _G.NUM_BAG_SLOTS do
        for slot_index = 1, _G.GetContainerNumSlots(bag_index) do
            local item_id = _G.GetContainerItemID(bag_index, slot_index)

            if item_id and item_id > 0 then
                local _, max_durability = _G.GetContainerItemDurability(bag_index, slot_index)
                RecordItemData(item_id, _G.GetContainerItemLink(bag_index, slot_index), max_durability)
            end
        end
    end
end


local TargetedNPC
do
    local GENDER_NAMES = {
        "UNKNOWN",
        "MALE",
        "FEMALE",
    }


    local REACTION_NAMES = {
        "HATED",
        "HOSTILE",
        "UNFRIENDLY",
        "NEUTRAL",
        "FRIENDLY",
        "HONORED",
        "REVERED",
        "EXALTED",
    }


    local POWER_TYPE_NAMES = {
        ["0"] = "MANA",
        ["1"] = "RAGE",
        ["2"] = "FOCUS",
        ["3"] = "ENERGY",
        ["6"] = "RUNIC_POWER",
    }


    function TargetedNPC()
        if not _G.UnitExists("target") or _G.UnitPlayerControlled("target") or currently_drunk then
            current_target_id = nil
            return
        end
        local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("target"))

        if not unit_idnum or not UnitTypeIsNPC(unit_type) then
            return
        end
        current_target_id = unit_idnum

        local npc = NPCEntry(unit_idnum)
        local _, class_token = _G.UnitClass("target")
        npc.class = class_token
        npc.faction = UnitFactionStanding("target")
        npc.genders = npc.genders or {}
        npc.genders[GENDER_NAMES[_G.UnitSex("target")] or "UNDEFINED"] = true
        npc.is_pvp = _G.UnitIsPVP("target") and true or nil
        npc.reaction = ("%s:%s:%s"):format(_G.UnitLevel("player"), _G.UnitFactionGroup("player"), REACTION_NAMES[_G.UnitReaction("player", "target")])

        local encounter_data = npc:EncounterData(InstanceDifficultyToken()).stats
        local npc_level = ("level_%d"):format(_G.UnitLevel("target"))
        local level_data = encounter_data[npc_level]

        if not level_data then
            level_data = {}
            encounter_data[npc_level] = level_data
        end
        level_data.max_health = level_data.max_health or _G.UnitHealthMax("target")

        if not level_data.power then
            local max_power = _G.UnitManaMax("target")

            if max_power > 0 then
                local power_type = _G.UnitPowerType("target")
                level_data.power = ("%s:%d"):format(POWER_TYPE_NAMES[_G.tostring(power_type)] or power_type, max_power)
            end
        end
        name_to_id_map[_G.UnitName("target")] = unit_idnum
        return npc, unit_idnum
    end
end -- do-block


do
    local COORD_MAX = 5

    function WDP:UpdateTargetLocation()
        if currently_drunk or not _G.UnitExists("target") or _G.UnitPlayerControlled("target") or (_G.UnitIsTapped("target") and not _G.UnitIsDead("target")) then
            return
        end

        for index = 1, 4 do
            if not _G.CheckInteractDistance("target", index) then
                return
            end
        end
        local npc = TargetedNPC()

        if not npc then
            return
        end
        local zone_name, area_id, x, y, map_level, difficulty_token = CurrentLocationData()
        local npc_data = npc:EncounterData(difficulty_token).stats[("level_%d"):format(_G.UnitLevel("target"))]
        local zone_token = ("%s:%d"):format(zone_name, area_id)
        npc_data.locations = npc_data.locations or {} -- TODO: Fix this. It is broken. Possibly something to do with the timed updates.

        local zone_data = npc_data.locations[zone_token]

        if not zone_data then
            zone_data = {}
            npc_data.locations[zone_token] = zone_data
        end

        for location_token in pairs(zone_data) do
            local loc_level, loc_x, loc_y = (":"):split(location_token)
            loc_level = tonumber(loc_level)

            if map_level == loc_level and math.abs(x - loc_x) <= COORD_MAX and math.abs(y - loc_y) <= COORD_MAX then
                return
            end
        end
        zone_data[("%d:%d:%d"):format(map_level, x, y)] = true
    end
end -- do-block


-- EVENT HANDLERS -----------------------------------------------------

function WDP:BLACK_MARKET_ITEM_UPDATE(event_name)
    if not ALLOWED_LOCALES[CLIENT_LOCALE] then
        return
    end
    local num_items = _G.C_BlackMarket.GetNumItems() or 0

    for index = 1, num_items do
        local name, texture, quantity, item_type, is_usable, level, level_type, seller_name, min_bid, min_increment, current_bid, has_high_bid, num_bids, time_left, item_link, market_id = _G.C_BlackMarket.GetItemInfoByIndex(index);

        if item_link then
            DBEntry("items", ItemLinkToID(item_link)).black_market = seller_name or "UNKNOWN"
        end
    end
end


function WDP:GROUP_ROSTER_UPDATE()
    local is_raid = _G.IsInRaid()
    local unit_type = is_raid and "raid" or "party"
    local group_size = is_raid and _G.GetNumGroupMembers() or _G.GetNumSubgroupMembers()

    table.wipe(group_member_uids)

    Debug("GROUP_ROSTER_UPDATE: %s group - %d members.", unit_type, group_size)

    for index = 1, group_size do
        local group_unit = unit_type .. index
        local unit_guid = _G.UnitGUID(group_unit)

        Debug("%s (%s) added as GUID %s", group_unit, _G.UnitName(group_unit), unit_guid)
        group_member_uids[unit_guid] = true
    end
    group_member_uids[_G.UnitGUID("player")] = true
end


function WDP:UNIT_PET(event_name, unit_id)
    local unit_guid = _G.UnitGUID(unit_id)
    local current_pet_guid = group_owner_guids_to_pet_guids[unit_guid]

    if current_pet_guid then
        Debug("Removing existing pet GUID for %s", _G.UnitName(unit_id))
        group_owner_guids_to_pet_guids[unit_guid] = nil
        group_pet_guids[current_pet_guid] = nil
    end
    local pet_guid = _G.UnitGUID(unit_id .. "pet")

    if pet_guid then
        Debug("Adding new pet GUID for %s.", _G.UnitName(unit_id))
        group_owner_guids_to_pet_guids[unit_id] = pet_guid
        group_pet_guids[pet_guid] = true
    end
end


function WDP:SHOW_LOOT_TOAST(event_name, loot_type, item_link, quantity)
    if loot_type ~= "item" then
        return
    end
    local npc = NPCEntry(private.raid_finder_boss_id or private.world_boss_id)
    ClearKilledBossID()

    if not npc then
        Debug("%s: NPC is nil.", event_name)
        return
    end
    local item_id = ItemLinkToID(item_link)

    if not item_id then
        Debug("%s: ItemID is nil, from item link %s", event_name, item_link)
        return
    end
    local loot_type = "drops"
    local encounter_data = npc:EncounterData(InstanceDifficultyToken())
    encounter_data[loot_type] = encounter_data[loot_type] or {}
    encounter_data.loot_counts = encounter_data.loot_counts or {}
    encounter_data.loot_counts[loot_type] = (encounter_data.loot_counts[loot_type] or 0) + 1

    table.insert(encounter_data[loot_type], ("%d:%d"):format(item_id, quantity))
    Debug("%s: %sX%d (%d)", event_name, item_link, quantity, item_id)
end


do
    local CHAT_MSG_LOOT_UPDATE_FUNCS = {
        [AF.NPC] = function(item_id, quantity)
            Debug("CHAT_MSG_LOOT: %d (%d)", item_id, quantity)
        end,
        [AF.ZONE] = function(item_id, quantity)
            current_loot = {
                list = {
                    ("%d:%d"):format(item_id, quantity)
                },
                identifier = current_action.identifier,
                label = current_action.loot_label or "drops",
                map_level = current_action.map_level,
                object_name = current_action.object_name,
                spell_label = current_action.spell_label,
                target_type = current_action.target_type,
                x = current_action.x,
                y = current_action.y,
                zone_data = current_action.zone_data,
            }
            table.wipe(current_action)
            GenericLootUpdate("zones")
        end,
    }


    function WDP:CHAT_MSG_LOOT(event_name, message)
        local category

        if current_action.spell_label ~= "EXTRACT_GAS" then
            category = AF.ZONE
        elseif private.raid_finder_boss_id then
            category = AF.NPC
        end
        local update_func = CHAT_MSG_LOOT_UPDATE_FUNCS[category]

        if not category or not update_func then
            return
        end
        local item_link, quantity = deformat(message, _G.LOOT_ITEM_PUSHED_SELF_MULTIPLE)

        if not item_link then
            quantity, item_link = 1, deformat(message, _G.LOOT_ITEM_PUSHED_SELF)
        end
        local item_id = ItemLinkToID(item_link)

        if not item_id then
            return
        end
        update_func(item_id, quantity)
    end
end

function WDP:RecordQuote(event_name, message, source_name, language_name)
    if not ALLOWED_LOCALES[CLIENT_LOCALE] or not source_name or not name_to_id_map[source_name] or (language_name ~= "" and not languages_known[language_name]) then
        return
    end
    local npc = NPCEntry(name_to_id_map[source_name])
    npc.quotes = npc.quotes or {}
    npc.quotes[event_name] = npc.quotes[event_name] or {}
    npc.quotes[event_name][ReplaceKeywords(message)] = true
end


do
    local SOBER_MATCH = _G.DRUNK_MESSAGE_ITEM_SELF1:gsub("%%s", ".+")

    local DRUNK_COMPARES = {
        _G.DRUNK_MESSAGE_SELF2,
        _G.DRUNK_MESSAGE_SELF3,
        _G.DRUNK_MESSAGE_SELF4,
    }

    local DRUNK_MATCHES = {
        (_G.DRUNK_MESSAGE_SELF2:gsub("%%s", ".+")),
        (_G.DRUNK_MESSAGE_SELF3:gsub("%%s", ".+")),
        (_G.DRUNK_MESSAGE_SELF4:gsub("%%s", ".+")),
    }

    local RECIPE_MATCH = _G.ERR_LEARN_RECIPE_S:gsub("%%s", "(.*)")


    local function RecordDiscovery(tradeskill_name, tradeskill_index)
        if tradeskill_name == private.discovered_recipe_name then
            DBEntry("spells", tonumber(_G.GetTradeSkillRecipeLink(tradeskill_index):match("^|c%x%x%x%x%x%x%x%x|H%w+:(%d+)"))).discovery = ("%d:%d"):format(private.previous_spell_id, private.profession_level)

            private.discovered_recipe_name = nil
            private.profession_level = nil
            private.previous_spell_id = nil

            return true
        end
    end


    local function IterativeRecordDiscovery()
        TradeSkillExecutePer(RecordDiscovery)
    end


    function WDP:CHAT_MSG_SYSTEM(event_name, message)
        if not private.trainer_shown then
            local recipe_name = message:match(RECIPE_MATCH)

            if recipe_name and private.previous_spell_id then
                local profession_name, prof_level = _G.GetTradeSkillLine()

                if profession_name == _G.UNKNOWN then
                    return
                end
                private.discovered_recipe_name = recipe_name
                private.profession_level = prof_level

                self:ScheduleTimer(IterativeRecordDiscovery, 0.2)
            end
        end

        if currently_drunk then
            if message == _G.DRUNK_MESSAGE_SELF1 or message:match(SOBER_MATCH) then
                currently_drunk = nil
            end
            return
        end

        for index = 1, #DRUNK_MATCHES do
            if message == DRUNK_COMPARES[index] or message:match(DRUNK_MATCHES[index]) then
                currently_drunk = true
                break
            end
        end
    end
end

-- do-block

do
    local FLAGS_NPC = bit.bor(_G.COMBATLOG_OBJECT_TYPE_GUARDIAN, _G.COMBATLOG_OBJECT_CONTROL_NPC)
    local FLAGS_NPC_CONTROL = bit.bor(_G.COMBATLOG_OBJECT_AFFILIATION_OUTSIDER, _G.COMBATLOG_OBJECT_CONTROL_NPC)

    local function RecordNPCSpell(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name)
        if not spell_id then
            return
        end
        local source_type, source_id = ParseGUID(source_guid)

        if not source_id or not UnitTypeIsNPC(source_type) then
            return
        end

        if bit.band(FLAGS_NPC_CONTROL, source_flags) == FLAGS_NPC_CONTROL and bit.band(FLAGS_NPC, source_flags) ~= 0 then
            local encounter_data = NPCEntry(source_id):EncounterData(InstanceDifficultyToken())
            encounter_data.spells = encounter_data.spells or {}
            encounter_data.spells[spell_id] = (encounter_data.spells[spell_id] or 0) + 1
        end
    end

    local HEAL_BATTLE_PETS_SPELL_ID = 125801

    local previous_combat_event = {}

    local COMBAT_LOG_FUNCS = {
        SPELL_AURA_APPLIED = RecordNPCSpell,
        SPELL_CAST_START = RecordNPCSpell,
        SPELL_CAST_SUCCESS = function(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name)
            if spell_id == HEAL_BATTLE_PETS_SPELL_ID then
                local unit_type, unit_idnum = ParseGUID(source_guid)

                if unit_idnum and UnitTypeIsNPC(unit_type) then
                    NPCEntry(unit_idnum).stable_master = true
                end
            end
            RecordNPCSpell(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name)
        end,
        UNIT_DIED = function(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, spell_id, spell_name)
            local unit_type, unit_idnum = ParseGUID(dest_guid)

            if not unit_idnum or not UnitTypeIsNPC(unit_type) then
                Debug("%s: %s is not an NPC, or has no ID.", sub_event, dest_name or _G.UNKNOWN)
                ClearKilledNPC()
                ClearKilledBossID()
                private.harvesting = nil
                return
            end

            if source_guid == "" then
                source_guid = nil
            end
            local killer_guid = source_guid or previous_combat_event.source_guid
            local killer_name = source_name or previous_combat_event.source_name

            if not group_member_uids[killer_guid] and not group_pet_guids[killer_guid] then
                Debug("%s: %s was killed by %s (not group member or pet).", sub_event, dest_name or _G.UNKNOWN, killer_name or _G.UNKNOWN)
                ClearKilledNPC()
                ClearKilledBossID()
                return
            end
            Debug("%s: %s was killed by %s.", sub_event, dest_name or _G.UNKNOWN, killer_name or _G.UNKNOWN)

            if private.RAID_FINDER_BOSS_IDS[unit_idnum] then
                Debug("%s: Matching boss %s.", sub_event, dest_name)
                ClearKilledBossID()
                private.raid_finder_boss_id = unit_idnum
            elseif private.WORLD_BOSS_IDS[unit_idnum] then
                Debug("%s: Matching world boss %s.", sub_event, dest_name)
                ClearKilledBossID()
                private.world_boss_id = unit_idnum
            else
                Debug("%s: Killed NPC %s (ID: %d) is not in LFG or World boss list.", sub_event, dest_name, unit_idnum)
            end

            killed_npc_id = unit_idnum
            WDP:ScheduleTimer(ClearKilledNPC, 0.1)
            WDP:ScheduleTimer(ClearKilledBossID, 1)
        end,
    }


    local NON_DAMAGE_EVENTS = {
        SPELL_AURA_APPLIED = true,
        SPELL_AURA_REMOVED = true,
        SPELL_AURA_REMOVED_DOSE = true,
        SPELL_CAST_FAILED = true,
        SWING_MISSED = true,
    }


    function WDP:COMBAT_LOG_EVENT_UNFILTERED(event_name, time_stamp, sub_event, hide_caster, source_guid, source_name, source_flags, source_raid_flags, dest_guid, dest_name, dest_flags, dest_raid_flags, ...)
        local combat_log_func = COMBAT_LOG_FUNCS[sub_event]

        if not combat_log_func then
            if not NON_DAMAGE_EVENTS[sub_event] then
                -- Uncomment to look for other sub-events to blacklist.
                --                Debug("Recording for %s", sub_event)
                previous_combat_event.source_guid = source_guid
                previous_combat_event.source_name = source_name
                previous_combat_event.dest_guid = dest_guid
                previous_combat_event.dest_name = dest_name
            end
            return
        end
        combat_log_func(sub_event, source_guid, source_name, source_flags, dest_guid, dest_name, dest_flags, ...)
        table.wipe(previous_combat_event)
    end

    local DIPLOMACY_SPELL_ID = 20599
    local MR_POP_RANK1_SPELL_ID = 78634
    local MR_POP_RANK2_SPELL_ID = 78635

    local REP_BUFFS = {
        [_G.GetSpellInfo(30754)] = "CENARION_FAVOR",
        [_G.GetSpellInfo(24705)] = "GRIM_VISAGE",
        [_G.GetSpellInfo(32098)] = "HONOR_HOLD_FAVOR",
        [_G.GetSpellInfo(39913)] = "NAZGRELS_FERVOR",
        [_G.GetSpellInfo(39953)] = "SONG_OF_BATTLE",
        [_G.GetSpellInfo(61849)] = "SPIRIT_OF_SHARING",
        [_G.GetSpellInfo(32096)] = "THRALLMARS_FAVOR",
        [_G.GetSpellInfo(39911)] = "TROLLBANES_COMMAND",
        [_G.GetSpellInfo(95987)] = "UNBURDENED",
        [_G.GetSpellInfo(100951)] = "WOW_ANNIVERSARY",
    }


    local FACTION_NAMES = {
        CENARION_CIRCLE = _G.GetFactionInfoByID(609),
        HONOR_HOLD = _G.GetFactionInfoByID(946),
        THE_SHATAR = _G.GetFactionInfoByID(935),
        THRALLMAR = _G.GetFactionInfoByID(947),
    }


    local MODIFIERS = {
        CENARION_FAVOR = {
            faction = FACTION_NAMES.CENARION_CIRCLE,
            modifier = 0.25,
        },
        GRIM_VISAGE = {
            modifier = 0.1,
        },
        HONOR_HOLD_FAVOR = {
            faction = FACTION_NAMES.HONOR_HOLD,
            modifier = 0.25,
        },
        NAZGRELS_FERVOR = {
            faction = FACTION_NAMES.THRALLMAR,
            modifier = 0.1,
        },
        SONG_OF_BATTLE = {
            faction = FACTION_NAMES.THE_SHATAR,
            modifier = 0.1,
        },
        SPIRIT_OF_SHARING = {
            modifier = 0.1,
        },
        THRALLMARS_FAVOR = {
            faction = FACTION_NAMES.THRALLMAR,
            modifier = 0.25,
        },
        TROLLBANES_COMMAND = {
            faction = FACTION_NAMES.HONOR_HOLD,
            modifier = 0.1,
        },
        UNBURDENED = {
            modifier = 0.1,
        },
        WOW_ANNIVERSARY = {
            modifier = 0.08,
        }
    }


    function WDP:COMBAT_TEXT_UPDATE(event_name, message_type, faction_name, amount)
        if message_type ~= "FACTION" or not killed_npc_id then
            return
        end
        UpdateFactionData()

        if not faction_name or not faction_standings[faction_name] then
            return
        end
        local npc = NPCEntry(killed_npc_id)
        ClearKilledNPC()

        if not npc then
            private.harvesting = nil
            return
        end
        npc.harvested = private.harvesting
        private.harvesting = nil

        local modifier = 1

        if _G.IsSpellKnown(DIPLOMACY_SPELL_ID) then
            modifier = modifier + 0.1
        end

        if _G.IsSpellKnown(MR_POP_RANK2_SPELL_ID) then
            modifier = modifier + 0.1
        elseif _G.IsSpellKnown(MR_POP_RANK1_SPELL_ID) then
            modifier = modifier + 0.05
        end

        for buff_name, buff_label in pairs(REP_BUFFS) do
            if _G.UnitBuff("player", buff_name) then
                local modded_faction = MODIFIERS[buff_label].faction

                if not modded_faction or faction_name == modded_faction then
                    modifier = modifier + MODIFIERS[buff_label].modifier
                end
            end
        end
        npc.reputations = npc.reputations or {}
        npc.reputations[("%s:%s"):format(faction_name, faction_standings[faction_name])] = math.floor(amount / modifier)
    end
end -- do-block


function WDP:CURSOR_UPDATE(event_name)
    if current_action.fishing_target or _G.Minimap:IsMouseOver() or current_action.spell_label ~= "FISHING" then
        return
    end
    local text = _G["GameTooltipTextLeft1"]:GetText()

    if not text or text == "Fishing Bobber" then
        text = "NONE"
    else
        current_action.fishing_target = true
    end
    current_action.identifier = ("%s:%s"):format(current_action.spell_label, text)
end


function WDP:ITEM_TEXT_BEGIN(event_name)
    local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))

    if not unit_idnum or unit_type ~= private.UNIT_TYPES.OBJECT or _G.UnitName("npc") ~= _G.ItemTextGetItem() then
        return
    end
    UpdateDBEntryLocation("objects", unit_idnum)
end


do
    local RE_GOLD = _G.GOLD_AMOUNT:gsub("%%d", "(%%d+)")
    local RE_SILVER = _G.SILVER_AMOUNT:gsub("%%d", "(%%d+)")
    local RE_COPPER = _G.COPPER_AMOUNT:gsub("%%d", "(%%d+)")


    local function _moneyMatch(money, re)
        return money:match(re) or 0
    end


    local function _toCopper(money)
        if not money then
            return 0
        end
        return _moneyMatch(money, RE_GOLD) * 10000 + _moneyMatch(money, RE_SILVER) * 100 + _moneyMatch(money, RE_COPPER)
    end


    local LOOT_OPENED_VERIFY_FUNCS = {
        [AF.ITEM] = function()
            local locked_item_id

            for bag_index = 0, _G.NUM_BAG_FRAMES do
                for slot_index = 1, _G.GetContainerNumSlots(bag_index) do
                    local _, _, is_locked = _G.GetContainerItemInfo(bag_index, slot_index)

                    if is_locked then
                        locked_item_id = ItemLinkToID(_G.GetContainerItemLink(bag_index, slot_index))
                        break
                    end
                end

                if locked_item_id then
                    break
                end
            end

            if not locked_item_id or (current_action.identifier and current_action.identifier ~= locked_item_id) then
                return false
            end
            current_action.identifier = locked_item_id
            return true
        end,
        [AF.NPC] = function()
            if not _G.UnitExists("target") or _G.UnitIsFriend("player", "target") or _G.UnitIsPlayer("target") or _G.UnitPlayerControlled("target") then
                return false
            end

            if not current_action.identifier then
                local unit_type, id_num = ParseGUID(_G.UnitGUID("target"))
                current_action.identifier = id_num
            end
            return true
        end,
        [AF.OBJECT] = true,
        [AF.ZONE] = function()
            current_action.zone_data = UpdateDBEntryLocation("zones", current_action.identifier)
            return _G.IsFishingLoot()
        end,
    }


    local LOOT_OPENED_UPDATE_FUNCS = {
        [AF.ITEM] = function()
            GenericLootUpdate("items")
        end,
        [AF.NPC] = function()
            local difficulty_token = InstanceDifficultyToken()
            local loot_type = current_loot.label
            local source_list = {}

            for source_guid, loot_data in pairs(current_loot.sources) do
                local source_id = select(2, ParseGUID(source_guid))
                local npc = NPCEntry(source_id)

                if npc then
                    local encounter_data = npc:EncounterData(difficulty_token)
                    encounter_data[loot_type] = encounter_data[loot_type] or {}

                    if not source_list[source_guid] then
                        encounter_data.loot_counts = encounter_data.loot_counts or {}
                        encounter_data.loot_counts[loot_type] = (encounter_data.loot_counts[loot_type] or 0) + 1
                        source_list[source_id] = true
                    end

                    for item_id, quantity in pairs(loot_data) do
                        table.insert(encounter_data[loot_type], ("%d:%d"):format(item_id, quantity))
                    end
                end
            end

            -- TODO: Remove this when GetLootSourceInfo() has values for money
            if #current_loot.list <= 0 then
                return
            end
            local npc = NPCEntry(current_loot.identifier)

            if not npc then
                return
            end
            local encounter_data = npc:EncounterData(difficulty_token)
            encounter_data[loot_type] = encounter_data[loot_type] or {}

            if not source_list[current_loot.identifier] then
                encounter_data.loot_counts = encounter_data.loot_counts or {}
                encounter_data.loot_counts[loot_type] = (encounter_data.loot_counts[loot_type] or 0) + 1
            end

            for index = 1, #current_loot.list do
                table.insert(encounter_data[loot_type], current_loot.list[index])
            end
        end,
        [AF.OBJECT] = function()
            GenericLootUpdate("objects", InstanceDifficultyToken())
        end,
        [AF.ZONE] = function()
            local location_token = ("%d:%d:%d"):format(current_loot.map_level, current_loot.x, current_loot.y)

            -- This will start life as a boolean true.
            if _G.type(current_loot.zone_data[location_token]) ~= "table" then
                current_loot.zone_data[location_token] = {
                    drops = {}
                }
            end
            local loot_count = ("%s_count"):format(current_loot.label)
            current_loot.zone_data[location_token][loot_count] = (current_loot.zone_data[location_token][loot_count] or 0) + 1

            if current_loot.sources then
                for source_guid, loot_data in pairs(current_loot.sources) do
                    for item_id, quantity in pairs(loot_data) do
                        table.insert(current_loot.zone_data[location_token].drops, ("%d:%d"):format(item_id, quantity))
                    end
                end
            end

            if #current_loot.list <= 0 then
                return
            end

            for index = 1, #current_loot.list do
                table.insert(current_loot.zone_data[location_token].drops, current_loot.loot_list[index])
            end
        end,
    }

    -- Prevent opening the same loot window multiple times from recording data multiple times.
    local loot_guid_registry = {}


    function WDP:LOOT_CLOSED(event_name)
        current_loot = nil
        table.wipe(current_action)
    end


    function WDP:LOOT_OPENED(event_name)
        if current_loot then
            return
        end

        if not current_action.target_type then
            return
        end
        local verify_func = LOOT_OPENED_VERIFY_FUNCS[current_action.target_type]
        local update_func = LOOT_OPENED_UPDATE_FUNCS[current_action.target_type]

        if not verify_func or not update_func then
            return
        end

        if _G.type(verify_func) == "function" and not verify_func() then
            return
        end
        local guids_used = {}

        current_loot = {
            list = {},
            sources = {},
            identifier = current_action.identifier,
            label = current_action.loot_label or "drops",
            map_level = current_action.map_level,
            object_name = current_action.object_name,
            spell_label = current_action.spell_label,
            target_type = current_action.target_type,
            x = current_action.x,
            y = current_action.y,
            zone_data = current_action.zone_data,
        }
        table.wipe(current_action)

        loot_guid_registry[current_loot.label] = loot_guid_registry[current_loot.label] or {}

        for loot_slot = 1, _G.GetNumLootItems() do
            local icon_texture, item_text, quantity, quality, locked = _G.GetLootSlotInfo(loot_slot)
            local slot_type = _G.GetLootSlotType(loot_slot)
            local loot_info = {
                _G.GetLootSourceInfo(loot_slot)
            }

            -- Odd index is GUID, even is count.
            for loot_index = 1, #loot_info, 2 do
                local source_guid = loot_info[loot_index]

                if not loot_guid_registry[current_loot.label][source_guid] then
                    local loot_quantity = loot_info[loot_index + 1]
                    local source_type, source_id = ParseGUID(source_guid)
                    local source_key = ("%s:%d"):format(private.UNIT_TYPE_NAMES[source_type + 1], source_id)
                    Debug("GUID: %s - Type:ID: %s - Amount: %d", loot_info[loot_index], source_key, loot_quantity)

                    if slot_type == _G.LOOT_SLOT_ITEM then
                        local item_id = ItemLinkToID(_G.GetLootSlotLink(loot_slot))
                        current_loot.sources[source_guid] = current_loot.sources[source_guid] or {}
                        current_loot.sources[source_guid][item_id] = current_loot.sources[source_guid][item_id] or 0 + loot_quantity
                        guids_used[source_guid] = true
                    elseif slot_type == _G.LOOT_SLOT_MONEY then
                        Debug("money:%d", _toCopper(item_text))
                        table.insert(current_loot.list, ("money:%d"):format(_toCopper(item_text)))
                    elseif slot_type == _G.LOOT_SLOT_CURRENCY then
                        Debug("Found currency: %s", icon_texture)
                        table.insert(current_loot.list, ("currency:%d:%s"):format(quantity, icon_texture:match("[^\\]+$"):lower()))
                    end
                end
            end
        end

        for guid in pairs(guids_used) do
            loot_guid_registry[current_loot.label][guid] = true
        end
        update_func()
    end
end -- do-block


function WDP:MAIL_SHOW(event_name)
    local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))

    if not unit_idnum or unit_type ~= private.UNIT_TYPES.OBJECT then
        return
    end
    UpdateDBEntryLocation("objects", unit_idnum)
end


do
    local POINT_MATCH_PATTERNS = {
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING:gsub("%%d", "(%%d+)")), -- May no longer be necessary
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING_3V3:gsub("%%d", "(%%d+)")), -- May no longer be necessary
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING_5V5:gsub("%%d", "(%%d+)")), -- May no longer be necessary
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING_BG:gsub("%%d", "(%%d+)")),
        ("^%s$"):format(_G.ITEM_REQ_ARENA_RATING_3V3_BG:gsub("%%d", "(%%d+)")),
    }

    local ITEM_REQ_REPUTATION_MATCH = "Requires (.-) %- (.*)"
    local ITEM_REQ_QUEST_MATCH1 = "Requires: .*"
    local ITEM_REQ_QUEST_MATCH2 = "Must have completed: .*"

    local current_merchant
    local merchant_standing

    function WDP:MERCHANT_CLOSED(event_name)
        current_merchant = nil
        merchant_standing = nil
    end


    function WDP:UpdateMerchantItems(event_name)
        if not current_merchant or event_name == "MERCHANT_SHOW" then
            local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))

            if not unit_idnum or not UnitTypeIsNPC(unit_type) then
                return
            end
            merchant_standing = select(2, UnitFactionStanding("npc"))
            current_merchant = NPCEntry(unit_idnum)
            current_merchant.sells = current_merchant.sells or {}
        end
        local current_filters = _G.GetMerchantFilter()
        _G.SetMerchantFilter(_G.LE_LOOT_FILTER_ALL)
        _G.MerchantFrame_Update()

        local num_items = _G.GetMerchantNumItems()

        for item_index = 1, num_items do
            local _, _, copper_price, stack_size, num_available, _, extended_cost = _G.GetMerchantItemInfo(item_index)
            local item_id = ItemLinkToID(_G.GetMerchantItemLink(item_index))

            if item_id and item_id > 0 then
                local price_string = ActualCopperCost(copper_price, merchant_standing)

                DatamineTT:ClearLines()
                DatamineTT:SetMerchantItem(item_index)

                local num_lines = DatamineTT:NumLines()

                for line_index = 1, num_lines do
                    local current_line = _G["WDPDatamineTTTextLeft" .. line_index]

                    if not current_line then
                        break
                    end
                    local faction, reputation = current_line:GetText():match(ITEM_REQ_REPUTATION_MATCH)

                    if faction or reputation then
                        DBEntry("items", item_id).req_reputation = ("%s:%s"):format(faction:gsub("-", ""), reputation:upper())
                        break
                    end
                end

                for line_index = 1, num_lines do
                    local current_line = _G["WDPDatamineTTTextLeft" .. line_index]

                    if not current_line then
                        break
                    end
                    local line_text = current_line:GetText()
                    local quest_name = line_text:match(ITEM_REQ_QUEST_MATCH1) or line_text:match(ITEM_REQ_QUEST_MATCH2)

                    if quest_name then
                        DBEntry("items", item_id).req_quest = ("%s"):format(quest_name:gsub("(.+): ", ""), quest_name)
                        break
                    end
                end

                if extended_cost then
                    local battleground_rating = 0
                    local personal_rating = 0
                    local required_season_amount

                    for line_index = 1, num_lines do
                        local current_line = _G["WDPDatamineTTTextLeft" .. line_index]

                        if not current_line then
                            break
                        end
                        required_season_amount = current_line:GetText():match("Requires earning a total of (%d+)\n(.-) for the season.")

                        for match_index = 1, #POINT_MATCH_PATTERNS do
                            local match1, match2 = current_line:GetText():match(POINT_MATCH_PATTERNS[match_index])
                            personal_rating = personal_rating + (match1 or 0)
                            battleground_rating = battleground_rating + (match2 or 0)

                            if match1 or match2 then
                                break
                            end
                        end
                    end
                    local currency_list = {}
                    local item_count = _G.GetMerchantItemCostInfo(item_index)

                    -- Keeping this around in case Blizzard makes the two points diverge at some point.
                    --                    price_string = ("%s:%s:%s:%s"):format(price_string, battleground_rating, personal_rating, required_season_amount or 0)
                    price_string = ("%s:%s:%s"):format(price_string, personal_rating, required_season_amount or 0)

                    for cost_index = 1, item_count do
                        local icon_texture, amount_required, currency_link = _G.GetMerchantItemCostItem(item_index, cost_index)
                        local currency_id = currency_link and ItemLinkToID(currency_link) or nil

                        if (not currency_id or currency_id < 1) and icon_texture then
                            currency_id = icon_texture:match("[^\\]+$"):lower()
                        end

                        if currency_id then
                            currency_list[#currency_list + 1] = ("(%s:%s)"):format(amount_required, currency_id)
                        end
                    end

                    for currency_index = 1, #currency_list do
                        price_string = ("%s:%s"):format(price_string, currency_list[currency_index])
                    end
                end
                current_merchant.sells[item_id] = ("%s:%s:[%s]"):format(num_available, stack_size, price_string)
            end
        end

        if _G.CanMerchantRepair() then
            current_merchant.can_repair = true
        end
        _G.SetMerchantFilter(current_filters)
        _G.MerchantFrame_Update()
    end
end -- do-block


function WDP:PET_BAR_UPDATE(event_name)
    if current_action.spell_label ~= "MIND_CONTROL" then
        return
    end
    local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("pet"))

    if not unit_idnum or not UnitTypeIsNPC(unit_type) then
        return
    end
    NPCEntry(unit_idnum).mind_control = true
    table.wipe(current_action)
end


function WDP:PET_JOURNAL_LIST_UPDATE(event_name)
    local num_pets = LPJ:NumPets()

    for index, pet_id in LPJ:IteratePetIDs() do
        local _, _, is_owned, _, level, _, _, name, icon, pet_type, npc_id, _, _, is_wild = _G.C_PetJournal.GetPetInfoByIndex(index)

        if is_owned then
            local health, max_health, attack, speed, rarity = _G.C_PetJournal.GetPetStats(pet_id)

            if rarity then
                local rarity_name = _G["BATTLE_PET_BREED_QUALITY" .. rarity]
                local npc = NPCEntry(npc_id)
                npc.wild_pet = is_wild or nil
                npc.battle_pet_data = npc.battle_pet_data or {}
                npc.battle_pet_data[rarity_name] = npc.battle_pet_data[rarity_name] or {}
                npc.battle_pet_data[rarity_name]["level_" .. level] = npc.battle_pet_data[rarity_name]["level_" .. level] or {}

                local data = npc.battle_pet_data[rarity_name]["level_" .. level]
                data.max_health = max_health
                data.attack = attack
                data.speed = speed
            end
        end
    end
end


function WDP:PLAYER_REGEN_DISABLED(event_name)
    private.in_combat = true
end


function WDP:PLAYER_REGEN_ENABLED(event_name)
    private.in_combat = nil

    if private.set_area_id then
        self:SetCurrentAreaID(event_name)
        private.set_area_id = nil
    end
end


function WDP:PLAYER_TARGET_CHANGED(event_name)
    if not TargetedNPC() then
        return
    end
    current_action.target_type = AF.NPC
    self:UpdateTargetLocation()
end


do
    local function UpdateQuestJuncture(point)
        local unit_name = _G.UnitName("questnpc")

        if not unit_name then
            return
        end
        local unit_type, unit_id = ParseGUID(_G.UnitGUID("questnpc"))

        if unit_type == private.UNIT_TYPES.OBJECT then
            UpdateDBEntryLocation("objects", unit_id)
        end
        local quest = DBEntry("quests", _G.GetQuestID())
        quest[point] = quest[point] or {}
        quest[point][("%s:%d"):format(private.UNIT_TYPE_NAMES[unit_type + 1], unit_id)] = true

        return quest
    end


    function WDP:QUEST_COMPLETE(event_name)
        local quest = UpdateQuestJuncture("end")

        if ALLOWED_LOCALES[CLIENT_LOCALE] then
            quest.reward_text = ReplaceKeywords(_G.GetRewardText())
        end
        -- Make sure the quest NPC isn't erroneously recorded as giving reputation for quests which award it.
        ClearKilledNPC()
    end


    function WDP:QUEST_DETAIL(event_name)
        local quest = UpdateQuestJuncture("begin")

        if not quest then
            return
        end
        quest.classes = quest.classes or {}
        quest.classes[PLAYER_CLASS] = true

        quest.races = quest.races or {}
        quest.races[(PLAYER_RACE == "Pandaren") and ("%s_%s"):format(PLAYER_RACE, PLAYER_FACTION or "Neutral") or PLAYER_RACE] = true
    end
end -- do-block


function WDP:QUEST_LOG_UPDATE(event_name)
    local selected_quest = _G.GetQuestLogSelection() -- Save current selection to be restored when we're done.
    local entry_index, processed_quests = 1, 0
    local _, num_quests = _G.GetNumQuestLogEntries()

    while processed_quests <= num_quests do
        local _, _, _, _, is_header, _, _, _, quest_id = _G.GetQuestLogTitle(entry_index)

        if quest_id == 0 then
            processed_quests = processed_quests + 1
        elseif not is_header then
            _G.SelectQuestLogEntry(entry_index);

            local quest = DBEntry("quests", quest_id)
            quest.timer = _G.GetQuestLogTimeLeft()
            quest.can_share = _G.GetQuestLogPushable() and true or nil
            processed_quests = processed_quests + 1
        end
        entry_index = entry_index + 1
    end
    _G.SelectQuestLogEntry(selected_quest)
    self:UnregisterEvent("QUEST_LOG_UPDATE")
end


function WDP:QUEST_PROGRESS(event_name)
    if not ALLOWED_LOCALES[CLIENT_LOCALE] then
        return
    end
    DBEntry("quests", _G.GetQuestID()).progress_text = ReplaceKeywords(_G.GetProgressText())
end


function WDP:UNIT_QUEST_LOG_CHANGED(event_name, unit_id)
    if unit_id ~= "player" then
        return
    end
    self:RegisterEvent("QUEST_LOG_UPDATE")
end


do
    local TRADESKILL_TOOLS = {
        Anvil = anvil_spell_ids,
        Forge = forge_spell_ids,
    }


    local function RegisterTools(tradeskill_name, tradeskill_index)
        local spell_id = tonumber(_G.GetTradeSkillRecipeLink(tradeskill_index):match("^|c%x%x%x%x%x%x%x%x|H%w+:(%d+)"))
        local required_tool = _G.GetTradeSkillTools(tradeskill_index)

        if required_tool then
            for tool_name, registry in pairs(TRADESKILL_TOOLS) do
                if required_tool:find(tool_name) then
                    registry[spell_id] = true
                end
            end
        end
    end


    function WDP:TRADE_SKILL_SHOW(event_name)
        local profession_name, prof_level = _G.GetTradeSkillLine()

        if profession_name == _G.UNKNOWN then
            return
        end
        TradeSkillExecutePer(RegisterTools)
    end
end -- do-block


function WDP:TRAINER_CLOSED(event_name)
    private.trainer_shown = nil
end


function WDP:TRAINER_SHOW(event_name)
    local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))
    local trainer = NPCEntry(unit_idnum)

    if not trainer then
        return
    end
    local trainer_standing = select(2, UnitFactionStanding("npc"))
    trainer.teaches = trainer.teaches or {}

    private.trainer_shown = true

    -- Get the initial trainer filters
    local available = _G.GetTrainerServiceTypeFilter("available")
    local unavailable = _G.GetTrainerServiceTypeFilter("unavailable")
    local used = _G.GetTrainerServiceTypeFilter("used")

    -- Clear the trainer filters
    _G.SetTrainerServiceTypeFilter("available", 1)
    _G.SetTrainerServiceTypeFilter("unavailable", 1)
    _G.SetTrainerServiceTypeFilter("used", 1)

    for index = 1, _G.GetNumTrainerServices(), 1 do
        local spell_name, rank_name, _, _, required_level = _G.GetTrainerServiceInfo(index)

        if spell_name then
            DatamineTT:ClearLines()
            DatamineTT:SetTrainerService(index)

            local _, _, spell_id = DatamineTT:GetSpell()

            if spell_id then
                local class_professions = trainer.teaches[PLAYER_CLASS]

                if not class_professions then
                    trainer.teaches[PLAYER_CLASS] = {}
                    class_professions = trainer.teaches[PLAYER_CLASS]
                end
                local profession, min_skill = _G.GetTrainerServiceSkillReq(index)
                profession = profession or "General"

                local profession_skills = class_professions[profession]

                if not profession_skills then
                    class_professions[profession] = {}
                    profession_skills = class_professions[profession]
                end
                profession_skills[spell_id] = ("%d:%d:%d"):format(required_level, min_skill, _G.GetTrainerServiceCost(index))
            end
        end
    end
    -- Reset the filters to what they were before
    _G.SetTrainerServiceTypeFilter("available", available or 0)
    _G.SetTrainerServiceTypeFilter("unavailable", unavailable or 0)
    _G.SetTrainerServiceTypeFilter("used", used or 0)
end


function WDP:UNIT_SPELLCAST_SENT(event_name, unit_id, spell_name, spell_rank, target_name, spell_line)
    if private.tracked_line or unit_id ~= "player" then
        return
    end
    local spell_label = private.SPELL_LABELS_BY_NAME[spell_name]

    if not spell_label then
        return
    end
    local item_name, item_link = _G.GameTooltip:GetItem()
    local unit_name, unit_id = _G.GameTooltip:GetUnit()

    if not unit_name and _G.UnitName("target") == target_name then
        unit_name = target_name
        unit_id = "target"
    end
    local spell_flags = private.SPELL_FLAGS_BY_LABEL[spell_label]
    local zone_name, area_id, x, y, map_level, instance_token = CurrentLocationData()

    table.wipe(current_action)
    current_action.instance_token = instance_token
    current_action.map_level = map_level
    current_action.x = x
    current_action.y = y
    current_action.zone_data = ("%s:%d"):format(zone_name, area_id)
    current_action.spell_label = spell_label

    if not private.NON_LOOT_SPELL_LABELS[spell_label] then
        current_action.loot_label = spell_label:lower()
    end

    if unit_name and unit_name == target_name and not item_name then
        if bit.band(spell_flags, AF.NPC) == AF.NPC then
            if not unit_id or unit_name ~= target_name then
                return
            end
            current_action.target_type = AF.NPC
        end
    elseif bit.band(spell_flags, AF.ITEM) == AF.ITEM then
        current_action.target_type = AF.ITEM

        if item_name and item_name == target_name then
            current_action.identifier = ItemLinkToID(item_link)
        elseif target_name and target_name ~= "" then
            current_action.identifier = ItemLinkToID(select(2, _G.GetItemInfo(target_name)))
        end
    elseif not item_name and not unit_name then
        if bit.band(spell_flags, AF.OBJECT) == AF.OBJECT then
            if target_name == "" then
                return
            end
            current_action.object_name = target_name
            current_action.target_type = AF.OBJECT
        elseif bit.band(spell_flags, AF.ZONE) == AF.ZONE then
            current_action.target_type = AF.ZONE
        end
    end
    private.tracked_line = spell_line
end


function WDP:UNIT_SPELLCAST_SUCCEEDED(event_name, unit_id, spell_name, spell_rank, spell_line, spell_id)
    if unit_id ~= "player" then
        return
    end
    private.tracked_line = nil
    private.previous_spell_id = spell_id

    if spell_name:match("^Harvest.+") then
        killed_npc_id = current_target_id
        private.harvesting = true
    end

    if anvil_spell_ids[spell_id] then
        UpdateDBEntryLocation("objects", OBJECT_ID_ANVIL)
    elseif forge_spell_ids[spell_id] then
        UpdateDBEntryLocation("objects", OBJECT_ID_FORGE)
    end
end


function WDP:HandleSpellFailure(event_name, unit_id, spell_name, spell_rank, spell_line, spell_id)
    if unit_id ~= "player" then
        return
    end

    if private.tracked_line == spell_line then
        private.tracked_line = nil
    end
    table.wipe(current_action)
end


do
    local function SetUnitField(field, required_type)
        local unit_type, unit_idnum = ParseGUID(_G.UnitGUID("npc"))

        if not unit_idnum or (required_type and unit_type ~= required_type) then
            return
        end

        if UnitTypeIsNPC(unit_type) then
            NPCEntry(unit_idnum)[field] = true
        elseif unit_type == private.UNIT_TYPES.OBJECT then
            DBEntry("objects", unit_idnum)[field] = true
            UpdateDBEntryLocation("objects", unit_idnum)
        end
    end


    function WDP:AUCTION_HOUSE_SHOW(event_name)
        SetUnitField("auctioneer", private.UNIT_TYPES.NPC)
    end


    function WDP:BANKFRAME_OPENED(event_name)
        SetUnitField("banker", private.UNIT_TYPES.NPC)
    end


    function WDP:BATTLEFIELDS_SHOW(event_name)
        SetUnitField("battlemaster", private.UNIT_TYPES.NPC)
    end


    function WDP:FORGE_MASTER_OPENED(event_name)
        SetUnitField("arcane_reforger", private.UNIT_TYPES.NPC)
    end


    function WDP:GOSSIP_SHOW(event_name)
        local gossip_options = { _G.GetGossipOptions() }

        for index = 2, #gossip_options, 2 do
            if gossip_options[index] == "binder" then
                SetUnitField("innkeeper", private.UNIT_TYPES.NPC)
                return
            end
        end
    end


    function WDP:GUILDBANKFRAME_OPENED(event_name)
        SetUnitField("guild_bank", private.UNIT_TYPES.OBJECT)
    end


    function WDP:ITEM_UPGRADE_MASTER_OPENED(event_name)
        SetUnitField("item_upgrade_master", private.UNIT_TYPES.NPC)
    end


    function WDP:TAXIMAP_OPENED(event_name)
        SetUnitField("flight_master", private.UNIT_TYPES.NPC)
    end


    function WDP:TRANSMOGRIFY_OPEN(event_name)
        SetUnitField("transmogrifier", private.UNIT_TYPES.NPC)
    end


    function WDP:VOID_STORAGE_OPEN(event_name)
        SetUnitField("void_storage", private.UNIT_TYPES.NPC)
    end
end -- do-block

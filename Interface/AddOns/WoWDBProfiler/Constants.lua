-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

local bit = _G.bit


-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...


-----------------------------------------------------------------------
-- Constants.
-----------------------------------------------------------------------
private.wow_version, private.build_num = _G.GetBuildInfo()

private.UNIT_TYPES = {
    PLAYER = 0,
    OBJECT = 1,
    UNKNOWN = 2,
    NPC = 3,
    PET = 4,
    VEHICLE = 5,
}


private.UNIT_TYPE_NAMES = {
    "PLAYER",
    "OBJECT",
    "UNKNOWN",
    "NPC",
    "PET",
    "VEHICLE",
}


private.ACTION_TYPE_FLAGS = {
    ITEM = 0x00000001,
    NPC = 0x00000002,
    OBJECT = 0x00000004,
    ZONE = 0x00000008,
}


private.ACTION_TYPE_NAMES = {}

for name, bit in _G.pairs(private.ACTION_TYPE_FLAGS) do
    private.ACTION_TYPE_NAMES[bit] = name
end


private.SPELL_LABELS_BY_NAME = {
    [_G.GetSpellInfo(13262)] = "DISENCHANT",
    [_G.GetSpellInfo(4036)] = "ENGINEERING",
    [_G.GetSpellInfo(30427)] = "EXTRACT_GAS",
    [_G.GetSpellInfo(131476)] = "FISHING",
    [_G.GetSpellInfo(2366)] = "HERB_GATHERING",
    [_G.GetSpellInfo(51005)] = "MILLING",
    [_G.GetSpellInfo(605)] = "MIND_CONTROL",
    [_G.GetSpellInfo(2575)] = "MINING",
    [_G.GetSpellInfo(3365)] = "OPENING",
    [_G.GetSpellInfo(921)] = "PICK_POCKET",
    [_G.GetSpellInfo(31252)] = "PROSPECTING",
    [_G.GetSpellInfo(73979)] = "SEARCHING_FOR_ARTIFACTS",
    [_G.GetSpellInfo(8613)] = "SKINNING",
}

private.NON_LOOT_SPELL_LABELS = {
    MIND_CONTROL = true,
}

local AF = private.ACTION_TYPE_FLAGS

private.SPELL_FLAGS_BY_LABEL = {
    DISENCHANT = AF.ITEM,
    ENGINEERING = AF.NPC,
    EXTRACT_GAS = AF.ZONE,
    FISHING = AF.ZONE,
    HERB_GATHERING = bit.bor(AF.NPC, AF.OBJECT),
    MILLING = AF.ITEM,
    MIND_CONTROL = AF.NPC,
    MINING = bit.bor(AF.NPC, AF.OBJECT),
    OPENING = AF.OBJECT,
    PICK_POCKET = AF.NPC,
    PROSPECTING = AF.ITEM,
    SEARCHING_FOR_ARTIFACTS = AF.OBJECT,
    SKINNING = AF.NPC,
}

private.RAID_FINDER_BOSS_IDS = {
    -----------------------------------------------------------------------
    -- Mogu'shan Vaults
    -----------------------------------------------------------------------
    [59915] = true, -- Jasper Guardian
    [60009] = true, -- Feng the Accursed
    [60043] = true, -- Jade Guardian
    [60047] = true, -- Amethyst Guardian
    [60051] = true, -- Cobalt Guardian
    [60143] = true, -- Gara'jal the Spiritbinder
    [60399] = true, -- Qin-xi
    [60400] = true, -- Jan-xi
    [60410] = true, -- Elegon
    [60701] = true, -- Zian of the Endless Shadow
    [60708] = true, -- Meng the Demented
    [60709] = true, -- Qiang the Merciless
    [60710] = true, -- Subetai the Swift

    -----------------------------------------------------------------------
    -- Terrace of Endless Spring
    -----------------------------------------------------------------------
    [60583] = true, -- Protector Kaolan
    [60585] = true, -- Elder Regail
    [60586] = true, -- Elder Asani
    [60999] = true, -- Sha of Fear
    [62442] = true, -- Tsulong
    [62983] = true, -- Lei Shi

    -----------------------------------------------------------------------
    -- Heart of Fear
    -----------------------------------------------------------------------
    [62164] = true, -- Garalon
    [62397] = true, -- Wind Lord Mel'jarak
    [62511] = true, -- Amber-Shaper Un'sok
    [62543] = true, -- Blade Lord Ta'yak
    [62837] = true, -- Grand Empress Shek'zeer
    [62980] = true, -- Imperial Vizier Zor'lok

    -----------------------------------------------------------------------
    -- Throne of Thunder
    -----------------------------------------------------------------------
    [69465] = true, -- Jin'rokh the Breaker
    [68476] = true, -- Horridon
    [69078] = true, -- Sul the Sandcrawler
    [69131] = true, -- Frost King Malakk
    [69132] = true, -- High Priestess Mar'li
    [69134] = true, -- Kazra'jin
    [67977] = true, -- Tortos
    [70212] = true, -- Flaming Head (of Megaera)
    [70235] = true, -- Frozen Head (of Megaera)
    [70247] = true, -- Venomous Head (of Megaera)
    [69712] = true, -- Ji-kun
    [68036] = true, -- Durumu
    [69017] = true, -- Primordius
    [69427] = true, -- Dark Animus
    [68078] = true, -- Iron Qon
    [68904] = true, -- Suen
    [68905] = true, -- Lu'lin
    [68397] = true, -- Lei Shen
}


private.WORLD_BOSS_IDS = {
    [60491] = true, -- Sha of Anger
    [62346] = true, -- Galleon
    [69099] = true, -- Nalak
    [69161] = true, -- Oondasta
}

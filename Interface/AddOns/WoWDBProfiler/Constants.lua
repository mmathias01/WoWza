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


private.LOOT_SPELL_ID_TO_ITEM_ID_MAP = {
    [142397] = 98134, -- Heroic Cache of Treasures
    [143506] = 98095, -- Brawler's Pet Supplies
    [143507] = 94207, -- Fabled Pandaren Pet Supplies
    [143508] = 89125, -- Sack of Pet Supplies
    [143509] = 93146, -- Pandaren Spirit Pet Supplies
    [143510] = 93147, -- Pandaren Spirit Pet Supplies
    [143511] = 93149, -- Pandaren Spirit Pet Supplies
    [143512] = 93148, -- Pandaren Spirit Pet Supplies
    [146885] = 103535, -- Bulging Bag of Charms
    [147598] = 104014, -- Pouch of Timeless Coins
    [149222] = 105911, -- Pouch of Enduring Wisdom
    [149223] = 105912, -- Oversized Pouch of Enduring Wisdom
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

    -----------------------------------------------------------------------
    -- Siege of Orgrimmar
    -----------------------------------------------------------------------
    [71543] = true, -- Immerseus
    [71475] = true, -- Rook Stonetoe (Fallen Protectors encounter)
    [71479] = true, -- He Softfoot (Fallen Protectors encounter)
    [71480] = true, -- Sun Tenderheart (Fallen Protectors encounter)
    [71967] = true, -- Norushen (Norushen encounter)
    [72276] = true, -- Amalgam of Corruption (Norushen encounter)
    [71734] = true, -- Sha of Pride
    [72249] = true, -- Galakras
    [71466] = true, -- Iron Juggernaut
    [71858] = true, -- Wavebinder Kardris (Kor'kron Dark Shaman encounter)
    [71859] = true, -- Earthbreaker Haromm (Kor'kron Dark Shaman encounter)
    [71515] = true, -- General Nazgrim
    [71454] = true, -- Malkorok
    [71889] = true, -- Secured Stockpile of Pandaren Spoils (Spoils of Pandaria encounter)
    [71529] = true, -- Thok the Bloodthirsty
    [71504] = true, -- Siegecrafter Blackfuse
    [71152] = true, -- Skeer the Bloodseeker (Paragons of the Klaxxi encounter)
    [71153] = true, -- Hisek the Swarmkeeper (Paragons of the Klaxxi encounter)
    [71154] = true, -- Ka'roz the Locust (Paragons of the Klaxxi encounter)
    [71155] = true, -- Korven the Prime (Paragons of the Klaxxi encounter)
    [71156] = true, -- Kaz'tik the Manipulator (Paragons of the Klaxxi encounter)
    [71157] = true, -- Xaril the Poisoned Mind (Paragons of the Klaxxi encounter)
    [71158] = true, -- Rik'kal the Dissector (Paragons of the Klaxxi encounter)
    [71160] = true, -- Iyyokuk the Lucid (Paragons of the Klaxxi encounter)
    [71161] = true, -- Kil'ruk the Wind-Reaver (Paragons of the Klaxxi encounter)
    [71865] = true, -- Garrosh Hellscream
}


private.WORLD_BOSS_IDS = {
    [60491] = true, -- Sha of Anger
    [62346] = true, -- Galleon
    [69099] = true, -- Nalak
    [69161] = true, -- Oondasta
    [71952] = true, -- Chi-Ji
    [71953] = true, -- Xuen
    [71954] = true, -- Niuzao
    [71955] = true, -- Yu'lon
    [72057] = true, -- Ordos
}


private.RAID_BOSS_BONUS_SPELL_ID_TO_NPC_ID_MAP = {
    -----------------------------------------------------------------------
    -- Mogu'shan Vaults
    -----------------------------------------------------------------------
    [125144] = 59915, -- Stone Guard Bonus (Jasper Guardian)
    [132189] = 60009, -- Feng the Accursed Bonus (Feng the Accursed)
    [132190] = 60143, -- Gara'jal the Spiritbinder Bonus (Gara'jal the Spiritbinder)
    [132191] = 60709, -- Spirit Kings Bonus (Qiang the Merciless)
    [132192] = 60410, -- Elegon Bonus (Elegon)
    [132193] = 60399, -- Will of the Emperor Bonus (Qin-xi)

    -----------------------------------------------------------------------
    -- Terrace of Endless Spring
    -----------------------------------------------------------------------
    [132200] = 60583, -- Protectors of the Endless Bonus (Protector Kaolan)
    [132204] = 60583, -- Protectors of the Endless (Elite) Bonus (Protector Kaolan)
    [132201] = 62442, -- Tsulong Bonus (Tsulong)
    [132202] = 62983, -- Lei Shi Bonus (Lei Shi)
    [132203] = 60999, -- Sha of Fear Bonus (Sha of Fear)

    -----------------------------------------------------------------------
    -- Heart of Fear
    -----------------------------------------------------------------------
    [132194] = 62980, -- Imperial Vizier Zor'lok Bonus (Imperial Vizier Zor'lok)
    [132195] = 62543, -- Blade Lord Tay'ak Bonus (Blade Lord Ta'yak)
    [132196] = 62164, -- Garalon Bonus (Garalon)
    [132197] = 62397, -- Wind Lord Mel'jarak Bonus (Wind Lord Mel'jarak)
    [132198] = 62511, -- Amber-Shaper Un'sok Bonus (Amber-Shaper Un'sok)
    [132199] = 62837, -- Grand Empress Shek'zeer Bonus (Grand Empress Shek'zeer)

    -----------------------------------------------------------------------
    -- Throne of Thunder
    -----------------------------------------------------------------------
    [139674] = 69465, -- Jin'rokh the Breaker Bonus (Jin'rokh the Breaker)
    [139677] = 68476, -- Horridon Bonus (Horridon)
    [139679] = 69078, -- Zandalari Troll Council Bonus (Sul the Sandcrawler)
    [139680] = 67977, -- Tortos Bonus (Tortos)
    [139682] = 68065, -- Magaera Bonus (Megaera)
    [139684] = 69712, -- Ji'kun, the Ancient Mother Bonus (Ji-Kun)
    [139686] = 68036, -- Durumu the Forgotten Bonus (Durumu the Forgotten)
    [139687] = 69017, -- Primordious Bonus (Primordius)
    [139688] = 69427, -- Dark Animus Bonus (Dark Animus)
    [139689] = 68078, -- Iron Qon Bonus (Iron Qon)
    [139690] = 68904, -- The Empyreal Queens Bonus (Suen)
    [139691] = 68397, -- Lei Shen, The Thunder King Bonus (Lei Shen)
    [139692] = 69473, -- Ra-den Bonus (Ra-den)

    -----------------------------------------------------------------------
    -- Siege of Orgrimmar
    -----------------------------------------------------------------------
    [145909] = 71543, -- Immerseus Bonus (Immerseus)
    [145910] = 71475, -- Fallen Protectors Bonus (Rook Stonetoe)
    [145911] = 72276, -- Norushen Bonus (Amalgam of Corruption)
    [145912] = 71734, -- Sha of Pride Bonus (Sha of Pride)
    [145913] = 72249, -- Galakras Bonus (Galakras)
    [145914] = 71466, -- Iron Juggernaut Bonus (Iron Juggernaut)
    [145915] = 71859, -- Dark Shaman Bonus (Earthbreaker Haromm)
    [145916] = 71515, -- General Nazgrim Bonus (General Nazgrim)
    [145917] = 71454, -- Malkorok Bonus (Malkorok)
    [145919] = 71889, -- Spoils of Pandaria Bonus (Secured Stockpile of Pandaren Spoils)
    [145920] = 71529, -- Thok the Bloodthirsty Bonus (Thok the Bloodthirsty)
    [145918] = 71504, -- Siegecrafter Blackfuse Bonus (Siegecrafter Blackfuse)
    [145921] = 71161, -- Klaxxi Paragons Bonus (Kil'ruk the Wind-Reaver)
    [145922] = 71865, -- Garrosh Hellscream Bonus (Garrosh Hellscream)
}


private.WORLD_BOSS_BONUS_SPELL_ID_TO_NPC_ID_MAP = {
    [132205] = 60491, -- Sha of Anger Bonus (Sha of Anger)
    [132206] = 62346, -- Galleon Bonus (Galleon)
    [136381] = 69099, -- Nalak Bonus (Nalak)
    [137554] = 69161, -- Oondasta Bonus (Oondasta)
    [148317] = 71952, -- Celestials Bonus (Chi-Ji)
    [148316] = 72057, -- Ordos Bonus (Ordos)
}

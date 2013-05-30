﻿-- $Id: InstanceList.lua 4215 2013-05-22 17:34:14Z hegarol $
--[[
Atlasloot Enhanced
Author Hegarol
Loot browser associating loot with instance bosses
Can be integrated with Atlas (http://www.atlasmod.com)

Functions:
]]
AtlasLoot_ModuleList_Loader = {
	"AtlasLootClassicWoW",
	"AtlasLootBurningCrusade",
	"AtlasLootWotLK",
	"AtlasLootCataclysm",
	"AtlasLootMoP",
	"AtlasLootCrafting",
	"AtlasLootWorldEvents"
}

AtlasLoot_InstanceList_Loader = {

["OrderCloudSerpent"] = 5,
["TailoringSoulclothEm"] = 6,
["HCHallsKargath"] = 2,
["BDChimaeron"] = 4,
["Ramkahen"] = 4,
["ToTMegaera"] = 5,
["TJSMari"] = 5,
["PVP90ShamanRestoration"] = 5,
["T456PaladinHoly"] = 2,
["LeatherworkingMoPVendor"] = 6,
["EngineeringMisc"] = 6,
["HCFurnaceMaker"] = 2,
["VioletHoldMoragg"] = 3,
["WSGArmor"] = 1,
["AQ20Ayamiss"] = 1,
["Gilneas"] = 1,
["AhnkahetTaldaram"] = 3,
["MSVWilloftheEmperor"] = 5,
["PVP70VengefulWeapons"] = 2,
["AQ40Sets"] = 1,
["T10PriestShadow"] = 3,
["CFRUnderGhazan"] = 2,
["NaxxDeathKnightTank"] = 3,
["PVP70Warrior"] = 2,
["VioletEye"] = 2,
["DMWMagisterKalendris"] = 1,
["Naxx80Thaddius"] = 3,
["HordeExpedition"] = 3,
["LeatherItemEnhancement"] = 6,
["SPKalecgos"] = 2,
["BRDTrash"] = 1,
["HCFurnaceBreaker"] = 2,
["PVP90Mage"] = 5,
["EngineeringTinker"] = 6,
["BoTCouncil"] = 4,
["T1112PriestHoly"] = 4,
["MCMajordomo"] = 1,
["TailoringItemEnhancement"] = 6,
["TKEyeSolarian"] = 2,
["Kurenai"] = 2,
["Oondasta"] = 5,
["Naxx80AnubRekhan"] = 3,
["Klaxxi"] = 5,
["CookingBanquetFeast"] = 6,
["LeatherworkingLeatherVolcanicArmor"] = 6,
["ABSets"] = 1,
["BRDArena"] = 1,
["KaraNightbane"] = 2,
["SalyisWarband"] = 5,
["AQ40Fankriss"] = 1,
["KaraAttumen"] = 2,
["GundrakTrash"] = 3,
["HeirloomBoAArmor"] = 5,
["AlchemyTransmute"] = 6,
["SmithingWeaponRemoved"] = 6,
["UlduarIronCouncil"] = 3,
["WorldBossesBC"] = 2,
["Naxx80Patchwerk"] = 3,
["T13PaladinHoly"] = 4,
["BTBloodboil"] = 2,
["JewelMountPet"] = 6,
["T456Hunter"] = 2,
["LeatherworkingMailSwiftarrowBattlefear"] = 6,
["BRDTomb"] = 1,
["MSVTheStoneGuard"] = 5,
["LeatherworkingMailNerubianHive"] = 6,
["BreweryOokOok"] = 5,
["TKEyeKaelthas"] = 2,
["SMWhitemane"] = 5,
["T15DeathKnightDPS"] = 5,
["CFRSlaveRokmar"] = 2,
["TailoringArmorBC"] = 6,
["UlduarRazorscale"] = 3,
["PVP90PaladinHoly"] = 5,
["MountHyjalKazrogal"] = 2,
["STRATMalekithePallid"] = 1,
["T1112ShamanElemental"] = 4,
["JusticePointsMoP"] = 5,
["AQ20Sets"] = 1,
["EnchantingMisc"] = 6,
["VPErtan"] = 4,
["JewelcraftingDailyBlue"] = 6,
["SilvermoonCity"] = 1,
["EngineeringReagents"] = 6,
["AQ20Moam"] = 1,
["T456Mage"] = 2,
["GBDrahga"] = 4,
["Inscription_Reagents"] = 6,
["LBRSFelguard"] = 1,
["NaxxShamanElemental"] = 3,
["STRATSkull"] = 1,
["CFRSerpentHydross"] = 2,
["Gnomish"] = 6,
["UBRSAnvilcrack"] = 1,
["Onyxia"] = 3,
["T14PaladinProtection"] = 5,
["VPAsaad"] = 4,
["LeatherworkingLeatherBoreanEmbrace"] = 6,
["VoAToravon"] = 3,
["FirelandsRagnaros"] = 4,
["UBRSBeast"] = 1,
["FirelandsShannox"] = 4,
["WorldEpics90"] = 5,
["SmithingWeaponMoP"] = 6,
["Naxx80Gluth"] = 3,
["KirinTorOffensive"] = 5,
["EnchantingBoots"] = 6,
["LeatherworkingLeatherWildDraenishA"] = 6,
["LeatherLeatherArmorBC"] = 6,
["LostCityBarim"] = 4,
["PVP80ShamanRestoration"] = 3,
["WoEPerotharn"] = 4,
["KnightsoftheEbonBlade"] = 3,
["SPFelmyst"] = 2,
["T1T2Priest"] = 1,
["T0Warlock"] = 1,
["PVP70GladiatorWeapons"] = 2,
["MSVElegon"] = 5,
["MCGehennas"] = 1,
["AQ40Skeram"] = 1,
["LeatherSpecializations"] = 6,
["MountsRareDungeon"] = 5,
["ZANalorakk"] = 4,
["Inscription_OffHand"] = 6,
["BDAtramedes"] = 4,
["PVP80Hunter"] = 3,
["LBRSWyrmthalak"] = 1,
["T1112Warlock"] = 4,
["T15ShamanElemental"] = 5,
["ZFAntusul"] = 1,
["JewelTrinket"] = 6,
["TailoringMoPVendor"] = 6,
["TransformationConsumableItems"] = 5,
["T10WarriorFury"] = 3,
["TotTTrash"] = 4,
["HoFUnsok"] = 5,
["HallsofLightningLoken"] = 3,
["NTJinbak"] = 5,
["EngineeringArmorCloth"] = 6,
["CoTMorassDeja"] = 2,
["KirinTor"] = 3,
["TotTUlthok"] = 4,
["JewelPrismatic"] = 6,
["Mooncloth"] = 6,
["DMEPusillin"] = 1,
["ChallengeModeWarlock"] = 5,
["SmithingWeaponCata"] = 6,
["PVP70PaladinHoly"] = 2,
["DMNGuardMoldar"] = 1,
["PVP90NonSetMail"] = 5,
["T15PriestHoly"] = 5,
["DMNGuardFengus"] = 1,
["VentureBay"] = 3,
["JewelDragonsEye"] = 6,
["AlchemyOtherElixir"] = 6,
["FirelandsTrash"] = 4,
["PVP70PriestHoly"] = 2,
["Naxx80Trash"] = 3,
["Netherwing"] = 2,
["T15WarriorProtection"] = 5,
["MoguShanVaultsTrash"] = 5,
["MountsAchievement"] = 5,
["PVP60Rogue"] = 1,
["CFRSerpentVashj"] = 2,
["Inscription_Enchants"] = 6,
["T9DruidBalance"] = 3,
["Shatar"] = 2,
["HoOAnhuur"] = 4,
["Inscription_Shaman"] = 6,
["ArchaeologyNightElf"] = 6,
["DS3Plate"] = 2,
["CookingRatings"] = 6,
["PVP90NonSetLeather"] = 5,
["PetsRare"] = 5,
["STAvatarofHakkar"] = 1,
["TailoringBattlecastG"] = 6,
["MountHyjalWinterchill"] = 2,
["SmithingWeaponWrath"] = 6,
["CardGame"] = 5,
["PVP85NonSet"] = 4,
["JewelYellow"] = 6,
["BWLVaelastrasz"] = 1,
["TheNexusAnomalus"] = 3,
["T9DeathKnightDPS"] = 3,
["T14DruidDPS"] = 5,
["PVP90Rogue"] = 5,
["SPBrutallus"] = 2,
["TailoringArcanoVest"] = 6,
["MountsCraftQuest"] = 5,
["WorldEpics80"] = 3,
["BoTChogall"] = 4,
["STRATTrash"] = 1,
["PVP60Hunter"] = 1,
["ChallengeModeShaman"] = 5,
["LBRSBashguud"] = 1,
["Therazane"] = 4,
["KaraTrash"] = 2,
["T15MonkTank"] = 5,
["PetsAchievement"] = 5,
["HCFurnaceBroggok"] = 2,
["T9WarriorProtection"] = 3,
["GnomereganLoot"] = 1,
["BlackrockCavernsLordObsidius"] = 4,
["PVP70MercilessWeapons"] = 2,
["T13DruidFeral"] = 4,
["AVMisc"] = 1,
["TabardsRemoved"] = 5,
["AzjolNerubHadronox"] = 3,
["DominanceOffensive"] = 5,
["LeatherworkingLeatherFelSkin"] = 6,
["Sporeggar"] = 2,
["NaxxPaladinHoly"] = 3,
["PVP85Rogue"] = 4,
["ZFZerillis"] = 1,
["T15MonkDPS"] = 5,
["ArchaeologyMogu"] = 6,
["DMEZevrimThornhoof"] = 1,
["MountsPvP"] = 5,
["TailoringFrostwovenPower"] = 6,
["Spellfire"] = 6,
["T15Hunter"] = 5,
["T0Mage"] = 1,
["T456DruidBalance"] = 2,
["HallsofStoneMaiden"] = 3,
["T1112DruidFeral"] = 4,
["VioletHoldIchoron"] = 3,
["ICCFestergut"] = 3,
["PVP60Druid"] = 1,
["Inscription_Paladin"] = 6,
["ArchaeologyTolvir"] = 6,
["RaresMOPMobsDreadWastes"] = 5,
["FirelandsPatterns"] = 4,
["FoSBronjahm"] = 3,
["T14WarriorFury"] = 5,
["ArchaeologyPandaren"] = 6,
["ArgentDawn"] = 1,
["Skyguard"] = 2,
["T456DruidRestoration"] = 2,
["MSVFeng"] = 5,
["Legendaries"] = 5,
["SmithingArmorOld"] = 6,
["LBRSSmolderweb"] = 1,
["ZFHydromancerVelratha"] = 1,
["Naxx80FourHorsemen"] = 3,
["Terokkar"] = 2,
["EmblemofValor"] = 3,
["GotSSRimok"] = 5,
["DarkspearTrolls"] = 1,
["T10PriestHoly"] = 3,
["HallsofStoneKrystallus"] = 3,
["ValorPointsMoP"] = 5,
["MCRANDOMBOSSDROPPS"] = 1,
["UBRSDrakkisath"] = 1,
["NaxxPaladinRetribution"] = 3,
["ZGKilnara"] = 4,
["PVP70DruidRestoration"] = 2,
["Ironforge"] = 1,
["TailoringArmorMoP"] = 6,
["EndtimeTrash"] = 4,
["AQ40CThun"] = 1,
["STJammalanandOgom"] = 1,
["EmblemofTriumph"] = 3,
["NTVojak"] = 5,
["SHHarlan"] = 5,
["DMWImmolthar"] = 1,
["TailoringSpellstrikeInfu"] = 6,
["MountHyjalTrash"] = 2,
["WSGWeapons"] = 1,
["HoOIsiset"] = 4,
["AuchShadowBlackheart"] = 2,
["CFRSlaveMennu"] = 2,
["TheNexusKolurgStoutbeard"] = 3,
["HardModeArena"] = 2,
["LeatherworkingMailBlackDragonM"] = 6,
["CFRSerpentLurker"] = 2,
["PVP80Weapons"] = 3,
["Halion"] = 3,
["LeatherworkingMailScaledDraenicA"] = 6,
["GBErudax"] = 4,
["ICCTrash"] = 3,
["T15PriestShadow"] = 5,
["BHAlizabal"] = 4,
["CFRUnderHungarfen"] = 2,
["Naxx80Heigan"] = 3,
["LeatherworkingLeatherEvisceratorBattlegear"] = 6,
["WailingCavernsLoot"] = 1,
["T1T2Shaman"] = 1,
["T9DruidRestoration"] = 3,
["WildhammerClan"] = 4,
["SmithingArmorMoP"] = 6,
["Mining"] = 6,
["ZAHalazzi"] = 4,
["LeatherCloaks"] = 6,
["BlackrockCavernsBeauty"] = 4,
["T1T2Warlock"] = 1,
["BlackrockMountainEntLoot"] = 1,
["AuchManaTavarok"] = 2,
["NTPavalak"] = 5,
["Swordsmith"] = 6,
["NaxxPriestHoly"] = 3,
["T3Mage"] = 1,
["PVP80ShamanEnhancement"] = 3,
["ArchaeologyDwarf"] = 6,
["MCSulfuron"] = 1,
["PVP60Warrior"] = 1,
["AuchShadowGrandmaster"] = 2,
["ThunderBluff"] = 1,
["TailoringShirts"] = 6,
["PVP90Warlock"] = 5,
["PVP80Accessories"] = 3,
["PVP85PriestShadow"] = 4,
["BTAkama"] = 2,
["Inscription_Warrior"] = 6,
["BRDPyromantLoregrain"] = 1,
["UBRSRunewatcher"] = 1,
["T1T2Druid"] = 1,
["BRDWarderStilgiss"] = 1,
["OcuDrakos"] = 3,
["BlacksmithingPlateOrnateSaroniteBattlegear"] = 6,
["VioletHoldCyanigosa"] = 3,
["ToTIronQon"] = 5,
["AugustCelestials"] = 5,
["UlduarAuriaya"] = 3,
["CraftedWeapons"] = 6,
["CoTStratholmeTrash"] = 3,
["Sartharion"] = 3,
["VioletHoldLavanthor"] = 3,
["Inscription_Warlock"] = 6,
["CFRUnderStalker"] = 2,
["ZAAkilZon"] = 4,
["CoTStratholmeSalramm"] = 3,
["PVP90DruidBalance"] = 5,
["ToESLeiShi"] = 5,
["T9PriestShadow"] = 3,
["ZGJindo"] = 4,
["NaxxPaladinProtection"] = 3,
["FishingFishWeapons"] = 6,
["JewelRing"] = 6,
["LeatherDrumsBagsMisc"] = 6,
["GundrakGaldarah"] = 3,
["MountsPromotional"] = 5,
["T10DruidBalance"] = 3,
["PVP80ShamanElemental"] = 3,
["AllianceVanguard"] = 3,
["T15ShamanEnhancement"] = 5,
["BRDLordIncendius"] = 1,
["HCHallsTrash"] = 2,
["Shadoweave"] = 6,
["VoAEmalon"] = 3,
["LeatherworkingLeatherThickDraenicA"] = 6,
["DMNTRIBUTERUN"] = 1,
["HardModePlate"] = 2,
["T14DruidRestoration"] = 5,
["ToTRaden"] = 5,
["ICCLanathel"] = 3,
["ShadowfangWalden"] = 4,
["BWLFlamegor"] = 1,
["LeatherworkingCataVendor"] = 6,
["LeatherworkingMailFelstalkerArmor"] = 6,
["AuchSethekkTalonKing"] = 2,
["PVP85Warlock"] = 4,
["STRATTheUnforgiven"] = 1,
["MountsFaction"] = 5,
["StonecoreAzil"] = 4,
["PVP90Hunter"] = 5,
["BRDHighInterrogatorGerstahn"] = 1,
["T9Mage"] = 3,
["BRDVerek"] = 1,
["UlduarDeconstructor"] = 3,
["TKEyeTrash"] = 2,
["T1T2Hunter"] = 1,
["AuchCryptsExarch"] = 2,
["SmithingWeaponEnhancement"] = 6,
["BWLNefarian"] = 1,
["SmithingArmorBC"] = 6,
["STRATBalnazzar"] = 1,
["ZADaakara"] = 4,
["STRATInstructorGalford"] = 1,
["BlackrockCavernsRomogg"] = 4,
["Goblin"] = 6,
["KaraCharredBoneFragment"] = 2,
["BRDLordRoccor"] = 1,
["TKArcHarbinger"] = 2,
["CookingAttributes"] = 6,
["LBRSVosh"] = 1,
["PetsEvent"] = 5,
["STRATWilleyHopebreaker"] = 1,
["EngineeringExplosives"] = 6,
["NTNeronok"] = 5,
["GundrakColossus"] = 3,
["UtgardeKeepTrash"] = 3,
["UPSkadi"] = 3,
["DS3Mail"] = 2,
["Naxx80Loatheb"] = 3,
["ScholoChillheart"] = 5,
["Armorsmith"] = 6,
["UlduarIgnis"] = 3,
["FirelandsFirestone"] = 4,
["MCLucifron"] = 1,
["LBRSGrimaxe"] = 1,
["GuardiansHyjal"] = 4,
["DMNStomperKreeg"] = 1,
["LeatherworkingLeatherOvercasterBattlegear"] = 6,
["Timbermaw"] = 1,
["T10ShamanRestoration"] = 3,
["LeatherMailArmorMoP"] = 6,
["CookingSpecial"] = 6,
["LeatherMailArmorWrath"] = 6,
["HCMagtheridon"] = 2,
["PVP85Accessories"] = 4,
["BreweryYanZhu"] = 5,
["JewelNeck"] = 6,
["WoEMannoroth"] = 4,
["GotSSKiptilak"] = 5,
["T1112WarriorFury"] = 4,
["ScholoTrash"] = 1,
["LeatherworkingLeatherStormshroudArmor"] = 6,
["LeatherworkingMailFelscaleArmor"] = 6,
["T456PriestHoly"] = 2,
["Tillers"] = 5,
["EmblemofConquest"] = 3,
["RaresMOPMobsIsleofThunder"] = 5,
["ArchaeologyMisc"] = 6,
["UlduarMimiron"] = 3,
["DrakTharonKeepTrash"] = 3,
["VoAKoralon"] = 3,
["UBRSTrash"] = 1,
["DMWHelnurath"] = 1,
["PVP80NonSet"] = 3,
["LBRSTrash"] = 1,
["AQBroodRings"] = 1,
["SHBraun"] = 5,
["PoSTyrannus"] = 3,
["KaraPrince"] = 2,
["T1112PaladinRetribution"] = 4,
["AuchCryptsShirrak"] = 2,
["TKMechCacheoftheLegion"] = 2,
["Tranquillien"] = 2,
["SPMuru"] = 2,
["PVP80PriestShadow"] = 3,
["SmithingTrainingProjects"] = 6,
["T0Warrior"] = 1,
["ArgentCrusade"] = 3,
["ZGVenoxis"] = 4,
["PVP90ShamanElemental"] = 5,
["LBRSCrystalFang"] = 1,
["WSGAccessories"] = 1,
["NaxxShamanEnhancement"] = 3,
["AQ40Emperors"] = 1,
["PVP70PriestShadow"] = 2,
["HCRampWatchkeeper"] = 2,
["TailoringCataVendor"] = 6,
["PVP60Priest"] = 1,
["BDMaloriak"] = 4,
["T10PaladinRetribution"] = 3,
["PVP90Warrior"] = 5,
["CFRSerpentLeotheras"] = 2,
["TKBotSplinter"] = 2,
["T15Rogue"] = 5,
["STEranikus"] = 1,
["T3Warrior"] = 1,
["SHKoegler"] = 5,
["ShadoPanCloudstrike"] = 5,
["SmithingMisc"] = 6,
["PVP90NonSetCloth"] = 5,
["LBRSSlavener"] = 1,
["BlacksmithingPlateEnchantedAdaman"] = 6,
["JewelcraftingDailyNeckRing"] = 6,
["LeatherworkingLeatherPrimalBatskin"] = 6,
["SunOffensive"] = 2,
["ScholoVoss"] = 5,
["BlacksmithingPlateAdamantiteB"] = 6,
["PVP80PriestHoly"] = 3,
["Consortium"] = 2,
["HoTArcurion"] = 4,
["HallsofStoneTribunal"] = 3,
["ScaleSands"] = 2,
["Stockade"] = 1,
["ShaofAnger"] = 5,
["SPPatterns"] = 2,
["T9PaladinRetribution"] = 3,
["AhnkahetTrash"] = 3,
["HallsofLightningBjarngrim"] = 3,
["KaraIllhoof"] = 2,
["WorldEpics3039"] = 1,
["PetsCrafted"] = 5,
["CoTHillsbradDrake"] = 2,
["T3Shaman"] = 1,
["T1112WarriorProtection"] = 4,
["NaxxWarlock"] = 3,
["MiscFactions"] = 1,
["AQ20Trash"] = 1,
["LeatherLeather"] = 6,
["TheNexusTelestra"] = 3,
["HoFTayak"] = 5,
["WOTLKSets"] = 3,
["ZFSezzziz"] = 1,
["T15MonkHealer"] = 5,
["HoRMarwyn"] = 3,
["AQ40Trash"] = 1,
["Naxx80Gothik"] = 3,
["STRATNerubenkan"] = 1,
["T1112ShamanRestoration"] = 4,
["PetsPromotional"] = 5,
["BTShahraz"] = 2,
["TailoringArmorOld"] = 6,
["T10Rogue"] = 3,
["ShadoPanAssault"] = 5,
["EnchantingCloak"] = 6,
["T14WarriorProtection"] = 5,
["TailoringBloodvineG"] = 6,
["DragonSoulTrash"] = 4,
["UlduarHodir"] = 3,
["BlackrockCavernsCorla"] = 4,
["HoFTrash"] = 5,
["AuchShadowHellmaw"] = 2,
["TrialoftheCrusaderAnubarak"] = 3,
["CookingDaily"] = 6,
["LBRSDoomhowl"] = 1,
["EnchantingCataVendor"] = 6,
["DeadminesTrash"] = 4,
["ZFChiefUkorzSandscalp"] = 1,
["T13Warlock"] = 4,
["DMEHydro"] = 1,
["AuchTrash"] = 2,
["BHArgaloth"] = 4,
["T3Paladin"] = 1,
["GBUmbriss"] = 4,
["TrialoftheCrusaderLordJaraxxus"] = 3,
["DragonSoulDeathwingSpine"] = 4,
["CFRSteamWarlord"] = 2,
["T15DruidDPS"] = 5,
["DMWTsuzee"] = 1,
["T9PaladinHoly"] = 3,
["TotTMindbender"] = 4,
["BRDFineousDarkvire"] = 1,
["NaxxMage"] = 3,
["VoAArchavon"] = 3,
["CFRSteamSteamrigger"] = 2,
["T13ShamanRestoration"] = 4,
["SunreaverOnslaught"] = 5,
["PVP80PaladinHoly"] = 3,
["TailoringBags"] = 6,
["CoTHillsbradSkarloc"] = 2,
["BlacksmithingPlateBurningRage"] = 6,
["AlchemyGuardianElixir"] = 6,
["TrialoftheCrusaderFactionChampions"] = 3,
["HallsofStoneSjonnir"] = 3,
["TailoringImbuedNeather"] = 6,
["PVP90NonSetPlate"] = 5,
["T14DruidTank"] = 5,
["PVP85PaladinRetribution"] = 4,
["HCHallsNethekurse"] = 2,
["UlduarAlgalon"] = 3,
["SPEredarTwins"] = 2,
["LBRSSpirestoneButcher"] = 1,
["PVP70Rep"] = 2,
["VWOWScholo"] = 1,
["WorldEpics5060"] = 1,
["TKMechCalc"] = 2,
["UPYmiron"] = 3,
["BTPatterns"] = 2,
["T1112Mage"] = 4,
["T9ShamanElemental"] = 3,
["PVP70ShamanRestoration"] = 2,
["HoTTrash"] = 4,
["NaxxHunter"] = 3,
["LeatherworkingLeatherPrimalIntent"] = 6,
["PVP70PaladinProtection"] = 2,
["UBRSGyth"] = 1,
["PVP70WarlockDemonology"] = 2,
["WorldEpics85"] = 4,
["T10PaladinHoly"] = 3,
["PetsMerchant"] = 5,
["Heirloom"] = 5,
["AlchemyBattleElixir"] = 6,
["KaraMaiden"] = 2,
["VioletHoldTrash"] = 3,
["JewelcraftingDailyGreen"] = 6,
["CoTTrash"] = 2,
["T13DeathKnightTank"] = 4,
["DMEAlzzin"] = 1,
["PVP60Shaman"] = 1,
["PVP90MonkDPS"] = 5,
["CoTStratholmeMeathook"] = 3,
["TailoringShadowEmbrace"] = 6,
["PetsNEW"] = 5,
["RaresMOPMobsKunLaiSummit"] = 5,
["BHOccuthar"] = 4,
["HoFGaralon"] = 5,
["BWLEbonroc"] = 1,
["ZGMadness"] = 4,
["ToESShaofFear"] = 5,
["PoSGarfrost"] = 3,
["ChallengeModeDeathKnight"] = 5,
["T0Shaman"] = 1,
["T1112DruidBalance"] = 4,
["T456PaladinRetribution"] = 2,
["TabardsAlliance"] = 5,
["LeatherLeatherArmorCata"] = 6,
["T14PriestHoly"] = 5,
["TKEyeAlar"] = 2,
["T9DruidFeral"] = 3,
["T10WarriorProtection"] = 3,
["ArchaeologyOrc"] = 6,
["TailoringMisc"] = 6,
["GundrakEck"] = 3,
["BDOmnotron"] = 4,
["TailoringWhitemendWis"] = 6,
["HuojinPandaren"] = 1,
["LeatherworkingLeatherWindhawkArmor"] = 6,
["TheSonsofHodir"] = 3,
["ThoriumBrotherhood"] = 1,
["Naxx80Faerlina"] = 3,
["AuchSethekkRavenGod"] = 2,
["AlchemyCauldron"] = 6,
["PoSKrickIck"] = 3,
["ArchaeologyTroll"] = 6,
["T10DruidFeral"] = 3,
["Exodar"] = 1,
["LeatherworkingMailNetherscaleArmor"] = 6,
["NaxxDruidRestoration"] = 3,
["T13PriestHoly"] = 4,
["HardModeAccessories"] = 2,
["TailoringTheUnyielding"] = 6,
["T3Hunter"] = 1,
["PVP85Warrior"] = 4,
["AuchManaYor"] = 2,
["JewelSerpentsEye"] = 6,
["CookingBuff"] = 6,
["PVP85PaladinHoly"] = 4,
["WSGMisc"] = 1,
["SPTrash"] = 2,
["UPTrash"] = 3,
["AuchCryptsAvatar"] = 2,
["ICCPutricide"] = 3,
["AQEnchants"] = 1,
["BlacksmithingPlateImperialPlate"] = 6,
["SmithingArmorWrath"] = 6,
["T10Hunter"] = 3,
["DarkspearRebellion"] = 5,
["TKBotSarannis"] = 2,
["BWLFiremaw"] = 1,
["TJSShaDoubt"] = 5,
["DeadminesRipsnarl"] = 4,
["ICCValithria"] = 3,
["DragonSoulHagara"] = 4,
["ChallengeModeMage"] = 5,
["MaraudonLoot"] = 1,
["Inscription_Priest"] = 6,
["Nagrand"] = 2,
["PVP70NonSet"] = 2,
["HoOAmmunae"] = 4,
["T0Hunter"] = 1,
["Maghar"] = 2,
["LeatherworkingMailNetherFury"] = 6,
["PVP90Weapons"] = 5,
["STRATStonespine"] = 1,
["UPPalehoof"] = 3,
["Inscription_Druid"] = 6,
["TBCSets"] = 2,
["T9Rogue"] = 3,
["PetsRemoved"] = 5,
["HoFMeljarak"] = 5,
["ChallengeModeDruid"] = 5,
["BlacksmithingMailFelIronChain"] = 6,
["EmblemofFrost"] = 3,
["PetsFaction"] = 5,
["HardModeCloaks"] = 2,
["T456PaladinProtection"] = 2,
["PetsCardGame"] = 5,
["TailoringArmorCata"] = 6,
["RaresMOPMobsWarbringer"] = 5,
["LBRSLordMagus"] = 1,
["ShadowfangGodfrey"] = 4,
["HCHallsOmrogg"] = 2,
["BRDBaelGar"] = 1,
["StonecoreOzruk"] = 4,
["T14ShamanElemental"] = 5,
["T15DruidRestoration"] = 5,
["DeadminesFoeReaper"] = 4,
["ScholoJandice"] = 5,
["TransformationNonconsumedItems"] = 5,
["HardModeWeapons"] = 2,
["TailoringArmorWotLK"] = 6,
["TheWyrmrestAccord"] = 3,
["UtgardeKeepSkarvald"] = 3,
["T9DeathKnightTank"] = 3,
["Undercity"] = 1,
["DMNThimblejack"] = 1,
["DominationPoint"] = 5,
["BlacksmithingPlateFaithFelsteel"] = 6,
["DrakTharonKeepKingDred"] = 3,
["BRDBSPlans"] = 1,
["T14ShamanRestoration"] = 5,
["RazorfenDownsLoot"] = 1,
["CFRSerpentMorogrim"] = 2,
["Naxx80Grobbulus"] = 3,
["CookingStandard"] = 6,
["PVP85DruidFeral"] = 4,
["PVP70PaladinRetribution"] = 2,
["TheNexusKeristrasza"] = 3,
["DMBooks"] = 1,
["Hellfire"] = 2,
["CookingAPSP"] = 6,
["STRATHearthsingerForresten"] = 1,
["TotTNazjar"] = 4,
["SmithingArmorEnhancement"] = 6,
["AhnkahetVolazj"] = 3,
["OldKeys"] = 1,
["ZAMalacrass"] = 4,
["FrenzyheartTribe"] = 3,
["T1112ShamanEnhancement"] = 4,
["T0Druid"] = 1,
["T14PaladinHoly"] = 5,
["T9PaladinProtection"] = 3,
["GundrakMoorabi"] = 3,
["BloodsailBuccaneers"] = 1,
["T14DruidBalance"] = 5,
["T10DruidRestoration"] = 3,
["CFRSteamTrash"] = 2,
["PVP70BrutalWeapons"] = 2,
["HallsofStoneTrash"] = 3,
["HallsofLightningIonar"] = 3,
["CFRSerpentKarathress"] = 2,
["UldamanLoot"] = 1,
["STRATFrasSiabi"] = 1,
["JewelcraftingDailyRed"] = 6,
["TKEyeVoidReaver"] = 2,
["FishingDaily"] = 6,
["ToTTwinConsorts"] = 5,
["AB4049"] = 1,
["OcuEregos"] = 3,
["PetsPetStore"] = 5,
["STTrash"] = 1,
["EngineeringGem"] = 6,
["T13PaladinRetribution"] = 4,
["Naxx80Razuvious"] = 3,
["T15WarriorFury"] = 5,
["HallsofLightningTrash"] = 3,
["BoTSinestra"] = 4,
["UlduarKologarn"] = 3,
["UlduarVezax"] = 3,
["Enchanting2HWeapon"] = 6,
["Naxx80Noth"] = 3,
["MCTrashMobs"] = 1,
["AQ20Buru"] = 1,
["LeatherLeatherArmorWrath"] = 6,
["T14Rogue"] = 5,
["UlduarFreya"] = 3,
["ICCGunshipBattle"] = 3,
["VPAltairus"] = 4,
["RaresMOPMobsMisc"] = 5,
["T456Warlock"] = 2,
["AQ40Ouro"] = 1,
["HoORajh"] = 4,
["Thrallmar"] = 2,
["T14MonkDPS"] = 5,
["Blackfathom"] = 1,
["PVP90PriestHoly"] = 5,
["ShadowfangSpringvale"] = 4,
["HoRFalric"] = 3,
["ShadowfangTrash"] = 4,
["MountHyjalAnetheron"] = 2,
["TheAshenVerdict"] = 3,
["STRATMagistrateBarthilas"] = 1,
["BRDMagmus"] = 1,
["TrialoftheChampionBlackKnight"] = 3,
["PVP80PaladinRetribution"] = 3,
["AQ20Ossirian"] = 1,
["BDNefarian"] = 4,
["ScholoRattlegore"] = 5,
["PVP90MonkHealer"] = 5,
["JewelRed"] = 6,
["UlduarLeviathan"] = 3,
["AzjolNerubAnubarak"] = 3,
["LionsLanding"] = 5,
["UldDwarves"] = 1,
["OcuTrash"] = 3,
["BRDFlamelash"] = 1,
["ChallengeModePriest"] = 5,
["T14Hunter"] = 5,
["BRDPanzor"] = 1,
["ShadoPanShaViolence"] = 5,
["T14MonkTank"] = 5,
["ToTTortos"] = 5,
["PVP90WeaponsTyrannicalElite"] = 5,
["T14PriestShadow"] = 5,
["LBRSSpirestoneLord"] = 1,
["PVP80DruidFeral"] = 3,
["NaxxWarriorProtection"] = 3,
["ICCLichKing"] = 3,
["T1112Hunter"] = 4,
["UtgardeKeepIngvar"] = 3,
["Weaponsmith"] = 6,
["Ashtongue"] = 2,
["T15Warlock"] = 5,
["GoldenLotus"] = 5,
["BTSupremus"] = 2,
["LBRSVoone"] = 1,
["AhnkahetAmanitar"] = 3,
["PVP70WarlockDestruction"] = 2,
["KaraChess"] = 2,
["SMTKaelthas"] = 2,
["T15PaladinRetribution"] = 5,
["EmblemofHeroism"] = 3,
["UlduarPatterns"] = 3,
["EndtimeEchoes"] = 4,
["DMELethtendrisPimgib"] = 1,
["HoFZorlok"] = 5,
["DeadminesGearbreaker"] = 4,
["T456DruidFeral"] = 2,
["NaxxDeathKnightDPS"] = 3,
["Orgrimmar"] = 1,
["UldTrash"] = 1,
["FirelandsBethtilac"] = 4,
["EnchantingShieldOffHand"] = 6,
["ToESTsulong"] = 5,
["FHTrashMobs"] = 3,
["PVP80DruidBalance"] = 3,
["T456ShamanRestoration"] = 2,
["HoTBenedictus"] = 4,
["BTCouncil"] = 2,
["ICCSaurfang"] = 3,
["T10ShamanEnhancement"] = 3,
["TabardsNeutralFaction"] = 5,
["ZFTrash"] = 1,
["LeatherMailArmorBC"] = 6,
["AuchShadowMurmur"] = 2,
["LostCityHusam"] = 4,
["WoEAzshara"] = 4,
["LostCitySiamat"] = 4,
["T10Warlock"] = 3,
["BDTrash"] = 4,
["ScholoGandling"] = 5,
["MCShazzrah"] = 1,
["T13Rogue"] = 4,
["GundrakSladran"] = 3,
["T10DeathKnightTank"] = 3,
["PVP85Mage"] = 4,
["NaxxShamanRestoration"] = 3,
["T15DeathKnightTank"] = 5,
["HardModeMail"] = 2,
["ChallengeModeHunter"] = 5,
["MoguShanGekkan"] = 5,
["T15PaladinHoly"] = 5,
["T9Hunter"] = 3,
["T456WarriorProtection"] = 2,
["T14PaladinRetribution"] = 5,
["KaraNetherspite"] = 2,
["BRDImperatorDagranThaurissan"] = 1,
["STDragons"] = 1,
["TheNexusOrmorok"] = 3,
["BlackrockCavernsSteelbender"] = 4,
["PVP60Paladin"] = 1,
["KaraCurator"] = 2,
["EnchantingRing"] = 6,
["StonecoreCorborus"] = 4,
["VioletHoldZuramat"] = 3,
["ChallengeModeMonk"] = 5,
["T1112Rogue"] = 4,
["PVP80Rogue"] = 3,
["Naxx80Maexxna"] = 3,
["FirelandsRhyolith"] = 4,
["TotTOzumat"] = 4,
["SmithingArmorRemoved"] = 6,
["PetsAccessories"] = 5,
["MountHyjalArchimonde"] = 2,
["PVP70DeathKnight"] = 2,
["T14MonkHealer"] = 5,
["T456WarriorFury"] = 2,
["TKArcUnbound"] = 2,
["LBRSZigris"] = 1,
["RaresMOPMobsKrasarangWilds"] = 5,
["EngineeringArmorMail"] = 6,
["T456PriestShadow"] = 2,
["HallsofLightningVolkhan"] = 3,
["T10PaladinProtection"] = 3,
["AzjolNerubTrash"] = 3,
["AQ40Huhuran"] = 1,
["DMNGuardSlipkik"] = 1,
["BDMagmaw"] = 4,
["T14DeathKnightTank"] = 5,
["LeatherLeatherArmorOld"] = 6,
["TJSStonestep"] = 5,
["WorldEpics4049"] = 1,
["MountsCardGame"] = 5,
["BlacksmithingPlateKhoriumWard"] = 6,
["ArchaeologyArmorAndWeapons"] = 6,
["EngineeringFirework"] = 6,
["T9ShamanEnhancement"] = 3,
["ToTLeiShen"] = 5,
["TailoringDuskweaver"] = 6,
["RaresMOPMobsClawlord"] = 5,
["LowerCity"] = 2,
["PVP70DruidBalance"] = 2,
["DragonSoulPatterns"] = 4,
["GotSSRaigonn"] = 5,
["TheKaluak"] = 3,
["Aldor"] = 2,
["Axesmith"] = 6,
["TabardsHorde"] = 5,
["NaxxDruidBalance"] = 3,
["LeatherworkingLeatherBloodTigerH"] = 6,
["MCRagnaros"] = 1,
["T10ShamanElemental"] = 3,
["LeatherworkingLeatherSClefthoof"] = 6,
["MCGeddon"] = 1,
["LostCityLockmaw"] = 4,
["AuchSethekkDarkweaver"] = 2,
["SMThalnos"] = 5,
["FirelandsAlysrazor"] = 4,
["DMWIllyannaRavenoak"] = 1,
["T0Rogue"] = 1,
["AhnkahetJedoga"] = 3,
["UBRSRend"] = 1,
["MountsNEW"] = 5,
["FirelandsStaghelm"] = 4,
["ICCSindragosa"] = 3,
["AQ40Viscidus"] = 1,
["FirelandsShared"] = 4,
["ICCLordMarrowgar"] = 3,
["T1T2Paladin"] = 1,
["DeadminesGlubtok"] = 4,
["CoTStratholmeMalGanis"] = 3,
["ZGTrash"] = 4,
["HoRLichKing"] = 3,
["LBRSHalycon"] = 1,
["UBRSSolakar"] = 1,
["DMWPrinceTortheldrin"] = 1,
["Inscription_DeathKnight"] = 6,
["BRDTheVault"] = 1,
["Darnassus"] = 1,
["Inscription_Scrolls"] = 6,
["ToTShared"] = 5,
["T3Druid"] = 1,
["TFWConclave"] = 4,
["ShadowfangAshbury"] = 4,
["AlchemyPotion"] = 6,
["TFWAlAkir"] = 4,
["BilgewaterCartel"] = 1,
["LeatherLeatherArmorMoP"] = 6,
["T3Rogue"] = 1,
["HellscreamsReach"] = 4,
["HardModeResist"] = 2,
["TKMechSepethrea"] = 2,
["Lorewalkers"] = 5,
["PVP85DeathKnight"] = 4,
["T14Warlock"] = 5,
["JewelPurple"] = 6,
["LeatherworkingMailStormhideBattlegear"] = 6,
["PVP60Warlock"] = 1,
["BRDHoundmaster"] = 1,
["T9WarriorFury"] = 3,
["GruulsLairHighKingMaulgar"] = 2,
["UtgardeKeepKeleseth"] = 3,
["T456Rogue"] = 2,
["CoTHillsbradHunter"] = 2,
["UBRSEmberseer"] = 1,
["PVP85PriestHoly"] = 4,
["AQ20Rajaxx"] = 1,
["LeatherMailArmorOld"] = 6,
["PVP90DruidRestoration"] = 5,
["CFRSerpentTrash"] = 2,
["ICCCouncil"] = 3,
["EnchantingGloves"] = 6,
["SMTTrash"] = 2,
["JewelChimerasEye"] = 6,
["AvengersHyjal"] = 4,
["BTTrash"] = 2,
["PVP85ShamanRestoration"] = 4,
["HoFShekzeer"] = 5,
["PVP85DruidBalance"] = 4,
["JewelOrange"] = 6,
["HoOTrash"] = 4,
["ToTDurumu"] = 5,
["BTReliquaryofSouls"] = 2,
["CFRSlaveQuagmirran"] = 2,
["BWLChromaggus"] = 1,
["DMWTendrisWarpwood"] = 1,
["T1112DeathKnightTank"] = 4,
["TransformationAdditionalEffects"] = 5,
["PVP90Accessories"] = 5,
["LBRSQuestItems"] = 1,
["CoTMorassAeonus"] = 2,
["T1T2Warrior"] = 1,
["T1112PriestShadow"] = 4,
["PVP90DeathKnight"] = 5,
["Ogrila"] = 2,
["WoETrash"] = 4,
["ZFGahzrilla"] = 1,
["SMKorloff"] = 5,
["MCGolemagg"] = 1,
["T9ShamanRestoration"] = 3,
["T13DeathKnightDPS"] = 4,
["ToTJinrokh"] = 5,
["T13DruidRestoration"] = 4,
["BlacksmithingPlateSavageSaroniteBattlegear"] = 6,
["DeadminesVanessa"] = 4,
["AQ40Sartura"] = 1,
["PVP80Warlock"] = 3,
["PVP80Mage"] = 3,
["CoTStratholmeEpoch"] = 3,
["JewelcraftingDailyOrange"] = 6,
["DragonSoulYorsahj"] = 4,
["T0Paladin"] = 1,
["T3Priest"] = 1,
["BoTTrash"] = 4,
["DMWTrash"] = 1,
["T456ShamanElemental"] = 2,
["PVP70Accessories"] = 2,
["PVP80DruidRestoration"] = 3,
["PVP70ShamanEnhancement"] = 2,
["KaraNamed"] = 2,
["JewelBlue"] = 6,
["Stormwind"] = 1,
["STRATLordAuriusRivendare"] = 1,
["ArchaeologyDraenei"] = 6,
["T13PaladinProtection"] = 4,
["PVP80Warrior"] = 3,
["T13PriestShadow"] = 4,
["PVP85DruidRestoration"] = 4,
["RaresMOPMobsValleyFourWinds"] = 5,
["DragonSoulUltraxion"] = 4,
["T1T2Rogue"] = 1,
["ZFDustwraith"] = 1,
["NaxxDruidFeral"] = 3,
["TheOracles"] = 3,
["BaradinsWardens"] = 4,
["RaresMOPItemsTownlongSteppesDreadWastes"] = 5,
["EnchantingChest"] = 6,
["Zangarmarsh"] = 2,
["TKTrash"] = 2,
["WorldEpics70"] = 3,
["BRDGolemLordArgelmach"] = 1,
["T456ShamanEnhancement"] = 2,
["TrialoftheChampionChampions"] = 3,
["ZATimedChest"] = 4,
["PVP70DruidFeral"] = 2,
["RagefireChasmLoot"] = 1,
["T13ShamanElemental"] = 4,
["T0Priest"] = 1,
["UPSorrowgrave"] = 3,
["T13ShamanEnhancement"] = 4,
["ZGZanzil"] = 4,
["AuchManaNexusPrince"] = 2,
["EngineeringWeapon"] = 6,
["T13WarriorFury"] = 4,
["T1112PaladinProtection"] = 4,
["T1112DruidRestoration"] = 4,
["SmithingWeaponBC"] = 6,
["T13DruidBalance"] = 4,
["DMNCaptainKromcrush"] = 1,
["PVP70Rogue"] = 2,
["MoguShanXin"] = 5,
["MCMagmadar"] = 1,
["MCGarr"] = 1,
["TKArcDalliah"] = 2,
["TJSFlameheart"] = 5,
["T13WarriorProtection"] = 4,
["FirelandsBaleroc"] = 4,
["BagsGeneral"] = 4,
["OcuCloudstrider"] = 3,
["EngineeringArmorPlate"] = 6,
["ZFWitchDoctorZumrah"] = 1,
["MoltenFront"] = 4,
["STRATRamsteintheGorger"] = 1,
["BoTValionaTheralion"] = 4,
["UlduarTrash"] = 3,
["BreweryHoptallus"] = 5,
["MoguShanTrialKing"] = 5,
["CFRSteamThespia"] = 2,
["BoTWyrmbreaker"] = 4,
["STRATBlackGuardSwordsmith"] = 1,
["Scryer"] = 2,
["SmithingCataVendor"] = 6,
["ShadoPanTaranZhu"] = 5,
["StonecoreSlabhide"] = 4,
["GotSSGadok"] = 5,
["ShadowfangSilverlaine"] = 4,
["T10Mage"] = 3,
["DragonSoulDeathwingMadness"] = 4,
["DrakTharonKeepTharonja"] = 3,
["JewelcraftingDailyMeta"] = 6,
["DMETrash"] = 1,
["TrialoftheCrusaderPatterns"] = 3,
["HoOSetesh"] = 4,
["BTGorefiend"] = 2,
["ChallengeModeWarrior"] = 5,
["Malygos"] = 3,
["KaraMoroes"] = 2,
["T13Mage"] = 4,
["TKBotFreywinn"] = 2,
["MSVGarajal"] = 5,
["Patternsilvl496"] = 5,
["Nalak"] = 5,
["BlacksmithingPlateFlameG"] = 6,
["MSVSpiritKings"] = 5,
["ToESProtectors"] = 5,
["LeatherworkingLeatherDevilsaurArmor"] = 6,
["T15DruidBalance"] = 5,
["BRDQuestItems"] = 1,
["SMTDelrissa"] = 2,
["PVP90DruidFeral"] = 5,
["TailoringPrimalMoon"] = 6,
["MountsAlliance"] = 5,
["ToTPrimordius"] = 5,
["EngineeringArmorLeather"] = 6,
["ArchaeologyFossil"] = 6,
["BlacksmithingPlateTheDarksoul"] = 6,
["NaxxPriestShadow"] = 3,
["PVP60Mage"] = 1,
["ToTJiKun"] = 5,
["RazorfenKraulLoot"] = 1,
["PVP60Accessories"] = 1,
["ToTDarkAnimus"] = 5,
["SMTVexallus"] = 2,
["ToTCouncil"] = 5,
["BTNajentus"] = 2,
["EngineeringPetMount"] = 6,
["DeadminesCookie"] = 4,
["Inscription_Hunter"] = 6,
["T1T2Mage"] = 1,
["HoOAnraphet"] = 4,
["WinterfinRetreat"] = 3,
["RaresMOPItemsKrasarangWildsKunLaiSummit"] = 5,
["Inscription_Staves"] = 6,
["TabardsAchievementQuestRare"] = 5,
["TrialoftheChampionEadricthePure"] = 3,
["UlduarYoggSaron"] = 3,
["T14Mage"] = 5,
["DragonmawClan"] = 4,
["UlduarThorim"] = 3,
["StonecoreTrash"] = 4,
["AhnkahetNadox"] = 3,
["HoOPtah"] = 4,
["PVP90PaladinRetribution"] = 5,
["T14ShamanEnhancement"] = 5,
["PVP70Mage"] = 2,
["LeatherworkingMailGreenDragonM"] = 6,
["HeirloomBoAMisc"] = 5,
["JewelcraftingDailyDragonEye"] = 6,
["T3Warlock"] = 1,
["BlacksmithingMailBloodsoulEmbrace"] = 6,
["Inscription_Rogue"] = 6,
["DrakTharonKeepTrollgore"] = 3,
["FishingGear"] = 6,
["DragonSoulShared"] = 4,
["Inscription_Mage"] = 6,
["ChallengeModePaladin"] = 5,
["EngineeringArmorTrinket"] = 6,
["ABMisc"] = 1,
["SmithingMoPVendor"] = 6,
["BWLRazorgore"] = 1,
["CookingOtherBuffs"] = 6,
["Inscription_Monk"] = 6,
["ToTTrash"] = 5,
["RaresMOPMobsJadeForest"] = 5,
["EnchantingWeapon"] = 6,
["EngineeringArmor"] = 6,
["MountHyjalAzgalor"] = 2,
["LBRSOmokk"] = 1,
["GnomereganRep"] = 1,
["EarthenRing"] = 4,
["FoSDevourer"] = 3,
["Naxx80Sapphiron"] = 3,
["LeatherworkingMailBlueDragonM"] = 6,
["STRATRisenHammersmith"] = 1,
["T1112DeathKnightDPS"] = 4,
["AQ20Kurinnaxx"] = 1,
["Inscription_Misc"] = 6,
["JewelcraftingDailyYellow"] = 6,
["Naxx80KelThuzad"] = 3,
["TailoringNeatherVest"] = 6,
["T14DeathKnightDPS"] = 5,
["DS3Cloth"] = 2,
["T15DruidTank"] = 5,
["AuchManaPandemonius"] = 2,
["NaxxRogue"] = 3,
["LeatherworkingLeatherIronfeatherArmor"] = 6,
["DragonSoulBlackhorn"] = 4,
["T15ShamanRestoration"] = 5,
["RaresMOPMobsTownlongSteppes"] = 5,
["JewelMisc"] = 6,
["RaresMOPMobsValeOfEternalBlossoms"] = 5,
["ZGMandokir"] = 4,
["KaraOperaEvent"] = 2,
["JewelcraftingDailyRemoved"] = 6,
["STRATTimmytheCruel"] = 1,
["PVP90WeaponsTyrannical"] = 5,
["LeatherworkingMailFrostscaleBinding"] = 6,
["KeepersofTime"] = 2,
["BRDPrincess"] = 1,
["MountsRemoved"] = 5,
["BWLTrashMobs"] = 1,
["OperationShieldwall"] = 5,
["LeatherworkingLeatherIceborneEmbrace"] = 6,
["JusticePoints"] = 4,
["LeatherworkingMailNetherstrikeArmor"] = 6,
["CenarionCircle"] = 1,
["BRDGeneralAngerforge"] = 1,
["T15PaladinProtection"] = 5,
["RaresMOPItemsJadeForestValleyoftheFourWinds"] = 5,
["AVBlue"] = 1,
["VPTrash"] = 4,
["TrialoftheCrusaderTwinValkyrs"] = 3,
["ArchaeologyMantid"] = 6,
["TushuiPandaren"] = 1,
["NaxxWarriorFury"] = 3,
["Anglers"] = 5,
["FishingPoles"] = 6,
["BizmosBrawlpubBrawlgarArena"] = 5,
["AzjolNerubKrikthir"] = 3,
["ICCRotface"] = 3,
["ShadoPanSnowdrift"] = 5,
["VWOWSets"] = 1,
["BWLLashlayer"] = 1,
["ChallengeModeRogue"] = 5,
["ICCLadyDeathwhisper"] = 3,
["ArchaeologyNerubian"] = 6,
["UBRSFLAME"] = 1,
["DMNChoRush"] = 1,
["T1112PaladinHoly"] = 4,
["MountsRareRaid"] = 5,
["AlchemyMisc"] = 6,
["SmithingWeaponOld"] = 6,
["ShadoPan"] = 5,
["HeirloomBoAWeapons"] = 5,
["LakeWintergrasp"] = 3,
["PVP60Weapons"] = 1,
["T15Mage"] = 5,
["TKMechCapacitus"] = 2,
["PVP70Hunter"] = 2,
["VioletHoldErekem"] = 3,
["PVP90PriestShadow"] = 5,
["T13Hunter"] = 4,
["HCRampOmor"] = 2,
["ZATrash"] = 4,
["ExplorersLeagueWarsongOffensive"] = 3,
["TKBotThorngrin"] = 2,
["GBThrongus"] = 4,
["PVP90ShamanEnhancement"] = 5,
["JewelMeta"] = 6,
["TailoringFrostsavageBattlegear"] = 6,
["CFRUnderSwamplord"] = 2,
["HCHallsPorung"] = 2,
["VioletHoldXevozz"] = 3,
["Hammersmith"] = 6,
["MountsEvent"] = 5,
["ArgentTournamentFaction"] = 3,
["JewelGreen"] = 6,
["LeatherMailArmorCata"] = 6,
["ArchaeologyVrykul"] = 6,
["HCRampVazruden"] = 2,
["LostCityTrash"] = 4,
["HardModeCloth"] = 2,
["TKBotLaj"] = 2,
["BTIllidanStormrage"] = 2,
["DS3Leather"] = 2,
["BlackrockCavernsTrash"] = 4,
["EndtimeMurozond"] = 4,
["CExpedition"] = 2,
["AB2039"] = 1,
["BlacksmithingPlateFelIronPlate"] = 6,
["HoTDawnslayer"] = 4,
["TKArcScryer"] = 2,
["DragonSoulMorchok"] = 4,
["MountsHorde"] = 5,
["TailoringSpellfireWrath"] = 6,
["STRATBaronessAnastari"] = 1,
["BRDGuzzler"] = 1,
["SMTFireheart"] = 2,
["EnchantingBracer"] = 6,
["DragonSoulZonozz"] = 4,
["DrakTharonKeepNovos"] = 3,
["TrialoftheChampionConfessorPaletress"] = 3,
["TrialoftheCrusaderNorthrendBeasts"] = 3,
["AlchemyFlask"] = 6,
["PVP85Misc"] = 4,
["HardModeLeather"] = 2,
["PVP85ShamanEnhancement"] = 4,
["HonorHold"] = 2,
["SmithingArmorCata"] = 6,
["PVP70ShamanElemental"] = 2,
["T10DeathKnightDPS"] = 3,
["T9Warlock"] = 3,
["PVP80DeathKnight"] = 3,
["GBTrash"] = 4,
["AlchemyOil"] = 6,
["KaraAran"] = 2,
["DMNKingGordok"] = 1,
["PVP85ShamanElemental"] = 4,
["T9PriestHoly"] = 3,
["GruulGruul"] = 2,
["SPKiljaeden"] = 2,
["FirstAid"] = 6,
["PetsQuest"] = 5,
["FishingLuresLines"] = 6,
["ZAJanAlai"] = 4,
["CoTMorassTemporus"] = 2,
["ToTHorridon"] = 5,
["EngineeringScope"] = 6,
["PVP85Weapons4"] = 4,
["AQ40BugFam"] = 1,
["PVP85Hunter"] = 4,
["JewelcraftingDailyPurple"] = 6,
["TailoringCloth"] = 6,
["OcuUrom"] = 3,
}
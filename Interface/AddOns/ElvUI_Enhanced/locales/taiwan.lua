local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "zhTW")
if not L then return end

-- Translation by: xjjxfpyyyf, zhouf616

-- Init
L["ENH_LOGIN_MSG"] = "您正在使用 |cff1784d1ElvUI Enhanced|r version %s%s|r."
L["Your version of ElvUI is to old (required v5.81 or higher). Please, download the latest version from tukui.org."] = "您的ElvUI版本過低(需要 v5.81 或更高), 請前往tukui.org下載最新版本."

-- Equipment
L["Equipment"] = "自動換裝"
L["EQUIPMENT_DESC"] = "當你切換專精或進入戰場時自動更換裝備, 你可以在選項中選擇相關的裝備模組."
L["No Change"] = "不改變"

L["Specialization"] = "專精"
L["Enable/Disable the specialization switch."] = "開啓/關閉 專精切換"

L["Primary Talent"] = "主專精"
L["Choose the equipment set to use for your primary specialization."] = "選擇當你使用主專精時的裝備模組."

L["Secondary Talent"] = "副專精"
L["Choose the equipment set to use for your secondary specialization."] = "選擇當你使用副專精時的裝備模組."

L["Battleground"] = "戰場"
L['Enable/Disable the battleground switch.'] = "開啓/關閉 戰場切換"

L["Equipment Set"] = "裝備模組"
L["Choose the equipment set to use when you enter a battleground or arena."] = "選擇當你進入戰場時的裝備模組."

L["You have equipped equipment set: "] = "你已裝備此模組: "

L["DURABILITY_DESC"] = "調整設置人物窗口裝備耐久度顯示."
L['Enable/Disable the display of durability information on the character screen.'] = "開啓/關閉 人物窗口裝備耐久度顯示."
L["Damaged Only"] = "受損顯示"
L["Only show durabitlity information for items that are damaged."] = "只在裝備受損時顯示耐久度."

L["ITEMLEVEL_DESC"] = "Adjust the settings for the item level information on the character screen."
L["Enable/Disable the display of item levels on the character screen."] = true

L["Miscellaneous"] = true
L['Equipment Set Overlay'] = true
L['Show the associated equipment sets for the items in your bags (or bank).'] = true

-- Movers
L["Mover Transparency"] = true
L["Changes the transparency of all the movers."] = true

-- Automatic Role Assignment
L['Automatic Role Assignment'] = true
L['Enables the automatic role assignment based on specialization for party / raid members (only work when you are group leader or group assist).'] = true

-- GPS module
L['GPS'] = "GPS定位"
L['Show the direction and distance to the selected party or raid member.'] = "顯示你與當前隊伍或團隊成員的方向与距離."

-- Attack Icon
L['Attack Icon'] = true
L['Show attack icon for units that are not tapped by you or your group, but still give kill credit when attacked.'] = true

-- Minimap Location
L['Above Minimap'] = true
L['Location Digits'] = true
L['Number of digits for map location.'] = true

-- Minimap Combat Hide
L["Hide minimap while in combat."] = true
L["FadeIn Delay"] = true
L["The time to wait before fading the minimap back in after combat hide. (0 = Disabled)"] = true

-- Minimap Buttons
L["Minimap Button Bar"] = "小地圖按鈕整合列"
L['Skin Buttons'] = "美化按鈕"
L['Skins the minimap buttons in Elv UI style.'] = "將小地圖圖標美化成ElvUI風格."
L['Skin Style'] = "美化風格"
L['Change settings for how the minimap buttons are skinned.'] = "改變美化設定."
L['The size of the minimap buttons.'] = "小地圖圖標尺寸."

L['No Anchor Bar'] = "沒有錨點"
L['Horizontal Anchor Bar'] = "水平狀"
L['Vertical Anchor Bar'] = "垂直狀"

-- PvP Autorelease
L['PvP Autorelease'] = "PVP自動釋放靈魂"
L['Automatically release body when killed inside a battleground.'] = "在戰場死亡後自動釋放靈魂."

-- Track Reputation
L['Track Reputation'] = "聲望追蹤"
L['Automatically change your watched faction on the reputation bar to the faction you got reputation points for.'] = "當你獲得某個陣營的聲望時, 將自動追蹤此陣營的聲望至經驗值欄位." 

-- Select Quest Reward
L['Select Quest Reward'] = true
L['Automatically select the quest reward with the highest vendor sell value.'] = true

-- Range Datatext
L['Distance'] = "距離"

-- Extra Datatexts
L['Actionbar1DataPanel'] = '快捷列 1 資訊框'
L['Actionbar3DataPanel'] = '快捷列 3 資訊框'
L['Actionbar5DataPanel'] = '快捷列 5 資訊框'

-- Farmer
L["Sunsong Ranch"] = "日歌農莊"
L["The Halfhill Market"] = "半丘市集"
L["Tilled Soil"] = "開墾過的沃土"
L['Right-click to drop the item.'] = "右鍵點擊需刪除的項目."
 
L['Farmer'] = "農夫"
L['Farmer Portal Bar'] = "農夫列:傳送"
L['Farmer Seed Bar'] = "農夫列:種子"
L['Farmer Tools Bar'] = "農夫列:工具"
L["FARMER_DESC"] = "調整設置以便你在日歌農莊更有效的耕作."
L['Farmer Bars'] = "農夫列"
L['Enable/Disable the farmer bars.'] = "開啓/關閉 農夫快捷列."
L['Only active buttons'] = "只顯示有效的按鈕"
L['Only show the buttons for the seeds, portals, tools you have in your bags.'] = "只顯示你背包中有的種子, 傳送和工具."
L['Drop Tools'] = "刪除工具"
L['Automatically drop tools from your bags when leaving the farming area.'] = "當你離開農莊範圍時, 自動刪除背包中的工具."
L['Seed Bar Direction'] = true
L['The direction of the seed bar buttons (Horizontal or Vertical).'] = true
 
-- Nameplates
L["Threat Text"] = "威脅值文字"
L["Display threat level as text on targeted, boss or mouseover nameplate."] = "在首領或鼠標懸停的血條上顯示威脅等級文字."

-- HealGlow
L['Heal Glow'] = true
L['Direct AoE heals will let the unit frames of the affected party / raid members glow for the defined time period.'] = true
L["Glow Duration"] = true
L["The amount of time the unit frames of party / raid members will glow when affected by a direct AoE heal."] = true
L["Glow Color"] = true

-- WatchFrame
L['WatchFrame'] = true
L['WATCHFRAME_DESC'] = "Adjust the settings for the visibility of the watchframe (questlog) to your personal preference."
L['Hidden'] = true
L['Collapsed'] = true
L['Settings'] = true
L['City (Resting)'] = true
L['PvP'] = true
L['Arena'] = true
L['Party'] = true
L['Raid'] = true

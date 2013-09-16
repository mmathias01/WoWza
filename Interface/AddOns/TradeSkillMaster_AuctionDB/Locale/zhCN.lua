-- ------------------------------------------------------------------------------ --
--                           TradeSkillMaster_AuctionDB                           --
--           http://www.curse.com/addons/wow/tradeskillmaster_auctiondb           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- TradeSkillMaster_AuctionDB Locale - zhCN
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkillMaster_AuctionDB/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster_AuctionDB", "zhCN")
if not L then return end

L["A full auction house scan will scan every item on the auction house but is far slower than a GetAll scan. Expect this scan to take several minutes or longer."] = "完整扫描拍卖行内的所有物品，此方式远慢于快速扫描，预计费时几分钟甚至更久。" -- Needs review
-- L["A GetAll scan is the fastest in-game method for scanning every item on the auction house. However, there are many possible bugs on Blizzard's end with it including the chance for it to disconnect you from the game. Also, it has a 15 minute cooldown."] = ""
-- L["Any items in the AuctionDB database that contain the search phrase in their names will be displayed."] = ""
L["Are you sure you want to clear your AuctionDB data?"] = "你确定你要清除AuctionDB的数据吗?" -- Needs review
L["Ascending"] = "递增" -- Needs review
L["AuctionDB - Market Value"] = "AuctionDB - 市场价格" -- Needs review
L["AuctionDB - Minimum Buyout"] = "AuctionDB - 最低一口价" -- Needs review
-- L["Can't run a GetAll scan right now."] = ""
L["Descending"] = "递减" -- Needs review
-- L["Display lowest buyout value seen in the last scan in tooltip."] = ""
-- L["Display market value in tooltip."] = ""
-- L["Display number of items seen in the last scan in tooltip."] = ""
-- L["Display total number of items ever seen in tooltip."] = ""
L["Done Scanning"] = "完成扫描" -- Needs review
-- L["Download the FREE TSM desktop application which will automatically update your TSM_AuctionDB prices using Blizzard's online APIs (and does MUCH more). Visit %s for more info and never scan the AH again! This is the best way to update your AuctionDB prices."] = ""
L["Enable display of AuctionDB data in tooltip."] = "在鼠标提示中显示AuctionDB数据" -- Needs review
-- L["GetAll scan did not run successfully due to issues on Blizzard's end. Using the TSM application for your scans is recommended."] = ""
L["Hide poor quality items"] = "隐藏灰色物品" -- Needs review
L["If checked, poor quality items won't be shown in the search results."] = "开启本选项,灰色物品将不在扫描结果中显示." -- Needs review
-- L["If checked, the lowest buyout value seen in the last scan of the item will be displayed."] = ""
-- L["If checked, the market value of the item will be displayed"] = ""
-- L["If checked, the number of items seen in the last scan will be displayed."] = ""
-- L["If checked, the total number of items ever seen will be displayed."] = ""
-- L["Imported %s scans worth of new auction data!"] = ""
L["Invalid value entered. You must enter a number between 5 and 500 inclusive."] = "输入错误,你必须输入一个5 - 500 之间的数字." -- Needs review
L["Item Link"] = "物品链接" -- Needs review
L["Item MinLevel"] = "最低物品等级" -- Needs review
L["Items per page"] = "每页显示的物品" -- Needs review
L["Items %s - %s (%s total)"] = "物品 %s - %s (总数 %s) " -- Needs review
L["Item SubType Filter"] = "物品子类型过滤" -- Needs review
L["Item Type Filter"] = "物品类型过滤" -- Needs review
L["It is strongly recommended that you reload your ui (type '/reload') after running a GetAll scan. Otherwise, any other scans (Post/Cancel/Search/etc) will be much slower than normal."] = "强烈推荐你在运行快速扫描后重载界面(输入'/reload')，否则任何其他的扫描（上架/下架/搜索/等）都较平时要慢。" -- Needs review
L["Last Scanned"] = "最后一次扫描" -- Needs review
-- L["Last updated from in-game scan %s ago."] = ""
-- L["Last updated from the TSM Application %s ago."] = ""
L["Market Value"] = "市场价" -- Needs review
-- L["Market Value:"] = ""
-- L["Market Value x%s:"] = ""
-- L["Min Buyout:"] = ""
-- L["Min Buyout x%s:"] = ""
L["Minimum Buyout"] = "最低一口价" -- Needs review
L["Next Page"] = "下一页" -- Needs review
L["No items found"] = "未找到物品" -- Needs review
-- L["No scans found."] = ""
L["Not Ready"] = "还未就绪" -- Needs review
-- L["Not Scanned"] = ""
-- L["Num(Yours)"] = ""
L["Options"] = "选项" -- Needs review
L["Previous Page"] = "上一页" -- Needs review
-- L["Processing data..."] = ""
L["Ready"] = "准备完毕" -- Needs review
L["Ready in %s min and %s sec"] = "在%s分钟%s秒內完成" -- Needs review
L["Refreshes the current search results."] = "刷新当前搜索结果." -- Needs review
L["Removed %s from AuctionDB."] = "以从AuctionDB中移除%s。" -- Needs review
L["Reset Data"] = "重置数据" -- Needs review
L["Resets AuctionDB's scan data"] = "重置AuctionDB扫描数据" -- Needs review
-- L["Result Order:"] = ""
L["Run Full Scan"] = "运行完整扫描" -- Needs review
L["Run GetAll Scan"] = "进行快速扫描" -- Needs review
-- L["Running query..."] = ""
L["%s ago"] = "%s 之前" -- Needs review
-- L["Scanning page %s/%s"] = ""
-- L["Scanning the auction house in game is no longer necessary!"] = ""
L["Search"] = "搜索" -- Needs review
L["Search Options"] = "搜索选项" -- Needs review
-- L["Seen Last Scan:"] = ""
L["Select how you would like the search results to be sorted. After changing this option, you may need to refresh your search results by hitting the \"Refresh\" button."] = "将搜索结果按你的要求排序.改变该选项后,你可能需要点击\"刷新\"按钮来刷新搜索结果." -- Needs review
-- L["Select whether to sort search results in ascending or descending order."] = ""
L["Shift-Right-Click to clear all data for this item from AuctionDB."] = "Shift-右键点击从AuctionDB中清除此项的所有数据" -- Needs review
L["Sort items by"] = "排序物品按" -- Needs review
L["This determines how many items are shown per page in results area of the \"Search\" tab of the AuctionDB page in the main TSM window. You may enter a number between 5 and 500 inclusive. If the page lags, you may want to decrease this number."] = "这个数字决定TSM主窗口中AuctionDB页面的\"搜索\"标签的搜索结果区域每页显示多少项目.你可以输入一个5到500之间的数字.如果页面加载缓慢，可以尝试减小这个数字。" -- Needs review
-- L["Total Seen Count:"] = ""
L["Use the search box and category filters above to search the AuctionDB data."] = "使用搜索框和过滤器来搜索AuctionDB数据." -- Needs review
L["You can filter the results by item subtype by using this dropdown. For example, if you want to search for all herbs, you would select \"Trade Goods\" in the item type dropdown and \"Herbs\" in this dropdown."] = "你可以用这个下拉菜单来按物品子类型过滤搜索结果.例如,如果你想搜索所有的草药,你需要物品类型下拉菜单中选择\"商品\",并在物品子类型下拉菜单中选择\"草药\"." -- Needs review
L["You can filter the results by item type by using this dropdown. For example, if you want to search for all herbs, you would select \"Trade Goods\" in this dropdown and \"Herbs\" as the subtype filter."] = "你可以用这个下拉菜单来按物品类型过滤搜索结果.例如,如果你想搜索所有的草药,你需要物品类型下拉菜单中选择\"商品\",并在物品子类型下拉菜单中选择\"草药\"." -- Needs review
L["You can use this page to lookup an item or group of items in the AuctionDB database. Note that this does not perform a live search of the AH."] = "你可以使用这个页面来查看AuctionDB数据库中的物品或者物品组.请注意,这并不是在拍卖行的实时搜索." -- Needs review
 
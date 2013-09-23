-- ------------------------------------------------------------------------------ --
--                            TradeSkillMaster_Shopping                           --
--            http://www.curse.com/addons/wow/tradeskillmaster_shopping           --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- TradeSkillMaster_Shopping Locale - deDE
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkillMaster_Shopping/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster_Shopping", "deDE")
if not L then return end

-- L["Action"] = ""
-- L["Added '%s' to your favorite searches."] = ""
-- L["Bid Percent"] = ""
-- L["Buyout"] = ""
--[==[ L[ [=[Click to search for an item.
Shift-Click to post at market value.]=] ] = "" ]==]
-- L["Custom Filter"] = ""
-- L["Default Post Undercut Amount"] = ""
-- L["Destroy Mode"] = ""
-- L["Done Scanning"] = ""
-- L["Enter what you want to search for in this box. You can also use the following options for more complicated searches."] = ""
-- L["Error creating operation. Operation with name '%s' already exists."] = ""
-- L["Even (5/10/15/20) Stacks Only"] = ""
-- L["Favorite Searches"] = ""
-- L["General"] = ""
-- L["General Operation Options"] = ""
L["General Options"] = "Allgemeine Einstellungen"
-- L["General Settings"] = ""
-- L["Give the new operation a name. A descriptive name will help you find this operation later."] = ""
-- L["Hide Grouped Items"] = ""
-- L["If checked, auctions above the max price will be shown."] = ""
-- L["If checked, only auctions posted in even quantities will be considered for purchasing."] = ""
-- L["If set, only items which are usable by your character will be included in the results."] = ""
-- L["If set, only items which exactly match the search filter you have set will be included in the results."] = ""
-- L["Import"] = ""
-- L["Import Favorite Search"] = ""
-- L["Inline Filters:|r You can easily add common search filters to your search such as rarity, level, and item type. For example '%sarmor/leather/epic/85/i350/i377|r' will search for all leather armor of epic quality that requires level 85 and has an ilvl between 350 and 377 inclusive. Also, '%sinferno ruby/exact|r' will display only raw inferno rubys (none of the cuts)."] = ""
-- L["Invalid custom price source for %s. %s"] = ""
-- L["Invalid destroy search: '%s'"] = ""
-- L["Invalid destroy target: '%s'"] = ""
-- L["Invalid Even Only Filter"] = ""
-- L["Invalid Exact Only Filter"] = ""
-- L["Invalid Filter"] = ""
-- L["Invalid Item Level"] = ""
-- L["Invalid Item Rarity"] = ""
-- L["Invalid Item SubType"] = ""
-- L["Invalid Item Type"] = ""
-- L["Invalid Max Quantity"] = ""
-- L["Invalid Min Level"] = ""
-- L["Invalid target item for destroy search: '%s'"] = ""
-- L["Invalid Usable Only Filter"] = ""
-- L["Item"] = ""
-- L["Item Class"] = ""
-- L["Item Level Range:"] = ""
-- L["Item SubClass"] = ""
-- L["Left-Click to run this search."] = ""
-- L["Log"] = ""
L["% Market Value"] = "% Marktwert"
-- L["Market Value Price Source"] = ""
-- L["Maximum Auction Price (per item)"] = ""
-- L["Maximum quantity purchased for destroy search."] = ""
-- L["Maximum quantity purchased for %s."] = ""
-- L["Maximum Quantity to Buy:"] = ""
L["% Max Price"] = "% Marktpreis"
-- L["Minimum Rarity"] = ""
-- L["Multiple Search Terms:|r You can search for multiple things at once by simply separated them with a ';'. For example '%selementium ore; obsidium ore|r' will search for both elementium and obsidium ore."] = ""
-- L["New Operation"] = ""
-- L["No recent AuctionDB scan data found."] = ""
-- L["Normal Mode"] = ""
-- L["Normal Post Price"] = ""
-- L["Num"] = ""
-- L["Operation Name"] = ""
-- L["Operations"] = ""
L["Options"] = "Einstellungen"
-- L["Other"] = ""
-- L["Paste the search you'd like to import into the box below."] = ""
-- L["Posted a %s with a buyuot of %s."] = ""
-- L["Preparing Filter %d / %d"] = ""
-- L["Preparing filters..."] = ""
-- L["Press Ctrl-C to copy this saved search."] = ""
-- L["Price"] = ""
-- L["Quick Posting"] = ""
-- L["Quick Posting Duration"] = ""
-- L["Quick Posting Price"] = ""
-- L["Recent Searches"] = ""
-- L["Relationships"] = ""
-- L["Removed '%s' from your favorite searches."] = ""
-- L["Removed '%s' from your recent searches."] = ""
-- L["Required Level Range:"] = ""
-- L["Reset Filters"] = ""
-- L["Right-Click to favorite this recent search."] = ""
-- L["Right-Click to remove from favorite searches."] = ""
-- L["Saved Searches"] = ""
-- L["Scanning %d / %d (Page %d / %d)"] = ""
-- L["Search Filter:"] = ""
-- L["Select the groups which you would like to include in the search."] = ""
-- L["'%s' has a Shopping operation of '%s' which no longer exists. Shopping will ignore this group until this is fixed."] = ""
-- L["Shift-Left-Click to export this search."] = ""
-- L["Shift-Right-Click to remove this recent search."] = ""
-- L["Shopping for auctions including those above the max price."] = ""
-- L["Shopping for auctions with a max price set."] = ""
-- L["Shopping for even stacks including those above the max price"] = ""
-- L["Shopping for even stacks with a max price set."] = ""
-- L["Shopping operations contain settings items which you regularly buy from the auction house."] = ""
-- L["Show Auctions Above Max Price"] = ""
-- L["Sidebar Pages:"] = ""
-- L["Skipped the following search term because it's invalid."] = ""
-- L["Skipped the following search term because it's too long. Blizzard does not allow search terms over 63 characters."] = ""
-- L["Start Search"] = ""
-- L["Start Vendor Search"] = ""
-- L["Stop"] = ""
-- L["% Target Value"] = ""
-- L["The duration at which items will be posted via the 'Quick Posting' frame."] = ""
-- L["The highest price per item you will pay for items in affected by this operation."] = ""
-- L["The vendor search looks for items on the AH below their vendor sell price."] = ""
-- L["This is how Shopping calculates the '% Market Value' column in the search results."] = ""
-- L["This is the default price Shopping will suggest to post items at when there's no others posted."] = ""
-- L["This is the percentage of your buyout price that your bid will be set to when posting auctions with Shopping."] = ""
-- L["This price is used to determine what items will be posted at through the 'Quick Posting' frame."] = ""
-- L["TSM Groups"] = ""
-- L["Unknown Filter"] = ""
-- L["Unknown milling search target: '%s'"] = ""
-- L["% Vendor Price"] = ""
-- L["Vendor Search Profit: %s"] = ""
-- L["What to set the default undercut to when posting items with Shopping."] = ""
L["When in destroy mode, you simply enter a target item (ink/pigment, enchanting mat, gem, etc) into the search box to search for everything you can destroy to get that item."] = "Im Zerstörenmodus, gibst du einfach einen Zielgegenstand (Tinte/Pigment, Verzaubermaterial, Edelstein, etc) in das Suchfeld ein um alle Gegenstände zu erhalten, die bei Zerstörung den Zielgegenstand enthalten." -- Needs review
L["When in normal mode, you may run simple and filtered searches of the auction house."] = "Im Normalmodus, kannst du einfache oder gefilterte Suchen des Auktionshauses durchführen." -- Needs review

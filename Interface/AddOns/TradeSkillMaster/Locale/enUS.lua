-- ------------------------------------------------------------------------------ --
--                                TradeSkillMaster                                --
--                http://www.curse.com/addons/wow/tradeskill-master               --
--                                                                                --
--             A TradeSkillMaster Addon (http://tradeskillmaster.com)             --
--    All Rights Reserved* - Detailed license information included with addon.    --
-- ------------------------------------------------------------------------------ --

-- TradeSkillMaster Locale - enUS
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkill-Master/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster", "enUS", true)
if not L then return end

L["% Market Value"] = true
L["%s is a valid custom price but %s is an invalid item."] = true
L["%s is a valid custom price but did not give a value for %s."] = true
L["%s is not a valid custom price and gave the following error: %s"] = true
L["%s operation(s):"] = true
L["%sDrag%s to move this button"] = true
L["%sLeft-Click%s to open the main window"] = true
L["%sLeft-Click|r to select / deselect this group."] = true
L["%sRight-Click|r to collapse / expand this group."] = true
L["/tsm help|r - Shows this help listing"] = true
L["/tsm|r - opens the main TSM window."] = true
L["<<< Remove"] = true
L["<No Operation>"] = true
L["<No Relationship>"] = true
L["<Remove Operation>"] = true
L["A custom price of %s for %s evaluates to %s."] = true
L["A group is a collection of items which will be treated in a similar way by TSM's modules."] = true
L["A maximum of 1 convert() function is allowed."] = true
L["A maximum of 1 gold amount is allowed."] = true
L["A simple, fixed gold amount."] = true
L["Add >>>"] = true
L["Add Additional Operation"] = true
L["Additional error suppressed"] = true
L["Advanced Option Text"] = true
L["All items with names containing the specified filter will be selected. This makes it easier to add/remove multiple items at a time."] = true
L["Allows for testing of custom prices."] = true
L["Allows you to build a queue of crafts that will produce a profitable, see what materials you need to obtain, and actually craft the items."] = true
L["Allows you to quickly and easily empty your mailbox as well as automatically send items to other characters with the single click of a button."] = true
L["Allows you to use data from http://wowuction.com in other TSM modules and view its various price points in your item tooltips."] = true
L["Alt-Click to immediately buyout this auction."] = true
L["Any subgroups of this group will also be deleted, with all items being returned to the parent of this group or removed completely if this group has no parent."] = true
L["Appearance Data"] = true
L["Application and Addon Developer:"] = true
L["Applied %s to %s."] = true
L["Apply Operation to Group"] = true
L["Are you sure you want to delete the selected profile?"] = true
L["Auction Buyout: %s"] = true
L["Auction Buyout:"] = true
L["Auction Frame Scale"] = true
L["Auction House Tab Settings"] = true
L["Auction not found. Skipped."] = true
L["Auctionator - Auction Value"] = true
L["Auctioneer - Appraiser"] = true
L["Auctioneer - Market Value"] = true
L["Auctioneer - Minimum Buyout"] = true
L["Auctions"] = true
L["Author(s):"] = true
L["BankUI"] = true
L["Below are various ways you can set the value of the current editbox. Any combination of these methods is also supported."] = true
L["Below are your currently available price sources. The %skey|r is what you would type into a custom price box."] = true
L["Below is a list of groups which this operation is currently applied to. Clicking on the 'Remove' button next to the group name will remove the operation from that group."] = true
L["Below, set the custom price that will be evaluated for this custom price source."] = true
L["Border Thickness (Requires Reload)"] = true
L["Buy from Vendor"] = true
L["Canceling Auction: %d/%d"] = true
L["Cancelled - Bags and bank are full"] = true
L["Cancelled - Bags and guildbank are full"] = true
L["Cancelled - Bags are full"] = true
L["Cancelled - Bank is full"] = true
L["Cancelled - Guildbank is full"] = true
L["Cancelled - You must be at a bank or guildbank"] = true
L["Cannot delete currently active profile!"] = true
L["Category Text (Requires Reload)"] = true
L["Category Text 2 (Requires Reload)"] = true
L["Changes how many rows are shown in the auction results tables."] = true
L["Changes the size of the auction frame. The size of the detached TSM auction frame will always be the same as the main auction frame."] = true
L["Character Name on Other Account"] = true
L["Chat Tab"] = true
L["Check out our completely free, desktop application which has tons of features including deal notification emails, automatic updating of AuctionDB and WoWuction prices, automatic TSM setting backup, and more! You can find this app by going to %s."] = true
L["Check this box to override this group's operation(s) for this module."] = true
L["Clear Selection"] = true
L["Clear"] = true
L["Click the button below to open the export frame for this group."] = true
L["Click this button to completely remove this operation from the specified group."] = true
L["Click this button to configure the currently selected operation."] = true
L["Click this button to create a new operation for this module."] = true
L["Click this button to show a frame for easily exporting the list of items which are in this group."] = true
L["Co-Founder:"] = true
L["Coins:"] = true
L["Content - Backdrop"] = true
L["Content - Border"] = true
L["Content Text - Disabled"] = true
L["Content Text - Enabled"] = true
L["Copy From"] = true
L["Copy the settings from one existing profile into the currently active profile."] = true
L["Create %s Operation"] = true
L["Create New Subgroup"] = true
L["Create a new empty profile."] = true
L["Creating a relationship for this setting will cause the setting for this operation to be equal to the equivalent setting of another operation."] = true
L["Crystals"] = true
L["Current Profile:"] = true
L["Custom Price for this Source"] = true
L["Custom Price Source"] = true
L["Custom Price Source Name"] = true
L["Custom Price Sources"] = true
L["Custom price sources allow you to create more advanced custom prices throughout all of the TSM modules. Just as you can use the built-in price sources such as 'vendorsell' and 'vendorbuy' in your custom prices, you can use ones you make here (which themselves are custom prices)."] = true
L["Default BankUI Tab"] = true
L["Default Group Tab"] = true
L["Default Tab (Open Auction House to Enable)"] = true
L["Default Tab"] = true
L["Default"] = true
L["Delete Custom Price Source"] = true
L["Delete Group"] = true
L["Delete Operation"] = true
L["Delete a Profile"] = true
L["Delete existing and unused profiles from the database to save space, and cleanup the SavedVariables file."] = true
L["Description:"] = true
L["Deselect All Groups"] = true
L["Deselects all items in both columns."] = true
L["Disenchant Value x%s:"] = true
L["Disenchant Value"] = true
L["Disenchant Value:"] = true
L["Disenchant source:"] = true
L["Display Group / Operation Info in Tooltips"] = true
L["Display disenchant value in tooltip."] = true
L["Display prices in tooltips as:"] = true
L["Display vendor buy price in tooltip."] = true
L["Display vendor sell price in tooltip."] = true
L["Done"] = true
L["Double-click to collapse this item and show only the cheapest auction."] = true
L["Double-click to expand this item and show all the auctions."] = true
L["Duplicate Operation"] = true
L["Duration:"] = true
L["Dust"] = true
L["Empty price string."] = true
L["Error Info:"] = true
L["Error creating custom price source. Custom price source with name '%s' already exists."] = true
L["Error creating group. Group with name '%s' already exists."] = true
L["Error creating subgroup. Subgroup with name '%s' already exists."] = true
L["Error duplicating operation. Operation with name '%s' already exists."] = true
L["Error moving group. Group '%s' already exists."] = true
L["Error renaming custom price source. Custom price source with name '%s' already exists."] = true
L["Error renaming group. Group with name '%s' already exists."] = true
L["Error renaming operation. Operation with name '%s' already exists."] = true
L["Essences"] = true
L["Examples"] = true
L["Existing Profiles"] = true
L["Export Appearance Settings"] = true
L["Export Group Items"] = true
L["Export Items in Group"] = true
L["Export Operation"] = true
L["Failed to parse gold amount."] = true
L["First, log into a character on the same realm (and faction) on both accounts. Type the name of the OTHER character you are logged into in the box below. Once you have done this on both accounts, TSM will do the rest automatically. Once setup, syncing will automatically happen between the two accounts while on any character on the account (not only the one you entered during this setup)."] = true
L["Fixed Gold Value"] = true
L["Forget Characters:"] = true
L["Frame Background - Backdrop"] = true
L["Frame Background - Border"] = true
L["General Options"] = true
L["General Settings"] = true
L["Give the group a new name. A descriptive name will help you find this group later."] = true
L["Give the new group a name. A descriptive name will help you find this group later."] = true
L["Give this operation a new name. A descriptive name will help you find this operation later."] = true
L["Give your new custom price source a name. This is what you will type in to custom prices and is case insensitive (everything will be saved as lower case)."] = true
L["Goblineer (by Sterling - The Consortium)"] = true
L["Group Item Data"] = true
L["Group Item Data"] = true
L["Group Items:"] = true
L["Group Name"] = true
L["Group names cannot contain %s characters."] = true
L["Group(Base Item):"] = true
L["Group:"] = true
L["Groups"] = true
L["Help / Options"] = true
L["Help"] = true
L["Here you can setup relationships between the settings of this operation and other operations for this module. For example, if you have a relationship set to OperationA for the stack size setting below, this operation's stack size setting will always be equal to OperationA's stack size setting."] = true
L["Hide Minimap Icon"] = true
L["I'll Go There Now!"] = true
L["Icon Region"] = true
L["If checked, all tables listing auctions will display the bid as well as the buyout of the auctions. This will not take effect immediately and may require a reload."] = true
L["If checked, any items you import that are already in a group will be moved out of their current group and into this group. Otherwise, they will simply be ignored."] = true
L["If checked, only items which are in the parent group of this group will be imported."] = true
L["If checked, operations will be stored globally rather than by profile. TSM groups are always stored by profile. Note that if you have multiple profiles setup already with separate operation information, changing this will cause all but the current profile's operations to be lost."] = true
L["If checked, the disenchant value of the item will be shown. This value is calculated using the average market value of materials the item will disenchant into."] = true
L["If checked, the price of buying the item from a vendor is displayed."] = true
L["If checked, the price of selling the item to a vendor displayed."] = true
L["If checked, the structure of the subgroups will be included in the export. Otherwise, the items in this group (and all subgroups) will be exported as a flat list."] = true
L["If checked, ungrouped items will be displayed in the left list of selection lists used to add items to subgroups. This allows you to add an ungrouped item directly to a subgroup rather than having to add to the parent group(s) first."] = true
L["If checked, your bags will be automatically opened when you open the auction house."] = true
L["If you delete, rename, or transfer a character off the current faction/realm, you should remove it from TSM's list of characters using this dropdown."] = true
L["If you have multiple profile set up with operations, enabling this will cause all but the current profile's operations to be irreversibly lost. Are you sure you want to continue?"] = true
L["Ignore Operation on Characters:"] = true
L["Ignore Operation on Faction-Realms:"] = true
L["Ignore Random Enchants on Ungrouped Items"] = true
L["Import Appearance Settings"] = true
L["Import Items"] = true
L["Import Operation Settings"] = true
L["Import Preset TSM Theme"] = true
L["Import String"] = true
L["Import/Export"] = true
L["Include Subgroup Structure in Export"] = true
L["Installed Modules"] = true
L["Invalid appearance data."] = true
L["Invalid custom price for undercut amount. Using 1c instead."] = true
L["Invalid custom price."] = true
L["Invalid filter."] = true
L["Invalid function."] = true
L["Invalid import string."] = true
L["Invalid item link."] = true
L["Invalid operator at end of custom price."] = true
L["Invalid parameter to price source."] = true
L["Invalid parent argument type. Expected table, got %s."] = true
L["Invalid price source in convert."] = true
L["Invalid word: '%s'"] = true
L["Item Buyout: %s"] = true
L["Item Level"] = true
L["Item Tooltip Text"] = true
L["Item links may only be used as parameters to price sources."] = true
L["Item not found in bags. Skipping"] = true
L["Item"] = true
L["Items"] = true
L["Jaded (by Ravanys - The Consortium)"] = true
L["Just incase you didn't read this the first time:"] = true
L["Keep Items in Parent Group"] = true
L["Keeps track of all your sales and purchases from the auction house allowing you to easily track your income and expenditures and make sure you're turning a profit."] = true
L["Label Text - Disabled"] = true
L["Label Text - Enabled"] = true
L["Lead Developer and Co-Founder:"] = true
L["Light (by Ravanys - The Consortium)"] = true
L["Link Text (Requires Reload)"] = true
L["Link Text 2 (Requires Reload)"] = true
L["Load Saved Theme"] = true
L["Looks like TradeSkillMaster has encountered an error. Please help the author fix this error by copying the entire error below and following the instructions for reporting bugs listed here (unless told elsewhere by the author):"] = true
L["Looks like TradeSkillMaster has encountered an error. Please help the author fix this error by following the instructions shown."] = true
L["Loop detected in the following custom price:"] = true
L["Make Auction Frame Movable"] = true
L["Management"] = true
L["Manages your inventory by allowing you to easily move stuff between your bags, bank, and guild bank."] = true
L["Medium Text Size (Requires Reload)"] = true
L["Mills, prospects, and disenchants items at super speed!"] = true
L["Misplaced comma"] = true
L["Module Information:"] = true
L["Module Operations / Options"] = true
L["Modules"] = true
L["Module:"] = true
L["More Advanced Methods"] = true
L["More advanced options are now designated by %sred text|r. Beginners are encourages to come back to these once they have a solid understanding of the basics."] = true
L["Move Already Grouped Items"] = true
L["Move Group"] = true
L["Move to Top Level"] = true
L["Moved %s to %s."] = true
L["Multi-Account Settings"] = true
L["New Custom Price Source"] = true
L["New Group Name"] = true
L["New Group"] = true
L["New Parent Group"] = true
L["New Subgroup Name"] = true
L["New"] = true
L["No modules are currently loaded.  Enable or download some for full functionality!"] = true
L["None of your groups have %s operations assigned. Type '/tsm' and click on the 'TradeSkillMaster Groups' button to assign operations to your TSM groups."] = true
L["Normal Text Size (Requires Reload)"] = true
L["Number of Auction Result Rows (Requires Reload)"] = true
L["Only Import Items from Parent Group"] = true
L["Open All Bags with Auction House"] = true
L["Operation #%d"] = true
L["Operation Management"] = true
L["Operations"] = true
L["Operations: %s"] = true
L["Options"] = true
L["Override Module Operations"] = true
L["Parent Group Items:"] = true
L["Parent/Ungrouped Items:"] = true
L["Past Contributors:"] = true
L["Paste the exported items into this box and hit enter or press the 'Okay' button. The recommended format for the list of items is a comma separated list of itemIDs for general items. For battle pets, the entire battlepet string should be used. For randomly enchanted items, the format is <itemID>:<randomEnchant> (ex: 38472:-29)."] = true
L["Paste the exported operation settings into this box and hit enter or press the 'Okay' button. Imported settings will irreversibly replace existing settings for this operation."] = true
L["Paste the list of items into the box below and hit enter or click on the 'Okay' button.\n\nYou can also paste an itemLink into the box below to add a specific item to this group."] = true
L["Per Item:"] = true
L["Percent of Price Source"] = true
L["Performs scans of the auction house and calculates the market value of items as well as the minimum buyout. This information can be shown in items' tooltips as well as used by other modules."] = true
L["Post"] = true
L["Posts and cancels your auctions to / from the auction house according to pre-set rules. Also, this module can show you markets which are ripe for being reset for a profit."] = true
L["Price Per Item"] = true
L["Price Per Stack"] = true
L["Price Per Target Item"] = true
L["Prints out the available price sources for use in custom price boxes."] = true
L["Prints out the version numbers of all installed modules"] = true
L["Profiles"] = true
L["Profiles"] = true
L["Provides extra functionality that doesn't fit well in other modules."] = true
L["Provides interfaces for efficiently searching for items on the auction house. When an item is found, it can easily be bought, canceled (if it's yours), or even posted from your bags."] = true
L["Purchasing Auction: %d/%d"] = true
L["Region - Backdrop"] = true
L["Region - Border"] = true
L["Remove"] = true
L["Removed '%s' as a custom price source. Be sure to update any custom prices that were using this source."] = true
L["Rename Custom Price Source"] = true
L["Rename Group"] = true
L["Rename Operation"] = true
L["Replace"] = true
L["Reset Profile"] = true
L["Reset the current profile back to its default values, in case your configuration is broken, or you simply want to start over."] = true
L["Resets the position, scale, and size of all applicable TSM and module frames."] = true
L["Resources:"] = true
L["Restore Default Colors"] = true
L["Restores all the color settings below to their default values."] = true
L["Save Theme"] = true
L["Saved theme: %s."] = true
L["Searching for item..."] = true
L["See instructions above this editbox."] = true
L["Select All Groups"] = true
L["Select a %s operation using the dropdown above."] = true
L["Select a group from the list below and click 'OK' at the bottom."] = true
L["Select a theme from this dropdown to import one of the preset TSM themes."] = true
L["Select a theme from this dropdown to import one of your saved TSM themes."] = true
L["Select an operation to apply to this group."] = true
L["Select the price source for calculating disenchant value."] = true
L["Sell to Vendor"] = true
L["Seller"] = true
L["Set All Relationships to Target"] = true
L["Sets all relationship dropdowns below to the operation selected."] = true
L["Settings"] = true
L["Settings"] = true
L["Setup account sync'ing with the account which '%s' is on."] = true
L["Shards"] = true
L["Sources"] = true
L["Show Bids in Auction Results Table (Requires Reload)"] = true
L["Show Ungrouped Items for Adding to Subgroups"] = true
L["Skipping auction which no longer exists."] = true
L["Slash Commands:"] = true
L["Small Text Size (Requires Reload)"] = true
L["Stack Size"] = true
L["Status / Credits"] = true
L["Store Operations Globally"] = true
L["Subgroup Items:"] = true
L["Subgroups contain a subset of the items in their parent groups and can be used to further refine how different items are treated by TSM's modules."] = true
L["Successfully imported %d items to %s."] = true
L["Successfully imported operation settings."] = true
L["Switch to New Custom Price Source After Creation"] = true
L["Switch to New Group After Creation"] = true
L["TSM Appearance Options"] = true
L["TSM Classic (by Jim Younkin - Power Word: Gold)"] = true
L["TSM Info / Help"] = true
L["TSM Status / Options"] = true
L["TSM Version Info:"] = true
L["TSMDeck (by Jim Younkin - Power Word: Gold)"] = true
L["TUJ GE - Market Average"] = true
L["TUJ GE - Market Median"] = true
L["TUJ RE - Market Price"] = true
L["TUJ RE - Mean"] = true
L["Target Operation"] = true
L["Target Operation"] = true
L["Testers (Special Thanks):"] = true
L["Text:"] = true
L["The Functional Gold Maker (by Xsinthis - The Golden Crusade)"] = true
L["The default tab shown in the 'BankUI' frame."] = true
L["The name can ONLY contain letters. No spaces, numbers, or special characters."] = true
L["Theme Name"] = true
L["Theme name is empty."] = true
L["There are no visible banks."] = true
L["There is only one price level and seller for this item."] = true
L["This allows you to export your appearance settings to share with others."] = true
L["This allows you to import appearance settings which other people have exported."] = true
L["This dropdown determines the default tab when you visit a group."] = true
L["This group already has operations. Would you like to add another one or replace the last one?"] = true
L["This group already has the max number of operation. Would you like to replace the last one?"] = true
L["This operation will be ignored when you're on any character which is checked in this dropdown."] = true
L["This option sets which tab TSM and its modules will use for printing chat messages."] = true
L["Time Left"] = true
L["Title"] = true
L["Toggles the bankui"] = true
L["Tooltip Options"] = true
L["Tracks and manages your inventory across multiple characters including your bags, bank, and guild bank."] = true
L["TradeSkillMaster Error Window"] = true
L["TradeSkillMaster Info:"] = true
L["TradeSkillMaster Team"] = true
L["Type '/tsm sources' to print out all available price sources."] = true
L["Type in the name of a new operation you wish to create with the same settings as this operation."] = true
L["Unbalanced parentheses."] = true
L["Ungrouped Items:"] = true
L["Ungrouped Items:"] = true
L["Usage: /tsm price <ItemLink> <Price String>"] = true
L["Use the button below to delete this group. Any subgroups of this group will also be deleted, with all items being returned to the parent of this group or removed completely if this group has no parent."] = true
L["Use the editbox below to give this group a new name."] = true
L["Use the group box below to move this group and all subgroups of this group. Moving a group will cause all items in the group (and its subgroups) to be removed from its current parent group and added to the new parent group."] = true
L["Use the options below to change and tweak the appearance of TSM."] = true
L["Use the tabs above to select the module for which you'd like to configure operations and general options."] = true
L["Use the tabs above to select the module for which you'd like to configure tooltip options."] = true
L["Using our website you can get help with TSM, suggest features, and give feedback."] = true
L["Various modules can sync their data between multiple accounts automatically whenever you're logged into both accounts."] = true
L["Vendor Buy Price x%s:"] = true
L["Vendor Buy Price:"] = true
L["Vendor Sell Price x%s:"] = true
L["Vendor Sell Price:"] = true
L["Version:"] = true
L["View Operation Options"] = true
L["Visit %s for information about the different TradeSkillMaster modules as well as download links."] = true
L["Web Master and Addon Developer:"] = true
L["When checked, random enchants will be ignored for ungrouped items.\n\nNB: This will not affect parent group items that were already added with random enchants\n\nIf you have this checked when adding an ungrouped randomly enchanted item, it will act as all possible random enchants of that item."] = true
L["When clicked, makes this group a top-level group with no parent."] = true
L["Would you like to add this new operation to %s?"] = true
L["Wrong number of item links."] = true
L["You appear to be attempting to import an operation from a different module."] = true
L["You can change the active database profile, so you can have different settings for every character."] = true
L["You can either create a new profile by entering a name in the editbox, or choose one of the already exisiting profiles."] = true
L["You can hold shift while clicking this button to remove the items from ALL groups rather than keeping them in the parent group (if one exists)."] = true
L["You cannot create a profile with an empty name."] = true
L["You cannot use %s as part of this custom price."] = true
L["You currently don't have any groups setup. Type '/tsm' and click on the 'TradeSkillMaster Groups' button to setup TSM groups."] = true
L["You have closed the bankui. Use '/tsm bankui' to view again."] = true
L["max %d"] = true
L["stacks of"] = true
L["|cffffff00Important Note:|r You do not currently have any modules installed / enabled for TradeSkillMaster! |cff77ccffYou must download modules for TradeSkillMaster to have some useful functionality!|r\n\nPlease visit http://www.curse.com/addons/wow/tradeskill-master and check the project description for links to download modules."] = true
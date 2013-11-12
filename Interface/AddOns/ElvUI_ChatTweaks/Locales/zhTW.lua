-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Lockslap (US, Bleeding Hollow)
-------------------------------------------------------------------------------
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI_ChatTweaks", "zhTW", false)
if not L then return end

L["Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN."] = "Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN." -- Requires localization
L["Abbreviations"] = "Abbreviations" -- Requires localization
L["About"] = "\233\151\156\230\150\188" -- Needs review
L["achieve"] = true
L["Achievement Filter"] = "\230\136\144\229\176\177\233\129\142\230\191\190" -- Needs review
L["Achievement Messages"] = "\230\136\144\229\176\177\232\168\138\230\129\175" -- Needs review
L["  Achievement Points\
"] = "  \230\136\144\229\176\177\233\187\158\230\149\184\
"
L["Action to take when an icon is found."] = "Action to take when an icon is found." -- Requires localization
L["Active Modules"] = "Active Modules" -- Requires localization
L["Add an |cff00ff00/emotes|r command to see what custom emotes you currently have running."] = "\230\150\176\229\162\158\228\184\128\229\128\139 |cff00ff00/emotes|r \230\140\135\228\187\164\228\190\134\231\156\139\231\156\139\228\189\160\231\143\190\229\156\168\230\173\163\229\156\168\228\189\191\231\148\168\231\154\132\232\161\168\230\131\133."
L["Add |cff00ff00/emotes|r Command"] = "\230\150\176\229\162\158 |cff00ff00/emotes|r \230\140\135\228\187\164"
L["Add custom emotes.  Please remember that your character's name will always be the first word.\
\
|cff00ff00%t|r is your current target."] = true
L["Added log entry from %s%s|r to %s%s|r log."] = "Added log entry from %s%s|r to %s%s|r log." -- Requires localization
L["Add Group Trigger"] = "\230\150\176\229\162\158\231\181\132\233\154\138\233\151\156\233\141\181\229\173\151"
L["Add Guild Trigger"] = "\230\150\176\229\162\158\229\133\172\230\156\131\233\151\156\233\141\181\229\173\151"
L["Add item icons to loot received messages."] = "\229\156\168\230\136\176\229\136\169\229\147\129\232\168\138\230\129\175\229\137\141\229\162\158\229\138\160\231\137\169\229\147\129\229\156\150\231\164\186."
L["Addon Messages"] = "Addon Messages" -- Requires localization
L["Addon Version Sent, Version: |cffffff00%s|r"] = "\230\143\146\228\187\182\231\137\136\230\156\172\233\128\129\229\135\186, \231\137\136\230\156\172: |cffffff00%s|r"
L["Add Percentage"] = "Add Percentage" -- Requires localization
L["Adds a minimap button.\
\
|cffffff00To disable the button, simply disable this module.|r"] = "Adds a minimap button.\
\
|cffffff00To disable the button, simply disable this module.|r" -- Requires localization
L["Adds an ElvUI datatext for this addon."] = "Adds an ElvUI datatext for this addon." -- Requires localization
L["Adds a timestamp to each line of text."] = "\230\175\143\232\161\140\229\162\158\229\138\160\230\153\130\233\150\147\230\136\179\232\168\152\227\128\130"
L["Adds chat commands |cff1784d1/chatframes|r and |cff1784d1/cf|r to help you identify the chat frames and their numbers."] = "\230\150\176\229\162\158\229\176\141\232\169\177\230\140\135\228\187\164 |cff1784d1/chatframes|r \229\146\140 |cff1784d1/cf|r \228\190\134\229\185\171\229\138\169\228\189\160\232\190\168\229\136\165\229\176\141\232\169\177\232\166\150\231\170\151\232\153\159\231\162\188."
L["Adds chat commands to clear the chat windows.\
\
"] = "\230\150\176\229\162\158\230\184\133\233\153\164\229\176\141\232\169\177\232\166\150\231\170\151\231\154\132\229\176\141\232\169\177\230\140\135\228\187\164\227\128\130\
\
"
L["Adds item links to Auction House messages.  Enabling this module will automatically disable the Auction Message Filter module.\
\
|cffff0000If you do not have the item in your bags at the time of the system message firing then this will not be able to get the item link.  This is a limitation of the|r |cffffff00GetItemInfo()|r |cffff0000API function.  If this occurs, then the module will simple pass through the default message.|r"] = "\230\150\176\229\162\158\231\137\169\229\147\129\233\128\163\231\181\144\232\135\179\230\139\141\232\179\163\229\160\180\232\168\138\230\129\175.  \229\149\159\229\139\149\230\173\164\230\168\161\231\181\132\230\156\131\232\135\170\229\139\149\229\129\156\231\148\168\230\139\141\232\179\163\232\168\138\230\129\175\233\129\142\230\191\190\230\168\161\231\181\132.\
\
|cffff0000\229\129\135\228\189\191\232\168\138\230\129\175\232\167\184\231\153\188\230\153\130\228\189\160\231\154\132\232\131\140\229\140\133\229\133\167\230\178\146\230\156\137\232\169\178\231\137\169\229\147\129\239\188\140\229\137\135\231\132\161\230\179\149\231\148\162\231\148\159\231\137\169\229\147\129\233\128\163\231\181\144.  \233\128\153\230\152\175|r |cffffff00GetItemInfo()|r |cffff0000API \231\154\132\233\153\144\229\136\182.  \229\129\135\229\166\130\233\128\153\231\139\128\230\179\129\231\153\188\231\148\159\239\188\140\230\173\164\230\168\161\231\181\132\230\156\131\231\155\180\230\142\165\233\161\175\231\164\186\229\142\159\230\156\172\231\154\132\232\168\138\230\129\175.|r"
L["Adds tell target slash command, |cff00ff00/tt|r."] = "\230\150\176\229\162\158\229\175\134\232\170\158\231\155\174\230\168\153\229\176\141\232\177\161\230\140\135\228\187\164, |cff00ff00/tt|r."
L["Adds the |cff00ff96/find|r and |cff00ff96/findall|r commands to search the chat history.\
\
Usage:\
    |cff00ff96/find <text>|r\
    |cff00ff96/findall <text>|r"] = "Adds the |cff00ff96/find|r and |cff00ff96/findall|r commands to search the chat history.\
\
Usage:\
    |cff00ff96/find <text>|r\
    |cff00ff96/findall <text>|r" -- Requires localization
L["Adds the |cff00ff96/role|r command for initiating a role poll in raids."] = "Adds the |cff00ff96/role|r command for initiating a role poll in raids." -- Requires localization
L["Adds the chat commands |cff00ff96/zonelist|r, |cff00ff96/pets|r and |cff00ff96/mounts|r to provide information about your mounts and pets."] = "Adds the chat commands |cff00ff96/zonelist|r, |cff00ff96/pets|r and |cff00ff96/mounts|r to provide information about your mounts and pets." -- Requires localization
L["Add surrounding brackets to own charname in messages."] = "\229\156\168\228\189\160\230\147\129\230\156\137\231\154\132\232\167\146\232\137\178\229\144\141\231\168\177\229\138\160\228\184\138\230\139\172\229\188\167."
L["Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it."] = "Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it." -- Requires localization
L["Add the player's alts to the tooltip."] = "Add the player's alts to the tooltip." -- Requires localization
L["Add the player's main to the tooltip."] = "Add the player's main to the tooltip." -- Requires localization
L["Add word to your group invite trigger list"] = "\230\150\176\229\162\158\233\151\156\233\141\181\229\173\151\229\136\176\232\135\170\229\139\149\231\181\132\233\154\138\230\184\133\229\150\174"
L["Add word to your guild invite trigger list."] = "\230\150\176\229\162\158\233\151\156\233\141\181\229\173\151\229\136\176\232\135\170\229\139\149\233\130\128\232\171\139\229\133\172\230\156\131\230\184\133\229\150\174."
L["AFK"] = "\230\154\171\233\155\162" -- Needs review
L["AFK/DND Filter"] = "\230\154\171\233\155\162/\229\139\191\230\147\190 \233\129\142\230\191\190" -- Needs review
L["AFK Messages"] = "\230\154\171\233\155\162\232\168\138\230\129\175"
L["After"] = "\228\185\139\229\190\140" -- Needs review
L["Alchemy"] = "\231\133\137\233\135\145\232\161\147" -- Needs review
L["All"] = true
L["All Modules"] = "All Modules" -- Requires localization
L["Allow Mobile Users"] = "Allow Mobile Users" -- Requires localization
L["Allow someone to request a link of all your professions."] = "\229\133\129\232\168\177\229\133\182\228\187\150\228\186\186\232\166\129\230\177\130\228\189\160\230\137\128\230\156\137\228\186\164\230\152\147\230\138\128\232\131\189\231\154\132\233\128\163\231\181\144."
L["Allows you to block chat channel invites and ignore the person who sent them.  Useful for preventing spam."] = "Allows you to block chat channel invites and ignore the person who sent them.  Useful for preventing spam." -- Requires localization
L["Allows you to change the default font settings for the chat frames.\
\
|cffff0000Using another addon to do this will break this functionality.|r"] = "\229\133\129\232\168\177\228\189\160\230\155\180\230\148\185\233\160\144\232\168\173\229\176\141\232\169\177\232\166\150\231\170\151\229\173\151\229\158\139.\
\
|cffff0000\229\166\130\230\158\156\228\189\191\231\148\168\229\133\182\228\187\150\231\155\184\229\144\140\229\138\159\232\131\189\230\143\146\228\187\182\230\156\131\231\160\180\229\163\158\230\173\164\229\138\159\232\131\189.|r"
L["Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command."] = "Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command." -- Requires localization
L["Allows you to color the pet battle info messages, and determine which chat frame to send them to.\
\
I am aware that some of the features of this module don't really pertain to the chat, but I couldn't really justify an entirely new addon.  So I just snuck them into here."] = "\228\184\138\232\137\178\229\175\181\231\137\169\230\136\176\233\172\165\232\179\135\232\168\138\239\188\140\228\184\166\230\177\186\229\174\154\232\166\129\233\161\175\231\164\186\229\156\168\229\147\170\229\128\139\229\176\141\232\169\177\232\166\150\231\170\151.\
\
\230\136\145\231\159\165\233\129\147\233\128\153\230\168\161\231\181\132\231\154\132\228\184\128\228\186\155\229\138\159\232\131\189\232\183\159\229\176\141\232\169\177\231\132\161\233\151\156, \228\189\134\230\152\175\230\136\145\231\156\159\231\154\132\231\132\161\230\179\149\232\173\137\230\152\142\228\187\150\230\152\175\228\184\128\229\128\139\230\150\176\231\154\132\230\143\146\228\187\182.  \230\137\128\228\187\165\230\136\145\229\129\183\229\129\183\231\154\132\230\138\138\229\174\131\230\148\190\229\156\168\233\128\153."
L["Allows you to reroute auction house messages to a different chat frame."] = "\229\133\129\232\168\177\228\189\160\229\176\135\230\139\141\232\179\163\229\160\180\232\168\138\230\129\175\233\135\141\229\153\181\229\136\176\229\136\165\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151."
L["Allows you to spam a message to General or Trade chat every X seconds.  Useful for guild recruitment or profession links."] = "\229\133\129\232\168\177\228\189\160\229\156\168\228\186\164\230\152\147\233\160\187\233\129\147\230\175\143X\231\167\146\233\135\141\232\164\135\231\153\188\233\128\129\232\168\138\230\129\175. \229\143\175\228\187\165\228\189\191\231\148\168\229\156\168\229\133\172\230\156\131\230\139\155\229\139\159\230\136\150\229\135\186\229\148\174\232\178\168\231\137\169."
L["Allows you to use some fun filters on various chat channels.\
\
|cffff0000This will break any links in the chat message.|r\
\
|cffffff00Filters:|r\
13375p34|<, ALL UPPERCASE, all lowercase, Capitalize Words, AlTeRnAtInG CaPs, BeTTeR ALTeRNaTiNG CaPS, sretteL esreveR, Gr\195\160v\195\168 L\195\168tt\195\168rs, \195\129c\195\186t\195\169 L\195\169tt\195\169rs, \195\144\195\175\195\164r\195\171s\195\175s L\195\171tt\195\171rs, C\195\174rc\195\187mfl\195\170x L\195\170tt\195\170rs"] = "Allows you to use some fun filters on various chat channels.\
\
|cffff0000This will break any links in the chat message.|r\
\
|cffffff00Filters:|r\
13375p34|<, ALL UPPERCASE, all lowercase, Capitalize Words, AlTeRnAtInG CaPs, BeTTeR ALTeRNaTiNG CaPS, sretteL esreveR, Gr\195\160v\195\168 L\195\168tt\195\168rs, \195\129c\195\186t\195\169 L\195\169tt\195\169rs, \195\144\195\175\195\164r\195\171s\195\175s L\195\171tt\195\171rs, C\195\174rc\195\187mfl\195\170x L\195\170tt\195\170rs" -- Requires localization
L["Allow users of the WoW's mobile app to whisper you."] = "Allow users of the WoW's mobile app to whisper you." -- Requires localization
L["All spam logs were cleared."] = "All spam logs were cleared." -- Requires localization
L["alt2"] = "\229\136\134\232\186\1712" -- Needs review
L["alt3"] = "\229\136\134\232\186\1713" -- Needs review
L["Alt-click name to invite"] = "ALT+\229\183\166\233\141\181\233\187\158\233\129\184\229\167\147\229\144\141\233\130\128\232\171\139"
L["Alternate"] = "\228\186\164\230\155\191"
L["ALTERNATE"] = "ALTERNATE" -- Requires localization
L["Alternate command to kick someone from guild."] = "\228\184\128\229\128\139\230\155\191\228\187\163\231\154\132\230\140\135\228\187\164\228\190\134\229\176\135\230\159\144\228\186\186\232\184\162\229\135\186\229\133\172\230\156\131."
L["AlTeRnAtInG CaPs"] = "AlTeRnAtInG CaPs" -- Requires localization
L["Alt Names"] = "\229\136\134\232\186\171\229\167\147\229\144\141" -- Needs review
L["Alt note fallback"] = "\229\136\134\232\186\171\232\168\187\232\168\152\229\155\158\233\165\139"
L["and"] = "and" -- Requires localization
L["ap"] = true
L["Are you sure you want to delete all your saved class/level data?"] = "\228\189\160\231\162\186\229\174\154\228\189\160\232\166\129\229\136\170\233\153\164\230\137\128\230\156\137\228\189\160\231\180\128\233\140\132\231\154\132 \232\129\183\230\165\173/\231\173\137\231\180\154 \232\179\135\230\150\153?" -- Needs review
L["Are you sure you want to disable all of the modules?"] = "Are you sure you want to disable all of the modules?" -- Requires localization
L["Are you sure you want to enable all of the modules?"] = "Are you sure you want to enable all of the modules?" -- Requires localization
L["Are you sure you want to reset the chat fonts to defaults?"] = "\228\189\160\231\162\186\229\174\154\228\189\160\232\166\129\233\135\141\231\189\174\229\176\141\232\169\177\229\173\151\229\158\139\231\130\186\233\160\144\232\168\173\229\128\188?"
L["A simple calculator used to perform basic operations on gold values.  Providing no parameters will show you how much gold you have.\
\
You can include your current gold amount by using the |cff00ff00mymoney|r keyword.  For example |cff00ff00mymoney * 2|r.\
\
|cffff0000Money amounts can only be added or subtracted, multiplication or division can only be performed with money and a number.  For example:  4g * 4 is okay, where 4g * 4g is invalid."] = "\228\184\128\229\128\139\231\176\161\229\150\174\231\154\132\232\168\136\231\174\151\230\169\159\228\190\134\233\128\178\232\161\140\231\176\161\229\150\174\231\154\132\233\135\145\233\140\162\232\168\136\231\174\151. \229\166\130\230\158\156\230\178\146\230\156\137\230\143\144\233\151\156\229\143\131\230\149\184\230\153\130\230\156\131\233\161\175\231\164\186\228\189\160\230\137\128\230\147\129\230\156\137\231\154\132\233\135\145\233\140\162\
\
\228\189\160\229\143\175\228\187\165\228\189\191\231\148\168 |cff00ff00mymoney|r \233\151\156\233\141\181\229\173\151\228\190\134\229\143\150\229\190\151\228\189\160\231\155\174\229\137\141\231\154\132\233\135\145\233\140\162\230\149\184\233\135\143.  \232\136\137\228\190\139 |cff00ff00mymoney * 2|r.\
\
|cffff0000\229\140\133\229\144\171\229\150\174\228\189\141\231\154\132\230\149\184\233\135\143\229\143\170\232\131\189\229\129\154\229\138\160\230\179\149\229\146\140\230\184\155\230\179\149, \228\185\152\230\179\149\229\146\140\233\153\164\230\179\149\229\143\170\232\131\189\228\189\191\231\148\168\229\156\168\233\135\145\233\140\162\232\136\135\228\184\128\229\128\139\230\149\184\229\173\151\231\154\132\231\174\151\229\188\143.  \232\136\137\228\190\139:  4g * 4 \230\152\175\229\143\175\228\187\165\231\148\168\231\154\132, \228\189\134\230\152\175 4g * 4g \230\152\175\228\184\141\229\144\136\230\179\149\231\154\132."
L["A simple command-line calculator.  Certain keywords, listed below, can be used and their in game value will be substituted.  You can also assign variables which are saved for later use.\
\
|cffffff00Keywords:|r\
"] = "\228\184\128\229\128\139\231\176\161\229\150\174\231\154\132\229\176\141\232\169\177\229\188\143\232\168\136\231\174\151\230\169\159.  \229\186\149\228\184\139\230\137\128\229\136\151\231\154\132\233\151\156\233\141\181\229\173\151, \229\143\175\228\187\165\232\162\171\228\189\191\231\148\168\228\184\166\228\184\148\230\156\131\230\155\191\230\143\155\230\136\144\229\133\182\229\156\168\233\129\138\230\136\178\228\184\173\231\154\132\230\149\184\229\128\188.  \228\189\160\228\185\159\229\143\175\228\187\165\230\140\135\229\174\154\232\174\138\230\149\184\228\184\166\229\173\152\232\181\183\228\190\134\228\187\165\228\190\155\228\187\165\229\190\140\228\189\191\231\148\168.\
\
|cffffff00\233\151\156\233\141\181\229\173\151:|r\
"
L["A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears."] = "A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears." -- Requires localization
L["A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r."] = "A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r." -- Requires localization
L["As I see it, yes."] = "As I see it, yes." -- Requires localization
L["Ask again later."] = "Ask again later." -- Requires localization
L["A Test of Valor"] = "A Test of Valor" -- Requires localization
L["Auction Created"] = "Auction Created" -- Requires localization
L["Auction Expired"] = "\230\139\141\232\179\163\229\147\129\233\129\142\230\156\159" -- Needs review
L["Auction Message Filtering"] = "\230\139\141\232\179\163\232\168\138\230\129\175\233\129\142\230\191\190" -- Needs review
L["Auction Message Types"] = "\230\139\141\232\179\163\232\168\138\230\129\175\231\168\174\233\161\158"
L["Auction Outbid"] = "\230\139\141\232\179\163\229\147\129\230\144\182\230\168\153"
L["Auction Removed"] = "\230\139\141\232\179\163\229\147\129\231\167\187\233\153\164" -- Needs review
L["Auction Sold"] = "\230\139\141\232\179\163\229\147\129\229\148\174\229\135\186" -- Needs review
L["Auction Won"] = "\232\180\143\229\190\151\230\139\141\232\179\163\229\147\129" -- Needs review
L["Auto Congratulate"] = "\232\135\170\229\139\149\230\129\173\232\179\128" -- Needs review
L["Auto Ding"] = "\232\135\170\229\139\149 Ding"
L["Auto Farewell"] = "\232\135\170\229\139\149\233\129\147\229\136\165" -- Needs review
L["Automatically bid someone farewell when they leave your guild."] = "\231\149\182\230\159\144\228\186\186\233\155\162\233\150\139\229\133\172\230\156\131\230\153\130\232\135\170\229\139\149\233\129\147\229\136\165."
L["Automatically congratulate someone when they, or others, complete an achievement."] = "\231\149\182\229\133\182\228\187\150\228\186\186\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\232\135\170\229\139\149\230\129\173\232\179\128."
L["Automatically congratulates someone when they say \"ding\" in chat."] = "\231\149\182\230\159\144\228\186\186\229\156\168\229\176\141\232\169\177\228\184\173\232\170\170 \"ding\" \230\153\130\232\135\170\229\139\149\229\155\158\230\135\137."
L["Automatically decline any channel invites."] = "Automatically decline any channel invites." -- Requires localization
L["Automatically enables chat logging."] = "\232\135\170\229\139\149\229\149\159\231\148\168\229\176\141\232\169\177\231\180\128\233\140\132"
L["Automatically enable tracking of pets for battles."] = "Automatically enable tracking of pets for battles." -- Requires localization
L["Automatically enable tracking of Stable Masters to help you revive and/or heal your pets."] = "Automatically enable tracking of Stable Masters to help you revive and/or heal your pets." -- Requires localization
L["Automatically link someone the profession they requested via various keywords."] = "\232\135\170\229\139\149\230\160\185\230\147\154\233\151\156\233\141\181\229\173\151\230\143\144\228\190\155\230\159\144\228\186\186\228\187\150\229\128\145\232\166\129\230\177\130\231\154\132\228\186\164\230\152\147\230\138\128\232\131\189\233\128\163\231\181\144."
L["Automatically Remove Item When Finished"] = "\231\149\182\231\137\169\229\147\129\229\174\140\230\136\144\230\153\130\232\135\170\229\139\149\231\167\187\233\153\164"
L["Automatically welcomes someone to your guild."] = "\231\149\182\230\156\137\228\186\186\229\138\160\229\133\165\229\133\172\230\156\131\230\153\130\232\135\170\229\139\149\230\173\161\232\191\142."
L["Automatic Chat Logging"] = "\232\135\170\229\139\149\228\191\157\229\173\152\229\176\141\232\169\177\232\168\152\233\140\132"
L["Auto Profession Link"] = "\232\135\170\229\139\149\230\143\144\228\190\155\228\186\164\230\152\147\230\138\128\232\131\189" -- Needs review
L["Auto Set Role"] = "Auto Set Role" -- Requires localization
L["Auto Welcome"] = "\232\135\170\229\139\149\230\173\161\232\191\142" -- Needs review
L["Available Chat Command Arguments"] = "\229\143\175\231\148\168\231\154\132\229\176\141\232\169\177\230\140\135\228\187\164\229\143\131\230\149\184"
L["Available parameters are |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r."] = "\229\143\175\231\148\168\231\154\132\229\143\131\230\149\184\229\140\133\230\139\172 |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r."
L["Battle.Net Convo"] = "Battle.Net Convo" -- Requires localization
L["Battle.net invite from %s%s|r blocked!"] = "Battle.net invite from %s%s|r blocked!" -- Requires localization
L["Battle.Net Options"] = "Battle.Net \233\129\184\233\160\133" -- Needs review
L["Battle.net Spam"] = "Battle.net Spam" -- Requires localization
L["Battle.Net Whisper"] = "Battle.Net Whisper" -- Requires localization
L["Before"] = "\228\185\139\229\137\141" -- Needs review
L["Below are the keywords that the module will look for to substitute with the values described below."] = "Below are the keywords that the module will look for to substitute with the values described below." -- Requires localization
L["BeTTeR ALTeRNaTiNG CaPS"] = "BeTTeR ALTeRNaTiNG CaPS" -- Requires localization
L["Better not tell you now."] = "Better not tell you now." -- Requires localization
L["Bid Accepted"] = "\229\135\186\229\131\185\230\142\165\229\143\151"
L["Blacksmithing"] = "\233\141\155\233\128\160" -- Needs review
L["Blocked Whisper from %s"] = "Blocked Whisper from %s" -- Requires localization
L["Blocks Battle.net friend requests from spammers."] = "Blocks Battle.net friend requests from spammers." -- Requires localization
L["Build: |cff1784d1%s|r"] = "\231\181\132\229\187\186: |cff1784d1%s|r"
L["Build Date: |cff1784d1%s|r"] = "\231\181\132\229\187\186\230\151\165\230\156\159: |cff1784d1%s|r"
L["Busy"] = "\229\191\153\231\162\140" -- Needs review
L["Calculator"] = "\232\168\136\231\174\151\230\169\159"
L["Cannot predict now."] = "Cannot predict now." -- Requires localization
L["Can't set value '%s', doesn't look like a number."] = "\231\132\161\230\179\149\232\168\173\229\174\154\230\149\184\229\128\188 '%s', \231\156\139\232\181\183\228\190\134\228\184\141\229\131\143\230\152\175\229\128\139\230\149\184\229\173\151."
L["Capitalize Words"] = "Capitalize Words" -- Requires localization
L["Capture Delay"] = "Capture Delay" -- Requires localization
L["Center"] = "\231\189\174\228\184\173" -- Needs review
L["   |cff00ff00/ct %s|r or |cff00ff00%s|r - %s"] = "   |cff00ff00/ct %s|r \230\136\150 |cff00ff00%s|r - %s"
L["   |cff00ff00/ct %s|r - %s"] = true
L["|cff00ff00%d|r Custom %s Being Used"] = "|cff00ff00%d|r Custom %s Being Used" -- Requires localization
L["|cff00ff00Enabled|r"] = "|cff00ff00\229\183\178\229\149\159\231\148\168|r"
L["|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r"] = "|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r" -- Requires localization
L["|cff00ff00%s|r"] = true
L["|cff00ff00%s|r or |cff00ff00%s|r %s"] = "|cff00ff00%s|r \230\136\150 |cff00ff00%s|r %s" -- Needs review
L["   |cff00ff00%s|r or |cff00ff00%s|r - %s"] = "   |cff00ff00%s|r \230\136\150 |cff00ff00%s|r - %s"
L["   |cff00ff00%s|r - %s"] = true
L["|cFF5cb4f8Pet Battle - Tale of the Tape|r"] = "|cFF5cb4f8Pet Battle - Tale of the Tape|r" -- Requires localization
L["|cffc7c7cfs|r"] = true
L["|cFFccff00Not Owned|r"] = "|cFFccff00\229\176\154\230\156\170\230\147\129\230\156\137|r"
L["|cffeda55fc|r"] = true
L["|cfffe2ec8|Hectfilter:%s:%d:%d:%s|h[Report Spam Message!]|h|r"] = "|cfffe2ec8|Hectfilter:%s:%d:%d:%s|h[Report Spam Message!]|h|r" -- Requires localization
L["|cffff0000Disabled|r"] = "|cffff0000\229\183\178\229\129\156\231\148\168|r"
L["|cffff0000ERROR|r Both messages must be set in order to use the spam method |cffffff00%s|r"] = "|cffff0000ERROR|r \229\133\169\232\128\133\232\179\135\232\168\138\231\154\134\233\160\136\232\162\171\232\168\173\229\174\154\228\187\165\228\189\191\231\148\168 spam \230\150\185\230\179\149 |cffffff00%s|r"
L["|cffff0000Item|r |cffffffff\"%s\"|r |cffff0000does not exist.|r"] = "|cffff0000\231\137\169\229\147\129|r |cffffffff\"%s\"|r |cffff0000\228\184\141\229\173\152\229\156\168.|r"
L["|cffff0000No modules found.|r"] = "|cffff0000\230\137\190\228\184\141\229\136\176\230\168\161\231\181\132.|r"
L["\
\
|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level."] = "\
\
|cffff0000\230\143\144\231\164\186:|r  \229\166\130\230\158\156\230\173\164UI\233\150\139\229\167\139\228\189\191\231\148\168\229\164\167\233\135\143\231\154\132\232\168\152\230\134\182\233\171\148, \229\143\170\232\166\129\233\135\141\231\189\174\229\144\141\231\168\177\232\179\135\230\150\153\229\141\179\230\156\131\229\155\158\229\190\169."
L["\
\
|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.\
\
Addon Usage: |cff00ff00%s|r"] = "\
\
|cffff0000\230\143\144\231\164\186:|r  \229\166\130\230\158\156\230\173\164UI\233\150\139\229\167\139\228\189\191\231\148\168\229\164\167\233\135\143\231\154\132\232\168\152\230\134\182\233\171\148, \229\143\170\232\166\129\233\135\141\231\189\174\229\144\141\231\168\177\232\179\135\230\150\153\229\141\179\230\156\131\229\155\158\229\190\169.\
\
\230\143\146\228\187\182\228\189\191\231\148\168\230\150\185\230\179\149: |cff00ff00%s|r"
L["|cffff0000The Chat Frame you chose to output reputation changes,|r |cffffffff%s|r|cffff0000, does not exist."] = "|cffff0000\228\189\160\233\129\184\230\147\135\233\161\175\231\164\186\232\129\178\230\156\155\232\174\138\229\140\150\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151,|r |cffffffff%s|r|cffff0000, \228\184\141\229\173\152\229\156\168."
L[" |cFFff5a00(Upgrade)|r"] = " |cFFff5a00(\229\141\135\231\180\154)|r"
L["|cffff9000Not in Pet Journal|r"] = "|cffff9000\228\184\141\229\156\168\229\175\181\231\137\169\230\151\165\232\170\140\228\184\173|r"
L["|cffff9000Pet Journal:|r %s"] = "|cffff9000\229\175\181\231\137\169\230\151\165\232\170\140:|r %s"
L["|cffffc080Alts:|r %s"] = "|cffffc080Alts:|r %s" -- Requires localization
L["|cffffd700g|r"] = true
L["|cffffff00Character already in a guild."] = "|cffffff00\232\167\146\232\137\178\229\183\178\229\156\168\228\184\128\229\128\139\229\133\172\230\156\131\228\184\173."
L["|cffffff00Character already in your guild."] = "|cffffff00\232\167\146\232\137\178\229\183\178\229\156\168\228\189\160\231\154\132\229\133\172\230\156\131."
L[" |cffffff00%d|r Total Modules (|cff00ff00%d|r Enabled, |cffff0000%d|r Disabled)"] = "\231\184\189\229\133\177 |cffffff00%d|r \229\128\139\230\168\161\231\181\132 (|cff00ff00%d|r \229\183\178\229\149\159\231\148\168, |cffff0000%d|r \229\183\178\229\129\156\231\148\168)"
L["|cffffff00One of your addons is breaking critical chat data I need to work properly :(|r"] = "|cffffff00\228\189\160\231\154\132\228\184\128\229\128\139\230\143\146\228\187\182\230\144\141\229\163\158\228\186\134\230\136\145\230\173\163\231\162\186\233\129\139\228\189\156\230\137\128\233\156\128\231\154\132\232\179\135\230\150\153:(|r"
L["|cffffff00This abbreviation is unknown."] = "|cffffff00This abbreviation is unknown." -- Requires localization
L["|cffffff00Unable to execute secure command.|r |cffffffff%s|r"] = "|cffffff00\231\132\161\230\179\149\229\159\183\232\161\140\229\174\137\229\133\168\230\140\135\228\187\164.|r |cffffffff%s|r"
L["|cffffff00Usage: /ccolor <class>|r"] = "|cffffff00Usage: /ccolor <class>|r" -- Requires localization
L["|cffffff00Usage: /ginvite <name>|r"] = "|cffffff00Usage: /ginvite <\229\144\141\229\173\151>|r"
L["|cffffff00Usage: /gkick <name>|r"] = "|cffffff00\231\148\168\230\179\149: /gkick <\229\144\141\229\173\151>|r" -- Needs review
L["|cffffff00Usage: /hextorgb <hex code>|r"] = "|cffffff00Usage: /hextorgb <hex code>|r" -- Requires localization
L["|cffffff00Usage: /in <delay> <command>|r"] = "|cffffff00Usage: /in <\229\187\182\233\129\178> <\230\140\135\228\187\164>|r"
L["|cffffff00Usage: /rgbtohex <red> <green> <blue>|r"] = "|cffffff00Usage: /rgbtohex <red> <green> <blue>|r" -- Requires localization
L["|cffffff00Usage: /rpt <times> <command>|r"] = "|cffffff00Usage: /rpt <\230\172\161\230\149\184> <\230\140\135\228\187\164>|r"
L["|cffffffffYou have %s.|r"] = "|cffffffff\228\189\160\230\156\137 %s.|r"
L["|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"] = "|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s" -- Requires localization
L["Changed Channel"] = "\232\174\138\230\155\180\233\160\187\233\129\147"
L["Channel"] = "\233\160\187\233\129\147"
L["Channel Colors"] = "\233\160\187\233\129\147\233\161\143\232\137\178" -- Needs review
L["Channel %d"] = "\233\160\187\233\129\147 %d"
L["Channel Invite Spam"] = "Channel Invite Spam" -- Requires localization
L["Channel Notice Filter"] = "\233\160\187\233\129\147\230\143\144\233\134\146\233\129\142\230\191\190"
L["Channels"] = "\233\160\187\233\129\147"
L["Channel Sounds"] = "\233\160\187\233\129\147\233\159\179\230\149\136" -- Needs review
L["Channel Spam"] = "\233\160\187\233\129\147\231\129\140\230\176\180"
L["Channel Spam has been |cff%s%s|r."] = "\233\160\187\233\129\147\231\129\140\230\176\180 |cff%s%s|r."
L["Channel Spam is already running."] = "\233\160\187\233\129\147\231\129\140\230\176\180\229\183\178\229\156\168\233\129\139\232\161\140."
L["Channels to Filter"] = "Channels to Filter" -- Requires localization
L["Channels to look for questions."] = "Channels to look for questions." -- Requires localization
L["Channels to Monitor"] = "\231\155\163\232\166\150\233\160\187\233\129\147"
L["Channels to Watch"] = "Channels to Watch" -- Requires localization
L["Channel to output the messages to."] = "\232\188\184\229\135\186\232\168\138\230\129\175\232\135\179\233\160\187\233\129\147."
L["Channel to send the reminder to."] = "Channel to send the reminder to." -- Requires localization
L["Character to use between the name and level"] = "\229\144\141\231\168\177\232\136\135\231\173\137\231\180\154\233\150\147\233\154\148\229\173\151\229\133\131"
L["Character to use for the left bracket"] = "\229\183\166\230\139\172\229\188\167\229\173\151\229\133\131"
L["Character to use for the right bracket"] = "\229\143\179\230\139\172\229\188\167\229\173\151\229\133\131"
L["Chat"] = "\229\176\141\232\169\177"
L["Chat Events"] = "Chat Events" -- Requires localization
L["Chat Fonts"] = "\229\176\141\232\169\177\229\173\151\229\158\139"
L["Chat Frame"] = "\229\176\141\232\169\177\232\166\150\231\170\151"
L["Chat Frame "] = "\229\176\141\232\169\177\232\166\150\231\170\151 "
L["Chat Frame %d"] = "\229\176\141\232\169\177\232\166\150\231\170\151 %d"
L["ChatFrame %d"] = "\229\176\141\232\169\177\232\166\150\231\170\151%d"
L["Chat Frame Settings"] = "\229\176\141\232\169\177\232\166\150\231\170\151\232\168\173\229\174\154"
L["Chat Frames To Watch"] = "Chat Frames To Watch" -- Requires localization
L["Chat frame to output the messages.  Default is ChatFrame3, which is the default output frame for reputation messages in ElvUI."] = "\232\188\184\229\135\186\232\168\138\230\129\175\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151.  \233\160\144\232\168\173\231\130\186 \229\176\141\232\169\177\232\166\150\231\170\1513, \230\152\175 ElvUI \233\160\144\232\168\173\231\154\132\232\129\178\230\156\155\232\168\138\230\129\175\232\188\184\229\135\186\232\166\150\231\170\151."
L["Chat frame to output the message to.  Default is |cffffff00ChatFrame3|r, which is the default frame for ElvUI XP messages."] = "\232\188\184\229\135\186\232\168\138\230\129\175\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151.  \233\160\144\232\168\173\231\130\186 |cffffff00\229\176\141\232\169\177\232\166\150\231\170\1513|r, \230\152\175 ElvUI \233\160\144\232\168\173\231\154\132\232\129\178\230\156\155\232\168\138\230\129\175\232\188\184\229\135\186\232\166\150\231\170\151."
L["Chat frame to route the auction house messages to."] = "\233\135\141\229\176\142\230\139\141\232\179\163\229\160\180\232\168\138\230\129\175\231\154\132\229\176\141\232\169\177\232\166\150\231\170\151."
L["Chat frame to route the messages to."] = "\233\135\141\229\176\142\232\168\138\230\129\175\232\163\189\229\176\141\232\169\177\232\166\150\231\170\151."
L["Chat frame to send the list to."] = "Chat frame to send the list to." -- Requires localization
L["Chat frame to send the messages to."] = "\231\153\188\233\128\129\232\168\138\230\129\175\232\163\189\229\176\141\232\169\177\232\166\150\231\170\151."
L["Chat message with icons"] = "\229\162\158\229\138\160\229\156\150\231\164\186\232\135\179\229\176\141\232\169\177\232\168\138\230\129\175"
L["Chats To Monitor"] = true
L["Chat Tabs"] = "Chat Tabs" -- Requires localization
L["Chat Tweaks"] = "Chat Tweaks" -- Requires localization
L["Cheats Color"] = "\228\189\156\229\188\138\233\161\143\232\137\178"
L["Choose the filter to use."] = "Choose the filter to use." -- Requires localization
L["Choose which chat frames display timestamps"] = "\233\129\184\230\147\135\229\147\170\228\184\128\229\128\139\232\129\138\229\164\169\232\166\150\231\170\151\233\161\175\231\164\186\230\153\130\233\150\147\230\136\179\232\168\152"
L["Class"] = "\232\129\183\230\165\173" -- Needs review
L["Clear all chat windows."] = "\230\184\133\233\153\164\230\137\128\230\156\137\229\176\141\232\169\177\232\166\150\231\170\151."
L["Clear All Logs"] = "Clear All Logs" -- Requires localization
L["Clear Chat Commands"] = "\230\184\133\233\153\164\229\176\141\232\169\177\230\140\135\228\187\164"
L["Clear current chat."] = "\230\184\133\233\153\164\231\155\174\229\137\141\229\176\141\232\169\177\232\168\138\230\129\175"
L["Cleared log of %s%s|r module."] = "Cleared log of %s%s|r module." -- Requires localization
L["Clear Log"] = "Clear Log" -- Requires localization
L["Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window."] = "Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window." -- Requires localization
L["Click to reset the materials you're tracking."] = "\233\187\158\233\129\184\228\187\165\233\135\141\231\189\174\228\189\160\230\137\128\232\191\189\232\185\164\231\154\132\232\179\135\230\186\144."
L["Click to send the reminder to the select channel that the Magic 8-Ball is listening."] = "Click to send the reminder to the select channel that the Magic 8-Ball is listening." -- Requires localization
L["Click to toggle ElvUI's config window.  This will also close this window."] = "Click to toggle ElvUI's config window.  This will also close this window." -- Requires localization
L["Client Locale: |cff1784d1%s|r"] = "\229\174\162\230\136\182\231\171\175\232\170\158\232\168\128: |cff1784d1%s|r"
L["Coin Size"] = "Coin Size" -- Requires localization
L["Color"] = "\233\161\143\232\137\178" -- Needs review
L["Color a roll game loss, aka when you roll a one (1)."] = "Color a roll game loss, aka when you roll a one (1)." -- Requires localization
L["Color a roll game win, aka when someone else rolls a one (1)."] = "Color a roll game win, aka when someone else rolls a one (1)." -- Requires localization
L["Color by Channel"] = "Color by Channel" -- Requires localization
L["Color Cheats"] = "\228\184\138\232\137\178\228\189\156\229\188\138"
L["Colorize"] = true
L["Color Level"] = "Color Level" -- Requires localization
L["Color Loss"] = "\228\184\138\232\137\178\229\164\177\230\149\151"
L["Color Name"] = "\228\184\138\232\137\178\229\144\141\231\168\177"
L["Color of other's rolls."] = "\228\187\150\228\186\186\230\147\178\233\170\176\233\161\143\232\137\178."
L["Color of the base reputation messages."] = "\232\129\178\230\156\155\232\168\138\230\129\175\229\159\186\231\164\142\233\161\143\232\137\178."
L["Color of the faction."] = "\233\153\163\231\135\159\231\154\132\233\161\143\232\137\178."
L["Color of the output message."] = "\232\188\184\229\135\186\232\168\138\230\129\175\231\154\132\233\161\143\232\137\178."
L["Color of the reputation needed/left."] = "\232\129\178\230\156\155 \230\137\128\233\156\128/\229\137\169\233\164\152 \233\161\143\232\137\178."
L["Color of the standing (honored, revered, etc.)."] = "\233\154\142\230\174\181\233\161\143\232\137\178 (\229\176\138\230\149\172, \229\180\135\230\149\172, \231\173\137\231\173\137.)."
L["Color own charname in messages."] = "\229\156\168\232\168\138\230\129\175\228\184\173\231\130\186\232\135\170\229\183\177\229\144\141\229\173\151\228\184\138\232\137\178"
L["Color Player Names By..."] = "\228\184\138\232\137\178\232\167\146\232\137\178\229\144\141\231\168\177\228\190\157\230\147\154..." -- Needs review
L["Color regular rolls by others."] = "\228\184\138\232\137\178\229\133\182\228\187\150\228\186\186\231\154\132\230\173\163\229\184\184\230\147\178\233\170\176."
L["Color Rolls"] = "\230\147\178\233\170\176\228\184\138\232\137\178" -- Needs review
L["Color rolls differently to make tracking the roll game easier on the eyes."] = "\229\176\135\230\147\178\233\170\176\232\168\138\230\129\175\229\161\151\228\184\138\228\184\141\229\144\140\231\154\132\233\161\143\232\137\178\228\187\165\228\190\191\232\167\128\229\175\159."
L["Color rolls that do not start at 1."] = "\228\184\138\232\137\178\228\184\141\230\152\175\229\190\1581\233\150\139\229\167\139\231\154\132\230\147\178\233\170\176."
L["Color self in messages"] = "\229\156\168\232\168\138\230\129\175\228\184\173\228\184\138\232\137\178\232\135\170\229\183\177"
L["Color the messages by the channel the message came from."] = "Color the messages by the channel the message came from." -- Requires localization
L["Color the name of the pets during a pet battle relative to their rarity.  If you have the pet you're currently battling it will also add the quality of the pet you have in your journal."] = "\229\156\168\229\175\181\231\137\169\230\136\176\233\172\165\228\184\173\228\190\157\231\133\167\229\147\129\232\179\170\228\184\138\232\137\178\228\187\150\229\128\145\231\154\132\229\144\141\231\168\177.  \229\166\130\230\158\156\228\189\160\229\183\178\231\182\147\230\147\129\230\156\137\232\169\178\229\175\181\231\137\169\228\185\159\230\156\131\233\161\175\231\164\186\228\189\160\229\183\178\231\182\147\230\147\129\230\156\137\231\154\132\229\147\129\232\179\170."
L["Color timestamps the same as the channel they appear in."] = "\229\176\135\230\153\130\233\150\147\230\136\179\232\168\152\228\190\157\232\169\178\233\160\187\233\129\147\233\161\143\232\137\178\228\184\138\232\137\178."
L["Color to change the filtered message to.\
\
|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r."] = "Color to change the filtered message to.\
\
|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r." -- Requires localization
L["Color to designate a cheating roll."] = "\228\189\156\229\188\138\233\161\143\232\137\178."
L["Color to designate a roll game loss."] = "\232\188\184\230\142\137\230\147\178\233\170\176\233\161\143\232\137\178."
L["Color to designate a roll game win."] = "\232\180\143\229\190\151\230\147\178\233\170\176\233\161\143\232\137\178."
L["Color to use for your rolls."] = "\228\189\160\231\154\132\230\147\178\233\170\176\233\161\143\232\137\178."
L["Color Win"] = "\228\184\138\232\137\178\229\139\157\229\136\169"
L["Color Your Rolls"] = "\228\184\138\232\137\178\228\189\160\231\154\132\230\147\178\233\170\176"
L["Color your rolls to set them apart."] = "\229\176\135\228\189\160\231\154\132\230\147\178\233\170\176\228\184\138\232\137\178\228\187\165\229\146\140\229\133\182\228\187\150\228\186\186\229\141\128\229\136\165."
L["Combined"] = "\231\181\144\229\144\136"
L["Command Help"] = "Command Help" -- Requires localization
L["Companions"] = "Companions" -- Requires localization
L["Compress"] = "\229\163\147\231\184\174" -- Needs review
L["Concentrate and ask again."] = "Concentrate and ask again." -- Requires localization
L["Congratulate achievements earned by guildmates."] = "\229\133\172\230\156\131\230\136\144\229\147\161\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\230\129\173\232\179\128."
L["Congratulate achievements earned by people in your party."] = "\233\154\138\228\188\141\230\136\144\229\147\161\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\230\129\173\232\179\128."
L["Congratulate achievements earned by people in your raid."] = "\229\156\152\233\154\138\230\136\144\229\147\161\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\230\129\173\232\179\128."
L["Congratulate achievements earned by people near you."] = "\233\153\132\232\191\145\231\154\132\228\186\186\229\143\150\229\190\151\230\136\144\229\176\177\230\153\130\230\129\173\232\179\128."
L["Congratulations Messages"] = "\230\129\173\232\179\128\232\168\138\230\129\175" -- Needs review
L["conquest"] = true
L["  Conquest Points\
"] = "  \229\190\129\230\156\141\233\187\158\230\149\184\
"
L["Cooking"] = "\231\131\185\233\163\170"
L["copper"] = true
L["Copy Links"] = "Copy Links" -- Requires localization
L["cp"] = true
L["cpcap"] = true
L["Crap Cleaner"] = "\229\158\131\229\156\190\232\169\177\230\184\133\231\144\134"
L["Crap Cleaner blocked a message from %s%s|r."] = "Crap Cleaner blocked a message from %s%s|r." -- Requires localization
L["Creates a button to click that will return you to the bottom of the chat frame."] = "\229\162\158\229\138\160\228\184\128\229\128\139\231\155\180\230\142\165\229\136\176\229\176\141\232\169\177\229\186\149\233\131\168\231\154\132\230\140\137\233\136\149" -- Needs review
L["Custom chat filters."] = true
L["Custom Chat Filters"] = "\232\135\170\232\168\130\229\176\141\232\169\177\233\129\142\230\191\190"
L["Custom color"] = "\232\135\170\232\168\130\233\161\143\232\137\178"
L["Custom Emote: |cffffff00%s|r"] = "\232\135\170\232\168\130\232\161\168\230\131\133: |cffffff00%s|r"
L["Custom Emotes"] = "\232\135\170\232\168\130\232\161\168\230\131\133"
L["Custom format (advanced)"] = "\232\135\170\232\168\130\230\160\188\229\188\143 (\233\128\178\233\154\142)" -- Needs review
L["Custom Named Chat Filters"] = "Custom Named Chat Filters" -- Requires localization
L["Damage Meters"] = "\230\136\176\233\172\165\231\180\128\233\140\132\230\143\146\228\187\182"
L["Datatext"] = "Datatext" -- Requires localization
L["Datatext Display"] = "Datatext Display" -- Requires localization
L["Date"] = "Date" -- Requires localization
L["Day"] = "Day" -- Requires localization
L["Death Knight"] = "\230\173\187\228\186\161\233\168\142\229\163\171" -- Needs review
L["DEATHKNIGHT"] = "DEATHKNIGHT" -- Requires localization
L["Decline Invite"] = "Decline Invite" -- Requires localization
L["Default font face for the chat frames."] = "\233\160\144\232\168\173\229\176\141\232\169\177\232\166\150\231\170\151\229\173\151\229\158\139."
L["Default font outline for the chat frames."] = "\233\160\144\232\168\173\229\176\141\232\169\177\232\166\150\231\170\151\229\173\151\229\158\139\230\143\143\233\130\138."
L["Default font size for the chat frames."] = "\233\160\144\232\168\173\229\176\141\232\169\177\232\166\150\231\170\151\229\173\151\229\158\139\229\164\167\229\176\143."
L["Default Name Color"] = "\233\160\144\232\168\173\232\167\146\232\137\178\229\144\141\231\168\177\233\161\143\232\137\178"
L["Destroys all your saved class/level data"] = "\230\145\167\230\175\128\230\137\128\230\156\137\228\189\160\229\132\178\229\173\152\231\154\132 \232\129\183\230\165\173/\231\173\137\231\180\154 \232\179\135\230\150\153"
L["Determines if a chat message is deemed spam, at which point it can be filtered and the person reported."] = "Determines if a chat message is deemed spam, at which point it can be filtered and the person reported." -- Requires localization
L["Developer Tools"] = "\233\150\139\231\153\188\229\183\165\229\133\183"
L["Ding Messages"] = "Ding \232\168\138\230\129\175"
L["Disable All Modules"] = "Disable All Modules" -- Requires localization
L["Disabled"] = "\229\183\178\229\129\156\231\148\168" -- Needs review
L["Disabled Modules"] = "Disabled Modules" -- Requires localization
L["Disabled %s%s|r module."] = "Disabled %s%s|r module." -- Requires localization
L["Disable if..."] = "\228\187\128\233\186\188\230\162\157\228\187\182\230\153\130\229\129\156\231\148\168..."
L["Disable while you're AFK flagged."] = "\231\149\182\228\189\160\230\154\171\233\155\162\230\153\130\229\129\156\231\148\168."
L["Disable while you're DND flagged."] = "\231\149\182\228\189\160\229\139\191\230\147\190\230\153\130\229\129\156\231\148\168."
L["Displays reputation numbers and progress in the chat frame."] = "\229\156\168\232\129\138\229\164\169\232\166\150\231\170\151\233\161\175\231\164\186\232\129\178\230\156\155\230\149\184\229\173\151\229\146\140\233\128\178\229\186\166."
L["DND Messages"] = "\229\139\191\230\147\190\232\168\138\230\129\175"
L["Do Nothing"] = true
L["Do not use alphanumerical characters."] = "Do not use alphanumerical characters." -- Requires localization
L["Dont Always Run"] = true
L["Don't count on it."] = "Don't count on it." -- Requires localization
L["Don't Report"] = "\228\184\141\229\155\158\229\160\177"
L["Do you want to automatically remove an item when you meet your quota?"] = "\231\149\182\228\189\160\233\129\148\229\136\176\232\166\129\230\177\130\230\149\184\233\135\143\230\153\130\228\189\160\230\131\179\232\166\129\232\135\170\229\139\149\231\167\187\233\153\164\232\169\178\231\137\169\229\147\129\229\151\142?"
L["Druid"] = "\229\190\183\233\173\175\228\188\138" -- Needs review
L["DRUID"] = "DRUID" -- Requires localization
L["Editbox History"] = "\232\188\184\229\133\165\232\168\138\230\129\175\230\173\183\229\143\178" -- Needs review
L["ElvUI ChatTweaks"] = "ElvUI \229\176\141\232\169\177\229\162\158\229\188\183"
L["ElvUI_ChatTweaks"] = "ElvUI_ChatTweaks" -- Requires localization
L["ElvUI_ChatTweaks: You need to be level %d to whisper me.  Currently you are level %d!"] = "ElvUI_\229\176\141\232\169\177\229\162\158\229\188\183: \228\189\160\229\191\133\233\160\136\232\166\129\233\129\148\229\136\176 %d \229\141\179\230\137\141\232\131\189\229\175\134\232\170\158\230\136\145.  \228\189\160\231\143\190\229\156\168\231\154\132\231\173\137\231\180\154\230\152\175 %d!"
L["ElvUI_CT"] = "ElvUI_CT" -- Requires localization
L["Emote"] = "\232\161\168\230\131\133" -- Needs review
L["Emote Filter"] = "\232\161\168\230\131\133\233\129\142\230\191\190"
L["Emphasize Self"] = "\229\188\183\232\170\191\232\135\170\229\183\177" -- Needs review
L["Enable"] = true
L["Enable "] = "\229\149\159\231\148\168" -- Needs review
L["Enable All Modules"] = "Enable All Modules" -- Requires localization
L["Enable Debugging"] = "\229\149\159\231\148\168\229\129\181\233\140\175"
L["Enabled Modules"] = "Enabled Modules" -- Requires localization
L["Enabled %s%s|r module."] = "Enabled %s%s|r module." -- Requires localization
L["Enable Logging"] = "Enable Logging" -- Requires localization
L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name.  Can also scan guild notes for character names to display, if no note has been manually set."] = "Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name.  Can also scan guild notes for character names to display, if no note has been manually set." -- Requires localization
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always congratulate."] = "Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always congratulate." -- Requires localization
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always run."] = "Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always run." -- Requires localization
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always welcome."] = "Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always welcome." -- Requires localization
L["Enable to filter custom emotes made using |cff00ff00/emote|r or |cff00ff00/e|r."] = "\229\149\159\231\148\168\233\129\142\230\191\190\232\135\170\232\168\130\232\161\168\230\131\133\228\190\139\229\166\130\228\189\191\231\148\168 |cff00ff00/emote|r \230\136\150 |cff00ff00/e|r."
L["Enable to filter standard emotes such as |cff00ff00/dance|r or |cff00ff00/flirt|r."] = "\229\149\159\231\148\168\233\129\142\230\191\190\233\160\144\232\168\173\232\161\168\230\131\133\228\190\139\229\166\130 |cff00ff00/\232\183\179\232\136\158|r \230\136\150 |cff00ff00/\232\170\191\230\131\133|r."
L["Enable various debugging messages to help with errors or undesired functioning."] = "\229\149\159\231\148\168\229\144\132\231\168\174\229\129\181\233\140\175\232\168\138\230\129\175\228\190\134\229\185\171\229\138\169\230\170\162\230\159\165\233\140\175\232\170\164\229\146\140\229\138\159\232\131\189."
L["Enabling this will send a message to your chat whenever you change a zone with a list of the Battle Pets that are obtainable in the zone.  You have the option to filter them based on whether or not you own them.  This will also add the chat command |cff00ff96/zonelist|r to send the list whenever.  Even if you disable this the chat commands will still work."] = "Enabling this will send a message to your chat whenever you change a zone with a list of the Battle Pets that are obtainable in the zone.  You have the option to filter them based on whether or not you own them.  This will also add the chat command |cff00ff96/zonelist|r to send the list whenever.  Even if you disable this the chat commands will still work." -- Requires localization
L["Enchanting"] = "\233\153\132\233\173\148"
L["Engineering"] = "\229\183\165\231\168\139\229\173\184"
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = "\232\188\184\229\133\165\232\135\170\232\168\130\230\153\130\233\150\147\230\160\188\229\188\143. \229\143\131\233\150\177 http://www.lua.org/pil/22.1.html \228\190\134\229\143\150\229\190\151\228\184\128\228\187\189\230\156\137\230\149\136\230\160\188\229\188\143\231\154\132\229\136\151\232\161\168."
L["Exclude level display for max level characters"] = "\228\184\141\233\161\175\231\164\186\229\183\178\233\129\148\230\156\128\233\171\152\231\173\137\231\180\154\232\167\146\232\137\178\231\173\137\231\180\154"
L["Exclude max levels"] = "\230\142\146\233\153\164\230\156\128\233\171\152\231\173\137\231\180\154" -- Needs review
L["Execution Interval"] = "\229\159\183\232\161\140\233\150\147\233\154\148"
L["Faction Color"] = "\233\153\163\231\135\159\233\161\143\232\137\178"
L["Female"] = "Female" -- Requires localization
L["Filter achievement message spam!"] = "Filter achievement message spam!" -- Requires localization
L["Filter achievements earned by guildmates."] = "\233\129\142\230\191\190\229\133\172\230\156\131\230\136\144\229\147\161\230\137\128\229\143\150\229\190\151\231\154\132\230\136\144\229\176\177."
L["Filter achievements earned by nearby people."] = "\233\129\142\230\191\190\233\153\132\232\191\145\231\154\132\228\186\186\230\137\128\229\143\150\229\190\151\231\154\132\230\136\144\229\176\177."
L["Filter AFK/DND auto responses.  This module is compatible with WIM."] = "\233\129\142\230\191\190 \230\154\171\233\155\162/\229\139\191\230\147\190 \232\135\170\229\139\149\229\155\158\230\135\137.  \230\173\164\230\168\161\231\181\132\231\155\184\229\174\185\230\150\188 WIM."
L["Filter AFK messages."] = "\233\129\142\230\191\190\230\154\171\233\155\162\232\168\138\230\129\175."
L["Filter annoying phrases in chat."] = "\229\156\168\229\176\141\232\169\177\228\184\173\233\129\142\230\191\190\230\131\177\228\186\186\231\154\132\229\173\151\228\184\178."
L["Filter by Player Level"] = "\230\160\185\230\147\154\231\142\169\229\174\182\231\173\137\231\180\154\233\129\142\230\191\190"
L["Filter changed channel message."] = "\233\129\142\230\191\190\232\174\138\230\155\180\233\160\187\233\129\147\232\168\138\230\129\175."
L["Filter Color"] = "Filter Color" -- Requires localization
L["Filter DND messages."] = "\233\129\142\230\191\190\229\139\191\230\147\190\232\168\138\230\129\175."
L["Filter Entire Line"] = "Filter Entire Line" -- Requires localization
L["Filter Guild Achievements"] = "\233\129\142\230\191\190\229\133\172\230\156\131\230\136\144\229\176\177"
L["Filter guild invites."] = "\233\129\142\230\191\190\229\133\172\230\156\131\230\139\155\229\139\159."
L["Filter guild recruitment messages in chat."] = "\233\129\142\230\191\190\228\184\128\232\136\172\229\133\172\230\156\131\230\139\155\229\139\159\232\168\138\230\129\175."
L["Filter guild recruitment whispers."] = "\233\129\142\230\191\190\229\175\134\232\170\158\229\133\172\230\156\131\230\139\155\229\139\159\232\168\138\230\129\175."
L["Filtering Mode"] = "\233\129\142\230\191\190\230\168\161\229\188\143"
L["Filter joined channel message."] = "\233\129\142\230\191\190\229\138\160\229\133\165\233\160\187\233\129\147\232\168\138\230\129\175."
L["Filter left channel message."] = "\233\129\142\230\191\190\233\155\162\233\150\139\233\160\187\233\129\147\232\168\138\230\129\175."
L["Filter Line"] = "Filter Line" -- Requires localization
L["Filter Mode"] = "Filter Mode" -- Requires localization
L["Filter Nearby Achievements"] = "\233\129\142\230\191\190\233\153\132\232\191\145\230\136\144\229\176\177"
L["Filter out raid icons in chat."] = "Filter out raid icons in chat." -- Requires localization
L["Filter Pets"] = "Filter Pets" -- Requires localization
L["Filter Raid Icons"] = "Filter Raid Icons" -- Requires localization
L["Filters"] = "Filters" -- Requires localization
L["Filters guild recruitment spam in whispers or chat.  Can also block guild invites."] = "\229\156\168\229\175\134\232\170\158\230\136\150\228\184\128\232\136\172\233\160\187\233\129\147\233\129\142\230\191\190\229\133\172\230\156\131\230\139\155\229\139\159\232\168\138\230\129\175\227\128\130 \228\185\159\229\143\175\228\187\165\233\152\187\230\147\139\229\133\172\230\156\131\233\130\128\232\171\139\232\166\129\230\177\130."
L["Filters out Auction House system messages."] = "\233\129\142\230\191\190\228\190\134\232\135\170\230\139\141\232\179\163\229\160\180\231\154\132\232\168\138\230\129\175" -- Needs review
L["Filter spam throttle notices."] = "\233\129\142\230\191\190\229\191\171\233\128\159\231\153\188\232\168\128\230\143\144\231\164\186."
L["Filter standard and/or custom emotes."] = "\233\129\142\230\191\190\233\160\144\232\168\173 \229\146\140/\230\136\150 \232\135\170\232\168\130\232\161\168\230\131\133."
L["Filters the channel notices."] = "\233\129\142\230\191\190\232\135\170\232\168\130\233\160\187\233\129\147\230\143\144\231\164\186."
L["Filter the Auction Created message.\
\
|cffffff00%s|r"] = "Filter the Auction Created message.\
\
|cffffff00%s|r" -- Requires localization
L["Filter the Auction Expired message.\
\
|cffffff00%s|r"] = "\233\129\142\230\191\190\230\139\141\232\179\163\229\147\129\233\129\142\230\156\159\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Filter the Auction Outbid message.\
\
|cffffff00%s|r"] = "\233\129\142\230\191\190\230\139\141\232\179\163\229\147\129\230\144\182\230\168\153\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Filter the Auction Removed message.\
\
|cffffff00%s|r"] = "\233\129\142\230\191\190\230\139\141\232\179\163\229\147\129\231\167\187\233\153\164\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Filter the Auction Sold message.\
\
|cffffff00%s|r"] = "\233\129\142\230\191\190\230\139\141\232\179\163\229\147\129\229\148\174\229\135\186\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Filter the Auction Won message.\
\
|cffffff00%s|r"] = "\233\129\142\230\191\190\232\180\143\229\190\151\230\139\141\232\179\163\229\147\129\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Filter the Bid Accepted message.\
\
|cffffff00%s|r"] = "\233\129\142\230\191\190\230\142\165\229\143\151\230\139\141\232\179\163\229\147\129\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Filter the line containing the question."] = "Filter the line containing the question." -- Requires localization
L["Filter Triggers"] = "Filter Triggers" -- Requires localization
L["Filter whispers based on the sender's level."] = "\230\160\185\230\147\154\229\175\134\232\170\158\232\128\133\231\173\137\231\180\154\233\129\142\230\191\190\229\175\134\232\170\158."
L["First message to send.  You can include links.\
\
|cffffffMake sure you hit [ENTER] after you finish typing your message.|r"] = true
L["Font Color"] = "Font Color" -- Requires localization
L["Font Face"] = "\229\173\151\229\158\139" -- Needs review
L["Font Size"] = "\229\173\151\229\158\139\229\164\167\229\176\143" -- Needs review
L["Frame scraping timeout exceeded, results will be incomplete."] = "Frame scraping timeout exceeded, results will be incomplete." -- Requires localization
L["Frame to output the messages to."] = "Frame to output the messages to." -- Requires localization
L["Frame to send the addon messages to."] = "Frame to send the addon messages to." -- Requires localization
L["Friends"] = "\230\156\139\229\143\139" -- Needs review
L["Fun Filters"] = "Fun Filters" -- Requires localization
L["General"] = "\228\184\128\232\136\172\233\160\187\233\129\147"
L["General Tab Channels"] = "General Tab Channels" -- Requires localization
L["ginv"] = "ginv" -- Requires localization
L["ginvite"] = "ginvite" -- Requires localization
L["GInvite Alternate Command"] = "\229\133\172\230\156\131\233\130\128\232\171\139\230\140\135\228\187\164"
L["Gives you more flexibility in how you invite people to your group and guild."] = "\231\149\182\228\189\160\233\130\128\230\133\182\228\186\186\232\135\179\229\133\172\230\156\131\230\136\150\233\154\138\228\188\141\230\153\130\231\181\166\228\186\136\228\189\160\230\155\180\229\164\154\231\154\132\229\189\136\230\128\167."
L["GKick Command"] = "\232\184\162\229\135\186\229\133\172\230\156\131\230\140\135\228\187\164" -- Needs review
L["GKick Target: |cffffff00%s|r"] = "\232\184\162\229\135\186\229\133\172\230\156\131 \231\155\174\230\168\153: |cffffff00%s|r"
L["gold"] = true
L["Gold Calculator"] = "\233\135\145\229\185\163\232\168\136\231\174\151\230\169\159"
L["Group"] = "\233\154\138\228\188\141" -- Needs review
L["Group Invite Links"] = "\233\154\138\228\188\141\233\130\128\232\171\139\233\128\163\231\181\144"
L["Group Say Command"] = "\232\135\170\229\139\149\233\154\138\228\188\141\230\140\135\228\187\164" -- Needs review
L["Guild"] = "\229\133\172\230\156\131" -- Needs review
L["Guild Channel"] = "\229\133\172\230\156\131\233\160\187\233\129\147" -- Needs review
L["Guild Chat"] = "\229\133\172\230\156\131\229\176\141\232\169\177"
L["Guild Invite Links"] = "\229\133\172\230\156\131\233\130\128\232\171\139\233\128\163\231\181\144"
L["Guildmates"] = "\229\133\172\230\156\131\230\156\131\229\147\161"
L["Guild Messages"] = "\229\133\172\230\156\131\232\168\138\230\129\175"
L["Guild Options"] = "\229\133\172\230\156\131\233\129\184\233\160\133"
L["Guild Spam"] = "\229\133\172\230\156\131\230\139\155\229\139\159\233\129\142\230\191\190"
L["Guild Spam blocked a message from %s%s|r."] = "Guild Spam blocked a message from %s%s|r." -- Requires localization
L["Handles chat tab flashing."] = "Handles chat tab flashing." -- Requires localization
L["health"] = true
L["Here you can select which channels this module will scan for the keygroupWords to trigger the invite."] = "Here you can select which channels this module will scan for the keygroupWords to trigger the invite." -- Requires localization
L["HH:MM (12-hour)"] = "HH:MM (12-\229\176\143\230\153\130\229\136\182)" -- Needs review
L["HH:MM (24-hour)"] = "HH:MM (24-\229\176\143\230\153\130\229\136\182)" -- Needs review
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24-\229\176\143\230\153\130\229\136\182)" -- Needs review
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12-\229\176\143\230\153\130\229\136\182)" -- Needs review
L["Hide the spam blocked message asking you to report the person."] = "Hide the spam blocked message asking you to report the person." -- Requires localization
L["Highlight Color"] = "\233\171\152\228\186\174\233\161\143\232\137\178"
L["Highlight Substitutions"] = "Highlight Substitutions" -- Requires localization
L["Highlight Term"] = "Highlight Term" -- Requires localization
L["Highlight the search term in the results."] = "Highlight the search term in the results." -- Requires localization
L["Highlight the substitutions that are made by changing their color."] = "Highlight the substitutions that are made by changing their color." -- Requires localization
L["honor"] = true
L["  Honor Points\
"] = "  \230\166\174\232\173\189\233\187\158\230\149\184\
"
L["honour"] = true
L["Hook the GameTooltip to add information to pet tooltips."] = "Hook \233\129\138\230\136\178\230\143\144\231\164\186\228\190\134\229\162\158\229\138\160\229\175\181\231\137\169\230\143\144\231\164\186."
L["Hook the tooltip to show the toon's main or alts."] = "Hook the tooltip to show the toon's main or alts." -- Requires localization
L["Hook Tooltip"] = "Hook \230\143\144\231\164\186"
L["Hour (12hr)"] = "Hour (12hr)" -- Requires localization
L["Hour (24hr)"] = "Hour (24hr)" -- Requires localization
L["How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command."] = "How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command." -- Requires localization
L["How to filter any matches."] = "How to filter any matches." -- Requires localization
L["Hunter"] = "\231\141\181\228\186\186" -- Needs review
L["HUNTER"] = "HUNTER" -- Requires localization
L["I am |cff1784d1%s|r"] = true
L["Icon Action"] = "Icon Action" -- Requires localization
L["Icon Orientation"] = "\229\156\150\231\164\186\230\150\185\229\144\145"
L["Icon Size"] = "\229\156\150\231\164\186\229\164\167\229\176\143"
L["Icon to the left or right of the item link."] = "\229\156\168\231\137\169\229\147\129\233\128\163\231\181\144\229\183\166\230\150\185\230\136\150\229\143\179\230\150\185\233\161\175\231\164\186\229\156\150\231\164\186."
L["Identify Chat Frames"] = "\232\190\168\232\173\152\229\176\141\232\169\177\232\166\150\231\170\151"
L["If a keyword is found should the module filter the line?"] = "If a keyword is found should the module filter the line?" -- Requires localization
L["If a person sends you multiple channel invites this will automatically put them on your ignore list."] = "If a person sends you multiple channel invites this will automatically put them on your ignore list." -- Requires localization
L["If no name can be found for an 'alt' rank character, use entire note"] = "If no name can be found for an 'alt' rank character, use entire note" -- Requires localization
L["Ignore any messages you send containing keywords."] = "Ignore any messages you send containing keywords." -- Requires localization
L["Ignore Lifetime"] = "Ignore Lifetime" -- Requires localization
L["Ignore Sender"] = "Ignore Sender" -- Requires localization
L["Ignore Your Messages"] = "Ignore Your Messages" -- Requires localization
L["Improved Auction Messages"] = "\229\188\183\229\140\150\230\139\141\232\179\163\232\168\138\230\129\175"
L["Improve the Auction Expired message.\
\
|cffffff00%s|r"] = "\229\188\183\229\140\150\230\139\141\232\179\163\229\147\129\233\129\142\230\156\159\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Improve the Auction Outbid message.\
\
|cffffff00%s|r"] = "\229\188\183\229\140\150\230\139\141\232\179\163\229\147\129\230\144\182\230\168\153\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Improve the Auction Removed message.\
\
|cffffff00%s|r"] = "\229\188\183\229\140\150\230\139\141\232\179\163\229\147\129\231\167\187\233\153\164\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Improve the Auction Sold message.\
\
|cffffff00%s|r"] = "\229\188\183\229\140\150\230\139\141\232\179\163\229\147\129\229\148\174\229\135\186\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Improve the Auction Won message.\
\
|cffffff00%s|r"] = "\229\188\183\229\140\150\232\180\143\229\190\151\230\139\141\232\179\163\229\147\129\232\168\138\230\129\175.\
\
|cffffff00%s|r"
L["Inactive Modules"] = "Inactive Modules" -- Requires localization
L["Include level"] = "\229\140\133\229\144\171\231\173\137\231\180\154" -- Needs review
L["Include the player's level"] = "\229\140\133\229\144\171\232\167\146\232\137\178\231\173\137\231\180\154" -- Needs review
L["In Command"] = "In \230\140\135\228\187\164"
L["Inscription"] = "\233\138\152\230\150\135\229\173\184"
L["Instance"] = "Instance" -- Requires localization
L["Instance Channel"] = "Instance Channel" -- Requires localization
L["Instance Leader"] = "Instance Leader" -- Requires localization
L["inv"] = "inv" -- Requires localization
L["Invalid format found on entry \"%s\"."] = "Invalid format found on entry \"%s\"." -- Requires localization
L["invite"] = "invite" -- Requires localization
L["Invite Links"] = "\232\135\170\229\139\149\233\130\128\232\171\139" -- Needs review
L["Invites"] = "Invites" -- Requires localization
L[" isn't a number."] = " \228\184\141\230\152\175\228\184\128\229\128\139\230\149\184\229\173\151."
L[" isn't a recognized variable or number."] = " \228\184\141\230\152\175\228\184\128\229\128\139\229\143\175\232\190\168\232\173\152\231\154\132\232\174\138\230\149\184\230\136\150\230\149\184\229\173\151."
L["It is certain."] = "It is certain." -- Requires localization
L["It is decidedly so."] = "It is decidedly so." -- Requires localization
L["Jewelcrafting"] = "\231\143\160\229\175\182\229\138\160\229\183\165"
L["Joined Channel"] = "\233\160\187\233\129\147\229\138\160\229\133\165"
L["jp"] = true
L["jpcap"] = true
L["justice"] = true
L["  Justice Points\
"] = "  \230\173\163\231\190\169\233\187\158\230\149\184\
"
L["Just one character."] = "Just one character." -- Requires localization
L["Keeps your channel colors by name rather than by number."] = "Keeps your channel colors by name rather than by number." -- Requires localization
L["Keybinds"] = "\229\191\171\230\141\183\233\141\181"
L["Keywords"] = "Keywords" -- Requires localization
L["Keyword Sounds"] = "Keyword Sounds" -- Requires localization
L["Leatherworking"] = "\232\163\189\231\154\174"
L["Left"] = "\233\157\160\229\183\166"
L["Left Bracket"] = "\229\183\166\230\139\172\229\188\167"
L["Left Channel"] = "\229\183\166\233\130\138\233\160\187\233\129\147"
L["Left Click"] = "Left Click" -- Requires localization
L["Lets you alt-click player names to invite them to your party."] = "\232\174\147\228\189\160ALT+\229\183\166\233\141\181\233\187\158\233\129\184\229\144\141\231\168\177\228\190\134\233\130\128\232\171\139\228\187\150\229\128\145\229\138\160\229\133\165\233\154\138\228\188\141."
L["Lets you set the justification of text in your chat frames."] = "\232\174\147\228\189\160\232\168\173\229\174\154\229\176\141\232\169\177\232\166\150\231\170\151\231\154\132\229\176\141\233\189\138\230\150\185\229\188\143."
L["Level: |cffffff00%s|r, Message: |cffffff00%s|r"] = "\231\173\137\231\180\154: |cffffff00%s|r, \232\168\138\230\129\175: |cffffff00%s|r"
L["Level Difference"] = "Level Difference" -- Requires localization
L["Level Location"] = "\231\173\137\231\180\154\228\189\141\231\189\174" -- Needs review
L["Level wasn't a number, tell Lockslap. Level was |cffff0000%s|r!"] = "\231\173\137\231\180\154\228\184\141\230\152\175\229\128\139\230\149\184\229\173\151, \229\145\138\232\168\180 Lockslap. \231\173\137\231\180\154\230\152\175 |cffff0000%s|r!"
L["Link All Professions"] = "\233\128\163\231\181\144\230\137\128\230\156\137\228\186\164\230\152\147\230\138\128\232\131\189"
L["Log is empty."] = "Log is empty." -- Requires localization
L["Log Lines"] = "Log Lines" -- Requires localization
L["Log Notice"] = "Log Notice" -- Requires localization
L["Logs the lines that are filtered by the |cff00ff96%s|r, |cff00ff96%s|r, |cff00ff96%s|r, |cff00ff96%s|r, and |cff00ff96%s|r modules."] = "Logs the lines that are filtered by the |cff00ff96%s|r, |cff00ff96%s|r, |cff00ff96%s|r, |cff00ff96%s|r, and |cff00ff96%s|r modules." -- Requires localization
L["Look in guildnotes for character names, unless a note is set manually"] = "\229\156\168\229\133\172\230\156\131\232\168\187\232\168\152\228\184\173\230\159\165\232\169\162\232\167\146\232\137\178\229\144\141\231\168\177, \233\153\164\233\157\158\229\183\178\230\137\139\229\139\149\232\168\173\229\174\154"
L["Loot Icons"] = "\230\136\176\229\136\169\229\147\129\229\156\150\231\164\186"
L["Loss Color"] = "\232\188\184\230\142\137\233\161\143\232\137\178"
L["lowercase"] = "lowercase" -- Requires localization
L["Mage"] = "\230\179\149\229\184\171" -- Needs review
L["MAGE"] = "MAGE" -- Requires localization
L["Magic 8-Ball"] = "Magic 8-Ball" -- Requires localization
L["Magic 8-Ball Says: I am ready to answer your questions!  Do \"%s <question>\" to ask me a question."] = "Magic 8-Ball Says: I am ready to answer your questions!  Do \"%s <question>\" to ask me a question." -- Requires localization
L["Magic 8-Ball says: %s"] = "Magic 8-Ball says: %s" -- Requires localization
L["Main: "] = "Main: " -- Requires localization
L["Male"] = "Male" -- Requires localization
L["mana"] = true
L["Material Quantities"] = "\232\179\135\230\186\144\230\149\184\233\135\143"
L["Materials Farming"] = "\232\179\135\230\186\144\232\146\144\233\155\134" -- Needs review
L["Materials to Track"] = "\232\191\189\232\185\164\232\179\135\230\186\144" -- Needs review
L["Maximum Delay"] = "\230\156\128\229\164\167\229\187\182\233\129\178"
L["Maximum Lines"] = "Maximum Lines" -- Requires localization
L["Maximum number of lines to keep."] = "Maximum number of lines to keep." -- Requires localization
L["Maximum time, in seconds, to wait before bidding someone farewell."] = "\233\129\147\229\136\165\229\137\141\231\173\137\229\190\133\230\156\128\229\164\167\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Maximum time, in seconds, to wait before congratulating someone."] = "\230\129\173\232\179\128\229\137\141\231\173\137\229\190\133\230\156\128\229\164\167\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Maximum time, in seconds, to wait before welcoming someone."] = "\230\173\161\232\191\142\229\137\141\231\173\137\229\190\133\230\156\128\229\164\167\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Maximum time, in seconds, to wait before whispering someone the link."] = "\229\155\158\232\166\134\233\128\163\231\181\144\229\137\141\231\173\137\229\190\133\230\156\128\229\164\167\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Message color."] = "\232\168\138\230\129\175\233\161\143\232\137\178." -- Needs review
L["Message Color"] = "\232\168\138\230\129\175\233\161\143\232\137\178" -- Needs review
L["Message highlight color."] = "\232\168\138\230\129\175\233\171\152\228\186\174\233\161\143\232\137\178."
L["Message Settings"] = "\232\168\138\230\129\175\232\168\173\229\174\154"
L["Messages for when multiple people complete achievements.  A random one will always be selected.\
\
|cffff0000Wildcards do not apply for multiple achievements.|r"] = true
L["Messages for when someone completes an achievement.  A random one will always be selected.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r  - Name of the person.\
|cff00ff00#achieve#|r - Achievement they completed."] = true
L["Messages to use in guild chat when someone leaves your guild.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Person who left.\
|cff00ff00#guild#|r - Name of your guild."] = true
L["Messages to use in the whisper when someone leaves your guild.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Person who left.\
|cff00ff00#guild#|r - Name of your guild."] = true
L["Messages to use when someone joins your guild.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Person who joined.\
|cff00ff00#guild#|r - Name of your guild."] = true
L["Messages to use when someone says \"ding\".\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Who said ding.\
|cff00ff00#guild#|r - Their current level."] = true
L["Message Throttle"] = "Message Throttle" -- Requires localization
L["Method by which to send the messages.\
\
|cffff00Alternate is alternating between the two messages.\
Combined is both messages at once.\
Random will randomly pick one of the messages to send.|r"] = true
L["Minimap Button"] = "Minimap Button" -- Requires localization
L["Minimum Delay"] = "\230\156\128\229\176\143\229\187\182\233\129\178"
L["Minimum DK Level"] = "\230\173\187\233\168\142\230\156\128\228\189\142\231\173\137\231\180\154" -- Needs review
L["Minimum Level"] = "\230\156\128\228\189\142\231\173\137\231\180\154" -- Needs review
L["Minimum level for a Death Knight to be in order to whisper you."] = "\230\173\187\233\168\142\230\156\128\229\176\143\229\143\175\229\175\134\232\170\158\231\173\137\231\180\154."
L["Minimum level for a non-Death Knight to be in order to whisper you."] = "\233\157\158\230\173\187\233\168\142\230\156\128\229\176\143\229\143\175\229\175\134\232\170\158\231\173\137\231\180\154u."
L["Minimum level required for an achievement to not be filtered."] = "\230\156\128\229\176\143\228\184\141\233\129\142\230\191\190\230\136\144\229\176\177\231\173\137\231\180\154."
L["Minimum time, in seconds, to wait before bidding someone farewell."] = "\233\129\147\229\136\165\229\137\141\230\156\128\229\176\143\231\173\137\229\190\133\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Minimum time, in seconds, to wait before congratulating someone."] = "\230\129\173\232\179\128\229\137\141\230\156\128\229\176\143\231\173\137\229\190\133\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Minimum time, in seconds, to wait before welcoming someone."] = "\230\173\161\232\191\142\229\137\141\230\156\128\229\176\143\231\173\137\229\190\133\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Minimum time, in seconds, to wait before whispering someone the link."] = "\229\155\158\232\166\134\233\128\163\231\181\144\229\137\141\230\156\128\229\176\143\231\173\137\229\190\133\230\153\130\233\150\147,\229\150\174\228\189\141\231\130\186\231\167\146."
L["Minute"] = "Minute" -- Requires localization
L["MM:SS"] = true -- Needs review
L["Module doesn't exist, or log is empty."] = "Module doesn't exist, or log is empty." -- Requires localization
L["Monitor Chat Events"] = "Monitor Chat Events" -- Requires localization
L["Monitor guild chat."] = "\231\155\163\230\142\167\229\133\172\230\156\131\229\176\141\232\169\177."
L["Monitor party chat."] = "\231\155\163\230\142\167\233\154\138\228\188\141\230\156\131\229\176\141\232\169\177."
L["Monitor raid chat."] = "\231\155\163\230\142\167\229\156\152\233\154\138\229\176\141\232\169\177."
L["Monitor say chat."] = "\231\155\163\230\142\167\232\170\170."
L["Monitor text in this channel for link triggers."] = "Monitor text in this channel for link triggers." -- Requires localization
L["Monitor whispers."] = "\231\155\163\230\142\167\229\175\134\232\170\158."
L["Monitor yell chat."] = "\231\155\163\230\142\167\229\164\167\229\150\138."
L["Monk"] = "Monk" -- Requires localization
L["MONK"] = "MONK" -- Requires localization
L["Monster Emote"] = "\230\128\170\231\137\169\232\161\168\230\131\133" -- Needs review
L["Monster Say"] = "\230\128\170\231\137\169\232\170\170" -- Needs review
L["Month"] = "Month" -- Requires localization
L["Most likely."] = "Most likely." -- Requires localization
L["Multiple Achievement Messages"] = "\229\164\154\233\135\141\230\136\144\229\176\177\232\168\138\230\129\175"
L["Multiple Invite Command"] = "Multiple Invite Command" -- Requires localization
L["My reply is no."] = "My reply is no." -- Requires localization
L["My sources say no."] = "My sources say no." -- Requires localization
L["Name"] = "\229\144\141\231\168\177" -- Needs review
L["Name color"] = "\229\144\141\231\168\177\228\184\138\232\137\178"
L["Nearby People"] = "\233\153\132\232\191\145\231\154\132\228\186\186"
L["New Version Notify"] = "\230\150\176\231\137\136\233\128\154\231\159\165"
L["No"] = "No" -- Requires localization
L["No custom emotes are currently being used."] = "\230\178\146\230\156\137\232\135\170\232\168\130\232\161\168\230\131\133\230\173\163\229\156\168\232\162\171\228\189\191\231\148\168."
L["No Filter"] = "No Filter" -- Requires localization
L["None"] = "\231\132\161" -- Needs review
L["No RealNames"] = "\228\184\141\233\161\175\231\164\186\231\156\159\229\175\166\229\167\147\229\144\141" -- Needs review
L["No role was set because you have no specialization."] = "No role was set because you have no specialization." -- Requires localization
L["<notarget>"] = "<notarget>" -- Requires localization
L["NoTarget"] = "\231\132\161\231\155\174\230\168\153"
L["Not Found"] = "Not Found" -- Requires localization
L["Notify on Filter"] = "Notify on Filter" -- Requires localization
L["Notify on new release?"] = "Notify on new release?" -- Requires localization
L["Notify on Role Set"] = "Notify on Role Set" -- Requires localization
L["Notify you when a message is filtered."] = "\231\149\182\232\168\138\230\129\175\232\162\171\233\129\142\230\191\190\230\153\130\230\143\144\233\134\146\228\189\160."
L["Notify you when a message/whisper is filtered."] = "\231\149\182\232\168\138\230\129\175/\229\175\134\232\170\158\232\162\171\233\129\142\230\191\190\230\153\130\230\143\144\233\134\146\228\189\160."
L["Not tracking %s."] = "%s \230\156\170\232\162\171\232\191\189\232\185\164."
L["Numbered Channels"] = "Numbered Channels" -- Requires localization
L["Num Channels"] = "Num Channels" -- Requires localization
L["Officer"] = "\229\185\185\233\131\168" -- Needs review
L["Officer Channel"] = "\229\185\185\233\131\168\233\160\187\233\129\147" -- Needs review
L["Officer Chat"] = "\229\185\185\233\131\168\229\176\141\232\169\177"
L["One or more of the changes you have made require you to reload your UI."] = "\228\184\128\229\128\139\230\136\150\229\164\154\229\128\139\232\174\138\230\155\180\233\156\128\232\166\129\228\189\160\233\135\141\232\188\137UI."
L["Only filter achievements earned by players below a certain level."] = "\229\131\133\233\129\142\230\191\190\228\189\142\230\150\188\231\137\185\229\174\154\231\173\137\231\180\154\231\142\169\229\174\182\229\143\150\229\190\151\231\154\132\230\136\144\229\176\177."
L["Open Config"] = "Open Config" -- Requires localization
L["Open ElvUI's Config"] = "Open ElvUI's Config" -- Requires localization
L["Opens configuration window."] = "\233\150\139\229\149\159\232\168\173\229\174\154\232\166\150\231\170\151."
L["Other Channels"] = "\229\133\182\229\174\131\233\160\187\233\129\147" -- Needs review
L["Ouput Frame"] = "\232\188\184\229\135\186\232\166\150\231\170\151"
L["Outline"] = "\230\143\143\233\130\138" -- Needs review
L["Outlook good."] = "Outlook good." -- Requires localization
L["Outlook not so good."] = "Outlook not so good." -- Requires localization
L["Output Channel"] = "Output Channel" -- Requires localization
L["Output Color"] = "\232\188\184\229\135\186\233\161\143\232\137\178"
L["Output color of the rerouted messages."] = "\233\135\141\229\176\142\232\168\138\230\129\175\232\188\184\229\135\186\233\161\143\232\137\178."
L["Output Frame"] = "\232\188\184\229\135\186\232\166\150\231\170\151"
L["Output Message Every..."] = true
L["Output the message every X times you gain XP."] = "\230\175\143 X \230\172\161\228\189\160\231\141\178\229\190\151\231\182\147\233\169\151\230\153\130\233\161\175\231\164\186\232\168\138\230\129\175."
L["Output To..."] = "Output To..." -- Requires localization
L["% Owned"] = "% Owned" -- Requires localization
L["Owned Only"] = "Owned Only" -- Requires localization
L["Paladin"] = "\232\129\150\233\168\142\229\163\171" -- Needs review
L["PALADIN"] = "PALADIN" -- Requires localization
L["Parameter: |cffffff00%s|r"] = "\229\143\131\230\149\184: |cffffff00%s|r"
L["Party"] = "\233\154\138\228\188\141" -- Needs review
L["Party Channel"] = "\233\154\138\228\188\141\233\160\187\233\129\147" -- Needs review
L["Party Leader"] = "\233\154\138\228\188\141\233\154\138\233\149\183" -- Needs review
L["Party Members"] = "\233\154\138\228\188\141\230\136\144\229\147\161"
L["Percent Chance"] = "%\230\169\159\230\156\131"
L["Perhaps you meant '*' (multiplication)?"] = "\228\189\160\231\154\132\230\132\143\230\128\157\230\152\175 '*' (\228\185\152\230\179\149)?"
L["Pet Battle Info"] = "\229\175\181\231\137\169\229\176\141\230\136\176\232\168\138\230\129\175"
L["Pet Battles"] = "\229\175\181\231\137\169\230\136\176\233\172\165"
L["Pet Combat Log"] = "\229\175\181\231\137\169\229\176\141\230\136\176\231\180\128\233\140\132"
L["Pets Per Line"] = "Pets Per Line" -- Requires localization
L["Place the level before or after the player's name."] = "\229\156\168\232\167\146\232\137\178\229\144\141\231\168\177\229\137\141\230\136\150\229\190\140\233\161\175\231\164\186\231\173\137\231\180\154."
L["Play a sound when it pops up."] = "Play a sound when it pops up." -- Requires localization
L["Player Class"] = "Player Class" -- Requires localization
L["Player Level"] = "\231\142\169\229\174\182\231\173\137\231\180\154"
L["Player level display options."] = "\231\142\169\229\174\182\231\173\137\231\180\154\233\161\175\231\164\186\233\129\184\233\160\133."
L["Player Names"] = "\231\142\169\229\174\182\229\167\147\229\144\141"
L["Player's Average iLvl"] = "Player's Average iLvl" -- Requires localization
L["Player's Class"] = "Player's Class" -- Requires localization
L["Player's Gender"] = "Player's Gender" -- Requires localization
L["Player's Health"] = "Player's Health" -- Requires localization
L["Player's Health Deficit"] = "Player's Health Deficit" -- Requires localization
L["Player's Health Percent"] = "Player's Health Percent" -- Requires localization
L["Players Level"] = "Players Level" -- Requires localization
L["Player's Location"] = "Player's Location" -- Requires localization
L["Player's Mana"] = "Player's Mana" -- Requires localization
L["Player's Mana Deficit"] = "Player's Mana Deficit" -- Requires localization
L["Player's Mana Percent"] = "Player's Mana Percent" -- Requires localization
L["Player's Max Health"] = "Player's Max Health" -- Requires localization
L["Player's Max Mana"] = "Player's Max Mana" -- Requires localization
L["Player's Name"] = "Player's Name" -- Requires localization
L["Player's X-Coordinate"] = "Player's X-Coordinate" -- Requires localization
L["Player's Y-Coordinate"] = "Player's Y-Coordinate" -- Requires localization
L["Player's Zone"] = "Player's Zone" -- Requires localization
L["Plays a sound, of your choosing (via LibSharedMedia-3.0), whenever a message is received in a given channel."] = "\231\149\182\230\140\135\229\174\154\233\160\187\233\129\147\230\142\165\230\148\182\229\136\176\232\168\138\230\129\175\230\153\130\239\188\140\230\146\165\230\148\190\228\189\160\230\140\135\229\174\154\231\154\132\233\159\179\230\149\136(\233\128\143\233\129\142 LibSharedMedia-3.0)."
L["Plays a sound when one of your ElvUI keywords is found."] = "Plays a sound when one of your ElvUI keywords is found." -- Requires localization
L["Play Sound"] = "Play Sound" -- Requires localization
L["Please DON'T use this. Reporting the spam is what gets the hacked accounts used by\
the spammers closed down and realms cleaned up. Also, if many people report a spammer,\
then that spammer looses the ability to chat meaning they can no longer spam, this benefits\
everyone."] = "Please DON'T use this. Reporting the spam is what gets the hacked accounts used by\
the spammers closed down and realms cleaned up. Also, if many people report a spammer,\
then that spammer looses the ability to chat meaning they can no longer spam, this benefits\
everyone." -- Requires localization
L["Plugins by |cff9382c9Lockslap|r"] = "Plugins by |cff9382c9Lockslap|r" -- Requires localization
L["Popup"] = "Popup" -- Requires localization
L["PopupMessage"] = "PopupMessage" -- Requires localization
L["Popup Messages"] = "Popup Messages" -- Requires localization
L["power"] = true
L["Prefix Character"] = "Prefix Character" -- Requires localization
L["Priest"] = "\231\137\167\229\184\171" -- Needs review
L["PRIEST"] = "PRIEST" -- Requires localization
L["Print Addon Version"] = "\233\161\175\231\164\186\230\143\146\228\187\182\231\137\136\230\156\172"
L["Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues."] = "Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues." -- Requires localization
L["Prints a message in the chat with your remain XP needed to level up."] = "\229\156\168\232\129\138\229\164\169\232\166\150\231\170\151\228\184\173\233\161\175\231\164\186\228\189\160\233\130\132\233\156\128\229\164\154\229\176\145\231\182\147\233\169\151\229\128\188\228\187\165\229\141\135\231\180\154."
L["Prints module status."] = "Prints module status." -- Requires localization
L["Print this again."] = "Print this again." -- Requires localization
L["Progress Updates"] = "Progress Updates" -- Requires localization
L["Provides a |cff00ff00/gkick|r command, as it should be."] = "\230\143\144\228\190\155 |cff00ff00/gkick|r \230\140\135\228\187\164, \230\156\172\228\190\134\229\176\177\230\135\137\232\169\178\230\156\137\231\154\132."
L["Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically."] = "Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically." -- Requires localization
L["Provides a few tools to help me (Lockslap), develop this addon as well as diagnose and fix any errors that are reported.\
\
|cff00ff00You can leave this addon disabled unless I (Lockslap) ask you to enable it for some debugging.|r"] = "Provides a few tools to help me (Lockslap), develop this addon as well as diagnose and fix any errors that are reported.\
\
|cff00ff00You can leave this addon disabled unless I (Lockslap) ask you to enable it for some debugging.|r" -- Requires localization
L["Provides a /in command to delay the execution of code in macros and other settings."] = "\230\143\144\228\190\155 a /in \230\140\135\228\187\164\228\190\134\230\154\171\231\183\169\229\156\168\229\183\168\233\155\134\230\136\150\229\133\182\228\187\150\232\168\173\229\174\154\228\184\173\231\154\132\230\140\135\228\187\164."
L["Provides basic chat subtitutions."] = "Provides basic chat subtitutions." -- Requires localization
L["Provides |cff00ff00/ginv|r, an alternative to |cff00ff00/ginvite|r command, for us lazy folks."] = "\230\143\144\228\190\155 |cff00ff00/ginv|r, \228\184\128\229\128\139\229\130\153\231\148\168 |cff00ff00/ginvite|r \230\140\135\228\187\164, \231\181\166\233\130\163\228\186\155\230\135\182\230\131\176\231\154\132\229\130\162\228\188\153."
L["Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.\
\
Module Written by Bj\195\182rn Benjamin Hiller <bjoern.hiller@gmail.com>"] = "Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.\
\
Module Written by Bj\195\182rn Benjamin Hiller <bjoern.hiller@gmail.com>" -- Requires localization
L["Provides keybinds to make talking in a specific chat easier."] = "\230\143\144\228\190\155\229\191\171\230\141\183\233\141\181\232\174\147\232\129\138\229\164\169\230\155\180\231\176\161\229\150\174."
L["Provides options to color player names, add player levels, and add tab completion of player names."] = "\230\143\144\228\190\155\233\129\184\233\160\133\228\190\134\228\184\138\232\137\178\232\167\146\232\137\178\229\144\141\231\168\177,\233\161\175\231\164\186\231\142\169\229\174\182\231\173\137\231\180\154,\229\146\140\230\150\176\229\162\158TAB\232\135\170\229\139\149\229\174\140\230\136\144\232\167\146\232\137\178\229\144\141\231\168\177."
L["Put each emote on a separate line.\
Separate the command from the text with a colon (\":\")."] = "\230\138\138\230\175\143\229\128\139\232\161\168\230\131\133\230\148\190\229\156\168\228\184\141\229\144\140\232\161\140.\
\231\148\168\229\134\146\232\153\159\229\136\134\233\154\148\230\175\143\229\128\139\230\140\135\228\187\164 (\":\")."
L["Quality Notification"] = "\229\147\129\232\179\170\230\143\144\233\134\146"
L["Raid"] = "\229\156\152\233\154\138" -- Needs review
L["Raid Boss Emote"] = "\233\166\150\233\160\152\232\161\168\230\131\133" -- Needs review
L["Raid Channel"] = "\229\156\152\233\154\138\233\160\187\233\129\147" -- Needs review
L["Raid Leader"] = "\229\156\152\233\154\138\233\154\138\233\149\183" -- Needs review
L["Raid Members"] = "\229\156\152\233\154\138\233\154\138\229\147\161"
L["Raid Warning"] = "\229\156\152\233\154\138\232\173\166\229\145\138" -- Needs review
L["Raid Warning Channel"] = "\229\156\152\233\154\138\232\173\166\229\145\138\233\160\187\233\129\147" -- Needs review
L["Random"] = true
L["RANDOM"] = true
L["Random Number"] = "Random Number" -- Requires localization
L["Ready Check Command"] = "Ready Check Command" -- Requires localization
L["RealID Brackets"] = "RealID \230\139\172\229\188\167"
L["RealID Conversation"] = "RealID \229\176\141\232\169\177" -- Needs review
L["RealID Whisper"] = "RealID \229\175\134\232\170\158" -- Needs review
L["Really remove this word from your trigger list?"] = true
L["Release Command"] = "Release Command" -- Requires localization
L["Remembers the history of the editbox across sessions."] = true
L["Reminder"] = "Reminder" -- Requires localization
L["Remove"] = true
L["Remove a word from your group invite trigger list"] = true
L["Remove a word from your guild invite trigget list."] = true
L["Remove Group Trigger"] = true
L["Remove Guild Trigger"] = true
L["Remove Icon Only"] = true
L[", removing from list"] = true
L["Repeat Command"] = "\233\135\141\232\164\135\230\140\135\228\187\164"
L["Repeat Question"] = "Repeat Question" -- Requires localization
L["Repeat the question when giving a response."] = "Repeat the question when giving a response." -- Requires localization
L["Reply hazy, try again."] = "Reply hazy, try again." -- Requires localization
L["Reported by %s"] = true
L["Reputation"] = "\232\129\178\230\156\155"
L["Reputation Color"] = "\232\129\178\230\156\155\233\161\143\232\137\178"
L["Reroute Auction Messages"] = "\230\139\141\232\179\163\229\160\180\232\168\138\230\129\175\233\135\141\229\176\142"
L["Reset"] = "\233\135\141\231\189\174" -- Needs review
L["Reset ChatFrame text justifications to defaults (left)."] = "\233\135\141\231\189\174\232\129\138\229\164\169\232\166\150\231\170\151\229\176\141\233\189\138\232\135\179\233\160\144\232\168\173\229\128\188 (\229\183\166)."
L["Reset Data"] = "\233\135\141\231\189\174\232\179\135\230\150\153" -- Needs review
L["Reset Font Data"] = true
L["Reset Materials"] = true
L["Resets all chat frames to their original font settings."] = true
L["Reset Text Justitification"] = "\233\135\141\231\189\174\230\150\135\229\173\151\229\176\141\233\189\138\230\150\185\229\188\143"
L["Respond to Whispers"] = true
L["Respond to whispers notifying them that they don't meet the level requirement."] = true
L["Right"] = "\233\157\160\229\143\179"
L["Right Bracket"] = "\229\143\179\230\139\172\229\188\167"
L["Right Click"] = "Right Click" -- Requires localization
L["Rogue"] = "\231\155\156\232\179\138" -- Needs review
L["ROGUE"] = "ROGUE" -- Requires localization
L["Role Poll Command"] = "Role Poll Command" -- Requires localization
L["Role Set: %s%s|r"] = "Role Set: %s%s|r" -- Requires localization
L["Role will not be set while in combat."] = "Role will not be set while in combat." -- Requires localization
L["Roll Color"] = "\230\147\178\233\170\176\233\161\143\232\137\178"
L["Roll Pattern: |cffffff00%s|r"] = "\230\147\178\233\170\176 Pattern: |cffffff00%s|r"
L["Save all /who data"] = true
L["Save class data from friends between sessions."] = true
L["Save class data from groups between sessions."] = true
L["Save class data from guild between sessions."] = true
L["Save class data from target/mouseover between sessions."] = true
L["Save class data from /who queries between sessions."] = true
L["Save Data"] = "\229\132\178\229\173\152\232\179\135\230\150\153"
L["Save data between sessions. Will increase memory usage"] = true
L["Say"] = "\232\170\170" -- Needs review
L["Say Chat"] = true
L["%s  Conquest Cap\
"] = true
L["Scrape Time"] = "Scrape Time" -- Requires localization
L["Scroll Reminder"] = "\232\135\179\229\186\149\230\140\137\233\136\149"
L["Search"] = "Search" -- Requires localization
L["Search Results:"] = "Search Results:" -- Requires localization
L["Search Results |cff9382c9(%d Found)|r:"] = "Search Results |cff9382c9(%d Found)|r:" -- Requires localization
L["Search term is too short."] = "Search term is too short." -- Requires localization
L["Second"] = "Second" -- Requires localization
L["Second message to send.  You can include links.\
\
|cffffffMake sure you hit [ENTER] after you finish typing your message.|r"] = true
L["Select a color for this channel."] = true
L["Select a method for coloring player names"] = true
L["Select an option if you want the zone list to only contain pets you own or do not own."] = "Select an option if you want the zone list to only contain pets you own or do not own." -- Requires localization
L["Select how you want the player's level colored."] = "Select how you want the player's level colored." -- Requires localization
L["Select the channels to apply the filter to."] = "Select the channels to apply the filter to." -- Requires localization
L["Select the channels you want monitored."] = "Select the channels you want monitored." -- Requires localization
L["Select the channels you want to monitor."] = "Select the channels you want to monitor." -- Requires localization
L["Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number."] = "Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number." -- Requires localization
L["Select the custom color to use for alt names"] = true
L["Select which channels to flash when a message is received."] = "Select which channels to flash when a message is received." -- Requires localization
L["Select which factions you would like to receive notifications for."] = true
L["%sElvUI Chat Tweaks|r by |cff9382c9Lockslap|r"] = "%sElvUI Chat Tweaks|r by |cff9382c9Lockslap|r" -- Requires localization
L["Send a chat message when a role is set/changed."] = "Send a chat message when a role is set/changed." -- Requires localization
L["Send a notice when something is added to the log."] = "Send a notice when something is added to the log." -- Requires localization
L["Send a tell to your target."] = true
L["Send a whisper to the person who left."] = true
L["Send Guild Messages"] = true
L["Send messages to guild chat when someone leaves."] = true
L["Send Reminder"] = "Send Reminder" -- Requires localization
L["Send Whisper"] = true
L["Separator"] = "\229\136\134\233\155\162\229\153\168" -- Needs review
L["Set Main"] = true
L["Set the coloring mode for alt names"] = true
L["Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel."] = "Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel." -- Requires localization
L["Set the sound to play."] = "Set the sound to play." -- Requires localization
L["Settings"] = true
L["Shaman"] = "\232\150\169\230\187\191" -- Needs review
L["SHAMAN"] = "SHAMAN" -- Requires localization
L["Shift + Left Click"] = "Shift + Left Click" -- Requires localization
L["Shift + Right Click"] = "Shift + Right Click" -- Requires localization
L["Show Alts"] = "Show Alts" -- Requires localization
L["Show a report player popup (showing the spam) instead of printing in chat"] = true
L["Show current to total XP percentage."] = true
L["Show ElvUI Chat Tweaks Config Window"] = "Show ElvUI Chat Tweaks Config Window" -- Requires localization
L["Showing Configuration Options"] = "Showing Configuration Options" -- Requires localization
L["Show Main"] = "Show Main" -- Requires localization
L["Show Percentage"] = true
L["Show remaining rested XP."] = true
L["Show Rested XP"] = true
L["Shows messages in a popup frame."] = "Shows messages in a popup frame." -- Requires localization
L["Show Spam Popup"] = true
L["Show the total number of modules on the datatext."] = "Show the total number of modules on the datatext." -- Requires localization
L["Show toon names instead of real names"] = true
L["Show Total XP"] = true
L["Show total XP needed to level."] = true
L["Show welcome message when logging in."] = true
L["Signs point to yes."] = "Signs point to yes." -- Requires localization
L["silver"] = true
L["Similar to the |cffffffIn Command|r module, except it will repeat the command X times."] = true
L["Size of the coin icons.  Generally you want to use your font size or smaller."] = true
L["%s  Justice Cap\
"] = true
L["Smart Group Channel"] = true
L["%s or %s"] = true
L["Sound"] = "Sound" -- Requires localization
L["Sound to play when a message in %s is received.\
\
|cff00ff00To disable set to \"None\"|r."] = "\231\149\182 %s \230\148\182\229\136\176\232\168\138\230\129\175\230\153\130\230\146\165\230\148\190\233\159\179\230\149\136\
\
|cff00ff00\232\166\129\229\129\156\231\148\168\232\171\139\232\168\173\230\136\144 \"\231\132\161\"|r." -- Needs review
L["Spam Delay"] = true
L["Spam Filter"] = "\230\180\151\233\160\187\233\129\142\230\191\190" -- Needs review
L["Spam Interval"] = true
L["Spam interval changed to |cffffff00%d|r"] = true
L["Spam Log"] = "Spam Log" -- Requires localization
L["Spam Mode"] = "\231\129\140\230\176\180\230\168\161\229\188\143"
L["Spam Throttle"] = "\231\129\140\230\176\180\233\150\147\233\154\148"
L[" %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r"] = " %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r" -- Requires localization
L["%s reputation left until %s with %s."] = true
L["%s reputation needed until %s with %s."] = true
L["sretteL esreveR"] = "sretteL esreveR" -- Requires localization
L["%s, %s, %s  Player's Money\
"] = true
L["%s, %s, %s  Player's Stats\
"] = true
L["Standard Emote: |cffffff00%s|r"] = true
L["Standard Emotes"] = true
L["Standing Color"] = "\233\154\142\230\174\181\233\161\143\232\137\178"
L["Start"] = true
L["STARTED"] = true
L["Stop"] = true
L["STOPPED"] = true
L["Strip RealID brackets"] = true
L["Substitutions"] = "Substitutions" -- Requires localization
L["Suppress"] = true
L["Suppress Recount/Skada/TinyDPS output into a clickable link, or filter it entirely."] = true
L["Suppress report message."] = true
L["%s  Valor Cap\
"] = true
L["Symbol: |cffffff00%s|r"] = true
L["Tailoring"] = "\232\163\129\231\184\171"
L["Talk to your group based on party/raid status."] = true
L["Target: |cffffff00%s|r"] = true
L["Target/Mouseover"] = "\231\155\174\230\168\153/\230\187\145\233\188\160\230\140\135\229\144\145" -- Needs review
L["Target's Class"] = "Target's Class" -- Requires localization
L["Target's Gender"] = "Target's Gender" -- Requires localization
L["Target's Health"] = "Target's Health" -- Requires localization
L["Target's Health Deficit"] = "Target's Health Deficit" -- Requires localization
L["Target's Health Percent"] = "Target's Health Percent" -- Requires localization
L["Target's Level"] = "Target's Level" -- Requires localization
L["Target's Mana"] = "Target's Mana" -- Requires localization
L["Target's Mana Deficit"] = "Target's Mana Deficit" -- Requires localization
L["Target's Mana Percent"] = "Target's Mana Percent" -- Requires localization
L["Target's Max Health"] = "Target's Max Health" -- Requires localization
L["Target's Max Mana"] = "Target's Max Mana" -- Requires localization
L["Target's Name"] = "Target's Name" -- Requires localization
L["Tell Target"] = "\229\145\138\232\168\180\231\155\174\230\168\153"
L["Text Justification"] = "\230\150\135\229\173\151\229\176\141\233\189\138" -- Needs review
L["Text justification for ChatFrame %d."] = "\232\129\138\229\164\169\232\166\150\231\170\151 %d \231\154\132\230\150\135\229\173\151\229\176\141\233\189\138\230\150\185\229\188\143."
L["Text to trigger the addon to answer a question."] = "Text to trigger the addon to answer a question." -- Requires localization
L["Thanks for using and supporting my work!  -- |cff9382c9Lockslap|r\
\
|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."] = "Thanks for using and supporting my work!  -- |cff9382c9Lockslap|r\
\
|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge." -- Requires localization
L["The amount of each material you'd like to farm.  If you want an unlimited amount simply put a 0.  You must add a quantity for every entry, and it must correspond to the same line in the other box."] = true
L["The character in front of abbreviations to be recognised as such."] = "The character in front of abbreviations to be recognised as such." -- Requires localization
L["The classic Magic 8-Ball brought to World of Warcraft!"] = "The classic Magic 8-Ball brought to World of Warcraft!" -- Requires localization
L["The color to highlight the search term."] = "The color to highlight the search term." -- Requires localization
L["The color to use when highlighting a substitution."] = "The color to use when highlighting a substitution." -- Requires localization
L["The default color to use to color names."] = true
L["The interval must be a |cff00ff00%s|r between |cff00ff00%d|r and |cff00ff00%d|r."] = true
L["The name or ID of the material you'd like to track.\
\
|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r"] = "The name or ID of the material you'd like to track.\
\
|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r" -- Requires localization
L["The percent chance the module has to bid someone farewell.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = true
L["The percent chance the module has to congratulate someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = true
L["The percent chance the module has to welcome someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = true
L["These are the keywords that the addon will look for first, when it finds a match then it will look for the actual profession being requested."] = true
L["These channels apply to the General tab only."] = "These channels apply to the General tab only." -- Requires localization
L["The size of the icon in the chat frame."] = true
L["The time, in seconds, it takes for the same person to trigger the addon again."] = true
L["The time, in seconds, it takes for the same person to trigger the addon by saying ding."] = true
L["Thick Outline"] = "\229\142\154\230\143\143\233\130\138" -- Needs review
L["This addon is designed to add a lot of the functionality of full fledged chat addons like Prat or Chatter, but without a lot of the unneeded bloat.  I wrote it to be as lightweight as possible, while still powerful enough to accomplish it's intended function.\
"] = true
L["This module is for named channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.\
\
For more information see this addon's Curse page."] = "This module is for named channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.\
\
For more information see this addon's Curse page." -- Requires localization
L["This module is for numbered channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.\
\
For more information see this addon's Curse page."] = "This module is for numbered channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.\
\
For more information see this addon's Curse page." -- Requires localization
L["This module will send a chat message every time you loot an item on your list with how many you have, and if applicable it will tell you how many more you need based on your set quantity.  This is useful if you need X amount of Y to be able to cook Z."] = true
L["This will contain the lines that were filtered by the |cff00ff96%s|r module.  You must have the logging setting enabled in the module's config."] = "This will contain the lines that were filtered by the |cff00ff96%s|r module.  You must have the logging setting enabled in the module's config." -- Requires localization
L["Throttle"] = "Throttle" -- Requires localization
L["Throttle Interval"] = true
L["Throttle Messages"] = true
L["Throttle output messages to prevent spam."] = true
L["Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable."] = "Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable." -- Requires localization
L["Throttle Time"] = "Throttle Time" -- Requires localization
L["Throttle time prevented %s update."] = "Throttle time prevented %s update." -- Requires localization
L["Throttle to only answer a question every X seconds, to prevent spam.\
\
|cffff0000Not recommended to disable this.|r"] = "Throttle to only answer a question every X seconds, to prevent spam.\
\
|cffff0000Not recommended to disable this.|r" -- Requires localization
L["Time"] = "Time" -- Requires localization
L["Time, in seconds, between messages being sent."] = true
L["Time, in seconds, in between running the command."] = true
L["Time, in seconds, the module will wait after the first line is found to assume it is complete.\
\
|cffffff00One (1) second seems to work.|r"] = true
L["Time, in seconds, to run the clean up to keep your ignore list clean."] = "Time, in seconds, to run the clean up to keep your ignore list clean." -- Requires localization
L["Time, in seconds, to throttle output messages to prevent spam."] = true
L["Time, in seconds, to throttle the zone list to prevent any spam."] = "Time, in seconds, to throttle the zone list to prevent any spam." -- Requires localization
L["Time, in seconds, you want the search to continue before it ends."] = "Time, in seconds, you want the search to continue before it ends." -- Requires localization
L["Timer is currently running, you must stop it first before changing the interval."] = true
L["Timestamp color"] = "\230\153\130\233\150\147\230\136\179\232\168\152\233\161\143\232\137\178"
L["Timestamp format"] = "\230\153\130\233\150\147\230\136\179\232\168\152\230\160\188\229\188\143"
L["Timestamps"] = "\230\153\130\233\150\147\230\136\179\232\168\152"
L["TOC Version: |cff1784d1%s|r"] = "TOC \231\137\136\230\156\172: |cff1784d1%s|r"
L["Toggle coloring and change of the chat frame for pet combat log messages."] = "\233\150\139\229\149\159\228\184\138\232\137\178\228\184\166\228\184\148\229\136\135\230\143\155\229\176\141\232\169\177\232\166\150\231\170\151\232\135\179\229\175\181\231\137\169\230\136\176\233\172\165\231\180\128\233\140\132."
L["Toggle coloring and changing of the chat frame for pet battle info messages."] = "\233\150\139\229\149\159\228\184\138\232\137\178\228\184\166\228\184\148\229\136\135\230\143\155\229\176\141\232\169\177\232\166\150\231\170\151\232\135\179\229\175\181\231\137\169\229\176\141\230\136\176\232\168\138\230\129\175."
L["Toggle logging any actions taken to the Spam Log module."] = "Toggle logging any actions taken to the Spam Log module." -- Requires localization
L["Toggle logging anything found to the Spam Log module."] = "Toggle logging anything found to the Spam Log module." -- Requires localization
L["Toggle the monitoring of chat events."] = "Toggle the monitoring of chat events." -- Requires localization
L["Toggle the pet list message when you enter a different zone."] = "Toggle the pet list message when you enter a different zone." -- Requires localization
L["Toggle the pet quality notifications when you join a wild pet battle."] = "\231\149\182\228\189\160\233\128\178\232\161\140\233\135\142\229\164\150\229\175\181\231\137\169\229\176\141\230\136\176\230\153\130\230\143\144\231\164\186\229\176\141\233\157\162\229\175\181\231\137\169\229\147\129\232\179\170."
L["Tooltip"] = "Tooltip" -- Requires localization
L["Total Modules"] = "Total Modules" -- Requires localization
L["Track Pets"] = "\232\191\189\232\185\164\229\175\181\231\137\169"
L["Track Stable Masters"] = "\232\191\189\232\185\164\230\136\176\229\175\181\229\164\167\229\184\171"
L["Trade"] = "\228\186\164\230\152\147\233\160\187\233\129\147"
L["Trigger"] = "Trigger" -- Requires localization
L["Triggers"] = "\232\167\184\231\153\188\229\153\168" -- Needs review
L["/tt"] = true
L["Turns the timestamps into a link.\
\
Click the link to copy the chat line.\
Shift+Click the link to send the line to the last chat you used."] = "Turns the timestamps into a link.\
\
Click the link to copy the chat line.\
Shift+Click the link to send the line to the last chat you used." -- Requires localization
L["Unable to load the Alt Name module, please try again."] = "Unable to load the Alt Name module, please try again." -- Requires localization
L["Unbalanced parameter count. Trailing Symbol: |cffffff00%s|r"] = true
L["% Unowned"] = "% Unowned" -- Requires localization
L["Unowned Only"] = "Unowned Only" -- Requires localization
L["Unrecognized Symbol: |cffffff00%s|r"] = "\231\132\161\230\179\149\232\190\168\232\170\141\231\154\132\231\172\166\232\153\159: |cffffff00%s|r"
L["Unset variable |cffffff00%s|r."] = "\230\156\170\232\168\173\229\174\154\229\190\151\232\174\138\230\149\184 |cffffff00%s|r."
L["Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement."] = "Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement." -- Requires localization
L["Uppercase"] = "Uppercase" -- Requires localization
L["Use channel color"] = "\228\189\191\231\148\168\233\160\187\233\129\147\233\161\143\232\137\178"
L["Use Channel Color"] = "\228\189\191\231\148\168\233\160\187\233\129\147\233\161\143\232\137\178"
L["Use Coins"] = "\228\189\191\231\148\168\231\161\172\229\185\163\229\156\150\231\164\186"
L["Use coins in the answers instead of abbreviations."] = "\231\173\148\230\161\136\228\189\191\231\148\168\231\161\172\229\185\163\229\156\150\231\164\186\230\155\191\228\187\163\231\184\174\229\175\171."
L["Use Custom Color"] = "\228\189\191\231\148\168\232\135\170\232\168\130\233\161\143\232\137\178"
L["Use guildnotes"] = "\228\189\191\231\148\168\229\133\172\230\156\131\232\168\187\232\168\152"
L["Use Level Threshold"] = "\228\189\191\231\148\168\231\173\137\231\180\154\233\150\128\230\170\187"
L["Use Master Channel"] = "Use Master Channel" -- Requires localization
L["Use PlayerNames Coloring"] = "\228\189\191\231\148\168\232\167\146\232\137\178\229\144\141\231\168\177\228\184\138\232\137\178"
L["Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon."] = "Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon." -- Requires localization
L["Use Short Name"] = "Use Short Name" -- Requires localization
L["Use Tab Complete"] = "\228\189\191\231\148\168\232\135\170\229\139\149\229\174\140\230\136\144"
L["Use tab key to automatically complete character names."] = "\228\189\191\231\148\168 tab \230\140\137\233\136\149\232\135\170\229\139\149\229\174\140\230\136\144\232\167\146\232\137\178\229\167\147\229\144\141."
L["Use the master channel when playing the sound."] = "Use the master channel when playing the sound." -- Requires localization
L["Valid Events"] = "\230\156\137\230\149\136\228\186\139\228\187\182"
L["valor"] = true
L["  Valor Points\
"] = "  \229\139\135\230\176\163\233\187\158\230\149\184\
"
L["Valor Points"] = "Valor Points" -- Requires localization
L["Variable |cffffff00%s|r is set to |cff00ff00%s|r."] = "Variable |cffffff00%s|r is set to |cff00ff00%s|r." -- Requires localization
L["Variable |cffffff00%s|r set to |cff00ff00%s|r."] = "Variable |cffffff00%s|r set to |cff00ff00%s|r." -- Requires localization
L["Various Developer Tools"] = "Various Developer Tools" -- Requires localization
L["Version"] = "Version" -- Requires localization
L["Version: |cff1784d1%s|r"] = "\231\137\136\230\156\172: |cff1784d1%s|r"
L["Version %s%s|r is loaded. Type %s/ct|r if you need help."] = "Version %s%s|r is loaded. Type %s/ct|r if you need help." -- Requires localization
L["Very doubtful."] = "Very doubtful." -- Requires localization
L["vp"] = true
L["vpcap"] = true
L["Warlock"] = "\232\161\147\229\163\171" -- Needs review
L["WARLOCK"] = "WARLOCK" -- Requires localization
L["Warrior"] = "\230\136\176\229\163\171" -- Needs review
L["WARRIOR"] = "WARRIOR" -- Requires localization
L["Welcome Message"] = true
L["Welcome Messages"] = "\230\173\161\232\191\142\232\168\138\230\129\175" -- Needs review
L["What to do with Recount/Skada/TinyDPS reports in this channel."] = "\229\166\130\228\189\149\229\176\135Recount/Skada/TinyDPS\230\136\176\233\172\165\232\168\138\230\129\175\232\178\188\232\135\179\230\173\164\233\160\187\233\129\147" -- Needs review
L["What to show on the datatext."] = "What to show on the datatext." -- Requires localization
L["When an ElvUI keyword is found it will show the message in a popup frame."] = "When an ElvUI keyword is found it will show the message in a popup frame." -- Requires localization
L["    When I first started using ElvUI around the beginning of Cataclysm's release I noticed that there were some chat functionality that I wanted, but wasn't included with ElvUI.  I came across Prat and Chatter, but found that they had too many modules that I didn't want and both addons do use a fair bit of memory.  So I decided to write my own version, which is when ElvUI_ChatTweaks was born.  Since then I have made sure that this addon is as bug free as possible, as well as being up to date with the latest API available, and I am constantly adding new functionality.  If there's any features you'd like to see added please contact me and I'll see what I can do.\
\
Thanks,\
|cffffff00Lockslap|r"] = "    When I first started using ElvUI around the beginning of Cataclysm's release I noticed that there were some chat functionality that I wanted, but wasn't included with ElvUI.  I came across Prat and Chatter, but found that they had too many modules that I didn't want and both addons do use a fair bit of memory.  So I decided to write my own version, which is when ElvUI_ChatTweaks was born.  Since then I have made sure that this addon is as bug free as possible, as well as being up to date with the latest API available, and I am constantly adding new functionality.  If there's any features you'd like to see added please contact me and I'll see what I can do.\
\
Thanks,\
|cffffff00Lockslap|r" -- Requires localization
L["When setting a variable the variable name must be the first parameter."] = "\232\168\173\229\174\154\229\143\131\230\149\184\230\153\130\229\143\131\230\149\184\229\144\141\229\191\133\233\160\136\231\130\186\231\172\172\228\184\128\229\128\139\232\174\138\230\149\184."
L["Whisper"] = "\229\175\134\232\170\158"
L["Whisper Answer"] = "Whisper Answer" -- Requires localization
L["Whisper Filter"] = "\229\175\134\232\170\158\233\129\142\230\191\190" -- Needs review
L["Whisper Messages"] = "\229\175\134\232\170\158\232\168\138\230\129\175"
L["Whisper Options"] = "\229\175\134\232\170\158\233\129\184\233\160\133"
L["Whispers"] = "\229\175\134\232\170\158\232\128\133" -- Needs review
L["Whisper the response to the person.  Otherwise it will be answered in the same channel the request was sent."] = "Whisper the response to the person.  Otherwise it will be answered in the same channel the request was sent." -- Requires localization
L["Who"] = "Who" -- Requires localization
L["Who: |cffffff00%s|r, Roll: |cffffff00%s|r, Min: |cffffff00%s|r, Max: |cffffff00%s|r"] = "\232\170\176: |cffffff00%s|r, \233\170\176\229\135\186: |cffffff00%s|r, \230\156\128\229\176\143: |cffffff00%s|r, \230\156\128\229\164\167: |cffffff00%s|r"
L["Who is %s's main?"] = "Who is %s's main?" -- Requires localization
L["Who to Congratulate?"] = "Who to Congratulate?" -- Requires localization
L["Will automatically set your role based on your spec, when appropriate."] = "Will automatically set your role based on your spec, when appropriate." -- Requires localization
L["Will save all data for large /who queries"] = true
L["Win Color"] = "\229\139\157\229\136\169\233\161\143\232\137\178"
L["Without a doubt."] = "Without a doubt." -- Requires localization
L["Words or phrases that will trigger the filtering."] = "\230\156\131\232\167\184\231\153\188\233\129\142\230\191\190\231\154\132\229\173\151\229\133\131\230\136\150\229\173\151\228\184\178."
L["XP Left To Level"] = "\229\137\169\233\164\152\231\182\147\233\169\151\229\128\188"
L["Year"] = "Year" -- Requires localization
L["Yell"] = "\229\164\167\229\150\138" -- Needs review
L["Yell Chat"] = true
L["Yes"] = "Yes" -- Requires localization
L["Yes, definitely."] = "Yes, definitely." -- Requires localization
L["You are missing %s%d|r pets."] = "You are missing %s%d|r pets." -- Requires localization
L["You are running version |cff1784d1%s|r."] = "\228\189\160\230\173\163\229\156\168\228\189\191\231\148\168\231\137\136\230\156\172 |cff1784d1%s|r." -- Needs review
L["You asked: %s"] = "You asked: %s" -- Requires localization
L["You can only send a request once every %d seconds.  You last sent a request at %s."] = "\228\189\160\230\175\143 %d \231\167\146\230\137\141\232\131\189\233\128\129\229\135\186\228\184\128\229\128\139\232\168\138\230\129\175. \228\189\160\230\156\128\229\190\140\228\184\128\230\172\161\233\128\129\229\135\186\232\168\138\230\129\175\230\152\175\229\156\168 %s." -- Needs review
L["You have |cff9382c9Chatter|r running, which is incompatible with this addon.  Please disable it."] = "You have |cff9382c9Chatter|r running, which is incompatible with this addon.  Please disable it." -- Requires localization
L["You have |cff9382c9Prat-3.0|r running, which is incompatible with this addon.  Please disable it."] = "You have |cff9382c9Prat-3.0|r running, which is incompatible with this addon.  Please disable it." -- Requires localization
L["You have |cff%s%d|r of %s."] = "\228\189\160\230\156\137 |cff%s%d|r \229\128\139 %s." -- Needs review
L["You have |cff%s%d|r of %s, you need |cff%s%d|r more. |cff%s(%d/%d)|r"] = "\228\189\160\230\156\137 |cff%s%d|r \229\128\139 %s, \228\189\160\233\130\132\233\156\128\232\166\129 |cff%s%d|r \229\128\139. |cff%s(%d/%d)|r" -- Needs review
L["You have met your quota of %s%s. |cff%s(%d/%d)|r"] = "%s%s\228\189\160\229\183\178\231\182\147\233\129\148\229\136\176\228\189\160\230\131\179\232\166\129\231\154\132\230\149\184\233\135\143. |cff%s(%d/%d)|r" -- Needs review
L["You have reached the maximum number of friends, please remove 2 for this module to function properly."] = "You have reached the maximum number of friends, please remove 2 for this module to function properly." -- Requires localization
L["You have %s%d (%d unique, %d duplicates)|r pets."] = "You have %s%d (%d unique, %d duplicates)|r pets." -- Requires localization
L["You have %s%d|r duplicate pets."] = "You have %s%d|r duplicate pets." -- Requires localization
L["You have %s%d|r mounts."] = "You have %s%d|r mounts." -- Requires localization
L["You have %s%d|r unique pets."] = "You have %s%d|r unique pets." -- Requires localization
L["You may rely on it."] = "You may rely on it." -- Requires localization
L["You must provide a calculation or set a variable."] = "\228\189\160\229\191\133\233\160\136\232\188\184\229\133\165\228\184\128\229\128\139\231\174\151\229\188\143\230\136\150\232\128\133\228\184\128\231\181\132\232\174\138\230\149\184."
L["You must wait ~7 seconds between reports to avoid being disconnected."] = "You must wait ~7 seconds between reports to avoid being disconnected." -- Requires localization
L["You need %s%s%s%sto hit level %d."] = "\228\189\160\233\156\128\232\166\129 %s%s%s%s\228\190\134\230\147\138\228\184\173\231\173\137\231\180\154 %d." -- Needs review
L["Your Color"] = "\228\189\160\231\154\132\233\161\143\232\137\178"
L["Your Version: |cffffff00%d|r, Latest Version: |cffffff00%d|r"] = "\228\189\160\231\154\132\231\137\136\230\156\172: |cffffff00%d|r, \230\156\128\230\150\176\231\137\136\230\156\172: |cffffff00%d|r" -- Needs review
L["Your version of %s is out of date.  Latest version is |cff1784d1%d|r."] = "\228\189\160\228\189\191\231\148\168\231\154\132\231\137\136\230\156\172 %s \229\183\178\231\182\147\233\129\142\230\156\159.  \230\156\128\230\150\176\231\137\136\230\156\172\230\152\175 |cff1784d1%d|r."
L["Zone List"] = "Zone List" -- Requires localization

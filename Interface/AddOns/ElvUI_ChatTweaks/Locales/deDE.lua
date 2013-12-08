-------------------------------------------------------------------------------
-- ElvUI_ChatTweaks By Lockslap (US, Bleeding Hollow)
-------------------------------------------------------------------------------
local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI_ChatTweaks", "deDE", false)
if not L then return end

L["Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN."] = "Abbreviate your favourites to save typing. Format is short1:long1, short2:long2, ... shortN:longN." -- Requires localization
L["Abbreviations"] = "Abk\195\188rzungen" -- Needs review
L["About"] = "\195\156ber" -- Needs review
L["achieve"] = "erreichen"
L["Achievement Filter"] = "Erfolgsfilter"
L["Achievement Messages"] = "Erfolgs Nachrichten"
L["  Achievement Points\
"] = "  Erfolgspunkte\
" -- Needs review
L["Action to take when an icon is found."] = "Aktion ausf\195\188hren wenn Symbol gefunden wird." -- Needs review
L["Active Modules"] = "Aktive Module" -- Needs review
L["Add an |cff00ff00/emotes|r command to see what custom emotes you currently have running."] = "F\195\188ge einen |cff00ff00/emotes|r Befehl hinzu um zu sehen, welche Emotes Du derzeit benutzt."
L["Add |cff00ff00/emotes|r Command"] = "F\195\188gt einen |cff00ff00/emotes|r Befehl hinzu."
L["Add custom emotes.  Please remember that your character's name will always be the first word.\
\
|cff00ff00%t|r is your current target."] = "F\195\188gt Benutzer-Emotes hinzu. Bitte dran denken, dass der Charaktername immer das erste Wort ist.\
\
|cff00ff00%t|r ist dein aktuelles Ziel." -- Needs review
L["Added log entry from %s%s|r to %s%s|r log."] = "Added log entry from %s%s|r to %s%s|r log." -- Requires localization
L["Add Group Trigger"] = "Gruppen Ausl\195\182ser hinzuf\195\188gen" -- Needs review
L["Add Guild Trigger"] = "Gilden Ausl\195\182ser hinzuf\195\188gen" -- Needs review
L["Add item icons to loot received messages."] = "Add item icons to loot received messages." -- Requires localization
L["Addon Messages"] = "Addon Nachrichten" -- Needs review
L["Addon Version Sent, Version: |cffffff00%s|r"] = "Addon Version wurde gesendet, die Version lautet: |cffffff00%s|r" -- Needs review
L["Add Percentage"] = "Add Percentage" -- Requires localization
L["Adds a minimap button.\
\
|cffffff00To disable the button, simply disable this module.|r"] = "F\195\188gt Minimap-Button hinzu." -- Needs review
L["Adds an ElvUI datatext for this addon."] = "Adds an ElvUI datatext for this addon." -- Requires localization
L["Adds a timestamp to each line of text."] = "F\195\188gt einen Zeitstempel zu jeder Textzeile hinzu."
L["Adds chat commands |cff1784d1/chatframes|r and |cff1784d1/cf|r to help you identify the chat frames and their numbers."] = "Adds chat commands |cff1784d1/chatframes|r and |cff1784d1/cf|r to help you identify the chat frames and their numbers." -- Requires localization
L["Adds chat commands to clear the chat windows.\
\
"] = "F\195\188gt Chat-Kommandos zum Leeren der Chatfenster hinzu."
L["Adds item links to Auction House messages.  Enabling this module will automatically disable the Auction Message Filter module.\
\
|cffff0000If you do not have the item in your bags at the time of the system message firing then this will not be able to get the item link.  This is a limitation of the|r |cffffff00GetItemInfo()|r |cffff0000API function.  If this occurs, then the module will simple pass through the default message.|r"] = "Adds item links to Auction House messages.  Enabling this module will automatically disable the Auction Message Filter module.\
\
|cffff0000If you do not have the item in your bags at the time of the system message firing then this will not be able to get the item link.  This is a limitation of the|r |cffffff00GetItemInfo()|r |cffff0000API function.  If this occurs, then the module will simple pass through the default message.|r" -- Requires localization
L["Adds tell target slash command, |cff00ff00/tt|r."] = "F\195\188gt einen \"Das Ziel anfl\195\188stern\"-Befehl |cff00ff00/tt|r hinzu." -- Needs review
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
L["Add surrounding brackets to own charname in messages."] = "Den eigenen Charakternamen in Nachrichten in Klammern setzen."
L["Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it."] = "Add the percentage of owned or unowned to total pets for a zone to the list, or you can choose to disable it." -- Requires localization
L["Add the player's alts to the tooltip."] = "Add the player's alts to the tooltip." -- Requires localization
L["Add the player's main to the tooltip."] = "Add the player's main to the tooltip." -- Requires localization
L["Add word to your group invite trigger list"] = "Add word to your group invite trigger list" -- Requires localization
L["Add word to your guild invite trigger list."] = "Add word to your guild invite trigger list." -- Requires localization
L["AFK"] = true
L["AFK/DND Filter"] = true
L["AFK Messages"] = "AFK Nachrichten" -- Needs review
L["After"] = "Danach"
L["Alchemy"] = "Alchemie"
L["All"] = "Alle"
L["All Modules"] = "Alle Module" -- Needs review
L["Allow Mobile Users"] = "Allow Mobile Users" -- Requires localization
L["Allow someone to request a link of all your professions."] = "Erlaubt anderen, dir eine Anfrage f\195\188r die Verlinkung von all deinen Berufen zu schicken." -- Needs review
L["Allows you to block chat channel invites and ignore the person who sent them.  Useful for preventing spam."] = "Allows you to block chat channel invites and ignore the person who sent them.  Useful for preventing spam." -- Requires localization
L["Allows you to change the default font settings for the chat frames.\
\
|cffff0000Using another addon to do this will break this functionality.|r"] = "Erlaubt eine \195\132nderung des vorgegebenen Zeichensatzes f\195\188r Chatfenster.\
\
|cffff0000Die Nutzung eines anderen AddOns mit selbem Effekt, wird zu einem Fehler f\195\188hren.|r"
L["Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command."] = "Allows you to check the status of the A Test of Valor quest given by Wrathion for the legendary gems by using the |cff00ff96/tov|r chat command." -- Requires localization
L["Allows you to color the pet battle info messages, and determine which chat frame to send them to.\
\
I am aware that some of the features of this module don't really pertain to the chat, but I couldn't really justify an entirely new addon.  So I just snuck them into here."] = "Allows you to color the pet battle info messages, and determine which chat frame to send them to.\
\
I am aware that some of the features of this module don't really pertain to the chat, but I couldn't really justify an entirely new addon.  So I just snuck them into here." -- Requires localization
L["Allows you to reroute auction house messages to a different chat frame."] = "Erlaubt es dir, Auktionshaus-Nachrichten in ein anderes Chatfenster umzuleiten." -- Needs review
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
L["All spam logs were cleared."] = "Alle Spam Protokolle wurden geleert." -- Needs review
L["alt2"] = true
L["alt3"] = true
L["Alt-click name to invite"] = "Alt-Klick auf den Namen zum Einladen"
L["Alternate command to kick someone from guild."] = "Alternatives Kommando um jemanden aus der Gilde zu entfernen."
L["AlTeRnAtInG CaPs"] = "AlTeRnAtInG CaPs" -- Requires localization
L["Alt Names"] = "Twink Namen" -- Needs review
L["Alt note fallback"] = "Alt note fallback" -- Requires localization
L["and"] = "and" -- Requires localization
L["ap"] = "AP" -- Needs review
L["Are you sure you want to delete all your saved class/level data?"] = "Bist du sicher, dass du alle gespeicherten Klassen-/Stufendaten l\195\182schen m\195\182chtest?"
L["Are you sure you want to disable all of the modules?"] = "Bist Du sicher, dass Du alle Module deaktivieren m\195\182chtest?" -- Needs review
L["Are you sure you want to enable all of the modules?"] = "Bist Du sicher, dass Du alle Module aktivieren m\195\182chtest?" -- Needs review
L["Are you sure you want to reset the chat fonts to defaults?"] = "Bist du sicher, dass du die Chat-Schriftart zur\195\188ck auf den Standard setzen m\195\182chtest?"
L["A simple calculator used to perform basic operations on gold values.  Providing no parameters will show you how much gold you have.\
\
You can include your current gold amount by using the |cff00ff00mymoney|r keyword.  For example |cff00ff00mymoney * 2|r.\
\
|cffff0000Money amounts can only be added or subtracted, multiplication or division can only be performed with money and a number.  For example:  4g * 4 is okay, where 4g * 4g is invalid."] = "A simple calculator used to perform basic operations on gold values.  Providing no parameters will show you how much gold you have.\
\
You can include your current gold amount by using the |cff00ff00mymoney|r keyword.  For example |cff00ff00mymoney * 2|r.\
\
|cffff0000Money amounts can only be added or subtracted, multiplication or division can only be performed with money and a number.  For example:  4g * 4 is okay, where 4g * 4g is invalid." -- Requires localization
L["A simple command-line calculator.  Certain keywords, listed below, can be used and their in game value will be substituted.  You can also assign variables which are saved for later use.\
\
|cffffff00Keywords:|r\
"] = "A simple command-line calculator.  Certain keywords, listed below, can be used and their in game value will be substituted.  You can also assign variables which are saved for later use.\
\
|cffffff00Keywords:|r\
" -- Requires localization
L["A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears."] = "A simple module to add the |cff00ff96/release|r command to release your spirit if your popup window disappears." -- Requires localization
L["A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r."] = "A simple module to shorten the |cff00ff96/readycheck|r command to |cff00ff96/rc|r." -- Requires localization
L["As I see it, yes."] = "So wie ich es sehe, ja." -- Needs review
L["Ask again later."] = "Sp\195\164ter nochmal fragen." -- Needs review
L["A Test of Valor"] = "A Test of Valor" -- Requires localization
L["Auction Created"] = "Auction Created" -- Requires localization
L["Auction Expired"] = "Auktion abgelaufen"
L["Auction Message Filtering"] = "Auktionsnachrichten filtern"
L["Auction Message Types"] = "Auktionsnachrichten-Typen" -- Needs review
L["Auction Outbid"] = "Auktion \195\156berboten"
L["Auction Removed"] = "Auktion Entfernt"
L["Auction Sold"] = "Auktion Verkauft"
L["Auction Won"] = "Auktion gewonnen"
L["Auto Congratulate"] = "Auto Gratulieren"
L["Auto Ding"] = "Auto \"ding\""
L["Auto Farewell"] = "Automatischer Abschied"
L["Automatically bid someone farewell when they leave your guild."] = "Automatisch allen, die die Gilde verlassen, alles Gute w\195\188nschen." -- Needs review
L["Automatically congratulate someone when they, or others, complete an achievement."] = "Automatisch gratulieren, wenn jemand einen Erfolg abschlie\195\159t."
L["Automatically congratulates someone when they say \"ding\" in chat."] = "Automatisch gratulieren, wenn jemand \"ding\" im Chat schreibt."
L["Automatically decline any channel invites."] = "Automatically decline any channel invites." -- Requires localization
L["Automatically enables chat logging."] = "Aktiviert die automatische Chataufzeichnung."
L["Automatically enable tracking of pets for battles."] = "Automatically enable tracking of pets for battles." -- Requires localization
L["Automatically enable tracking of Stable Masters to help you revive and/or heal your pets."] = "Automatically enable tracking of Stable Masters to help you revive and/or heal your pets." -- Requires localization
L["Automatically link someone the profession they requested via various keywords."] = "Automatisch jemanden den Beruf verlinken, welcher \195\188ber verschiedene Schl\195\188sselw\195\182rter angfragt worden ist." -- Needs review
L["Automatically Remove Item When Finished"] = "Item automatisch nach der Beendigung l\195\182schen" -- Needs review
L["Automatically welcomes someone to your guild."] = "Neue Gildenmitglieder automatisch willkommen hei\195\159en."
L["Automatic Chat Logging"] = "automatische Chat-Aufzeichnung"
L["Auto Profession Link"] = "Automatisch Berufe verlinken" -- Needs review
L["Auto Set Role"] = "Auto Set Role" -- Requires localization
L["Auto Welcome"] = "Auto Willkommen" -- Needs review
L["Available Chat Command Arguments"] = "Verf\195\188gbare Chat-Kommando Argumente"
L["Available parameters are |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r."] = "Verf\195\188gbare Parameter sind |cff1784d1version|r, |cff1784d1build|r, |cff1784d1date|r, |cff1784d1interface|r, |cff1784d1locale|r." -- Needs review
L["Battle.Net Convo"] = "Battle.Net Convo" -- Requires localization
L["Battle.net invite from %s%s|r blocked!"] = "Battle.net invite from %s%s|r blocked!" -- Requires localization
L["Battle.Net Options"] = "Battle.Net Einstellungen"
L["Battle.net Spam"] = "Battle.net Spam" -- Requires localization
L["Battle.Net Whisper"] = "Battle.Net Whisper" -- Requires localization
L["Before"] = "Davor"
L["Below are the keywords that the module will look for to substitute with the values described below."] = "Below are the keywords that the module will look for to substitute with the values described below." -- Requires localization
L["BeTTeR ALTeRNaTiNG CaPS"] = "BeTTeR ALTeRNaTiNG CaPS" -- Requires localization
L["Better not tell you now."] = "Besser dir jetzt nicht mittteilen." -- Needs review
L["Bid Accepted"] = "Gebot akzeptiert"
L["Blacksmithing"] = "Juwelenschleifen"
L["Blocked Whisper from %s"] = "Geblockte Fl\195\188sternachrichten von %s" -- Needs review
L["Blocks Battle.net friend requests from spammers."] = "Blocks Battle.net friend requests from spammers." -- Requires localization
L["Build: |cff1784d1%s|r"] = true
L["Build Date: |cff1784d1%s|r"] = "Build Datum: |cff1784d1%s|r"
L["Busy"] = "Besch\195\164ftigt"
L["Calculator"] = "Taschenrechner" -- Needs review
L["Cannot predict now."] = "Kann ich nicht voraussagen." -- Needs review
L["Can't set value '%s', doesn't look like a number."] = "Kann den Wert '%s' nicht setzen, da es nicht nach einer Zahl aussieht." -- Needs review
L["Capitalize Words"] = "Capitalize Words" -- Requires localization
L["Capture Delay"] = "Capture Delay" -- Requires localization
L["Center"] = "Mitte"
L["   |cff00ff00/ct %s|r or |cff00ff00%s|r - %s"] = "   |cff00ff00/ct %s|r or |cff00ff00%s|r - %s" -- Requires localization
L["   |cff00ff00/ct %s|r - %s"] = true
L["|cff00ff00%d|r Custom %s Being Used"] = "|cff00ff00%d|r Custom %s Being Used" -- Requires localization
L["|cff00ff00Enabled|r"] = "|cff00ff00Aktiviert|r"
L["|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r"] = "|cff00ff00Keybind options are solely handled by the Keybinding interface provided by WoW itself.|r" -- Requires localization
L["|cff00ff00%s|r"] = "|cff00ff00%s|r" -- Requires localization
L["|cff00ff00%s|r or |cff00ff00%s|r %s"] = "|cff00ff00%s|r oder |cff00ff00%s|r %s"
L["   |cff00ff00%s|r or |cff00ff00%s|r - %s"] = "   |cff00ff00%s|r oder |cff00ff00%s|r - %s"
L["   |cff00ff00%s|r - %s"] = true
L["|cFF5cb4f8Pet Battle - Tale of the Tape|r"] = "|cFF5cb4f8Pet Battle - Tale of the Tape|r" -- Requires localization
L["|cffc7c7cfs|r"] = "|cffc7c7cfs|r" -- Requires localization
L["|cFFccff00Not Owned|r"] = "|cFFccff00Not Owned|r" -- Requires localization
L["|cffeda55fc|r"] = "|cffeda55fc|r" -- Requires localization
L["|cfffe2ec8|Hectfilter:%s:%d:%d:%s|h[Report Spam Message!]|h|r"] = "|cfffe2ec8|Hectfilter:%s:%d:%d:%s|h[Report Spam Message!]|h|r" -- Requires localization
L["|cffff0000Disabled|r"] = "|cffff0000Deaktiviert|r"
L["|cffff0000Item|r |cffffffff\"%s\"|r |cffff0000does not exist.|r"] = "|cffff0000Item|r |cffffffff\"%s\"|r |cffff0000existiert nicht.|r" -- Needs review
L["|cffff0000No modules found.|r"] = "|cffff0000Es wurden keine Module gefunden.|r"
L["\
\
|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level."] = "\
\
|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level." -- Requires localization
L["\
\
|cffff0000NOTE:|r  If this addon starts to use a substantial amount of memory, simply reset the name data and it will return to a normal level.\
\
Addon Usage: |cff00ff00%s|r"] = "|cffff0000NOTE:|r  Wenn dieses Addon anf\195\164ngt eine erhebliche Menge an Speicher zu verbrauchen, einfach die Namensdaten zur\195\188cksetzen und es wird auf ein normales Niveau zur\195\188ckkehren.\
\
Addon Verbrauch: |cff00ff00%s|r" -- Needs review
L["|cffff0000The Chat Frame you chose to output reputation changes,|r |cffffffff%s|r|cffff0000, does not exist."] = "|cffff0000The Chat Frame you chose to output reputation changes,|r |cffffffff%s|r|cffff0000, does not exist." -- Requires localization
L[" |cFFff5a00(Upgrade)|r"] = " |cFFff5a00(Upgrade)|r" -- Requires localization
L["|cffff9000Not in Pet Journal|r"] = "|cffff9000Not in Pet Journal|r" -- Requires localization
L["|cffff9000Pet Journal:|r %s"] = "|cffff9000Pet Journal:|r %s" -- Requires localization
L["|cffffc080Alts:|r %s"] = "|cffffc080Alts:|r %s" -- Requires localization
L["|cffffd700g|r"] = "|cffffd700g|r" -- Requires localization
L["|cffffff00Character already in a guild."] = "|cffffff00Der Charakter befindet sich bereits in einer Gilde."
L["|cffffff00Character already in your guild."] = "|cffffff00Der Charakter befindet sich bereits in deiner Gilde."
L[" |cffffff00%d|r Total Modules (|cff00ff00%d|r Enabled, |cffff0000%d|r Disabled)"] = " |cffffff00%d|r Anzahl der Module (|cff00ff00%d|rAktiviert, |cffff0000%d|r Deaktiviert)"
L["|cffffff00One of your addons is breaking critical chat data I need to work properly :(|r"] = "|cffffff00One of your addons is breaking critical chat data I need to work properly :(|r" -- Requires localization
L["|cffffff00This abbreviation is unknown."] = "|cffffff00This abbreviation is unknown." -- Requires localization
L["|cffffff00Unable to execute secure command.|r |cffffffff%s|r"] = "|cffffff00Kann sicheren Befehl nicht ausf\195\188hren.|r |cffffffff%s|r" -- Needs review
L["|cffffff00Usage: /ccolor <class>|r"] = "|cffffff00Usage: /ccolor <class>|r" -- Requires localization
L["|cffffff00Usage: /ginvite <name>|r"] = "|cffffff00Verwendung: /ginvite <name>|r"
L["|cffffff00Usage: /gkick <name>|r"] = true
L["|cffffff00Usage: /hextorgb <hex code>|r"] = "|cffffff00Usage: /hextorgb <hex code>|r" -- Requires localization
L["|cffffff00Usage: /in <delay> <command>|r"] = "|cffffff00Verwendung: /in <Verz\195\182gerung> <Befehl>|r" -- Needs review
L["|cffffff00Usage: /rgbtohex <red> <green> <blue>|r"] = "|cffffff00Usage: /rgbtohex <red> <green> <blue>|r" -- Requires localization
L["|cffffff00Usage: /rpt <times> <command>|r"] = "|cffffff00Verwendung: /rpt <Zeit> <Befehl>|r" -- Needs review
L["|cffffffffYou have %s.|r"] = "|cffffffffYou have %s.|r" -- Requires localization
L["|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s"] = "|cff%sHex:|r %s, |cffff0000Red:|r %s, |cff00ff00Green:|r %s, |cff0000ffBlue:|r %s" -- Requires localization
L["Changed Channel"] = "Changed Channel" -- Requires localization
L["Channel"] = true -- Needs review
L["Channel Colors"] = "Kanal Farben"
L["Channel %d"] = true -- Needs review
L["Channel Invite Spam"] = "Channel Invite Spam" -- Requires localization
L["Channel Notice Filter"] = "Channel Notice Filter" -- Requires localization
L["Channels"] = true -- Needs review
L["Channel Sounds"] = "Kanal-Sounds"
L["Channels to Filter"] = "Channels to Filter" -- Requires localization
L["Channels to look for questions."] = "Kan\195\164le in welchen nach Anfragen geschaut werden soll." -- Needs review
L["Channels to Monitor"] = "Zu beobachtende Kan\195\164le" -- Needs review
L["Channels to Watch"] = "Channels to Watch" -- Requires localization
L["Channel to send the reminder to."] = "Channel in welchem Erinnerung geschickt werden soll." -- Needs review
L["Character to use between the name and level"] = "Zeichen, welches zwischen Name und Stufe genutzt werden soll"
L["Character to use for the left bracket"] = "Zeichen, welches als linke Klammer genutzt werden soll"
L["Character to use for the right bracket"] = "Zeichen, welches als rechte Klammer genutzt werden soll"
L["Chat"] = true
L["Chat Events"] = "Chat Ereignisse" -- Needs review
L["Chat Fonts"] = "Chat-Schriftarten"
L["Chat Frame"] = "Chat Fenster" -- Needs review
L["Chat Frame "] = "Chat-Fenster"
L["Chat Frame %d"] = true -- Needs review
L["ChatFrame %d"] = "Chatfenster %d"
L["Chat Frame Settings"] = "Chatfenster Einstellungen"
L["Chat Frames To Watch"] = "Chat Frames To Watch" -- Requires localization
L["Chat frame to output the messages.  Default is ChatFrame3, which is the default output frame for reputation messages in ElvUI."] = "Chat frame to output the messages.  Default is ChatFrame3, which is the default output frame for reputation messages in ElvUI." -- Requires localization
L["Chat frame to output the message to.  Default is |cffffff00ChatFrame3|r, which is the default frame for ElvUI XP messages."] = "Chat frame to output the message to.  Default is |cffffff00ChatFrame3|r, which is the default frame for ElvUI XP messages." -- Requires localization
L["Chat frame to route the auction house messages to."] = "Chat frame to route the auction house messages to." -- Requires localization
L["Chat frame to route the messages to."] = "Chat frame to route the messages to." -- Requires localization
L["Chat frame to send the list to."] = "Chat frame to send the list to." -- Requires localization
L["Chat frame to send the messages to."] = "Chatfenster an welches Nachrichten gesendet werden sollen." -- Needs review
L["Chat message with icons"] = "Chat Nachricht mit Symbolen." -- Needs review
L["Chats To Monitor"] = "Zu beobachtende Chats" -- Needs review
L["Chat Tabs"] = "Chat Tabs" -- Requires localization
L["Chat Tweaks"] = "Chat Tweaks" -- Requires localization
L["Cheats Color"] = "Cheats Color" -- Requires localization
L["Choose the filter to use."] = "Choose the filter to use." -- Requires localization
L["Choose which chat frames display timestamps"] = "W\195\164hle, in welchem Chatfenster ein Zeitstempel angezeigt werden soll."
L["Class"] = "Klasse"
L["Clear all chat windows."] = "Leere alle Chatfenster"
L["Clear All Logs"] = "Alle Protokolle l\195\182schen" -- Needs review
L["Clear Chat Commands"] = "Kommandos um Chat zu leeren"
L["Clear current chat."] = "Leere aktuellen Chat."
L["Cleared log of %s%s|r module."] = "Cleared log of %s%s|r module." -- Requires localization
L["Clear Log"] = "L\195\182sche Protokoll" -- Needs review
L["Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window."] = "Click to open the ElvUI Chat Tweaks config window.  This will also close ElvUI's config window." -- Requires localization
L["Click to reset the materials you're tracking."] = "Click to reset the materials you're tracking." -- Requires localization
L["Click to send the reminder to the select channel that the Magic 8-Ball is listening."] = "Click to send the reminder to the select channel that the Magic 8-Ball is listening." -- Requires localization
L["Click to toggle ElvUI's config window.  This will also close this window."] = "Click to toggle ElvUI's config window.  This will also close this window." -- Requires localization
L["Client Locale: |cff1784d1%s|r"] = "Client Locale: |cff1784d1%s|r" -- Requires localization
L["Coin Size"] = "Coin Size" -- Requires localization
L["Color"] = "Farbe"
L["Color a roll game loss, aka when you roll a one (1)."] = "Color a roll game loss, aka when you roll a one (1)." -- Requires localization
L["Color a roll game win, aka when someone else rolls a one (1)."] = "Color a roll game win, aka when someone else rolls a one (1)." -- Requires localization
L["Color by Channel"] = "Color by Channel" -- Requires localization
L["Color Cheats"] = "Color Cheats" -- Requires localization
L["Colorize"] = "F\195\164rben"
L["Color Level"] = "Color Level" -- Requires localization
L["Color Loss"] = "Farbe Verloren" -- Needs review
L["Color Name"] = "Name der Farbe" -- Needs review
L["Color of other's rolls."] = "Color of other's rolls." -- Requires localization
L["Color of the base reputation messages."] = "Color of the base reputation messages." -- Requires localization
L["Color of the faction."] = "Farbe der Fraktion." -- Needs review
L["Color of the output message."] = "Color of the output message." -- Requires localization
L["Color of the reputation needed/left."] = "Farbe des noch zu ben\195\182tigten Rufs." -- Needs review
L["Color of the standing (honored, revered, etc.)."] = "Color of the standing (honored, revered, etc.)." -- Requires localization
L["Color own charname in messages."] = "F\195\164rbe eigenen Charakternamen in Nachrichten."
L["Color Player Names By..."] = "F\195\164rbe Spielernamen nach..."
L["Color regular rolls by others."] = "Color regular rolls by others." -- Requires localization
L["Color Rolls"] = "W\195\188rfel Farbe"
L["Color rolls differently to make tracking the roll game easier on the eyes."] = "Color rolls differently to make tracking the roll game easier on the eyes." -- Requires localization
L["Color rolls that do not start at 1."] = "Color rolls that do not start at 1." -- Requires localization
L["Color self in messages"] = "F\195\164rbe selbst in Nachrichten"
L["Color the messages by the channel the message came from."] = "Color the messages by the channel the message came from." -- Requires localization
L["Color the name of the pets during a pet battle relative to their rarity.  If you have the pet you're currently battling it will also add the quality of the pet you have in your journal."] = "Color the name of the pets during a pet battle relative to their rarity.  If you have the pet you're currently battling it will also add the quality of the pet you have in your journal." -- Requires localization
L["Color timestamps the same as the channel they appear in."] = "F\195\164rbe Zeitstempel in den gleichen Farben, wie auch den Kanal, in dem sie erscheinen."
L["Color to change the filtered message to.\
\
|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r."] = "Color to change the filtered message to.\
\
|cffff0000Only works when Filtering Mode is set to |cff00ff00Colorize|r." -- Requires localization
L["Color to designate a cheating roll."] = "Color to designate a cheating roll." -- Requires localization
L["Color to designate a roll game loss."] = "Color to designate a roll game loss." -- Requires localization
L["Color to designate a roll game win."] = "Color to designate a roll game win." -- Requires localization
L["Color to use for your rolls."] = "Farbe zur Verwendung f\195\188r deine W\195\188rfe." -- Needs review
L["Color Win"] = "Farbe Gewonnen" -- Needs review
L["Color Your Rolls"] = "F\195\164rbe deine W\195\188rfe" -- Needs review
L["Color your rolls to set them apart."] = "Color your rolls to set them apart." -- Requires localization
L["Command Help"] = "Command Help" -- Requires localization
L["Companions"] = "Companions" -- Requires localization
L["Compress"] = "Komprimieren"
L["Concentrate and ask again."] = "Konzentrieren und nochmal fragen." -- Needs review
L["Congratulate achievements earned by guildmates."] = "Automatisch Gildenmitgliedern gratulieren, wenn sie einen Erfolg abschlie\195\159en."
L["Congratulate achievements earned by people in your party."] = "Automatisch gratulieren, wenn jemand in deiner Gruppe einen Erfolg abschlie\195\159t."
L["Congratulate achievements earned by people in your raid."] = "Automatisch gratulieren, wenn jemand in deinem Raid einen Erfolg abschlie\195\159t."
L["Congratulate achievements earned by people near you."] = "Automatisch gratulieren, wenn jemand in deiner N\195\164he einen Erfolg abschlie\195\159t."
L["Congratulations Messages"] = "Gratulationsnachrichten"
L["conquest"] = "conquest" -- Requires localization
L["  Conquest Points\
"] = "  Eroberungspunkte\
" -- Needs review
L["Cooking"] = "Kochen"
L["copper"] = "Kupfer"
L["Copy Links"] = "Links kopieren" -- Needs review
L["cp"] = "cp" -- Requires localization
L["cpcap"] = "cpcap" -- Requires localization
L["Crap Cleaner"] = "Crap Cleaner" -- Requires localization
L["Crap Cleaner blocked a message from %s%s|r."] = "Crap Cleaner blocked a message from %s%s|r." -- Requires localization
L["Creates a button to click that will return you to the bottom of the chat frame."] = "Erzeugt eine klickbare Schaltfl\195\164che, die f\195\188r dich an das Ende des Chatfensters scrollt."
L["Custom chat filters."] = "Benutzerdefinierte Chatfilter."
L["Custom Chat Filters"] = "Benutzerdefinierte Chatfilter"
L["Custom color"] = "Benutzerdefinierte Farbe" -- Needs review
L["Custom Emote: |cffffff00%s|r"] = "Benutzer Emote: |cffffff00%s|r" -- Needs review
L["Custom Emotes"] = "Eigene Emotes"
L["Custom format (advanced)"] = "Eigenes Format (fortgeschritten)"
L["Custom Named Chat Filters"] = "Benutzerdefiniert benannte Chatfilter" -- Needs review
L["Damage Meters"] = true
L["Datatext"] = "Datatext" -- Requires localization
L["Datatext Display"] = "Datatext Display" -- Requires localization
L["Date"] = "Datum" -- Needs review
L["Day"] = "Tag" -- Needs review
L["Death Knight"] = "Todesritter"
L["DEATHKNIGHT"] = "TODESRITTER" -- Needs review
L["Decline Invite"] = "Decline Invite" -- Requires localization
L["Default font face for the chat frames."] = "Standard Schriftart in Chatfenstern"
L["Default font outline for the chat frames."] = "Standard Schriftkontur in Chatfenstern"
L["Default font size for the chat frames."] = "Standard Schriftgr\195\182\195\159e in Chatfenstern"
L["Default Name Color"] = "Standard Namensfarbe"
L["Destroys all your saved class/level data"] = "L\195\182scht alle gespeicherten Klassen-/Stufendaten"
L["Determines if a chat message is deemed spam, at which point it can be filtered and the person reported."] = "Determines if a chat message is deemed spam, at which point it can be filtered and the person reported." -- Requires localization
L["Developer Tools"] = "Entwicklertools" -- Needs review
L["Ding Messages"] = "\"Ding\" Nachrichten"
L["Disable All Modules"] = "Alle Module deaktivieren" -- Needs review
L["Disabled"] = "Deaktiviert"
L["Disabled Modules"] = "Deaktivierte Module" -- Needs review
L["Disabled %s%s|r module."] = "Disabled %s%s|r module." -- Requires localization
L["Disable if..."] = "Deaktivieren, wenn"
L["Disable while you're AFK flagged."] = "Deaktivieren, wenn AFK"
L["Disable while you're DND flagged."] = "Deaktivieren, wenn DND "
L["Displays reputation numbers and progress in the chat frame."] = "Zeigt Rufpunkte und Fortschritt im Chatfenster an" -- Needs review
L["DND Messages"] = "DND Nachrichten" -- Needs review
L["Do Nothing"] = "Nichts machen"
L["Do not use alphanumerical characters."] = "Keine Alphanumerischen Zeichen verwenden." -- Needs review
L["Dont Always Run"] = "Nicht Immer Rennen"
L["Don't count on it."] = "Rechne nicht damit." -- Needs review
L["Don't Report"] = "Nicht melden" -- Needs review
L["Do you want to automatically remove an item when you meet your quota?"] = "Do you want to automatically remove an item when you meet your quota?" -- Requires localization
L["Druid"] = "Druide"
L["DRUID"] = "DRUIDE" -- Needs review
L["EditBox Alt Key Arrows"] = "EditBox Alt Key Arrows" -- Requires localization
L["ElvUI ChatTweaks"] = true
L["ElvUI_ChatTweaks"] = "ElvUI_ChatTweaks" -- Requires localization
L["ElvUI_ChatTweaks: You need to be level %d to whisper me.  Currently you are level %d!"] = "ElvUI_ChatTweaks: Du musst Level %d sein, um mich anzufl\195\188stern. Zur Zeit bist Du %d!"
L["ElvUI_CT"] = "ElvUI_CT" -- Requires localization
L["Emote"] = true
L["Emote Filter"] = "Emote-Filter" -- Needs review
L["Emphasize Self"] = "Eigenes hervorheben"
L["Enable"] = "Aktivieren" -- Needs review
L["Enable "] = "Aktivieren"
L["Enable All Modules"] = "Aktiviere Alle Module" -- Needs review
L["Enabled"] = "Aktiviert"
L["Enable Debugging"] = "Debugging aktivieren" -- Needs review
L["Enabled Modules"] = "Aktivierte Module" -- Needs review
L["Enabled %s%s|r module."] = "Enabled %s%s|r module." -- Requires localization
L["Enable Logging"] = "Aktiviere Protokollierung" -- Needs review
L["Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name.  Can also scan guild notes for character names to display, if no note has been manually set."] = "Enables you to right-click a person's name in chat and set a note on them to be displayed in chat, such as their main character's name.  Can also scan guild notes for character names to display, if no note has been manually set." -- Requires localization
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always congratulate."] = "Aktiviere dies, um die Funktion lediglich mit einer prozentualen Chance auszuf\195\188hren, um Spam/Bel\195\164stigungen zu unterbinden. Wenn du die Funktion deaktivierst, wird immer gratuliert."
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always run."] = "Aktiviere dies, um das Modul lediglich mit einer prozentualen Chance auszuf\195\188hren, um Spam/Bel\195\164stigungen zu unterbinden. Wenn du die Funktion deaktivierst, wird das Modul immer laufen."
L["Enable this to give the module a percent chance to run to prevent spam/annoyances.  If disabled the module will always welcome."] = "Aktiviere dies, um die Funktion lediglich mit einer prozentualen Chance auszuf\195\188hren, um Spam/Bel\195\164stigungen zu unterbinden. Wenn du die Funktion deaktivierst, werden Neulinge immer willkommen gehei\195\159en."
L["Enable to filter custom emotes made using |cff00ff00/emote|r or |cff00ff00/e|r."] = "Enable to filter custom emotes made using |cff00ff00/emote|r or |cff00ff00/e|r." -- Requires localization
L["Enable to filter standard emotes such as |cff00ff00/dance|r or |cff00ff00/flirt|r."] = "Enable to filter standard emotes such as |cff00ff00/dance|r or |cff00ff00/flirt|r." -- Requires localization
L["Enable various debugging messages to help with errors or undesired functioning."] = "Aktiviere verschiedene Debug-Nachrichten zur Suche von Fehlern oder unerw\195\188nschten Funktionen." -- Needs review
L["Enabling this will send a message to your chat whenever you change a zone with a list of the Battle Pets that are obtainable in the zone.  You have the option to filter them based on whether or not you own them.  This will also add the chat command |cff00ff96/zonelist|r to send the list whenever.  Even if you disable this the chat commands will still work."] = "Enabling this will send a message to your chat whenever you change a zone with a list of the Battle Pets that are obtainable in the zone.  You have the option to filter them based on whether or not you own them.  This will also add the chat command |cff00ff96/zonelist|r to send the list whenever.  Even if you disable this the chat commands will still work." -- Requires localization
L["Enchanting"] = "Verzauberkunst"
L["Engineering"] = "Ingenieurskunst"
L["Enter a custom time format. See http://www.lua.org/pil/22.1.html for a list of valid formatting symbols."] = "Eigenes Zeitformat eingeben. Siehe http://www.lua.org/pil/22.1.html f\195\188r eine \195\156bersicht nutzbarer Symbole."
L["Exclude level display for max level characters"] = "Deaktiviere die Stufenanzeige f\195\188r Charaktere auf h\195\182chster Stufe."
L["Exclude max levels"] = "Charaktere auf h\195\182chster Stufe ausschliessen."
L["Execution Interval"] = "Ausf\195\188hrungsintervall"
L["Faction Color"] = "Fraktionsfarbe" -- Needs review
L["Female"] = "weiblich" -- Needs review
L["Filter achievement message spam!"] = "Filtere Erfolgsmitteilungs-Spam!"
L["Filter achievements earned by guildmates."] = "Filtere Erfolge die Gildenmitglieder errungen haben."
L["Filter achievements earned by nearby people."] = "Filtere Erfolge die nahe Spieler errungen haben."
L["Filter AFK/DND auto responses.  This module is compatible with WIM."] = "Filtere AFK/DND autoantworten. Dieses Modul ist mit WIM kompatibel." -- Needs review
L["Filter AFK messages."] = "Filtere AFK-Nachrichten." -- Needs review
L["Filter annoying phrases in chat."] = "Filtere l\195\164stige S\195\164tze im Chat." -- Needs review
L["Filter by Player Level"] = "Filtere nach Spieler-Level"
L["Filter changed channel message."] = "Filter changed channel message." -- Requires localization
L["Filter Color"] = "Filterfarbe"
L["Filter DND messages."] = "Filtere DND-Nachrichten." -- Needs review
L["Filter Entire Line"] = "Filter die ganze Zeile" -- Needs review
L["Filter Guild Achievements"] = "Filtere Gildenerfolge"
L["Filter guild invites."] = "Gildeneinladungen filtern." -- Needs review
L["Filter guild recruitment messages in chat."] = "Gildenrekrutierungen im Chat herausfiltern." -- Needs review
L["Filter guild recruitment whispers."] = "Gildenrekrutierungen in Fl\195\188sternachrichten herausfiltern" -- Needs review
L["Filtering Mode"] = "Filter-Modus"
L["Filter joined channel message."] = "Filtere Channel beigetreten Nachricht." -- Needs review
L["Filter left channel message."] = "Filtere Channel verlassen Nachricht." -- Needs review
L["Filter Line"] = "Filter Line" -- Requires localization
L["Filter Mode"] = "Filter Mode" -- Requires localization
L["Filter Nearby Achievements"] = "Filtere nahe Erfolge"
L["Filter out raid icons in chat."] = "Schlachtzugssymbole aus dem Chat herausfiltern." -- Needs review
L["Filter Pets"] = "Filter Pets" -- Requires localization
L["Filter Raid Icons"] = "Schlachtzugssymbole filtern" -- Needs review
L["Filters"] = "Filter"
L["Filters guild recruitment spam in whispers or chat.  Can also block guild invites."] = "Filtert Gildenrekrutierungs-Spam in Fl\195\188sternachrichten oder Chat. Kann auch Gildeneinladungen blocken." -- Needs review
L["Filters out Auction House system messages."] = "Auktionshaus-Systemnachrichten filtern."
L["Filter spam throttle notices."] = "Filter spam throttle notices." -- Requires localization
L["Filter standard and/or custom emotes."] = "Filtere Standard- und/oder benutzerdefinierte Emotes." -- Needs review
L["Filters the channel notices."] = "Filtere die Channel Ank\195\188ndigungen" -- Needs review
L["Filter the Auction Created message.\
\
|cffffff00%s|r"] = "Filter the Auction Created message.\
\
|cffffff00%s|r" -- Requires localization
L["Filter the Auction Expired message.\
\
|cffffff00%s|r"] = "Nachrichten f\195\188r Abgelaufene Auktionen filtern.\
\
|cffffff00%s|r"
L["Filter the Auction Outbid message.\
\
|cffffff00%s|r"] = "Nachrichten f\195\188r \195\156berbotene Auktionen filtern.\
\
|cffffff00%s|r"
L["Filter the Auction Removed message.\
\
|cffffff00%s|r"] = "Nachrichten f\195\188r Entfernte Auktionen filtern.\
\
|cffffff00%s|r"
L["Filter the Auction Sold message.\
\
|cffffff00%s|r"] = "Nachrichten f\195\188r Verkaufte Auktionen filtern.\
\
|cffffff00%s|r"
L["Filter the Auction Won message.\
\
|cffffff00%s|r"] = "Nachrichten f\195\188r Gewonnene Auktionen filtern.\
\
|cffffff00%s|r"
L["Filter the Bid Accepted message.\
\
|cffffff00%s|r"] = "Filtert die Gebot akzeptiert Nachricht.\
\
|cffffff00%s|r" -- Needs review
L["Filter the line containing the question."] = "Filtere die Zeile welche die Anfragen beinhaltet." -- Needs review
L["Filter Triggers"] = "Filtere Ausl\195\182ser" -- Needs review
L["Filter whispers based on the sender's level."] = "Fl\195\188sternachrichten basierend auf dem Level des Gespr\195\164chspartners herausfiltern." -- Needs review
L["Font Color"] = "Schriftfarbe" -- Needs review
L["Font Face"] = "Schriftschnitt"
L["Font Size"] = "Schriftgr\195\182\195\159e"
L["Frame scraping timeout exceeded, results will be incomplete."] = "Frame scraping timeout exceeded, results will be incomplete." -- Requires localization
L["Frame to output the messages to."] = "Frame to output the messages to." -- Requires localization
L["Frame to send the addon messages to."] = "Frame to send the addon messages to." -- Requires localization
L["Friends"] = "Freunde"
L["Fun Filters"] = "Fun Filters" -- Requires localization
L["General Tab Channels"] = "General Tab Channels" -- Requires localization
L["ginv"] = true
L["ginvite"] = true
L["GInvite Alternate Command"] = "alternativer /guildinvite Befehl"
L["Gives you more flexibility in how you invite people to your group and guild."] = "Gives you more flexibility in how you invite people to your group and guild." -- Requires localization
L["GKick Command"] = "GKick Kommando"
L["GKick Target: |cffffff00%s|r"] = "GKick aktuelles Ziel: |cffffff00%s|r" -- Needs review
L["gold"] = "Gold" -- Needs review
L["Gold Calculator"] = "Gold Rechner" -- Needs review
L["Group"] = "Gruppe"
L["Group Invite Links"] = "Gruppeneinladungslinks" -- Needs review
L["Group Say Command"] = "Gruppenchannel Kommando"
L["Guild"] = "Gilde"
L["Guild Channel"] = "Gilden-Kanal"
L["Guild Chat"] = "Gildenchat"
L["Guild Invite Links"] = "Gildeneinladungslinks" -- Needs review
L["Guildmates"] = "Gildenmitglieder"
L["Guild Messages"] = "Gildenmitteilungen"
L["Guild Options"] = "Gildenoptionen"
L["Guild Spam"] = "Gilden Spam"
L["Guild Spam blocked a message from %s%s|r."] = "Guild Spam blocked a message from %s%s|r." -- Requires localization
L["Handles chat tab flashing."] = "Handles chat tab flashing." -- Requires localization
L["health"] = "Gesundheit" -- Needs review
L["Here you can select which channels this module will scan for the keygroupWords to trigger the invite."] = "Here you can select which channels this module will scan for the keygroupWords to trigger the invite." -- Requires localization
L["HH:MM (12-hour)"] = "HH:MM (12 Stunden)"
L["HH:MM (24-hour)"] = "HH:MM (24 Stunden)"
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24 Stunden)"
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12 Stunden)"
L["Hide the spam blocked message asking you to report the person."] = "Hide the spam blocked message asking you to report the person." -- Requires localization
L["Highlight Color"] = "Hervorheben Farbe" -- Needs review
L["Highlight Substitutions"] = "Highlight Substitutions" -- Requires localization
L["Highlight Term"] = "Highlight Term" -- Requires localization
L["Highlight the search term in the results."] = "Highlight the search term in the results." -- Requires localization
L["Highlight the substitutions that are made by changing their color."] = "Highlight the substitutions that are made by changing their color." -- Requires localization
L["honor"] = "Ehre" -- Needs review
L["  Honor Points\
"] = "  Ehrenpunkte\
" -- Needs review
L["honour"] = "Ehre" -- Needs review
L["Hook the GameTooltip to add information to pet tooltips."] = "Hook the GameTooltip to add information to pet tooltips." -- Requires localization
L["Hook the tooltip to show the toon's main or alts."] = "Hook the tooltip to show the toon's main or alts." -- Requires localization
L["Hook Tooltip"] = "Hook Tooltip" -- Requires localization
L["Hour (12hr)"] = "Stunde (12Std.)" -- Needs review
L["Hour (24hr)"] = "Stunde (24Std.)" -- Needs review
L["How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command."] = "How many pets on a single line when they're being listed using the |cff00ff96/pets list|r command." -- Requires localization
L["How to filter any matches."] = "Auf welche Weise die Suchergebnisse filtern."
L["Hunter"] = "J\195\164ger"
L["HUNTER"] = "J\195\132GER" -- Needs review
L["I am |cff1784d1%s|r"] = "Ich bin |cff1784d1%s|r" -- Needs review
L["Icon Action"] = "Symbol Aktion" -- Needs review
L["Icon Orientation"] = "Symbol Ausrichtung" -- Needs review
L["Icon Size"] = "Symbol Gr\195\182\195\159e" -- Needs review
L["Icon to the left or right of the item link."] = "Symbol auf der linken oder rechten Seite vom Item-Link." -- Needs review
L["Identify Chat Frames"] = "Identifiziere Chat Fenster" -- Needs review
L["If a keyword is found should the module filter the line?"] = "If a keyword is found should the module filter the line?" -- Requires localization
L["If a person sends you multiple channel invites this will automatically put them on your ignore list."] = "If a person sends you multiple channel invites this will automatically put them on your ignore list." -- Requires localization
L["If no name can be found for an 'alt' rank character, use entire note"] = "If no name can be found for an 'alt' rank character, use entire note" -- Requires localization
L["Ignore any messages you send containing keywords."] = "Ignoriere alle von dir gesendeten Nachrichten welche Schl\195\188sselw\195\182rter enthalten." -- Needs review
L["Ignore Lifetime"] = "Ignore Lifetime" -- Requires localization
L["Ignore Sender"] = "Ignore Sender" -- Requires localization
L["Ignore Your Messages"] = "Ignoriere Deine Nachrichten" -- Needs review
L["Improved Auction Messages"] = "Improved Auction Messages" -- Requires localization
L["Improve the Auction Expired message.\
\
|cffffff00%s|r"] = "Improve the Auction Expired message.\
\
|cffffff00%s|r" -- Requires localization
L["Improve the Auction Outbid message.\
\
|cffffff00%s|r"] = "Improve the Auction Outbid message.\
\
|cffffff00%s|r" -- Requires localization
L["Improve the Auction Removed message.\
\
|cffffff00%s|r"] = "Improve the Auction Removed message.\
\
|cffffff00%s|r" -- Requires localization
L["Improve the Auction Sold message.\
\
|cffffff00%s|r"] = "Improve the Auction Sold message.\
\
|cffffff00%s|r" -- Requires localization
L["Improve the Auction Won message.\
\
|cffffff00%s|r"] = "Improve the Auction Won message.\
\
|cffffff00%s|r" -- Requires localization
L["Inactive Modules"] = "Inaktive Module" -- Needs review
L["Include level"] = "Level einbeziehen"
L["Include the player's level"] = "Einschalten des Spieler Levels"
L["In Command"] = "In Command" -- Requires localization
L["Inscription"] = "Inschriftenkunde" -- Needs review
L["Instance"] = "Instanz" -- Needs review
L["Instance Channel"] = "Instance Channel" -- Requires localization
L["Instance Leader"] = "Instanzleiter" -- Needs review
L["inv"] = "einladen"
L["Invalid format found on entry \"%s\"."] = "Invalid format found on entry \"%s\"." -- Requires localization
L["invite"] = "Einladen"
L["Invite Links"] = "Einladungs Links"
L["Invites"] = "Einladungen"
L[" isn't a number."] = " isn't a number." -- Requires localization
L[" isn't a recognized variable or number."] = " isn't a recognized variable or number." -- Requires localization
L["It is certain."] = "Es ist sicher." -- Needs review
L["It is decidedly so."] = "Es ist zweifellos so." -- Needs review
L["Jewelcrafting"] = "Juwelenschleifen" -- Needs review
L["Joined Channel"] = "Joined Channel" -- Requires localization
L["jp"] = "jp" -- Requires localization
L["jpcap"] = "jpcap" -- Requires localization
L["justice"] = "justice" -- Requires localization
L["  Justice Points\
"] = "  Gerechtigkeitspunkte\
" -- Needs review
L["Just one character."] = "Just one character." -- Requires localization
L["Keeps your channel colors by name rather than by number."] = "H\195\164lt deine Kanal-Farben nach Namen statt nach Anzahl."
L["Keybinds"] = "Keybinds" -- Requires localization
L["Keywords"] = "Keywords" -- Requires localization
L["Keyword Sounds"] = "Keyword Sounds" -- Requires localization
L["Leatherworking"] = "Lederverarbeitung"
L["Left"] = "Links"
L["Left Bracket"] = "Linke Klammer"
L["Left Channel"] = "Linker Kanal" -- Needs review
L["Left Click"] = "Links Klick" -- Needs review
L["Lets you alt-click player names to invite them to your party."] = "L\195\164sst dich per ALT-Klick auf die Spielernamen diese in deine Gruppe einladen."
L["Lets you set the justification of text in your chat frames."] = "L\195\164sst dich die Ausrichtung des Textes in deinen Chat-Frames setzen."
L["Level: |cffffff00%s|r, Message: |cffffff00%s|r"] = "Level: |cffffff00%s|r, Nachricht: |cffffff00%s|r" -- Needs review
L["Level Difference"] = "Level Difference" -- Requires localization
L["Level Location"] = "Levelgebiet" -- Needs review
L["Level wasn't a number, tell Lockslap. Level was |cffff0000%s|r!"] = "Level wasn't a number, tell Lockslap. Level was |cffff0000%s|r!" -- Requires localization
L["Link All Professions"] = "alle Berufe verlinken"
L["Log is empty."] = "Protokoll ist leer." -- Needs review
L["Log Lines"] = "Anzahl Protokoll Zeilen" -- Needs review
L["Log Notice"] = "Protokolliere Ank\195\188ndigungen" -- Needs review
L["Logs the lines that are filtered by the |cff00ff96%s|r, |cff00ff96%s|r, |cff00ff96%s|r, |cff00ff96%s|r, and |cff00ff96%s|r modules."] = "Logs the lines that are filtered by the |cff00ff96%s|r, |cff00ff96%s|r, |cff00ff96%s|r, |cff00ff96%s|r, and |cff00ff96%s|r modules." -- Requires localization
L["Look in guildnotes for character names, unless a note is set manually"] = "\195\156berpr\195\188ft die Gildennotiz nach Charakternamen, solange manuell keiner gesetzt wurde."
L["Loot Icons"] = "Loot Icons" -- Requires localization
L["Loss Color"] = "Verlust Farbe"
L["lowercase"] = "lowercase" -- Requires localization
L["Mage"] = "Magier"
L["MAGE"] = "MAGIER" -- Needs review
L["Magic 8-Ball"] = "Magic 8-Ball" -- Requires localization
L["Magic 8-Ball Says: I am ready to answer your questions!  Do \"%s <question>\" to ask me a question."] = "Magic 8-Ball Says: I am ready to answer your questions!  Do \"%s <question>\" to ask me a question." -- Requires localization
L["Magic 8-Ball says: %s"] = "Magic 8-Ball says: %s" -- Requires localization
L["Main: "] = "Main: " -- Requires localization
L["Male"] = "m\195\164nnlich" -- Needs review
L["mana"] = "Mana" -- Needs review
L["Material Quantities"] = "Material Mengen" -- Needs review
L["Materials Farming"] = "Materials Farming" -- Requires localization
L["Materials to Track"] = "Zu verfolgende Materialien" -- Needs review
L["Maximum Delay"] = "Maximale Verz\195\182gerung"
L["Maximum Lines"] = "Maximale Anzahl Zeilen" -- Needs review
L["Maximum number of lines to keep."] = "Maximale Anzahl Zeilen, die behalten werden soll." -- Needs review
L["Maximum time, in seconds, to wait before bidding someone farewell."] = "Maximale Wartezeit in Sekunden vor dem Verabschieden."
L["Maximum time, in seconds, to wait before congratulating someone."] = "Maximale Wartezeit (in Sekunden), bevor jemandem gratuliert wird."
L["Maximum time, in seconds, to wait before welcoming someone."] = "Maximale Wartezeit (in Sekunden), bevor jemandem willkommen gehei\195\159en wird."
L["Maximum time, in seconds, to wait before whispering someone the link."] = "Maximale Wartezeit (in Sekunden), bevor der Link gefl\195\188stert wird."
L["Message color."] = "Nachrichten-Farbe" -- Needs review
L["Message Color"] = "Nachrichtenfarbe"
L["Message highlight color."] = "Nachricht hervorheben Farbe." -- Needs review
L["Message Settings"] = "Nachrichten Einstellungen" -- Needs review
L["Messages for when multiple people complete achievements.  A random one will always be selected.\
\
|cffff0000Wildcards do not apply for multiple achievements.|r"] = "Nachricht, wenn mehrere Spieler einen Erfolg abschlie\195\159en. Es wird immer ein zuf\195\164lliger Spieler ausgew\195\164hlt.\
\
|cffff0000Wildcards funktionieren nicht bei mehreren Erfolgen.|r"
L["Messages for when someone completes an achievement.  A random one will always be selected.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r  - Name of the person.\
|cff00ff00#achieve#|r - Achievement they completed."] = "Nachrichten f\195\188r den, der einen Erfolg abschlie\195\159t. Eine zuf\195\164llige wird immer gew\195\164hlt\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r  - Name der Person.\
|cff00ff00#achieve#|r - Der Erfolg, welcher abgeschlossen wurde."
L["Messages to use in guild chat when someone leaves your guild.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Person who left.\
|cff00ff00#guild#|r - Name of your guild."] = "Nachrichten zur Verwendung im Gildenchat, wenn jemand deine Gilde verl\195\164sst.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Person, welche die Gilde verlassen hat.\
|cff00ff00#guild#|r - Name deiner Gilde."
L["Messages to use in the whisper when someone leaves your guild.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Person who left.\
|cff00ff00#guild#|r - Name of your guild."] = "Nachrichten zum Fl\195\188stern, wenn jemand deine Gilde verl\195\164sst.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Person, welche die Gilde verlassen hat.\
|cff00ff00#guild#|r - Name deiner Gilde."
L["Messages to use when someone joins your guild.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Person who joined.\
|cff00ff00#guild#|r - Name of your guild."] = "Nachrichten, welche benutzt werden, wenn jemand der Gilde beitritt.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Name des beigetretenen.\
|cff00ff00#guild#|r - Name deiner Gilde."
L["Messages to use when someone says \"ding\".\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Who said ding.\
|cff00ff00#guild#|r - Their current level."] = "Nachrichten, wenn jemand \"ding\" schreibt.\
\
|cffFA6400Wildcards|r\
|cff00ff00#name#|r - Name des jenigen, der \"ding\" geschrieben hat.\
|cff00ff00#guild#|r - Sein aktueller Level."
L["Message Throttle"] = "Message Throttle" -- Requires localization
L["Minimap Button"] = "Minimap-Button" -- Needs review
L["Minimum Delay"] = "Minimale Verz\195\182gerung"
L["Minimum DK Level"] = "minimales DK Level"
L["Minimum Level"] = "Mindest Level"
L["Minimum level for a Death Knight to be in order to whisper you."] = "Mindestlevel f\195\188r Todesrittern, um dich anfl\195\188stern zu d\195\188rfen." -- Needs review
L["Minimum level for a non-Death Knight to be in order to whisper you."] = "Mindestlevel f\195\188r Nicht-Todesrittern, um dich anfl\195\188stern zu d\195\188rfen." -- Needs review
L["Minimum level required for an achievement to not be filtered."] = "Minimales ben\195\182tigtes Level damit Erfolgsnachricht nicht gefiltert wird."
L["Minimum time, in seconds, to wait before bidding someone farewell."] = "Minimale Wartezeit in Sekunden vor Verabschiedung."
L["Minimum time, in seconds, to wait before congratulating someone."] = "Minimale Wartezeit (in Sekunden), bevor jemandem gratuliert wird."
L["Minimum time, in seconds, to wait before welcoming someone."] = "Minimale Wartezeit (in Sekunden), bevor ein Neuling willkommen gehei\195\159en wird."
L["Minimum time, in seconds, to wait before whispering someone the link."] = "Minimale Wartezeit (in Sekunden), bevor der Link gefl\195\188stert wird."
L["Minute"] = true -- Needs review
L["MM:SS"] = true
L["Module doesn't exist, or log is empty."] = "Modul existiert nicht oder Protokoll ist leer." -- Needs review
L["Monitor Chat Events"] = "Beobachte Chat-Ereignisse" -- Needs review
L["Monitor guild chat."] = "Beobachte Gildenchat"
L["Monitor party chat."] = "Beobachte Gruppenchat"
L["Monitor raid chat."] = "Beobachte Schlachtzugsnachrichten"
L["Monitor say chat."] = "Beobachte \"Sagen\"-Nachrichten"
L["Monitor text in this channel for link triggers."] = "Monitor text in this channel for link triggers." -- Requires localization
L["Monitor whispers."] = "Beobachte Fl\195\188sternachrichten"
L["Monitor yell chat."] = "Beobachte \"Schreien\"-Nachrichten"
L["Monk"] = "M\195\182nch" -- Needs review
L["MONK"] = "M\195\150NCH" -- Needs review
L["Monster Emote"] = true
L["Monster Say"] = "Monster sagen"
L["Month"] = "Monat" -- Needs review
L["Most likely."] = "H\195\182chstwahrscheinlich." -- Needs review
L["Multiple Achievement Messages"] = "Mehrfache Erfolgsnachrichten."
L["Multiple Invite Command"] = "Multiple Invite Command" -- Requires localization
L["My reply is no."] = "Meine Antwort ist Nein." -- Needs review
L["My sources say no."] = "Meine Quellen sagen Nein." -- Needs review
L["Name"] = true
L["Name color"] = "Farbe Name" -- Needs review
L["Nearby People"] = "Leute in der N\195\164he."
L["New Version Notify"] = "Benachrichtigung \195\188ber neue Version." -- Needs review
L["No"] = "Nein" -- Needs review
L["No custom emotes are currently being used."] = "Zur Zeit sind keine Benutzer-Emotes in Benutzung."
L["No Filter"] = "No Filter" -- Requires localization
L["None"] = "Keiner"
L["No RealNames"] = "Keine Echt-Namen"
L["No role was set because you have no specialization."] = "No role was set because you have no specialization." -- Requires localization
L["<notarget>"] = "<notarget>" -- Requires localization
L["NoTarget"] = "KeinZiel" -- Needs review
L["Not Found"] = "Nicht gefunden" -- Needs review
L["Notify on Filter"] = "Notify on Filter" -- Requires localization
L["Notify on new release?"] = "\195\156ber neue Version benachrichtigen?" -- Needs review
L["Notify on Role Set"] = "Notify on Role Set" -- Requires localization
L["Notify you when a message is filtered."] = "Benachrichtigen, wenn eine Nachricht gefilter wurde." -- Needs review
L["Notify you when a message/whisper is filtered."] = "Benachrichtigen, wenn eine Nachricht/Fl\195\188sternachricht gefiltert wurde." -- Needs review
L["Not tracking %s."] = "Not tracking %s." -- Requires localization
L["Numbered Channels"] = "Nummerierte Kan\195\164le" -- Needs review
L["Num Channels"] = "Num Channels" -- Requires localization
L["Officer"] = "Offizier"
L["Officer Channel"] = "Offiziers-Kanal"
L["Officer Chat"] = "Offizierschat"
L["One or more of the changes you have made require you to reload your UI."] = "Eine oder mehrere gemachte \195\132nderung(en) erfordern das reloaden des UI." -- Needs review
L["Only filter achievements earned by players below a certain level."] = "Nur Erfolge herausfiltern, die von Spielern unter einem bestimmten Level erreicht werden."
L["Open Config"] = "\195\150ffne Konfiguration" -- Needs review
L["Open ElvUI's Config"] = "Open ElvUI's Config" -- Requires localization
L["Opens configuration window."] = "Konfigurationsfenster \195\182ffnen"
L["Other Channels"] = "Andere Kan\195\164le"
L["Ouput Frame"] = "Ausgabe-Fenster" -- Needs review
L["Outline"] = "Kontur"
L["Outlook good."] = "Aussicht gut." -- Needs review
L["Outlook not so good."] = "Aussicht nicht so gut." -- Needs review
L["Output Channel"] = "Ausgabe-Kanal" -- Needs review
L["Output Color"] = "Ausgabe-Farbe" -- Needs review
L["Output color of the rerouted messages."] = "Ausgabefarbe von umgeleiteten Nachrichten." -- Needs review
L["Output Frame"] = "Ausgabe-Fenster" -- Needs review
L["Output Message Every..."] = "Output Message Every..." -- Requires localization
L["Output the message every X times you gain XP."] = "Output the message every X times you gain XP." -- Requires localization
L["Output To..."] = "Ausgabe nach..." -- Needs review
L["% Owned"] = "% Owned" -- Requires localization
L["Owned Only"] = "Owned Only" -- Requires localization
L["Paladin"] = true
L["PALADIN"] = true -- Needs review
L["Parameter: |cffffff00%s|r"] = "Parameter: |cffffff00%s|r" -- Requires localization
L["Party"] = "Gruppe"
L["Party Channel"] = "Gruppen-Kanal"
L["Party Leader"] = "Gruppenleiter"
L["Party Members"] = "Gruppenmitglieder"
L["Percent Chance"] = "Prozentuale Chance"
L["Perhaps you meant '*' (multiplication)?"] = "Perhaps you meant '*' (multiplication)?" -- Requires localization
L["Pet Battle Info"] = "Pet Battle Info" -- Requires localization
L["Pet Battles"] = "Haustierk\195\164mpfe" -- Needs review
L["Pet Combat Log"] = "Haustierkampf Protokoll" -- Needs review
L["Pets Per Line"] = "Pets Per Line" -- Requires localization
L["Place the level before or after the player's name."] = "Platziere das Level vor oder nach den Spielernamen"
L["Play a sound when it pops up."] = "Play a sound when it pops up." -- Requires localization
L["Player Class"] = "Player Class" -- Requires localization
L["Player Level"] = "Spieler Level"
L["Player level display options."] = "Spieler-Level Anzeigeoptionen."
L["Player Names"] = "Spieler Namen"
L["Player's Average iLvl"] = "Spieler durchschnittliches iLvl" -- Needs review
L["Player's Class"] = "Spieler Klasse" -- Needs review
L["Player's Gender"] = "Spieler Geschlecht" -- Needs review
L["Player's Health"] = "Spieler Gesundheit" -- Needs review
L["Player's Health Deficit"] = "Spieler Gesundheit Defizit" -- Needs review
L["Player's Health Percent"] = "Spieler Gesundheit Prozent" -- Needs review
L["Players Level"] = "Players Level" -- Requires localization
L["Player's Location"] = "Player's Location" -- Requires localization
L["Player's Mana"] = "Player's Mana" -- Requires localization
L["Player's Mana Deficit"] = "Player's Mana Deficit" -- Requires localization
L["Player's Mana Percent"] = "Player's Mana Percent" -- Requires localization
L["Player's Max Health"] = "Player's Max Health" -- Requires localization
L["Player's Max Mana"] = "Player's Max Mana" -- Requires localization
L["Player's Name"] = "Spielername" -- Needs review
L["Player's X-Coordinate"] = "Player's X-Coordinate" -- Requires localization
L["Player's Y-Coordinate"] = "Player's Y-Coordinate" -- Requires localization
L["Player's Zone"] = "Player's Zone" -- Requires localization
L["Plays a sound, of your choosing (via LibSharedMedia-3.0), whenever a message is received in a given channel."] = "Spielt einen Sound, von deiner Auswahl (via LibSharedMedia-3.0), wann immer du eine Nachricht ein einem gegebenen Kanal erh\195\164lst."
L["Plays a sound when one of your ElvUI keywords is found."] = "Plays a sound when one of your ElvUI keywords is found." -- Requires localization
L["Play Sound"] = "Spiele Sound" -- Needs review
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
L["power"] = "power" -- Requires localization
L["Prefix Character"] = "Prefix Character" -- Requires localization
L["Priest"] = "Priester"
L["PRIEST"] = "PRIESTER" -- Needs review
L["Print Addon Version"] = "Print Addon Version" -- Requires localization
L["Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues."] = "Print hidden addon messages in a chat frame.  This can be useful to debugging addon issues." -- Requires localization
L["Prints a message in the chat with your remain XP needed to level up."] = "Prints a message in the chat with your remain XP needed to level up." -- Requires localization
L["Prints module status."] = "Zeige Modul-Status an."
L["Print this again."] = "Zeige das nochmal an."
L["Progress Updates"] = "Progress Updates" -- Requires localization
L["Provides a |cff00ff00/gkick|r command, as it should be."] = "Integriert ein |cff00ff00/gkick|r Befehl, wie es sein sollte."
L["Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically."] = "Provides a |cff00ff96/gs|r slash command to let you speak in your group (raid, party, or instance) automatically." -- Requires localization
L["Provides a few tools to help me (Lockslap), develop this addon as well as diagnose and fix any errors that are reported.\
\
|cff00ff00You can leave this addon disabled unless I (Lockslap) ask you to enable it for some debugging.|r"] = "Provides a few tools to help me (Lockslap), develop this addon as well as diagnose and fix any errors that are reported.\
\
|cff00ff00You can leave this addon disabled unless I (Lockslap) ask you to enable it for some debugging.|r" -- Requires localization
L["Provides a /in command to delay the execution of code in macros and other settings."] = "Provides a /in command to delay the execution of code in macros and other settings." -- Requires localization
L["Provides basic chat subtitutions."] = "Bietet Basis Chat Ersetzungen." -- Needs review
L["Provides |cff00ff00/ginv|r, an alternative to |cff00ff00/ginvite|r command, for us lazy folks."] = "Stellt |cff00ff00/ginv|r bereit, einem alternativen |cff00ff00/ginvite|r Befehl, f\195\188r uns faule Leute."
L["Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.\
\
Module Written by Bj\195\182rn Benjamin Hiller <bjoern.hiller@gmail.com>"] = "Provides |cff00ff00/minv|r to invite multiple people at once. Also adds custom abbreviations for characters which are invited often.\
\
Module Written by Bj\195\182rn Benjamin Hiller <bjoern.hiller@gmail.com>" -- Requires localization
L["Provides keybinds to make talking in a specific chat easier."] = "Provides keybinds to make talking in a specific chat easier." -- Requires localization
L["Provides options to color player names, add player levels, and add tab completion of player names."] = "Bietet Optionen zum f\195\164rben von Spielernamen, f\195\188gt Spielerlevel  hinzu und Tabulator Vervollst\195\164ndigung von Spielernamen."
L["Put each emote on a separate line.\
Separate the command from the text with a colon (\":\")."] = "Setze jedes Emote in eine seperate Zeile.\
Trenne den Befehl vom Text mit einem Doppelpunkt (\":\")."
L["Quality Notification"] = "Quality Notification" -- Requires localization
L["Raid"] = "Schlachtzug"
L["Raid Boss Emote"] = "Schlachtzugsboss-Emote"
L["Raid Channel"] = "Schlachtzug-Kanal"
L["Raid Leader"] = "Schlachtzugsleiter"
L["Raid Members"] = "Schlachtzugsmitglieder"
L["Raid Warning"] = "Schlachtzugwarnung"
L["Raid Warning Channel"] = "Schlachtzugwarnung-Kanal"
L["Random Number"] = "Zufallszahl" -- Needs review
L["Ready Check Command"] = "Ready Check Command" -- Requires localization
L["RealID Brackets"] = "RealID Klammern"
L["RealID Conversation"] = "RealID Unterhaltung"
L["RealID Whisper"] = "RealID Fl\195\188stern"
L["Really remove this word from your trigger list?"] = "Dieses Wort wirklich von der Trigger Liste nehmen?"
L["Release Command"] = "Release Command" -- Requires localization
L["Reminder"] = "Erinnerung" -- Needs review
L["Remove"] = "Entfernen"
L["Remove a word from your group invite trigger list"] = "Entfernt ein Wort aus deiner Gruppeneinladung Ausl\195\182ser-Liste" -- Needs review
L["Remove a word from your guild invite trigget list."] = "Entfernt ein Wort aus deiner Gildeneinladung Ausl\195\182ser-Liste" -- Needs review
L["Remove Group Trigger"] = "Entfernt Gruppen Ausl\195\182ser" -- Needs review
L["Remove Guild Trigger"] = "Entfernt Gilden Ausl\195\182ser" -- Needs review
L["Remove Icon Only"] = "Entferne nur das Icon"
L[", removing from list"] = ", removing from list" -- Requires localization
L["Repeat Command"] = "Befehl wiederholen"
L["Repeat Question"] = "Wiederhole Frage" -- Needs review
L["Repeat the question when giving a response."] = "Wiederhole die Frage, wenn Antwort geegeben wird." -- Needs review
L["Reply hazy, try again."] = "Antwort schwammig, versuchs nochmal." -- Needs review
L["Reported by %s"] = "Gemeldet durch %s"
L["Reputation"] = "Ruf" -- Needs review
L["Reputation Color"] = "Reputation Color" -- Requires localization
L["Require the alt key to be pressed to use the arrow keys on editboxes."] = "Require the alt key to be pressed to use the arrow keys on editboxes." -- Requires localization
L["Reroute Auction Messages"] = "Leite Auktionsnachichten um" -- Needs review
L["Reset ChatFrame text justifications to defaults (left)."] = "Die Textausrichtung des Chatframe auf Standart zur\195\188ckstellen (linksb\195\188ndig)."
L["Reset Data"] = "Daten zur\195\188cksetzen"
L["Reset Font Data"] = "Schriftartdaten zur\195\188cksetzen"
L["Reset Materials"] = "Materialien zur\195\188cksetzen." -- Needs review
L["Resets all chat frames to their original font settings."] = "Alle Chats auf den Originalschriftart zur\195\188cksetzen."
L["Reset Text Justitification"] = "Textausrichtung zur\195\188cksetzen"
L["Respond to Whispers"] = "Auntowrt auf Fl\195\188sternachrichten" -- Needs review
L["Respond to whispers notifying them that they don't meet the level requirement."] = "Respond to whispers notifying them that they don't meet the level requirement." -- Requires localization
L["Right"] = "Rechts"
L["Right Bracket"] = "Rechte Klammer"
L["Right Click"] = "Rechts Klick" -- Needs review
L["Rogue"] = "Schurke"
L["ROGUE"] = "SCHURKE" -- Needs review
L["Role Poll Command"] = "Role Poll Command" -- Requires localization
L["Role Set: %s%s|r"] = "Role Set: %s%s|r" -- Requires localization
L["Role will not be set while in combat."] = "Role will not be set while in combat." -- Requires localization
L["Roll Color"] = "Roll Color" -- Requires localization
L["Roll Pattern: |cffffff00%s|r"] = "Roll Pattern: |cffffff00%s|r" -- Requires localization
L["Save all /who data"] = "Speichere alle /wer Daten"
L["Save class data from friends between sessions."] = "Speichere Freundesdaten zwischen den Sitzungen."
L["Save class data from groups between sessions."] = "Speichere Klassendaten zwischen den Sitzungen."
L["Save class data from guild between sessions."] = "Speichere Klassendaten aus der Gilde zwischen den Sitzungen."
L["Save class data from target/mouseover between sessions."] = "Speichere Klassendaten von Ziel/Maus\195\188ber zwischen den Sitzungen."
L["Save class data from /who queries between sessions."] = "Speichere Klassendaten von /wer Abfragen zwischen den Sitzungen."
L["Save Data"] = "Speichere Daten"
L["Save data between sessions. Will increase memory usage"] = "Speichere Daten zwischen den Sitzungen. Wird den Speicherverbrauch erh\195\182hen"
L["Say"] = "Sagen"
L["Say Chat"] = "Sagen Chat"
L["%s  Conquest Cap\
"] = "%s  Conquest Cap\
" -- Requires localization
L["Scrape Time"] = "Scrape Time" -- Requires localization
L["Scroll Reminder"] = "Scroll Reminder" -- Requires localization
L["Search"] = "Search" -- Requires localization
L["Search Results:"] = "Search Results:" -- Requires localization
L["Search Results |cff9382c9(%d Found)|r:"] = "Search Results |cff9382c9(%d Found)|r:" -- Requires localization
L["Search term is too short."] = "Search term is too short." -- Requires localization
L["Second"] = "Zweite" -- Needs review
L["Select a color for this channel."] = "Eine Farbe f\195\188r diesen Kanal ausw\195\164hlen."
L["Select a method for coloring player names"] = "W\195\164hle ein Methode zum Einf\195\164rben der Spielernamen."
L["Select an option if you want the zone list to only contain pets you own or do not own."] = "Select an option if you want the zone list to only contain pets you own or do not own." -- Requires localization
L["Select how you want the player's level colored."] = "Select how you want the player's level colored." -- Requires localization
L["Select the channels to apply the filter to."] = "Select the channels to apply the filter to." -- Requires localization
L["Select the channels you want monitored."] = "Select the channels you want monitored." -- Requires localization
L["Select the channels you want to monitor."] = "W\195\164hle die Kan\195\164le, welche beobachtet werden sollen." -- Needs review
L["Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number."] = "Select the chat frames you want to monitor for substitutions.  You can use the chat command |cff00ff96/cf|r to determine a chat frame's number." -- Requires localization
L["Select the custom color to use for alt names"] = "Select the custom color to use for alt names" -- Requires localization
L["Select which channels to flash when a message is received."] = "Select which channels to flash when a message is received." -- Requires localization
L["Select which factions you would like to receive notifications for."] = "W\195\164hle die Fraktionen aus, von denen du Benachrichtigungen erhalten m\195\182chtest." -- Needs review
L["%sElvUI Chat Tweaks|r by |cff9382c9Lockslap|r"] = "%sElvUI Chat Tweaks|r by |cff9382c9Lockslap|r" -- Requires localization
L["Send a chat message when a role is set/changed."] = "Send a chat message when a role is set/changed." -- Requires localization
L["Send a notice when something is added to the log."] = "Benachrichtige, wenn etwas zum Protokoll hinzugef\195\188gt worden ist." -- Needs review
L["Send a tell to your target."] = "Send a tell to your target." -- Requires localization
L["Send a whisper to the person who left."] = "Sende der Person eine Nachricht, die verlassen hat." -- Needs review
L["Send Guild Messages"] = "Gildennachrichten versenden"
L["Send messages to guild chat when someone leaves."] = "Sende Nachrichten zum Gildenchat wenn jemand austritt."
L["Send Reminder"] = "Sende Erinnerung" -- Needs review
L["Send Whisper"] = "Fl\195\188sternachricht versenden"
L["Separator"] = "Trennzeichen"
L["Set Main"] = "Hauptcharakter einstellen"
L["Set the coloring mode for alt names"] = "Set the coloring mode for alt names" -- Requires localization
L["Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel."] = "Set the message color.  This only applies if |cff00ff96Color by Channel|r is disabled or if there is no color for the channel." -- Requires localization
L["Set the sound to play."] = "Set the sound to play." -- Requires localization
L["Settings"] = "Einstellungen"
L["Shaman"] = "Schamane"
L["SHAMAN"] = "SCHAMANE" -- Needs review
L["Shift + Left Click"] = "Shift + Links Klick" -- Needs review
L["Shift + Right Click"] = "Shift + Rechts Klick" -- Needs review
L["Show Alts"] = "Show Alts" -- Requires localization
L["Show a report player popup (showing the spam) instead of printing in chat"] = "Show a report player popup (showing the spam) instead of printing in chat" -- Requires localization
L["Show current to total XP percentage."] = "Show current to total XP percentage." -- Requires localization
L["Show ElvUI Chat Tweaks Config Window"] = "Show ElvUI Chat Tweaks Config Window" -- Requires localization
L["Showing Configuration Options"] = "Showing Configuration Options" -- Requires localization
L["Show Main"] = "Show Main" -- Requires localization
L["Show Percentage"] = "Show Percentage" -- Requires localization
L["Show remaining rested XP."] = "Show remaining rested XP." -- Requires localization
L["Show Rested XP"] = "Show Rested XP" -- Requires localization
L["Shows messages in a popup frame."] = "Shows messages in a popup frame." -- Requires localization
L["Show Spam Popup"] = "Zeige Spam Popup" -- Needs review
L["Show the total number of modules on the datatext."] = "Show the total number of modules on the datatext." -- Requires localization
L["Show toon names instead of real names"] = "Show toon names instead of real names" -- Requires localization
L["Show Total XP"] = "Show Total XP" -- Requires localization
L["Show total XP needed to level."] = "Show total XP needed to level." -- Requires localization
L["Show welcome message when logging in."] = "Show welcome message when logging in." -- Requires localization
L["Signs point to yes."] = "Anzeichen deuten auf Ja." -- Needs review
L["silver"] = "silver" -- Requires localization
L["Similar to the |cffffffIn Command|r module, except it will repeat the command X times."] = "Similar to the |cffffffIn Command|r module, except it will repeat the command X times." -- Requires localization
L["Size of the coin icons.  Generally you want to use your font size or smaller."] = "Size of the coin icons.  Generally you want to use your font size or smaller." -- Requires localization
L["%s  Justice Cap\
"] = "%s  Justice Cap\
" -- Requires localization
L["Smart Group Channel"] = "Smart Group Channel" -- Requires localization
L["%s or %s"] = "%s or %s" -- Requires localization
L["Sound"] = true -- Needs review
L["Sound to play when a message in %s is received.\
\
|cff00ff00To disable set to \"None\"|r."] = "Abzuspielender Sound, wenn eine Nachricht in %s empfangen wurde.\
\
|cff00ff00Zum Deaktivieren w\195\164hle \"None\"|r."
L["Spam Delay"] = "Spamverz\195\182gerung"
L["Spam Filter"] = "Spam-Filter"
L["Spam Log"] = "Spam Protokoll" -- Needs review
L["Spam Throttle"] = "Spam Verz\195\182gerung"
L[" %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r"] = " %s Progress: Completed on %s%s|r/%s%s|r/%s%s|r" -- Requires localization
L["%s reputation left until %s with %s."] = "%s reputation left until %s with %s." -- Requires localization
L["%s reputation needed until %s with %s."] = "%s reputation needed until %s with %s." -- Requires localization
L["sretteL esreveR"] = "sretteL esreveR" -- Requires localization
L["%s, %s, %s  Player's Money\
"] = "%s, %s, %s  Player's Money\
" -- Requires localization
L["%s, %s, %s  Player's Stats\
"] = "%s, %s, %s  Player's Stats\
" -- Requires localization
L["Standard Emote: |cffffff00%s|r"] = "Standard Emote: |cffffff00%s|r" -- Requires localization
L["Standard Emotes"] = "Standard Emotes" -- Requires localization
L["Standing Color"] = "Standing Color" -- Requires localization
L["Strip RealID brackets"] = "RealID Klammern ausschneiden."
L["Substitutions"] = "Ersetzungen" -- Needs review
L["Suppress"] = "Unterdr\195\188cken"
L["Suppress Recount/Skada/TinyDPS output into a clickable link, or filter it entirely."] = "Fasse Recount/Skada/TinyDPS Ausgaben zu einem klickbaren Link zusammen oder filtere diese komplett."
L["Suppress report message."] = "Suppress report message." -- Requires localization
L["%s  Valor Cap\
"] = "%s  Valor Cap\
" -- Requires localization
L["Symbol: |cffffff00%s|r"] = true -- Needs review
L["Tailoring"] = "Schneiderei"
L["Talk to your group based on party/raid status."] = "Sprich zu deiner Gruppe abh\195\164ngig vom Gruppen/Raid-Status."
L["Target: |cffffff00%s|r"] = "Ziel: |cffffff00%s|r" -- Needs review
L["Target/Mouseover"] = "Ziel/Mouseover"
L["Target's Class"] = "Klasse des Ziels" -- Needs review
L["Target's Gender"] = "Geschlecht des Ziels" -- Needs review
L["Target's Health"] = "Ziel Gesundheit" -- Needs review
L["Target's Health Deficit"] = "Ziel Gesundheit Defizit" -- Needs review
L["Target's Health Percent"] = "Ziel Gesundheit Prozent" -- Needs review
L["Target's Level"] = "Ziel Level" -- Needs review
L["Target's Mana"] = "Ziel Mana" -- Needs review
L["Target's Mana Deficit"] = "Ziel Mana Defizit" -- Needs review
L["Target's Mana Percent"] = "Ziel Mana Prozent" -- Needs review
L["Target's Max Health"] = "Ziel Max Gesundheit" -- Needs review
L["Target's Max Mana"] = "Ziel Max Mana" -- Needs review
L["Target's Name"] = "Ziel Name" -- Needs review
L["Tell Target"] = "Ziel fl\195\188stern" -- Needs review
L["Text Justification"] = "Textausrichtung"
L["Text justification for ChatFrame %d."] = "Text Ausrichtung f\195\188r Chat Fenster %d."
L["Text to trigger the addon to answer a question."] = "Text welcher das Addon zum Frage beantworten ausl\195\182st." -- Needs review
L["Thanks for using and supporting my work!  -- |cff9382c9Lockslap|r\
\
|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."] = "Thanks for using and supporting my work!  -- |cff9382c9Lockslap|r\
\
|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge." -- Requires localization
L["The amount of each material you'd like to farm.  If you want an unlimited amount simply put a 0.  You must add a quantity for every entry, and it must correspond to the same line in the other box."] = "Die Menge von jedem Material, welches Du farmen m\195\182chstest. F\195\188r unbegrenzte Menge einfach eine Null einf\195\188gen. Du musst f\195\188r jeden Eintrag eine Menge hinzuf\195\188gen und es muss sich in der gleichen Zeile, wie die dazugeh\195\182rige Box, befinden." -- Needs review
L["The character in front of abbreviations to be recognised as such."] = "Der Anfangsbuchstabe von Abk\195\188rzungen zur Erkennung von Abk\195\188rzungen." -- Needs review
L["The classic Magic 8-Ball brought to World of Warcraft!"] = "The classic Magic 8-Ball brought to World of Warcraft!" -- Requires localization
L["The color to highlight the search term."] = "Farbe zur Hervorhebung von Suchbegriffen" -- Needs review
L["The color to use when highlighting a substitution."] = "Farbe zur Hervorhebung von Ersetzungen." -- Needs review
L["The default color to use to color names."] = "Standardfarbe, welche zum Einf\195\164rben von Namen verwendet werden soll."
L["The name or ID of the material you'd like to track.\
\
|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r"] = "The name or ID of the material you'd like to track.\
\
|cff00ff00If you wish to use the item's name then the item must exist in your bags.  This is a limitation to the API, item ID's will always work as intended.|r" -- Requires localization
L["The percent chance the module has to bid someone farewell.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = "Prozentuale Chance, mit der das Modul jemanden verabschieden soll. Erh\195\182he die Chance je mehr es verabschieden soll. Das ist ein Mittel um Spam/\195\132rger zu vermeiden." -- Needs review
L["The percent chance the module has to congratulate someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = "Prozentuale Chance mit der das Modul jemanden gratulieren soll. Erh\195\182he die Chance je mehr es begr\195\188\195\159en soll. Das ist ein Mittel um Spam/\195\132rger zu vermeiden."
L["The percent chance the module has to welcome someone.  Higher the chance, the more likely it is to run.  This is a means to throttle, so as to prevent spam/annoyances."] = "Prozentuale Chance mit der das Modul jemanden willkommen hei\195\159en soll. Erh\195\182he die Chance je mehr es begr\195\188\195\159en soll. Das ist ein Mittel um Spam/\195\132rger zu vermeiden."
L["These are the keywords that the addon will look for first, when it finds a match then it will look for the actual profession being requested."] = "These are the keywords that the addon will look for first, when it finds a match then it will look for the actual profession being requested." -- Requires localization
L["These channels apply to the General tab only."] = "These channels apply to the General tab only." -- Requires localization
L["The size of the icon in the chat frame."] = "Symbolgr\195\182\195\159e im Chatfenster" -- Needs review
L["The time, in seconds, it takes for the same person to trigger the addon again."] = "The time, in seconds, it takes for the same person to trigger the addon again." -- Requires localization
L["The time, in seconds, it takes for the same person to trigger the addon by saying ding."] = "The time, in seconds, it takes for the same person to trigger the addon by saying ding." -- Requires localization
L["Thick Outline"] = "Dicke Kontur"
L["This addon is designed to add a lot of the functionality of full fledged chat addons like Prat or Chatter, but without a lot of the unneeded bloat.  I wrote it to be as lightweight as possible, while still powerful enough to accomplish it's intended function.\
"] = "Dieses Addon wurde entwickelt, um einen Gro\195\159teil der Funktionen des vollwertigen Chat Addons wie Prat oder Chatter zu integrieren, jedoch es unn\195\182tig aufzublasen. Ich schrieb, dass es so schlank wie m\195\182glich, dennoch stark genug, um die beabsichtigte Funktion erf\195\188llen.\
" -- Needs review
L["This module is for named channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.\
\
For more information see this addon's Curse page."] = "This module is for named channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.\
\
For more information see this addon's Curse page." -- Requires localization
L["This module is for numbered channels only.  Allows you to filter certain words or phrases using Lua's pattern matching. For an item, achievement, spell, etc. just use the name of the item, don't try to link it.\
\
For more information see this addon's Curse page."] = "Dieses Modul ist nur f\195\188r nummerierte Kan\195\164le. Es erlaubt die Filterung von bestimmten W\195\182rtern und S\195\164tzen unter Verwendung von LUA-Vorlagen. F\195\188r ein Item, Erfolg, Zauber, etc. einfach den Namen des Items/Erfolgs/Zaubers benutzen. Nicht versuchen es zu verlinken.\
\
F\195\188r weitere Informationen siehe die Addon-Seite auf Curse.com." -- Needs review
L["This module will send a chat message every time you loot an item on your list with how many you have, and if applicable it will tell you how many more you need based on your set quantity.  This is useful if you need X amount of Y to be able to cook Z."] = "Dieses Modul wird jedes Mal eine Chat-Nachricht senden, wenn ein Item aus der Liste gepl\195\188ndert wird. Es wird sagen wie viele Du hast und gegebenenfalls wird es sagen wie vile zur eingestellten Menge fehlen. Dies ist n\195\188tzlich, wenn z.B. die Menge X von Y ben\195\182tigt wird wird um Z kochen zu k\195\182nnen." -- Needs review
L["This will contain the lines that were filtered by the |cff00ff96%s|r module.  You must have the logging setting enabled in the module's config."] = "Das wird die Zeilen beinhalten, welche vom  |cff00ff96%s|r Modul gefilter wurden. Dazu muss in der Modul-Konfiguration die Protokollierung aktiviert sein." -- Needs review
L["Throttle"] = "Drosselung" -- Needs review
L["Throttle Interval"] = "Verz\195\182gerung Intervall" -- Needs review
L["Throttle Messages"] = "Nachrichten Verz\195\182gerung" -- Needs review
L["Throttle output messages to prevent spam."] = "Ausgehende Nachrichten verz\195\182gern um Spam zu vermeiden." -- Needs review
L["Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable."] = "Throttle the updates so you do not get spammed.  Set to |cff00ff960|r to disable." -- Requires localization
L["Throttle Time"] = "Verz\195\182gerungszeit" -- Needs review
L["Throttle time prevented %s update."] = "Throttle time prevented %s update." -- Requires localization
L["Throttle to only answer a question every X seconds, to prevent spam.\
\
|cffff0000Not recommended to disable this.|r"] = "Drosselung auf nur eine Nachricht alle X Sekunden m Spam zu vermeiden." -- Needs review
L["Time"] = "Zeit" -- Needs review
L["Time, in seconds, in between running the command."] = "Time, in seconds, in between running the command." -- Requires localization
L["Time, in seconds, the module will wait after the first line is found to assume it is complete.\
\
|cffffff00One (1) second seems to work.|r"] = "Time, in seconds, the module will wait after the first line is found to assume it is complete.\
\
|cffffff00One (1) second seems to work.|r" -- Requires localization
L["Time, in seconds, to run the clean up to keep your ignore list clean."] = "Time, in seconds, to run the clean up to keep your ignore list clean." -- Requires localization
L["Time, in seconds, to throttle output messages to prevent spam."] = "Zeit in Sekunden zur Verz\195\182gerung der ausgehenden Nachrichten um Spam zu vermeiden." -- Needs review
L["Time, in seconds, to throttle the zone list to prevent any spam."] = "Zeit in Sekunden zum Verz\195\182gern der Zonenliste um Spam zu vermeiden." -- Needs review
L["Time, in seconds, you want the search to continue before it ends."] = "Zeit in Sekunden" -- Needs review
L["Timestamp color"] = "Zeitstempelfarbe"
L["Timestamp format"] = "Zeitstempelformat"
L["Timestamps"] = "Zeitstempel"
L["TOC Version: |cff1784d1%s|r"] = true -- Needs review
L["Toggle coloring and change of the chat frame for pet combat log messages."] = "Umschalten der Einf\195\164rbung und \195\132nderung des Chatfensters f\195\188r Haustierkampf-Log-Nachrichten." -- Needs review
L["Toggle coloring and changing of the chat frame for pet battle info messages."] = "Umschalten der Einf\195\164rbung und \195\132nderung des Chatfensters f\195\188r Haustierkampf-Nachrichten." -- Needs review
L["Toggle logging any actions taken to the Spam Log module."] = "Toggle logging any actions taken to the Spam Log module." -- Requires localization
L["Toggle logging anything found to the Spam Log module."] = "Toggle logging anything found to the Spam Log module." -- Requires localization
L["Toggle the monitoring of chat events."] = "Schaltet die \195\156berwachung von Chat-Ereignissen um." -- Needs review
L["Toggle the pet list message when you enter a different zone."] = "Haustierliste umschalten, wenn eine andere Zone betreten wird." -- Needs review
L["Toggle the pet quality notifications when you join a wild pet battle."] = "Toggle the pet quality notifications when you join a wild pet battle." -- Requires localization
L["Toggle the requirement of the Alt key to be pressed to use arrow keys to navigate an editbox."] = "Toggle the requirement of the Alt key to be pressed to use arrow keys to navigate an editbox." -- Requires localization
L["Tooltip"] = "Tooltip" -- Requires localization
L["Total Modules"] = "Anzahl aller Module" -- Needs review
L["Track Pets"] = "Verfolge Haustiere" -- Needs review
L["Track Stable Masters"] = "Track Stable Masters" -- Requires localization
L["Trigger"] = "Ausl\195\182ser" -- Needs review
L["Triggers"] = "Ausl\195\182ser"
L["/tt"] = true -- Needs review
L["Turns the timestamps into a link.\
\
Click the link to copy the chat line.\
Shift+Click the link to send the line to the last chat you used."] = "Turns the timestamps into a link.\
\
Click the link to copy the chat line.\
Shift+Click the link to send the line to the last chat you used." -- Requires localization
L["Unable to load the Alt Name module, please try again."] = "Unable to load the Alt Name module, please try again." -- Requires localization
L["Unbalanced parameter count. Trailing Symbol: |cffffff00%s|r"] = "Unbalanced parameter count. Trailing Symbol: |cffffff00%s|r" -- Requires localization
L["% Unowned"] = "% Unowned" -- Requires localization
L["Unowned Only"] = "Unowned Only" -- Requires localization
L["Unrecognized Symbol: |cffffff00%s|r"] = "Unerkannte Symbole: |cffffff00%s|r" -- Needs review
L["Unset variable |cffffff00%s|r."] = "Unset variable |cffffff00%s|r." -- Requires localization
L["Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement."] = "Update the quest progress when you receive Valor Points.  This will automatically be disabled when you complete the achievement." -- Requires localization
L["Uppercase"] = "Uppercase" -- Requires localization
L["Use Alt Key"] = "Use Alt Key" -- Requires localization
L["Use channel color"] = "Benutze Kanalfarbe"
L["Use Channel Color"] = "Benutze Channel-Farben" -- Needs review
L["Use Coins"] = "Use Coins" -- Requires localization
L["Use coins in the answers instead of abbreviations."] = "Use coins in the answers instead of abbreviations." -- Requires localization
L["Use Custom Color"] = "Verwende Benutzerdefinierte Farbe" -- Needs review
L["Use guildnotes"] = "Benutze Gilden Notizen"
L["Use Level Threshold"] = "Use Level Threshold" -- Requires localization
L["Use Master Channel"] = "Use Master Channel" -- Requires localization
L["Use PlayerNames Coloring"] = "Verwende Einf\195\164rben von SpielerNamen" -- Needs review
L["Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon."] = "Use %sElvUI_CT|r instead of %sElvUI_ChatTweaks|r in messages printed by the addon." -- Requires localization
L["Use Short Name"] = "Use Short Name" -- Requires localization
L["Use Tab Complete"] = "Benutze Tabulator Vervollst\195\164ndigung"
L["Use tab key to automatically complete character names."] = "Mit der Tabulator-Taste automatisch die Charakternamen vervollst\195\164ndigen"
L["Use the master channel when playing the sound."] = "Use the master channel when playing the sound." -- Requires localization
L["Valid Events"] = "G\195\188ltige Ereignisse" -- Needs review
L["valor"] = "Tapferkeit" -- Needs review
L["  Valor Points\
"] = "  Tapferkeitspunkte\
" -- Needs review
L["Valor Points"] = "Valor Points" -- Requires localization
L["Variable |cffffff00%s|r is set to |cff00ff00%s|r."] = "Variable |cffffff00%s|r is set to |cff00ff00%s|r." -- Requires localization
L["Variable |cffffff00%s|r set to |cff00ff00%s|r."] = "Variable |cffffff00%s|r set to |cff00ff00%s|r." -- Requires localization
L["Various Developer Tools"] = "Verschiedene Entwickler-Tools" -- Needs review
L["Version"] = true -- Needs review
L["Version: |cff1784d1%s|r"] = true -- Needs review
L["Version %s%s|r is loaded. Type %s/ct|r if you need help."] = "Version %s%s|r is loaded. Type %s/ct|r if you need help." -- Requires localization
L["Very doubtful."] = "Sehr Zweifelhaft." -- Needs review
L["vp"] = "vp" -- Requires localization
L["vpcap"] = "vpcap" -- Requires localization
L["Warlock"] = "Hexenmeister"
L["WARLOCK"] = "HEXENMEISTER" -- Needs review
L["Warrior"] = "Krieger"
L["WARRIOR"] = "KRIEGER" -- Needs review
L["Welcome Message"] = "Willkommens Nachricht" -- Needs review
L["Welcome Messages"] = "Willkommensnachrict"
L["What to do with Recount/Skada/TinyDPS reports in this channel."] = "Was tun, wenn Recount/Skada/TinyDPS-Daten in dem Kanal gepostet werden."
L["What to show on the datatext."] = "What to show on the datatext." -- Requires localization
L["When an ElvUI keyword is found it will show the message in a popup frame."] = "When an ElvUI keyword is found it will show the message in a popup frame." -- Requires localization
L["    When I first started using ElvUI around the beginning of Cataclysm's release I noticed that there were some chat functionality that I wanted, but wasn't included with ElvUI.  I came across Prat and Chatter, but found that they had too many modules that I didn't want and both addons do use a fair bit of memory.  So I decided to write my own version, which is when ElvUI_ChatTweaks was born.  Since then I have made sure that this addon is as bug free as possible, as well as being up to date with the latest API available, and I am constantly adding new functionality.  If there's any features you'd like to see added please contact me and I'll see what I can do.\
\
Thanks,\
|cffffff00Lockslap|r"] = "    When I first started using ElvUI around the beginning of Cataclysm's release I noticed that there were some chat functionality that I wanted, but wasn't included with ElvUI.  I came across Prat and Chatter, but found that they had too many modules that I didn't want and both addons do use a fair bit of memory.  So I decided to write my own version, which is when ElvUI_ChatTweaks was born.  Since then I have made sure that this addon is as bug free as possible, as well as being up to date with the latest API available, and I am constantly adding new functionality.  If there's any features you'd like to see added please contact me and I'll see what I can do.\
\
Thanks,\
|cffffff00Lockslap|r" -- Requires localization
L["When setting a variable the variable name must be the first parameter."] = "When setting a variable the variable name must be the first parameter." -- Requires localization
L["Whisper"] = "Fl\195\188stern"
L["Whisper Answer"] = "Fl\195\188ster Antwort" -- Needs review
L["Whisper Filter"] = "Fl\195\188stern- Filter"
L["Whisper Messages"] = "Fl\195\188ster-Nachrichten"
L["Whisper Options"] = "Fl\195\188ster-Optionen"
L["Whispers"] = "Fl\195\188stern"
L["Whisper the response to the person.  Otherwise it will be answered in the same channel the request was sent."] = "Fl\195\188ster die Antwort an die Person. Sonst wird es im selben Kanal geantwortet in dem die Anfrage gesendet wurde." -- Needs review
L["Who"] = "Wer"
L["Who: |cffffff00%s|r, Roll: |cffffff00%s|r, Min: |cffffff00%s|r, Max: |cffffff00%s|r"] = "Who: |cffffff00%s|r, Roll: |cffffff00%s|r, Min: |cffffff00%s|r, Max: |cffffff00%s|r" -- Requires localization
L["Who is %s's main?"] = "Wie hei\195\159t %s's Hauptcharakter?" -- Needs review
L["Who to Congratulate?"] = "Wem Gratulieren?"
L["Will automatically set your role based on your spec, when appropriate."] = "Will automatically set your role based on your spec, when appropriate." -- Requires localization
L["Will save all data for large /who queries"] = "Speichert bei gro\195\159en /wer Anfragen alle Daten"
L["Win Color"] = "Win Color" -- Requires localization
L["Without a doubt."] = "Ohne Zweifel." -- Needs review
L["Words or phrases that will trigger the filtering."] = "W\195\182rter oder Phrasen die die Filterung ausl\195\182sen" -- Needs review
L["XP Left To Level"] = "EPs ben\195\182tigt zum Aufstieg" -- Needs review
L["Year"] = "Jahr" -- Needs review
L["Yell"] = "Schreien"
L["Yell Chat"] = "Schreien-Chat"
L["Yes"] = "Ja" -- Needs review
L["Yes, definitely."] = "Ja, eindeutig." -- Needs review
L["You are missing %s%d|r pets."] = "You are missing %s%d|r pets." -- Requires localization
L["You are running version |cff1784d1%s|r."] = "Du verwendest Version |cff1784d1%s|r." -- Needs review
L["You asked: %s"] = "Du fragtest: %t" -- Needs review
L["You can only send a request once every %d seconds.  You last sent a request at %s."] = "Du kannst nur alle %d Sekunden eine Anfrage schicken. Deine letzte Anfrage war um %s."
L["You have |cff9382c9Chatter|r running, which is incompatible with this addon.  Please disable it."] = "Du verwendest das Addon |cff9382c9Chatter|r, welches nicht kompatibel ist, bitte deaktiviere es." -- Needs review
L["You have |cff9382c9Prat-3.0|r running, which is incompatible with this addon.  Please disable it."] = "Du verwendest das Addon |cff9382c9Prat-3.0|r, welches nicht kompatibel ist, bitte deaktiviere es." -- Needs review
L["You have |cff%s%d|r of %s."] = "Du hast |cff%s%d|r %s." -- Needs review
L["You have |cff%s%d|r of %s, you need |cff%s%d|r more. |cff%s(%d/%d)|r"] = "Du hast |cff%s%d|r %s, du ben\195\182tigst |cff%s%d|r mehr. |cff%s(%d/%d)|r" -- Needs review
L["You have met your quota of %s%s. |cff%s(%d/%d)|r"] = "You have met your quota of %s%s. |cff%s(%d/%d)|r" -- Requires localization
L["You have reached the maximum number of friends, please remove 2 for this module to function properly."] = "Du hasst die maximale Anzahl von Freunden erreicht, bitte entferne 2 um eine korrekte Funktion zu gew\195\164hleisten." -- Needs review
L["You have %s%d (%d unique, %d duplicates)|r pets."] = "You have %s%d (%d unique, %d duplicates)|r pets." -- Requires localization
L["You have %s%d|r duplicate pets."] = "You have %s%d|r duplicate pets." -- Requires localization
L["You have %s%d|r mounts."] = "You have %s%d|r mounts." -- Requires localization
L["You have %s%d|r unique pets."] = "You have %s%d|r unique pets." -- Requires localization
L["You may rely on it."] = "Du kann dich drauf verlassen." -- Needs review
L["You must provide a calculation or set a variable."] = "You must provide a calculation or set a variable." -- Requires localization
L["You must wait ~7 seconds between reports to avoid being disconnected."] = "You must wait ~7 seconds between reports to avoid being disconnected." -- Requires localization
L["You need %s%s%s%sto hit level %d."] = "You need %s%s%s%sto hit level %d." -- Requires localization
L["Your Color"] = "Deine Farbe" -- Needs review
L["Your Version: |cffffff00%d|r, Latest Version: |cffffff00%d|r"] = "Deine Version: |cffffff00%d|r, Neuste Version: |cffffff00%d|r" -- Needs review
L["Your version of %s is out of date.  Latest version is |cff1784d1%d|r."] = "Deine Version von %s ist veraltet, neuste Version ist |cff1784d1%d|r." -- Needs review
L["Zone List"] = "Zone List" -- Requires localization

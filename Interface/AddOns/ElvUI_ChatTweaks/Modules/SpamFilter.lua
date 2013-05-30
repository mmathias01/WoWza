-------------------------------------------------------------------------------
-- ElvUI Chat Tweaks By Lockslap (US, Bleeding Hollow)
-- <Borderline Amazing>, http://ba-guild.com
-- Based on functionality provided by Prat and/or Chatter
-------------------------------------------------------------------------------
-- Based on BadBoy by funkydude
local Module = ElvUI_ChatTweaks:NewModule("Spam Filter", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_ChatTweaks", false)
Module.name = L["Spam Filter"]
Module.namespace = string.gsub(Module.name, " ", "")

local prevLineID, prevWarn, result = 0, 0, nil
local chatLines, chatPlayers = {}, {}
local reportMessage = L["|cffffffffBlocked spam from |Hplayer:%s|h[%s]|h,|r |cfffe2ec8|Hspamfilter:%d:%s|h[Click to report!]|h|r"]

local db, options
local defaults = {
	profile = {
		noMessage = true,
		noReport = false,
		manualReport = false,
		logging = true,
	}
}

do
	local report = {}
	local OnHyperlinkShow = ChatFrame_OnHyperlinkShow
	ChatFrame_OnHyperlinkShow = function(self, data, ...)
		local spamFilter, line, player = strsplit(":", data)
		if spamFilter and spamFilter == "spamfilter" then
			line = tonumber(line)
			if CanComplainChat(line) and not report[player] then
				report[player] = true
				ReportPlayer("spam", line)
			end
			return
		end
		OnHyperlinkShow(self, data, ...)
	end
end

--[[ Configure popup reporting ]]--
StaticPopupDialogs["CONFIRM_REPORT_SPAM_CHAT"].OnHide = function(self)
	self.text:SetText(REPORT_SPAM_CONFIRMATION) --Reset popup message to default for manual reporting
end

local function FindSpam(message, find, points, change)
	return message:find(find) and points + change or points
end

local function IsSpam(message, num)
	-- automatic spam list
	for i = 1, #Module.instantReport do
		if message:find(Module.instantReport[i]) then
			return true
		end
	end
	
	local points, phishPoints = num, num
	for i = 1, #Module.whiteList do
		points = FindSpam(message, Module.whiteList[i], points, -2)
		phishPoints = FindSpam(message, Module.whiteList[i], phishPoints, -2)
	end
	
	for i = 1, #Module.common do
		points = FindSpam(message, Module.common[i], points, 1)
	end
	
	for i = 1, #Module.heavy do
		points = FindSpam(message, Module.heavy[i], points, 2)
	end
	
	for i = 1, #Module.heavyRestricted do
		if message:find(Module.heavyRestricted[i]) then
			points = points + 2
			phishPoints = phishPoints + 2
			break
		end
	end
	
	for i = 1, #Module.phishing do
		phishPoints = FindSpam(message, Module.phishing[i], phishPoints, 1)
	end
	
	-- >3 points for either means its spam
	if points > 3 or phishPoints > 3 then return true end
end

local function Filter(_, event, message, player, _, _, _, flag, channel, _, _, _, line)
	local origMessage = message
	if line == prevLine then
		return result
	else
		if not line then
			local t = GetTime()
			if t - prevWarn > 60 then
				prevWarn = t
				Module:Print(L["|cffffff00One of your addons is breaking critical chat data I need to work properly :(|r"])
			end
			return
		end
		prevLine = line
		
		if event == "CHAT_MSG_CHANNEL" and channel == 0 then result = nil; return end
		if not CanComplainChat(line) or UnitIsInMyGuild(player) or UnitInRaid(player) or UnitInParty(player) then result = nil; return end
		if event == "CHAT_MSG_WHISPER" then
			if flag == "GM" then result = nil; return end
			for i = 1, select(2, BNGetNumFriends()) do
				local toons = BNGetNumFriendToons(i)
				for j = 1, toons do
					local _, rName, rGame = BNGetFriendToonInfo(i, j)
					if rName == player and rGame == "WoW" then result = nil; return end
				end
			end
		end
	end
	
	local debug = message
	message = message:lower()
	
	-- strip raid icons
	local icon = 0
	if message:find("{", nil, true) then
		local found = 0
		for i = 1, #Module.icons do
			-- strip the icons
			message, found = message:gsub(Module.icons[i], "")
			if found > 0 then icon = 1 end
		end
	end
	
	-- strip spaces, symbols, etc.
	message = message:gsub("[“”%*%-%(%)\"`'_%+#%%%^&;:~{} ]+", "")
	
	-- they like to replace English letters with UTF-8 "equivalents" to avoid detection
	if message:find("[аàáäâãåсçеèéëёêìíïîΜмоòóöōôõùúüû]+") then
		for index, value in pairs(Module.replacements) do
			message = message:gsub(index, value)
		end
	end
	
	for i = 1, #chatLines do
		if chatLines[i] == message and chatPlayers[i] == player then
			result = true
			return true
		end
		if i == 20 then
			tremove(chatLines, 1)
			tremove(chatPlayers, 1)
		end
	end
	tinsert(chatLines, message); tinsert(chatPlayers, player)
	
	if IsSpam(message, icon) then
		if db.manualReport then
			StaticPopupDialogs["CONFIRM_REPORT_SPAM_CHAT"].text = "Spam Filter: ".. REPORT_SPAM_CONFIRMATION .."\n\n".. debug:gsub("%%", "%%%%")
			local dialog = StaticPopup_Show("CONFIRM_REPORT_SPAM_CHAT", player)
			dialog.data = line
		else
			if not db.noReport then Module:Print(reportMessage:format(player, player, line, player)) end
			
			-- debugging
			if Module.debug then Module:Print(("%s: %s"):format(player, message)) end
		end
		--Module:Print(message)
		
		if db.logging and Module.log:IsEnabled() then
			Module.log:AddToLog("spam", event, player, origMessage)
		end
		
		result = true
		return true
	end
	result = nil
end

function Module:OnEnable()
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", Filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", Filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", Filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", Filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", Filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", Filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", Filter)
	
	-- let blizzard's spam filter help us
	SetCVar("spamFilter", 1)
	
	self.log = ElvUI_ChatTweaks:GetModule("Spam Log")
end

function Module:OnDisable()
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", Filter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", Filter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", Filter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", Filter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_EMOTE", Filter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_DND", Filter)
	ChatFrame_RemoveMessageEventFilter("CHAT_MSG_AFK", Filter)
end

function Module:OnInitialize()
	self.db = ElvUI_ChatTweaks.db:RegisterNamespace(Module.namespace, defaults)
	db = self.db.profile
	self.debug = ElvUI_ChatTweaks.db.profile.debugging
end

function Module:GetDefaults()
	return defaults
end

function Module:Info()
	return L["Determines if a chat message is deemed spam, at which point it can be filtered and the person reported."]
end

function Module:GetOptions()
	if not options then
		options = {
			noMessage = {
				type = "toggle",
				order = 13,
				name = L["Suppress report message."],
				desc = L["Hide the spam blocked message asking you to report the person."],
				get = function() return db.noMessage end,
				set = function(_, value) db.noMessage = value end,
			},
			noReport = {
				type = "toggle",
				order = 14,
				name = L["Don't Report"],
				desc = L["Please DON'T use this. Reporting the spam is what gets the hacked accounts used by\nthe spammers closed down and realms cleaned up. Also, if many people report a spammer,\nthen that spammer looses the ability to chat meaning they can no longer spam, this benefits\neveryone."],
				get = function() return db.noReport end,
				set = function(_, value) db.noReport = value end,
			},
			manualReport = {
				type = "toggle",
				order = 15,
				name = L["Show Spam Popup"],
				desc = L["Show a report player popup (showing the spam) instead of printing in chat"],
				get = function() return db.manualReport end,
				set = function(_, value) db.manualReport = value end,
			},
			logging = {
				type = "toggle",
				order = 16,
				name = L["Enable Logging"],
				desc = L["Toggle logging anything found to the Spam Log module."],
				get = function() return db.logging end,
				set = function(_, value) db.logging = value end,
			},
		}
	end
	return options
end

-- spam lists, from BadBoy
Module.common = {
	--English
	"bonus",
	"buy",
	"cheap",
	"code",
	"coupon",
	"customer",
	"deliver",
	"discount",
	"express",
	"g[0o]ld",
	"lowest",
	"order",
	"powerle?ve?l",
	"price",
	"promoti[on][gn]",
	"reduced",
	"rocket",
	"sa[fl]e",
	"server",
	"service",
	"stock",
	"trusted",
	"well?come",

	--French
	"livraison", --delivery
	"moinscher", --least expensive
	"prix", --price
	"commande", --order

	--German
	"billigster", --cheapest
	"lieferung", --delivery
	"preis", --price
	"willkommen", --welcome

	--Spanish
	"barato", --cheap
	"gratuito", --free
	"rapid[oe]", --fast [[ esES:rapido / frFR:rapide ]]
	"seguro", --safe/secure
	"servicio", --service

	--Chinese
	"金币", --gold currency
	"大家好", --hello everyone

	--Russian
	"з[o0]л[o0]т[ao0]", --gold
	"гoлд", --gold
	"дocтaвкa", --delivery
	"cкидкa", --discount [russian]
	"oплaт", --payment [russian]
	"прoдaжa", --sale [serbian]
	"нaличии", --stock/presence
	"цeнe", --price [serbian]
	"пoкупкe", --buy/buying/purchase [russian]
	"купи", --buy [serbian]
	"быcтрo", --fast/quickly
	"ищemпocтaвщикoв", --ищем поставщиков --looking for suppliers
	"[%.,]ru", --really can't risk any more TLDs for 2 points (Heavy Strict) until Blizz implements my requests to reduce FPs, which will probably be never
}

Module.heavy = {
	"ourgamecenter[<c][o0@]m", --March 12
	"cicigamec[o0@]m", --April 12
	"[\226\130\172%$\194\163]+%d+.?%d*[fp][oe]r%d+[%.,]?%d*[kg]", --Add separate line if they start approx prices
	"[\226\130\172%$\194\163]+%d+[%.,]?%d*[/\\=]%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*eur?o?s?[fp][oe]r%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*[\226\130\172%$\194\163]+[/\\=>]+%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*[kg][/\\=][\226\130\172%$\194\163]+%d+",
	"%d+[%.,]?%d*[kg][/\\=]%d+[%.,]?%d*[\226\130\172%$\194\163]+",
	"%d+[%.,]?%d*[kg][/\\=]%d+[%.,]?%d*e[uv]",
	"%d+[%.,]?%d*[kg][%.,]?only%d+[%.,]?%d*eu",
	"%d+[%.,]?%d*[kg]for%d+[%.,]?%d*eu",
	"%d+o?[kg][/\\=]%$?%d+[%.,]%d+", --1OK=9.59
	"%d+[%.,]?[%do]*[/\\=]%d+[%.,]?%d*[kge]",
	"%d+[%.,]?%d*eur?[o0]?s?[/\\=<>]+%d+[%.,]?[%do]*[kg]",
	"%d+[%.,]?%d*eur?[o0]?s?[/\\=<>]+l[0o]+[kg]",
	"%d+[%.,]?%d*usd[/\\=]%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*usd[fp][oe]r%d+[%.,]?%d*[kg]",
	"%d+[%.,]?%d*[kg][/\\=]%d+[%.,]?%d*usd",
	"%d+[%.,]?[o%d]*[kg]%d+bonus[/\\=]%d+[%.,]?[o%d]+",
	"%d+[%.,]?%d*[кр]+зa%d+[%.,]?%d*[рк]+", --14к за 21р / 17р за 1к
}

Module.heavyRestricted = {
	"www[%.,]",
	"[%.,]c[%.,]*[o0@][%.,]*m",
	"[%.,]net",
	"dotc[o0@]m",
}

Module.icons = {
	"{%l%l%d}",
	"{цр%d}",
	"{star}",
	"{circle}",
	"{diamond}",
	"{triangle}",
	"{moon}",
	"{square}",
	"{cross}",
	"{x}",
	"{skull}",
	"{diamant}",
}

Module.phishing = {
	--English
	"account",
	"blizz",
	"claim",
	"congratulations",
	"free",
	"gamemaster",
	"gift",
	"investigat", --investigate/investigation
	"launch",
	"log[io]n",
	"luckyplayer",
	"mount",
	"pleasevisit",
	"receive",
	"service",
	"surprise",
	"suspe[cn][td]", --suspect/suspend
	"system",
	"validate",

	--German
	"berechtigt", --entitled
	"erhalten", --get/receive
	"deaktiviert", --deactivated
	"konto", --acount
	"kostenlos", --free
	"qualifiziert", --qualified
}

Module.whiteList = {
	"recrui?t",
	"dkp",
	"lookin?g", --guild
	"lf[gm]",
	"|cff",
	"raid",
	"roleplay",
	"apply",
	"contender", --Contender's Silk
	"enjin",
	"guildlaunch",
	"wowstead",
	"social",
	"fortunecard",
	"house",
	"progres",
	"transmor?g",
	"arena",
	"boost",
	"player",
	"portal",
	"town",
	"vialofthe",
	"[235]v[235]",
	"sucht", --de
	"gilde", --de
	"rekryt", --se
	"soker", --se
	"kilta", --fi
	"etsii", --fi
	"sosyal", --tr
	"дкп", --ru, dkp
	"рeкрут", --ru, recruit
	"нoвoбрaн", --ru, recruits
	"лфг", --ru, lfg
	"рeйд", --ru, raid
}

Module.instantReport = {
	--[[  Personal Whispers  ]]--
	"so?rr?y.*%d+[kg].*stock.*buy", --sry to bother, we have 60k g in stock today. do u wanna buy some?:)
	"server.*purchase.*gold.*deliv", --sorry to bother,currently we have 29200g on this server, wondering if you might purchase some gold today? 15mins delivery:)
	"free.*powerleveling.*level.*%d+.*interested", --Hello there! I am offering free powerleveling from level 70-80! Perhaps you are intrested? :)v
	"friend.*price.*%d+k.*gold", --dear friend.. may i tell you the price for 10k wow gold ?^^
	"we.*%d+k.*stock.*realm", --hi, we got 25k+++ in stock on this realm. r u interested?:P
	"we.*%d+k.*gold.*buy", --Sorry to bother. We got around 27.4k gold on this server, wondering if you might buy some quick gold with face to face trading ingame?
	"so?rr?y.*interest.*cheap.*gold", --sorry to trouble you , just wondering whether you have  any interest in getting some cheap gold at this moment ,dear dude ? ^^
	"we.*%d+k.*stock.*interest", --hi,we have 40k in stock today,interested ?:)
	"we.*%d%d%d+g.*stock.*price", --hi,we have the last 23600g in stock now ,ill give you the bottom price.do u need any?:D
	"hi.*%d%d+k.*stock.*interest", --hi ,30k++in stock any interest?:)
	"wondering.*you.*need.*buy.*g.*so?r?ry", --I am sunny, just wondering if you might need to buy some G. If not, sry to bother.:)
	"buy.*wow.*curr?ency.*deliver", --Would u like to buy WOW CURRENCY on our site?:)We deliver in 5min:-)
	"interest.*%d+kg.*price.*delive", --:P any interested in the last 30kg with the bottom price.. delivery within 5 to 10 mins:)
	"sorr?y.*bother.*another.*wow.*account.*use", --Hi,mate,sorry to bother,may i ask if u have another wow account that u dont use?:)
	"hello.*%d%d+k.*stock.*buy.*now", --hello mate :) 40k stock now,wanna buy some now?^^
	"price.*%d%d+g.*sale.*gold", --Excuse me. Bottom price!.  New and fresh 30000 G is for sale. Are you intrested in buying some gold today?
	"so?rr?y.*you.*tellyou.*%d+k.*wow.*gold", --sorry to bother you,may i tell you how much for 5k wow gold
	"excuse.*do.*need.*buy.*wow.*gold", --Excuse me,do u need to buy some wowgold?
	"bother.*%d%d%d+g.*server.*quick.*gold", --Sry to bother you, We have 57890 gold on this server do you want to purchase some quick gold today?
	"hey.*interest.*some.*fast.*%d+kg.*left", --hey,interested in some g fast?got 27kg left atm:)
	"know.*need.*buy.*gold.*delivery", --hi,its kitty here. may i know if you need to buy some quick gold today. 20-50 mins delivery speed,
	"may.*know.*have.*account.*don.*use", -- Hi ,May i know if you have an useless account that you dont use now ? :)
	"company.*le?ve?l.*char.*%d%d.*free", --our company  can lvl your char to lvl 80 for FREE.
	"so?r?ry.*need.*cheap.*gold.*%d+", --sorry to disurb you. do you need some cheap gold 20k just need 122eur(108GBP)
	"stock.*gold.*wonder.*buy.*so?rr?y", --Full stock gold! Wondering you might wanna buy some today ? sorry for bothering you.
	"hi.*you.*need.*gold.*we.*promotion", --[hi.do] you need some gold atm?we now have a promotion for it ^^
	"brbgame.*need.*gold.*only.*fast.*deliver", --sry to bother i am maria from brbgame, may i pease enquire as to whether u r in need of wow gold ?:P only 3$ per k with fast delivery !\
	"so?r?ry.*bother.*still.*%d+k.*left.*buy.*gold", --sry to bother you ,we still have around 52k left atm, you wanna buy some gold quickly today ?
	"may.*ask.*whether.*interest.*ing.*boe.*stuff.*rocket", --hmm, may i ask whether u r interested in g or boe stuffs such as X-53 Touring Rocket:P

	--[[  Casino  ]]--
	"%d+.*d[ou][ub]ble.*%d+.*trip", --10 minimum 400 max\roll\61-97 double, 98-100 triple, come roll,
	"casino.*%d+x2.*%d+x3", --{star} CASINO {star} roll 64-99x2 your wager roll 100x3 your wager min bet 50g max 10k will show gold 100% legit (no inbetween rolls plz){diamond} good luck {diamond}
	"casino.*%d+.*double.*%d+.*tripp?le", --The Golden Casino is offering 60+ Doubles, and 80+ Tripples!
	"casino.*whisper.*info", --<RollReno's Casino> <Whisper for more information!>
	"d[ou][ub]ble.*%d+.*tripp?le", --come too the Free Roller  gaming house!  and have ur luck of winning gold! :) pst me for invite:)  double is  62-96 97-100 tripple we also play blackjack---- u win double if you beat the host in blackjack
	"casino.*bet.*%d+", --Casino time. You give me your bet, Than You roll from 1-11 unlimited times.Your rolls add up. If you go over 21 you lose.You can stop before 21.When you stop I do the same, and if your closer to 21 than me than you get back 2 times your bet
	"roll.*%d+.*roll.*%d+.*bet", --Roll 63+ x2 , Roll 100 x3, Roll 1 x4 NO MAX BETS
	"casino.*roll.*double", --CASINO IS BACK IN TOWN COME PAY ME ROLL +65 AND GET DOUBLE
	"casino.*roll.*%d+.*roll.*%d+", --Casino is back in town !! Roll over 65 + and get your gold back 2X !!  Roll 100 and get your gold back 3X !!
	"double.*tripp?le.*casino", --Hey there wanna double your money in casino? or triple or even quad it? give me a whisp if you want to join my casino :)

	--[[  Runescape Trading  ]]--
	--WTB RS gold paying WoW GOLD
	"wt[bs]rsgold.*wowgold", --WTB rs gold trading wow gold PST
	"wt[bs]wowgold.*rsgold", --WTS Wow gold for rs gold
	"wt[bs]wowgold.*rscoint?s", --WTS Wow gold for rs coints
	--WTS RUNESCAPE GOLD !~!~!~ PST
	--WTB RUNESCAPE GOLD WITH WOW GOLD PST
	"wt[bs]runescapegold", --WTB Runescape Gold, Trading WOW Gold, PST -- I will trade first.
	"exchangingrsgold", --Exchanging RS gold for WoW gold. I have 400m PST
	--WTS level 25 guild with 80k gold for runescape gold
	"goldforrunescapegold", --Exchanging WoW gold for Runescape gold pst me better price for higher amount.
	"buying?runescapeg", --buyin runescape g
	"wt[bs]runescapeaccount", --WTB runescape accounts ( pure only ) or money! i pay with wow gold. GOT 170k gold atm.
	"wt[bs]runescapepure", --WTB runescape pure ( STR PURE IS A $$ PAYING EXTRA FOR STR PURE )!
	--WTB big amount of runescape money. 2mil = 1k gold. ONLY LEGIT PEOPLE.
	"wt[bs].*runescapemoney.*%d+k", --WTB runescape money. 3mil = 1k in wow! easy money making.
	"^wt[bs]rsaccount", --wts rs acount 10k .... lvl 95 with items for over 15 mil with 6 year old holiday
	"^wt[bs]%d+rsaccount", --WTS 137 RS ACCOUNT /W ME
	--WTS awesome rs account with 99's /w me
	--WTS an awesome rs account /w me details
	"^wt[bs]a?n?awesomersaccount", --wts awesome rs account /w me
	"runescapegoldforwowgold", --Selling my runescape gold for wow gold

	--[[  Dota 2 ]]--
	"^wtsdota2.*key", --wts dota 2beta key 10k

	--[[  Steam  ]]--
	"^wtssteamaccount", --WTS Steam account with 31 games (full valve pack+more) /w me with offers

	--[[  League of Legends  ]]--
	"^wt[bs]lolacc$", --WTB LoL acc
	"^wt[bs]%d?x?leagueoflegends?account", --WTS 2x League of Legend accounts for 1 price !
	"^wt[bs]lolaccount", --WTS LOL ACCOUNT LEVEL 30 with 27 SKINS and 14k IP

	--[[  Account Buy/Sell  ]]--
	"wtsnonemergeacc.*lvl?%d+char", --!WTS none-merge acc(can get a lv80 char)./W me for more info!
	--! WTS lvl 80 char.{all class}.Diablo3 g0ld /W me for more info !
	--^{diamond}lv80 char all class./w me for more info if you WTB^
	"lvl?%d+char%.?allclass.*info", --^{Square} WTS lvl 80 char all class ! /w me for more info{square}^
	"lvl?%d+char.*fast.*g[o0]ld", --# WTS lvl 80 char .TCG mount.cheap fast D3 g0ld/w me for more #
	"%d+lvloldaccounts?tosell", --80lvl old account to sell
	"wtswowaccount.*epic", --y WTS WOW ACCOUNT 401 ITEM LEVEL ROGUES WITH FIRST STAGE LEGENDARY FULL CATA!! WITH 1X VIAL OF SANDS/CRIMSON DEATHCHARGER FULL EPIC GEMED 1X ROGUE 1 X WARRIOR PVP AIMED ADD SKYPE * AND I ALSO HAVE FULL HIERLOOM FOR EVER SINGLE CHARACTER A
	"^wanttotradeaccount", --Want to trade account full cata rogue on * with full epic 50 agil gems(vial of the sands and crimson dk and warrior with 1 cata and mechanohog it is on * wt t for a class with full cata on * /w me!!!!!
	"^wttacc.*epic.*mount.*/w", --WTT ACC MINE HAS FULL CATA+FULL EPIC GEMS  ROGUE WITH NICE MOUNTS WTT FOR AND ACC WITH FULL CATA  RESTO SHAMAN!! /W ME!!
	"^wttacc?ount.*gear.*char", --WTT Acount Resto/Enha shaman / Resto / Balance druid / Prot warr / Mage / Paladin for just one full cata geared pvp character /w me with info
	--WTS wow account 85human Rogue with LEGENDARIES + JC BS.  u pay with gold./w me for more info
	"^wt[st]wowaccount", --WTT Wow account /w me for more info
	"^wtsaccount.*gametime", --WTS Account with free lvl 80 And GAME  TIME!! /w me
	"^wt[bs]mopcode", --WTS MoP Code /w me for info
	"^wttaccountfor.*youget.*tier", --WTT Account for a 90 tier 1 ROGUE, you get 90mage(tier1)90druid (tier1) 85 priest, 85 rogue, 85 warrior /wme
	"^wttaccountwith.*90.*tier", --WTT ACCOUNT with 90 mage(TIER1) 90 Feral (TIER1) 85 priest, 85 warrior, 85 rogue for 90 ROGUE with TIER 1/wme

	--[[  Brazzers, yes, really...  ]]--
	"sell.*brazzersaccount.*info", --Hey there! I'm here to sell you Brazzers account /w me for more info!
	"^wtsbrazzersaccount", --WTS BRAZZERS ACCOUNT UNLIMITED TIME /W OFFER

	--[[  Diablo 3  ]]--
	"^wttrade%d+kgold.*diablo", --WT trade 6k gol;d for 300k in diablo 3. /w me
	"^wttwowgold.*diablo", --WTT wow gold for diablo gold. /w if interested.
	"^wtbd3forgold", --WTB D3 for gold!
	--SELLING DIABLO 3 / 60 DAYS PREPAIDGAMECARD - PRICES IN DND!! CHEAP
	"^sellingdiablo3", --Selling Diablo 3 CD Key.Fast & Smooth Deal.
	"^sellingd3account", --Selling D3 account cheap /w for more !
	"^wtscheapfastd3g", --*WTS cheap fast D3 G,/W for skype*
	"^wt[bs]d3key", --WTs D3 key Wisp me for info and price!
	"^wts.*%d+day.*diablo.*account", --WTS [Winged Guardian] [Heart of the Aspects] [Celestial Steed]Each 22k gc90days=30Kdiablo III Account for=70k
	"tradediablo3?goldforwowgold", --anyone want to trade diablo gold for wow gold?
	--SELLING 60 DAYS GAMECARD - VERY CHEAP - ALSO SELL DIABLO ! -SAFE
	"^selling.*gamecard.*diablo", --SELLING 60 DAY GAMECARDS & DIABLO 3!!!!
	"^wt[bs]d3account", --WTS D3 account /w for more !
	"^wtsd3.*transfer.*item", --WTS D3/faction/race change server transfer and other items!
	--WTS Diablo 3 code 30 K !!
	--WTS Diablo 3 CD KEY
	--WTB Diablo 3 key cheap
	--WTB Diablo3 Gold for WoW Gold! /w me D3Gold per WoWGold!
	"^wt[bs]diablo3", --WTB Diablo 3 Gold!
	--WTB WOW GOLDS WITH D3 GOLDS ASAP
	"^wt[bst]wowgold.*d3gold", --WTT Wow Gold For D3 Gold! /w me with your price!
	"wowgoldford3gold", --T> My WoW gold for D3 gold
	--T> My WoW gold for Diablo 3 gold
	--Trading My WoW gold for Diablo 3 gold
	"wowgold.*fordiablo3?gold", --T> My WoW gold (15,000g) for Diablo 3 gold
	"tradediablo3?gold.*wowgold", --LF someone that wants to trade diablo 3 gold for my wow gold
	"^wt[bs]diablogold", --wtb diablo gold for wow gold!

	--[[  Illegal Items ]]--
	"%[.*%].*%[.*%].*facebook.com/buyboe", --Win Free[Volcano][Spire of Scarlet Pain][Obsidium Cleaver]from a simple contest, go www.facebook.com/buyboe now!
	--WTS 6PETS [Cenarion Hatchling],Lil'Rag,XT,KT,Moonkin,Panda 8K each;Prepaid gametimecard 10K;Flying Mounts[Winged Guardian],[Celestial Steed]20K each.
	"wts.*gamet?i?m?e?card.*mount", --WTS 90 Day Pre-Paid Game Card 35K Also selling mount from BLZ STORE,25k for golden dragon/lion
	--if you want buy pets/ mounts/gametimecard/ Spectral Tiger/whisper me!^^
	"pets.*mount.*gametimecard", --wts 6pets .mounts .rocket. gametimecard .Change camp. variable race. turn area. change a name. ^_^!
	"wts.*gametime.*mount.*pet", --WTS Prepaid gametime code 8k per month. the mount [Winged Guardian]'[Celestial Steed] 15K each and the pets 6k each, if u are interested,PST
	"wts.*monthgametime.*%d+k", --WTS 1 Month Gametime 10k. 3 Month Gameitme 25k. 6 Month Gametime 40k
	"wts.*gamet?i?m?e?card.*gold", --wts 60days gamecard for gold /w for more info.
	--[Winged Guardian] 25k  [Heart of the Aspects]25k  [Celestial Steed]20k and prepaid gametimecard
	"%[.*%].*%[.*%].*gamet?i?m?e?card", --wts [Heart of the Aspects]25k [Winged Guardian]25k and prepaid gametimecard
	--WTS [Heart of the Aspects]25K [Winged Guardian]25K [Celestial Steed]20K AND prepaid gametimecard
	--WTS [Celestial Steed]  [Winged Guardian]  [Heart of the Aspects] and prepaid gametimecard / 60k for half year
	"wts.*steed.*gamet?i?m?e?card", --{skull} WTS Winged Guardian 15K.Heart of the Aspects 15K Celestial Steed 15K 90 Day Pre-Paid Game Card 35K {skull}
	--VK [Phiole der Sande][Theresas Leselampe][Maldos Shwertstock],25 Minuten Lieferung auf <buyboe(dot)de>
	"%[.*%].*buyboe.*dot.*[fcd][ro0e]", --WTS [Theresa's Booklight] [Vial of the Sands] [Heaving Plates of Protection] 15mins delivery on<buyboe dot com>
	"code.*hatchling.*gamet?i?m?e?card", --WTS Codes redeem:6PETS [Cenarion Hatchling],Lil Rag,KT,XT,Moonkin,Pandaren 5k each;Prepaid gametimecard 6K;Flying mount[Celestial Steed] 15K.PST
	"gamet?i?m?e?card.*deliver", --{rt6}{rt1} 19=10k,90=51K+gamecard+rocket? deliver10mins
	--40$ for 10k gold or 45$ for  10k gold + 1 rocket  + one month  time card  .   25$ for  a  rocket .  we have  all boe items and 264 gears selled . if u r interested in .  plz whsiper me . :) ty
	--$45=10k + one X-53 Touring Rocket, $107=30K + X-53 Touring Rocket, the promotion will be done in 10 minutes, if you like it, plz whisper me :) ty
	"%$.*rocket.*%$.*rocket.*ple?a?[sz]", --$45 for 10k with a rocket {star} and 110$ for 30k with a Rocket{moon},if you like,plz pst
	--WTS X-53 Touring Rocket.( the only 2 seat flying mount you can aslo get a free month game time) .. pst
	--WTS [X-53 Touring Rocket], the only 2seats flying mount, PST
	"wts.*touringrocket.*mount", --!!!!!! WTS*X-53 TOURING ROCKET Mount(2seats)for 10000G (RAF things), you also can get a free month game time,PST me !!!
	"^wts.*x53touringrocket", --WTS[Celestial Steed],[X-53 Touring Rocket],Race,Xfer 15K,TimeCard 6K,[Cenarion Hatchling]*Rag*KT*XT*Moonk*Panda 5K
	"wts.*g[o0][1l]d.*tcgmounts.*tabard", --WTS gO1d and TCG mounts and Tabard of the Lightbringer and maig rooster egg^^/w me:)
	"sell.*rocket.*pet.*gametimecard", --sell  [X-53 Touring Rocket] &2mounts,6pets,gametimecard,CATA/WLK CD-key
	--WTS[Bladeshatter Treads][Splinterfoot Sandals][Rooftop Griptoes]&all 397 epic boot on <g2500 dot com>.
	"wts.*%[.*%].*g2500.*com", --WTS[Foundations of Courage][Leggings of Nature's Champion]Search for more wow items on <g2500 dot com>. With discount code G2500OKYO5097 to order now.
	"wts.*%[.*%].*good4game", --WTS[Blazing Hippogryph][Amani Dragonhawk][Big Battle Bear]buy TCG Mounts on good4game.c{circle}m
	"wts.*%[.*%].*%[.*%].*wealso.*cheapestg", --WTS [Reins of the Crimson Deathcharger] [Mechano-Hog] [Big Battle Bear]and we also have the cheapest G
	"wts.*%[.*%].*%d+usd.*%d+k", --WTS [Reins of the Crimson Deathcharger] [Vial of the Sands] [Reins of Poseidus],170usd=100k+a rocket for free
	"boe.*sale.*upitems", --wts [Krol Decapitator] we have all the Boe items,mats and 378 items for sale .<www.upitems.com>!!
	"wts.*%[.*%].*$%d+.*%[.*%].*$%d+", --wts[Blauvelt's Family Crest]$34.00[Gilnean Ring of Ruination]$34.99[Signet of High Arcanist Savor]$34.90pst
	"pet.*panda.*gametimecard", --Vends 6PETS [Bébé hippogriffe cénarien],Mini'Rag,XT,KT,Sélénien,Panda 12K each;payé d'avance gametimecard 15K;Bâtis volants[Gardien ailé],[Palefroi célest
	"wts.*deliver.*cheap.*price", --WTS [Reins of Poseidus],deliver fast,cheaper price ,pst,plz
	"wts.*%[.*%].*%[.*%].*cheap.*stock", --wts [Reins of the Swift Spectral Tiger] [Reins of the Spectral Tiger] [Vial of the Sands],cheapst ,in stock ,pst
	"wts.*%[.*%].*%[.*%].*cheap.*safe", --WTS [Reins of the Swift Spectral Tiger] [Tabard of the Lightbringer] [Magic Rooster Egg]Cheapest & Safest Online Trad
	"wts.*%[.*%].*order.*stock", --Wts [prestiges mount] order over 50k will get it free  250k in stock-------- (lots of random characters)
	"^wts.*spectraltiger.*alsootheritems$", --WTS [Magic Rooster Egg] [Reins of the Spectral Tiger] [Reins of the Swift Spectral Tiger] Also other items
	--WTS [Magic Rooster Egg] [Reins of the Spectral Tiger]  [Reins of the Swift Spectral Tiger]cheap mount and gold
	"^wts.*%[.*%].*%[.*%].*cheapmounta?n?d?gold", --WTS [Magic Rooster Egg] [Reins of the Spectral Tiger]  [Reins of the Swift Spectral Tiger]cheap mount&gold
	--WTS Blizzard Store Mounts (25k) and Blizzard Store Pets (10k)
	"wts.*mount.*pet.*%d+k", --WTS {star}flying mounts:[Celestial Steed] and [Winged Guardian]30k each {star}PETS:Lil'Ragnaros/Lil'XT/Lil'K.T./Moonkin/Pandaren/Cenarion Hatchling 12k each,{star}prepaid timecards 15k each.{star}
	"wts.*%[.*%].*powerle?ve?l.*chea", --wts [Reins of the Swift Spectral Tiger] [Reins of the Spectral Tiger] [Wooly White Rhino],and g ,powerlvling ,chea
	"selling%d+.*prepaidtimecard", --selling 60 day prepaid time card /w me for the price
	"need.*gametime.*rocket.*info", --Does someone need WoW Gametime & X53 Rocket's Mount  /w me for more info
	"^wts%d+days?gamecard", --wts 60 days game card /w me
	"wts.*steed.*prepaidgame", --WTS [Winged Guardian]25K [Heart of the Aspects]25K [Celestial Steed]20K prepaid game
	"gamecard.*gold.*money.*info", -- I am offer Game Card for gold or money, for more info /w me
	"^wtsgametimesubsc", --WTS Gametime-Subscribtion /w me
	"^wtsgamecard%d+.*cheap", --Wts gamecard 60days very cheap
	--WTB Game Time CODE Buy gold
	--WTS Game time/Diablo and Unmarged accounts for gold!
	"wt[bs].*gametime.*gold", --WTB 1 Month Game Time CODE Buy gold
	"^wt[bs]gametime.*/w", --WTS G A M E T I M E /W
	"steed.*gc%d+day.*sale", --WTS [Winged Guardian] [Heart of the Aspects] [Celestial Steed]Each 15k gc90days=25KPet sales
	"wts.*mount.*gametimecard", --WTS Mounts[Heart of the Aspects] and Pets/ GameTimecard
	"mount.*account.*sell.*discount", --Get every single rare mount on your own account now! (including incredibly rare & unobtainables) Also selling all PvP achievies: Gladiator, Hero of Ally, 2200/2400 arenas/RBGs and more! Great discounts for MoP preorders! Message me! Skype: Baddieisboss
	"raiditems.*buy.*email.*price.*wowpve%.c", --{rt1}{rt1}T{rt1}{rt1}S raid items ，397/410/416 token ，achive dragon (ICC,ULD,CATA,FL),416 weapons and so on.If u want to buy,our team will carry u to the instance to get it. U can email me anytime,I will give u a price. [wowpve.com]
	--WTS cheap gold /w me for more info ( no chineese website etc...)
	"^wtscheapgold", --WTS cheap gold /w me for more info
	"^wtscheapandfastgold", --WTS cheap and fast gold ( no chineese website) /w me for more info
	"^wtsgametime.*cheap", --WTS gametime card 60days Very cheap
	"^wtbgold.*gametime", --WTB GOLD, OR TRADE GOLD FOR GAMETIME!!
	"honorbuddy.*bot.*gold.*skype", --WTS 1 sessions and 3 sessions of HONORBUDDY (WoW bot) For golds....It rly good way to earn golds,if you are interested contact me on skype : Stimar12
	"^wts%d+day.*gametime.*cheap", --wts  180days gametime card  {rt1} {rt2}\ cheaps\

	--[[  RBG  ]]--
	"boost.*rating.*wowbooster666", --{rt8}WTS RBG Boost! We boosts any rating 2.2, 2.4, 2.7(HERO), 3k and more! Cap games also! Quickly, efficiently, safely! Test game included.{rt8} Details on skype {rt1}wowbooster666{rt1}
	"rating.*account.*mark%.addington", --{rt8} Get your RBG rating fast and safe! 2200|2400|HERO. No account sharing. 3300 conquest points per week. Mount, 16+ achivements and 14 titles. Access to elite gear. We have website and business paypal! Skype - mark.addington23 {rt8}
	--{rt1} Get your Rated BG rating today! We can boost you really fast rating to 2.2k/2.4k/2.6k(depends on your wish).No account sharing,you play your character,so its 100% legally. You will get for sure best Elite PVP Gear+extended CP cap!1 game free. /w
	--{rt1}Get your Rated BG rating boosted up to 2.2k|2.4k|2.6k fast and for near to nothing. No account sharing, you play your character, so its 100% legit.  You get extended Conquest Points cap, best PvP gear, and other benefits.trial games!Pm me
	"rating.*fast.*account.*playyour", --{rt2} Get your RBG rating fast and safe! 2200/2400/Hero/CP Cap! No account sharing, you play your character, so its 100% legit. We have website and business paypal! /w me for information to join your rbg boost today. Autumn discount!!! {rt2}
	"account.*playyour.*legit.*paypal", --{rt2} RBG BOOST! 2200/2400/Hero/CP CAP! No account sharing, you play your character, so its 100% legit. We have website and business paypal! /w me for information to join your rbg boost today. Autumn discount!!! {rt2}
	--{rt8} Get your RBG rating fast and safe! 2200|2400|HERO. No account sharing. 3850 conquest points per week. Mount, 16+ achievements and 14 titles. Access to elite gear and t2 weapon. Get your rating today! Skype - john.saunder {rt8}
	"rating.*account.*john%.saunder", --{rt8} Get your RBG rating fast and safe! 2200|2400|HERO. No account sharing. 3300 conquest points per week. Mount, 16+ achivements and 14 titles. Access to elite gear. We have website and business paypal! Skype - john.saunder {rt8}
	"sale.*mount.*wowpvpcarry", --Gladiator, 2200/2400/2700 Arena & RBG, Hero of the Horde, Malevolent Gladiator (rank 1!), and much more for sale! Also selling rare & unobtainable mounts/titles (including scarab lord)! Skype: wowpvpcarry
	"rating.*mount.*baddieisboss", --Are you interested in becoming a Gladiator or achieving 2400 rating in RBGs/Arenas? How about being one of the first to get full elite gear this season? What about getting rare & unobtainable mounts? Message me for more info! Skype: Baddieisboss
	"boost.*account.*nucleear1986", --RBG BOOST (1 day) in MoP started!Get 2.2/2.4/HERO!NO share acc! We're 1 in world do not take account!Cap 3200+ every week.Access to Elite gear!All legally! 1 Test game!Website - 100% guarantees!Cheapest & Fastest service!Skype: nucleear1986_26
	"boost.*rating.*legal.*price", --{rt8} WTS RBG [BOOST.Any]rating:2200,2400,Hero. Absolutely legal - you play yourself, no account sharing. Best prices in Europe. Boost's provided in a very short space of [time.Be]the first to obtain great titles and elite gear!
	--{rt1}RBG help! Get 2.2/2.4/HERO/CAP only in few hours!NO share acc! We're 1 in world do not take account!Cap 3800+ every week.21 rbg achievs. Access to Elite gear!All legally! 1 Test game!Website - 100% guarantees! For more info /w me
	"rbg.*share.*account.*legal", --{rt1}RBG BOOST help! Get 2.2/2.4/HERO/CAP only in few hours!NO share acc! We're 1 in world do not take account!Cap 3800+ every week.21 rbg achievs. Access to Elite gear!All legally! 1 Test game!Website - 100% guarantees!Cheapest & Fastest service! /w
	"boost.*cheap.*rbgmarko", --{rt1} Best RBG boosting service!{rt1} 2200|2400|HERO. 2950-3300 conquest point per week + access to elite gear, 16+ achievments | 14 titles. Fast and secure boost,no account sharing with cheapest prices! {rt1} Skype: RBGmarko {rt1}
	"boost.*discount.*unkwn", --{rt8}WTS RBG Boost! Easily 0-2.2, 2.4, 2.65. Be the best with T2 weapon+ elite gear. Fast, SAFE. You play urself. PRIVATE games only. Pm for info. Test game included.{rt8}Autumn Discounts!{rt1}We have Proofs!{rt1}Skype: Unkwn-
	"rating.*gear.*rgboost", --Get the RBG rating you need! 2200|2400|HERO. 2950-3300 conquest point per week, access to elite gear,16+ achievments and 14 titles. Do easy and safe and fair, no account sharing. Hurry to catch Test and discount! Skype: RGBoost
	"rbg.*account.*playyour.*legit", --{rt1}New pvp Guild will help you with RBG. No account sharing, you play your character, so its 100% legit. 2.2\2.4\2.6k{rt1}
	"rbg.*playyour.*account.*legit", --{star} new pvp guild <all stars>. we are helping with rbg. you play yourself, without account sharing. 100% legit, you can see it yourself. 3800+ cp per week. helping with 2200/2400/hero. access to t2 weapons and more. wisp me for more information. /w
	"cheap.*arenaboost.*rating.*discount.*service", --{rt1} *now providing the cheapest Arena boosting*, Boosting all from 0-2,700 rating, example: 1,5-2k rating, EVERYTHING, NOW 20% DISCOUNT FOR ALL HEALERS, The Boosting Service is atm Available for all classes! {rt1}
	--{star} new pvp guild {star}get your rbg{star} will help you with 2200||2400||hero. 3850 cp a week, access to elite gear and t2 weapon. get your rating today! {star} /w me for more information! {star}
	"rbg.*help.*%d%d%d%d.*elitegear.*rating", --{skull} new guild <get your rbg rate>.we are helping with 2200||2400||hero.you play yourself in our group!3850 cp a week,mount,16+achievements and 14 titles. access to elite gear and t2 weapon.get your rating today!wisp me for more information! {skull}
	"safe.*paypal.*romaboost", --RGB Help. {square} 2200 - 2400 - 2600, CAP {square}. Fast and safe. The lowest prices in Europe. No sharing Account. You play yourself. Bussines PayPal. 100% legally. Skype: Romaboost

	--[[  Russian  ]]--
	--[skull]Ovoschevik.rf[skull] continues to harm the enemy, to please you with fresh [circle]vegetables! BC 450. Operators of girls waiting for you!
	"oвoщeвик%.рф.*cвeжиmи", --[skull]Овощевик.рф[skull] продолжает, на зло врагaм, радовaть вас свежими [circle]oвoщaми! Бл 450. oператoры девyшки ждyт вaс!
	-- [[MMOSHOP.RU]] [circle] ot23r] real price [WM BL:270] [ICQ:192625006 Skype:MMOSHOP.RU, chat on the site] [Webmoney,Yandex,other]
	"mmoshop%.ru.*цeнa.*skype", -- [ [MMOSHOP.RU]] [circle] от23р] реальная цена [WM BL:270] [ICQ:192625006 Skype:MMOSHOP.RU, Чат на сайте] [Вебмани,Яндекс,другие]
	--[square] [RPGdealer.ru] [square] gives you quick access to wealth. Always on top!
	"rpgdealer%.ru.*бoгaтcтву", --[square] [RPGdealer.ru] [square] предоставит Вам быстрый доступ к богатству. Всегда на высоте!
	--GOLD WOW + SATELLITE PRESENT EACH! Lotteries 2 times a month of valuable prizes [circle] Site : [RPGdealer.ru] [circle] ICQ: 485552474. BL 360 Info on the site.
	"з[o0]л[o0]т[ao0].*rpgdealer%.ru", --ЗОЛОТО WOW + СПУТНИК В ПОДАРОК КАЖДОМУ! Розыгрыши 2 раза в мес ценных призов [circle] Сайт: [RPGdealer.ru] [circle] ICQ: 485552474. BL 360 Инфа на сайте.
	--Buy MERRY COINS on the funny-money.rf Funny price:)
	--Купи ВЕСЕЛЫЕ МОНЕТКИ на фани-мани.рф Смешные цены:)
	--Buy GOLD at [circle]funny-money.rf[circle] Price Calculator on the site.
	"купи.*фaни-maни%.рф", --Купи ЗОЛОТО на [circle]фани-мани.рф[circle] Калькулятор цен на сайте.
	--[COINS] of 23 per 1OOO | website | INGMONEY. RU | | SALE + Super Award - Spectral Tiger! ICQ 77-21-87 | | Skype INGMONEY. RU
	"ingmoney%.ru.*skype", --[МОНЕТЫ]  от 23 за 1OOO | сайт | INGMONEY. RU ||АКЦИЯ + Супер Приз - Спектральный Тигр! ICQ 77-21-87 || Skype INGMONEY. RU
	--Sell 55kg of potatoes at a low price quickly! Skype v_techno_delo [circle] 8 = 1kg
	"прoдam.*кaртoшки.*cрoчнo.*cкaйп", --Продам 55кг картошки по дешевке  срочно! скайп v_techno_delo  [circle] 8 = 1кг
	--Gold Exchange Invitation to participate suppliers and shops. With our more than 800 suppliers and 100 stores. GexDex.ru
	"з[o0]л[o0]т[ao0].*gexdex%.ru", --[skull][skull][skull] Биржа золота приглaшaет к учaстию постaвщиков и магазины. С нами болee 800 постaвщиков и 100 магaзинов. GеxDеx.ru
	--Cheapest price only here! Price 1000 gold-20R, from 40k-18r on, from-60k to 17p! Website [playwowtime.vipshop.ru]! ICQ 196-353-353, skype nickname playwowtime2011!
	"vipshop%.ru.*skype", --Самые дешевые цены только у нас! Цены 1000 золотых- 20р , от 40к -по 18р , от 60к-по 17р ! Сайт [playwowtime.vipshop.ru] ! ICQ 196-353-353 , skype ник playwowtime2011!
	--we are help with RAITING BATTLE GROUND -2200-2400-2650 /admission of cap/PVP set for honor points/mount/leveling 1-90/ skype - [RPGBOX.RU] icq  819-207 site [rpgbox.ru]
	"рeйтинг.*cкaйп.*rpgbox%.ru", --поможем РЕЙТИНГ ПОЛЕ БОЯ -2200-2400-2650 /набор капа/ПВП сет за очки чести/маунт/прокачка 1-90/ скайп - [RPGBOX.RU] ася  819-207 сайт [rpgbox.ru]
	--Selling [GOLD]! 16r-1k Instant delivery any quantatys. Levelling characters, prof, honor. Attestat WM BL 350 ICQ 406-8878-55 Skype wow-crabbs
	--Продам [GOLD]! 16р-1к Моментальная доставка любых количеств. Прокачка персонажей, проф, хонора. Аттестат WM BL 350 ICQ 406-8878-55 Скайп wow-crabbs
	--Buying gold!looking for suppliers.Leveling characters, proffesions, honor TimeCards60days-80k gold Game payment 1month-45k gold. Attestat [BL 350] ICQ 406-8878-55 Skype wow-crabbs
	"хoнoрa.*cкaйп.*wowcrabbs", --Скупаю голд!ищу поставщиков.Прокачка персонажей, профессий, хонора ТК60дн-80к Проплата 1мес-45к. Аттестат [BL 350] ICQ 406-8878-55 Скайп wow-crabbs
	--[MMOah.ru]  [circle] Gold at competitive prices [circle] BL85+ IСQ  49-48-48 , online chat on the site, we are accepted any kind of payments WM/YM/Visa/qiwi/Robokassa/SMS, we are produce recruitment of suppl
	"mmoah%.ru.*зoлoтo.*icq", --[MMOah.ru]  [circle] Золото по выгодным ценам [circle] BL85+ IСQ  49-48-48 , на сайте онлайн чат, принимаем все виды оплат WM/ЯД/Visa/qiwi/Robokassa/SMS, производим набор пост
	--Seling [G[circle]LD], Fast, reliably, any kind of payments. Attestat of seller's. Looking for supplier's details to pm.
	"g{.*}ld.*быcтрo.*oплaты.*пocтaвщикoв", --Продам [G[circle]LD], Быстро, надежно, различные способы оплаты. Аттестат продовца. Ищем поставщиков подробности в пм.
	--selling [circle] 1k at 13 rub
	"^прoдaм.*{.*}.*%d+кзa%d+руб", --продам [circle] 1к за 13 руб

	--[[  Chinese  ]]--
	--嗨 大家好  团购金币送代练 炼金龙 还有各职业账号 详情请咨询 谢谢$18=10k;$90=50k+1000G free;$180=100k+2000g+月卡，也可用G 换月卡
	--{rt3}{rt1} 春花秋月何时了，买金知多少.小楼昨夜又东风，金价不堪回首月明中. 雕栏玉砌金犹在，只是价格改.问君能有几多愁，恰似我家金价在跳楼.QQ:1069665249
	--大家好，金币现价：19$=10k,90$=50k另外出售火箭月卡，还有70,80,85账号，全手工代练，技能代练，荣誉等，华人价格从优！！买金币还是老牌子可靠，sky牌金币，您最好的选择！
	"only%d+.*for%d+k.*rocket.*card", --only 20d for 10k,90d for 50k,X-53 rocket,recuit month card ,pst for more info{rt1}另外出售火箭月卡，买金送火箭月卡，账号，代练等，华人价格从优！！
	"金币.*%d+k.*惊喜大奖", --卖坐骑啦炽热角鹰兽白色毛犀牛大小幽灵虎红色DK马等拉风坐骑热销中，金币价格170$/105k,更有惊喜大奖等你拿=D
	--17=10k 160=100K 359BOE LVL85 Account For SaIe 疯狂甩卖 P0werleveling 1-85 only need 7days 还有大小幽灵虎
	"%d+=%d+k.*boe.*p[0o]we?rle?ve?ling.*虎", --17=10k 160=100K 359BOE疯狂甩卖 P0werleveling 1-85还有大小幽灵虎等你来拿PST
	"%d+=%d+k.*r0cket.*p[0o]we?rle?ve?ling", --$50=30k $80=50K+X-53T0uring R0cket+1 M0nth G@me Time , 378B0Es For SaIe 疯狂甩卖 P0werleveling 1-85 only 7 days, Help Do Bloodbathed Frostbrood Vanquisher Achivement!代打ICC成就龙,华人优惠哦
	"金.*%d+=%d+k.*boe.*虎", --暑假WOW大促销啦@，金币超低价 <200=100k+10kextra> , 国服/美服1-85效率代练5天完成，378BOE各种装备甩卖，各职业帐号，大小幽灵虎等稀有坐骑现货，金币换火箭，月卡牛
	"only.*%d+k.*deliver.*售", --only 17d for 10k,160d for 100k,deliver in 5mins, pst for more info另出售装备，账号，坐骑，85代练，华人价格从优！！!
	"专业代练.*安全快速发货", --17美元=10k  大量金币薄利多销，货比三家，专业代练1-85，练技能，账号，火箭月卡，还有各种378BOE装备，各种新材料，大小幽灵虎，专业团队代打ICC成就龙，刷荣誉等，安全快速发货
	"cheap.*sale.*囤货", --WTS [Blazing Hippogryph] [Amani Dragonhawk]cheapest for sale,pst,plz 龙鹰和角鹰兽囤货，需要速密，谢谢
	"金币.*卖.*买金币", --感恩大回馈金币大甩卖 ,买金币送坐骑，送代练，需要的请M,另外有378装备，代练，帐号，月卡出售。大、小幽灵虎，犀牛，角鹰兽， 魔法公鸡，赤红DK战马,战斗熊等
	"wts.*%[.*%].*gear.*%d+k.*gift", --WTS大卖 [Dragonbelly Bracers] [Boots of Fungoid Growth] lvl384 or 397 pattern gear Gem 150$=100k+a free gift,17$=10k, pst withi more offer
	"wts.*%[.*%].*cheap.*囤货甩卖", --WTS [Savage Raptor] [Blazing Hippogryph] [X-51 Nether-Rocket X-TREME] cheap pst,囤货甩卖，需要的
	"wts.*%[.*%].*cheapgold.*%d+k", --WTS大卖 [Pattern: Bladeshadow Wristguards] [Pattern: World Mender's Pants] and cheap gold 10k for 15,100k for 140 pst
	--WOW龙魂8H效率团低价出售橙匕+WOW各版本橙武。 397/403/410/416装备。带刷成就龙(ICC,ULD,CATA,FL)。帅气坐骑.死翼坐骑/火鹰/等。带刷RBG荣誉.1-85手工代练美金消费欢迎咨询QQ: 1416781477
	"出售.*成就.*欢迎.*qq", --WOW龙魂8H美金消费团出售橙匕+WOW各版本橙武。 397/403/410/416装备。带刷成就龙(ICC,ULD,CATA,FL)。低价出售帅气坐骑.死翼坐骑/火鹰/等。带刷RBG荣誉.1-85手工代练欢迎咨询QQ: 1416781477
	"wts.*nightwing.*order.*gametime", --WTS[Heart of the Nightwing]order 50k will get a free one plus 30days game time{star}买金送招募坐骑,炼金龙和DK马,大小幽灵虎特价出售,另有各种代练和账号{diamond}QQ：1933089703

	--[[  Advanced URL's/Misc  ]]--
	"%d+eu.*deliver.*credible.*kcq[%.,]", --12.66EUR/10000G 10 minutes delivery.absolutely credible. K C Q .< 0 M
	"deliver.*gears.*g4p", --Fast delivery for Level 359/372 BoE gears!Vist <www.g4pitem.com> to get whatever you need!
	"pkpkg.*boe.*deliver", --[PKPKG.COM] sells all kinds of 346,359lvl BOE gears. fast delivery. your confidence is all garanteed
	"service.*pst.*info.*%d+k.*usd", --24 hrs on line servicer PST for more infor. Thanks ^_^  10k =32 u s d  -happy friday :)
	"okgolds.*only.*%d+.*euro", --WWW.okgolds.COM,10000G+2000G.only.15.99EURO}/2
	"mmo4store.*%d+[kg].*good.*choice", --{square}MMO4STORE.C0M{square}14/10000G{square}Good Choice{square}
	"promotion.*serve.*%d+k", --Special promotion in this serve now, 21$ for 10k
	"pkpkg.*gear.*pet", --WWW.PkPkg.C{circle}M more gears,mount,pet and items on
	"euro.*gold.*safer.*trade", --Only 1.66 Euros per 1000 gold, More safer trade model.
	--WWW.PVPBank.C{circle}MCODE=itempvp(20% price off)
	"www[%.,]pvpbank[%.,]c.*%d+", --Wir haben mehr Ausr?stungen, Mounts und Items, die Sie mochten. Professionelles Team fuer 300 Personen sind 24 Stunde fuer Sie da.Wenn Sie Fragen haben,wenden Sie an uns bitteWWW.PVPBank.C{circle}M7 Tage 24 Uhr Service.
	"wts.*boeitems.*sale.*ignah", --wts [Lightning-Infused Leggings] [Carapace of Forgotten Kings] we have all the Boe items,mats and t10/t10.5 for sale .<www.ignah.com>!!
	"mmoarm2teeth.*wanna.*gear.*season.*wowgold", --hey,this is [3w.mmoarm2teeth.com](3w=www).do you wanna get heroic ICC gear,season8 gear and wow gold?
	"skillcopper.*wow.*mount.*gold", --skillcopper.eu Oldalunk ujabb termekekel bovult WoWTCG Loot Card-okal pl.:(Mount: Spectral Tiger, pet: Tuskarr Kite, Spectral Kitten Fun cuccok: Papa Hummel es meg sok mas) Gold, GC, CD kulcsok Akcio! Latogass el oldalunkra skillcopper.eu
	"meingd[%.,]de.*eur.*gold", --[MeinGD.de] - 0,7 Euro - 1000 Gold - [MeinGD.de]
	"%$.*boe.*deliver.*interest", --{rt3}{rt1} WTS WOW G for $$. 10k for 20$, 52k for 100$. 105k for 199$. all item level 359 BOE gear. instant delivery! PST if ya have insterest in it. ^_^
	"^wtscheapergold/whisper$", --{square} WTS CHeaper gold /whisper {square}
	"wowhelp%.1click%.hu", --{square}Have a nice day, enjoy the game!{square} - {star} [http://wowhelp.1-click.hu/] - One click for all WoW help! {star}
	"g4p.*gold.*discount", --Saray Daily Greetings ? thanks for your previous support on G4P,here I am reminding you of our info, you may need it again :web:G4Pgold,Discount code:saray,introducer ID:saray
	"%d+k.*deliver.*item", --$20=10K, $100=57k,$200=115k with instant delivery,all lvl378 items,pst
	"money.*gold.*gold2sell", --Ingame gold for real money! Real gold for Ingame gold! Ingame gold for a account key! If you're intrested, then check out: "gold2sell.org" now!
	"%d+=%d+k.*cheap.*fast.*boe", --WTS RBG 2400 Rating,3.88=10k, cheap and fast. Also kinds of BOE in store. Pst me for detail
	"wtsgold.*mount.*tar?bard.*acc", --WTS gold and some TCG mounts and Tarbard of the lightbringer and 80lvl acc
	"%d+[/\\=]%d+.*gold4power", --?90=5oK Google:Gold4Power, Introducer ID:saray
	"k%.?4g[o0]ldcom.*code", --{star}.W{star}.W{star}W {square} k{triangle}.4{triangle}g{triangle}o{triangle}l{triangle}d {square} c{star}o{star}m -------{square}- c{star}o{star}d{star}e : CF \ CO \ CK
	"kb8g[o0]ld.*%d+.*st[o0]ck", --KB8GOLD com 8.5EUR = 10000,269K IN STOCK NOW!
	--www K4power c@m.Lowest Price + 10% Free G.{Code:4Power}--
	--~~K.4.p.0.W.e.r,C,o,m~~ 4.€.~1O0O0
	"k[%.,]*4[%.,]*p[%.,]*[o0][%.,]*w[%.,]*e[%.,]*r.*%d[%do]+", --WWW K4POWER C0M {Code:Xmas}->>Xmas Promotions{18th Dec-26th Dec}->35% Free,0rder 50k More->X-53 Rocket Mount For Free!
	"%d[%do]+.*k[%.,]*4[%.,]*p[%.,]*[o0][%.,]*w[%.,]*e[%.,]*r", --4e<> 10O0O @ k4põwér C'Q'M @
	"deliver.*g[@o]ldw[@o]w2012", --$$ Lv 1-85=127EUR+7days $$ 397-410 professional equipment,TCG Loot card,rare mount $$ fast delivery within 24 horus $$ g@ldW@W2012 C@M $$
	"wts.*%[.*%].*cheap.*gold.*%d+%$", --WTS [Reins of the Swift Spectral Tiger] [Tabard of the Lightbringer]{rt3}{rt3}cheapest gold,110$=100k,pst with more offer,plz!!!!
	"wts.*euro.*boe.*deliver", --WTS RBG 2400 RATING, 3.88 "euro"=10 K,Also kinds of BOE 11in store.fast delivery,Pst me for detail
	"msn.*salliaes7587.*%d[%do]+", --1K 1TL ! MSN Adresi salliaes7587@hotmail.c@m !isteyene referans gosterilir :)MSNden eklemeniz yeterli!1OOk 9O TL :)
	"gear.*%d+=%d+.*ourgamecenter", --WTS gear & item 410/416, 25m raid team{star}10000=8 ,50000=40{star}wwvv-OurGameCenter-< om{star}waiting for u!!!
	"like.*facebook.*goldsdepot", --{diamant}anyone who {diamant}LIKE {diamant}our FACEBOOK{dreieck}goldsdepot{dreieck}can get 4000  free G !!!
	"g[0o]ld.*deliver.*bonus", --3WG0ldsDepot C0M SAVE UP 40% 15Mins DELIVERY 10000=5.99 NEW MEMEBER CAN GET 10% BONUS,NICE CUST0MER ASSISTANT say “NO” to “ ST0LEN G0LD “!!!
	--{square}G0lDSDEP0T C..0..M {square}{star}10mns.. {star}{diamond} 10k=5.99 {diamond}
	"g[%.,]*[0o][%.,]*[l1][%.,]*d[%.,]*s[%.,]*d[%.,]*e[%.,]*p[%.,]*[o0][%.,]*t.*%d[%do]+[%.,]*[kg]", --{square}G01dsDepot{square}c..0..m {square}10k=5.99{square}Refuse St01en G01d{square}
	"g[%.,]*[0o][%.,]*[l1][%.,]*d[%.,]*s[%.,]*d[%.,]*e[%.,]*p[%.,]*[o0][%.,]*t.*d[%.,]*e?[%.,]*[l1][%.,]*i[%.,]*v[%.,]*e?[%.,]*r", --{diamond} G.0.l.d.s.d.e.p.o.t,C,o,m {diamond}10m,in Dlivry,10000=5.99, 10% Extra G for Easter
	"k[%.,]*4[%.,]*g[%.,]*u[%.,]*i[%.,]*l[%.,]*d.*d[%.,]*e[%.,]*[l1][%.,]*i[%.,]*v[%.,]*e", --3.W,K.4.G.U.I.L.D,C.@.m 4.5 Êürõ--10k+1O%Disçòünt, Délìvèry 6 M.i.n.s
	"k[%.,]*4[%.,]*p[%.,]*[o0][%.,]*w[%.,]*e[%.,]*r.*d[%.,]*e[%.,]*[l1][%.,]*i[%.,]*v[%.,]*e", --3.w,K.4.P.0.W.E.R,c.@.m 4 èü // 1Ok,Délìvèry 6 M.i.n.s
	--"w[%.,]*o[%.,]*w[%.,]*4[%.,]*w[%.,]*o[%.,]*w.*d[%.,]*e[%.,]*[l1][%.,]*i[%.,]*v[%.,]*e",
	--"[hl][%.,]*[au][%.,]*[pc][%.,]*[pk][%.,]*y[%.,]*g[%.,]*o[%.,]*l[%.,]*d[%.,]*s.*d[%.,]*e[%.,]*[l1][%.,]*i[%.,]*v[%.,]*e",
	--"[hl!|][%.,]*[au][%.,]*[pc][%.,]*[pk][%.,]*y[%.,]*g[%.,]*[o0q][%.,]*[l!|][%.,]*d[%.,]*s.*%d[%do]+",
	--"%d[%do]+.*[hl!|][%.,]*[au][%.,]*[pc][%.,]*[pk][%.,]*y[%.,]*g[%.,]*[o0q][%.,]*[l!|][%.,]*d[%.,]*s",
	--"[wv][%.,]*[o0q][%.,]*[wv]v?[%.,]*4[%.,]*[wv]v?[%.,]*[o0q][%.,]*[wv]v?.*%d[%do]+",
	--"%d[%do]+.*[wv][%.,]*[o0q][%.,]*[wv]v?[%.,]*4[%.,]*[wv]v?[%.,]*[o0q][%.,]*[wv]v?",
	--"^[wv][%.,]*[o0][%.,]*[wv]v?[%.,]*4[%.,]*[wv]v?[%.,]*[o0][%.,]*[wv]v?[%.,]*c[%.,]*[o0][%.,]*m$",
	--"^[hl][%.,]*[au][%.,]*[pc][%.,]*[pk][%.,]*y[%.,]*g[%.,]*[o0][%.,]*l[%.,]*d[%.,]*s[%.,]*c[%.,]*[o0][%.,]*m$",
	--"[hl!|][%.,]*[au][%.,]*[pc][%.,]*[pk][%.,]*y[%.,]*g[%.,]*[o0q][%.,]*[l!|][%.,]*d[%.,]*s.*s[%.,]*[ae][%.,]*[l!|][%.,]*[l!|e]",
	--"[wv][%.,]*[o0q][%.,]*[wv]v?[%.,]*4[%.,]*[wv]v?[%.,]*[o0q][%.,]*[wv]v?.*s[%.,]*[ae][%.,]*[l!|][%.,]*[l!|e]",
	--"s[%.,]*[ae][%.,]*[l!|][%.,]*[l!|e].*[hl!|][%.,]*[au][%.,]*[pc][%.,]*[pk][%.,]*y[%.,]*g[%.,]*[o0q][%.,]*[l!|][%.,]*d[%.,]*s",
	--"s[%.,]*[ae][%.,]*[l!|][%.,]*[l!|e].*[wv][%.,]*[o0q][%.,]*[wv]v?[%.,]*4[%.,]*[wv]v?[%.,]*[o0q][%.,]*[wv]v?",
	--"\\/\\/[o0]\\/\\/4\\/\\/[o0]\\/\\/.*%d[%dqo]+",
	--"%d[%dqo]+.*\\/\\/[o0]\\/\\/4\\/\\/[o0]\\/\\/",
	--"\\/\\/[o0]\\/\\/4\\/\\/[o0]\\/\\/.*s[%.,]*[ae][%.,]*[l!|][%.,]*[l!|e]",
	--"s[%.,]*[ae][%.,]*[l!|][%.,]*[l!|e].*\\/\\/[o0]\\/\\/4\\/\\/[o0]\\/\\/",
	--Vend RBG 2400{star} 3.88“euro”=10k{moon}rapide et sûre.{star}D'autres types de BOE est également en vente.
	"vend.*prix.*livraison.*wow%.po", --Vend Po à prix interessant Livraison instantanée. Paiement par SMS/Tel ou Paypal, me contacter Skype: wow.po
	"verkauf.*hotgolds.*%d+g", --Gréat Vérkauf! .Hôtgôlds.côrn10000G.only.2.éUR.Hôtgôlds.côrnWWWé habén 783k spéichért und k?nnén Sié érhaltén innérhalb von 5-10 Minutén.wénn Sié kaufén ,  4403
	"%d[%do]+=%d+%.?%d*e.*bonus.*skype", --@1òòòO=5.52ё.5% BòNuS.5-15mins can Gёt./w me for skype@
	"hotg01ds.*%d[%do]+k", --Hôtg01ds. côrn 1Ok=2.99 8081
	--{star}www.OurGameCenter.com{star} 10000=4.69 WTS Smoldering Egg of Millagazor and all 410/416 items droped from DS {star} including achieve,mount,legendary dagger,etc.( 8/8H DS &7/7H FL)
	"ourgamecenter.*wts.*legendary", --www.OurGameCenter.com10K=4.69 we have 8/8H DS 25m raid team ,WTS 410/416lvl BOP items,achiev,mount,legendary dagger,etc. {star} Smoldering Egg of Millagazor
	"billiggull.*koster.*skype", --{star} Interessert i billig GULL? 100k koster 700 NOK (7 NOK pr 1k) – Bet: Pay Pal og nettbank. Bare nor,swe,dk kunder! Lei av kineserene? Jeg er mye sikrere, instant gull etter bet, online ofte og billig! Add meg på SKYPE for mer info: Nolixz1 {star}
	"order.*nightwing.*%d+k.*stock", --WTS{star}50K Order can get <heart of the nightwing> for free,100k Order can get it for free,500k in stock,pst{square}
	"kb8g[0o][1l]d.*deliver", --1OK // 7.9 E { www,Kb8G01d,Com } <5Mins Delivery>
}

Module.replacements = {
	["а"]="a", ["à"]="a", ["á"]="a", ["ä"]="a", ["â"]="a", ["ã"]="a", ["å"]="a", --First letter is Russian "\208\176". Convert > \97
	["с"]="c", ["ç"]="c", --First letter is Russian "\209\129". Convert > \99
	["е"]="e", ["è"]="e", ["é"]="e", ["ë"]="e", ["ё"]="e",["ê"]="e", --First letter is Russian "\208\181". Convert > \101
	["ì"]="i", ["í"]="i", ["ï"]="i", ["î"]="i", --Convert > \105
	["Μ"]="m", ["м"]="m",--First letter is capital Greek μ "\206\156". Convert > \109
	["о"]="o", ["ò"]="o", ["ó"]="o", ["ö"]="o", ["ō"]="o", ["ô"]="o", ["õ"]="o", --First letter is Russian "\208\190". Convert > \111
	["ù"]="u", ["ú"]="u", ["ü"]="u", ["û"]="u", --Convert > \117
}
﻿--[[ 
  @file       oqueue.lua
  @brief      warcraft addon for finding and queuing premade groups for bgs

  @author     rmcinnis
  @date       april 06, 2012
  @copyright  Solid ICE Technologies
              this file may be distributed so long as it remains unaltered
              if this file is posted to a web site, credit must be given to me along with a link to my web page
              no code in this file may be used in other works without expressed permission  
]]--
local addonName, OQ = ... ;
local L = OQ._T ; -- for literal string translations
if (OQ.table == nil) then
  OQ.table = {} ;
end
local tbl = OQ.table ;

local OQ_MAJOR                 = 1 ;
local OQ_MINOR                 = 6 ;
local OQ_REVISION              = 0 ;
local OQ_BUILD                 = 160 ;
local OQ_SPECIAL_TAG           = "" ;
local OQUEUE_VERSION           = tostring(OQ_MAJOR) ..".".. tostring(OQ_MINOR) ..".".. OQ_REVISION ;
local OQUEUE_VERSION_SHORT     = tostring(OQ_MAJOR) ..".".. tostring(OQ_MINOR) .."".. OQ_REVISION ;
local OQ_VERSION               = tostring(OQ_MAJOR) .."".. tostring(OQ_MINOR) .."".. tostring(OQ_REVISION) ;
local OQ_VER_STR               = OQUEUE_VERSION ;
local OQ_VER                   = "0Z"  ;  -- just removing the dot
local OQSK_VER                 = "0C"  ;  
local OQSK_HEADER              = "OQSK" ;
local OQ_NOTIFICATION_CYCLE    = 2 * 60 * 60 ; -- every 2 hrs
local OQ_VERSION_SWAP_TM       = 24 * 60 * 60 ;  -- daily check for toons that are OQ enabled
local OQ_ONEDAY                = 24 * 60 * 60 ; 
local OQ_REALISTIC_MAX_GAMELEN = 8*60*60 ;  -- classic AV no longer exists
local OQ_MAX_RELAY_REALMS      = 5 ; 
local OQ_NOEMAIL               = "." ;
local OQ_OLDBNHEADER           = "[OQ] " ;
local OQ_BNHEADER_TAG          = "(OQ)" ;
local OQ_BNHEADER              = OQ_BNHEADER_TAG .." " ;
local OQ_SKHEADER              = "[SK] " ;
local OQ_HEADER                = "OQ" ;
local OQ_MSGHEADER             = OQ_HEADER .."," ;
local OQ_FLD_TO                = "#to:" ;
local OQ_FLD_FROM              = "#fr:" ;
local OQ_FLD_REALM             = "#rlm:" ;
local OQ_TTL                   = 5 ;
local OQ_PREMADE_STAT_LIFETIME = 5*60 ; -- 5 minutes
local OQ_GROUP_TIMEOUT         = 2*60 ; -- 2 minutes (matches raid-timeout) if no response will remove group 
local OQ_GROUP_RECOVERY_TM     = 5*60 ; -- 5 minutes 
local OQ_SEC_BETWEEN_ADS       = 25 ; 
local OQ_SEC_BETWEEN_PROMO     = 25 ;
local OQ_BOOKKEEPING_INTERVAL  = 10 ;
local OQ_BRIEF_INTERVAL        = 30 ;
local HAILTOTHEKINGBABY        = 3600 ; -- no more then once an hour
local OQ_MAX_ATOKEN_LIFESPAN   = 120 ; -- 120 seconds before token removed from ATOKEN list
local OQ_MIN_ATOKEN_RELAY_TM   = 30 ; -- do not relay atokens more then once every 30 seconds
local OQ_MAX_HONOR_WARNING     = 3600 ;
local OQ_MAX_HONOR             = 4000 ;
local OQ_MAX_SUBMIT_ATTEMPTS   = 20 ;
local OQ_MAX_WAITLIST          = 40 ;
local OQ_TOTAL_BGS             = 10 ;
local OQ_MIN_RUNAWAY_TM        = 40 ; 
local OQ_MIN_CONNECTION        = 20 ;
local OQ_MIN_BNET_CONNECTIONS  = 10 ;
local OQ_FINDMESH_CD           = 7 ; -- seconds
local OQ_CREATEPREMADE_CD      = 5 ; -- seconds
local OQ_BTAG_SUBMIT_INTERVAL  = 4*24*60*60 ;
local OQ_DIP_GAP               = 30 ; -- seconds
local MAX_OQGENERAL_TALKERS    = 20 ;
local last_runaway             = 0 ;
local last_stat_tm             = 0 ;
local my_group                 = 0 ;
local my_slot                  = 0 ;
local next_bn_check            = 0 ;
local next_check               = 0 ;
local next_invite_tm           = 0 ;
local last_ident_tm            = 0 ;
local last_stats_tm            = 0 ;
local skip_stats               = 0 ;
local last_stats               = "" ;
local player_name              = nil ;
local player_class             = nil ;
local player_realm             = nil ;
local player_realm_id          = 0 ;
local player_realid            = nil ;
local player_faction           = nil ;
local player_level             = 1 ;
local player_ilevel            = 1 ;  
local player_resil             = 1 ;  
local player_role              = 3 ;
local player_deserter          = nil ;
local player_queued            = nil ;
local player_online            = 1 ;
local player_karma             = 0 ;
local _source                  = nil ;
local _sender_pid              = nil ;
local _msg_token               = nil ;
local _debug                   = nil ;
local _inc_channel             = nil ;
local _received                = nil ;
local _ok2relay                = 1 ;
local _ok2decline              = true ;
local _local_msg               = nil ;
local _last_find_tm            = 0 ;
local _inside_bg               = nil ;
local _bg_shortname            = nil ;
local _bg_zone                 = nil ;
local _winner                  = nil ;
local _msg                     = nil ;
local _msg_type                = nil ;
local _msg_id                  = nil ;
local _oq_note                 = nil ;
local _oq_msg                  = nil ;
local _last_grp_stats          = nil ;
local _dest_realm              = nil ;
local _core_msg                = nil ;
local _to_name                 = nil ;
local _to_realm                = nil ;
local _from                    = nil ;
local _lucky_charms            = nil ;
local _last_lust               = nil ;
local _last_report             = nil ;
local _last_tops               = nil ;
local _last_bg                 = nil ;
local _last_crc                = nil ;
local _next_dip                = 0 ;
local _map_open                = nil ;
local _ui_open                 = nil ;
local _oqgeneral_id            = nil ;
local _oqgeneral_count         = 0 ;
local _oqgeneral_lockdown      = true ; -- restricted until unlocked once the # of members of oqgeneral are determined
local _f                       = {} ;
local _toon                    = {} ;
local _flags                   = nil ;
local _enemy                   = nil ;
local _nkbs                    = 0 ;
local _hailtiny                = 0 ;
local _next_flag_check         = 0 ;
local _announcePremades        = nil ;
local _arg                     = {} ;
local _opts                    = {} ;
local _vars                    = {} ;
local _hop                     = 0 ;
local player_away              = nil ;
local oq_ascii                 = {} ;
local oq_mime64                = {} ;
local lead_ticker              = 0 ;
local OQ_MAX_BNFRIENDS         = 85 ;
OQ.MAXBOUNTIES                 = 20 ;
OQ.BNET_CAPB4THECAP            = 100 ; -- blizz increased the cap from 100 to 112 (also fixed the crash.  capb4cap needed?).  
local _ ; -- throw away (was getting taint warning; what happened blizz?)

if (OQ_toon == nil) then 
  OQ_toon = { last_tm = 0,
              auto_role = 1,
              class_portrait = 1,
              shout_kbs = 1,
              shout_caps = 1,
              shout_ragequits = 1,
              say_sapped = 1,
              who_popped_lust = 1,
            } ;
end
--[[ OQ_toon used to help save group information if disconnected, reloaded, or quickly logged out
  my_group = 0 ;
  my_slot = 0 ;
  last_tm = 0 ;  -- if within 1 minute from now, try to re-establish
  raid = {} ; -- copied from oq on_logout
]]

local oq = { my_tok = nil, ui = {}, channels = {}, premades = {}, raid = {}, waitlist = {}, pending = {} } ;
--[[
  raid = {
    name         = 'the raid'
    leader       = 'bigdk'
    leader_realm = 'magtheridon'
    leader_rid   = 'joebob@someaddress.com'
    level_range  = '80-84'
    faction      = 'H'
    min_ilevel   = 380 ;
    min_resil    = 3000 ;
    bgs          = 'IoC,AV,AB,EotS'
    notes        = 'nothing much here' 
    raid_token   = 'OQ10002xxx'
    type         = OQ.TYPE_BG (D dungeon, A rated bgs, B battlegrounds(def))
    group        = { 
      [1] = { status = 'queued'                                                       -- group[1].member[1] is always the raid leader
              member = { 
                [1] = { name = 'bigman', class = 'dk'   , realm = '', bgroup = '', realid = nil, level = 0, hp = 0, flags = 0, bg[1]{ type,status } }, -- member[1] is always the group leader
                [2] = { name = 'jack'  , class = 'rogue', realm = '', bgroup = '', realid = nil }, -- realid is nil all but the raid leader
              }
      },
    }
    channel = 'oq00010022'
    pword   = 'pw00050001'
  },

  pending_invites = {
         [ name-realm ] = { raid_tok = oq.raid.raid_token, gid = group_id, slot = slot_, rid = rid_ } 
  },

  premades = {
    [1] = { raid_token = '', name = '', leader = '', leader_rid = '', level_range = '', faction = '', min_ilevel = '', min_resil = '', bgs = '' },
  },
  
  -- non-nil only for raid leader
  waitlist = {
    [1] = { name = 'slash', class = 'pally', realm = '', realid = '', level = '84', ilevel = '390', resil = '4200', realid = '' },
    [2] = { name = 'hack' , class = 'rogue', realm = '', realid = '', level = '84', ilevel = '390', resil = '4200', realid = '' },
  },
]]
local dtp = oq ;
function OQ:mod()  return oq ; end

if (OQ_data == nil) then 
  OQ_data = {  
    bn_friends = {}, 
    autoaccept_mesh_request = 1,
    ok2submit_tag = 1,
    show_premade_ads = 0,
    show_contract_ads = 1,
  } ;
  OQ_data.stats = {
    nGames      = 0 ;
    nWins       = 0 ;
    nLosses     = 0 ;
    start_tm    = 0 ; -- time() when this raid was created
    bg_start    = 0 ; -- place holder - time() of bg start
    bg_end      = 0 ; -- place holder - time() of bg end
    tm          = 0 ; -- time of last update from source.  able to know which data is the latest
  } ;
end

--[[
  -- OQ enabled BN friends
  bn_friends = {
    [toonName-realm] = { presenceID, givenName, surName, toonName, realm, isOnline, oq_enabled } ;
  }
]]

-------------------------------------------------------------------------------
--   local defines
-------------------------------------------------------------------------------
oq.old_bncustommsg        = nil ;
oq.old_bn_msg             = nil ;
oq.WhoPoppedList_Ids = 
{
  [ 2825] = "Bloodlust",
  [32182] = "Heroism",
  [80353] = "Time Warp",
  [90355] = "Ancient Hysteria",
} ;


OQ.CHK_VLIST_TM     = 15 ;

OQ.FLAG_ONLINE      = 0x01 ;
OQ.FLAG_DESERTER    = 0x02 ;
OQ.FLAG_QUEUED      = 0x04 ;
OQ.FLAG_BRB         = 0x08 ;
OQ.FLAG_TANK        = 0x10 ;
OQ.FLAG_HEALER      = 0x20 ;

OQ.FLAG_CLEAR       = 0x00 ;
OQ.FLAG_READY       = 0x01 ;
OQ.FLAG_NOTREADY    = 0x02 ;
OQ.FLAG_WAITING     = 0x04 ;

OQ.FACTION_ICON = {} ;
OQ.FACTION_ICON["H"] = "|TInterface\\BattlefieldFrame\\Battleground-Horde.blp:20:20:0:0|t";
OQ.FACTION_ICON["A"] = "|TInterface\\BattlefieldFrame\\Battleground-Alliance.blp:20:20:0:0|t";

local OQ_LOCK          = "|TInterface\\BUTTONS\\UI-Button-KeyRing.blp:28:20:0:0:20:24:0:16:0:16|t";
local OQ_KEY           = "Interface\\BUTTONS\\UI-Button-KeyRing" ;

local OQ_STAR_ICON     = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:16:16:0:0:64:64:0:16:0:16|t";
local OQ_CIRCLE_ICON   = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:16:16:0:0:64:64:16:32:0:16|t";
local OQ_DIAMOND_ICON  = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:10:10:0:0:64:64:32:48:0:16|t";
local OQ_BIGDIAMOND_ICON  = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:16:16:0:0:64:64:32:48:0:16|t";
local OQ_TRIANGLE_ICON = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:16:16:0:0:64:64:48:64:0:16|t";
local OQ_LILTRIANGLE_ICON = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:8:8:0:0:64:64:48:64:0:16|t";

local OQ_MOON_ICON     = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:16:16:0:0:64:64:0:16:16:32|t";
local OQ_SQUARE_ICON   = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:16:16:0:0:64:64:16:32:16:32|t";
local OQ_REDX_ICON     = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:16:16:0:0:64:64:32:48:16:32|t";
local OQ_LILREDX_ICON  = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:8:8:0:0:64:64:32:48:16:32|t";
local OQ_SKULL_ICON    = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:16:16:0:0:64:64:48:64:16:32|t";
local OQ_LILSKULL_ICON = "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:10:10:0:0:64:64:48:64:16:32|t";
local OQ_LILCIRCLE_ICON= "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcons.blp:8:8:0:0:64:64:16:32:0:16|t";

OQ.ICON_NONE        = 0 ;
OQ.ICON_STAR        = 1 ;
OQ.ICON_CIRCLE      = 2 ;
OQ.ICON_DIAMOND     = 3 ;
OQ.ICON_TRIANGLE    = 4 ;
OQ.ICON_MOON        = 5 ;
OQ.ICON_SQUARE      = 6 ;
OQ.ICON_REDX        = 7 ;
OQ.ICON_SKULL       = 8 ;

OQ.ICON_STRINGS = {
  [ OQ.ICON_NONE      ] = nil,
  [ OQ.ICON_STAR      ] = OQ_STAR_ICON,
  [ OQ.ICON_CIRCLE    ] = OQ_CIRCLE_ICON,
  [ OQ.ICON_DIAMOND   ] = OQ_DIAMOND_ICON,
  [ OQ.ICON_TRIANGLE  ] = OQ_TRIANGLE_ICON,
  [ OQ.ICON_MOON      ] = OQ_MOON_ICON,
  [ OQ.ICON_SQUARE    ] = OQ_SQUARE_ICON,
  [ OQ.ICON_REDX      ] = OQ_REDX_ICON,
  [ OQ.ICON_SKULL     ] = OQ_SKULL_ICON,
} ;

OQ.ICON_COORDS = {
  [ OQ.ICON_NONE      ] = { 0.00, 0.00, 0.00, 0.00 },
  [ OQ.ICON_STAR      ] = { 0.00, 0.25, 0.00, 0.25 },
  [ OQ.ICON_CIRCLE    ] = { 0.25, 0.50, 0.00, 0.25 },
  [ OQ.ICON_DIAMOND   ] = { 0.50, 0.75, 0.00, 0.25 },
  [ OQ.ICON_TRIANGLE  ] = { 0.75, 1.00, 0.00, 0.25 },
  [ OQ.ICON_MOON      ] = { 0.00, 0.25, 0.25, 0.50 },
  [ OQ.ICON_SQUARE    ] = { 0.25, 0.50, 0.25, 0.50 },
  [ OQ.ICON_REDX      ] = { 0.50, 0.75, 0.25, 0.50 },
  [ OQ.ICON_SKULL     ] = { 0.75, 1.00, 0.25, 0.50 },
} ;

-------------------------------------------------------------------------------
local OQ_versions = 
{ [ "1.5.0"    ] = 28,
  [ "1.5.1"    ] = 29,
  [ "1.5.2"    ] = 30,
  [ "1.5.3"    ] = 31,
  [ "1.5.4"    ] = 32,
  [ "1.5.5"    ] = 33,
  [ "1.5.6"    ] = 34,
  [ "1.5.7"    ] = 35,
  [ "1.5.8"    ] = 36,
  [ "1.5.9"    ] = 37,
  [ "1.6.0"    ] = 39,
  [ "1.6.1"    ] = 40,
  [ "1.6.2"    ] = 41,
  [ "1.6.3"    ] = 42,
  [ "1.6.4"    ] = 43,
  [ "1.6.5"    ] = 44,
  [ "1.6.6"    ] = 45,
  [ "1.6.7"    ] = 46,
  [ "1.6.8"    ] = 47,
  [ "1.6.9"    ] = 48,
  [ "1.7.0"    ] = 49,
  [ "1.8.0"    ] = 50,
  [ "1.8.1"    ] = 51,
  [ "1.8.2"    ] = 52,
  [ "1.8.3"    ] = 53,
  [ "1.8.4"    ] = 54,
  [ "1.8.5"    ] = 55,
  [ "1.8.6"    ] = 56,
  [ "1.8.7"    ] = 57,
  [ "1.8.8"    ] = 58,
  [ "1.8.9"    ] = 59,
  [ "1.9.0"    ] = 60,
  [ "1.9.1"    ] =  1,
} ;

function oq.get_version_id()
  return OQ_versions[OQ_VER_STR] or 0 ;
end

function oq.get_version_str( id )
  if (id == 0) then
    return "" ;
  end
  for i,v in pairs(OQ_versions) do
    if (v == id) then
      return i ;
    end
  end
  return "" ;
end
-------------------------------------------------------------------------------
--   slash commands
-------------------------------------------------------------------------------

SLASH_OQUEUE1 = '/oqueue' ;
SLASH_OQUEUE2 = '/oq' ;
SlashCmdList["OQUEUE"] = function (msg, editbox)
  if (msg == nil) or (msg == "") then
    oq.ui_toggle() ;
    return ;
  end
  local arg1 = msg ;
  local opts = nil ;
  if (msg ~= nil) and (msg:find(" ") ~= nil) then
    arg1 = msg:sub(1,msg:find(" ")-1) ;
    opts = msg:sub(msg:find(" ")+1,-1) ;
  end
  if (oq.options[ arg1 ] ~= nil) then
    oq.options[ arg1 ]( opts ) ;
  end
end

SLASH_BOUNTY1 = '/bounty' ;
SLASH_BOUNTY2 = '/bb' ;
SlashCmdList["BOUNTY"] = function (msg, editbox)
  oq.toggle_bounty_board() ;
end

SLASH_OQLOG1 = '/oqlog' ;
SLASH_OQLOG2 = '/log' ;
SlashCmdList["OQLOG"] = function (msg, editbox)
  oq.toggle_log() ;
end

--------------------------------------------------------------------------
--------------------------------------------------------------------------
oq.options = {} ;
function oq.hook_options()
  oq.options[ "?"           ] = oq.usage ; 
  oq.options[ "adds"        ] = oq.show_adds ;
  oq.options[ "ban"         ] = oq.ban_user ;
  oq.options[ "blam"        ] = oq.blam ;
  oq.options[ "j2tw"        ] = oq.j2tw_now ;
  oq.options[ "bnclear"     ] = oq.bn_clear ; 
  oq.options[ "brb"         ] = oq.brb ;
  oq.options[ "cb"          ] = oq.color_blind_mode ;
  oq.options[ "check"       ] = oq.bn_force_verify ;
  oq.options[ "cp"          ] = oq.toggle_class_portraits ;
  oq.options[ "debug"       ] = oq.debug_toggle ;
  oq.options[ "dip"         ] = oq.dip ; 
  oq.options[ "dg"          ] = oq.leave_party ;  -- drop group
  oq.options[ "dp"          ] = oq.leave_party ;  -- drop party
  oq.options[ "fixui"       ] = oq.reposition_ui ;  
  oq.options[ "fog"         ] = oq.fog_command ;  
  oq.options[ "godark"      ] = oq.godark ;
  oq.options[ "harddrop"    ] = oq.harddrop ; 
  oq.options[ "help"        ] = oq.usage ; 
  oq.options[ "id"          ] = oq.id_target ; 
  oq.options[ "log"         ] = oq.log_cmdline ; 
  oq.options[ "lust"        ] = oq.last_lust ;   
  oq.options[ "mbsync"      ] = oq.mbsync ;
  oq.options[ "mycrew"      ] = oq.mycrew ;
  oq.options[ "mini"        ] = oq.toggle_mini ;
  oq.options[ "now"         ] = oq.show_now ;
  oq.options[ "pnow"        ] = oq.show_now2party ;
  oq.options[ "partynow"    ] = oq.show_now2party ;
  oq.options[ "off"         ] = oq.oq_off ;
  oq.options[ "on"          ] = oq.oq_on ;
  oq.options[ "pending"     ] = oq.bn_show_pending ;
  oq.options[ "ping"        ] = oq.ping_toon ;
  oq.options[ "pos"         ] = oq.where_am_i ;
  oq.options[ "purge"       ] = oq.remove_OQadded_bn_friends ;
  oq.options[ "rage"        ] = oq.report_rage ;
  oq.options[ "rc"          ] = oq.start_role_check ;
  oq.options[ "refresh"     ] = oq.raid_find ;
  oq.options[ "reset"       ] = oq.data_reset ;
  oq.options[ "show"        ] = oq.show_data ;
  oq.options[ "datestamp"   ] = oq.toggle_datestamp ;
  oq.options[ "spy"         ] = oq.battleground_spy ;
  oq.options[ "stats"       ] = oq.dump_statistics ;
  oq.options[ "threat"      ] = oq.toggle_threat_level ;  
  oq.options[ "thx"         ] = oq.special_thanks ;  
  oq.options[ "time"        ] = oq.force_time_reset ;  
  oq.options[ "timer"       ] = oq.user_timer ;  
  oq.options[ "toggle"      ] = oq.toggle_option ;  
  oq.options[ "version"     ] = oq.show_version ;
  oq.options[ "-v"          ] = oq.show_version ;
  oq.options[ "wallet"      ] = oq.show_wallet ;
  oq.options[ "who"         ] = oq.show_bn_enabled ;
end

local bg_points = { [1] = "AB"  ,
                    [2] = "AV"  ,
                    [3] = "BFG" ,
                    [4] = "EotS",
                    [5] = "IoC" ,
                    [6] = "SotA",
                    [7] = "TP"  ,
                    [8] = "WSG" ,
                    [9] = "SSM" ;
                    [10] = "ToK" ;
                    [11] = "DWG" ;
                  } ;

function oq.toggle_mini()
  if (OQ_MinimapButton:IsVisible()) then
    OQ_MinimapButton:Hide() ;
    OQ_toon.mini_hide = true ;
    print( OQ.MINIMAP_HIDDEN ) ;
  else
    OQ_MinimapButton:Show() ;
    OQ_toon.mini_hide = nil ;
    print( OQ.MINIMAP_SHOWN ) ;
  end
end

local function comma_value(n) -- credit http://richard.warburton.it
  if (n == nil) then
    n = 0 ;
  end
  local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
  return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function oq.toggle_datestamp()
  if (OQ_data._show_datestamp) and (OQ_data._show_datestamp == 1) then
    OQ_data._show_datestamp = 0 ;
    oq.tab4_now:Hide() ;
    print( "date stamp: OFF" ) ;
  else
    OQ_data._show_datestamp = 1 ;
    oq.tab4_now:Show() ;
    print( "date stamp: ON" ) ;
  end
end

function oq.id_target()
  local target = "target" ;
  local guid = UnitGUID(target) ;
  if (guid == nil) then
    target = "player" ;
    guid = UnitGUID(target) ;
  end

  local id = tonumber(guid:sub(6,10),16) ; 
  if (id ~= 0) then
    print( "(".. guid ..")  id: ".. comma_value(id) .."  ".. UnitName(target) ) ;
  else
    id = tonumber(guid:sub(-7,-1),16) ; 
    print( "(".. guid ..")  ".. UnitName(target) .."  player_id: ".. comma_value(id) ) ;
  end
end

function oq.basic_compare( a, b )
  if (a == nil) then
    return false ;
  elseif (b == nil) then
    return true ;
  end
  return (a < b) ;
end

function oq.get_hostiles() 
  local now = utc_time() ;
  
  if (oq._hostiles_tm) and ((now - oq._hostiles_tm) < 10) then
    -- only refresh list once every 10 seconds
    return oq._hostiles ;
  end
  oq._hostiles_tm = now ;
  if (WorldStateScoreFrame:IsVisible()) then
    return oq._hostiles ;
  end

  -- clear faction
  SetBattlefieldScoreFaction( nil ) ;
  
  local nplayers = GetNumBattlefieldScores() ;
  local p_faction = 0 ; -- 0 == horde, 1 == alliance, -1 == offline
  if (oq.get_bg_faction() == "A") then
    p_faction = 1 ;
  end
  
  if (nplayers == 0) then
    -- not inside or the call failed
    return nil ;
  end
  -- don't clean out the main table so we hold onto the tms
  if (oq._hostiles == nil) then oq._hostiles = {} ; end -- one time creation, table of tables
  if (oq._hostiles_ids == nil) then oq._hostiles_ids = {} ; else tbl.clear( oq._hostiles_ids ) ; end
  oq._nEnemies = 0 ;
  for i=1, nplayers do
    local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class = GetBattlefieldScore(i);
    if (name) and (faction) and (faction ~= p_faction) then
      if (oq._hostiles[name] == nil) then
        oq._hostiles[name] = { tm = 0, ndx = 0 } ;
        oq._nEnemies = oq._nEnemies + 1 ; 
      end
      table.insert( oq._hostiles_ids, name ) ;
    end
  end
  table.sort(oq._hostiles_ids, oq.basic_compare) ;  
  for i,v in pairs(oq._hostiles_ids) do
    oq._hostiles[ v ].ndx = i ;
  end  
  return oq._hostiles ;
end

function oq.toggle_threat_level()
  if (OQ_data.threat_show == nil) or (OQ_data.threat_show == 1) then
    oq.threat_frame():Hide() ;
    OQ_data.threat_show = 0 ;
  else
    oq.threat_frame():Show() ;
    OQ_data.threat_show = 1 ;
  end
end

function oq.toggle_timers()
  if (OQ_data.timer_show == nil) or (OQ_data.timer_show == 1) then
    oq.utimer_frame():Hide() ;
    OQ_data.timer_show = 0 ;
  else
    oq.utimer_frame():Show() ;
    OQ_data.timer_show = 1 ;
  end
end

function oq.get_threat_level()
  local px, py = GetPlayerMapPosition("player") ; 
  local nfriendly = 0 ;
  local nhostile = 0 ;
  
  -- check friendlies
  for i=1,GetNumGroupMembers() do
    if UnitInRange( "raid".. i ) then
      nfriendly = nfriendly + 1 ;
    end
  end

  oq.get_hostiles() ;
  
  -- check hostiles
  if (oq._hostiles) then
    local t1 = GetTime() - 5.0 ;
    for i,v in pairs(oq._hostiles) do
      if (v.tm > t1) then
        nhostile = nhostile + 1 ;
      end
    end
  end
  return nfriendly, nhostile ;
end

-- announce threat detected to other oqueue members
function oq.report_threat()
  if (oq._hostiles == nil) or (_inside_bg == nil) or (oq.fog_send_report == nil) then
    return ;
  end
  local s = "" ;
  local now = GetTime() ;
  local t1 = now - 5.0 ;
  for i,v in pairs(oq._hostiles) do
    if (v.tm > t1) then
      s = s .."".. oq.encode_mime64_1digit( v.ndx ) ;
    end
  end
  if (s == "") then
    return ;
  end
  local x, y = GetPlayerMapPosition("player") ; 
  s = oq.encode_mime64_2digit( floor(x*1000) ) .."".. 
      oq.encode_mime64_2digit( floor(y*1000) ) .."".. s ;
  -- report to bg and process myself
  oq.fog_send_report( s ) ;
end

function oq.utimer_frame_transit( self, flag )
  if (flag) then
    self.texture:SetTexture( 0.1, 0.1, 0.1 ) ;
    self.label  :Show() ;
    self.closepb:Show() ;
  else
    local f = GetMouseFocus() ;
    if (f ~= self.closepb) then
      self.texture:SetTexture( nil ) ;
      self.label  :Hide() ;
      self.closepb:Hide() ;
    end
  end
end

function oq.threat_frame_transit( self, flag )
  if (flag) then
    self.closepb:Show() ;
  else
    local f = GetMouseFocus() ;
    if (f ~= self.closepb) then
      self.closepb:Hide() ;
    end
  end
end

function oq.threat_frame_toggle( self, flag )
  OQ_data.threat_show = flag ;
  if (flag) then
    oq.timer( "threat_update", 2.5, oq.threat_update, true ) ;
  else
    oq.timer( "threat_update", 2.5, nil ) ;
  end    
end

function oq.threat_frame()
  if (oq._threat_frame ~= nil) then
    return oq._threat_frame ;
  end
  local d = oq.CreateFrame("FRAME", "OQThreatFrame", UIParent ) ;
  d:SetBackdropColor(0.6,0.6,0.6,1.0) ;
  d:SetScript("OnEnter" , function(self, ...) oq.threat_frame_transit( self,   1 ) ; end ) ;
  d:SetScript("OnLeave" , function(self, ...) oq.threat_frame_transit( self, nil ) ; end ) ;
  oq.setpos( d, 300, 300, 100, 50 ) ;

  oq.make_frame_moveable( d ) ;
  d.closepb = oq.closebox( d, function(self) self:GetParent():Hide() ; OQ_data.threat_show = 0 ; end ) ;
  d.closepb:SetPoint("TOPRIGHT", d, "TOPRIGHT", 3, 3 ) ;
  d._save_position = function(self) 
                       OQ_data.threat_x = max(0,floor(self:GetLeft())) ; 
                       OQ_data.threat_y = max(0,floor(self:GetTop())) ; 
                     end ;

  -- friendly
  local i = d:CreateTexture( nil, "LOW" ) ;
  i:SetWidth ( 40 ) ;
  i:SetHeight( 40 ) ;
  i:SetPoint( "TOPLEFT", d, "TOPLEFT", 5, -10 ) ;
  i:SetAlpha( 0.65 ) ;
  d.friend = i ;
  d.nFriends = oq.label( d, 16, 2, 40, 25, "", "CENTER", "CENTER", "GameFontNormalLarge", "MEDIUM" ) ; 
  d.nFriends:SetAllPoints( i ) ;
  d.nFriends:SetTextColor( 1, 1, 1 ) ;
  d.nFriends:SetText( "" ) ;

  -- enemy
  local e = d:CreateTexture( nil, "LOW" ) ;
  e:SetWidth ( 40 ) ;
  e:SetHeight( 40 ) ;
  e:SetPoint( "TOPRIGHT", d, "TOPRIGHT", -5, -10 ) ;
  e:SetAlpha( 0.65 ) ;
  d.enemy = e ;
  d.nEnemies = oq.label( d, 16, 2, 40, 25, "", "CENTER", "CENTER", "GameFontNormalLarge", "MEDIUM" ) ; 
  d.nEnemies:SetAllPoints( e ) ;
  d.nEnemies:SetTextColor( 1, 1, 1 ) ;
  d.nEnemies:SetText( "" ) ;

  if (player_faction == "A") then
    i:SetTexture( "Interface\\FriendsFrame\\PlusManz-Alliance" ) ;
    e:SetTexture( "Interface\\FriendsFrame\\PlusManz-Horde" ) ;
  else
    i:SetTexture( "Interface\\FriendsFrame\\PlusManz-Horde" ) ;
    e:SetTexture( "Interface\\FriendsFrame\\PlusManz-Alliance" ) ;
  end
  
  d:Hide() ; -- require caller to explicitly show it

  if (OQ_data.threat_x or OQ_data.threat_y) then
    d:SetPoint( "TOPLEFT", UIParent, "BOTTOMLEFT", OQ_data.threat_x, OQ_data.threat_y ) ;
  end
  oq._threat_frame = d ;
  oq.threat_frame_transit( d, nil ) ; -- hide certain bits
  return oq._threat_frame ;
end

function oq.threat_update()
  if (oq._threat_frame == nil) or (not oq._threat_frame:IsVisible()) or (oq._instance_type ~= "pvp") then
    return ;
  end

  local friends, enemies = oq.get_threat_level() ;
  if (friends == 0) then
    friends = "" ;
  end
  oq._threat_frame.nFriends:SetText( friends ) ;
  if (enemies == 0) then
    enemies = "" ;
  end
  oq._threat_frame.nEnemies:SetText( enemies ) ;  
end

function oq.utimer_set_width( w ) 
  if (w == nil) or (w < 30) then
    return ;
  end
  local ut = oq.utimer_frame() ;
  ut:SetWidth( w ) ;
  ut:SetPoint( "TOPLEFT", UIParent, "BOTTOMLEFT", ut:GetLeft(), ut:GetTop() ) ;
  ut.texture:SetWidth( w ) ;
  for i,v in pairs(oq._utimers) do
    if (v._start ~= 0) and (v:IsVisible()) then
      v:set_width( w ) ;
    end
  end
end

function oq.utimer_frame()
  if (oq._utimer_frame ~= nil) then
    return oq._utimer_frame ;
  end
  local d = oq.CreateFrame("FRAME", "OQUserTimerFrame", UIParent ) ;
  d:SetBackdropColor(0.6,0.6,0.6,1.0) ;
  d:SetScript("OnEnter" , function(self, ...) oq.utimer_frame_transit( self,   1 ) ; end ) ;
  d:SetScript("OnLeave" , function(self, ...) oq.utimer_frame_transit( self, nil ) ; end ) ;

  oq.setpos( d, 300, 300, OQ_data.timer_width or 200, 200 ) ;
  local t = d:CreateTexture( nil, "BACKGROUND" ) ;
  t:SetTexture( nil ) ;
  t:SetPoint( "TOPLEFT"    , d, "TOPLEFT" , 16,   0 ) ;
  t:SetPoint( "BOTTOMRIGHT", d, "TOPRIGHT",  0, -18 ) ;
  t:SetAlpha( 0.8 ) ;
  d.texture = t ;

  d.label = oq.label( d, 0, 0, d:GetWidth()-(2*5+16), d:GetHeight() - 2*2, "timers", "TOP", "LEFT" ) ; 
  d.label:SetPoint("TOPLEFT", d, "TOPLEFT", 5+16, -4 ) ;
  d.label:SetTextColor( 1,1,1 ) ;
  
  oq.make_frame_moveable( d ) ;
  d.closepb = oq.closebox( d, function(self) self:GetParent():Hide() ; OQ_data.timer_show = 0 ; end ) ;
  d.closepb:SetPoint("TOPRIGHT", d, "TOPRIGHT", 3, 3 ) ;
  d._save_position = function(self) 
                       OQ_data.utimer_x = max(0,floor(self:GetLeft())) ; 
                       OQ_data.utimer_y = max(0,floor(self:GetTop())) ; 
                     end ;
  d:Hide() ; -- require caller to explicitly show it

  if (OQ_data.utimer_x or OQ_data.utimer_y) then
    d:SetPoint( "TOPLEFT", UIParent, "BOTTOMLEFT", OQ_data.utimer_x, OQ_data.utimer_y ) ;
  end
  oq._utimer_frame = d ;
  oq.utimer_frame_transit( d, nil ) ; -- hide certain bits
  return oq._utimer_frame ;
end

function oq.utimer_done( self )
  self:Hide() ;
  self._start   = 0 ;
  self._end     = 0 ;
  self._trigger = nil ;
  self._type    = 1 ;
  oq.utimer_shuffle() ;
end

function oq.utimer_update( bar ) 
  if (bar._type == 1) then
    return oq.utimer_countdown_update( bar ) ;
  end
  if (bar._type == 2) then
    return oq.utimer_countup_update( bar ) 
  end
  if (bar._type == 3) then
    return oq.utimer_cycle_update( bar ) 
  end
  if (bar._type == 4) then
    return oq.utimer_node_update( bar ) 
  end
  if (bar._type == 5) then
    return oq.utimer_normal_update( bar ) 
  end
end

function oq.utimer_reset_cycle( name ) 
  if (name == nil) then
    return nil ;
  end
  for i,v in pairs(oq._utimers) do
    if (v.label:GetText() == name) and (v._type == 3) then
      v._start = GetTime() ;
      v._end   = v._start + v._tm ;
      if (v._last_reset_tm) then
        local dt = (v._start - v._last_reset_tm) ;
        if (dt > 1) then
          v._last_cyle_length = dt ;
          print( "(".. name ..") res cycle length: ".. dt ) ;
        end
      end
      v._last_reset_tm = _start ;
      return v ;
    end
  end
  return nil ;
end

-- static bar (used to represent a controlled node)
function oq.utimer_node_update( bar ) 
  if (bar._start == 0) then
    return ;
  end
  
  local now = GetTime() ;
  local dt = (now - bar._start) ; -- how long it's been held
  local width = floor(bar.backdrop:GetWidth()+1) ;
  bar.texture:SetPoint( "TOPRIGHT", bar, "TOPRIGHT",  0, 0 ) ;
  if (bar._notime) then
    bar.time:SetText( "" ) ;
  else
    bar.time:SetText( floor(dt/60) ..":".. string.format( "%02d", floor(dt % 60)) ) ;
  end
  if (bar._count) then
    bar.count:SetText( tostring(bar._count) .."x" ) ;
  else
    bar.count:SetText( "" ) ;
  end
end

function oq.utimer_normal_update( bar ) 
  local now = GetTime() ;
  local dt = (now - bar._start) ; -- how long it's been held
  local width = floor(bar.backdrop:GetWidth()+1) ;
  bar.texture:SetPoint( "TOPRIGHT", bar, "TOPRIGHT",  0, 0 ) ;
  bar.time:SetText( "" ) ;
  if (bar._count) then
    bar.count:SetText( tostring(bar._count) .."x" ) ;
  else
    bar.count:SetText( "" ) ;
  end
end

function oq.utimer_cycle_update( bar ) 
  if (bar._start == 0) then
    return ;
  end
  
  local now = GetTime() ;
  if (bar._end < now) then
    -- timer ended
    if (bar._trigger) then
      bar._trigger( bar, now ) ;
    end
    -- reset timer data for reuse and shuffle remaining
    bar._start = GetTime() ;
    bar._end   = bar._start + bar._tm ;
    return ;
  end

  local dt = (bar._end - now) ;
  local tm = (bar._end - bar._start) ;
  local width = floor(bar.backdrop:GetWidth()+1) ;
  if (tm == 0) then
    return ;
  end
  bar.texture:SetPoint( "TOPRIGHT", bar, "TOPRIGHT",  -1* width * (dt / tm), 0 ) ;
  bar.time:SetText( floor(dt/60) ..":".. string.format( "%02d", floor(dt % 60)) ) ;
  if (bar._count) then
    bar.count:SetText( tostring(bar._count or 0) .."x" ) ;
  else
    bar.count:SetText( "" ) ;
  end
  if (bar._dead) then
    bar.ressers:SetText( "(".. tostring(bar._dead or 0) ..")" ) ;
  else
    bar.ressers:SetText( "" ) ;
  end
end

function oq.utimer_countup_update( bar ) 
  if (bar._start == 0) then
    return ;
  end
  
  local now = GetTime() ;
  if (bar._end < now) then
    -- timer ended
    if (bar._trigger) then
      bar._trigger( bar, now ) ;
    end
    -- reset timer data for reuse and shuffle remaining
    oq.utimer_done( bar ) ;
    return ;
  end

  local dt = (bar._end - now) ;
  local tm = (bar._end - bar._start) ;
  local width = floor(bar.backdrop:GetWidth()+1) ;
  if (tm == 0) then
    return ;
  end
  bar.texture:SetPoint( "TOPRIGHT", bar, "TOPRIGHT",  -1* width * (dt / tm), 0 ) ;
  bar.time:SetText( floor(dt/60) ..":".. string.format( "%02d", floor(dt % 60)) ) ;
end

function oq.utimer_countdown_update( bar ) 
  if (bar._start == 0) then
    return ;
  end
  
  local now = GetTime() ;
  if (bar._end < now) then
    -- timer ended
    if (bar._trigger) then
      bar._trigger( bar, now ) ;
    end
    -- reset timer data for reuse and shuffle remaining
    oq.utimer_done( bar ) ;
    return ;
  end

  local dt = (bar._end - now) ;
  local tm = (bar._end - bar._start) ;
  local width = floor(bar.backdrop:GetWidth()+1) ;
  if (tm == 0) then
    return ;
  end
  bar.texture:SetPoint( "TOPRIGHT", bar, "TOPRIGHT", width * (dt / tm) - width, 0 ) ;
  bar.time:SetText( floor(dt/60) ..":".. string.format( "%02d", floor(dt % 60)) ) ;
  if (bar._count) then
    bar.count:SetText( tostring(bar._count) .."x" ) ;
  else
    bar.count:SetText( "" ) ;
  end
end

function oq.utimer_create( parent, handle, x, y, cx, cy ) 
  oq.nlistings = oq.nlistings + 1 ;
  local d = oq.CreateFrame("FRAME", "OQUserTimer".. oq.nlistings, parent ) ;
  d:SetBackdropColor(0.8,0.8,0.8,1.0) ;
  oq.setpos( d, x, y, cx+1, cy ) ;
  local b = d:CreateTexture( nil, "BACKGROUND" ) ;
  b:SetTexture( 0.2, 0.2, 0.2, 0.4 ) ;
  b:SetAllPoints(d) ;
  b:SetWidth(cx) ;
  b:SetPoint( "TOPLEFT", d, "TOPLEFT", 16, 0 ) ;
  d.backdrop = b ;

  local i = d:CreateTexture( nil, "LOW" ) ;
  i:SetTexture( "INTERFACE/BUTTONS/GRADBLUE" ) ;
  i:SetWidth ( 16 ) ;
  i:SetHeight( 16 ) ;
  i:SetPoint( "TOPLEFT", d, "TOPLEFT", 0, -2 ) ;
  i:SetAlpha( 1.0 ) ;
  d.icon = i ;

  local t = d:CreateTexture( nil, "LOW" ) ;
  t:SetTexture( "INTERFACE/BUTTONS/GRADBLUE" ) ;
  t:SetAllPoints(d) ;
  t:SetPoint( "TOPLEFT", d, "TOPLEFT", 16+1, 0 ) ;
  t:SetAlpha( 0.6 ) ;
  d.texture = t ;

  d.label = oq.label( d, 16+5, 2, d:GetWidth()-(2*5+16), d:GetHeight() - 2*2, "", "MIDDLE", "LEFT", nil, "MEDIUM" ) ; 
  d.label:SetTextColor( 1, 1, 1 ) ;
  
  d.count = oq.label( d, 2, 2, 60, d:GetHeight() - 2*2, "", "MIDDLE", "LEFT", nil, "MEDIUM" ) ; 
  d.count:SetTextColor( 1, 1, 1 ) ;
  d.count:SetPoint( "TOPLEFT", d, "TOPLEFT", -60, -2 ) ;
  d.count:SetJustifyH( "RIGHT" ) ;
  
  d.ressers = oq.label( d, 2, 2, 60, d:GetHeight() - 2*2, "", "MIDDLE", "LEFT", nil, "MEDIUM" ) ; 
  d.ressers:SetTextColor( 1, 1, 1 ) ;
  d.ressers:SetPoint( "TOPLEFT", d, "TOPRIGHT", 2, -2 ) ;
  d.ressers:SetJustifyH( "LEFT" ) ;
  
  d.time = oq.label( d, d:GetWidth() - 50 - 5, 2, 50, d:GetHeight() - 2*2, "0:00", "MIDDLE", "RIGHT", nil, "MEDIUM" ) ; 
  d.time:SetTextColor( 1, 1, 1 ) ;
  d.time:SetPoint( "TOPLEFT", d, "TOPRIGHT", -60, -2 ) ;
  d._start  = 0 ;
  d._end    = 0 ;
  d._handle = handle ;
  d._type   = 1 ; -- standard count down
  d:SetScript("OnUpdate", function(self, elapsed) oq.utimer_update( self ) ; end ) ;
  
  d:SetMovable(false) ;
  d:EnableMouse(true) ;
  d:SetScript("OnMouseUp", function(self, button) 
                             if (button == "LeftButton") and (self._type == 1) and (_inside_bg) then
                               SendChatMessage( self.label:GetText() .."   ".. self.time:GetText(), 
                                                "INSTANCE_CHAT" ) ;
                             end
                           end ) ;
  d:Hide() ;
  
  d.set_width = function(self, w) 
                  local x, y = self:GetLeft(), self:GetTop() ;
                  x = abs(x - self:GetParent():GetLeft()) ;
                  y = abs(y - self:GetParent():GetTop()) ;
                  self:SetPoint( "TOPLEFT", self:GetParent(), "TOPLEFT", x, -1 * y ) ;
                  self:SetWidth(w) ;
                  self.backdrop:SetWidth(w) ;
                end
  return d ;
end

function oq.utimer_find( name, type )
  for i,v in pairs(oq._utimers) do
    if (v.label:GetText() == name) and (v._start ~= 0) and ((type == nil) or (v._type == type)) then
      return v ;
    end
  end
  return nil ;
end

function oq.utimer_find_unused()
  for i,v in pairs(oq._utimers) do
    if (v._start == 0) then
      return v ;
    end
  end
  return nil ;
end

function oq.utimer_compare( a, b )
  if (a == nil) then
    return false ;
  elseif (b == nil) then
    return true ;
  end
  return (oq._utimers[b]._end < oq._utimers[a]._end) ;
end

function oq.utimer_compare_alpha( a, b )
  if (a == nil) then
    return false ;
  elseif (b == nil) then
    return true ;
  end
  return (oq._utimers[a].label:GetText() < oq._utimers[b].label:GetText()) ;
end

function oq.utimer_compare_capped( a, b )
  if (a == nil) then
    return false ;
  elseif (b == nil) then
    return true ;
  end
  if (oq._utimers[b]._faction ~= oq._utimers[a]._faction) then
    return oq._utimers[a]._faction == "alliance" ;
  end
  return (oq._utimers[a].label:GetText() < oq._utimers[b].label:GetText()) ;
end

function oq.utimer_shuffle()
  if (_bg_shortname ~= nil) and (oq._bg_checks[ _bg_shortname ] ~= nil) then
    return oq._bg_checks[ _bg_shortname ].shuffle() ;
  end
  -- default shuffle
  return oq._bg_checks[ "AB" ].shuffle() ;
end

function oq.utimer_set( msg, tm )
  -- find unused timer or create a new one
  local t = oq.utimer_find_unused() ;
  if (t == nil) then
    print( "all timers used" ) ;
    return ;
  end
  t.label:SetText( msg ) ;
  t._start = GetTime() ;
  t._end   = t._start + tm ;
  t.texture:SetTexture( "INTERFACE/BUTTONS/GRADBLUE" ) ;
  t.texture:SetAlpha( 0.6 ) ;
  t.icon:SetTexture( nil ) ;
  t:Show() ;
  oq.utimer_shuffle() ;
end

function oq.utimer_set_horde( msg, tm )
  -- find unused timer or create a new one
  local t = oq.utimer_find_unused() ;
  if (t == nil) then
    print( "all timers used" ) ;
    return ;
  end
  t.label:SetText( msg ) ;
  t._start = GetTime() ;
  t._end   = t._start + tm ;
  t.texture:SetTexture( 1.0, 0.0, 0.0 ) ;
  t.texture:SetGradient("HORIZONTAL", 0.4, 0.0, 0.0, 
                                      1.0, 0.0, 0.0 ) ;                                      
  t:Show() ;
  oq.utimer_shuffle() ;
end

function oq.utimer_set_alliance( msg, tm )
  -- find unused timer or create a new one
  local t = oq.utimer_find_unused() ;
  if (t == nil) then
    print( "all timers used" ) ;
    return ;
  end
  t.label:SetText( msg ) ;
  t._start = GetTime() ;
  t._end   = t._start + tm ;
  t.texture:SetTexture( 0.0, 0.0, 1.0 ) ;
  t.texture:SetGradient("VERTICAL", 0.0, 0.0, 0.4,
                                    0.0, 0.0, 1.0 ) ;
  t:Show() ;
  oq.utimer_shuffle() ;
end

function oq.where_am_i()
  if (oq._inside_instance == nil) then
    local x, y = GetPlayerMapPosition("player") ; 
    print( "location: ".. floor(x*1000)/1000 .." , ".. floor(y*1000)/1000 .."  ".. tostring(GetZoneText()) ) ;
  elseif (_bg_shortname ~= nil) and (oq._bg_checks[ _bg_shortname ] ~= nil) and (oq._bg_checks[ _bg_shortname ].loc ~= nil) then
    oq._bg_checks[ _bg_shortname ].loc() ;
  else
    local x, y = GetPlayerMapPosition("player") ; 
    print( "location: ".. floor(x*1000)/1000 .." , ".. floor(y*1000)/1000 ) ;
  end
end

function oq.utimer_test( arg1, arg2 ) 
  if (arg1) then
    arg1 = arg1:upper() ;
  end
  if (arg1 ~= nil) and (oq._bg_checks[ arg1 ] ~= nil) and (oq._bg_checks[ arg1 ].test ~= nil) then
    return oq._bg_checks[ arg1 ].test( arg2 ) ;
  end
  -- basic test
  local t ;
  oq.utimer_start( "test 1", "horde", 13, 60, 1 ) ;
  oq.utimer_start( "test 2", "horde", 13, 60, 2 ) ;
  t = oq.utimer_start( "test 3", "horde", 13, 60, 3 ) ;
  t._count = 5 ;
  t._dead  = 8 ;
  t = oq.utimer_start( "test 3a", "horde", 13, 60, 3 ) ;
  t._count = 5 ;
  oq.utimer_start( "test 4", "horde", 13, 60, 4 ) ;
  oq.utimer_start( "test 5", "horde", 13, 60, 5 ) ;
  oq.utimer_start( "test 6", "alliance", 14, 60, 1 ) ;
end

function oq.utimer_start( name, faction, textureIndex, tm, type_, notime )
  local t = oq.utimer_find( name, type_ ) ;
  if (t ~= nil) and (faction == t._faction) then
    oq.utimer_shuffle() ; -- may not be needed
    return t ;
  end
  if (t == nil) then
    t = oq.utimer_find_unused() ;
  end
  if (t == nil) then
    print( "all timers used" ) ;
    return ;
  end
  t.label:SetText( name ) ;
  t._start    = GetTime() ;
  t._end      = t._start + tm ;
  t._tm       = tm ; -- original time 
  t._type     = (type_ or 1) ;
  t._faction  = faction ;
  t._count    = nil ;
  t._dead     = nil ;
  t._notime   = notime ;
  t.ressers:SetText("") ;

  if (faction == "horde") then
    t.texture:SetTexture( 1.0, 0.0, 0.0 ) ;
    t.texture:SetGradient("VERTICAL", 0.4, 0.0, 0.0, 
                                      1.0, 0.0, 0.0 ) ;
  elseif (faction == "alliance") then
    t.texture:SetTexture( 0.0, 0.0, 1.0 ) ;
    t.texture:SetGradient("VERTICAL", 0.0, 0.0, 0.4, 
                                      0.0, 0.0, 1.0 ) ;
  else
    t.texture:SetTexture( "INTERFACE/BUTTONS/GRADBLUE" ) ;
  end

  if (textureIndex) and (type(textureIndex) == "number") then
    t.icon:SetTexture( "Interface/Minimap/POIIcons.blp" ) ;
    local x1, x2, y1, y2 = GetPOITextureCoords(textureIndex);
    t.icon:SetTexCoord(x1, x2, y1, y2) ;
  else
    t.icon:SetTexture( textureIndex ) ;
    t.icon:SetTexCoord(0,1,0,1) ;
  end
  t:Show() ;
  oq.utimer_shuffle() ;
  return t ;
end

function oq.utimer_stop( name, type )
  if (type == nil) then
    type = 1 ;
  end
  for i,v in pairs(oq._utimers) do
    if ((name == nil) or (v.label:GetText() == name)) and ((type == -1) or (v._type == type)) and (v:IsVisible()) then
      v.label  :SetText( "" ) ;
      v.time   :SetText( "0:00" ) ;
      v.texture:SetTexture( "INTERFACE/BUTTONS/GRADBLUE" ) ;
      v._start = 0 ;
      v._end   = 0 ;
      v._trigger = nil ;
      v:Hide() ;
      oq.utimer_shuffle() ;
      if (name ~= nil) then
        return 1 ;
      end
    end
  end  
  return nil ;
end

function oq.utimer_stop_all()
  for i,v in pairs(oq._utimers) do
    v.label  :SetText( "" ) ;
    v.time   :SetText( "0:00" ) ;
    v.texture:SetTexture( "INTERFACE/BUTTONS/GRADBLUE" ) ;
    v._start   = 0 ;
    v._end     = 0 ;
    v._trigger = nil ;
    v._type    = 0 ;
    v._count   = 0 ;
    v:Hide() ;
  end  
  oq.utimer_shuffle() ;
end

function oq.utimer_dump() 
  print( "timer-bar dump:" ) ;
  for i,v in pairs(oq._utimers) do
    if (v._start > 0) then
      print( v.label:GetText() .." type(".. tostring(v._type) ..")  notime(".. tostring(v._notime) ..") count: ".. 
             tostring(v._count) .."  dead: ".. tostring(v._dead) ) ;
    end
  end
  print( "---" ) ;
end

function string.find_end( self, s )
  if (s) then
    return self:find( s ) + string.len( s ) ;
  end
end

function oq.user_timer( opts )
  oq.utimer_frame():Show() ;
  if (opts == nil) then
    return ;
  end
  local v ;
  local args = {} ;
  for v in string.gmatch(opts, "([^ ]+)") do
    table.insert(args, v);
  end
  if (args[1] == "h") then
    oq.utimer_start( "horde timer", "horde", 17, 4*60 ) ;
  elseif (args[1] == "a") then
    oq.utimer_start( "alliance timer", "alliance", 12, 4*60 ) ;
  elseif (args[1] == "upa") then
    oq.utimer_start( "alliance win", "alliance", 43, 1*60, 2 ) ;
  elseif (args[1] == "uph") then
    oq.utimer_start( "horde win", "horde", 44, 1*60, 2 ) ;
  elseif (args[1] == "dump") then
    oq.utimer_dump() ;
  elseif (args[1]:find("test")) then
    oq.utimer_test( args[2], args[3] ) ;
  elseif (args[1] == "clear") then
    oq.utimer_stop_all() ;
  elseif (args[1] == "shuffle") then
    oq.utimer_shuffle() ;
  elseif (args[1] ~= nil) then
    oq.utimer_set( "test timer", 1*60 ) ;
  end
end

function oq.utimer_check_bg_updates()
  -- check timers for current bg
  if (_bg_shortname == nil) then
    -- not ready yet
    oq.get_zone_info() ;
    if (_bg_shortname == nil) then
      return ;
    end
  end
  if (oq._bg_checks[ _bg_shortname ] ~= nil) then
    oq._bg_checks[ _bg_shortname ].check() ;
  end
end

function oq.utimer_bg_completed()
  if (_bg_shortname ~= nil) and (oq._bg_checks[ _bg_shortname ] ~= nil) then
    oq._bg_checks[ _bg_shortname ].close() ;
  end
  oq.utimer_stop_all() ; -- clears all timers; might want to keep non-bg timers
end

function oq.utimer_check_init()
  oq._utimers = {} ;
  for i=1,25 do
    oq._utimers[i] = oq.utimer_create( oq.utimer_frame(), i, 0, 18+20*(i-1), OQ_data.timer_width or 200, 20 ) ;
  end
  
  if (oq._bg_checks == nil) then
    oq._bg_checks = {} ;
  end
end

-- new browser capability
-- might be able to show armory in-game (nice for quick lookups off waitlist)
-- not ready yet; doesn't seem to work and may break key binds
function oq.armory( opts )
  if (oq.browser == nil) then
    oq.browser = oq.CreateFrame("Browser", "oQueueBrowser", UIParent ) ;
  end
  if (oq.browser:HasConnection() ~= true) then
    print( "oQueue browser - no connection" ) ;
    return ;
  end
  print( "oQueue browser - navigation" ) ;
  oq.browser:Show() ;
--  oq.browser:NavigateHome() ;
  oq.browser:OpenExternalLink("http://us.battle.net") ;
end

function oq.blam( n )
  local spice = { "bells", "jolly", "sing" } ;
  n = tonumber(n) ;
  if (n == nil) or (n > #spice) then
    n = random(1,#spice) ;
  end
  PlaySoundFile("Interface\\Addons\\oqueue\\sounds\\".. spice[n] ..".mp3") ;
end

-- joy to the world 
-- randomly plays on Christmas, 45-90 min interval
-- (tip: type this a few times for a preview: /oq blam)
function oq.j2tw(queue_it)
  local mon = tonumber(date("%m")) ;
  local day = tonumber(date("%d")) ;
  if (mon ~= 12) or ((day < 21) and (day > 29)) then
    return ;
  end
  if (queue_it == nil) then
    oq.j2tw_now()
  end
  oq.timer_oneshot( random(45*60, 90*60), oq.j2tw ) ;
end

function oq.j2tw_now()
  -- Merry Christmas!
  -- i love Christmas and if you don't like it, i'll gy-camp yer ass ;)
  oq.timer_oneshot( 1.0, oq.blam, 3 ) ;  
  oq.timer_oneshot( 1.5, oq.blam, 1 ) ;  
  oq.timer_oneshot( 2.0, oq.blam, 2 ) ;  
end

function oq.special_thanks()
  print( "oQueue v".. OQUEUE_VERSION ) ;
  print( "Written by Tinystomper / Weegeezer of Magtheridon (aka 'tiny')" ) ;
  print( "Special thanks to Rathamus and the crazy late-nite people on wow public vent" ) ;
  print( "  -  weanii, oath, skitt, naynayz, pluurrr, erickah, sorina, mighty, milk (not! j/k)," ) ;
  print( "  -  merrik, furry, mokk, rittenaur, shakem, cuthroat, staary, gumo, porf, pooz," ) ;
  print( "  -  pleb, celeste, snotmore, ubi, bosskiller, tann, mutilator, arrisa, traper, " ) ;
  print( "  -  and many, many more" ) ;
end

function oq.reposition_ui()
  local x = 100 ;
  
  -- bounty board
  if (oq._bounty_board) then
    oq._bounty_board:Show() ;
    oq._bounty_board:SetPoint( "TOPLEFT", UIParent, "TOPLEFT", x, -125 ) ;
    oq._bounty_board:_save_position() ;
  end

  x = x + 400 ;  
  -- main ui
  local f = OQMainFrame ;
  if (not f:IsVisible()) then
    oq.ui_toggle() ;
  end  
  f:SetWidth( 800 ) ;
  f:SetHeight( 425 ) ;
  f:SetPoint("TOPLEFT", UIParent,"TOPLEFT", x, -150 ) ;
  
  x = x + 800 ;
  -- timers
  oq.utimer_frame():Show() ;
  oq.utimer_frame():SetPoint( "TOPLEFT", UIParent, "TOPLEFT", x, -200 ) ;
  oq.utimer_frame():SetWidth(200) ;
  oq.utimer_frame():_save_position() ;
  
  -- threat indicator
  oq.utimer_start( "temporary timer", "alliance", 41, 60, 1 ) ;
  oq.threat_frame():Show() ;
  oq.threat_frame():SetPoint( "TOPLEFT", UIParent, "TOPLEFT", x, -150 ) ;
  oq.threat_frame():SetWidth(100) ;
  oq.threat_frame():_save_position() ;
  
  -- toggle minimap button so it's on top
  OQ_MinimapButton:Show() ;
  OQ_MinimapButton:SetFrameStrata( "MEDIUM" ) ;
  OQ_MinimapButton:SetFrameLevel(50) ;

  -- log
  if (oq._log) then
    oq._log:Show() ;
    oq._log:SetPoint( "TOPLEFT", UIParent, "TOPLEFT", x, -325 ) ;
    oq._log:_save_position() ;
  end
end

function oq.color_blind_mode( opt )
--  if (not OQColorBlindShader:IsVisible()) then
  if (not oq.tab5_colorblindshader:IsVisible()) then
    return nil ;
  end
  if (OQ_data.colorblindshader == nil) then
    OQ_data.colorblindshader = 0 ;
  end
  if (opt ~= nil) and (opt == "?") then
    print( "OQ: color-blind-shader: ".. OQ.COLORBLINDSHADER[ OQ_data.colorblindshader ] ) ;
    return nil ;
  end
  if (opt ~= nil) and (opt == "next") then
    OQ_data.colorblindshader = (OQ_data.colorblindshader + 1) % 9 ;
  elseif (opt == nil) or (type(tonumber(opt)) ~= "number") then
    OQ_data.colorblindshader = 0 ;
  else
    OQ_data.colorblindshader = (tonumber(opt) % 9) ;
  end
  ConsoleExec( "colorblindshader ".. tostring( OQ_data.colorblindshader ) ) ;
  
  if (oq.tab5_colorblindshader ~= nil) then
    oq.tab5_colorblindshader._edit:SetText( OQ.COLORBLINDSHADER[OQ_data.colorblindshader or 0] ) ;
  end
  return 1 ;
end

function oq.show_data( opt )
  if (opt == nil) or (opt == "?") then
    print( "oQueue v".. OQUEUE_VERSION .."  build ".. OQ_BUILD .." (".. tostring(OQ.REGION) ..")" ) ;
    print( " usage:  /oq show <option>" ) ;
    print( "   remove       list all the battle-tags that will be removed with 'remove now'" ) ;
    print( "   report       show battleground reports yet to be filed" ) ;
    print( "   stats        list various stats" ) ;
  elseif (opt == "thebook") then
    oq.show_the_book() ;
  elseif (opt == "remove") then
    oq.remove_OQadded_bn_friends( "show" ) ;
  elseif (opt == "btags") then
    oq.show_btags() ;
  elseif (opt == "report") then
    oq.show_reports() ;
  elseif (opt == "raid") then
    oq.show_raid() ;
  elseif (opt == "stats") then
    oq.dump_statistics() ;
  elseif (opt == "timers") then
    oq.timer_dump() ;
  elseif (opt == "frames") then
    oq.frame_report() ;
  elseif (opt == "wallet") then
    oq.show_wallet() ;
  end
end

function oq.show_wallet() 
  if (OQ_toon.player_wallet == nil) then
    return ;
  end
  print( "--[ wallet ]--" ) ;
  for i,v in pairs(OQ_toon.player_wallet) do
    print( "  ".. tostring(i) .."  ".. tostring(v) ) ;
  end
  print( "--" ) ;
end

function oq.show_reports()
end

function oq.toggle_option( opt )
  if (opt == nil) or (opt == "?") then
    print( "oQueue v".. OQUEUE_VERSION .."  build ".. OQ_BUILD .." (".. tostring(OQ.REGION) ..")" ) ;
    print( " usage:  /oq toggle <option>" ) ;
    print( "   ads          toggle the premade advertisements" ) ;
    print( "   mini         toggle the minimap icon" ) ;    
  elseif (opt == "mini") then 
    oq.toggle_mini() ;
  elseif (opt == "ads") then
    if (OQ_data.show_premade_ads == nil) or (OQ_data.show_premade_ads == 0) then
      OQ_data.show_premade_ads = 1 ;
      print( "premade advertisements are now ON" ) ;
    else
      OQ_data.show_premade_ads = 0 ;
      print( "premade advertisements are now OFF" ) ;
    end
  end  
end

function oq.harddrop()
  oq.raid_init() ;
end

function oq.leave_party()
  oq._last_raid_token = oq.raid.raid_token ;
  if (oq.iam_raid_leader()) then
    oq.raid_disband() ;
  else
    LeaveParty() ;
    oq.raid_init() ;
  end
  oq.raid_cleanup() ;
end

function oq.dip()
  local n_bnfriends = select( 1, BNGetNumFriends() )  ;
  if (n_bnfriends >= OQ_MAX_BNFRIENDS) then
    print( OQ_LILSKULL_ICON .." ".. string.format( OQ.NODIPFORYOU, OQ_MAX_BNFRIENDS ) ) ;
    return ;
  end
  local now = utc_time() ;
  if (_next_dip > now) then
    return ;
  end
  _next_dip = now + OQ_DIP_GAP ;
  
  local msg_tok = "W".. oq.token_gen() ;
  oq.token_push( msg_tok ) ;
  
  local token = "M".. oq.token_gen() ;
  oq.token_push( token ) ;
  
  local msg = "OQ,".. 
              OQ_VER ..",".. 
              msg_tok ..","..
              OQ_TTL ..",".. 
              "req_mesh,".. 
              token ;  
              
  -- allow for dip request
  local temp = _oqgeneral_lockdown ;
  _oqgeneral_lockdown = nil ;
  oq.channel_general( msg ) ;
  _oqgeneral_lockdown = temp ;
end

function oq.ban_user( tag )
  if (tag == nil) then
    return ;
  end
  local dialog = StaticPopup_Show("OQ_BanUser", tag ) ;
  if (dialog ~= nil) then
    dialog.data2 = { flag = 3, btag = tag } ;
  end
end

function oq.last_lust()
  if (_last_lust ~= nil) then
    print( _last_lust ) ;
  else
    print( "nothing to report" ) ;
  end
end

function oq.usage()
  print( "oQueue v".. OQUEUE_VERSION .."  build ".. OQ_BUILD .." (".. tostring(OQ.REGION) ..")" ) ;
  print( L["usage:  /oq [command]"] ) ;
  print( L["command such as:"] ) ;
  print( L["  adds            show the list of OQ added b.net friends"] ) ;
  print( L["  ban [b-tag]     manually add battle-tag to your ban list"] ) ;
  print( L["  bnclear         clear OQ enabled battle-net associations"] ) ;
  print( L["  brb             signal to the group that you'll be-right-back"] ) ;
  print( L["  check           force OQ capability check"] ) ;
  print( L["  cp              toggle class portraits to normal portrait"] ) ;
  print( L["  dg              drop group.  same as /script LeaveParty()"] ) ;
  print( L["  fixui           will reposition the UI to upper left area"] ) ;
  print( L["  godark          send 'oq stop' to all your OQ enabled friends"] ) ;
  print( L["  id              show guid, id, and name of target"] ) ;
  print( L["  log [clear]     toggle log on/off or clear"] ) ;
  print( L["  lust            re-display the last lust message"] ) ;
  print( L["  mini            toggle the minimap button"] ) ;
  print( L["  mycrew [clear]  for boxers, populate the alt list"] ) ;
  print( L["  now             print the current utc time (only visible to user)"] ) ;
  print( L["  off             turn off OQ messaging"] ) ;
  print( L["  on              turn on OQ messaging"] ) ;
  print( L["  pnow            print the current utc time to party chat"] ) ;
  print( L["  pos             print your current locaiton in the world"] ) ;
  print( L["  purge           purge friends list of OQ added b.net friends"] ) ;
  print( L["  rage            report the number of rage-quitters (in BG only)"] ) ;
  print( L["  rc              start role check (OQ premade leader only)"] ) ;
  print( L["  refresh         sends out a request to refresh find-premade list"] ) ;
  print( L["  show <opt>      show various information"] ) ;
  print( L["  stats           various statistics about the player"] ) ;
  print( L["  spy [on|off]    display summary of enemy class types"] ) ;
  print( L["  toggle <opt>    toggle specific option"] ) ;
  print( L["  who             list of OQ enabled battle-net friends"] ) ;    
end

function oq.data_reset()
    oq = { my_tok = nil, ui = {}, channels = {}, premades = {}, raid = {}, waitlist = {} } ;
    OQ_data = { bn_friends = {} } ;
    oq.init_stats_data() ;
    OQ_toon = { last_tm = 0,
                auto_role = 1,
                class_portrait = 1,
                shout_kbs = 1,
                shout_caps = 1,
                shout_ragequits = 1,
                say_sapped = 1,
                who_popped_lust = 1,
                reports = {},
              } ;
    print( "oQueue data reset.  for it to take effect, type /reload" ) ;
end

function oq.debug_toggle( level )
  if (level) then
    if (level == "off") then 
      _debug = nil ; 
      print( "debug off" ) ;
    elseif (level == "on") then
      _debug = true ; 
      print( "debug on" ) ;
    elseif (tonumber(level)) then
      oq._debug_level = tonumber(level) ;
      print( "debug level: ".. tostring(oq._debug_level) ) ;
    end
  else
    if (_debug) then
      _debug = nil ; 
      print( "debug off" ) ;
    else
      _debug = true ; 
      print( "debug on" ) ;
    end
  end
end

function oq.godark()
  -- clear out bn friends
  oq.bn_clear() ;
  -- turn it off
  oq.oq_off() ;
  -- update OQ friends count
  oq.n_connections() ;
end

function oq.oq_off() 
  OQ_toon.disabled = true ;
  oq.reset_bn_custom_msg() ;
  print( OQ.DISABLED ) ;
end

function oq.oq_on() 
  OQ_toon.disabled = nil ;
  oq.init_bn_custom_msg() ;
  print( OQ.ENABLED ) ;
end

function oq.GetNumPartyMembers()
  return GetNumGroupMembers() ;
end

local _consts = { 0x00000000, 0x77073096, 0xEE0E612C, 0x990951BA, 0x076DC419, 0x706AF48F, 0xE963A535, 0x9E6495A3, 0x0EDB8832, 
                  0x79DCB8A4, 0xE0D5E91E, 0x97D2D988, 0x09B64C2B, 0x7EB17CBD, 0xE7B82D07, 0x90BF1D91, 0x1DB71064, 0x6AB020F2, 
                  0xF3B97148, 0x84BE41DE, 0x1ADAD47D, 0x6DDDE4EB, 0xF4D4B551, 0x83D385C7, 0x136C9856, 0x646BA8C0, 0xFD62F97A, 
                  0x8A65C9EC, 0x14015C4F, 0x63066CD9, 0xFA0F3D63, 0x8D080DF5, 0x3B6E20C8, 0x4C69105E, 0xD56041E4, 0xA2677172, 
                  0x3C03E4D1, 0x4B04D447, 0xD20D85FD, 0xA50AB56B, 0x35B5A8FA, 0x42B2986C, 0xDBBBC9D6, 0xACBCF940, 0x32D86CE3, 
                  0x45DF5C75, 0xDCD60DCF, 0xABD13D59, 0x26D930AC, 0x51DE003A, 0xC8D75180, 0xBFD06116, 0x21B4F4B5, 0x56B3C423, 
                  0xCFBA9599, 0xB8BDA50F, 0x2802B89E, 0x5F058808, 0xC60CD9B2, 0xB10BE924, 0x2F6F7C87, 0x58684C11, 0xC1611DAB, 
                  0xB6662D3D, 0x76DC4190, 0x01DB7106, 0x98D220BC, 0xEFD5102A, 0x71B18589, 0x06B6B51F, 0x9FBFE4A5, 0xE8B8D433, 
                  0x7807C9A2, 0x0F00F934, 0x9609A88E, 0xE10E9818, 0x7F6A0DBB, 0x086D3D2D, 0x91646C97, 0xE6635C01, 0x6B6B51F4, 
                  0x1C6C6162, 0x856530D8, 0xF262004E, 0x6C0695ED, 0x1B01A57B, 0x8208F4C1, 0xF50FC457, 0x65B0D9C6, 0x12B7E950, 
                  0x8BBEB8EA, 0xFCB9887C, 0x62DD1DDF, 0x15DA2D49, 0x8CD37CF3, 0xFBD44C65, 0x4DB26158, 0x3AB551CE, 0xA3BC0074, 
                  0xD4BB30E2, 0x4ADFA541, 0x3DD895D7, 0xA4D1C46D, 0xD3D6F4FB, 0x4369E96A, 0x346ED9FC, 0xAD678846, 0xDA60B8D0, 
                  0x44042D73, 0x33031DE5, 0xAA0A4C5F, 0xDD0D7CC9, 0x5005713C, 0x270241AA, 0xBE0B1010, 0xC90C2086, 0x5768B525, 
                  0x206F85B3, 0xB966D409, 0xCE61E49F, 0x5EDEF90E, 0x29D9C998, 0xB0D09822, 0xC7D7A8B4, 0x59B33D17, 0x2EB40D81, 
                  0xB7BD5C3B, 0xC0BA6CAD, 0xEDB88320, 0x9ABFB3B6, 0x03B6E20C, 0x74B1D29A, 0xEAD54739, 0x9DD277AF, 0x04DB2615, 
                  0x73DC1683, 0xE3630B12, 0x94643B84, 0x0D6D6A3E, 0x7A6A5AA8, 0xE40ECF0B, 0x9309FF9D, 0x0A00AE27, 0x7D079EB1, 
                  0xF00F9344, 0x8708A3D2, 0x1E01F268, 0x6906C2FE, 0xF762575D, 0x806567CB, 0x196C3671, 0x6E6B06E7, 0xFED41B76, 
                  0x89D32BE0, 0x10DA7A5A, 0x67DD4ACC, 0xF9B9DF6F, 0x8EBEEFF9, 0x17B7BE43, 0x60B08ED5, 0xD6D6A3E8, 0xA1D1937E, 
                  0x38D8C2C4, 0x4FDFF252, 0xD1BB67F1, 0xA6BC5767, 0x3FB506DD, 0x48B2364B, 0xD80D2BDA, 0xAF0A1B4C, 0x36034AF6, 
                  0x41047A60, 0xDF60EFC3, 0xA867DF55, 0x316E8EEF, 0x4669BE79, 0xCB61B38C, 0xBC66831A, 0x256FD2A0, 0x5268E236, 
                  0xCC0C7795, 0xBB0B4703, 0x220216B9, 0x5505262F, 0xC5BA3BBE, 0xB2BD0B28, 0x2BB45A92, 0x5CB36A04, 0xC2D7FFA7, 
                  0xB5D0CF31, 0x2CD99E8B, 0x5BDEAE1D, 0x9B64C2B0, 0xEC63F226, 0x756AA39C, 0x026D930A, 0x9C0906A9, 0xEB0E363F, 
                  0x72076785, 0x05005713, 0x95BF4A82, 0xE2B87A14, 0x7BB12BAE, 0x0CB61B38, 0x92D28E9B, 0xE5D5BE0D, 0x7CDCEFB7, 
                  0x0BDBDF21, 0x86D3D2D4, 0xF1D4E242, 0x68DDB3F8, 0x1FDA836E, 0x81BE16CD, 0xF6B9265B, 0x6FB077E1, 0x18B74777, 
                  0x88085AE6, 0xFF0F6A70, 0x66063BCA, 0x11010B5C, 0x8F659EFF, 0xF862AE69, 0x616BFFD3, 0x166CCF45, 0xA00AE278, 
                  0xD70DD2EE, 0x4E048354, 0x3903B3C2, 0xA7672661, 0xD06016F7, 0x4969474D, 0x3E6E77DB, 0xAED16A4A, 0xD9D65ADC, 
                  0x40DF0B66, 0x37D83BF0, 0xA9BCAE53, 0xDEBB9EC5, 0x47B2CF7F, 0x30B5FFE9, 0xBDBDF21C, 0xCABAC28A, 0x53B39330, 
                  0x24B4A3A6, 0xBAD03605, 0xCDD70693, 0x54DE5729, 0x23D967BF, 0xB3667A2E, 0xC4614AB8, 0x5D681B02, 0x2A6F2B94, 
                  0xB40BBE37, 0xC30C8EA1, 0x5A05DF1B, 0x2D02EF8D }
   
function oq.CRC32(s)
   local bit_band, bit_bxor, bit_rshift, str_byte, str_len = bit.band, bit.bxor, bit.rshift, string.byte, string.len
   local crc, l, i = 0xFFFFFFFF, str_len(s)
   for i = 1, l, 1 do
      crc = bit_bxor(bit_rshift(crc, 8), _consts[bit_band(bit_bxor(crc, str_byte(s, i)), 0xFF) + 1])
   end
   return bit_bxor(crc, -1)
end

function oq.mycrew( arg )
  -- use the current raid/party to poulate the OQ_data.my_toons
  if (arg == "clear") then
    oq.clear_alt_list() ;
    return ;
  end
  if (not UnitInParty("player")) then
    return ;
  end
  oq.clear_alt_list() ;
  local n = GetNumGroupMembers() ;
  if (n > 0) then
    for i=1,n do
      local name = select( 1, GetRaidRosterInfo(i) ) ;
      oq.add_toon( name ) ;
    end
  else
    n = oq.GetNumPartyMembers() ;
    oq.add_toon( player_name ) ;
    for i=1,n do
      local name = GetUnitName( "party".. i ) ;
      oq.add_toon( name ) ;
    end
  end
end

-- this will return utc time in seconds
--
function oq.timezone_reset()
  oq.__date1 = nil ;
  oq.__date2 = nil ;
end

function oq.force_time_reset() 
  print( "OQ: forcing timezone reset" ) ;
  oq.timezone_reset() ;
  oq.show_now() ;
end

function utc_time( arg )
  if (arg == nil) then
    local now = time() ;
    if (oq.__date1 == nil) then
      oq.__date1 = date("!*t") ;
      oq.__date2 = date("!*t", now) ;
    end
    return time( oq.__date1 ) + difftime(now, time( oq.__date2 )) ;
    --
    -- date("!*t") leaks a table after every call.  to avoid, only call once
    -- this will cause a problem for those ppl with incorrect set timezones.
    -- whereas they will automatically pick up the timezone change now, this
    -- will force them to tell oq to re-calc the tables
    --
    --    return time(date("!*t")) + difftime(now, time(date("!*t", now) )) ;
  else
    return time(date("!*t")) ;
  end
end

function oq.reset_portrait( f, player, show_default )
  if (f == nil) or (f.portrait == nil) then
    return ;
  end
  if (show_default) then
    SetPortraitTexture( f.portrait, player ) ;
    f.portrait:SetTexCoord(0,1,0,1) ;
  else
    OQ_ClassPortrait( f ) ;
  end
end

function oq.toggle_class_portraits()
  if (OQ_toon.class_portrait == 1) then
    OQ_toon.class_portrait = 0 ;
  else
    OQ_toon.class_portrait = 1 ;
  end
  oq.reset_portrait( PlayerFrame      , "player", (OQ_toon.class_portrait == 0) ) ;
  oq.reset_portrait( TargetFrame      , "target", (OQ_toon.class_portrait == 0) ) ;
  oq.reset_portrait( PartyMemberFrame1, "party1", (OQ_toon.class_portrait == 0) ) ;
  oq.reset_portrait( PartyMemberFrame2, "party2", (OQ_toon.class_portrait == 0) ) ;
  oq.reset_portrait( PartyMemberFrame3, "party3", (OQ_toon.class_portrait == 0) ) ;
  oq.reset_portrait( PartyMemberFrame4, "party4", (OQ_toon.class_portrait == 0) ) ;
  oq.reset_portrait( PartyMemberFrame5, "party5", (OQ_toon.class_portrait == 0) ) ;
end

function oq.render_tm( dt )
  dt = abs(dt) ;
  if (dt > 0) then
    local dsec, dmin, dhr, ddays, dyrs, dstr ;
    ddays = floor(dt / (24*60*60)) ;
    dt = dt % (24*60*60) ;
    dyrs = floor( ddays / 365 ) ;
    ddays = ddays % 365 ;
    dhr = floor(dt / (60*60)) ;
    dt = dt % (60*60) ;
    dmin = floor(dt / 60) ;
    dt = dt % 60 ;
    dsec = dt ;
    dstr = "" ;
    if (dyrs > 0) then
      dstr = dyrs .."y ".. ddays .."d ".. string.format("%02d:%02d:%02d", dhr, dmin, dsec ) ;
    elseif (ddays > 0) then
      dstr = ddays .."d ".. string.format("%02d:%02d:%02d", dhr, dmin, dsec ) ;
    elseif (dhr > 0) then
      dstr = string.format("%02d:%02d:%02d", dhr, dmin, dsec ) ;
    elseif (dmin > 0) then
      dstr = string.format("%02d:%02d", dmin, dsec ) ;
    else
      dstr = string.format("00:%02d", dsec ) ;
    end
    return dstr ;
  else
    return "xx:xx" ;
  end
end

function oq.show_now( arg )
  local now = utc_time( arg ) ;
  local msg = string.format( OQ.THETIMEIS, now ) ;
  print( string.format( OQ.THETIMEIS, now ) .."  ".. date("!%H:%M %d %b %Y UTC", now ) ) ;
  
  -- show difference from scorekeeper time
  if (oq._sktime_last_tm == nil) then
    return ;
  end
  local dt = abs(oq._sktime_last_dt) ;
  if (dt > 0) then
    local dsec, dmin, dhr, ddays, dyrs, dstr ;
    ddays = floor(dt / (24*60*60)) ;
    dt = dt % (24*60*60) ;
    dyrs = floor( ddays / 365 ) ;
    ddays = ddays % 365 ;
    dhr = floor(dt / (60*60)) ;
    dt = dt % (60*60) ;
    dmin = floor(dt / 60) ;
    dt = dt % 60 ;
    dsec = dt ;
    dstr = "local time varies from scorekeeper by: " ;
    if (dyrs > 0) then
      dstr = dstr .." ".. dyrs .." yrs ".. ddays .." days ".. dhr ..":".. dmin ..":".. dsec ;
    elseif (ddays > 0) then
      dstr = dstr .." ".. ddays .." days ".. dhr ..":".. dmin ..":".. dsec ;
    elseif (dhr > 0) then
      dstr = dstr .." ".. dhr ..":".. dmin ..":".. dsec .." hours" ;
    elseif (dmin > 0) then
      dstr = dstr .." ".. dmin ..":".. dsec .." minutes" ;
    else
      dstr = dstr .." ".. dsec .." seconds" ;
    end
    print( dstr ) ;
  end
end

function oq.show_now2party( arg )
  local msg = string.format( OQ.THETIMEIS, utc_time( arg )) ;
  SendChatMessage( msg, "PARTY", nil ) ;  
end
-------------------------------------------------------------------------------
-- token functions
-------------------------------------------------------------------------------
local OQ_atoken = {} ;
function oq.atok_last_seen( token )
  if (token == nil) or (OQ_atoken[ token ] == nil) then
    return 0 ;
  end
  return OQ_atoken[ token ] ;
end

function oq.atok_seen( token )
  if (token ~= nil) then
    OQ_atoken[ token ] = utc_time() ;
  end
end

-- will register token as seen if ok to process
--
function oq.atok_ok2process( token )
  local last_seen = oq.atok_last_seen( token ) ;
  local now = utc_time() ;
  if ((now - last_seen) > OQ_MIN_ATOKEN_RELAY_TM) then
    oq.atok_seen( now ) ;
    return true ;
  end
end

function oq.atok_clear_old()
  local now = utc_time() ;
  for i,v in pairs(OQ_atoken) do
    if ((now - v) > OQ_MAX_ATOKEN_LIFESPAN) then
      OQ_atoken[i] = nil ;
    end
  end
end

function oq.atok_clear()
  tbl.clear( OQ_atoken ) ;
end

function oq.token_gen()
--[[
  local tm = floor( GetTime() * 1000 ) ;
  local r = random( 0, 10000 ) ;
  local token = (tm % 100000) * 10000 + r ;
  return oq.encode_mime64_5digit(token) ;
]]--
  return oq.encode_mime64_5digit( utc_time() * 10000 + random( 0, 10000 )) ;

-- was producing a 9 digit token, now will produce only 5 (needed the room)
--  return tostring(token) ;
-- 
end

local OQ_recent_tokens = {} ;
local OQ_recent_keys = {} ;
local OQ_tok_cnt = 0 ;
function oq.token_list_init()
  for i=1,500 do
    OQ_recent_tokens[i] = i ;
    OQ_recent_keys[i] = i ;
  end
  OQ_tok_cnt = 501 ;
end

function oq.token_was_seen( token )
  return (OQ_recent_keys[ token ] ~= nil) ;
end

--
--  remove one from the front, push one to the back
--
function oq.token_push( token_ )
  local key = table.remove( OQ_recent_tokens, 1 ) ;
  if (OQ_recent_keys == nil) then
    OQ_recent_keys = tbl.new() ;
  end
  if (OQ_recent_tokens == nil) then
    OQ_recent_tokens = tbl.new() ;
  end
  if (key ~= nil) then
    OQ_recent_keys[ key ] = nil ;
  end

  OQ_tok_cnt = OQ_tok_cnt + 1 ;
  OQ_recent_tokens[ OQ_tok_cnt ] = token_ ;
  OQ_recent_keys  [ token_     ] = OQ_tok_cnt ;
end

-------------------------------------------------------------------------------
--   
-------------------------------------------------------------------------------
function oq.tremove_value( t, val )
  for i,v in pairs(t) do
    if (v == val) then
      tremove( t, i ) ;
      return ;
    end
  end
end

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
local function tprint_col (tbl, indent, key )
   if not indent then indent = 0 end
   local ln = string.rep(" ", indent) ;
   for k, v in pairs(tbl) do
      if type(v) == "table" then
         formatting = string.rep(" ", indent) ;
         tprint_col(v, indent+1, k)
      elseif (k ~= "leader_rid") then
         ln = ln .." ".. k ..": ".. tostring(v) ;
      end
   end
   if (key ~= nil) then
      print( tostring(key) ..": ".. ln ) ;
   else
      print( ln ) ;
   end
end

function oq.n_rows(t)
  local n = 0 ;
  for i,v in pairs(t) do
    n = n + 1 ;
  end
  return n ;
end

function oq.total_tears()
  local n = 0 ;
  for i,v in pairs(OQ_data.tear_cup) do
    n = n + v ;
  end
  return n ;
end

function oq.new_tears( ntears )
  if (player_name == nil) then
    player_name = UnitName("player") ;
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  if (player_faction == nil) then
    oq.get_player_faction() ;
  end
  local ndx = strlower( player_realm ) ..".".. player_faction ..".".. strlower( player_name ) ;
  OQ_data.tear_cup[ ndx ] = (OQ_data.tear_cup[ ndx ] or 0) + ntears ;
end

function oq.n_premades()
  local nShown, nPremades = 0, 0 ;
  if (oq.tab2_raids ~= nil) then
    for n,v in pairs(oq.tab2_raids) do 
      local p = oq.premades[ v.token ] ;
      if (p ~= nil) then
        if (v._isvis) then
          nShown = nShown + 1 ;
        end
        nPremades = nPremades + 1 ;
      end
    end
  end
  return nShown, nPremades ;
end

function oq.dump_statistics()
  oq.gather_my_stats() ;
  
  print( "oQueue premade stats" ) ;
  print( "---" ) ;
  print( " leader stats" ) ;
  print( " -  regular bg   : ".. tostring(OQ_data.leader["bg"].nWins or 0) .." - ".. tostring(OQ_data.leader["bg"].nLosses or 0) .." over ".. tostring(OQ_data.leader["bg"].nGames or 0) .." games" ) ;
  print( " -  rated bg     : ".. tostring(OQ_data.leader["rbg"].nWins or 0) .." - ".. tostring(OQ_data.leader["rbg"].nLosses or 0) .." over ".. tostring(OQ_data.leader["rbg"].nGames or 0) .." games" ) ;
  print( " -  5Mans        : ".. tostring(OQ_data.leader["pve.5man"].nBosses) .." - ".. tostring(OQ_data.leader["pve.5man"].nWipes) .."  pts: ".. tostring(OQ_data.leader["pve.5man"].pts) ) ;
  print( " -  raids        : ".. tostring(OQ_data.leader["pve.raid"].nBosses) .." - ".. tostring(OQ_data.leader["pve.raid"].nWipes) .."  pts: ".. tostring(OQ_data.leader["pve.raid"].pts) ) ;
  print( " -  challenges   : ".. tostring(OQ_data.leader["pve.challenge"].nBosses) .." - ".. tostring(OQ_data.leader["pve.challenge"].nWipes) .."  pts: ".. tostring(OQ_data.leader["pve.challenge"].pts) ) ;
  print( " -  scenarios    : ".. tostring(OQ_data.leader["pve.scenario"].nBosses) .." - ".. tostring(OQ_data.leader["pve.scenario"].nWipes) .."  pts: ".. tostring(OQ_data.leader["pve.scenario"].pts) ) ;
  
  print( "  my win-loss      : " ) ;
  print( " -  regular bg     : ".. tostring(OQ_toon.stats["bg"].nWins or 0) .." - ".. tostring(OQ_toon.stats["bg"].nLosses or 0) .." over ".. tostring(OQ_toon.stats["bg"].nGames or 0) .." games") ;
  print( " -  rated bg       : ".. tostring(OQ_toon.stats["rbg"].nWins or 0) .." - ".. tostring(OQ_toon.stats["rbg"].nLosses or 0) .." over ".. tostring(OQ_toon.stats["rbg"].nGames or 0) .." games" ) ;
  
  print( "  my_tears         : ".. tostring(oq.total_tears()) ) ;

  print( "  my_region        : ".. tostring(OQ.REGION) ) ;
  print( "  my_realmlist     : ".. tostring(GetCVar("realmlist")) ) ;
  print( "  my_realm         : ".. tostring(player_realm)  .." (".. tostring(oq.realm_cooked(player_realm)) ..")" ) ;
  print( "  my_btag          : ".. tostring( player_realid ) ) ;
  print( "  my_karma         : ".. tostring( player_karma ) ) ;
  print( "  my_role          : ".. tostring( OQ.ROLES[player_role] ) ) ;
  print( "  my_ilevel        : ".. oq.get_ilevel() ) ;
  print( "  my_rbg_rating    : ".. oq.get_mmr() ) ;
  print( "  my_2s_rating     : ".. oq.get_arena_rating(1) ) ;
  print( "  my_3s_rating     : ".. oq.get_arena_rating(2) ) ;
  print( "  my_5s_rating     : ".. oq.get_arena_rating(3) ) ;
  print( "  my_resil         : ".. oq.get_resil() ) ;
  if (oq.raid.raid_token == nil) then
    print( "  my_group:  not in an OQ premade" ) ;
  else
    print( "  my_group: ".. tostring( oq.raid.type ) ..".".. tostring( oq.raid.raid_token ) .." . ".. tostring( my_group ) .." . ".. tostring( my_slot ) .."  ".. tostring(oq.raid.leader) .."-".. tostring(oq.raid.leader_realm) ) ;
    if (oq.iam_related_to_boss()) then
      print( "    --  i am related to the boss" ) ;
    end
  end
  if (_inside_bg) then
    print( " inside bg       : yes   [".. tostring(_bg_zone) ..". ".. tostring(_bg_shortname) .."]" ) ;
  else
    print( " inside bg       : no" ) ;
  end
  if (OQ_toon.disabled) then
    print( "  OQ messaging is DISABLED" ) ;
  else
    print( "  OQ messaging is ENABLED" ) ;
  end
  local nShown, nPremades = oq.n_premades() ;
  print( "  # of premades        : ".. nShown .." / ".. nPremades ) ;
  print( "  # of BN friends      : ".. select( 1, BNGetNumFriends() ) ) ;
  print( "  packets recv         : ".. oq.pkt_recv._cnt .." (".. string.format( "%5.3f", oq.pkt_recv._aps ) .." per sec)" ) ;
  print( "  packets processed    : ".. oq.pkt_processed._cnt .." (".. string.format( "%5.3f", oq.pkt_processed._aps ) .." per sec)" ) ;
  print( "  packets sent         : ".. oq.pkt_sent._cnt .." (".. string.format( "%5.3f", oq.pkt_sent._aps ) .." per sec)  ".. #oq.send_q .." q'd" ) ;
  print( "" ) ;
  
  if (_oqgeneral_lockdown) then
    if (_oqgeneral_count > 0) then
      print( "  oqgeneral #: ".. _oqgeneral_count .."   channel over capacity.  restricted" ) ;
    else
      print( "  oqgeneral #: ".. _oqgeneral_count .."   restricted" ) ;
    end
  else
    if (_oqgeneral_count > MAX_OQGENERAL_TALKERS) then
      print( "  oqgeneral #: ".. _oqgeneral_count .."   channel over capacity.  no restrictions" ) ;
    else
      print( "  oqgeneral #: ".. _oqgeneral_count .."   no restrictions" ) ;
    end
  end
  print( "---" ) ;
end

function oq.show_member(m)
  print( "-- [".. tostring(m.name) .."][".. tostring(m.realm) .."]" ) ;
end

function oq.show_adds()
  local ntotal, nonline = BNGetNumFriends() ;
  local cnt = 0 ;
  print( "---  OQ added friends" ) ;
  for friendId=1,ntotal do
    local f = { BNGetFriendInfo( friendId ) } ;
    local presenceID = f[1] ;
    local givenName  = f[2] ;
    local btag       = f[3] ;
    local client     = f[7] ;
    local online     = f[8] ;
    local noteText   = f[13] ;
    if (noteText ~= nil) and ((noteText:find( "OQ," ) == 1) or (noteText:find( "REMOVE OQ" ) == 1)) then
      print( presenceID ..".  ".. givenName .." ".. btag .."   [".. noteText .."]" ) ;
      cnt = cnt + 1 ;
    elseif ((noteText == nil) or (noteText == "")) and oq.in_btag_cache( tag ) then
      print( presenceID ..".  ".. givenName .." ".. btag .."   [".. noteText .."]" ) ;
      cnt = cnt + 1 ;
    end
  end  
  print( "---  total :  ".. cnt ) ;
end

function oq.show_bn_enabled() 
  local cnt = 0 ;

  oq.bn_force_verify() ;
  print( "--[ OQ enabled ]--" ) ;
  for i,v in pairs(OQ_data.bn_friends) do
    if (v.isOnline and (v.oq_enabled or v.sk_enabled)) then
      print( tostring(v.presenceID) ..".  ".. tostring(v.toonName) .."-".. tostring(v.realm) ) ;
      cnt = cnt + 1 ;
    end
  end
  print( cnt .." bn friends OQ enabled" ) ;
  print( tostring( oq.n_channel_members( "OQgeneral" ) ) .." OQ enabled locals" ) ;
  
  oq.n_connections() ;  
end

function oq.raid_init()
  oq.raid = tbl.new() ;
  oq.raid.group = tbl.new() ;
  for i = 1,8 do
    oq.raid.group[i] = tbl.new() ;
    oq.raid.group[i].member = tbl.new() ;
    for j=1,5 do
      oq.raid.group[i].member[j] = tbl.new() ;
      oq.raid.group[i].member[j].flags = 0 ;
      oq.raid.group[i].member[j].bg = tbl.new() ;
      oq.raid.group[i].member[j].bg[1] = tbl.new() ;
      oq.raid.group[i].member[j].bg[2] = tbl.new() ;
    end
  end
  oq.raid.raid_token = nil ;
  oq.raid.type = OQ.TYPE_BG ;
  oq.waitlist  = tbl.new() ;
  oq.pending   = tbl.new() ;
  my_group     = 0 ;
  my_slot      = 0 ;
  
  oq.procs_no_raid() ;
end

function oq.channel_isregistered( chan_name )
  local n = strlower( chan_name ) ;
  return (oq.channels[ n ]) ;
end

function oq.buildChannelList(...)
   local tbl = {}
   for i = 1, select("#", ...), 2 do
      local id, name = select(i, ...)
      tbl[id] = strlower(name)
   end
   return tbl
end

function oq.channel_join( chan_name, pword )
  local n = strlower( chan_name ) ;

  JoinTemporaryChannel( n, pword ) ;
  local id, chname = GetChannelName( n ) ;

  oq.channels[ n ]       = {} ;
  oq.channels[ n ].id    = id ;
  oq.channels[ n ].pword = pword ;
end

function oq.hook_roster_update(chan_name)
  local n = strlower( chan_name ) ;
  local nchannels = GetNumDisplayChannels() ;
  for i=1,nchannels do
    local name, header, collapsed, channelNumber, count, active, category, 
          voiceEnabled, voiceActive = GetChannelDisplayInfo(i) ;
    if (name ~= nil) and (strlower(name) == n) then
      _oqgeneral_id = i ;
      SetSelectedDisplayChannel( _oqgeneral_id ) ;
      return true ;
    end
  end
end

local _names = {} ;
function oq.check_oqgeneral_lockdown()
  local n, index = oq.n_channel_members( "oqgeneral" ) ;
  _oqgeneral_count = n ;
  if (n < MAX_OQGENERAL_TALKERS) or (n == 0) then
    -- no restrictions
    _oqgeneral_lockdown = (n == 0) ;
    return ;
  end
   
  local old_chan_ndx = GetSelectedDisplayChannel() ;
  SetSelectedDisplayChannel( index ) ;
  --  local index = GetSelectedDisplayChannel()
  local count = select(5, GetChannelDisplayInfo(index))
  local activeCount = 0
  tbl.clear( _names ) ;
  for i=1,count do
    local n = select(1, GetChannelRosterInfo(index, i))
    if n then
      table.insert(_names, n) ;
    end
  end
  -- sort
  table.sort( _names ) ;
  -- determine player position in list
  count = 0 ;
  for i,v in pairs(_names) do
    count = count + 1 ;
    if (v == player_name) or (count > MAX_OQGENERAL_TALKERS) then
      _oqgeneral_lockdown = (count > MAX_OQGENERAL_TALKERS) ;
      break ;
    end
  end
   -- if position > max talkers, lockdown
  SetSelectedDisplayChannel( old_chan_ndx ) ;
end

function oq.n_channel_members( chan_name )
  local n = strlower( chan_name ) ;  
  local nchannels = GetNumDisplayChannels() ;
  for i=1,nchannels do
    local name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = GetChannelDisplayInfo(i) ;
      
    if (name ~= nil) and (n == strlower(name)) then
      return count or 0, i ;
    end
  end
  return 0, 0 ;
end

function oq.channel_leave( chan_name )
  local n = strlower( chan_name ) ;
  LeaveChannelByName( n ) ;
  oq.channels[ n ] = nil ;
end

function oq.log_clear() 
  OQ_data.log = {} ;
end

function oq.log_cmdline( opt )
  if (opt == nil) or (opt == "") then
    oq.toggle_log() ;
    return ;
  end
  if (opt == "clear") then
    if (OQ_data._history) then
      tbl.clear( OQ_data._history ) ;
      oq.log( nil, "|cFF808080log cleared on|r ".. date("%H:%M %d-%b", utc_time()) ) ;
    end
    return ;
  end
end

function oq.channel_say( chan_name, msg )
  local n = strlower( chan_name ) ;
  if ((n ~= nil) and (oq.channels[n] ~= nil)) then
    SendChatMessage( msg, "CHANNEL", nil, oq.channels[ n ].id ) ;
    oq.pkt_sent:inc() ;
  end
end

function oq.join_oq_general()
  if (oq._banned) then
    return ;
  end
  oq.channel_join( "OQGeneral" ) ;
end

function oq.oqgeneral_join()
  if (oq._banned) then
    return ;
  end
  oq.channel_join( "OQGeneral" ) ;
  oq.timer( "hook_roster_update"   ,  5, oq.hook_roster_update      , true, "OQGeneral" ) ; -- will repeat until channel joined
  oq.timer( "chk_OQGeneralLockdown", 30, oq.check_oqgeneral_lockdown, true ) ; -- will check capacity every 30 seconds
end

function oq.oqgeneral_leave()
  _oqgeneral_lockdown = true ; -- lock the door.  the restriction will life once joined and cleared
  oq.channel_leave( "OQGeneral" ) ;
  oq.timer( "chk_OQGeneralLockdown", 0, nil ) ;
end

function oq.channel_general( msg ) 
  if (_oqgeneral_lockdown) then
    return ; -- too many ppl in oqgeneral, voluntary mute engaged
  end
  oq.channel_say( "OQGeneral", msg ) ;
end

function oq.iam_in_a_party()
  if (GetNumGroupMembers() > 0) then
    return true ;
  end
  return nil ;
end

function oq.is_oqueue_msg( msg )
  if (msg:sub(1,#OQ_MSGHEADER) == OQ_MSGHEADER) or 
     (msg:sub(1,#OQSK_HEADER) == OQSK_HEADER) then
     return true ;
  end
  return nil ;
end

function oq.BNSendFriendInvite( id, msg, note )
  if (id == nil) or (id == player_realid) or (id == "") then
    return ;
  end
  local pid, is_online = oq.is_bnfriend( id ) ;
  if (pid ~= nil) then
    return ; -- already friended
  end
  if (msg ~= nil) and (#msg > 127) then
    msg = msg:sub(1,127) ;
  end
  BNSendFriendInvite( id, msg ) ;
  oq.cache_btag( id, note ) ;
  oq.pkt_sent:inc() ;
end

function oq.SendAddonMessage( channel, msg, type, to_name )
  if (msg == nil) then
    return ;
  end
  if (#msg > 254) then
    msg = msg:sub(1,254) ;
  end
  if (type == "PARTY") and ((oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID)) then
    oq.BNSendQ_push( SendAddonMessage, channel, msg, "INSTANCE_CHAT", nil ) ;
    oq.pkt_sent:inc() ;
  else
    if (type == "INSTANCE_CHAT") then
      SendAddonMessage( channel, msg, type, to_name ) ;
      oq.pkt_sent:inc() ;
    elseif (string.find(msg, ",p8,") == nil) then
      oq.BNSendQ_push( SendAddonMessage, channel, msg, type, to_name ) ;
      oq.pkt_sent:inc() ;
    end
  end  
end

function oq.channel_party( msg ) 
  if (msg == nil) then
    return ;
  end
  if (oq.iam_in_a_party()) then
    oq.SendAddonMessage( "OQ", msg, "PARTY" ) ;
  end
end

--------------------------------------------------------------------------
--  communications
--------------------------------------------------------------------------
--[[
    http://www.wowpedia.org/API_GetCombatRating
    
    CR_WEAPON_SKILL = 1;
    CR_DEFENSE_SKILL = 2;
    CR_DODGE = 3;
    CR_PARRY = 4;
    CR_BLOCK = 5;
    CR_HIT_MELEE = 6;
    CR_HIT_RANGED = 7;
    CR_HIT_SPELL = 8;
    CR_CRIT_MELEE = 9;
    CR_CRIT_RANGED = 10;
    CR_CRIT_SPELL = 11;
    CR_HIT_TAKEN_MELEE = 12;
    CR_HIT_TAKEN_RANGED = 13;
    CR_HIT_TAKEN_SPELL = 14;
    COMBAT_RATING_RESILIENCE_CRIT_TAKEN = 15;
    COMBAT_RATING_RESILIENCE_PLAYER_DAMAGE_TAKEN = 16;
    CR_CRIT_TAKEN_SPELL = 17;
    CR_HASTE_MELEE = 18;
    CR_HASTE_RANGED = 19;
    CR_HASTE_SPELL = 20;
    CR_WEAPON_SKILL_MAINHAND = 21;
    CR_WEAPON_SKILL_OFFHAND = 22;
    CR_WEAPON_SKILL_RANGED = 23;
    CR_EXPERTISE = 24;
    CR_ARMOR_PENETRATION = 25;
    CR_MASTERY = 26; 
    CR_PVP_POWER = 27; 
]]
function oq.get_pvppower()
  return (GetCombatRating(27) or 0) ;
end

function oq.on_player_mmr_change()
  oq.get_mmr() ;
end

function oq.get_best_mmr( type ) 
  if (type == OQ.TYPE_ARENA) then
    local m = 0 ;
    for i=1,3 do
      m = max( m, oq.get_arena_rating(i) ) ;
    end
    return m ;
  else
    return oq.get_mmr() ;
  end
end

function oq.get_mmr()
  return select( 1, GetPersonalRatedInfo(4) ) or 0 ;
end

function oq.get_arena_rating(type)
  return select( 1, GetPersonalRatedInfo(type) ) or 0 ;
end

function oq.my_seat()
  return my_group, my_slot ;
end

function oq.get_spell_power()
  local pow = 0 ;
  for i=1,7 do
    pow = max( pow, GetSpellBonusDamage(i) ) ;
  end
  return pow ;
end

function oq.get_spell_crit()
  -- taken from: http://www.wowwiki.com/API_GetSpellCritChance
  local minCrit = GetSpellCritChance(2);
  for i=1,7 do
    minCrit = min(minCrit, GetSpellCritChance(i));
  end
  return minCrit ;
end

function oq.get_hks()
  local hks = GetStatistic(588) or 0 ;
  if (hks == "--") then
    hks = 0 ;
  end
  return floor(hks / 1000) ;  
end

function oq.get_resil()
  return (GetCombatRating(16) or 0) ;
end

function oq.debug_report( ... )
  if (_debug) then
    print( ... ) ;
  end
end

function oq.get_ilevel()
  return floor( select( 2, GetAverageItemLevel() )) ;
end

function oq.iam_party_leader() 
  if (oq.iam_in_a_party()) then
    return ((my_group ~= 0) and (my_slot == 1)) ;
  else
    return (my_slot == 1) ;
  end
end

function oq.iam_alone()
  if (oq._inside_instance and oq._entered_alone) then
    return true ;
  end
  local n = 0 ;
  for i=1,5 do
    local m = oq.raid.group[1].member[i] ;
    if ((m.name) and (m.name ~= "-")) then
      n = n + 1 ;
    end
  end
  return (n == 1) ;
end

function oq.iam_raid_leader() 
  return ((oq.raid.leader ~= nil) and (player_name == oq.raid.leader)) ;
end

function oq.is_raid()
  if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
    return true ;
  end
  return nil ;
end

function oq.find_bgroup( realm )
  for bgroup,realms in pairs(OQ.BGROUPS) do
    for i,r in pairs(realms) do
      if (realm == r) then
        return bgroup ;
      end
    end
  end
  return nil ;
end

function oq.is_in_raid( name )
  for i,grp in pairs(oq.raid.group) do
    for j,mem in pairs(grp.member) do
      local n = mem.name ;
      if ((n) and (n ~= "") and (n ~= "-")) then
        if ((mem.realm) and (mem.realm ~= player_realm)) then
          n = n .."-".. mem.realm ;
        end
        if (name == n) then
          return true ;
        end
      end
    end
  end
  return nil ;
end

function oq.mark_currency()
  -- clear the wallet
  tbl.clear( OQ_toon.player_wallet ) ;
  -- mark currency
  local n = GetCurrencyListSize() ;
  for index = 1,n do
     local name, isHeader, isExpanded, isUnused, isWatched, count, 
           extraCurrencyType, icon, itemID = GetCurrencyListInfo(index) ;
     if (name ~= nil) then
       OQ_toon.player_wallet[ name ] = count ;
     end
  end
  -- mark rep
  for factionIndex = 1, GetNumFactions() do
    local name, description, standingId, bottomValue, topValue, earnedValue, atWarWith,
    canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)
    if (name ~= nil) then
      OQ_toon.player_wallet[ name ] = earnedValue ;
    end
  end
  -- mark xp
  OQ_toon.player_wallet[ "xp"    ] = UnitXP   ("player") or 0 ;
  OQ_toon.player_wallet[ "maxxp" ] = UnitXPMax("player") or 0 ;
  
  -- mark hks  
  OQ_toon.player_wallet[ "hks"   ] = GetStatistic(588) or 0 ;
  
  -- mark dkps
  OQ_toon.player_wallet[ "leader_dkp" ] = OQ_data.leader_dkp or 0 ;
  OQ_toon.player_wallet[ "dkp"        ] = OQ_data._dkp or 0 ;
  
  -- mark mmr
  OQ_toon.player_wallet[ "mmr"   ] = oq.get_mmr() or 0 ;
  
  -- mark money
  OQ_toon.player_wallet[ "money" ] = GetMoney() or 0 ;
end

function oq.check_currency()
  -- precaution
  if (OQ_data.stats.bg_length == nil) or (OQ_data.stats.bg_length == 0) then
    -- invalidates the rate calculation, but keeps it sane(ish)
    OQ_data.stats.bg_length = 1 ;
  end
  if (oq._instance_duration == nil) or (oq._instance_duration == 0) then
    print( OQ_LILREDX_ICON .." ".. OQ.ERR_NODURATION ) ;
    return ;
  end
  
  -- check for gains in currency
  local n = GetCurrencyListSize() ;
  for index = 1,n do
     local name, isHeader, isExpanded, isUnused, isWatched, count, 
           extraCurrencyType, icon, itemID = GetCurrencyListInfo(index) ;
     if (name ~= nil) and (OQ_toon.player_wallet[ name ] ~= nil) then
       if (OQ_toon.player_wallet[ name ] ~= count) then
         local delta = count - OQ_toon.player_wallet[name] ;
         local rate = floor( (delta / oq._instance_duration) * 60 * 60 ) ; -- bg_length is seconds * 60*60 --> delta/hr
         if (delta > 0) then
           if (name == OQ.HONOR_PTS) and (count == OQ_MAX_HONOR) then -- honor capped
             oq.log( true, name .."  ".. OQ_LILREDX_ICON .." ".. OQ.CAPPED .." ".. OQ_LILREDX_ICON ) ;
           elseif (name == OQ.HONOR_PTS) and (count >= OQ_MAX_HONOR_WARNING) then -- approaching honor capped
             oq.log( true, OQ.GAINED .." ".. delta .." ".. name .."  (".. rate .." ".. OQ.PERHOUR ..")  ".. OQ_LILREDX_ICON .." ".. OQ.APPROACHING_CAP .." ".. OQ_LILREDX_ICON ) ;
           else
             oq.log( true, OQ.GAINED .." ".. delta .." ".. name .."  (".. rate .." ".. OQ.PERHOUR ..")" ) ;
           end
         elseif (delta < 0) then
           oq.log( true, OQ.LOST .." ".. delta .." ".. name .."  (".. rate .." ".. OQ.PERHOUR ..")" ) ;
         end
       elseif (OQ_toon.player_wallet[ name ] == count) and (name == OQ.HONOR_PTS) and (count == OQ_MAX_HONOR) then
         oq.log( true, name .."  ".. OQ_LILREDX_ICON .." ".. OQ.CAPPED .." ".. OQ_LILREDX_ICON ) ;
       end
     end
  end
  
  -- check for gains in reputation
  for factionIndex = 1, GetNumFactions() do
    local name, description, standingId, bottomValue, topValue, count, atWarWith,
          canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild = GetFactionInfo(factionIndex)
    if (name ~= nil) and (OQ_toon.player_wallet[ name ] ~= nil) then
      local delta = count - OQ_toon.player_wallet[name] ;
      local rate = floor( (delta / oq._instance_duration) * 60 * 60 ) ; -- bg_length is seconds * 60*60 --> delta/hr
      if (delta > 0) then
        oq.log( true, OQ.GAINED .." ".. delta .." ".. OQ.WITH .." ".. name .."  (".. rate .." ".. OQ.PERHOUR ..")" ) ;
      elseif (delta < 0) then
        oq.log( true, OQ.LOST .." ".. delta .." ".. OQ.WITH.." ".. name .."  (".. rate .." ".. OQ.PERHOUR ..")" ) ;
      end
    end
  end
  
  -- check for gains in xp
  local xp = UnitXP("player") ;
  local maxxp = UnitXPMax("player") ;
  local delta = 0 ;
  if (maxxp ~= OQ_toon.player_wallet[ "maxxp" ]) then
    -- gained level
    -- note: won't handle gaining more then one level per bg.  not sure that's even possible
    delta = (OQ_toon.player_wallet[ "maxxp" ] - OQ_toon.player_wallet[ "xp" ]) + xp ;
  elseif (xp ~= OQ_toon.player_wallet[ "xp" ]) then
    delta = xp - OQ_toon.player_wallet[ "xp" ] ;
  end
  if (delta > 0) then
    -- report gained xp
    local rate = floor( (delta / oq._instance_duration) * 60 * 60 ) ; -- bg_length is seconds * 60*60 --> delta/hr
    oq.log( true, OQ.GAINED .." ".. delta .." XP  (".. rate .." ".. OQ.PERHOUR ..")" ) ;
  end
  
  -- check for gains in hks
  if (OQ_toon.player_wallet[ "hks" ]) then
    local hks = tonumber(GetStatistic(588) or 0) or 0 ;
    delta = hks - tonumber( OQ_toon.player_wallet[ "hks" ] or 0 ) ;
    if (delta > 0) then
      -- report gained hks
      local rate = floor( (delta / oq._instance_duration) * 60 * 60 ) ; -- bg_length is seconds * 60*60 --> delta/hr
      oq.log( true, OQ.GAINED .." ".. delta .." HKs  (".. rate .." ".. OQ.PERHOUR ..")" ) ;
    end
  end
  
  -- check for gains in dkp
  -- no need to report leadership as it would be the same if you were the lead as a member
  if (OQ_toon.player_wallet[ "dkp" ]) then
    delta = (OQ_data._dkp or 0) - OQ_toon.player_wallet[ "dkp" ] ;
    if (delta > 0) then
      -- report gained dkps
      local rate = floor( (delta / oq._instance_duration) * 60 * 60 ) ; -- bg_length is seconds * 60*60 --> delta/hr
      oq.log( true, OQ.GAINED .." ".. delta .." ".. OQ.TT_DKP .." (".. rate .." ".. OQ.PERHOUR ..")" ) ;
    end
  end
  
  -- report mmr
  local mmr = oq.get_mmr() ;
  delta = mmr - OQ_toon.player_wallet[ "mmr" ] ;
  if (delta > 0) then
    oq.log( true, OQ.GAINED .." ".. delta .." ".. OQ.TT_MMR .."  (".. OQ.NOW .." ".. mmr ..")" ) ;
  elseif (delta < 0) then
    oq.log( true, OQ.LOST .." ".. delta .." ".. OQ.TT_MMR .."  (".. OQ.NOW .." ".. mmr ..")" ) ;
  end

  if (OQ_data.nrage > 0) and (oq._instance_type == "pvp") then
    oq.report_rage() ;
  else
    local dsec = utc_time() - oq._instance_tm ;
    oq.log( true, OQ.INSTANCE_LASTED .." ".. floor(dsec / 60) ..":".. string.format( "%02d", floor( dsec % 60) ) ) ;
  end
  
  -- report money 
  if (OQ_toon.player_wallet[ "money" ]) then
    local money = GetMoney() ;
    delta = money - tonumber( OQ_toon.player_wallet[ "money" ] or 0 ) ;
    local rate = floor( (delta / oq._instance_duration) * 60 * 60 ) ; -- bg_length is seconds * 60*60 --> delta/hr
    -- shave the pennies
    delta = floor(delta/100)*100 ;
    rate  = floor(rate /100)*100 ;
    
    if (delta > 0) then
      oq.log( true, OQ.GAINED .." ".. GetCoinTextureString(delta) .."    (".. GetCoinTextureString(rate) .." ".. OQ.PERHOUR ..")" ) ;
    elseif (delta < 0) then
      oq.log( true, OQ.LOST .." ".. GetCoinTextureString(delta) .."    (".. GetCoinTextureString(rate) .." ".. OQ.PERHOUR ..")" ) ;
    end
  end
    
  if (oq.iam_party_leader()) then
    oq.timer_oneshot( 15, oq.force_stats ) ; -- force stats to refresh 15 seconds after coming out
  else
    oq.timer_oneshot( 10, oq.force_stats ) ; -- force stats to refresh 10 seconds after coming out
  end
  
  if (_last_report ~= nil) then
    -- bgs only
    oq.submit_report( _last_report, _last_tops, _last_bg, _last_crc, OQ_data.stats.bg_end ) ;
  end
  
  -- resetting data
  oq._instance_type = nil ;
end

function oq.show_wallet()
  print( "--[ player wallet ]--" ) ;
  if (OQ_toon.player_wallet) then
    for i,v in pairs(OQ_toon.player_wallet) do
      print( i .." :  ".. v ) ;
    end
  end
  print( "--" ) ;
end

function oq.bg_cleanup()
  -- clean up structs no longer needed after bg
  if (_flags) then
    for i,v in pairs(_flags) do
      tbl.delete( v ) ;
    end
    _flags = tbl.delete( _flags ) ;
  end

  if (_enemy) then
    for i,v in pairs(_enemy) do
      tbl.delete( v ) ;
    end
    _enemy = tbl.delete( _enemy ) ;
  end
end

function oq.flag_watcher()
  if (not _inside_bg) or (_winner ~= nil) then
    return ;
  end
  local now = utc_time() ;
  if (now < _next_flag_check) then
    return ;
  end
  _next_flag_check = now + 4 ; -- minimal
  
  local p_faction = 0 ; -- 0 == horde, 1 == alliance, -1 == offline
  if (oq.get_bg_faction() == "A") then
    p_faction = 1 ;
  end
  if (_flags == nil) then
    _flags = tbl.new() ;
  end
  if (_enemy == nil) then
    _enemy = tbl.new() ;
  end
  if (WorldStateScoreFrame:IsVisible()) then
    return ;
  end
  -- clear faction
  SetBattlefieldScoreFaction( nil ) ;
  
  local nplayers = GetNumBattlefieldScores() ;
  
  if (nplayers == 0) then
    -- not inside or the call failed
    return ;
  end
  for i=1, nplayers do
    local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class = GetBattlefieldScore(i);
    if (name) and (faction) and (faction == p_faction) then
      local nstats = GetNumBattlefieldStats() ;
      if (_flags[name] == nil) then
        _flags[name] = tbl.new() ;
      end
      for statndx = 1,nstats do
        local stat = GetBattlefieldStatData(i, statndx);
        if (_flags[name][statndx] == nil) then
          _flags[name][statndx] = 0 ;
        end
        if (_flags[name][statndx] ~= stat) then
          local stat_name = GetBattlefieldStatInfo( statndx ) ;
          local str = stat_name ..":  ".. name ;
          if (OQ.BG_STAT_COLUMN[ stat_name ] ~= nil) then
            str = OQ.BG_STAT_COLUMN[stat_name] ..":  ".. name ;
          end
          -- dump for individual OQ player to see
          --
          if (OQ_toon.shout_caps == 1) then
            print( OQ_DIAMOND_ICON .." ".. str ) ;
          end
        end
        _flags[name][statndx] = stat ;
      end
    elseif (name) and (faction) and (faction ~= p_faction) then
      if (_enemy[name] == nil) then
        _enemy[name] = tbl.new() ;
        _enemy[name].appearance = now ;
     end
      _enemy[name].last_seen = now ; -- always updating, last time seen ~= now... player left
      _enemy[name].strike    = 0 ;
    end
  end
  
  -- report rage-quitters
  local s = OQ_toon.stats["bg"] ;
  if (oq.raid.type == OQ.TYPE_RBG) then
    s = OQ_toon.stats["rbg"] ;
  end

  if (nplayers >= 10) then -- just incase the GetBattlefieldScore was wonky
    for i,e in pairs(_enemy) do
      if (e.last_seen ~= nil) then
        if (e.last_seen ~= now) and (e.reported == nil) then
          if (e.strike >= 1) then
            -- don't report until the 2nd strike.  the scorecard can be flaky
            e.reported = true ;
            e.ragequit = true ;
            if (IsRatedBattleground() == false) then
              oq.new_tears( 1 ) ; -- acct wide; should increment your tear count only for regular bgs, as only enemy faction counts
            end
            OQ_data.nrage = OQ_data.nrage + 1 ;

            if (OQ_toon.shout_ragequits == 1) then
              local diff = e.last_seen - e.appearance ;
              local min = floor((diff)/60) ;
              local sec = diff % 60 ;
              print( OQ_STAR_ICON .."".. string.format( OQ.RAGEQUITSOFAR, i, min, sec, OQ_data.nrage or 0 ) ) ;
              -- play sound
              if ((now - last_runaway) > OQ_MIN_RUNAWAY_TM) then
                last_runaway = now ;
                PlaySoundFile("Sound\\Creature\\HoodWolf\\HoodWolfTransformPlayer01.wav") ;
              end
            end
          else
            e.strike = e.strike + 1 ;
          end
        end
      end
    end
  end
end

function oq.UnitSetRole( target, role )
  if (InCombatLockdown()) then
    -- cannot change while in combat.  comeback in 3 seconds to try again
    oq.timer_oneshot( 3, oq.UnitSetRole, target, role ) ;
  else
    UnitSetRole( target, role ) ;
  end
end

function oq.entering_bg() 
  _inside_bg    = true ;
  _lucky_charms = nil ;
  _winner       = nil ;
  _nkbs         = 0 ;
  _last_lust    = nil ;
  _last_report  = nil ;
  _last_bg      = nil ;
  _last_crc     = nil ;
  _bg_zone      = nil ;
  _bg_shortname = nil ;
  OQ_data.nrage = 0 ;
  
  oq.get_zone_info() ;
  
  oq.UnitSetRole( "player", OQ.ROLES[ player_role ] ) ;

  oq.utimer_stop_all() ; -- clear all timer bars
  oq.timer( "chk_bg_updates",  2, oq.utimer_check_bg_updates , true ) ; -- check towers and graveyards
  oq.timer( "flag_watcher"  ,  5, RequestBattlefieldScoreData, true ) ; -- requesting score info
  oq.timer_oneshot( 5, oq.oqgeneral_leave ) ;
  StaticPopup_Hide("OQ_QueuePoppedMember") ;
  
  local s = oq.init_stats_data() ;
  
  OQ_data.stats.bg_start  = utc_time() ;
  OQ_data.stats.bg_end    = 0 ;
  OQ_data.stats.bg_length = 1 ;
  _winner    = nil ;

  if (not oq.iam_raid_leader()) then
    return ;
  end
  
  oq.timer( "bg_spy_report", 30, oq.battleground_spy ) ;
  
  -- send one last message before entering
  oq.send_my_premade_info() ;
end

function oq.game_ended()
  _winner = GetBattlefieldWinner() ;
  
  if (OQ_data.stats.bg_start == 0) or ((OQ_data.stats.bg_end - OQ_data.stats.bg_start) > OQ_REALISTIC_MAX_GAMELEN) then
    -- game never started.  clean up data and leave
    OQ_data.stats.bg_start  = 0 ;
    OQ_data.stats.bg_end    = 0 ;
    OQ_data.stats.bg_length = 1 ;
  end

  if (_winner ~= nil) then
    OQ_data.stats.bg_end    = utc_time() ;
    OQ_data.stats.bg_length = OQ_data.stats.bg_end - OQ_data.stats.bg_start ;
  end  

  oq.calc_game_stats() ;
  oq.announce_nquitters() ;
  oq.calc_player_stats() ;
  
  -- for test, report on all players... otherwise only premade leader
  oq.calc_game_report() ;
  
  -- update info for hover on find-premade and premade tab
  oq.update_my_hover_overs() ;
end

function oq.update_my_hover_overs()
  if ((my_group == 0) or (my_slot == 0)) then
    return ;
  end

  -- update leader info for find-premade tab  
  if (oq.iam_raid_leader()) then
    local s = OQ_data.leader["bg"] ;
    if (oq.raid.type == OQ.TYPE_RBG) then
      s = OQ_data.leader["rbg"] ;
    end
    
    local raid = oq.premades[ oq.raid.raid_token ] ;
    if (raid ~= nil) then
      raid.nWins   = s.nWins ;
      raid.nLosses = s.nLosses ;
    end
  end

  -- update personal win-loss in the main premade tab
  local me = oq.raid.group[ my_group ].member[ my_slot ] ;
  local s = OQ_toon.stats["bg"] ;
  if (oq.raid.type == OQ.TYPE_RBG) then
    s = OQ_toon.stats["rbg"] ;
  end
  me.wins   = s.nWins ;
  me.losses = s.nLosses ;
  me.tears  = oq.total_tears() ;
end

function oq.deserted() 
  if (my_group == 0) then
    return ;
  end
  
  -- register personal loss
  local s = OQ_toon.stats["bg"] ;
  if (oq.raid.type == OQ.TYPE_RBG) then
    s = OQ_toon.stats["rbg"] ;
  end
  print( OQ_LILSKULL_ICON .."  ".. OQ.RANAWAY ) ;
  
  s.nLosses = s.nLosses + 1 ;
  s.nGames  = s.nGames + 1 ;
  
  -- if leader, register leader loss 
  if (not oq.iam_raid_leader()) then
    return ;
  end
  local s = OQ_data.leader["bg"] ;
  if (oq.raid.type == OQ.TYPE_RBG) then
    s = OQ_data.leader["rbg"] ;
  end
  s.nLosses = s.nLosses + 1 ;
  s.nGames  = s.nGames + 1 ;
end

function oq.leaving_bg()
  _inside_bg    = nil ;
  _lucky_charms = nil ;

  oq.raid._last_lag = utc_time() + 60 ; -- give them some time to leave the BG 
  oq.utimer_stop_all() ; -- clear all timer bars
  
  -- post game clean up
  oq.gather_my_stats() ;
  if (oq.check_for_deserter()) then
    -- register loss
    oq.deserted() ;
    return ;
  end

  -- reset queue status
  for i=1,8 do
    for j=1,5 do
      local m = oq.raid.group[ i ].member[ j ] ;
      m.check = OQ.FLAG_CLEAR ;
      m.bg[1].status = "0" ;
      m.bg[2].status = "0" ;
    end
    oq.tab1_group[i].status[1]:SetText( "-" ) ;
    oq.tab1_group[i].dtime [1]:SetText( "" ) ; 
    oq.tab1_group[i].status[2]:SetText( "-" ) ;
    oq.tab1_group[i].dtime [2]:SetText( "" ) ; 
  end
  
  -- reset ping timers
  if (oq.iam_raid_leader()) then
    for i=2,8 do
      oq.raid.group[i]._last_ping = nil ;
    end
  end
  
  if (oq.iam_raid_leader()) then
    local now = utc_time() ;
    local raid = oq.premades[ oq.raid.raid_token ] ;
    raid.last_seen   = now ;
    raid.next_advert = now + (OQ_SEC_BETWEEN_PROMO / 2) ;
  end

  oq.utimer_bg_completed() ;
  oq.fog_clear() ;
  oq.timer_oneshot( 4.0, oq.cache_mmr_stats ) ; -- must open conquest tab to refresh mmr info
--  oq.timer_oneshot( 5.0, oq.check_currency ) ;
  oq.timer_oneshot( 5.0, oq.oqgeneral_join ) ;
  oq.timer( "flag_watcher"  ,  5, nil ) ;
  oq.timer( "chk_bg_updates",  2, nil ) ;
  _flags = nil ; -- clearing out score flags
  _enemy = nil ;
  
  -- update my slot
  if (my_group > 0) and (my_slot > 0) then
    oq.set_textures( my_group, my_slot ) ;
  end
end

function oq.game_in_process()
  oq.pass_bg_leader() ;
end

function oq.warning_no_role()
  local class, spec, spec_id = oq.get_spec() ;
  
  print( OQ_LILREDX_ICON .."  WARNING:  player_role unknown.  This may be a language support issue." ) ;
  print( OQ_LILREDX_ICON .."  WARNING:  If you believe oQueue does not support your language," ) ;
  print( OQ_LILREDX_ICON .."  WARNING:  please inform tiny on wow.publicvent.org : 4135 " ) ;
  print( OQ_LILREDX_ICON .."  locale: ".. GetLocale() ) ;
  print( OQ_LILREDX_ICON .."  class: ".. tostring(class) ) ;
  print( OQ_LILREDX_ICON .."  spec: ".. tostring(spec) ) ;
end

function oq.get_spec()
  local class = select(2, UnitClass("player")) ;
  local primaryTalentTree = GetSpecialization() ;
  local spec = nil ;
  local spec_id = 0 ;
  if (primaryTalentTree) then
    local id, name, description, icon, background, role = GetSpecializationInfo(primaryTalentTree) ;
    spec = name ;
    spec_id = id ;
  end
  return class, spec, spec_id ;
end

function oq.get_role()
   local class, spec, spec_id = oq.get_spec() ;
   if (spec == nil) then
     return "None" ;
   end
   if (OQ.CLASS_SPEC[ spec_id ]) then
     return OQ.CLASS_SPEC[ spec_id ].spy ;
   end
   return "None" ;
--   return OQ.BG_ROLES[ class ][ spec ] or "None" ;
end

function oq.get_player_role()
  local role = oq.get_role() ;
  local role_id = 1 ;
  -- 1  dps
  -- 2  healer
  -- 3  none 
  -- 4  tank
  if (role == "Healer") then
    role_id = 2 ;
  elseif (role == "Tank") then
    role_id = 4 ;
  end
  return role_id ;
end

function oq.auto_set_role()
  if (OQ_toon.auto_role == 0) or (InCombatLockdown()) then
    return ;
  end
  
  local role = oq.get_role() ;
  local role_id = 1 ;
  -- 1  dps
  -- 2  healer
  -- 3  none 
  -- 4  tank
  if (role == "Healer") then
    role_id = 2 ;
  elseif (role == "Tank") then
    role_id = 4 ;
  end
  if (role_id ~= player_role) then
    player_role = role_id ;
    -- insure UI update
    oq.set_role( my_group, my_slot, player_role ) ;
  end
  oq.UnitSetRole( "player", OQ.ROLES[ player_role ] ) ;
end

function oq.battleground_spy( opt )
  if (opt == "on") then
    OQ_data.announce_spy = 1 ;
  elseif (opt == "off") then
    OQ_data.announce_spy = 0 ;
  end
  if (OQ_data.announce_spy == 0) then
    return ;
  end
  SetBattlefieldScoreFaction( nil ) ;
  
  local numScores = GetNumBattlefieldScores()
  local numHorde = 0
  local numAlliance = 0
  local f = tbl.new() ;
  local p_faction = 0 ; -- 0 == horde, 1 == alliance, -1 == offline
  local e_faction = 1 ;
  if (oq.get_bg_faction() == "A") then
    p_faction = 1 ;
    e_faction = 0 ;
  end
  for i=0,1 do
    f[i] = tbl.new() ;
    f[i].num = 0 ;
    f[i].roles = tbl.new() ;
    f[i].stealthies = 0 ;
  end
  
  for i=1, numScores do
    local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, classToken, damageDone, 
          healingDone, bgRating, ratingChange, preMatchMMR, mmrChange, talentSpec = GetBattlefieldScore(i) ;
    if ( faction ) and (OQ.BG_ROLES[ classToken ] ~= nil) and (OQ.BG_ROLES[ classToken ][ talentSpec ] ~= nil) then
      f[ faction ].num = f[ faction ].num + 1 ;
      if (classToken == "DRUID") or (classToken == "ROGUE") then
        f[ faction ].stealthies = f[ faction ].stealthies + 1 ;
      end
      local role = OQ.BG_ROLES[ classToken ][ talentSpec ] ;
      if (role ~= nil) then
        f[ faction ].roles[ role ] = (f[ faction ].roles[ role ] or 0) + 1 ;
      end
    end
  end  
  local str = "OQ BG-Spy:" ;
  if (f[ e_faction ].roles[ "Healer" ]) then
    str = str .."  ".. f[ e_faction ].roles[ "Healer" ] .." Healers." ;
  end
  if (f[ e_faction ].roles[ "Tank" ]) then
    str = str .."  ".. f[ e_faction ].roles[ "Tank" ] .." Tanks." ;
  end
  if (f[ e_faction ].roles[ "Melee" ]) then
    str = str .."  ".. f[ e_faction ].roles[ "Melee" ] .." Melee." ;
  end
  if (f[ e_faction ].roles[ "Ranged" ]) then
    str = str .."  ".. f[ e_faction ].roles[ "Ranged" ] .." Ranged." ;
  end
  if (f[ e_faction ].roles[ "Knockback" ]) then
    str = str .."  ".. f[ e_faction ].roles[ "Knockback" ] .." Knockback." ;
  end
  if (f[ e_faction ].stealthies > 0) then
    str = str .."  ".. f[ e_faction ].stealthies .." Stealthies." ;
  end
  if (oq.iam_raid_leader() and _inside_bg) then
    SendChatMessage( str, "INSTANCE_CHAT", nil ) ;
  elseif (_inside_bg) then
    print( str ) ;
  else
    print( "OQ BG-Spy:  You are not in a battleground" ) ;
  end
  
  -- cleanup
  for i=0,1 do
    tbl.delete( f[i].roles ) ;
    tbl.delete( f[i] ) ;    
  end
  tbl.delete( f ) ;
end

function oq.calc_pkt_stats()
  if (oq.pkt_recv == nil) or (oq.pkt_processed == nil) or (oq.pkt_sent == nil) or (oq.send_q == nil) then
    return ;
  end
  oq.tab5_oq_pktrecv     :SetText( string.format( "%7.2f", oq.pkt_recv._aps ) ) ;
  oq.tab5_oq_pktprocessed:SetText( string.format( "%7.2f", oq.pkt_processed._aps ) ) ;
  oq.tab5_oq_pktsent     :SetText( string.format( "%7.2f", oq.pkt_sent._aps ) ) ;
  if (#oq.send_q > 20) then  -- more then 1 sec of pkts in the queue
    oq.tab5_oq_send_queuesz:SetText( string.format("(|cFFFF3131%d|r)", #oq.send_q ) ) ;
  elseif (#oq.send_q > 5) then
    oq.tab5_oq_send_queuesz:SetText( string.format("(|cFFFFD331%d|r)", #oq.send_q ) ) ;
  else
    oq.tab5_oq_send_queuesz:SetText( "" ) ;
  end
end

function oq.check_bg_status()
  local instance, instanceType = IsInInstance() ;
  if (instance and (instanceType == "pvp")) then
    if (not _inside_bg) then
      -- transition
      oq.entering_bg() ;
    end
  elseif (not instance and _inside_bg) then
    oq.leaving_bg() ;
  end
  if (instanceType ~= "none") and (oq._inside_instance == nil) and (instance == 1) then
    OQ_data.nrage         = 0 ;
    oq._entered_alone     = oq.iam_alone() ;
    oq._inside_instance   = 1 ;
    oq._instance_type     = instanceType ;
    oq._instance_pts      = 0 ;
    oq._instance_header   = nil ;
    oq._instance_tm       = utc_time() ;
    oq._instance_end_tm   = 0 ;
    oq._instance_duration = 0 ;
    oq._boss_fight        = nil ;
    oq._wiped             = nil ;
    if (oq._instance_type == "pvp") then
      oq.timer( "threat_update", 2.5, oq.threat_update , true ) ;
      oq.timer( "report_threat", 2.5, oq.report_threat , true ) ;
      if (OQ_data.timer_show == 1) then
        oq.utimer_frame():Show() ;
      end
      if (OQ_data.threat_show == 1) then
        oq.threat_frame():Show() ;
      end
    else
      oq.timer( "wipe_check"   , 5.0, oq.check_for_wipe, true ) ;
    end
    SetMapToCurrentZone() ; -- one-time call to set the map to the current zone
    oq.mark_currency() ;
    oq.timer_oneshot( 2.0, oq.log_realm_name ) ;
  end
  if (instance ~= 1) and (oq._inside_instance ~= nil) and (not UnitIsDeadOrGhost("player")) then
    oq._inside_instance = nil ;
    oq._entered_alone   = nil ;
    if (oq._instance_tm) and (oq._instance_tm > 0) then
      oq._instance_end_tm   = utc_time() ;
      oq._instance_duration = oq._instance_end_tm - oq._instance_tm ;
    end
    oq.timer_oneshot( 5.0, oq.check_currency ) ;
    oq.timer_oneshot( 3.0, oq.bg_cleanup ) ;
    oq.timer( "threat_update", 2.5, nil ) ;
    oq.timer( "wipe_check"   , 5.0, nil ) ;
    oq.timer( "report_threat", 2.5, nil ) ;
    oq.utimer_frame():Hide() ; -- hide while not in the bgs
    oq.threat_frame():Hide() ; -- hide while not in the bgs
  end
  oq.group_lead_bookkeeping() ;
  
  -- if ui close, make sure flag is set (for display and redisplaying map)
  if (not oq.ui:IsVisible()) then
    _ui_open = nil ;
  end
end

function oq.on_world_map_change()
  -- check map
  if (not _map_open) and (WorldMapFrame:IsVisible()) then
    _map_open = true ;
  elseif _map_open and not WorldMapFrame:IsVisible() then
    _map_open = nil ;
    -- map closing ... open the UI if it was open
    if (_ui_open) then
      oq.ui:Show() ;
    end
  end
end

function oq.report_premades()
  if (OQ_data.show_premade_ads == 0) then
    return ;
  end
  _announcePremades = true ;
  local npremades = #oq.tab2_raids ;
  if (npremades == 0) then
    return ;
  end
end

function oq.announce_new_contract( contract )
  print( "|Hcontract:".. tostring(contract.id) .. "|h"..
         OQ_LILSKULL_ICON ..
         string.format( OQ.CONTRACT_ARRIVED, contract.id, contract.name, oq.get_crowns( contract.reward, 12 ) ) 
         ) ;
end

function oq.announce_new_premade( name, name_change, raid_token )
  if (OQ_data.show_premade_ads == 0) then
    return ;
  end
  if (not _announcePremades) then
    return ;
  end

  -- don't announce if interested in qualified or certain premade types
  if (raid_token ~= nil) then
    if (oq.premade_filter_qualified == 1) and (not oq.qualified(raid_token)) then
      return ;
    end
    local p = oq.premades[ raid_token ] ;
    if (oq.premade_filter_type ~= OQ.TYPE_NONE) and (p.type ~= oq.premade_filter_type) then
      return ;
    end
    if not oq.pass_filter(p) then
      return ;
    end
  end  
  
  local premade = oq.premades[ raid_token ] ;
  if (premade == nil) then
    return ;
  end
  
  local hlink = "|Hoqueue:".. tostring(raid_token) .."|h".. OQ_DIAMOND_ICON ;
  local nShown, nPremades = oq.n_premades() ;
  if (name_change) then
    print( hlink .."  ".. string.format( OQ.PREMADE_NAMEUPD, nShown, premade.leader, name, premade.bgs ) .."|h" ) ;
  else
    print( hlink .."  ".. string.format( OQ.NEW_PREMADE, nShown, premade.leader, name, premade.bgs ) .."|h" ) ;
  end
end

function oq.announce_nquitters()
  if (OQ_toon.shout_ragequits == 1) and (_enemy ~= nil) then
    local cnt = 0 ;
    for i,e in pairs(_enemy) do
      if (e.ragequit ~= nil) then
        cnt = cnt + 1 ;
      end
    end
    if (cnt > 0) then
      local min = floor((OQ_data.stats.bg_length)/60) ;
      local sec = OQ_data.stats.bg_length % 60 ;
      print( OQ_STAR_ICON .." ".. string.format( OQ.RAGEQUITTERS, cnt, min, sec ) ) ;
    end
  end
end

function oq.calc_player_stats()
  if ((my_group == 0) or (my_slot == 0)) then
    return ;
  end

  local s = OQ_toon.stats["bg"] ;
  if (oq.raid.type == OQ.TYPE_RBG) then
    s = OQ_toon.stats["rbg"] ;
  end

  -- function to hold player stat info
  -- bg name, time of start, hks, dmg, heals, kbs
  -- other player names and their stats
  local winner = GetBattlefieldWinner() ; -- nil, 0, 1, 255
  if (winner) then
    local p_faction = oq.get_bg_faction() ;
    if (p_faction == "H") then
      p_faction = 0 ;
    elseif (p_faction == "A") then
      p_faction = 1 ;
    end
    if (winner == p_faction) then
      s.nWins = s.nWins + 1 ;
    elseif (winner ~= 255) then
      s.nLosses = s.nLosses + 1 ;
    end
    if (winner ~= 255) then
      s.nGames = s.nGames + 1 ;
    end
  end
end

function oq.get_bg_faction()
  local numScores    = GetNumBattlefieldScores() ;
  local nMembers     = 0 ;
  local hks          = 0 ;
  local honor        = 0 ;
  local deaths       = 0 ;
  for i=1, numScores do
    local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class, filename, damageDone, healingDone = GetBattlefieldScore(i);
    if (faction and (faction == 0)) then
      faction = "H" ;
    elseif (faction) then
      faction = "A" ;
    end
    if (name == player_name) then
      return faction ;
    end
  end  
  return "n" ;
end

function oq.calc_game_stats()
  if (not oq.iam_raid_leader()) then
    return ;
  end

  local s = OQ_data.leader["bg"] ;
  if (oq.raid.type == OQ.TYPE_RBG) then
    s = OQ_data.leader["rbg"] ;
  end
  local winner = GetBattlefieldWinner() ; -- nil, 0, 1, 255
  if (winner) then
    local p_faction = oq.get_bg_faction() ;
    if (p_faction == "H") then
      p_faction = 0 ;
    elseif (p_faction == "A") then
      p_faction = 1 ;
    end
    if (winner == p_faction) then
      s.nWins = s.nWins + 1 ;
    elseif (winner ~= 255) then
      s.nLosses = s.nLosses + 1 ;
    end
    if (winner ~= 255) then
      s.nGames = s.nGames + 1 ;
    end
  end

  if (IsRatedBattleground() == true) or (winner == nil) then
    -- rated BGs shouldn't impact stats
    return ;
  end

  -- clear faction
  SetBattlefieldScoreFaction( nil ) ;
end

function oq.calc_game_report()
  -- go through the in-game scorecard
  -- clear faction
  SetBattlefieldScoreFaction( nil ) ;
  local numScores    = GetNumBattlefieldScores() ;
  local bg_winner    = GetBattlefieldWinner() ;
  local scores       = {} ;
  local tops         = { ["H"] = { heals = { n = 0 }, dps = { n = 0 } },
                         ["A"] = { heals = { n = 0 }, dps = { n = 0 } },
                       } ;
  for i=1, numScores do
--    local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class, filename, damageDone, healingDone = GetBattlefieldScore(i);
    local name, killingBlows, honorableKills, deaths, honorGained, faction, race, class, 
          classToken, damageDone, healingDone, bgRating, ratingChange, preMatchMMR, 
          mmrChange, talentSpec = GetBattlefieldScore(i) ;
          
    if (faction and (faction == 0)) then
      faction = "H" ;
    elseif (faction) then
      faction = "A" ;
    end
    local n = name ;
    if (n:find("-") == nil) then
      n = n .."-".. player_realm ;
    end
    scores[n] = { fact = faction, dmg = damageDone, heal = healingDone } ;
    local realm ;
    name, realm = oq.crack_name( n ) ;
    if (tops[faction].heals.n < healingDone) then
      tops[faction].heals.n     = healingDone ;
      tops[faction].heals.name  = name ;
      tops[faction].heals.realm = realm ;
      tops[faction].heals.class = class ;
      tops[faction].heals.rank  = rank ;
    end
    if (tops[faction].dps.n < damageDone) then
      tops[faction].dps.n     = damageDone ;
      tops[faction].dps.name  = name ;
      tops[faction].dps.realm = realm ;
      tops[faction].dps.class = class ;
      tops[faction].dps.rank  = rank ;
    end
  end  
  -- get winner   
  if (bg_winner and (bg_winner == 0)) then
    bg_winner = "H" ;
  elseif (bg_winner) then
    bg_winner = "A" ;
  end
  
  oq.report_score( bg_winner, scores, tops ) ;
end

function oq.pairsByKeys(t, f)
  if (t == nil) then
    return nil ;
  end
   local a = tbl.new() ;
   for n in pairs(t) do 
     table.insert(a, n) 
   end
   table.sort(a, f)
   local i = 0      -- iterator variable
   local iter = function ()   -- iterator function
      i = i + 1
      if a[i] == nil then return nil
      else return a[i], t[a[i]]
      end
   end
   return iter
end

function oq.send_report( report, submit_token, tm )
  if (player_realid == nil) then
    oq.get_battle_tag() ;
    if (player_realid == nil) then
      return ;
    end
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "bg_report,"..
              report ..","..
              tostring(player_name) ..",".. 
              tostring(oq.realm_cooked(player_realm)) ..",".. 
              tostring(player_faction) ..",".. 
              tostring(player_realid) ..","..
              submit_token ..","..
              oq.encode_mime64_2digit(OQ_data.nrage or 0 ) ;
  oq.send_to_scorekeeper( msg ) ;
  
  oq.timer_oneshot( 4, oq.req_karma, "player" ) ;
end

function oq.req_karma_if_needed()
  local now = utc_time() ;
  if (OQ_data._karma == nil) or (OQ_data._karma_last_tm == nil) or ((now - OQ_data._karma_last_tm) > 24*60*60) then
    -- reduce the number of msgs being sent to the scorekeeper
    -- avoid requesting karma if you had a karma of 0 before (vast majority of players will have a karma of 0)
    -- force request if your karma is unknown
    -- check in at least every 3 days
    if (OQ_data._karma == nil) or (OQ_data._karma ~= 0) or ((now - OQ_data._karma_last_tm) > 3*24*60*60) then
      oq.req_karma( "player" ) ;
    end
  end
end

function oq.salt()
  return oq.encode_mime64_3digit( OQ_data.leader["bg" ].nWins   ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["bg" ].nLosses ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["bg" ].nGames  ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["rbg"].nWins   ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["rbg"].nLosses ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["rbg"].nGames  ) ..""..
         oq.encode_mime64_3digit( OQ_data.leader["pve.5man"].nBosses ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["pve.5man"].nWipes ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["pve.raid"].nBosses ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["pve.raid"].nWipes ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["pve.challenge"].nBosses ) .."".. 
         oq.encode_mime64_3digit( OQ_data.leader["pve.challenge"].nWipes ) ..""..
         oq.encode_mime64_3digit( OQ_data.leader_dkp or 0 ) ..""..
         oq.encode_mime64_3digit( OQ_data._dkp or 0 ) ..""..  -- dragon kill points
         oq.encode_mime64_4digit( OQ_data._dtp or 0 ) ;       -- dragon timed points (length of time to kill); tbd
end

function oq.req_karma( btag )
  if (player_realid == nil) then
    oq.get_battle_tag() ;
    if (player_realid == nil) then
      return ;
    end
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  local salt = "x" ;
  if (btag ~= nil) and (btag == "player") then
    btag = player_realid ;
    salt = oq.salt() ;
  end
  if (btag == nil) then
    -- invalid btag
    return ;
  end
  local submit_token = "S".. oq.token_gen() ;
  oq.token_push( submit_token ) ;
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "k2,"..
              tostring(player_name) ..",".. 
              tostring(oq.realm_cooked(player_realm)) ..",".. 
              tostring(player_faction) ..",".. 
              tostring(player_realid) ..","..
              tostring(btag) ..","..
              tostring(0) ..","..
              submit_token ..","..
              salt ; 
  oq.send_to_scorekeeper( msg ) ;
end

function oq.send_karma( btag, pts )
  if (player_realid == nil) then
    oq.get_battle_tag() ;
    if (player_realid == nil) then
      return ;
    end
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  
  local submit_token = "S".. oq.token_gen() ;
  oq.token_push( submit_token ) ;
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "k2,"..
              tostring(player_name) ..",".. 
              tostring(oq.realm_cooked(player_realm)) ..",".. 
              tostring(player_faction) ..",".. 
              tostring(player_realid) ..","..
              tostring(btag) ..","..
              tostring(pts) ..","..
              submit_token ;
  oq.send_to_scorekeeper( msg ) ;
end

function oq.max_karma( btag, now )
  if (OQ_data.karma[btag] == nil) or ((now - OQ_data.karma[btag]) > 24*60*60) then
    return false ;
  end
  return true ;
end

function oq.karma_vote( g_id, slot, pts ) 
  g_id = tonumber( g_id ) ;
  slot = tonumber( slot ) ;
  local m = oq.raid.group[ g_id ].member[ slot ] ;
  if (m == nil) then
    return ;
  end
  oq.karma_vote_btag( m.realid, pts ) ;
end

function oq.karma_vote_btag( btag, pts ) 
  if (btag == nil) or (btag == "") then
    print( OQ_LILREDX_ICON .."  ".. OQ.BAD_KARMA_BTAG ) ;
    return ;
  end
  local now = utc_time() ;
  if (OQ_data.karma == nil) then
    OQ_data.karma = {} ;
  end
  if (oq.max_karma( btag, now )) then
    print( OQ_LILREDX_ICON .."  ".. string.format( OQ.MAX_KARMA_TODAY, btag ) ) ;
    return ;
  end
  oq.send_karma( btag, pts ) ;
  OQ_data.karma[btag] = now ;
end

-- clear out stale btags we gave karma to more then 24 hrs ago
--
function oq.clean_karma_log()
  if (OQ_data.karma == nil) then
    OQ_data.karma = {} ;
    return ;
  end
  local now = utc_time() ;
  for i,v in pairs(OQ_data.karma) do
    if (i ~= nil) and ((now - v) > OQ_ONEDAY) then
      OQ_data.karma[i] = nil ;
    end
  end
end

function oq.on_karma( token, btag, karma, vlist )
  _ok2relay  = nil ;
--  if (not oq.is_my_req_token( token )) then  -- not my token, bogus msg
--    return ;
--  end
  karma = tonumber(karma) ;
  btag  = strlower(btag) ;
  -- update player's karma
  if (btag == strlower(player_realid)) then
    -- my karma
    local dk = karma - player_karma ;
    if (dk > 0) then
      print( OQ_LILTRIANGLE_ICON .."  ".. string.format( OQ.YOUVE_GOT_KARMA , abs(dk) ) ) ;
    elseif (dk < 0) then
      if (abs(dk) == 1) then
        print( OQ_LILREDX_ICON .."  ".. string.format( OQ.YOUVE_LOST_KARMA , abs(dk) ) ) ;
      else
        print( OQ_LILREDX_ICON .."  ".. string.format( OQ.YOUVE_LOST_KARMAS, abs(dk) ) ) ;
      end
    end
    player_karma   = karma ;
    OQ_data._karma = karma ;
    oq.set_karma_shield( karma ) ;
    last_stats = nil ;
    OQ_data._karma_last_tm = utc_time() ;
  end
  oq.process_vlist(vlist) ;
  -- update premade info
  for raid_tok,p in pairs(oq.premades) do
    if (p.leader_rid) and (btag ==  strlower(p.leader_rid)) then
      p.karma = karma ;
    end
  end
  -- update waitlist if oq leader
  if (oq.iam_raid_leader()) then
    for wait_tok,p in pairs(oq.waitlist) do
      if (p.realid) and (btag == strlower(p.realid)) then
        p.karma = karma ;
      end
    end
  end
  -- update group
  if (my_group ~= 0) and (my_slot ~= 0) then
    local ngroups = oq.nMaxGroups() ;
    for i=1,ngroups do
      for j=1,5 do
        local m = oq.raid.group[i].member[j] ;
        if (m.realid) and (btag == strlower(m.realid)) then
          m.karma = karma ;
        end
      end
    end
  end
end

function oq.bump_scorekeeper()
  if (OQ_data.build ~= nil) and (OQ_data.build >= OQ_BUILD) then
    return ;
  end
  if (player_realid == nil) then
    oq.get_battle_tag() ;
    if (player_realid == nil) then
      oq.timer_oneshot( 10, oq.bump_scorekeeper ) ; -- try again in 10 seconds
      return ;
    end
  end
  OQ_data.build = OQ_BUILD ;
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "ver_bump,"..
              tostring(OQ_BUILD) ..",".. 
              tostring(player_name) ..",".. 
              tostring(oq.realm_cooked(player_realm)) ..",".. 
              tostring(player_faction) ..",".. 
              tostring(player_realid) ..",".. 
              oq.salt() ;

  oq.send_to_scorekeeper( msg ) ;
end

function oq.send_top_dps( tops, submit_token, bg, crc )
  if (tops == nil) then
    return ;
  end
  if (player_realid == nil) then
    oq.get_battle_tag() ;
    if (player_realid == nil) then
      return ;
    end
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "bg_top_dps" ;
  msg = msg ..","..
        tostring(player_name) ..",".. 
        tostring(oq.realm_cooked(player_realm)) ..",".. 
        tostring(player_realid) ;

  local f = tops["H"] ;
  local divisor = 1000 ;
  if (player_level < 30) then
    divisor = 1 ;
  end
  msg = msg ..",".. 
        (f.dps.name or "none") .."|"..
        oq.encode_mime64_2digit( OQ.SHORT_BGROUPS[ f.dps.realm or "Aegwynn" ] ) ..""..
        oq.encode_mime64_3digit( floor(f.dps.n / divisor) ) ..""..
        OQ.SHORT_CLASS[ strupper(f.dps.class or "none") ] ;

  f = tops["A"] ;
  msg = msg ..",".. 
        (f.dps.name or "none") .."|"..
        oq.encode_mime64_2digit( OQ.SHORT_BGROUPS[ f.dps.realm or "Aegwynn" ] ) ..""..
        oq.encode_mime64_3digit( floor(f.dps.n / divisor) ) ..""..
        OQ.SHORT_CLASS[ strupper(f.dps.class or "none") ] ;

  msg = msg ..","..
        player_faction ..""..
        oq.encode_mime64_1digit( bg ) .."".. 
        oq.encode_mime64_1digit( oq.get_player_level_id() ) ..""..
        oq.encode_mime64_6digit( tonumber(crc) ) ..",".. 
        submit_token ;

  oq.send_to_scorekeeper( msg ) ;
end

function oq.send_top_heals( tops, submit_token, bg, crc )
  if (tops == nil) then
    return ;
  end
  if (player_realid == nil) then
    oq.get_battle_tag() ;
    if (player_realid == nil) then
      return ;
    end
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "bg_top_heals" ;
  msg = msg ..","..
        tostring(player_name) ..",".. 
        tostring(oq.realm_cooked(player_realm)) ..",".. 
        tostring(player_realid) ;

  local f = tops["H"] ;
  local divisor = 1000 ;
  if (player_level < 30) then
    divisor = 1 ;
  end
  msg = msg ..",".. 
        (f.heals.name or "none") .."|"..
        oq.encode_mime64_2digit( OQ.SHORT_BGROUPS[ f.heals.realm or "Aegwynn"] ) ..""..
        oq.encode_mime64_3digit( floor(f.heals.n / divisor) ) ..""..
        OQ.SHORT_CLASS[ strupper(f.heals.class or "none") ] ;

  f = tops["A"] ;
  msg = msg ..",".. 
        (f.heals.name or "none") .."|"..
        oq.encode_mime64_2digit( OQ.SHORT_BGROUPS[ f.heals.realm or "Aegwynn"] ) ..""..
        oq.encode_mime64_3digit( floor(f.heals.n / divisor) ) ..""..
        OQ.SHORT_CLASS[ strupper(f.heals.class or "none") ] ;

  msg = msg ..","..
        player_faction ..""..
        oq.encode_mime64_1digit( bg ) .."".. 
        oq.encode_mime64_1digit( oq.get_player_level_id() ) ..""..
        oq.encode_mime64_6digit( tonumber(crc) ) ..",".. 
        submit_token ;

  oq.send_to_scorekeeper( msg ) ;
end

function oq.cleanup_bnfriends()
  for i,v in pairs(OQ_data.bn_friends) do
    if (v.realm == nil) or (v.realm == "") then
      OQ_data.bn_friends[i] = nil ;
    end
  end
end

function oq.clear_sk_ignore()
  local sk = strlower(OQ.SK_NAME) ;
  if (player_realm ~= OQ.SK_REALM) then
    sk = sk .."-".. strlower(OQ.SK_REALM) ;
  end
  local n = GetNumIgnores() ;
  for i=1,n do
    local ignored = strlower( GetIgnoreName(i) ) ;
    if (sk == ignored) then
      DelIgnore( sk ) ;
      return ;
    end
  end
end

function oq.send_to_scorekeeper( msg )
  oq.clear_sk_ignore() ;
  local pid, online = oq.is_bnfriend(OQ.SK_BTAG) ;
  if (pid ~= nil) then
    if (online) then
      oq.BNSendWhisper( pid, msg, OQ.SK_NAME, OQ.SK_REALM ) ;
      return ;
    else
      -- no way to leave a note... should resend when no reply recv'd
      return ;
    end
  end

  if (player_realm == OQ.SK_REALM) and (player_faction == "H") then
    oq.SendAddonMessage( "OQSK", msg, "WHISPER", OQ.SK_NAME ) ;
    return ;
  end
  oq.BNSendFriendInvite( OQ.SK_BTAG, msg ) ;
end

function oq.submit_report( str, tops, bg, crc, bg_end_tm )
  if (str == nil) then
    return ;
  end
  
  local submit_token = "S".. oq.token_gen() ;
  oq.token_push( submit_token ) ;

  if (OQ_toon.reports == nil) then
    OQ_toon.reports = {} ;
  end
  OQ_toon.reports[submit_token] = { tok = submit_token, last_tm = utc_time(), report = str } ;
  OQ_toon.reports[submit_token].tops = copyTable( tops ) ;
  OQ_toon.reports[submit_token].bg = bg ;
  OQ_toon.reports[submit_token].crc = crc ;
  OQ_toon.reports[submit_token].end_tm = bg_end_tm ;
end

function oq.submit_btag_info()
  local now = utc_time() ;
  if (OQ_data.btag_submittal_tm ~= nil) and (OQ_data.btag_submittal_tm > now) then
    return ;
  end
  local f = oq.submit_btag ;
  if (OQ_data.ok2submit_tag ~= nil) and (OQ_data.ok2submit_tag == 0) then
    f = oq.submit_still_kickin ; -- not submitting for mesh, just saying user still here
  end
  if (f() ~= nil) then
    OQ_data.btag_submittal_tm = now + OQ_BTAG_SUBMIT_INTERVAL ;
  end
end

function oq.timed_submit_report()
  oq.submit_btag_info() ;
  
  if (OQ_toon.reports == nil) then
    return ;
  end
  local now = utc_time() ;
  for i,v in pairs(OQ_toon.reports) do
    if (v.end_tm == nil) or (v.end_tm < oq.scores.start_round_tm) then
      -- this score is old and hasn't been reported for some reason.  
      -- remove it
      OQ_toon.reports[i] = nil ;
    elseif ((now - v.last_tm) >= 10) and (not v.submit_failed) then
      v.last_tm = now ;
      if (not v.report_recvd) then
        oq.send_report( v.report, v.tok, v.last_tm ) ;   
        -- no longer collecting; not used for anything useful, might as well cut down on msgs
        v.top_heals_recvd = true ;
        v.top_dps_recvd = true ;
      end
      if (v.attempt == nil) then
        v.attempt = 1 ;
      else
        v.attempt = v.attempt + 1 ;
      end
      if (v.attempt > OQ_MAX_SUBMIT_ATTEMPTS) then
        v.submit_failed = true ;
      end
      return ; -- can only send out one report at a time, otherwise subsequent msgs will overwrite 
    end
  end
end

function oq.enemy_is_same_faction()
  if (IsRatedBattleground() ~= true) then
    return nil ;
  end
  -- is rated bg.  must look at races in scorecard to determine if same faction
  SetBattlefieldScoreFaction( nil ) ;
  
  local nplayers = GetNumBattlefieldScores() ;
  if (nplayers == 0) then
    -- not inside or the call failed
    return nil ;
  end
  local game_faction = nil ; -- the faction i played during the game
  local me = strlower(player_name) ;
  for i=1, nplayers do
    local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class = GetBattlefieldScore(i);
    name = strlower(name) ;
    if (name) and (faction) and (name:find(me) ~= nil) then
      game_faction = faction ;
      break ;
    end
  end
  if (game_faction == nil) then
    -- unable to determine races
    return nil ;
  end
  
  -- now look for opposing faction and check race to determine whether or not factions actually match
  --
  for i=1, nplayers do
    local name, killingBlows, honorableKills, deaths, honorGained, faction, rank, race, class = GetBattlefieldScore(i);
    if (faction) and (race) and (faction ~= game_faction) then
      -- opposing team member, check race
      if (OQ.FACTION[race]) and (OQ.FACTION[race] ~= "X") then
        return (OQ.FACTION[race] == player_faction) ;
      end
    end
  end
  -- unable to determine 
  return nil ;
end

function oq.report_score( winner, scores, tops )
  if (not oq.iam_raid_leader() or oq.enemy_is_same_faction() or oq.iam_alone()) then
    return ;
  end
  if (OQ_data.stats.bg_start == 0) or (OQ_data.stats.bg_end == 0) then
    -- game time not properly recorded, do not report
    return ;
  end

  local str = "" ;
  if (scores == nil) then
    return ;
  end
  for i,v in oq.pairsByKeys( scores, nil ) do
    str = str .."|".. i ..",".. v.fact ..",".. v.dmg ..",".. v.heal ;
  end
  str = str .."|" ;
  _last_crc = oq.CRC32(str) ;

  oq.get_zone_info() ;
  
  local bg        = oq.encode_mime64_1digit( OQ.BG_SHORT_NAME[ _bg_shortname ] ) ;
  local crc       = oq.encode_mime64_6digit( _last_crc ) ;
  local end_tm    = oq.encode_mime64_6digit( OQ_data.stats.bg_end ) ;
  local start_tm  = oq.encode_mime64_6digit( OQ_data.stats.bg_start ) ;
  local is_rated  = "0" ;
  if (IsRatedBattleground()) then
    is_rated = "1" ;
  end
  _last_report = bg .."".. winner .."".. crc .."".. end_tm .."".. start_tm .."".. oq.encode_mime64_1digit(oq.nMembers()) .."".. is_rated ;
  _last_bg     = OQ.BG_NAMES[ _bg_zone ].type_id ;
  _last_tops   = copyTable( tops ) ;
end

function oq.report_rage()
  if (_inside_bg) then
    print( string.format( OQ.RAGEQUITS, OQ_data.nrage ) ) ;
  else
    local min = floor((OQ_data.stats.bg_length)/60) ;
    local sec = OQ_data.stats.bg_length % 60 ;
    oq.log( true, string.format( OQ.RAGELASTGAME, OQ_data.nrage, min, sec ) ) ;
  end
end

local ad = 0 ;
function oq.get_ab_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- Resources: 400/1600
  local points = txt:match( "Resources: (%d+)" ) ;
  return points ;
end

function oq.get_av_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- Reinforcements: 400
  local points = txt:match( "Reinforcements: (%d+)" ) ;
  return points ;
end

function oq.get_bfg_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- Resources: 400/2000
  local points = txt:match( "Resources: (%d+)" ) ;
  return points ;
end

function oq.get_eots_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- Bases: 3  Victory Points:  1600/2000
  local bases, points  = txt:match( "Bases: (%d+)  Victory Points: (%d+)" ) ;
  return points ;
end

function oq.get_ioc_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- Reinforcements: 400
  local points = txt:match( "Reinforcements: (%d+)" ) ;
  return points or "" ;
end

function oq.get_sota_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- time
  -- End of Round: 02:01
  local tm = txt:match( "End of Round: (%d+:%d+)" ) ;  
  if (tm == nil) or (tm == "") then
    return "" ;
  else
    return "round (".. tm ..")" ;
  end
end

function oq.get_ssm_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- Resources: 400/1600
  local points = txt:match( "Resources: (%d+)" ) ;
  return points ;
end

function oq.get_tok_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- Victory Points: 400/1600
  local points = txt:match( "Victory Points: (%d+)" ) ;
  return points ;
end

function oq.get_tp_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- Bases: 3  Victory Points:  1600/1600
  local points = txt:match( "%d+" ) ;
  return points or "" ;
end

function oq.get_wsg_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- 0/3
  local points = txt:match( "%d+" ) ;
  return points or "" ;
end

function oq.get_dwg_text( txt )
  if (txt == nil) then
    return "" ;
  end
  -- Bases: 3  Gold:  200/1600
  local bases, points  = txt:match( "Bases: (%d+)  Gold: (%d+)" ) ;
  return points or "" ;
end

function oq.get_ad_text()
  ad = ad + 1 ;
  local zone = OQ.BG_SHORT_NAME[ GetZoneText() ] ;
  local bg = zone ;
  if (bg == nil) then
    bg = "BG" ;
  end
  local aText = "" ;
  local hText = "" ;
  local line1 = "" ;
  if (AlwaysUpFrame1Text ~= nil) then
    line1 = AlwaysUpFrame1Text:GetText()
  end
  local line2 = "" ;
  if (AlwaysUpFrame2Text ~= nil) then
    line2 = AlwaysUpFrame2Text:GetText()
  end
  local tm = "" ;
  if (zone == "AB") then
    aText = oq.get_ab_text( line1 ) ;
    hText = oq.get_ab_text( line2 ) ;
  elseif (zone == "AV") then
    aText = oq.get_av_text( line1 ) ;
    hText = oq.get_av_text( line2 ) ;
  elseif (zone == "BFG") then
    aText = oq.get_bfg_text( line1 ) ;
    hText = oq.get_bfg_text( line2 ) ;
  elseif (zone == "EotS") then
    aText = oq.get_eots_text( line1 ) ;
    hText = oq.get_eots_text( line2 ) ;
  elseif (zone == "IoC") then
    aText = oq.get_ioc_text( line1 ) ;
    hText = oq.get_ioc_text( line2 ) ;
  elseif (zone == "SotA") then
    local line3 = "" ;
    if (AlwaysUpFrame3Text ~= nil) then
      line3 = AlwaysUpFrame3Text:GetText() ;
    end
    aText = oq.get_sota_text( line3 ) ;
  elseif (zone == "SSM") then
    aText = oq.get_ssm_text( line1 ) ;
    hText = oq.get_ssm_text( line2 ) ;
  elseif (zone == "ToK") then
    aText = oq.get_tok_text( line1 ) ;
    hText = oq.get_tok_text( line2 ) ;
  elseif (zone == "TP") then
    tm    = line1:match( "Remaining: (%d+)" ) ;  
    local line3 = AlwaysUpFrame3Text:GetText() ;
    aText = oq.get_tp_text( line2 ) ;
    hText = oq.get_tp_text( line3 ) ;
  elseif (zone == "WSG") then
    tm    = line1:match( "Remaining: (%d+)" ) ;  
    local line3 = AlwaysUpFrame3Text:GetText() ;
    aText = oq.get_wsg_text( line2 ) ;
    hText = oq.get_wsg_text( line3 ) ;
  elseif (zone == "DWG") then
    aText = oq.get_dwg_text( line1 ) ;
    hText = oq.get_dwg_text( line2 ) ;
  else
    return "" ;
  end

  local p_faction = oq.get_bg_faction() ;
  if (zone == "SotA") then
    bg = bg ..": ".. aText ;
  elseif (zone == "TP") or (zone == "WSG") then
    if (p_faction == "A") then
      bg = bg ..": ".. aText .." - ".. hText ;
    else
      bg = bg ..": ".. hText .." - ".. aText ;
    end      
    bg = bg .." (".. tm .." min)" ;
  else
    if (p_faction == "A") then
      bg = bg ..": ".. (aText or "") .." - ".. (hText or "") ;
    else
      bg = bg ..": ".. (hText or "") .." - ".. (aText or "") ;
    end      
  end
  
  return bg ;
end

function oq.init_stats_element( s )
  s.nWins       = 0 ;
  s.nLosses     = 0 ;
  s.nGames      = 0 ;
  s.start_tm    = 0 ; -- time() when this raid was created
  s.bg_start    = 0 ; -- place holder - time() of bg start
  s.bg_end      = 0 ; -- place holder - time() of bg end
  s.bg_length   = 0 ; 
  s.tm          = 0 ; -- time of last update from source.  able to know which data is the latest
end

function oq.init_stats_data()
  if (OQ_data.stats == nil) then
    OQ_data.stats = { bg_length = 0, bg_end = 0, bg_start = 0 } ;
  end
  if (OQ_data.leader == nil) then
    OQ_data.leader = { ["bg"]  = {},
                       ["rbg"] = {},
                     } ;
    oq.init_stats_element( OQ_data.leader["bg" ] ) ;
    oq.init_stats_element( OQ_data.leader["rbg"] ) ;
    -- copy over old data
    OQ_data.leader["bg"].nWins   = OQ_data.stats.nWins or 0 ;
    OQ_data.leader["bg"].nLosses = OQ_data.stats.nLosses or 0 ;
    OQ_data.leader["bg"].nGames  = OQ_data.stats.nGames or 0 ;
  end
  if (OQ_toon.stats == nil) then
    OQ_toon.stats = { ["bg" ] = { nWins = 0, nLosses = 0, nGames = 0 },
                      ["rbg"] = { nWins = 0, nLosses = 0, nGames = 0 },
                    } ;
    OQ_toon.stats["bg"].nWins   = OQ_toon.wins or 0 ;
    OQ_toon.stats["bg"].nLosses = OQ_toon.losses or 0 ;
    OQ_toon.stats["bg"].nGames  = (OQ_toon.stats["bg"].nWins + OQ_toon.stats["bg"].nLosses) ;
  end  
  if (OQ_data.tear_cup == nil) then
    OQ_data.tear_cup = {} ;
  end
  if (OQ_toon.stats["bg"].nTears) and (OQ_toon.stats["bg"].nTears > 0) and (oq.total_tears() == 0) then
    oq.new_tears( OQ_toon.stats["bg"].nTears ) ;
    OQ_toon.stats["bg"].nTears = nil ;
  end
  if (OQ_data.tear_count) and (OQ_data.tear_count > 0) and (oq.total_tears() == 0) then
    oq.new_tears( min( 3000, OQ_data.tear_count )) ; -- a bug existed where tears dupped; trimming to 3k
    OQ_data.tear_count = nil ;
  end
  OQ_data.stats.tears = nil ; -- old value no longer used
  
  local s = OQ_data.leader["bg"] ;
  if (oq.raid.type == OQ.TYPE_RBG) then
    s = OQ_data.leader["rbg"] ;
  end
  return s ;
end

function oq.send_my_premade_info()
  if ((not oq.iam_raid_leader()) or OQ_toon.disabled) then
    return ;
  end

  -- announce new raid on main channel
  local nMembers, avg_resil, avg_ilevel = oq.calc_raid_stats() ;
  local nWaiting = oq.n_waiting() ;
  local now      = utc_time() ;
  
  oq.raid.pdata     = oq.get_pdata() ;
  oq.raid.leader_xp = oq.get_leader_experience() ;

  local s = oq.init_stats_data() ;
  
  s.status = 0 ;
  if (_inside_bg) then
    s.status = 2 ;
  elseif (player_queued) then
    s.status = 1 ;
  end

  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end

  local raid = oq.premades[ oq.raid.raid_token ] ;
  local enc_data = oq.encode_data( "abc123", player_name, player_realm, player_realid ) ;
  if (raid ~= nil) then
    local tmp = nil ;
    raid.stats, tmp = copyTable( OQ_data.stats ) ; -- make sure to copy stats
    tbl.delete( tmp ) ;
  end
  oq.process_premade_info( oq.raid.raid_token, oq.encode_name( oq.raid.name ), oq.raid.faction, 
                           oq.raid.level_range, oq.raid.min_ilevel, oq.raid.min_resil, oq.raid.min_mmr, enc_data, oq.encode_bg( oq.raid.bgs ),
                           nMembers, 1, now, s.status, nWaiting, oq.raid.has_pword, oq.raid.is_realm_specific, 
                           oq.raid.type, oq.raid.pdata, oq.raid.leader_xp, player_karma ) ;

  if (raid == nil) then
    -- would have just been created, ok2send
    local tmp = nil ;
    
    raid = oq.premades[ oq.raid.raid_token ] ;
    raid.stats, tmp = copyTable( OQ_data.stats ) ; -- make sure to copy stats
    tbl.delete( tmp ) ;
  elseif (raid.next_advert > now) then
    return ;
  end
  
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  raid.leader         = player_name ;
  raid.leader_realm   = player_realm ;
  raid.leader_rid     = player_realid ;
  raid.last_seen      = now ;
  raid.next_advert    = now + OQ_SEC_BETWEEN_PROMO ;
  
  local ad_text = nil ;
  if (_inside_bg) then
    ad_text = oq.get_ad_text() ;
  else
    ad_text = oq.raid.bgs ;
  end
  
  local stat = s.status or 0 ;
  if _inside_bg then
    stat = 2 ;
  end

  local is_realm_specific = nil ;
  local is_source = 1 ;

  -- on_premade
  local is_restricted = _oqgeneral_lockdown ;
  _oqgeneral_lockdown = nil ; -- this allows the group leader to advertise on their own realm
  oq.announce( "p8,".. 
               oq.raid.raid_token ..",".. 
               oq.encode_name( oq.raid.name ) ..",".. 
               oq.encode_premade_info( oq.raid.raid_token, stat, now, oq.raid.has_pword, is_realm_specific, is_source, player_karma ) ..","..
               enc_data ..","..
               oq.encode_bg( ad_text ) ..","..
               oq.raid.type ..","..
               oq.raid.pdata ..","..
               oq.get_leader_experience()
             ) ;
  _oqgeneral_lockdown = is_restricted ; -- this allows the group leader to advertise on their own realm
end

function oq.advertise_my_raid()
  if ((not oq.iam_raid_leader()) or (oq.raid.raid_token == nil)) then
    return ;
  end
  oq._ad_ticker = (oq._ad_ticker or 0) + 1 ;
  if ((oq._ad_ticker % 2) == 0) then
    if (not _inside_bg) then
      -- this will produce premade ads every 30 seconds when not in a bg and every 15 seconds when inside
      return ;
    end
  end
  
  if (not _inside_bg) then
    -- send the raid token to everyone in the party
    oq.party_announce( "party_update,".. oq.raid.raid_token ) ;
  end
  -- even if inside a bg, the leader will continue to send premade info
  oq.send_my_premade_info() ;
end

function oq.on_charm( raid_token, g_id, slot, icon ) 
  if (raid_token == nil) or (raid_token ~= oq.raid.raid_token) then
    return ;
  end
  g_id = tonumber( g_id ) ;
  slot = tonumber( slot ) ;
  icon = tonumber( icon or 0 ) or 0 ;
  oq.set_charm( g_id, slot, icon ) ;
end

function oq.leader_set_charm( g_id, slot, icon ) 
  if (not oq.iam_raid_leader()) then
    return ;
  end
  g_id = tonumber( g_id ) ;
  slot = tonumber( slot ) ;
  icon = tonumber( icon or 0 ) or 0 ;
  oq.raid_announce( "charm,".. oq.raid.raid_token ..",".. tostring(g_id) ..",".. tostring(slot) ..",".. tostring(icon) ) ;
  oq.set_charm( g_id, slot, icon ) ;
end

function oq.group_charm_clear( g_id )
  g_id = tonumber( g_id ) ;
  for i=1,5 do
    oq.raid.group[g_id].member[i].charm = 0 ;    
    oq.raid.group[g_id].member[i].check = OQ.FLAG_CLEAR ;
  end
end

function oq.set_charm( g_id, slot, icon ) 
  if (icon > 0) then
    local i, j ;
    for i=1,8 do
      if (oq.raid.group[i]) then
        for j=1,5 do
          if (oq.raid.group[i].member) then
            local m = oq.raid.group[i].member[j] ;
            if (m) and (m.name) and (m.name ~= "-") and (m.name ~= "") and (m.charm == icon) then
              m.charm = 0 ;
              oq.set_textures( i, j ) ;
            end
          end
        end
      end
    end
  end
  oq.raid.group[ g_id ].member[ slot ].charm = icon ;
  oq.set_textures( g_id, slot ) ;
  
  -- set the charm if currently in the bg
  if (g_id == my_group) and (slot == my_slot) then
    SetRaidTarget( "player", icon ) ;
  end
  if (oq._inside_instance and oq.IsRaidLeader()) then
    local m = oq.raid.group[ g_id ].member[ slot ] ;
    if (m.name == player_name) then
      SetRaidTarget( "player", icon ) ;
    else
      local n = m.name ;
      if (m.realm) and (m.realm ~= player_realm) then
        n = n .."-".. m.realm ;
      end
      if (n) then
        SetRaidTarget( n, icon ) ;
      end
    end
  end
end

function oq.numeric_sanity( n )
  if (n == nil) or (n == "") or (tostring(n) == "-1.#IND") then
    return 0 ;
  end
  return tonumber( n or 0 ) or 0 ;
end

function oq.nActiveGroups()
  if (oq.raid.type ~= OQ.TYPE_BG) then
    return 1 ;
  end
  local n = 0 ;
  for i=1,8 do
    if (oq.raid.group[i].member[1].realid ~= nil) then
      n = n + 1 ;
    end
  end
  return n ;
end

-- bnet conversation only used for regular bgs
-- only started when the number of groups exceeds 3
function oq.add_to_conversation( pid )
  if (not oq.iam_raid_leader()) or (oq.raid.type ~= OQ.TYPE_BG) then
    return ;
  end
  if (oq.nActiveGroups() < 3) and (oq._hConversation == nil) then
    -- no conversation yet
    return ;
  end
--[[
issue #1: multiple accounts under one bnet
issue #2: must have 3 ppl minimum to start
issue #3: what if 3rd person leaves?
issue #4: if 2nd person leaves, conversation closes?  have to continually recreate

print( "max in a channel:  ".. BNGetMaxPlayersInConversation() ) ;
print( "max # conversations: ".. BNGetMaxNumConversations () ) ;

if (thistle_pid ~= 0) then
   print( "attempting to create conversation" ) ;
   --   BNCreateConversation( thistle_pid, 0 ) ;
end

for i=1, BNGetMaxNumConversations() do
   if ( BNGetConversationInfo(i) == "conversation" ) then
      print( "# in channel: ".. tostring(BNGetNumConversationMembers( i ))) ;
      BNSendConversationMessage( i, "test msg" );
      --      BNInviteToConversation( i, snot_pid );
      --      BNInviteToConversation( i, snot2_pid );
   end
end
]]--
end

function oq.show_raid()
  print( "raid_name: ".. tostring(oq.raid.name) .."  token(".. tostring(oq.raid.raid_token) ..")" ) ;
  print( "leader: ".. tostring(oq.raid.leader) .."-".. tostring(oq.raid.leader_realm) .."  btag(".. tostring(oq.raid.leader_rid) ..")" ) ;
  for i=1,8 do
    local str = " ".. tostring(i) ..". " ;
    if (oq.raid.group[i]) then
      local g = oq.raid.group[i] ;
      if (g.member) then
        for j=1,5 do
          local m = g.member[j] ;
          if (m) then
            if (m.name) then
              str = str .."(".. tostring(j) ..": ".. tostring(m.class) ..".".. tostring(m.name) .."-".. tostring(m.realm_id) .."^".. tostring(m.realid) ..") " ;
            else
              str = str .."(".. tostring(j) ..": .) " ;
            end
          else
            str = str .."(".. tostring(j) ..": nil) " ;
          end
        end
      else
        str = str .."  nil+" ;
      end
    else
      str = str .."  nil" ;
    end
    print( str ) ;
  end
  print( "--" ) ;
end

function oq.raid_create()
  if (oq.raid.raid_token ~= nil) then
    print( OQ.STILL_IN_PREMADE ) ;
    return ;
  end
  -- check information to make sure it's all filled in

  -- generate token
  oq.raid.raid_token = "G".. oq.token_gen() ;
  if (not oq.valid_rid( player_realid )) then
    message( OQ.BAD_REALID .." ".. tostring(player_realid) ) ;
    return ;
  end
  
  if (player_level < 10) then
    message( OQ.MSG_CANNOTCREATE_TOOLOW ) ;
    return ;
  end

  OQ_data.realid = player_realid ;

  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  -- set raid info
  my_group                 = 1 ;
  my_slot                  = 1 ;
  oq.raid.name             = oq.rtrim( oq.tab3_raid_name:GetText() ) ;
  oq.raid.leader           = player_name ;
  oq.raid.leader_class     = player_class ;
  oq.raid.leader_realm     = player_realm ;
  oq.raid.leader_rid       = player_realid ;
  oq.raid.level_range      = oq.tab3_level_range ;
  oq.raid.faction          = player_faction ; 
  oq.raid.min_ilevel       = oq.numeric_sanity( oq.tab3_min_ilevel:GetText() ) ;
  oq.raid.min_resil        = oq.numeric_sanity( oq.tab3_min_resil:GetText() ) ;
  oq.raid.min_mmr          = oq.numeric_sanity( oq.tab3_min_mmr:GetText() ) ;
  oq.raid.notes            = (oq.tab3_notes.str or "") ;
  oq.raid.bgs              = string.gsub( oq.tab3_bgs:GetText() or ".", ",", ";" ) ;
  oq.raid.pword            = oq.tab3_pword:GetText() or "" ;
  oq.raid.leader_xp        = oq.get_leader_experience() ;
  
  local m = { level     = player_level, 
              faction   = player_faction, 
              resil     = oq.get_resil(), 
              ilevel    = oq.get_ilevel(), 
              spec_type = player_role, 
--              arena2s   = oq.get_arena_rating(1),
--              arena3s   = oq.get_arena_rating(2),
--              arena5s   = oq.get_arena_rating(3),
--              mmr       = oq.get_mmr()
              mmr       = oq.get_best_mmr( oq.raid.type ) 
            } ;
  if (oq.is_qualified( m ) == nil) then
    oq.raid_cleanup() ;
    StaticPopup_Show("OQ_DoNotQualifyPremade") ;
    tbl.delete( m ) ;
    return ;
  end
  m = tbl.delete( m ) ; -- cleanup

  if (oq.raid == nil) or (oq.raid.type == nil) then
    oq.set_premade_type( OQ.TYPE_BG ) ;
  else
    oq.set_premade_type( oq.raid.type ) ;
  end

  if (oq.raid.pword == nil) or (oq.raid.pword == "") then
    oq.raid.has_pword = nil ;
  else
    oq.raid.has_pword = true ;
  end
  
  local s = oq.init_stats_data() ;
  OQ_data.stats.start_tm   = utc_time() ;
  OQ_data.stats.bg_start   = 0 ; -- place holder - time() of bg start
  OQ_data.stats.bg_end     = 0 ; -- place holder - time() of bg end

  oq.raid.notes      = oq.raid.notes or "" ;
  oq.raid.bgs        = oq.raid.bgs or "" ;

  oq.log( nil, "|cFF808080created group:|r ".. tostring(oq.raid.name) .."" ) ;
  
  -- enable premade leader only controls
  oq.ui_raidleader() ;

  oq.set_group_lead( 1, player_name, player_realm, player_class, player_realid ) ;
--  oq.set_charm( my_group, my_slot, OQ.ICON_SKULL ) ; -- initial charm puts 'skull' on leader
  oq.raid.group[1].member[1].resil  = player_resil ;
  oq.raid.group[1].member[1].ilevel = player_ilevel ;
  oq.raid.group[1].member[1].level  = player_level ;

  -- update tab_1
  oq.tab1_name :SetText( oq.raid.name ) ;
  oq.tab1_notes:SetText( oq.raid.notes ) ;

  oq.update_tab1_stats() ;
  oq.get_group_hp() ;
  oq.check_for_deserter() ;
  
  -- remove myself from other waitlists
  oq.clear_pending() ;

  -- assign slots to the party members
  local enc_data = oq.encode_data( "abc123", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ;
  oq.party_assign_slots( my_group, enc_data ) ;
  
  -- activate in-raid only procs
  oq.procs_join_raid() ;

  -- tell the world 
  oq._ad_ticker = 0 ;
  oq.advertise_my_raid() ;
  return 1 ;
end

-- if same realm, will whisper
-- if real-id friend, will bnwhisper
-- if not same realm and not friend, will bnfriendinvite with msg in note
--
function oq.realid_msg( to_name, to_realm, real_id, msg ) 
  if (msg == nil) then
    return ;
  end
  local rc = 0 ;
  if ((to_name == nil) or (to_name == "-") or (to_realm == nil)) then
    return ;
  end
  if ((to_name == player_name) and (to_realm == player_realm)) then
    -- sending to myself?
    return ;
  end
  if (not oq.well_formed_msg( msg )) then
      local msg_tok = "W".. oq.token_gen() ;
      oq.token_push( msg_tok ) ;
      msg = "OQ,".. 
            OQ_VER ..",".. 
            msg_tok ..","..
            OQ_TTL ..",".. 
            msg ;
  end
        
  if (to_realm == player_realm) then
    oq.SendAddonMessage( "OQ", msg, "WHISPER", to_name ) ;
    return ;
  end

  local pid, online = oq.is_bnfriend(real_id) ;
  if (pid ~= nil) then
    if (pid > 0) then
      oq.BNSendWhisper( pid, msg, to_name, to_realm ) ;
      return ;
    else
      -- no way to leave a note... should resend when no reply recv'd
      return ;
    end
  end

  oq.BNSendFriendInvite( real_id, msg ) ;
end

function oq.bnbackflow( msg, to_pid )
  if (_sender_pid ~= to_pid) then
    return nil ;
  end
  -- ie: "OQ,0A,P477389297,G17613410,name,1,3,Tinymasher,Magtheridon"
  local tok = msg:sub(7,16) ;
  if (_msg_token ~= tok) then
    return nil ;
  end
  return true ;
end

function oq.iknow_scorekeeper()
  for i,v in pairs(OQ_data.bn_friends) do
    if ((v.presenceID ~= 0) and v.isOnline and v.sk_enabled) then
      return v.presenceID ;
    end
  end
  return nil ;
end

function oq.bn_ok2send( msg, pid )
  if (oq.bnbackflow( msg, pid )) then
    return nil ;
  end
  for i,v in pairs(OQ_data.bn_friends) do
    if ((v.presenceID == pid) and v.isOnline and v.oq_enabled) then
      return true ;
    end
  end
  return nil ;
end

function oq.well_formed_msg( m )
  if (m == nil) then
    return nil ;
  end
  local str = OQ_MSGHEADER .."".. OQ_VER .."," ;
  if (m:sub(1,#str) == str) then
    return true ;
  end
  str = OQSK_HEADER ..",".. OQSK_VER .."," ;
  if (m:sub(1,#str) == str) then
    return true ;
  end
  return nil ;
end

function oq.BNSendQ_push( func_, pid_, msg_, name_, realm_ )
  if (pid_ == 0) or (msg_ == nil) or (OQ_toon.disabled) then
    return ;
  end
  if (oq.send_q == nil) then
    oq.send_q = tbl.new() ;
  end
  -- pkt recycling
  if (oq.__msgpktq == nil) then
    oq.__msgpktq = tbl.new() ;
  end
  local t = next( oq.__msgpktq ) ;
  if (t) then
    oq.__msgpktq[t] = nil ;
  else
    oq._nMsgPackets = (oq._nMsgPackets or 0) + 1 ;
    t = tbl.new() ;
    t.__id = oq._nMsgPackets ;
  end
  t.func  = func_ ;
  t.pid   = pid_ ;
  t.msg   = msg_ ;
  t.name  = name_ ;
  t.realm = realm_ ;
  t.ts    = utc_time() ;
  table.insert( oq.send_q, t ) ;  
end

function oq.BNSendQ_pop() 
  if (oq.send_q == nil) or (#oq.send_q == 0) then
    return ;
  end
  local now = utc_time() ;
  local t = nil ;
  repeat
    t = table.remove( oq.send_q, 1 ) ;
  until (t == nil) or ((now - t.ts) < 2.0) ;
  if (t == nil) then
    return ;
  end
  -- have an entry... process
  t.func( t.pid, t.msg, t.name, t.realm ) ;
  
  -- recycle pkt holder
  if (oq.__msgpktq  == nil) then
    oq.__msgpktq = tbl.new() ;
  end
  oq.__msgpktq[t] = true ;
end

function oq.BNSendWhisper( pid, msg, name, realm )
  oq.BNSendQ_push( oq.BNSendWhisper_now, pid, msg, name, realm ) ;
end

function oq.BNSendWhisper_now( pid, msg, name, realm )
  if (pid == 0) or (msg == nil) or (OQ_toon.disabled) then
    return ;
  end
  if (name == nil) or (realm == nil) or (msg:find( ",".. OQ_FLD_TO ) ~= nil) then
    if (#msg > 254) then
      msg = msg:sub(1,254) ;
    end
    BNSendWhisper( pid, msg ) ;
    oq.pkt_sent:inc() ;
    return ;
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  local x_msg = msg ..",".. 
                OQ_FLD_TO .."".. name ..",".. 
                OQ_FLD_REALM .."".. tostring(oq.realm_cooked( realm )) ..",".. 
                OQ_FLD_FROM .."".. player_name .."-".. tostring(oq.realm_cooked( player_realm ))  ;
  if (#x_msg > 254) then
    x_msg = x_msg:sub(1,254) ;
  end
  BNSendWhisper( pid, x_msg ) ;  
  oq.pkt_sent:inc() ;
end

function oq.get_field( m, fld )
  if (m == nil) or (fld == nil) then
    return nil ;
  end
  -- not found, leave
  local p1 = m:find( fld ) ;
  if (p1 == nil) then
    return nil ;
  end
  
  -- find end, either the next ',' or eos
  local p2 = m:find( ",", p1 ) ;
  if (p2 == nil) then
    p2 = -1 ;
  else
    p2 = p2 - 1 ;
  end
  return m:sub( p1 + #fld, p2 ) ;
end

-- takes name-realm and returns name,realm
-- if there is no realm, player_realm assumed
--
function oq.crack_name( n )
  if (n == nil) then
    return nil, nil ;
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  local name = n ;
  local realm = player_realm ;
  local p = n:find("-") ;
  if (p) then
    name  = n:sub( 1, p-1 ) ;
    realm = n:sub( p+1, -1 ) ;
  end
  return name, realm ;
end

function oq.is_number(s)
  if (s == nil) then
    return nil ;
  end
  if (type(s) == "number") then
    return true ;
  end
  if (tonumber(s) ~= nil) then
    return true ;
  end
  return nil ;
end

function oq.space_it( s ) 
   local x = string.find( s:sub(2,-1), OQ.PATTERN_CAPS ) ;
   if (x == nil) or (s:sub(x,x) == "'") then
      return s ;
   end
   return s:sub( 1, x ) .." ".. s:sub( x+1, -1 ) ;
end

function oq.realm_cooked(realm)
  if (realm == nil) or (realm == "-") or (realm == "nil") or (realm == "n/a") or (realm == "") then
    return 0 ;
  end
  if (oq.is_number(realm)) then
    return realm ;
  end
  if (OQ.SHORT_BGROUPS[ realm ] ~= nil) then
    return OQ.SHORT_BGROUPS[ realm ] ;
  end
  local r = realm ;
  if (OQ.REALMNAMES_SPECIAL[ realm ] ~= nil) then
    r = OQ.REALMNAMES_SPECIAL[ realm ] ;
  elseif (OQ.REALMNAMES_SPECIAL[ strlower( realm ) ] ~= nil) then
    r = OQ.REALMNAMES_SPECIAL[ strlower(realm) ] ;
  end
  
  if (OQ.SHORT_BGROUPS[ r ] == nil) then
    -- for some reason, realms like "Bleeding Hollow" will come from blizz as "BleedingHollow".. sometimes
    r = oq.space_it( r ) ; 
    if (OQ.SHORT_BGROUPS[ r ] == nil) then
      print( OQ_REDX_ICON .." unable to locate realm id.  realm[".. tostring(realm) .."]" ) ;
      print( OQ_REDX_ICON .." please report this to tiny on wow.publicvent.org : 4135" ) ;
      return 0 ;
    end
  end
 
  return OQ.SHORT_BGROUPS[ r ] ;
end

function oq.realm_uncooked(realm)
  if (oq.is_number(realm)) then
    realm = OQ.SHORT_BGROUPS[ tonumber(realm) ] ;
  elseif (realm == "nil") then
    realm = nil ;
  end
  return realm ;
end

--  local m, name_, realm_ = oq.crack_bn_msg( msg ) ;
function oq.crack_bn_msg( msg )
  local  p = msg:find( ",".. OQ_FLD_TO ) ;
  if (p == nil) then
    return msg, nil, nil, nil ;
  end
   
  local m, name, realm, from ;
  m     = msg:sub( 1, p - 1 ) ;
  name  = oq.get_field( msg, OQ_FLD_TO ) ;
  realm = oq.get_field( msg, OQ_FLD_REALM ) ;
  realm = oq.realm_uncooked(realm) ;
  from  = oq.get_field( msg, OQ_FLD_FROM ) ;
  local from_name, from_realm = oq.crack_name( from ) ;
  from_realm = oq.realm_uncooked(from_realm) ;
  return m, name, realm, from ;
end

function oq.whisper_msg( to_name, to_realm, msg, immediate ) 
  if (msg == nil) then
    return ;
  end
  local rc = 0 ;
  if ((to_name == nil) or (to_name == "-")) then
    return ;
  end
  if ((to_name == player_name) and (to_realm == player_realm)) then
    return ;
  end
  if (not oq.well_formed_msg( msg )) then
      local msg_tok = "W".. oq.token_gen() ;
      oq.token_push( msg_tok ) ;
      msg = "OQ,".. 
            OQ_VER ..",".. 
            msg_tok ..","..
            OQ_TTL ..",".. 
            msg ;
  end
  if (to_realm == player_realm) then
    if ((oq._sender == nil) or (oq._sender ~= to_name)) then
      if (immediate) then
        SendAddonMessage( "OQ", msg, "WHISPER", to_name ) ;
        oq.pkt_sent:inc() ;
      else
        oq.SendAddonMessage( "OQ", msg, "WHISPER", to_name ) ;
      end
    end
    return ;
  elseif (to_realm ~= nil) then
    -- check to see if we have BN access
    local presenceID = oq.bnpresence( to_name .."-".. to_realm ) ;
    if (presenceID == 0) then
      local msg_sent = nil ;
      -- send to real-id list for ppl not in the raid (hoping they will forward to their local OQGeneral channel)
      return ;
    else
      if (immediate) then
        oq.BNSendWhisper_now( presenceID, msg, to_name, to_realm ) ;
      else
        oq.BNSendWhisper( presenceID, msg, to_name, to_realm ) ;
      end
    end
  end
end

function oq.whisper_party_leader( msg ) 
  if ((my_group <= 0) or (oq.raid.group[my_group].member[1].name == nil) or (msg == nil)) then
    return ;
  end
  if ((oq.raid.leader == nil) or (oq.raid.leader_realm == nil)) then
    return ;
  end
  local lead = oq.raid.group[my_group].member[1] ;
  local name = lead.name ;
  if (lead.realm ~= player_realm) then
    name = name .."-".. lead.realm ;
  end
  -- make sure the msg is well formed
  if (not oq.well_formed_msg( msg )) then
      local msg_tok = "W".. oq.token_gen() ;
      oq.token_push( msg_tok ) ;
      msg = "OQ,".. 
            OQ_VER ..",".. 
            msg_tok ..","..
            OQ_TTL ..",".. 
            msg ;
  end
  oq.SendAddonMessage( "OQ", msg, "WHISPER", name ) ;
end

function oq.whisper_raid_leader( msg ) 
  if (msg == nil) then
    return ;
  end

  if ((oq.raid.leader == nil) or (oq.raid.leader_realm == nil)) then
    return ;
  end
  -- make sure the msg is well formed
  if (not oq.well_formed_msg( msg )) then
      local msg_tok = "W".. oq.token_gen() ;
      oq.token_push( msg_tok ) ;
      msg = "OQ,".. 
            OQ_VER ..",".. 
            msg_tok ..","..
            OQ_TTL ..",".. 
            msg ;
  end
  oq.whisper_msg( oq.raid.leader, oq.raid.leader_realm, msg, true ) ; 
end

function oq.send_invite_accept( raid_token, group_id, slot, name, class, realm, realid, req_token ) 
  -- the 'W' stands for 'whisper' and should not be echo'd far and wide
  local msg_tok = "W".. oq.token_gen() ;
  oq.token_push( msg_tok ) ;

  local enc_data = oq.encode_data( "abc123", player_name, player_realm, player_realid ) ;
  local m = "OQ,".. 
            OQ_VER ..",".. 
            msg_tok ..","..
            OQ_TTL ..",".. 
            "invite_accepted,".. 
            raid_token ..",".. 
            group_id ..","..
            slot ..","..
            class ..","..
            enc_data ..","..
            req_token ;

  oq.whisper_raid_leader( m ) ;
end

function oq.check_for_dead_group()
  if ((oq.raid.raid_token == nil) or _inside_bg or (not oq.iam_raid_leader())) then
    return ;
  end
  if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
    oq.assign_raid_seats() ;
    return ;
  end
  local now = utc_time() ;
  
  if (not oq.iam_raid_leader()) then
    -- group 1 cannot lag out
    if (my_group > 1) and ((now - oq.raid._last_lag) >= OQ_GROUP_TIMEOUT) then
      -- group leader lost conn or just left
      oq.quit_raid_now() ;
    end
    return ;
  end  
  
  -- remove a group if its been more end OQ_GROUP_TIMEOUT since last ping response
  for i=2,8 do
    if (oq.raid.group[i]) and (oq.raid.group[i].member) then
      local grp  = oq.raid.group[i] ;
      local lead = grp.member[1] ;
      if (lead.name) and (lead.name ~= "-") then 
        if (grp._last_ping ~= nil) and ((now - grp._last_ping) >= OQ_GROUP_TIMEOUT) then
          oq.remove_group( i ) ;
        elseif (grp._last_ping == nil) then
          grp._last_ping = now ;
        end
      end
    end
  end
  -- ping all leaders
  oq.raid_ping() ;
end

local _auras = nil ;
function oq.check_for_deserter() 
--  local v = { UnitAura("player", "Deserter", nil, "PLAYER|HARMFUL") } ;
  _auras = { UnitAura("player", "Deserter", nil, "PLAYER|HARMFUL") } ;
  if (player_deserter and (_auras[1] == nil)) then
    player_deserter = nil ;
    oq.set_status( my_group, my_slot, player_deserter, player_queued, player_online ) ;
    oq.update_status_txt() ;
  elseif (not player_deserter and (_auras[1] ~= nil)) then
    player_deserter = true ;
    oq.set_status( my_group, my_slot, player_deserter, player_queued, player_online ) ;
    oq.update_status_txt() ;
  end
  return player_deserter ;
end

function oq.check_my_role( changedPlayer, changedBy, oldRole, newRole ) 
  if (changedPlayer == player_name) then
    local role = OQ.ROLES[ newRole ] ;
    if (role ~= player_role) then  
      player_role = role ;
    end
    -- insure UI update
    oq.set_role( my_group, my_slot, role ) ;
  end
end

function oq.brief_player( slot, name )
  if (not oq.iam_party_leader() or (my_group == 0) or (my_slot ~= 1)) then
    return ;
  end
  local enc_data = oq.encode_data( "abc123", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ;
  oq.party_announce( "party_join,".. 
                      my_group ..","..
                      oq.encode_name( oq.raid.name ) ..",".. 
                      oq.raid.leader_class ..",".. 
                      enc_data ..",".. 
                      oq.raid.raid_token  ..",".. 
                      oq.encode_note( oq.raid.notes )
                   ) ;
  oq.party_announce( "party_slot,".. 
                     name ..","..
                     my_group ..","..
                     slot ..",".. 
                     (oq.raid.type or OQ.TYPE_BG)
                   ) ;
end

function oq.set_member_stats_offline( m ) 
  if (m == nil) or (m.stats == nil) then
    return ;
  end
  --  m.flags must set to 0 for offline
  m.stats = m.stats:sub(1,6) .."A".. m.stats:sub(8,-1) ;
end

function oq.find_group_member( name )
  if (not oq.iam_party_leader() or (my_group == 0) or (my_slot ~= 1) or _inside_bg) then
    return ;
  end
  for i=2,5 do
    -- check the members of my party to see if they are online
    local m = oq.raid.group[ my_group ].member[ i ] ;
    if (m.name and (m.name == name)) then
      return m ;
    end
  end  
  return nil ;
end

function oq.remove_one_mesh_node()
  local ntotal, nonline = BNGetNumFriends() ;
  local now = utc_time() ;
  local rc = nil ;
  local option = "silent" ;
  for i=ntotal,1,-1 do
    tbl.fill( _f, BNGetFriendInfo( i ) ) ;

    local presenceID = _f[1] ;
    local givenName  = _f[2] ;
    local btag       = _f[3] ;
    local noteText   = _f[13] or "" ;
    -- remove this friend from OQ_data if noted
    if (noteText == "REMOVE OQ") or (noteText == "OQ,mesh node") then
      rc = oq.remove_friend_by_pid( presenceID, btag, givenName, option, "group member" ) ;
    elseif (noteText == "OQ,leader") and (oq.raid.raid_token == nil) then
      rc = oq.remove_friend_by_pid( presenceID, btag, givenName, option, "group leader" ) ;
    elseif ((noteText == "") and oq.in_btag_cache( btag )) then
      rc = oq.remove_friend_by_pid( presenceID, btag, givenName, option, "mesh auto-add" ) ;
    end
    if (rc ~= nil) then
      break ;
    end
  end  
  if (rc ~= nil) then
    print( OQ_DIAMOND_ICON .." ".. string.format( L["NOTICE:  You've exceeded the cap before the cap(%s).  removed: %s"], OQ.BNET_CAPB4THECAP, tostring(_f[3]) )) ;
  end
  return rc ;
end

function oq.bntoons()
  local now = utc_time() ;
  if (next_bn_check > now) then
    return ;
  end
  next_bn_check = now + 5 ; -- refresh presence ids every 5 seconds (was 30, but the numbers were getting re-issued more frequently then that)
  if (OQ_data.bn_friends == nil) then
    OQ_data.bn_friends = {} ;
  end
  if (oq._bnet_friends == nil) then
    oq._bnet_friends = tbl.new() ;
  end
  local ntotal, nonline = BNGetNumFriends() ;
  if (ntotal > OQ.BNET_CAPB4THECAP) then
    -- remove one
    if (oq.remove_one_mesh_node()) then
      next_bn_check = now + 2 ; -- force recheck next time thru
      return ;
    else
      if (oq._warning_001 == nil) or ((now - oq._warning_001) > 120) then
        print( OQ_LILSKULL_ICON .." ".. string.format( L["WARNING:  Your battle.net friends list has %s friends."], tostring(ntotal) )) ;
        print( OQ_LILSKULL_ICON .." ".. string.format( L["WARNING:  You've exceeded the cap before the cap(%s)"], OQ.BNET_CAPB4THECAP )) ;
        print( OQ_LILSKULL_ICON .." ".. string.format( L["WARNING:  No mesh nodes available for removal.  Please trim your b.net friends list"] )) ;
      end
      oq._warning_001 = now ;
    end
  end
  
  for i,v in pairs(OQ_data.bn_friends) do
    v.presenceID = 0 ;
    v.isOnline   = nil ;
    v.oq_enabled = nil ;
  end
  local p_faction = 0 ; -- 0 == horde, 1 == alliance, -1 == offline
  if (player_faction == "A") then
    p_faction = 1 ;
  end

  for friendId=ntotal,1,-1 do
    tbl.fill( _f, BNGetFriendInfo( friendId ) ) ;
    if (_f[3]) then
      _f[3] = strlower(_f[3]) ;
    end
    
    local presenceID = _f[1] ;
    local givenName  = _f[2] ;
--    local surName    = _f[3] ;
    local client     = _f[7] ;
    local online     = _f[8] ;
    local broadcast  = _f[12] ;
    if ((_f[4] == true) and (_f[3]) and (oq._bnet_friends[_f[3]] == nil)) then
      -- new bnet friend
      if (oq._bnet_friends_initialized) and (ntotal >= OQ.BNET_CAPB4THECAP) then
        -- new bnet friend... already max'd at 98.  this is the cap before the cap
        -- wow will issue an assert at some point over 98 bnet friends
--        print( OQ_LILSKULL_ICON .." WARNING: You've exceeded the cap before the cap(".. OQ.BNET_CAPB4THECAP ..")." ) ;
      end
      oq._bnet_friends[_f[3]] = true ;
    end
    
    if ((_f[4] == true) and (_f[3]) and oq.is_banned( _f[3], true )) then -- will only remove if on your LOCAL oq ban list
      print( OQ_LILSKULL_ICON .." ".. string.format( L["Found oQ banned b.tag on your friends list.  removing: %s"], tostring(_f[3]) )) ;
      BNRemoveFriend( presenceID ) ; 
    else
      local nToons = BNGetNumFriendToons( friendId ) ;
      if (nToons > 0) and online and (client == "WoW") then
        for toonIndx=1,nToons do
          tbl.fill( _toon, BNGetFriendToonInfo( friendId, toonIndx ) ) ;
          local toonName   = _toon[2] ;
          local realmName  = _toon[4] ;
          local faction    = 1 ;
          if (_toon[6] == "Horde") then
            faction = 0 ;
          end

          if (faction == p_faction) then
            local name = toonName .."-".. realmName ;
            local friend = OQ_data.bn_friends[ name ] ;
            if (friend == nil) then
              OQ_data.bn_friends[ name ] = tbl.new() ;
              friend = OQ_data.bn_friends[ name ] ;
            end
            friend.isOnline   = true ;
            friend.toonName   = toonName ;
            friend.realm      = realmName ;
            friend.presenceID = presenceID ;
            friend.oq_enabled = nil ;
            if (broadcast ~= nil) and (broadcast:sub(1, #OQ_BNHEADER ) == OQ_BNHEADER) then
              friend.oq_enabled = true ;
            end
            if (broadcast ~= nil) and (broadcast:sub(1, #OQ_SKHEADER ) == OQ_SKHEADER) then
              friend.sk_enabled = true ;
            end          
          end
        end
      end  
    end
  end  
  
  -- clear out those that didn't update
  for i,v in pairs(OQ_data.bn_friends) do
    if (v.presenceID == 0) then
      OQ_data.bn_friends[i] = tbl.delete( v ) ;
    end
  end

  -- update ui elements  
  oq._bnet_friends_initialized = true ;
  oq.n_connections() ;
end

function oq.is_toon_friended( name, realm )
  local ntotal, nonline = BNGetNumFriends() ;
  for friendId=1,ntotal do
    tbl.fill( _f, BNGetFriendInfo( friendId ) ) ;
    local client     = _f[7] ;
    local online     = _f[8] ;
    local nToons = BNGetNumFriendToons( friendId ) ;
    if (nToons > 0) and online and (client == "WoW") then
      for toonIndx=1,nToons do
        tbl.fill( _toon, BNGetFriendToonInfo( friendId, toonIndx ) ) ;
        local toonName   = _toon[2] ;
        local realmName  = _toon[4] ;
        if (name == toonName) and (realm == realmName) then
          return 1 ;
        end
      end
    end
  end
  return nil ;
end

function oq.is_bnfriend(btag_) 
  if (btag_ == nil) then
    return nil, nil ;
  end
  btag_ = strlower( btag_ ) ; -- just to make sure
  local ntotal, nonline = BNGetNumFriends() ;
  for friendId=1,ntotal do
    tbl.fill( _f, BNGetFriendInfo( friendId ) ) ;
    
    local presenceID = _f[1] ;
    local btag       = _f[3] ;
    local client     = _f[7] ;
    local online     = _f[8] ;
    if (btag) and (btag_ == strlower(btag)) then
      if (client == "WoW") and online then
        return presenceID, true ;
      else
        return 0, nil ;
      end
    end
  end
  return nil, nil ;
end

function oq.get_nConnections()
  local cnt = 0 ;
  
  oq.bntoons() ;
  for name,v in pairs(OQ_data.bn_friends) do
    if (v.isOnline and (v.presenceID ~= 0) and v.oq_enabled) then
      cnt = cnt + 1 ;
    end
  end
  
  -- update the label on tab 5
  local nlocals = oq.n_channel_members( "OQgeneral" ) ;
  if (nlocals > 0) then
    nlocals = nlocals - 1 ; -- subtract player
  end
  local ntotal, nonline = BNGetNumFriends() ;
  return nlocals, cnt, ntotal ;
end

function oq.n_connections()
  local nOQlocals, nOQfriends, nBNfriends = oq.get_nConnections() ;
  if (oq.loaded) then
    oq.tab2_nfriends:SetText( string.format( OQ.BNET_FRIENDS, nBNfriends ) ) ; 
    oq.tab2_connection:SetText( string.format( OQ.CONNECTIONS, nOQlocals, nOQfriends )) ;
  end
end

function oq.bnpresence( name )
  oq.bntoons() ;
  name = strlower(name) ; -- make sure
  for i,v in pairs(OQ_data.bn_friends) do
    if (name == strlower(i)) then
      if (not v.isOnline) or ((not v.oq_enabled) and (not v.sk_enabled)) then
        return 0 ;
      else
        return v.presenceID or 0 ;
      end
    end
  end
  return 0 ;
  
--  local friend = OQ_data.bn_friends[ name ] ;
--  if (friend == nil) or ((not friend.oq_enabled) and (not friend.sk_enabled)) or (not friend.isOnline) then
--    return 0 ;
--  end
--  return friend.presenceID or 0 ;
end

function oq.mbsync_toons( to_name )
  for ndx,friend in pairs( OQ_data.bn_friends ) do
    if ((friend.presenceID ~= 0) and friend.isOnline and friend.oq_enabled) then
      local m = "OQ,".. 
                OQ_VER ..",".. 
                "W1,"..
                OQ_TTL ..","..
                "mbox_bn_enable,".. 
                friend.toonName ..","..
                tostring(oq.realm_cooked( friend.realm )) ..","..
                tostring(1) ;
      oq.whisper_msg( to_name, player_realm, m ) ;
    end
  end
end

function oq.mbsync_single( toonName, toonRealm ) 
  for i,v in pairs(OQ_toon.my_toons) do
    local m = "OQ,".. 
              OQ_VER ..",".. 
              "W1,"..
              OQ_TTL ..","..
              "mbox_bn_enable,".. 
              toonName ..","..
              tostring(oq.realm_cooked( toonRealm )) ..","..
              tostring(1) ;
    oq.whisper_msg( v.name, player_realm, m ) ;
  end
end

function oq.mbsync()
  for i,v in pairs(OQ_toon.my_toons) do
    oq.mbsync_toons( v.name ) ;
  end
end

function oq.on_mbox_bn_enable( name, realm, is_enabled )
  oq.bntoons() ;
  if (is_enabled == "0") then
    is_enabled = nil ;
  else
    is_enabled = true ;
  end
  realm = oq.realm_uncooked(realm) ;
  local friend = OQ_data.bn_friends[ name .."-".. realm ] ;
  if (friend == nil) then
    OQ_data.bn_friends[ name .."-".. realm ] = {} ;
    friend = OQ_data.bn_friends[ name .."-".. realm ] ;
    friend.isOnline      = nil ;
    friend.toonName      = name ;
    friend.realm         = realm ;
    friend.presenceID    = 0 ;
    return ;
  end
  friend.oq_enabled    = is_enabled ;
end

-- notify multi-box toons on same b-net that the toon is bn-enabled
--
function oq.mbnotify_bn_enable( name, realm, is_enabled ) 
  if (OQ_toon.my_toons == nil) or (#OQ_toon.my_toons == 0) then
    return ;
  end

  local m = "OQ,".. 
            OQ_VER ..",".. 
            "W1,"..
            OQ_TTL ..","..
            "mbox_bn_enable,".. 
            name ..","..
            tostring(oq.realm_cooked( realm )) ..","..
            (is_enabled or 1) ;

  for i,v in pairs(OQ_toon.my_toons) do
    oq.whisper_msg( v.name, player_realm, m ) ;
  end
end

-- returns first pid of a toon on the desired realm
function oq.bnpresence_realm( realm ) 
  if (realm == nil) then
    return nil ;
  end
  for i,v in pairs(OQ_data.bn_friends) do
    if (v.realm == realm) and (v.oq_enabled) and (v.isOnline) then
      return v.pid ;
    end
  end
  return 0 ;
end

function oq.bn_echo_msg( name, realm, msg )
  local pid = oq.bnpresence( name .."-".. realm ) ;
  if (pid == 0) then
    return ;
  end
  if (oq.bn_ok2send( msg, pid )) then
    oq.BNSendWhisper( pid, msg, name, realm ) ;
  end
end

function oq.bn_echo_raid( msg )
  if (oq.raid.raid_token == nil) then
    return ;
  end
  for i=1,8 do
    for j=1,5 do
      if (oq.raid.group[i].member) then
        local m = oq.raid.group[i].member[j] ;
        if (m) and (m.name) and (m.realm) and (m.realm ~= player_realm) then
          oq.bn_echo_msg( m.name, m.realm, msg ) ;
        end
      end
    end
  end
end

function oq.check_pending_invites()
  if ((oq.pending_invites == nil) or _inside_bg) then
    return ;
  end
  
  for name,v in pairs(oq.pending_invites) do
    local friend = OQ_data.bn_friends[ name ] ;
    if (friend ~= nil) then
      if (not friend.oq_enabled) then
        oq.mbnotify_bn_enable( friend.toonName, friend.realm, 1 ) ; 
      end
      friend.oq_enabled = true ; -- they got on the invite-list, must be enabled
      InviteUnit( name ) ;
      oq.timer_oneshot( 2.0, oq.brief_group_members ) ;  
      oq.pending_invites[ name ] = nil ;
    end
  end
end

function oq.bn_check_online()
  next_bn_check = 0 ; -- force check
  oq.bntoons() ; 
  oq.n_connections() ; -- should update the connection info on the find-premade tab
end

function oq.set_bn_enabled( pid ) 
  -- find author in OQ_data.bn_friends and set him oq_enabled
  -- lot of work per msg.  how to reduce?  (another table??)
  -- 
  oq.bntoons() ;
  if (OQ_data.bn_friends == nil) then
    return ;
  end
  
  for name,friend in pairs(OQ_data.bn_friends) do
    if (friend.presenceID == pid) then
      if (not friend.oq_enabled) then 
        oq.mbnotify_bn_enable( friend.toonName, friend.realm, 1 ) ;      
      end
      friend.oq_enabled = true ;
    end
  end
end

function oq.bn_clear()
  tbl.clear( OQ_data.bn_friends ) ;
  next_bn_check = 0 ;
  oq.bntoons() ; -- have lost all OQ enabled friends
end

function oq.bn_force_verify()
  next_bn_check = 0 ; -- force the check
  oq.bntoons() ;  
end

function oq.remove_friend_by_pid( pid, btag, givenName, option, why )
  if (option == "show") or (option == "list") then
    print( OQ_DIAMOND_ICON .."  ".. tostring(btag or givenName) .."  (".. tostring(why) ..")" ) ;
    return nil ;
  end
  if (option ~= "silent") then
    print( OQ_DIAMOND_ICON .."  removing ".. btag or givenName .."  (".. tostring(why) ..")" ) ;
  end
  if (OQ_data.bn_friends ~= nil) then
    for n,friend in pairs(OQ_data.bn_friends) do
      if (friend.presenceID == pid) then
        tbl.clear( OQ_data.bn_friends[ n ] ) ;
      end
    end
  end
  BNSetFriendNote( pid, "" ) ;
  BNRemoveFriend( pid ) ;
  return 1 ;
end

local _btags = nil ;
local _btag_ids = nil ;

function oq.show_btags() 
  if (_btags == nil) then
    _btags = tbl.new() ;
  end
  if (_btag_ids == nil) then
    _btag_ids = tbl.new() ;
  end
  local ntotal, nonline = BNGetNumFriends() ;
  tbl.clear( _btags ) ;
  tbl.clear( _btag_ids ) ;
  for i=1,ntotal do
    tbl.fill( _f, BNGetFriendInfo( i ) ) ;

    if (_f[3] ~= nil) then
      _btags[_f[3]] = tbl.new() ;
      _btags[_f[3]].name = _f[2] ;
      _btags[_f[3]].note = _f[13] or "" ;
      table.insert( _btag_ids, _f[3] ) ;
    end
  end  
  table.sort( _btag_ids ) ;  -- names have embedded codes making it impossible to sort by name
  for i,v in pairs(_btag_ids) do
    print( tostring(v) .."  |cFFFFFF00".. tostring(_btags[v].name) .."|r  ".. tostring(_btags[v].note) ) ;
  end
  
  -- cleanup
  for i,v in pairs(_btags) do
    tbl.delete( v ) ;
  end
  _btags = tbl.delete( _btags ) ;
  _btag_ids = tbl.delete( _btag_ids ) ;
end

function oq.remove_OQadded_bn_friends( option )
  local ntotal, nonline = BNGetNumFriends() ;
  local now = utc_time() ;
  local removal_text = "REMOVE ".. OQ_HEADER ;
  for i=ntotal,1,-1 do
    tbl.fill( _f, BNGetFriendInfo( i ) ) ;

    local presenceID = _f[1] ;
    local givenName  = _f[2] ;
    local btag       = _f[3] ;
    local noteText   = _f[13] or "" ;
    -- remove this friend from OQ_data if noted
    if (noteText == "REMOVE OQ") or (noteText == "OQ,mesh node") then
      oq.remove_friend_by_pid( presenceID, btag, givenName, option, "group member" ) ;
    elseif (noteText == "OQ,leader") and (oq.raid.raid_token == nil) then
      oq.remove_friend_by_pid( presenceID, btag, givenName, option, "group leader" ) ;
    elseif ((noteText == "") and oq.in_btag_cache( btag )) then
      oq.remove_friend_by_pid( presenceID, btag, givenName, option, "mesh auto-add" ) ;
    end
  end  
  if (option ~= "show") and (option ~= "list") then
    oq.clear_btag_cache() ; -- clear the btag cache so it can start fresh
  end
  oq.bn_check_online() ;
end

function oq.is_enabled(toonName, realm)
  local n = toonName .."-".. realm ;
  if (OQ_data.bn_friends[ n ] == nil) then
    return nil ;
  end
  return OQ_data.bn_friends[ n ].oq_enabled ;
end

function oq.bn_show_pending()
  if (oq.pending_invites == nil) then
    print( "pending list is empty" ) ;
    oq.pending_invites = tbl.new() ;
  else
    print( "pending ---" ) ;
    for i,v in pairs(oq.pending_invites) do
      print( i .." raid( ".. i ..".".. v.gid ..".".. v.slot ..") ".. v.rid ) ;
    end
    print( "--- total: ".. #oq.pending_invites ) ;
  end

  if (oq.waitlist == nil) then
    print( "wait list is empty" ) ;
    oq.waitlist = tbl.new() ;
  else  
    print( "waiting ---" ) ;
    for i,v in pairs(oq.waitlist) do
      print( "[".. i .."] [".. v.name .."-".. v.realm .."] [".. v.realid .."]" ) ;
    end
    print( "--- total: ".. #oq.waitlist ) ;
  end
end

function oq.announce( msg, to_name, to_realm )
  if ((msg == nil) or OQ_toon.disabled) then
    return ;
  end
  if (to_name ~= nil) then
    if (to_realm == player_realm) then
      local msg_tok = "W".. oq.token_gen() ;
      oq.token_push( msg_tok ) ;
      m = "OQ,".. OQ_VER ..",".. msg_tok ..",".. OQ_TTL ..",".. msg ;
      oq.SendAddonMessage( "OQ", m, "WHISPER", to_name ) ;
      return ;
    end
    -- try to go direct if pid exists
    local pid = oq.bnpresence( to_name .."-".. to_realm ) ;
    if (pid ~= 0) then
      local msg_tok = "W".. oq.token_gen() ;
      oq.token_push( msg_tok ) ;
      m = "OQ,".. OQ_VER ..",".. msg_tok ..",".. OQ_TTL ..",".. msg ;
      oq.BNSendWhisper( pid, m, to_name, to_realm ) ;
      return ;
    end
    -- if i have a bn-friend on the target realm, bnsend it to them and return
    pid = oq.bnpresence_realm( to_realm ) ;
    if (pid ~= 0) then
      local msg_tok = "A".. oq.token_gen() ;
      oq.token_push( msg_tok ) ;
      m = "OQ,".. OQ_VER ..",".. msg_tok ..",".. OQ_TTL ..",".. msg ;
      oq.BNSendWhisper( pid, m, to_name, to_realm ) ;
      return ;
    end

    msg = msg ..",".. OQ_FLD_TO .."".. to_name ..",".. OQ_FLD_REALM .."".. tostring(oq.realm_cooked( to_realm )) ;
  end
  local msg_tok = "A".. oq.token_gen() ;
  oq.token_push( msg_tok ) ;

  local m = "OQ,".. OQ_VER ..",".. msg_tok ..",".. OQ_TTL ..",".. msg ;

  -- send to raid (which sends to local channel and real-id ppl in the raid)
  oq.announce_relay( m ) ;
end

--
-- message relays
--
function oq.announce_relay( m )
  if (OQ_toon.disabled) then
    return ;
  end
  -- send to general channel
  if (_inc_channel ~= "oqgeneral") and (oq._banned == nil) then
    oq.channel_general( m ) ;
  end

  -- send to raid channels
  if (oq.raid.raid_token ~= nil) then
    oq.raid_announce_relay( m ) ;
  end

  -- send to real-id list for ppl not in the raid (hoping they will forward to their local OQGeneral channel)
  if (_dest_realm == nil) or (_dest_realm ~= player_realm) then
    oq.bnfriends_relay( m ) ;
  end
end

local _tags   = {} ;
local _realms = {} ;
function oq.bnfriends_relay( m )
  oq.bntoons() ; -- just incase the information has changed 
  if (OQ_data.bn_friends == nil) then
    return ;
  end
  local dt = 0.1 ;
  tbl.clear( _tags ) ;
  tbl.clear( _realms ) ;
  local cnt = 1 ;
  for i,v in pairs(OQ_data.bn_friends) do
    if (v.isOnline and v.oq_enabled and v.toonName and v.realm and (v.realm ~= player_realm) and (_realms[v.realm] == nil)) then
      _tags[cnt] = v ;
      cnt = cnt + 1 ;
      _realms[v.realm] = true ;
    end
  end
  if (cnt <= OQ_MAX_RELAY_REALMS) then
    for i,v in pairs(_tags) do
      oq.BNSendWhisper( v.presenceID, m, v.toonName, v.realm ) ;
    end
  else
    tbl.clear( _names ) ;
    for i=1,OQ_MAX_RELAY_REALMS do
      local ndx = random(1,cnt) ;
      local v = _tags[ndx] ;
      if (v ~= nil) and (v.toonName ~= nil) and (_names[v.toonName] == nil) then 
        _names[v.toonName] = true ;
        oq.BNSendWhisper( v.presenceID, m, v.toonName, v.realm ) ;
      end
    end
  end
end

--
--  send to local OQRaid channel then to real-id friends in the raid
--
function oq.raid_announce( msg, msg_tok )
  if (oq.raid.raid_token == nil) then
    -- no raid token means not in a raid
    return ;
  end

  if (msg_tok == nil) then
    -- the 'R' stands for 'raid' and should not be echo'd far and wide
    msg_tok = "R".. oq.token_gen() ;
    oq.token_push( msg_tok ) ;
  end

  local m = "OQ,".. OQ_VER ..",".. msg_tok ..",".. oq.raid.raid_token ..",".. msg ;
  oq.raid_announce_relay( m ) ;
--  oq.bn_echo_raid( m ) ;
end

function oq.raid_announce_relay( m )
  -- if we get here then the message must have come from OUTSIDE the raid/party
  -- 
  if (_inside_bg) then
    oq.SendAddonMessage( "OQ", m, "INSTANCE_CHAT" ) ;
  elseif (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
    oq.SendAddonMessage( "OQ", m, "RAID" ) ;
    return ;
  end  
  if (oq.iam_raid_leader() == true) then
    -- send to party leaders
    if (oq.raid.group) then
      for i=1,8 do
        if (oq.raid.group[i]) and (oq.raid.group[i].member) then
          local lead = oq.raid.group[i].member[1] ;
          if ((lead) and (lead.name) and (lead.name ~= "-") and (lead.name ~= player_name) and (lead.realm)) then
            oq.whisper_msg( lead.name, lead.realm, m ) ;
          end
        end
      end
    end
  elseif (oq.iam_party_leader() == true) then
    -- send to raid_leader
    oq.whisper_raid_leader( m ) ;
  else
  end
  -- send to my own party
  oq.channel_party( m ) ;
end

function oq.raid_announce_member( group_id, slot, name, realm, class ) 
  if ((name == nil) or (name == "-")) then
    return ;
  end
  oq.raid_announce( "member,".. group_id ..",".. slot ..",".. tostring(class) ..",".. tostring(name) ..",".. tostring(oq.realm_cooked( realm )) ) ;
end

function oq.party_announce( msg )
  if (oq.raid.raid_token == nil) or (not oq.iam_in_a_party()) then
    return ;
  end
  -- the 'P' stands for 'party' and should not be echo'd far and wide
  msg_tok = "P".. oq.token_gen() ;
  oq.token_push( msg_tok ) ;

  local m = "OQ,".. OQ_VER ..",".. msg_tok ..",".. oq.raid.raid_token ..",".. msg ;
  
  -- send to party channel
  oq.channel_party( m ) ;
end

function oq.bg_announce( msg )
  local m = "OQ,".. 
            OQ_VER ..",".. 
            "W1,"..
            OQ_TTL ..",".. 
            msg ;
  -- this should send to both parties and instance groups and fail silently if either isn't valid
  SendAddonMessage( "OQ", m, "PARTY" ) ;
  oq.pkt_sent:inc() ;
  SendAddonMessage( "OQ", m, "INSTANCE_CHAT" ) ;
  oq.pkt_sent:inc() ;
end

function oq.send_to_group_leads( m ) 
  if (oq.iam_raid_leader()) then  
    for i=2,8 do
      local grp = oq.raid.group[i] ;
      if ((grp.member) and (grp.member[1].name) and (grp.member[1].name ~= "-") and (grp.member[1].realm)) then
        oq.whisper_msg( grp.member[1].name, grp.member[1].realm, m ) ;
      end
    end
  end
end

function oq.boss_announce( msg )
  if (not oq.iam_raid_leader() and not oq.iam_party_leader()) then  
    if (oq.raid.type ~= OQ.TYPE_RBG) and (oq.raid.type ~= OQ.TYPE_RAID) then
      return ;
    end
  end

  -- the 'B' stands for 'bosses' and should not be echo'd 
  local msg_tok = "B".. oq.token_gen() ;
  oq.token_push( msg_tok ) ;

  local m = "OQ,".. OQ_VER ..",".. msg_tok ..",".. oq.raid.raid_token ..",".. msg ;
  
  if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
    if (_inside_bg) then
      oq.SendAddonMessage( "OQ", m, "INSTANCE_CHAT" ) ;
    else
      oq.SendAddonMessage( "OQ", m, "RAID" ) ;
    end
    return ;
  end  
  -- send to bosses
  if (oq.iam_raid_leader()) then  
    oq.send_to_group_leads( m ) ;
  elseif (oq.iam_party_leader()) then
    oq.whisper_raid_leader( m ) ;
  end
end

--
--  ONLY sent by raid leader
--
function oq.raid_disband()
  if (oq.iam_raid_leader()) then
    local token = oq.token_gen() ;
    oq.token_push( token ) ;
    oq.log( nil, "|cFF808080group disbanded:|r ".. tostring(oq.raid.name) .."" ) ;
    oq.announce( "disband,".. oq.raid.raid_token ..",".. token  ) ;
    oq.tab3_radio_buttons_clear() ; -- clear premade type
    oq.on_disband( oq.raid.raid_token, token, true ) ;
  end
end

function oq.raid_find()
  local now = utc_time() ;
  if ((_last_find_tm + 8) > now) then
    return ; -- too soon.  no more then 1 find per 8 seconds
  end
  _last_find_tm = now ;

  local subtok = string.format( "%04d", utc_time() % 10000 ) ;
  oq.announce( "find,"..
               oq.my_tok .."".. subtok ..","..
               player_faction ..","..
               oq.get_player_level_range() ..","..
               player_realm
             ) ;
end

function oq.raid_join( ndx, bg_type )
  oq.raid_announce( "join,".. ndx ..",".. bg_type ) ;
end

function oq.raid_leave( ndx )
  oq.raid_announce( "leave,".. ndx ) ;
end

function oq.raid_ping()
  local msg_tok = "B".. oq.token_gen() ;
  oq.token_push( msg_tok ) ;
  local m = "OQ,".. OQ_VER ..",".. msg_tok ..",".. oq.raid.raid_token ..",ping,".. oq.my_tok ..",".. GetTime()*1000 ;
--  oq.boss_announce( "ping,".. oq.my_tok ..",".. GetTime()*1000 ) ;
  for i=2,8 do
    local grp = oq.raid.group[i] ;
    if ((grp.member) and (grp.member[1].name) and (grp.member[1].name ~= "-") and (grp.member[1].realm)) then
      oq.whisper_msg( grp.member[1].name, grp.member[1].realm, m, true ) ;
    end
  end
end

function oq.raid_ping_ack( tok, tm )
  oq._sender = nil ; -- must nil to allow send
  if (my_group == 0) then
    local name = _from ;
    local realm = nil ;
    if (_from:find("-")) then
      name  = _from:sub( 1, _from:find("-")-1 ) ;
      realm = _from:sub( _from:find("-")+1, -1 ) ;
      realm = oq.realm_uncooked(realm) ;
    end
    local msg = "ping_ack,".. tok ..",".. tm ..",".. (my_group or 0) ;
    oq.whisper_msg( name, realm, msg ) ;
  else
    local m = "ping_ack,".. tok ..",".. tm ..",".. (my_group or 0) ;
--    oq.boss_announce( "ping_ack,".. tok ..",".. tm ..",".. (my_group or 0) ) ;
    oq.whisper_raid_leader( m ) ;
  end
end

function oq.ping_toon( toon )
  local name = toon ;
  local realm = player_realm ;
  if (toon:find("-")) then
    name = toon:sub( 1, toon:find("-")-1 ) ;
    realm = toon:sub( toon:find("-")+1, -1 ) ;
    realm = oq.realm_uncooked(realm) ;
  end
  oq.whisper_msg( name, realm, "ping,".. oq.my_tok ..",".. GetTime()*1000 ) ;
end

function oq.remove_all_premades()
  tbl.clear( oq.premades ) ;
  for i,v in pairs(oq.tab2_raids) do
    v:Hide() ;
    v:SetParent(nil) ; -- remove from parent's child list
    oq.tab2_raids[i] = nil ; -- erased, but not cleaned up... should be reclaimed
  end
  oq.reshuffle_premades() ;
end

function oq.remove_dead_premades()
  if (_inside_bg) then
    return ;
  end
  
  local now = utc_time() ;
  for i,v in pairs(oq.premades) do
    -- don't remove my own premade
    if (v.raid_token ~= oq.raid.raid_token) then
      -- time since last update 
      if ((now - v.tm) > OQ_PREMADE_STAT_LIFETIME) then
        oq.remove_premade( i ) ;
      end
    end
  end
end

function oq.remove_premade( token )
  if (oq.premades[ token ] ~= nil) then
    -- hold onto the token & b-tag combo incase the user wants to ban the group lead
    if (oq.old_raids == nil) then
      oq.old_raids = {} ;
    end
    if (oq.old_raids[token] == nil) and (oq.premades[token].leader_rid ~= nil) then
      oq.old_raids[token] = { btag = oq.premades[token].leader_rid } ;
    end
    oq.premades[ token ] = nil ;
  end
  
  local reshuffle = nil ;
  for i,v in pairs(oq.tab2_raids) do
    if (v.token == token) then
      reshuffle = true ;
      v:Hide() ;
      v:SetParent(nil) ; -- remove the frame from it's parent
      oq.tab2_raids[i] = nil ;   -- erased, but not cleaned up... should be reclaimed
      break ;
    end
  end

  if (reshuffle) then
    oq.reshuffle_premades() ;
  end
end

function oq.compare_premades(a,b)
  if (a == nil) then
    return false ;
  elseif (b == nil) then
    return true ;
  end
  local v1 = oq.tab2_raids[a] ;
  local v2 = oq.tab2_raids[b] ;
  local p1 = oq.premades[ v1.raid_token ] ;
  local p2 = oq.premades[ v2.raid_token ] ;
  if (oq.premade_sort_ascending == nil) then
    p1 = oq.premades[ v2.raid_token ] ;
    p2 = oq.premades[ v1.raid_token ] ;
  end
  if (p1 == nil) then
    return false ;
  elseif (p2 == nil) then
    return true ;
  end
  if (oq.premade_sort == "name") then
    return (strlower(p1.name) < strlower(p2.name)) ;
  end
  if (oq.premade_sort == "lead") then
    return (p1.leader < p2.leader) ;
  end
  if (oq.premade_sort == "level") then
    return (p1.level_range < p2.level_range) ;
  end
  if (oq.premade_sort == "ilevel") then
    return (p1.min_ilevel < p2.min_ilevel) ;
  end
  if (oq.premade_sort == "resil") then
    return (p1.min_resil < p2.min_resil) ;
  end
  if (oq.premade_sort == "mmr") then
    return (p1.min_mmr < p2.min_mmr) ;
  end
  return true ;
end

function oq.qualified( token )
  if (token == nil) then
    return false ;
  end
  local p = oq.premades[ token ] ;
  if (p == nil) then
    return false ;
  end
  if (oq.get_player_level_id() ~= OQ.SHORT_LEVEL_RANGE[p.level_range]) then
    return false ;
  end
  if (oq.get_ilevel() < p.min_ilevel) then
    return false ;
  end
  if (oq.get_resil() < p.min_resil) then
    return false ;
  end
  if (oq.get_best_mmr(p.type) < p.min_mmr) then
    return false ;
  end
  return true ;
end

function oq.premades_of_type( filter_type )
  local nPremades = 0 ;
  if (oq.tab2_raids == nil) then
    return 0 ;
  end
  for n,v in pairs(oq.tab2_raids) do 
    local p = oq.premades[ v.token ] ;
    if (p ~= nil) then
      if ((oq.premade_filter_qualified == 1) and (oq.qualified(p.raid_token))) or (oq.premade_filter_qualified == 0) then
        if ((filter_type == OQ.TYPE_NONE) or (p.type == filter_type)) and oq.pass_filter(p) then
          nPremades = nPremades + 1 ;
        end
      end
    end
  end
  return nPremades ;
end

local _items = {} ;
local _vips = {} ;
function oq.reshuffle_premades() 
  local x, y, cx, cy ;
  x  = 15 ;
  y  = 10 ;
  cy = 25 ;
  cx = oq.tab2_list:GetWidth() - 2*x ;

  tbl.clear( _items ) ;
  tbl.clear( _vips ) ;
  for n,v in pairs(oq.tab2_raids) do 
    v._isvis = nil ;
    if (oq.premade_filter_qualified == 1) and (not oq.qualified(v.raid_token)) then
      v:Hide() ;
    else
      local p = oq.premades[ v.raid_token ] ;
      if (p ~= nil) and ((oq.premade_filter_type == OQ.TYPE_NONE) or (p.type == oq.premade_filter_type)) and oq.pass_filter(p) then
        v:Show() ;
        v._isvis = true ; 
        local btag = strlower(p.leader_rid) ;
        if (oq.vip(btag)) and (oq.vip(btag).nosort == nil) then
          table.insert(_vips, n) ;
        else
          table.insert(_items, n) ;
        end
      else
        v:Hide() ;
      end
    end
  end
  oq._npremades = 0 ;
  table.sort(_vips, oq.compare_premades) ;
  for i,v in pairs(_vips) do
    oq.setpos( oq.tab2_raids[v], x, y, cx, cy ) ;
    y = y + cy + 2 ;
    oq._npremades = oq._npremades + 1 ;
  end
  
  table.sort(_items, oq.compare_premades) ;
  for i,v in pairs(_items) do
    oq.setpos( oq.tab2_raids[v], x, y, cx, cy ) ;
    y = y + cy + 2 ;
    oq._npremades = oq._npremades + 1 ;
  end

  oq.tab2_list:SetHeight( max( 15*(cy+2), y + (4*(cy+2)) ) ) ;
  
  oq.update_premade_count() ;
end

function oq.n_waiting()
  local n = 0 ;
  if (oq.tab7_waitlist ~= nil) then
    for i,v in pairs(oq.tab7_waitlist) do
      n = n + v.nMembers ;
    end
  end
  return n ;
end

function oq.find_premade_entry( raid_token )
  local n = 0 ;
  if (oq.tab2_raids ~= nil) then
    for i,v in pairs(oq.tab2_raids) do
      if (v.raid_token == raid_token) then
        return v ;
      end
    end
  end
end

--
-- ban list
-- 
function oq.create_ban_listitem( parent, x, y, cx, cy, btag, reason, ts )
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "Banned".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, cx, cy ) ;
  
  f.texture:SetTexture( 0.0, 0.0, 0.0, 1 ) ;

  local x2 = 0 ;
  f.remove_but = oq.button( f, x2, 2,  23, cy-2, "x", function(self) oq.remove_banlist_item( self:GetParent().btag:GetText() ) ; end ) ;
  x2 = x2 + 40 ;
  f.ts   = oq.label ( f, x2, 2, 130, cy, tostring(date("%H:%M %d-%b-%Y", ts)) ) ;
--  f.ts:SetFont(OQ.FONT, 10, "") ;
  f.ts:SetFont(OQ.FONT_FIXED, 9, "") ;
  f.ts:SetTextColor( 1,1,1 ) ;
  x2 = x2 + 130 + 8 ;
  f.btag   = oq.label ( f, x2, 2, 125, cy, btag ) ;
  f.btag:SetFont(OQ.FONT, 10, "") ;
  x2 = x2 + 125 + 4 ;
  f.reason = oq.label ( f, x2, 2, 450, cy, reason ) ;
  f.reason:SetFont(OQ.FONT, 10, "") ;
  f.reason:SetTextColor( 0.9, 0.9, 0.9 ) ;
  f._ts = ts ;
  f:Show() ;
  return f ;         
end

function oq.populate_ban_list() 
  if (OQ_data.banned == nil) then
    OQ_data.banned = {} ;
  end
  local x, y, cx, cy ;
  x = 1 ;
  y = 1 ;
  cx = 200 ;
  cy = 22 ;
  for i,v in pairs(OQ_data.banned) do
    local f = oq.create_ban_listitem( oq.tab6_list, x, y, cx, cy, i, v.reason, v.ts ) ;
    table.insert( oq.tab6_banlist, f ) ;
    y = y + cy ;
  end
  oq.reshuffle_banlist() ;  
end

function oq.compare_banlist( a, b )
  if (a == nil) then
    return false ;
  elseif (b == nil) then
    return true ;
  end
  local v1 = oq.tab6_banlist[a] ;
  local v2 = oq.tab6_banlist[b] ;
  if (oq.banlist_sort_ascending == nil) then
    v1 = oq.tab6_banlist[b] ;
    v2 = oq.tab6_banlist[a] ;
  end

  if (oq.banlist_sort == "ts") then
    return (v1._ts < v2._ts) ;
  end
  if (oq.banlist_sort == "reason") then
  return (strlower(v1.reason:GetText()) < strlower(v2.reason:GetText())) ;
  end
  -- default sort: btag
  return (strlower(v1.btag:GetText()) < strlower(v2.btag:GetText())) ;
end

function oq.sort_banlist( col )
  local order = oq.banlist_sort_ascending ;
  if (oq.banlist_sort ~= col) then
    order = true ;
  else
    if (order) then
      order = nil ;
    else
      order = true ;
    end
  end
  oq.banlist_sort = col ;
  oq.banlist_sort_ascending = order ;
  oq.reshuffle_banlist() ;
end

function oq.reshuffle_banlist() 
  local x, y, cx, cy, n ;
  x  = 20 ;
  y  = 10 ;
  cy = 25 ;
  cx = oq.tab6_list:GetWidth() - 2*x ;

  tbl.clear( _items ) ;
  for n,v in pairs(oq.tab6_banlist) do 
    if (n ~= nil) then 
      table.insert(_items, n) ; 
    end
  end
  table.sort(_items, oq.compare_banlist) ;
  oq._nbanlist = 0 ;
  for i,v in pairs(_items) do
    oq.setpos( oq.tab6_banlist[v], x, y, cx, cy ) ;
    y = y + cy + 2 ;
    oq._nbanlist = oq._nbanlist + 1 ;
  end
  
  oq.tab6_list:SetHeight( max( 15*(cy+2), y + (4*(cy+2)) ) ) ;
end

function oq.remove_all_banlist()
  oq.ban_clearall() ;
  for i,v in pairs(oq.tab6_banlist) do
    v:Hide() ;
    v:SetParent(nil) ;
    oq.tab6_banlist[i] = nil ; -- erased, but not cleaned up... should be reclaimed
  end
  oq.reshuffle_banlist() ;
end

function oq.remove_banlist_item( btag )
  local reshuffle = nil ;
  for i,v in pairs(oq.tab6_banlist) do
    if (v.btag:GetText() == btag) then
      reshuffle = true ;
      v:Hide() ;
      v:SetParent(nil) ;
      oq.tab6_banlist[i] = nil ; -- erased, but not cleaned up... should be reclaimed
      break ;
    end
  end

  if (reshuffle) then
    oq.reshuffle_banlist() ;
  end

  oq.ban_remove( btag ) ;
end

function oq.is_lessthan( a, b )
   if (a == nil) then
      return true ;
   end
   return ((a or 0) < (b or 0)) ;
end
--
-- wait list
--
function oq.compare_waitlist(a,b)
  if (a == nil) then
    return false ;
  elseif (b == nil) then
    return true ;
  end
  local v1 = oq.tab7_waitlist[a] ;
  local v2 = oq.tab7_waitlist[b] ;
  local p1 = oq.waitlist[ v1.token ] ;
  local p2 = oq.waitlist[ v2.token ] ;
  if (oq.waitlist_sort_ascending == nil) then
    v1 = oq.tab7_waitlist[b] ;
    v2 = oq.tab7_waitlist[a] ;
    p1 = oq.waitlist[ v1.token ] ;
    p2 = oq.waitlist[ v2.token ] ;
  end
  if (p1 == nil) then
    return false ;
  elseif (p2 == nil) then
    return true ;
  end
  
  if (oq.waitlist_sort == "bgrp") then
    return (strlower(oq.find_bgroup(p1.realm)) < strlower(oq.find_bgroup(p2.realm))) ;
  end
  if (oq.waitlist_sort == "name") then
    return (strlower(p1.name) < strlower(p2.name)) ;
  end
  if (oq.waitlist_sort == "rlm") then
    return (strlower(p1.realm) < strlower(p2.realm)) ;
  end
  if (oq.waitlist_sort == "level") then
    return (p1.level < p2.level) ;
  end
  if (oq.waitlist_sort == "ilevel") then
    return oq.is_lessthan(p1.ilevel, p2.ilevel) ;
  end
  if (oq.waitlist_sort == "resil") then
    return oq.is_lessthan(p1.resil, p2.resil) ;
  end
  if (oq.waitlist_sort == "mmr") then
    return oq.is_lessthan(p1.mmr, p2.mmr) ;
  end
  if (oq.waitlist_sort == "power") then
    return oq.is_lessthan(p1.pvppower, p2.pvppower) ;
  end
  if (oq.waitlist_sort == "haste") then
    return oq.is_lessthan(p1.haste, p2.haste) ;
  end
  if (oq.waitlist_sort == "mastery") then
    return oq.is_lessthan(p1.mastery, p2.mastery) ;
  end
  if (oq.waitlist_sort == "hit") then
    return oq.is_lessthan(p1.hit, p2.hit) ;
  end
  if (oq.waitlist_sort == "time") then
    return oq.is_lessthan(p1.create_tm, p2.create_tm) ;
  end
  return true ;
end

function oq.reshuffle_waitlist() 
  local x, y, cx, cy, n ;
  x  = 6 ;
  y  = 10 ;
  cy = 25 ;
  cx = oq.tab7_list:GetWidth() - 2*x ;
  n  = 0 ;

  tbl.clear( _items ) ;
  tbl.clear( _vips ) ;
  for n,v in pairs(oq.tab7_waitlist) do 
    local btag = strlower(oq.waitlist[v.token].realid) ;
    if (n ~= nil) and (oq.vip(btag)) and (oq.vip(btag).nosort == nil) then
      table.insert(_vips, n) ;
    elseif (n ~= nil) then
      table.insert(_items, n) ; 
    end
  end
  oq._nwaitlist = 0 ;
  table.sort(_vips, oq.compare_waitlist) ;
  for i,v in pairs(_vips) do
    oq.setpos( oq.tab7_waitlist[v], x, y, cx, cy ) ;
    y = y + cy + 2 ;
    n = n + oq.tab7_waitlist[v].nMembers ;
    oq._nwaitlist = oq._nwaitlist + 1 ;
  end
  
  table.sort(_items, oq.compare_waitlist) ;
  for i,v in pairs(_items) do
    oq.setpos( oq.tab7_waitlist[v], x, y, cx, cy ) ;
    y = y + cy + 2 ;
    n = n + oq.tab7_waitlist[v].nMembers ;
    oq._nwaitlist = oq._nwaitlist + 1 ;
  end
    
  oq.tab7_list:SetHeight( max( 15*(cy+2), y + (4*(cy+2)) ) ) ;
  
  if (n > 0) then
    OQMainFrameTab7:SetText( string.format( OQ.TAB_WAITLISTN, n ) ) ;
  else
    OQMainFrameTab7:SetText( OQ.TAB_WAITLIST ) ;
  end
end

function oq.remove_all_waitlist()
  tbl.clear( oq.waitlist ) ;
  for i,v in pairs(oq.tab7_waitlist) do
    v:Hide() ;
    v:SetParent(nil) ;
    oq.tab7_waitlist[i] = nil ; -- erased, but not cleaned up... should be reclaimed
  end
  oq.reshuffle_waitlist() ;
end

function oq.send_removed_notice( token ) 
  local r = oq.waitlist[ token ] ;
  if (r ~= nil) then
    oq.timer_oneshot( 1, oq.realid_msg, r.name, r.realm, r.realid, 
                      OQ_MSGHEADER .."".. 
                      OQ_VER ..","..
                      "W1,"..
                      "0,"..
                      "removed_from_waitlist,"..
                      oq.raid.raid_token ..","..
                      token
                    ) ;
  end
end

function oq.reject_all_waitlist()
  for i,v in pairs(oq.tab7_waitlist) do
    oq.send_removed_notice( v.token ) ;
  end
  oq.remove_all_waitlist() ;
end

function oq.remove_waitlist( token )
  local reshuffle = nil ;
  for i,v in pairs(oq.tab7_waitlist) do
    if (v.token == token) then
      reshuffle = true ;
      v:Hide() ;
      v:SetParent(nil) ;
      oq.tab7_waitlist[i] = nil ; -- erased, but not cleaned up... should be reclaimed
      break ;
    end
  end

  if (reshuffle) then
    oq.reshuffle_waitlist() ;
  end

  -- now tell the remote user he has been removed
  oq.send_removed_notice( token ) ;
  
  -- clean up the waitlist  
  if (oq.waitlist[ token ] ~= nil) then
    oq.waitlist[ token ] = nil ;
  end
end

function oq.on_removed_from_waitlist( raid_token, req_token )
  -- set the premade button from 'pending' back to 'waitlist'
  local f = oq.find_premade_entry( raid_token ) ;
  if (f ~= nil) then
    f.req_but:SetText( OQ.BUT_WAITLIST ) ;
    f.req_but:SetBackdropColor( 0.5, 0.5, 0.5, 1 ) ;
    f.pending = nil ;
    if (oq.raid.raid_token == nil) then
      -- sad sound if no group and leaving wait list
      PlaySound( "igQuestFailed" ) ;
    end
  end
  
  -- remove from oq.pending
  oq.pending[ raid_token ] = tbl.delete( oq.pending[ raid_token ] ) ;
end

function oq.on_leave_waitlist( raid_token, req_token )
  if (raid_token ~= oq.raid.raid_token) then
    -- not for me
    return ;
  end
  oq.remove_waitlist( req_token ) ;  
end

function oq.send_leave_waitlist( raid_token )
  if (raid_token == nil) then
    return ;
  end
  local now = utc_time() ;
  local req = oq.pending[ raid_token ] ;
  local raid = oq.premades[ raid_token ] ;
  if (req == nil) or (raid == nil) or (req.next_msg_tm > now) or (req.req_token == nil) then
    return ;
  end
  req.next_msg_tm = now + 5 ;
  
  if (raid_token == oq.raid.raid_token) then
    -- i've joined the raid.  just remove the entry
    oq.pending[ raid_token ] = tbl.delete( oq.pending[ raid_token ] ) ;
    local f = oq.find_premade_entry( raid_token ) ;
    if (f ~= nil) then
      f.req_but:SetText( OQ.BUT_WAITLIST ) ;
      f.req_but:SetBackdropColor( 0.5, 0.5, 0.5, 1 ) ;
      f.pending = nil ;
      if (oq.raid.raid_token == nil) then
        -- sad sound if no group and leaving wait list
        PlaySound( "igQuestFailed" ) ;
      end
    end
  else
    oq.realid_msg( raid.leader, raid.leader_realm, raid.leader_rid, 
                   OQ_MSGHEADER .."".. 
                   OQ_VER ..","..
                   "W1,"..
                   "0,"..
                   "leave_waitlist,"..                 
                   raid_token ..","..
                   req.req_token 
                 ) ;
  end
end

--
-- this is called to remove the player from all waitlists they may have put themselves on
--
function oq.clear_pending()
  for raid_token,req in pairs( oq.pending ) do
    oq.send_leave_waitlist( raid_token ) ;
  end
end

function oq.check_and_send_request( raid_token )
  local in_party = (oq.GetNumPartyMembers() > 0) ;
  local raid  = oq.premades[ raid_token ] ;
  if (raid == nil) then
    return ;
  end
  if (in_party and not UnitIsGroupLeader("player")) then
    StaticPopup_Show("OQ_NotPartyLead", nil, nil, ndx ) ;
    return ;
  end
  if (in_party and (raid.type ~= OQ.TYPE_BG)) then
    StaticPopup_Show("OQ_NoPartyWaitlists", nil, nil, ndx ) ;
    return ;
  end
  if (oq.raid.raid_token ~= nil) then
    if (my_group == 1) and (my_slot == 1) then
      StaticPopup_Show("OQ_NoWaitlistWhilePremadeLead", nil, nil, ndx ) ;
    else
      StaticPopup_Show("OQ_NoWaitlistWhilePremade", nil, nil, ndx ) ;
    end
    return ;
  end
  
  if (raid ~= nil) then
    if (raid.has_pword ~= nil) then
      PlaySoundFile( "Sound\\interface\\KeyRingOpen.wav" ) ;
      local dialog = StaticPopup_Show("OQ_EnterPword") ;
      dialog.data = raid_token ;
    else
      oq.send_req_waitlist( raid_token, "" ) ;
    end
  end
end

function oq.send_req_waitlist( raid_token, pword ) 
  local in_party = (oq.GetNumPartyMembers() > 0) ;
  
  local now = utc_time() ;
  local req = oq.pending[ raid_token ] ;
  if (req == nil) then
    oq.pending[ raid_token ] = tbl.new() ;
    req = oq.pending[ raid_token ] ;
  elseif (req.next_msg_tm) and (req.next_msg_tm > now) then
    -- too soon for resend. no more then once every 5 seconds
    return ;
  end
  req.next_msg_tm = now + 5 ;

  local req_token = req.req_token ;

  if (req_token == nil) then
    req_token = "Q".. oq.token_gen() ;
    req.req_token = req_token ;
    oq.token_push( req_token ) ;  -- hang onto it for return
  end

  oq.gather_my_stats() ;
  local flags = OQ.FLAG_ONLINE ;
  local raid  = oq.premades[ raid_token ] ;
  _dest_realm = raid.leader_realm ;
  
  if (raid == nil) then
    return ;
  end
  oq.raid.type = raid.type ;
  
  if (player_realm ~= _dest_realm) and (not oq.valid_rid( player_realid )) then
    message( OQ.BAD_REALID .." ".. tostring(player_realid) ) ;
    return ;
  end

  if (in_party) then
    -- must be party leader.  
    local party_avg_ilevel = 0 ;
    local party_avg_resil  = 0 ;  
    local mmr              = oq.get_best_mmr(raid.type) ;
    local pvppower         = oq.get_pvppower() ;
    local stats = oq.encode_short_stats( player_level, player_faction, player_class, party_avg_resil, party_avg_ilevel, player_role, mmr, pvppower, 0 ) ;
    local enc_data = oq.encode_data( "abc123", player_name, player_realm, player_realid ) ;
    oq.realid_msg( raid.leader, raid.leader_realm, raid.leader_rid, 
                   OQ_MSGHEADER .."".. 
                   OQ_VER ..","..
                   "W1,"..
                   "0,"..
                   "ri,"..                 
                   raid_token ..","..
                   tostring(raid.type or 0) ..","..
                   tostring(oq.GetNumPartyMembers()) ..","..
                   req_token ..","..
                   enc_data ..","..
                   stats ..","..
                   oq.encode_pword( pword ) 
                 ) ;
  else
    local mmr                  = oq.get_best_mmr(raid.type) ;
    local pvppower             = oq.get_pvppower() ;
    local class, spec, spec_id = oq.get_spec() ;
    local stats = oq.encode_my_stats( 0, 0, 0, 'A', 'A' ) ;
    local enc_data = oq.encode_data( "abc123", player_name, player_realm, player_realid ) ;

    oq.realid_msg( raid.leader, raid.leader_realm, raid.leader_rid, 
                   OQ_MSGHEADER .."".. 
                   OQ_VER ..","..
                   "W1,"..
                   "0,"..
                   "ri,"..                 
                   raid_token ..","..
                   tostring(raid.type or 0) ..","..
                   "1,"..
                   req_token ..","..
                   enc_data ..","..
                   stats ..","..
                   oq.encode_pword( pword ) 
                 ) ;
  end
end

-------------------------------------------------------------------------------
--   
-------------------------------------------------------------------------------
function oq.bg_name( tid )
  for i,v in pairs(OQ.BG_NAMES) do
    if (v.type_id == tid) then
      return i ;
    end
  end
end

function oq.bg_type_id( name ) 
  if (name == nil) then
    return -1 ;
  end
  if (OQ.BG_NAMES[ name ] == nil) then
    return -2 ;
  end
  return OQ.BG_NAMES[ name ].type_id ;
end

function oq.get_player_level_id() 
  player_level = UnitLevel("player") ; -- the level could have changed since the group was formed
  if (player_level == 90) then
    return OQ.SHORT_LEVEL_RANGE[ "90" ] ;
  elseif (player_level < 10) then
    return OQ.SHORT_LEVEL_RANGE[ "unavailable" ] ;
  end
  local minlevel = floor( player_level / 5) * 5 ;
  local maxlevel = floor((player_level + 5) / 5) * 5 - 1 ;
  return OQ.SHORT_LEVEL_RANGE[ string.format( "%d - %d", minlevel, maxlevel ) ] ;
end

function oq.get_player_level_range() 
  player_level = UnitLevel("player") ; -- the level could have changed since the group was formed
  if (player_level == 90) then
    return 90, 90 ;
  elseif (player_level < 10) then
    return 0,0 ;
  end
  local minlevel, maxlevel ;

  minlevel = floor(player_level / 5) * 5 ;
  maxlevel = floor((player_level + 5) / 5) * 5 - 1 ;

  return minlevel, maxlevel ;
end

function oq.nVisible( type )
  if (type == "banlist") then
    return oq._nbanlist or 0 ;
  elseif (type == "waitlist") then
    return oq._nwaitlist or 0 ;
  elseif (type == "premades") then
    return oq._npremades or 0 ;
  end
  return 0 ;
end

function OQ_ModScrollBar_Update(f)
  local nItems = max( 14, oq.nVisible(f._type) ) ;
  FauxScrollFrame_Update( f, nItems, 5, 25 ) ;
end

function oq.show_version()
  print( "oQueue v".. OQUEUE_VERSION .."  build ".. OQ_BUILD .." (".. tostring(OQ.REGION) ..")".. tostring(OQ_SPECIAL_TAG or "") ) ;
  
  if (player_level > 20) and (oq.get_role() == "None") then
    oq.warning_no_role() ;
  end
end

function oq.hint( button, txt, show )
  if (not show) or (txt == nil) or (txt == "") then
    -- clear & hide the tooltip
    oq.gen_tooltip_hide() ;
    return ;
  end
  oq.gen_tooltip_set( button, txt ) ;
end

function oq.battleground_join( ndx, bg_type )
  if (oq.iam_party_leader()) then
    if (GetNumGroupMembers() == 0) then
      oq.make_big( HonorFrameSoloQueueButton ) ; -- queue up as solo toon
    else
      oq.make_big( HonorFrameGroupQueueButton ) ;
    end
  end
end

function oq.normalize_static_button_height()
  if (HonorFrameSoloQueueButton) then
    if (not HonorFrameSoloQueueButton:IsVisible()) then
      oq.reset_button( HonorFrameSoloQueueButton ) ;
    end
    HonorFrameSoloQueueButton:Show() ;
  end
  if (HonorFrameGroupQueueButton) then
    if (not HonorFrameGroupQueueButton:IsVisible()) then
      oq.reset_button( HonorFrameGroupQueueButton ) ;
    end
    HonorFrameGroupQueueButton:Show() ;
  end

  if (PVPReadyDialogEnterBattleButton and (not PVPReadyDialogEnterBattleButton:IsVisible())) then
    oq.reset_button( PVPReadyDialogEnterBattleButton ) ;
  end
  if (PVPReadyDialogLeaveQueueButton and (not PVPReadyDialogLeaveQueueButton:IsVisible())) then
    oq.reset_button( PVPReadyDialogLeaveQueueButton ) ;
  end
end

function oq.battleground_leave( ndx )
  if (_inside_bg or (my_group == 0) or (my_slot == 0)) then
    return ;
  end

  -- are we still in a bg?
  if (GetBattlefieldStatInfo(1)) then
    return ;
  end

  local s1 = select(1, GetBattlefieldStatus(ndx)) ;
  if (s1 == "none") then
    -- nothing to do
    return ;
  end
  
  if (s1 == "confirm") then
    -- queue popped, move button to be clicked
    local button = PVPReadyDialogLeaveQueueButton ;
    button:Enable() ;
    button:SetText( OQ.DLG_LEAVE ) ;
    if (oq.leaveQ:IsVisible()) then
      oq.reset_button( oq.leaveQ ) ;
      oq.leaveQ:Hide() ;
    end
    oq.reset_button( button ) ;
    oq.make_big( button ) ;
  else
    -- queue not popped, move macro button into position
    oq.leaveQ:SetText( OQ.DLG_LEAVE ) ;
    oq.make_big( oq.leaveQ ) ;
  end

  --
  --  leaving queue now requires a hardware event
  --  pop up a box for the user to hit ok or esc (any input)
  --
end

function oq.battleground_leave_now( ndx )
  last_stat_tm = 0 ; -- force the status send
end

function oq.create_alt_listitem( parent, x, y, cx, cy, name )
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "Alt".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, cx, cy ) ;

  f.name = name ;
  f.texture:SetTexture( 0.0, 0.0, 0.0, 1 ) ;

  local x2 = 1 ;
  f.remove_but = oq.button( f, x2, 2,  18, cy-2, "x", function(self) oq.remove_alt_listitem( self:GetParent().name ) ; end ) ;
  x2 = x2 + 18+4 ;
  f.toonName  = oq.label( f, x2, 2, 150, cy, name ) ;
  f:Show() ;
  return f ;         
end

function oq.clear_alt_list()
  for i,v in pairs(oq.tab5_alts) do
    v:Hide() ;
    v:SetParent(nil) ;
    oq.tab5_alts[i] = nil ;   -- erased, but not cleaned up... should be reclaimed
  end
  tbl.clear( OQ_toon.my_toons ) ;
end

function oq.remove_alt_listitem( name )
  local reshuffle = nil ;
  for i,v in pairs(oq.tab5_alts) do
    if (v.name == name) then
      reshuffle = true ;
      v:Hide() ;
      v:SetParent(nil) ;
      oq.tab5_alts[i] = nil ;   -- erased, but not cleaned up... should be reclaimed
      break ;
    end
  end
  
  for i,v in pairs(OQ_toon.my_toons) do
    if (v.name == name) then
      OQ_toon.my_toons[i] = nil ;
      break ;
    end
  end

  if (reshuffle) then
    oq.reshuffle_alts() ;
  end
end

function oq.reshuffle_alts() 
  if (oq.tab5_alts == nil) then
    oq.tab5_alts = {} ;
    return ;
  end
    
  local x, y, cx, cy ;
  x  = 20 ;
  y  = 10 ;
  cy = 20 ;
  cx = oq.tab5_list:GetWidth() - 2*x ;
  for i,v in pairs(oq.tab5_alts) do
    oq.setpos( v, x, y, cx, cy ) ;
    y = y + cy + 2 ;
  end
  
  oq.tab5_list:SetHeight( max( 6*(cy+2), y + (1*(cy+2)) ) ) ;
end

function oq.add_toon( toonName ) 
  if (toonName == nil) or (toonName == "") then
    return ;
  end
  if (OQ_toon.my_toons == nil) then
    OQ_toon.my_toons = {} ;
  end
  for i,v in pairs(OQ_toon.my_toons) do
    if (v.name == toonName) then
      return ;
    end
  end

  local d = { name = toonName ; }
  table.insert( OQ_toon.my_toons, d ) ;
  
  -- now update ui
  local f = oq.create_alt_listitem( oq.tab5_list, 1, 1, 200, 22, toonName ) ;
  f.toonName:SetText( toonName ) ;
  table.insert( oq.tab5_alts, f ) ;
  oq.reshuffle_alts() ;  
end

function oq.populate_alt_list() 
  if (OQ_toon.my_toons == nil) then
    OQ_toon.my_toons = {} ;
  end
  local x, y, cx, cy ;
  x = 1 ;
  y = 1 ;
  cx = 200 ;
  cy = 22 ;
  for i,v in pairs(OQ_toon.my_toons) do
    local f = oq.create_alt_listitem( oq.tab5_list, x, y, cx, cy, v.name ) ;
    f.toonName:SetText( v.name ) ;
    y = y + cy ;
    table.insert( oq.tab5_alts, f ) ;
  end
  oq.reshuffle_alts() ;  
end

function oq.populate_waitlist()
  local x, y, cy ;
  x  = 2 ;
  cy = 25 ;
  y  = 10 ;
  for req_token,v in pairs(oq.waitlist) do
    if (v) and (v.name) then
      local f = oq.insert_waitlist_item( x, y, req_token, v.n_members, v.name, v.realm, v ) ;
      table.insert( oq.tab7_waitlist, f ) ;
      y = y + cy ;
    else
      oq.waitlist[ req_token ] = tbl.delete( oq.waitlist[ req_token ] ) ;
    end
  end
  oq.reshuffle_waitlist() ;
end

--------------------------------------------------------------------------
--
--------------------------------------------------------------------------
function oq.on_enter_bg( ndx )
  PVPReadyDialogEnterBattleButton:Enable() ;
  PVPReadyDialogLeaveQueueButton:Disable() ;
  oq.reset_button( PVPReadyDialogEnterBattleButton ) ;
  oq.make_big( PVPReadyDialogEnterBattleButton ) ;
end

function oq.getpos( f, p ) 
  if (f == nil) or (f:GetLeft() == nil) then
    return { left = 0, top = 0, width = 10, height = 10 } ;
  end
  if (p == nil) then
    p = tbl.new() ;
  end
  p.left   = ceil( f:GetLeft  () - 0.5 ) ;
  p.top    = ceil( f:GetTop   () - 0.5 ) ;
  p.width  = ceil( f:GetWidth () - 0.5 ) ;
  p.height = ceil( f:GetHeight() - 0.5 ) ;
  if (f:GetParent() ~= UIParent) then
    p.left = ceil( p.left - f:GetParent():GetLeft() - 0.5 ) ;
    p.top  = ceil( p.top  - f:GetParent():GetTop()  - 0.5 ) ;
  end
  p.top = abs( p.top ) ;
  return p ;
end

function oq.center( f ) 
  local x = ceil( ((GetScreenWidth ()-f:GetWidth ())/2) - 0.5) ;
  local y = ceil( ((GetScreenHeight()-f:GetHeight())/2) - 0.5) ;
  f:SetPoint("TOPLEFT",UIParent,"TOPLEFT", x, -1 * y)
  return f ;
end

function oq.make_big( f )
  if (_inside_bg) or (f == nil) then
    return ;
  end
  f._was_vis = f:IsVisible() ;
  if (not f:IsVisible()) then
    f:Show() ;
  end
  if (f._is_big) then
    return ;
  end
  f._is_big          = true ;
  f._original_pos    = oq.getpos( f, f._original_pos) ;
  f._original_level  = f:GetFrameLevel() ;
  f:SetFrameLevel( 99 ) ;
  f:ClearAllPoints() ;
  if (f:IsEnabled()) then
    f._original_enable = 1 ;
  else
    f._original_enable = 0 ;
  end
  f:Enable() ;
  oq.center( oq.setpos( f, 100, 100, 300, 300 ) ) ;
  
  oq.angry_lil_button( f ) ;
  f:SetScript("PostClick", function(self) oq.angry_lil_button_done( self ) ; end ) ;
end

function oq.reset_button( f )
  if (not f._is_big) then
    return ;
  end
  if (f._original_pos ~= nil) then
    local o = f._original_pos ;
    oq.setpos( f, o.left, o.top, o.width, o.height ) ;
  end
  if (f._original_level) then
    f:SetFrameLevel( f._original_level ) ;
  end
  if (f._was_vis) then
    f:Show() ;
  else
    f:Hide() ;
  end
  if (f._original_enable == 0) then
    f:Disable() ;
  else
    f:Enable() ;
  end
  f:SetScript("PostClick", function(self) end ) ;
  f._is_big = nil ;
end

function oq.on_leave_queue( ndx )
  StaticPopup_Hide("OQ_QueuePoppedMember") ;

  -- this may require hardware event
  oq.battleground_leave( tonumber(ndx) ) ; 
end

function oq.quit_raid() 
  if (not _inside_bg) then
    local dialog = StaticPopup_Show("OQ_QuitRaidConfirm") ;
  end
end

function oq.raid_cleanup_slot( i, j )
  if (j == 1) then
    oq.raid.group[i]._last_ping     = nil ;
    oq.raid.group[i]._names         = nil ;
    oq.raid.group[i]._stats         = nil ;
    oq.raid.group[i].member[1].lag  = nil ;
    oq.tab1_group[i].status[1]:SetText( "-" ) ;
    oq.tab1_group[i].status[2]:SetText( "-" ) ;
    oq.tab1_group[i].lag:SetText( "" ) ;
  end
  oq.set_group_member( i, j, nil, nil, "XX", nil, "0", "0" ) ;
  oq.set_deserter( i, j, nil ) ;
  oq.set_role( i, j, OQ.ROLES["NONE"] ) ;
end

function oq.ui_raidleader()
  if (oq.raid.type == OQ.TYPE_BG) then
    oq.tab1_bg[1].queue_button:Show() ;
    oq.tab1_bg[2].queue_button:Show() ;
  else
    oq.tab1_bg[1].queue_button:Hide() ;
    oq.tab1_bg[2].queue_button:Hide() ;
  end
  oq.tab1_quit_button:SetText( OQ.DISBAND_PREMADE ) ;
  oq.tab1_readycheck_button:Show() ;
  oq.tab1_brb_button:Show() ;
  oq.tab1_lucky_charms:Show() ;
  OQMainFrameTab7:Show() ;
end

function oq.ui_player()
  if (oq.raid.raid_token) and (oq.iam_raid_leader()) then
    oq.ui_raidleader() ;
    return ;
  end

  oq.tab1_bg[1].queue_button:Hide() ;
  oq.tab1_bg[2].queue_button:Hide() ;
  oq.tab1_quit_button:SetText( OQ.LEAVE_PREMADE ) ;
  oq.tab1_readycheck_button:Hide() ;
  OQMainFrameTab7:Hide() ;
  if (my_slot == 0) then
    oq.tab1_brb_button:Hide() ;
  else
    oq.tab1_brb_button:Show() ;
  end
  oq.tab1_lucky_charms:Hide() ;
end

function oq.raid_cleanup()
  -- leave party
  if (oq.iam_in_a_party()) then
    oq._error_ignore_tm  = GetTime() + 5 ;
    -- not leaving party... allowing the user to control leaving group
--    LeaveParty() ;
  end

  oq.set_premade_type( OQ.TYPE_BG ) ;
  for i=1,8 do
    oq.tab1_group[i].lag:SetText( "" ) ;
    for k=1,2 do
      oq.tab1_group[i].status[k]:SetText( "-" ) ;
    end
    for j=1,5 do
      oq.raid_cleanup_slot( i, j ) ;
    end
  end
  oq.tab3_create_but:SetText( OQ.CREATE_BUTTON ) ;
  oq.tab1_name :SetText( "" ) ;
  oq.tab1_notes:SetText( "" ) ;
  oq.tab1_raid_stats:SetText( "" ) ;

  -- update status 
  if (oq._last_raid_token == nil) then
    oq._last_raid_token = oq.raid.raid_token ;
  end
  local raid = oq.premades[ oq._last_raid_token ] ;
  if (raid ~= nil) then
    local s = raid.stats ;
    local line = oq.find_premade_entry( oq._last_raid_token ) ;
    if (line ~= nil) then
      if (s.status == 2) then -- if inside, disable the waitlist button
        line.req_but:Disable() ;
      else
        line.req_but:Enable() ;
      end
    end  
  end
  
  -- clear settings
  tbl.clear( oq.raid ) ;
  oq.raid.group = tbl.new() ;
  for i=1,8 do
    oq.raid.group[i] = tbl.new() ;
    oq.raid.group[i].member = tbl.new() ;
    for j=1,5 do
      oq.raid.group[i].member[j] = tbl.new() ;
      oq.raid.group[i].member[j].flags = 0 ;
      oq.raid.group[i].member[j].charm = 0 ;
      oq.raid.group[i].member[j].check = OQ.FLAG_CLEAR ;
      oq.raid.group[i].member[j].bg = tbl.new() ;
      for k=1,2 do
        oq.raid.group[i].member[j].bg[k] = tbl.new() ;
        oq.raid.group[i].member[j].bg[k].start_tm   = 0 ;
        oq.raid.group[i].member[j].bg[k].queue_ts   = 0 ;
        oq.raid.group[i].member[j].bg[k].confirm_tm = 0 ;
        oq.raid.group[i].member[j].bg[k].status     = "0" ;
      end
    end
  end

  tbl.clear( oq.waitlist ) ;
  my_group      = 0 ;
  my_slot       = 0 ;

  -- remove raid-only procs
--  oq.set_premade_type( OQ.TYPE_BG ) ;
  oq.procs_no_raid() ;
  
  oq.ui_player() ;
  
  -- reset buttons
  PVPReadyDialogEnterBattleButton:Show() ;
  PVPReadyDialogLeaveQueueButton :Show() ;
  PVPReadyDialogEnterBattleButton:Enable() ;
  PVPReadyDialogLeaveQueueButton :Enable() ;
end

function oq.quit_raid_now() 
  -- 
  -- clear out raid settings
  --
  oq.raid_announce( "leave_slot,".. my_group ..",".. my_slot ) ;
  oq.raid_disband() ;  -- only triggers if i am raid leader

  -- make sure we left any queues we might've been in
  if (not _inside_bg) then
    oq.battleground_leave( 1 ) ;
    oq.battleground_leave( 2 ) ;
  end

  -- clean up raid tab
  oq.raid_cleanup() ;
  oq.remove_all_waitlist() ;
end

function oq.accept_group_leader( req_token, group_id )
  local r = oq.waitlist[ req_token ] ;
  if (r == nil) then
    print( "unable to locate req_token ".. req_token ..".  invite failed" ) ;
    return ;
  end

  oq.set_group_member( group_id, 1, r.name, r.realm, r.class, r.realid ) ;
end

function oq.InviteUnit( name, realm )
  if (realm == nil) or (realm == player_realm) then
    InviteUnit( name ) ;
  else
    InviteUnit( name .."-".. realm ) ;
  end
end

local _ninvites = 0 ;
function oq.invite_group_leader( req_token, group_id )
  local r = oq.waitlist[ req_token ] ;  
  if (r == nil) then
    -- wasn't my request
    return ;
  end

  -- the 'W' stands for 'whisper' and should not be echo'd far and wide
  local msg_tok = "W".. oq.token_gen() ;
  oq.token_push( msg_tok ) ;
  local enc_data = oq.encode_data( "abc123", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ;
  local msg = "invite_group_lead,"..  
              req_token ..",".. 
              group_id ..",".. 
              oq.encode_name( oq.raid.name ) ..",".. 
              oq.raid.leader_class  ..",".. 
              enc_data ..",".. 
              oq.raid.raid_token ..","..
              oq.encode_note( oq.raid.notes ) ;

  -- if i'm already b-net friends or the player is on my realm, just send msg
  local pid = oq.bnpresence( r.name .."-".. r.realm ) ;
  if (pid ~= 0) or (player_realm == r.realm) then
    oq.realid_msg( r.name, r.realm, r.realid, msg ) ;
    oq.remove_waitlist( req_token ) ;
    return ;
  end
  
  -- if reaches here, player is not b-net friend or not on realm... must b-net friend then invite
  if (oq.iam_raid_leader() and (player_realm ~= r.realm)) then
    oq.bn_realfriend_invite( r.name, r.realm, r.realid, "#tok:".. req_token ..",#lead" ) ;
  end

  _ninvites = _ninvites + 1 ;
  oq.timer( "invite_to_group".. _ninvites, 2, oq.timer_invite_group, true, req_token, msg, true ) ;
end

function oq.timer_invite_group( req_token, msg, is_lead )
  local r = oq.waitlist[ req_token ] ;
  if (r == nil) then
    return true ; -- this will remove the timer
  end
  next_bn_check = 0 ; -- force the refresh
--  local pid = oq.bnpresence( r.name .."-".. r.realm ) ;
  local pid, online = oq.is_bnfriend( r.realid ) ;
  if (pid == nil) then
    -- not friended yet
    if (r.attempts == nil) then
      r.attempts = 1 ;
    else
      r.attempts = r.attempts + 1 ;
    end
    if (r.attempts > 8) then
      print( "B.net has not friended ".. r.name .."-".. r.realm .." (".. tostring(r.realid) ..").  Giving up." ) ;
      return true ; -- this will remove the timer
    end
    return ;
  end

  oq.realid_msg( r.name, r.realm, r.realid, msg ) ;
  if (not is_lead) then
    oq.InviteUnit( r.name, r.realm ) ;
  end
  oq.remove_waitlist( req_token ) ;
  return true ; -- this will remove the timer
end

function oq.is_in_group( name, realm )
  local n = name ;
  if (realm ~= player_realm) then
    n = n .."-".. realm ;
  end
  return UnitInParty( n ) ;
end

function oq.timer_invite_group_member( name, realm, rid_, msg, group_id, slot_, req_token_ )
  if (oq.is_in_group( name, realm )) then
    oq.pending_invites[ name .."-".. realm ] = nil ;
    return ;
  end
  next_bn_check = 0 ; -- force the refresh
  local pid = oq.bnpresence( name .."-".. realm ) ;
  if (pid == 0) then
    -- not friended yet
    local r = oq.pending_invites[ name .."-".. realm ] ;
    if (r == nil) then
      -- table leak when deleted
      oq.pending_invites[ name .."-".. realm ] = { raid_tok = oq.raid.raid_token, gid = group_id, slot = slot_, rid = rid_, req_token = req_token_ } ;
      r = oq.pending_invites[ name .."-".. realm ] ;
    end
    if (r.attempts == nil) then
      r.attempts = 1 ;
    else
      r.attempts = r.attempts + 1 ;
    end
    if (r.attempts == 5) then
      oq.bn_realfriend_invite( name, realm, rid_, "#tok:".. req_token_ ..",#grp:".. group_id ..",#nam:".. player_name .."-".. tostring(oq.realm_cooked(player_realm)) ) ; 
    elseif (r.attempts > 8) then
      print( "B.net has not friended ".. name .."-".. realm .." (".. tostring(rid_) ..").  Giving up." ) ;
      oq.pending_invites[ name .."-".. realm ] = nil ;
      return true ; -- this will remove the timer
    end
    return ;
  end
  
  oq.realid_msg( name, realm, rid_, msg ) ;
  oq.timer_oneshot( 1.5, oq.InviteUnit, name, realm ) ;
  oq.timer_oneshot( 3.5, oq.brief_group_members ) ;  
  oq.pending_invites[ name .."-".. realm ] = nil ;
  return true ; -- this will remove the timer
end

function oq.find_first_available_slot( p ) 
  if (p ~= nil) then
    -- check to see if player already assigned a slot
    for i=1,8 do
      for j=1,5 do
        if ((oq.raid.group[i].member[j].name == p.name) and (oq.raid.group[i].member[j].realm == p.realm)) then
          oq.raid.group[i].member[j].charm = 0 ; 
          oq.raid.group[i].member[j].check = OQ.FLAG_CLEAR ;
          return i, j ;
        end
      end
    end
  end
  for i=1,8 do
    for j=1,5 do
      if ((oq.raid.group[i].member[j].name == nil) or (oq.raid.group[i].member[j].name == "-")) then
        oq.raid.group[i].member[j].name  = p.name  ; -- reserve spot so we don't get overlap due to slow messaging
        oq.raid.group[i].member[j].realm = p.realm ; 
        oq.raid.group[i].member[j].class = "XX" ; 
        oq.raid.group[i].member[j].charm = 0 ; 
        oq.raid.group[i].member[j].check = OQ.FLAG_CLEAR ;
        return i, j ;
      end
    end
  end
  return 0, 0 ;
end

function oq.find_first_available_group( p ) 
  if (p ~= nil) then
    -- check to see if player already assigned a slot
    for i=1,8 do
      if ((oq.raid.group[i].member[1].name == p.name) and (oq.raid.group[i].member[1].realm == p.realm)) then
        oq.group_charm_clear( i )
        return i ;
      end
    end
  end
  for i=1,8 do
    if ((oq.raid.group[i].member[1].name == nil) or (oq.raid.group[i].member[1].name == "-")) then
        oq.group_charm_clear( i )
      return i ;
    end
  end
  return 0, 0 ;
end

function oq.group_invite_slot( req_token, group_id, slot ) 
  if (not oq.iam_raid_leader()) then
    -- not possible
    return ;
  end
  --
  -- slot will NOT be 1
  --
  local r = oq.waitlist[ req_token ] ;
  
  if (r == nil) then
    oq.remove_waitlist( req_token ) ;
    return ;    
  end
  if (r.realid == nil) then
    oq.remove_waitlist( req_token ) ;
    return ;    
  end
  
  group_id = tonumber( group_id ) ;
  slot     = tonumber( slot ) ;
  
  if ((oq.raid.type ~= OQ.TYPE_RBG) and (oq.raid.type ~= OQ.TYPE_RAID) and (group_id ~= my_group)) then
    -- proxy_invite needed
    oq.proxy_invite( group_id, slot, r.name, r.realm, r.realid, req_token ) ;
    oq.timer( "brief_leader", 1.5, oq.brief_group_lead, nil, group_id ) ;
    oq.remove_waitlist( req_token ) ;
    return ;
  end
  
  -- the 'W' stands for 'whisper' and should not be echo'd far and wide
  local msg_tok = "W".. oq.token_gen() ;
  local g_leader_rid = oq.raid.group[ group_id ].member[1].realid ;
  if (g_leader_rid == nil) then
    g_leader_rid = OQ_NOEMAIL ;
  end

  oq.token_push( msg_tok ) ;
  local enc_data = oq.encode_data( "abc123", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ;
  local msg = "invite_group,"..  
              req_token ..",".. 
              group_id ..",".. 
              slot ..",".. 
              oq.encode_name( oq.raid.name ) ..",".. 
              oq.raid.leader_class  ..",".. 
              enc_data ..",".. 
              oq.raid.raid_token ..","..
              oq.encode_note( oq.raid.notes ) ;

  -- if i'm already b-net friends or the player is on my realm, just send msg
--  local pid = oq.bnpresence( r.name .."-".. r.realm ) ;
  local pid, online = oq.is_bnfriend( r.realid ) ;
  if ((pid ~= nil) and (pid ~= 0)) or (player_realm == r.realm) then
    oq.realid_msg( r.name, r.realm, r.realid, msg ) ;
    oq.InviteUnit( r.name, r.realm ) ;
    oq.remove_waitlist( req_token ) ;
    return ;
  end
  -- if reaches here, player is not b-net friend or not on realm... must b-net friend then invite
  oq.bn_realfriend_invite( r.name, r.realm, r.realid, "#tok:".. req_token ..",#grp:".. my_group ..",#nam:".. player_name .."-".. tostring(oq.realm_cooked(player_realm)) ) ; 

  _ninvites = _ninvites + 1 ;
  oq.timer( "invite_to_group".. _ninvites, 2, oq.timer_invite_group, true, req_token, msg ) ;
end

function oq.group_invite_first_slot_in( req_token, group_id ) 
  if (not oq.iam_raid_leader()) then
    -- not possible
    return ;
  end
  local r = oq.waitlist[ req_token ] ;
  
  group_id = tonumber( group_id ) ;
  local slot = oq.first_slot_in_group( group_id ) ;
  if (slot == 0) then
    print( "[oq.group_invite_first_slot_in]  no slots available" ) ;
    return ;
  end
  if (slot == 1) then
    oq.invite_group_leader( req_token, group_id ) ;
  else
    oq.group_invite_slot( req_token, group_id, slot ) ;
  end
end

function oq.group_invite_first_available( req_token ) 
  if (not oq.iam_raid_leader()) then
    -- not possible
    return ;
  end
  local r = oq.waitlist[ req_token ] ;
  
  local group_id, slot = oq.find_first_available_slot( r ) ;
  if (group_id == 0) then
    print( "[oq.group_invite_first_available]  no slots available" ) ;
    return ;
  end
  if (slot == 1) then
    oq.invite_group_leader( req_token, group_id ) ;
  else
    oq.group_invite_slot( req_token, group_id, slot ) ;
  end
end

function oq.group_invite_party( req_token ) 
  local r = oq.waitlist[ req_token ] ;

  local group_id = oq.find_first_available_group( r ) ;
  if (group_id == 0) then
    print( "[oq.group_invite_party]  no empty groups available" ) ;
    return ;
  end

  -- if i'm raid leader, all group leaders must be real-id friends if not on the same realm
  if (oq.iam_raid_leader() and (player_realm ~= r.realm)) then
    oq.realid_msg( r.name, r.realm, r.realid, "#tok:".. req_token ..",#lead" ) ;
  end

  -- the 'W' stands for 'whisper' and should not be echo'd far and wide
  local msg_tok = "W".. oq.token_gen() ;
  oq.token_push( msg_tok ) ;
  local enc_data = oq.encode_data( "abc123", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ;
  local msg = "invite_group_lead,"..  
              req_token ..",".. 
              group_id ..",".. 
              oq.encode_name( oq.raid.name ) ..",".. 
              oq.raid.leader_class  ..",".. 
              enc_data ..",".. 
              oq.raid.raid_token ..","..
              oq.encode_note( oq.raid.notes ) ;

  local m = "OQ,".. OQ_VER ..",".. msg_tok ..",0,".. msg ;
  -- do not call direct, as the bnfriend invite may not be completed yet
  oq.timer_oneshot( 3.5, oq.realid_msg, r.name, r.realm, r.realid, m ) ;
  oq.timer_oneshot( 4.0, oq.brief_group_lead, group_id ) ;

  oq.remove_waitlist( req_token ) ;
end

function oq.make_dropdown_03( button, req_token)
  oq.menu_create()  
  for i=1,8 do
    if ((oq.raid.group[i].member[1] == nil) or (oq.raid.group[i].member[1].name == nil) or (oq.raid.group[i].member[1].name == "-")) then
      oq.menu_add( "group ".. i, 
                   tostring(i), 
                   req_token, 
                   nil, 
                   function(self,arg1,arg2) oq.invite_group_leader( arg2, arg1 ) ; return true ; end
                 ) ;

    end
  end
  oq.menu_show( button, "TOPLEFT", 2, -25, "BOTTOMLEFT", button:GetWidth()+10 ) ;
end

function oq.first_slot_in_group( g_id )
  if (g_id < 1) or (g_id > 8) then
    return ;
  end
  for i=1,5 do
    local mem = oq.raid.group[g_id].member[i] ;
    if ((mem == nil) or (mem.name == nil) or (mem.name == "-")) then
      mem.charm = 0 ;
      mem.check = OQ.FLAG_CLEAR ;
      return i ;
    end
  end
end

function oq.make_dropdown_04( button, req_token )
  oq.menu_create()  
  for i=1,8 do
    local slot = oq.first_slot_in_group( i ) ;
    if (slot) then
      oq.menu_add( "group ".. i, 
                   tostring(i), 
                   req_token, 
                   nil, 
                   function(self,arg1,arg2) oq.group_invite_first_slot_in( arg2, arg1 ) ; return true ; end
                 ) ;
    end
  end
  oq.menu_show( button, "TOPLEFT", 2, -25, "BOTTOMLEFT", button:GetWidth()+10 ) ;
end

--
-- name to whisper.  could be real-id, could be on leader's realm
--
function oq.on_remove( g_id, slot )
  -- remove from cell
  g_id = tonumber( g_id ) ;
  slot = tonumber( slot ) ;
  if ((my_group == g_id) and (my_slot == slot)) then
    -- remove myself
    oq.quit_raid_now() ;
    if (slot ~= 1) then
      LeaveParty() ;
    end
  elseif ((my_group == g_id) and (my_slot == 1)) then
    -- OQ leader asking me, the group lead, to kick someone
    local mem = oq.raid.group[g_id].member[slot] ;
    local n = mem.name ;
    if (player_realm ~= mem.realm) then
      n = n .."-".. mem.realm ;
    end
    -- requires a hardware event since 3.3.5... won't work and would produce a lua violation error
--      UninviteUnit( n ) ;
  elseif (slot == 1) then
    -- removing group lead, which removes entire group
    oq.on_remove_group( g_id ) ;
  end
end

function oq.on_remove_group( g_id )
  -- msg ok, remove group
  g_id = tonumber(g_id) ;
  if (my_group == g_id) then
    -- leave raid
    oq.quit_raid_now() ;
  else
    -- clear out group
    for i=1,5 do
      oq.raid_cleanup_slot( g_id, i ) ;
    end
  end  
end

function oq.on_new_lead( raid_token, name, realm, rid ) 
  if (raid_token == nil) or (raid_token ~= oq.raid.raid_token) then
    return ;
  end
  if (name == player_name) then
    -- i am the new oq leader
  elseif (my_slot == 1) then
    -- send real-id request if needed
  end
  -- update oq leader info
  oq.raid.leader       = name ;
  oq.raid.leader_realm = realm ;
  oq.raid.leader_rid   = rid ;
end

function oq.new_oq_leader( name, realm, rid ) 
  oq.raid_announce( "new_lead,"..
                    oq.raid.raid_token ..","..
                    name ..","..  
                    realm ..","..  
                    tostring(rid or "")
                  ) ;
end

function oq.remove_member( g_id, slot ) 
  if (not oq.iam_raid_leader()) then
    return ;
  end
  oq.raid_announce( "remove,"..
                    g_id ..","..
                    slot 
                  ) ;
  if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
    local m = oq.raid.group[ g_id ].member[ slot ] ;
    local n = m.name ;
    if (m.realm ~= player_realm) then
      n = n .."-".. m.realm ;
    end
    UninviteUnit( n ) ;
  end
  -- incase the slot if a group lead that is offline
  oq.on_remove( g_id, slot ) ;
end

function oq.member_left( g_id, slot ) 
  oq.raid_cleanup_slot( g_id, slot ) ;
end

function oq.group_left( g_id )
  oq.on_remove_group( g_id ) ;
end

function oq.remove_group( g_id ) 
  if (not oq.iam_raid_leader()) then
    return ;
  end
  -- cannot remove main group; disband raid to remove the main group
  if (g_id == 1) then
    return ;
  end
  oq.raid_announce( "remove_group,".. g_id ) ;
  oq.on_remove_group( g_id ) ;
end

function oq.on_classdot_enter( self )
  local gid  = self.gid ;
  local slot = self.slot ;
  if (gid == nil) or (slot == nil) then
    return ;
  end
  if (oq.raid.group[gid] == nil) or (oq.raid.group[gid].member[slot] == nil) then
    return ;
  end
  --
  -- generate tooltip 
  -- 
  local m = oq.raid.group[gid].member[slot] ;
  if ((m == nil) or (m.name == nil) or (m.name == "-")) then
    return ;
  end
  oq.tooltip_set2( self, m, nil, ((gid == 1) and (slot == 1)) ) ;
end

function oq.on_classdot_exit( self )
  oq.tooltip_hide() ;
end

function oq.on_ladderdot_enter( self )
  local gid  = self.gid ;
  local slot = self.slot ;
print( "[on_ladderdot_enter] ".. gid .." . ".. slot ) ;
  --
  -- generate tooltip 
  -- 
  local m = oq.raid.group[gid].member[slot] ;
  if ((m == nil) or (m.name == nil) or (m.name == "-")) then
    return ;
  end
  oq.tooltip_set2( self, m ) ;
end

function oq.on_ladderdot_exit( self )
  oq.tooltip_hide() ;
end

function oq.btag_link( desc, name, realm, btag ) 
  local str = "|cFF808080".. 
              desc ..
              "|r |Hbtag:".. 
              tostring(strlower(btag or "")) ..
              ":".. utc_time() ..
              "|h".. 
              tostring(name or "") .."-".. tostring(realm or "") ..
              "|h" ;
  return str ;
end

function oq.btag_link2( desc, name, realm, btag )
  local str = "|Hbtag:".. 
              tostring(strlower(btag)) ..
              ":".. utc_time() ..
              "|h".. 
              tostring(name) .."-".. tostring(realm) ..
              " |cFF808080"..
              desc ..
              "|r |h" ;
  return str ;
end

function oq.on_btag( name, realm_id, rid )
  _ok2relay = 1 ;
  realm_id = tonumber(realm_id) ;
  local loname = strlower(name) ;
  local realm  = oq.realm_uncooked(realm_id) ;
  for i=1,8 do
   if (oq.raid.group[i]) then
      for j=1,5 do
        if (oq.raid.group[i].member) then
          local p = oq.raid.group[i].member[j] ;
          p.name, p.realm_id, p.realm = oq.name_sanity( p.name, p.realm_id ) ;
          
          if (p) and (p.name) and (strlower(p.name) == loname) and (p.realm_id) and (p.realm_id == realm_id) and (rid) then
            p.name, p.realm_id, p.realm = oq.name_sanity( name, realm_id ) ;
            p.realid   = strlower(rid) ;
            return ;
          end
--          if (p) and (p.name) and (p.name == name) and (p.realm) and (p.realm == realm) and (p.realid ~= rid) and (rid) then
--            oq.set_group_member( i, j, p.name, p.realm, p.class, strlower(rid), "0", "0" ) ;
--            return ;
--          end
        end
      end
    end
  end
end

function oq.send_my_btag_to_raid()
  if (my_group == 0) or (my_slot == 0) then
    return ;
  end
  if (player_realid == nil) then
    oq.get_battle_tag() ;
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  if ((player_realid == nil) or (player_realm == nil)) then
    return ;
  end
  oq.raid_announce( "btag,".. player_name ..",".. oq.realm_cooked(player_realm) ..",".. player_realid ) ;
end

function oq.on_need_btag( name, realm )
  _ok2relay = 1 ;
  if (name == player_name) and (realm == player_realm) and (player_realid ~= nil) then
    oq._sender = nil ; -- clear to allow it to be sent
    oq.raid_announce( "btag,".. player_name ..",".. oq.realm_cooked(player_realm) ..",".. player_realid ) ;
  end
end

function oq.on_classdot_promote( g_id, slot )
  -- promote to group lead
  local m1 = oq.raid.group[g_id].member[1] ;
  local m2 = oq.raid.group[g_id].member[slot] ;
  local req_token = "Q".. oq.token_gen() ;
  oq.token_push( req_token ) ;  -- hang onto it for return
  if (m2.realid == nil) or (m2.realid == "") then
    print( OQ_REDX_ICON .."".. OQ.NOBTAG_01 ) ;
    print( OQ_REDX_ICON .."".. OQ.NOBTAG_02 ) ;
    return ;
  end

  if (g_id == 1) then
    -- push as new oq-leader
    oq.new_oq_leader( m2.name, m2.realm, m2.realid ) ;
    -- need to manually push the promote
    oq.raid_announce( "promote,"..
                      g_id ..","..  
                      m2.name ..","..
                      m2.realm ..","..
                      tostring(m2.realid) ..","..
                      tostring(m2.realm) ..","..
                      req_token
                    ) ;
    oq.on_promote( g_id, m2.name, m2.realm, m2.realid, m2.realm, req_token ) ;
    oq.ui_player() ;
  else
    oq.raid_announce( "promote,"..
                      g_id ..","..  
                      m2.name ..","..
                      m2.realm ..","..
                      player_realid ..","..
                      player_realm ..","..
                      req_token
                    ) ;
  end
  -- update info
  oq.set_group_lead( g_id, m2.name, m2.realm, m2.class, m2.realid ) ;
  oq.set_name      ( g_id, slot, m1.name, m1.realm, m1.class, m1.realid ) ;
end

function oq.is_my_toon( name, realm )
  if (realm ~= player_realm) then
    return nil ;
  end
  name = strlower(name) ;
  for i,v in pairs(OQ_toon.my_toons) do
    if (name == strlower(v.name)) then
      return true ;
    end
  end
  return nil ;
end

function oq.on_classdot_menu_select( g_id, slot, action ) 
  if (action == "promote") then
    local p = oq.raid.group[g_id].member[slot] ;
    if (oq.is_my_toon( p.name, p.realm )) then
      p.realid = player_realid ;
    end
    if (p.realid == nil) or (p.realid == "") then
      -- delay to allow btag to be delivered
      oq.timer_oneshot( 2, oq.on_classdot_promote, g_id, slot ) ;
    else
      oq.on_classdot_promote( g_id, slot ) ;
    end
  elseif (action == "ban") then
    local m = oq.raid.group[ tonumber(g_id) ].member[ tonumber(slot) ] ;
    local dialog = StaticPopup_Show("OQ_BanUser", m.realid) ;
    if (dialog ~= nil) then
      dialog.data2 = { flag = 1, gid = g_id, slot_ = slot } ;
    end
  elseif (action == "upvote") then
    oq.karma_vote( g_id, slot, 1 ) ;
  elseif (action == "dnvote") then
    oq.karma_vote( g_id, slot, -1 ) ;
  elseif (action == "kick") then
    oq.remove_member( g_id, slot ) ;
  elseif (type(action) == "number") then
    oq.leader_set_charm( g_id, slot, action ) ;
  end
end

OQ.karma_up = "|TInterface\\BUTTONS\\UI-Scrollbar-ScrollUpButton-Up.blp:22:22:0:0:20:24:0:18:0:18|t";
OQ.karma_dn = "|TInterface\\BUTTONS\\UI-Scrollbar-ScrollDownButton-Up.blp:22:22:0:0:20:24:0:18:0:18|t";

local _dropdown_options = { { val = "promote", f = 0x10, msg = OQ.DD_PROMOTE }, 
                    { val = "spacer" , f = 0x10, msg = "---------------", notClickable = 1 },
                    { val = 1        , f = 0x04, msg = OQ_STAR_ICON       .."  ".. OQ.DD_STAR     },
                    { val = 2        , f = 0x04, msg = OQ_CIRCLE_ICON     .."  ".. OQ.DD_CIRCLE   },
                    { val = 3        , f = 0x04, msg = OQ_BIGDIAMOND_ICON .."  ".. OQ.DD_DIAMOND  },
                    { val = 4        , f = 0x04, msg = OQ_TRIANGLE_ICON   .."  ".. OQ.DD_TRIANGLE },
                    { val = 5        , f = 0x04, msg = OQ_MOON_ICON       .."  ".. OQ.DD_MOON     },
                    { val = 6        , f = 0x04, msg = OQ_SQUARE_ICON     .."  ".. OQ.DD_SQUARE   },
                    { val = 7        , f = 0x04, msg = OQ_REDX_ICON       .."  ".. OQ.DD_REDX     },
                    { val = 8        , f = 0x04, msg = OQ_SKULL_ICON      .."  ".. OQ.DD_SKULL    },
                    { val = 0        , f = 0x04, msg = OQ.DD_NONE },
                    { val = "spacer2", f = 0x20, msg = "---------------", notClickable = 1 },
                    { val = "upvote" , f = 0x08, msg = OQ.TT_KARMA ..":  ".. OQ.karma_up .."  ".. OQ.UP    },
                    { val = "dnvote" , f = 0x08, msg = OQ.TT_KARMA ..":  ".. OQ.karma_dn .."  ".. OQ.DOWN  },
                    { val = "spacer3", f = 0x08, msg = "---------------", notClickable = 1 },
                    { val = "kick"   , f = 0x20, msg = OQ.DD_KICK }, 
                    { val = "ban"    , f = 0x08, msg = OQ.DD_BAN }, 
                  } ;
function oq.make_classdot_dropdown(cell)
  local options = _dropdown_options ;
  local mask = 0x01 ; -- member
  if (my_slot == 1) then  
    mask = mask + 0x02 ;  -- group leader
  end
  if (my_group == 1) and (my_slot == 1) then
    mask = mask + 0x04 ; -- oq leader
    if (cell.slot ~= 1) then
      mask = mask + 0x10 ;  -- NOT group leader
    end
    if (my_group ~= cell.gid) or (my_slot ~= cell.slot) then
      mask = mask + 0x20 ; -- i'm OQ leader but not clicking on my cell
    end
  end  
  if (my_group ~= cell.gid) or (my_slot ~= cell.slot) then
    mask = mask + 0x08 ; -- not my cell
  end

  oq.menu_create()  
  for i,v in pairs(options) do
    if (oq.is_set( v.f, mask )) then
      local func = nil ;
      if (v.notClickable == nil) then
        func = function(self,arg1,arg2) oq.on_classdot_menu_select( arg2.gid, arg2.slot, arg1 ) ; return true ; end ;
      end
      oq.menu_add( v.msg, v.val, cell, nil, func ) ;
    end
  end  
  oq.menu_show( cell, "TOPLEFT", 30, -25, "BOTTOMLEFT", 160 ) ;

  local p = oq.raid.group[cell.gid].member[cell.slot] ;
  if ((p.realid == nil) or (p.realid == "")) and (p.name ~= nil) and (p.realm ~= nil) then
    oq._sender = nil ;
    oq.raid_announce( "need_btag,"..
                      p.name ..","..
                      p.realm 
                    ) ;
  end
end

function oq.cell_occupied( g_id, slot )
  if (oq.raid.group[ g_id ] == nil) or (oq.raid.group[ g_id ].member[slot] == nil) then
    return nil ;
  end
  local m = oq.raid.group[ g_id ].member[ slot ] ;
  if ((m == nil) or (m.name == nil) or (m.name == "") or (m.name == "-")) then
    return nil ;
  end
  return true ;
end

function oq.my_cell( gid, slot )
  return ((my_group == gid) and (my_slot == slot)) ;
end

function oq.on_classdot_click( cell, frame ) 
  if (oq.iam_raid_leader() and oq.cell_occupied( cell.gid, cell.slot )) then
    cell:SetPoint("Center", UIParent, "Center") ;
    oq.make_classdot_dropdown(cell) ;
    cell:SetHeight(cell.cy) ; -- forcing hieght; EasyMenu seems to resize the cell for some reason
  elseif oq.cell_occupied( cell.gid, cell.slot ) and not oq.my_cell(cell.gid, cell.slot) then
    cell:SetPoint("Center", UIParent, "Center") ;
    oq.make_classdot_dropdown(cell) ;
    cell:SetHeight(cell.cy) ; -- forcing hieght; EasyMenu seems to resize the cell for some reason
  end
end

function oq.create_class_dot( parent, x, y, cx, cy ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "DotRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, cx, cy ) ;
  local val = 5 ;

  f.cy = cy ;

  f.gid  = 0 ;
  f.slot = 0 ;
  n = "DotTexture".. oq.nthings ;
  f.texture:SetAllPoints(f) ;
  f.texture:SetTexture( 0.2, 0.2, 0.0, 1 ) ;

  -- deserter 
  f.status = f:CreateTexture(n .. "Deserter", "OVERLAY" ) ;
  f.status:SetPoint("TOPLEFT", f,"TOPLEFT", 2, -3) ;
  f.status:SetPoint("BOTTOMRIGHT", f,"BOTTOMRIGHT", -2, 3) ;
  f.status:SetTexture( nil ) ;

  -- class
  f.class = f:CreateTexture(n .. "Class", "OVERLAY" ) ;
  f.class:SetPoint("TOPLEFT", f,"CENTER", -8, -8) ;
  f.class:SetPoint("BOTTOMRIGHT", f,"CENTER", 8, 8) ;
  f.class:SetTexture( nil ) ;

  -- role
  f.role = f:CreateTexture(n .. "Role", "OVERLAY" ) ;
  f.role:SetPoint("TOPLEFT", f,"BOTTOMRIGHT", -14, 14) ;
  f.role:SetPoint("BOTTOMRIGHT", f,"BOTTOMRIGHT", 4, -4) ;
  f.role:SetTexture( nil ) ;
  
  -- lucky charm
  f.charm = f:CreateTexture(n .. "Charm", "OVERLAY" ) ;
  f.charm:SetPoint("TOPLEFT", f,"TOPLEFT", -3, 3 ) ;
  f.charm:SetPoint("BOTTOMRIGHT", f,"BOTTOMRIGHT", -15, 15) ;
  f.charm:SetTexture( nil ) ;

  -- add tooltip event handler 
  --
  f:SetScript("OnEnter", function(self, ...) oq.on_classdot_enter(self) ; end ) ;
  f:SetScript("OnLeave", function(self, ...) oq.on_classdot_exit (self) ; end ) ;

--  f:SetScript( "OnMouseDown", function(self, frame)  
  f:SetScript( "OnMouseUp", function(self, frame)  
                                oq.on_classdot_click( self, frame ) ;
                              end  
             ) ;

  oq.moveto( f, x, y ) ;
  f:SetSize( cx, cy ) ;
  f:Show() ;
  return f ;
end

function oq.create_dungeon_dot( parent, x, y, cx, cy ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "DotRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, cx, cy ) ;
  local val = 5 ;

  f.cy = cy ;

  f.gid  = 0 ;
  f.slot = 0 ;
  n = "DotTexture".. oq.nthings ;
  f.texture:SetAllPoints(f) ;
  f.texture:SetTexture( 0.2, 0.2, 0.0, 1 ) ;

  -- status
  f.status = f:CreateTexture(n .. "Deserter", "OVERLAY" ) ;
  f.status:SetPoint("TOPLEFT", f,"BOTTOMRIGHT", -25, 16) ;
  f.status:SetPoint("BOTTOMRIGHT", f,"BOTTOMRIGHT", -1, -8) ;

  f.status:SetTexture( nil ) ;

  -- class
  f.class = f:CreateTexture(n .. "Class", "OVERLAY" ) ;
  f.class:SetPoint("TOPLEFT", f,"TOPLEFT", -17, -12) ;
  f.class:SetPoint("BOTTOMRIGHT", f,"TOPLEFT", -1, -28) ;
  f.class:SetTexture( nil ) ;

  -- role
  f.role = f:CreateTexture(n .. "Role", "OVERLAY" ) ;
  f.role:SetPoint("TOPLEFT", f,"BOTTOMLEFT", 1, 14) ;
  f.role:SetPoint("BOTTOMRIGHT", f,"BOTTOMLEFT", 17, -4) ;
  f.role:SetTexture( nil ) ;
  
  -- lucky charm
  f.charm = f:CreateTexture(n .. "Charm", "OVERLAY" ) ;
  f.charm:SetPoint("TOPLEFT", f,"BOTTOMLEFT", 19, 14) ;
  f.charm:SetPoint("BOTTOMRIGHT", f,"BOTTOMLEFT", 35, -2) ;
  f.charm:SetTexture( nil ) ;

  -- add tooltip event handler 
  --
  f:SetScript("OnEnter", function(self, ...) oq.on_classdot_enter(self) ; end ) ;
  f:SetScript("OnLeave", function(self, ...) oq.on_classdot_exit (self) ; end ) ;

  f:SetScript( "OnMouseDown", function(self, frame)  
                                oq.on_classdot_click( self, frame ) ;
                              end  
             ) ;

  oq.moveto( f, x, y ) ;
  f:SetSize( cx, cy ) ;
  f:Show() ;
  return f ;
end

function oq.create_challenge_dot( parent, x, y, cx, cy ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "DotRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, cx, cy ) ;
  local val = 5 ;

  f.cy = cy ;

  f.gid  = 0 ;
  f.slot = 0 ;
  n = "DotTexture".. oq.nthings ;
  f.texture:SetAllPoints(f) ;
  f.texture:SetTexture( 0.2, 0.2, 0.0, 1 ) ;

  -- status
  f.status = f:CreateTexture(n .. "Deserter", "OVERLAY" ) ;
  f.status:SetPoint("TOPLEFT", f,"BOTTOMRIGHT", -25, 16) ;
  f.status:SetPoint("BOTTOMRIGHT", f,"BOTTOMRIGHT", -1, -8) ;

  f.status:SetTexture( nil ) ;

  -- class
  f.class = f:CreateTexture(n .. "Class", "OVERLAY" ) ;
  f.class:SetPoint("TOPLEFT", f,"TOPLEFT", -17, -12) ;
  f.class:SetPoint("BOTTOMRIGHT", f,"TOPLEFT", -1, -28) ;
  f.class:SetTexture( nil ) ;

  -- role
  f.role = f:CreateTexture(n .. "Role", "OVERLAY" ) ;
  f.role:SetPoint("TOPLEFT", f,"BOTTOMLEFT", 1, 14) ;
  f.role:SetPoint("BOTTOMRIGHT", f,"BOTTOMLEFT", 17, -4) ;
  f.role:SetTexture( nil ) ;
  
  -- lucky charm
  f.charm = f:CreateTexture(n .. "Charm", "OVERLAY" ) ;
  f.charm:SetPoint("TOPLEFT", f,"BOTTOMLEFT", 19, 14) ;
  f.charm:SetPoint("BOTTOMRIGHT", f,"BOTTOMLEFT", 35, -2) ;
  f.charm:SetTexture( nil ) ;

  -- add tooltip event handler 
  --
  f:SetScript("OnEnter", function(self, ...) oq.on_classdot_enter(self) ; end ) ;
  f:SetScript("OnLeave", function(self, ...) oq.on_classdot_exit (self) ; end ) ;

  f:SetScript( "OnMouseDown", function(self, frame)  
                                oq.on_classdot_click( self, frame ) ;
                              end  
             ) ;

  oq.moveto( f, x, y ) ;
  f:SetSize( cx, cy ) ;
  f:Show() ;
  return f ;
end

function oq.on_ladderdot_click( cell, frame ) 
  if (oq.iam_raid_leader() and oq.cell_occupied( cell.gid, cell.slot )) then
    cell:SetPoint("Center", UIParent, "Center") ;
    oq.make_classdot_dropdown(cell) ;
    cell:SetHeight(cell.cy) ; -- forcing hieght; EasyMenu seems to resize the cell for some reason
  elseif oq.cell_occupied( cell.gid, cell.slot ) and not oq.my_cell(cell.gid, cell.slot) then
    cell:SetPoint("Center", UIParent, "Center") ;
    oq.make_classdot_dropdown(cell) ;
    cell:SetHeight(cell.cy) ; -- forcing hieght; EasyMenu seems to resize the cell for some reason
  end
end

function oq.create_ladder_dot( parent, x, y, cx, cy ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "DotRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, cx, cy ) ;
  local val = 5 ;

  f.cy = cy ;

  f.gid  = 0 ;
  f.slot = 0 ;
  n = "DotTexture".. oq.nthings ;
  f.texture:SetAllPoints(f) ;
  f.texture:SetTexture( 0.2, 0.2, 0.0, 1 ) ;

  -- status
  f.status = f:CreateTexture(n .. "Deserter", "OVERLAY" ) ;
  f.status:SetPoint("TOPLEFT", f,"BOTTOMRIGHT", -25, 16) ;
  f.status:SetPoint("BOTTOMRIGHT", f,"BOTTOMRIGHT", -1, -8) ;

  f.status:SetTexture( nil ) ;

  -- class
  f.class = f:CreateTexture(n .. "Class", "OVERLAY" ) ;
  f.class:SetPoint("TOPLEFT", f,"TOPLEFT", -17, -12) ;
  f.class:SetPoint("BOTTOMRIGHT", f,"TOPLEFT", -1, -28) ;
  f.class:SetTexture( nil ) ;

  -- role
  f.role = f:CreateTexture(n .. "Role", "OVERLAY" ) ;
  f.role:SetPoint("TOPLEFT", f,"BOTTOMLEFT", 1, 14) ;
  f.role:SetPoint("BOTTOMRIGHT", f,"BOTTOMLEFT", 17, -4) ;
  f.role:SetTexture( nil ) ;
  
  -- lucky charm
  f.charm = f:CreateTexture(n .. "Charm", "OVERLAY" ) ;
  f.charm:SetPoint("TOPLEFT", f,"BOTTOMLEFT", 19, 14) ;
  f.charm:SetPoint("BOTTOMRIGHT", f,"BOTTOMLEFT", 35, -2) ;
  f.charm:SetTexture( nil ) ;

  -- add tooltip event handler 
  --
  f.on_dot_enter = oq.on_ladderdot_enter ;
  f.on_dot_exit  = oq.on_ladderdot_exit ;
  f.on_dot_click = oq.on_ladderdot_click ;
  f:SetScript("OnEnter", function(self, ...) self.on_dot_enter(self) ; end ) ;
  f:SetScript("OnLeave", function(self, ...) self.on_dot_exit (self) ; end ) ;

  f:SetScript( "OnMouseDown", function(self, frame)  
                                self.on_dot_click( self, frame ) ;
                              end  
             ) ;

  oq.moveto( f, x, y ) ;
  f:SetSize( cx, cy ) ;
  f:Show() ;
  return f ;
end

function oq.create_ladder_seat( parent, x, y, cx, cy ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "DotRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, cx, cy ) ;

  f.cy = cy ;

  f.ndx  = 0 ;
  n = "DotTexture".. oq.nthings ;
  f.texture:SetAllPoints(f) ;
  f.texture:SetTexture( 0.2, 0.2, 0.0, 1 ) ;

  oq.moveto( f, x, y ) ;
  f:SetSize( cx, cy ) ;
  f:Show() ;
  return f ;
end

function oq.create_group( parent, x, y, cx, cy, label_cx, title, group_id ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "GroupRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, cx, cy ) ;
  local i = 1 ;

  f.texture:SetTexture( 0.0, 0.0, 0.0, 1 ) ;

  f.gid       = oq.label( f,   2, 2,  16, cy-8, title ) ;
  f.bgroup    = oq.texture(f ,16, (cy - 25)/2,  25, 25, nil ) ;
-- f.bgroup.texture:SetTexture( OQ_BGROUP_ICON["Vengeance"] ) ;

  f.realm     = oq.label( f,  50, 2,  75, cy-8, "-" ) ;
  f.realm:SetTextColor( 0.6, 0.6, 0.6 ) ;
  f.leader    = oq.label( f, 135, 2, 125, cy-8, "-" ) ;
  f.leader:SetFont(OQ.FONT, 12, "") ;
  f.lag       = oq.label( f, 135, 2, 120, cy-8, "-" ) ;
  f.lag:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;
  f.lag:SetFont(OQ.FONT, 8, "") ;
  f.lag:SetJustifyV( "BOTTOM" ) ;
  f.lag:SetJustifyH( "RIGHT" ) ;
  
  f.status = tbl.new() ;
  f.status[1] = oq.label( f, 450, 2, 100, cy-8, "-" ) ;
  f.status[2] = oq.label( f, 625, 2, 100, cy-8, "-" ) ;

  f.dtime = tbl.new() ;
  f.dtime[1] = oq.label( f, 450, 2, 100, cy, "" ) ;
  f.dtime[1]:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;
  f.dtime[1]:SetFont(OQ.FONT, 8, "") ;
  f.dtime[1]:SetJustifyV( "BOTTOM" ) ;
  f.dtime[1]:SetJustifyH( "CENTER" ) ;
  
  f.dtime[2] = oq.label( f, 625, 2, 100, cy, "" ) ;
  f.dtime[2]:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;
  f.dtime[2]:SetFont(OQ.FONT, 8, "") ;
  f.dtime[2]:SetJustifyV( "BOTTOM" ) ;
  f.dtime[2]:SetJustifyH( "CENTER" ) ;

  f.slots = tbl.new() ;
  local cx = cy-2*2 ; -- to make them square
  for i=1,5 do
    f.slots[i] = oq.create_class_dot( f, 255 + 5 + (cx+4)*(i-1), 2, cx, cy-2*2 ) ;
    f.slots[i].gid  = group_id ;
    f.slots[i].slot = i ;
  end
  f:Show() ;
  return f ;
end

function oq.create_dungeon_group( parent, x_, y_, ix, iy, label_cx, title, group_id ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "GroupRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x_, y_, ix, iy ) ;
  local i = 1 ;

  f.texture:SetTexture( 0.0, 0.0, 0.0, 1 ) ;
  f.texture:SetAllPoints( f ) ;

  local cy = iy - 2*5 ;
  local cx = floor( (ix - 4*10 - 2*10) / 5 ) ;
  
  f.gid = oq.label( f,   2, 2,  16, cy-8, title ) ;

  f.slots = tbl.new() ;
  local x = 10 ;
  for i=1,5 do
    f.slots[i] = oq.create_dungeon_dot( f, x, 5, cx, cy ) ;
    f.slots[i].gid  = group_id ;
    f.slots[i].slot = i ;
    x = x + cx + 10 ;
  end

  f:Show() ;
  return f ;
end

function oq.create_challenge_group( parent, x_, y_, ix, iy, label_cx, title, group_id ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "GroupRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x_, y_, ix, iy ) ;
  local i = 1 ;

  f.texture:SetTexture( 0.0, 0.0, 0.0, 1 ) ;
  f.texture:SetAllPoints( f ) ;

  local cy = iy - 2*5 ;
  local cx = floor( (ix - 4*10 - 2*10) / 5 ) ;
  
  f.gid = oq.label( f,   2, 2,  16, cy-8, title ) ;

  f.slots = tbl.new() ;
  local x = 10 ;
  for i=1,5 do
    f.slots[i] = oq.create_challenge_dot( f, x, 5, cx, cy ) ;
    f.slots[i].gid  = group_id ;
    f.slots[i].slot = i ;
    x = x + cx + 10 ;
  end

  f:Show() ;
  return f ;
end

function oq.create_scenario_group( parent, x, y, ix, iy, label_cx, title, group_id ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "GroupRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, ix, iy ) ;
  local i = 1 ;

  f.texture:SetTexture( 0.0, 0.0, 0.0, 1 ) ;
  f.texture:SetAllPoints( f ) ;

  local cy = iy - 2*5 ;
  local cx = floor( (ix - 4*10 - 2*10) / 5 ) ;
  
  f.gid       = oq.label( f,   2, 2,  16, cy-8, title ) ;
  f.slots = tbl.new() ;
  local x = 10 ;
  x = x + cx + 10 ; -- bump ahead one panel to center it
  for i=1,3 do
    f.slots[i] = oq.create_dungeon_dot( f, x, 5, cx, cy ) ;
    f.slots[i].gid  = group_id ;
    f.slots[i].slot = i ;
    x = x + cx + 10 ;
  end
  f:Show() ;
  return f ;
end

function oq.create_arena_group( parent, x_, y_, ix, iy, label_cx, title, group_id ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "ArenaRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x_, y_, ix, iy ) ;
  local i = 1 ;

  f.texture:SetTexture( 0.0, 0.0, 0.0, 1 ) ;
  f.texture:SetAllPoints( f ) ;

  local cy = iy - 2*5 ;
  local cx = floor( (ix - 4*10 - 2*10) / 5 ) ;
  
  f.gid = oq.label( f,   2, 2,  16, cy-8, title ) ;

  f.slots = tbl.new() ;
  local x = 10 ;
  for i=1,5 do
    f.slots[i] = oq.create_dungeon_dot( f, x, 5, cx, cy ) ;
    f.slots[i].gid  = group_id ;
    f.slots[i].slot = i ;
    x = x + cx + 10 ;
  end

  f:Show() ;
  return f ;
end

function oq.create_ladder_group( parent, x_, y_, ix, iy, label_cx, title, group_id ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local n = "LadderRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x_, y_, ix, iy ) ;
  local i = 1 ;
  local j = 1 ;

  f.texture:SetTexture( 0.0, 0.0, 0.0, 1 ) ;
  f.texture:SetAllPoints( f ) ;

  local cy = 16 ;
  local cx = 16 ;
  
  f.gid = oq.label( f,   2, 2,  16, cy-8, title ) ;

  f.slots = tbl.new() ;
  local x = 10 ;
  local y = (iy / 2) - 2 * (cy + 2) ;
  local ndx = 2 ;
  for i=1,4 do
    x = (ix / 2) - 2 * (cx + 2) ; 
    for j=1,4 do
      f.slots[ndx] = oq.create_ladder_dot( f, x, y, cx, cy ) ;
      f.slots[ndx].gid  = group_id ;
      f.slots[ndx].slot = ndx ;
      x = x + cx + 2 ;
      ndx = ndx + 1 ;
    end
    y = y + cy + 2 ;
  end

  f.slots[1] = oq.create_ladder_dot( f, (ix - cx)/2, 10, cx, cy ) ; -- referee / ladder owner
  f.slots[1].gid  = group_id ;
  f.slots[1].slot = 1 ;

  f:Show() ;
  return f ;
end

function oq.on_premade_item_enter( self )
  oq.pm_tooltip_set( self, self.token ) ;
end

function oq.on_premade_item_exit( self )
  oq.pm_tooltip_hide() ;
end

function oq.vip(btag)
  if (OQ.VIP[btag]) then
    return OQ.VIP[btag] ;
  end
  if (OQ_data.vtags) and (OQ_data.vtags[btag]) then
    local now = utc_time() ;
    if (OQ_data.vtags[btag].expires) and (now < OQ_data.vtags[btag].expires) then
      return OQ_data.vtags[btag] ;
    end
  end
  return nil ;
end

OQ.VIP = { 
           [ "tiny#1846-"            ] = { r=255/255, g=255/255, b=255/255, a=1.0, bdrop="INTERFACE/EncounterJournal/UI-EJ-BOSS-Pandemonius", 
                                      r2= 77/255, g2=  0/255, b2= 153/255, a2=0.9,
                                      x1=18/128,x2=128/128,y1=0/64,y2=64/64,
                                      left=5, top=-90, right=-30, bottom=30, 
                                    },
           [ "tiny#1846"             ] = { r= 117/255, g=  0/255, b=193/255, a=0.9, bdrop="INTERFACE/Challenges/ChallengeMode_Medal_Silver",
                                      r2= 97/255, g2=  20/255, b2= 173/255, a2=0.9,
                                      x1=0/128,x2=128/128,y1=0/128,y2=128/128,
                                      left=25, top=-40, right=-25, bottom=60,
                                      adjust_top=-30, adjust_bottom=70,
                                      nosort=nil, splat="INTERFACE/CHARACTERFRAME/BarFill",
                                    },

           [ "oathbreaker#1695"     ] = { r=255/255, g=255/255, b=200/255, a=0.9, bdrop="INTERFACE/EncounterJournal/UI-EJ-BOSS-Ragnaros", 
                                      r2= 77/255, g2=  0/255, b2= 153/255, a2=0.9,
                                      x1=18/128,x2=128/128,y1=0/64,y2=64/64,
                                      left=5, top=-90, right=-30, bottom=30, 
                                      adjust_top=-70, adjust_bottom=0,
                                      nosort=nil, splat="INTERFACE/CHARACTERFRAME/BarFill",
                                    },
           [ "oathbreaker#1308"     ] = { r=255/255, g=255/255, b=200/255, a=0.9, bdrop="INTERFACE/EncounterJournal/UI-EJ-BOSS-Ragnaros", 
                                      r2= 77/255, g2=  0/255, b2= 153/255, a2=0.9,
                                      x1=18/128,x2=128/128,y1=0/64,y2=64/64,
                                      left=5, top=-90, right=-30, bottom=30, 
                                      adjust_top=-70, adjust_bottom=0,
                                      nosort=nil, splat="INTERFACE/CHARACTERFRAME/BarFill",
                                    },
                                    
           [ "rathamus#1865"        ] = { r=255/255, g=255/255, b=255/255, a=1.0, bdrop="INTERFACE/EncounterJournal/UI-EJ-BOSS-Pyroguard Emberseer", 
                                      r2= 160/255, g2=  2/255, b2= 2/255, a2=0.9,
                                      x1=18/128,x2=128/128,y1=0/64,y2=64/64,
                                      left=5, top=-90, right=-30, bottom=30, 
                                      adjust_top=-70, adjust_bottom=0,
                                      nosort=nil, splat="INTERFACE/CHARACTERFRAME/BarFill",
                                    },

           -- golden dragons: line highlight, sorted
           [ "golden-dragon"        ] = { r=255/255, g=255/255, b=255/255, a=0.8, bdrop="INTERFACE/EncounterJournal/UI-EJ-BOSS-NefarianBWD", 
                                      r2= 128/255, g2=128/255, b2= 128/255, a2=0.9,
                                      x1=18/128,x2=128/128,y1=0/64,y2=64/64,
                                      left=5, top=-90, right=-30, bottom=30, 
                                      nosort=nil
                                    },
                                    
           -- silver dragons: line highlight, no sort           
           [ "dragona"              ] = { r=225/255, g=225/255, b=255/255, a=0.9, bdrop="INTERFACE/PetBattles/PetIcon-Dragon", 
                                      x1=0/128,x2=128/128,y1=0/256,y2=100/256,
                                      nosort=1 
                                    },
           [ "dragon"               ] = { r=255/255, g=255/255, b=255/255, a=0.5, bdrop="INTERFACE/EncounterJournal/UI-EJ-BOSS-Tsulong", 
                                      r2= 128/255, g2=128/255, b2= 64/255, a2=0.9,
                                      x1=18/128,x2=128/128,y1=0/64,y2=64/64,
                                      left=5, top=-95, right=-30, bottom=30, 
                                      nosort=1
                                    },
           -- generals: no line highlight, no sort
           [ "general-H"            ] = { r=140/255, g=  2/255, b=  2/255, a=0.9, bdrop="INTERFACE/Challenges/challenges-plat",
                                      left=25, top=-55, right=-25, bottom=45,
                                      adjust_top=-30, adjust_bottom=70,
                                      nosort=1 
                                    },
           [ "general-A"            ] = { r=  2/255, g=  80/255, b=140/255, a=0.9, bdrop="INTERFACE/Challenges/challenges-plat",
                                      left=25, top=-55, right=-25, bottom=45,
                                      adjust_top=-30, adjust_bottom=70,
                                      nosort=1 
                                    },
                                    
           -- knights: no line highlight, no sort
           [ "knight-H"             ] = { r= 128/255, g=  2/255, b=  2/255, a=0.75, bdrop="INTERFACE/Challenges/ChallengeMode_Medal_Bronze",
                                      r2= 0/255, g2=  0/255, b2=0/255, a2=0.0,
                                      left=25, top=-55, right=-25, bottom=45,
                                      adjust_top=-30, adjust_bottom=70,
                                      nosort=1 
                                    },

           [ "knight-A"             ] = { r= 2/255, g= 100/255, b= 255/255, a=0.9, bdrop="INTERFACE/Challenges/ChallengeMode_Medal_Bronze",
                                      r2= 0/255, g2=  0/255, b2=0/255, a2=0.0,
                                      left=25, top=-55, right=-25, bottom=45,
                                      adjust_top=-30, adjust_bottom=70,
                                      nosort=1 
                                    },

           -- angels and badboys: no line highlight, no sort
           [ "weanii#1434"          ] = { r= 90/255, g= 90/255, b=164/255, a=1.0, bdrop="INTERFACE/TUTORIALFRAME/UI-TUTORIALFRAME-SPIRITREZ", 
                                      r2= 90/255, g2=  90/255, b2= 200/255, a2=0.9,
                                      x1=(197-60)/512,x2=(197+60)/512,y1=0/128,y2=128/128, 
                                      left=5, top=-10, right=-5, bottom=10, 
                                      adjust_top=-20, adjust_bottom=60,
                                      nosort=nil, splat="INTERFACE/CHARACTERFRAME/BarFill",
                                    },
           ["buffy#1245"            ] = { r=209/255, g=153/255, b=166/255, a=1.0, bdrop="",
                                         r2=209/255, g2=153/255, b2=166/255, a2=0.75, 
                                         x1=18/128,x2=128/128,y1=0/64,y2=64/64,
                                         left=5, top=-90, right=-30, bottom=60, 
                                         nosort=1, splat="INTERFACE/CHARACTERFRAME/BarFill",
                                    },
           [ "gatemaster75#1240"    ] = { r= 255/255, g=  0/255, b=0/255, a=1.0, bdrop="INTERFACE/ARCHEOLOGY/ArchRare-TrollVoodooDoll",
                                      r2= 220/255, g2=  0/255, b2=0/255, a2=0.6,
                                      x1=170/512,x2=370/512,y1=0/256,y2=256/256,
                                      left=50, top=-50, right=-50, bottom=50, 
                                      adjust_top=-30, adjust_bottom=60,
                                      nosort=1, splat="INTERFACE/CHARACTERFRAME/BarFill", nohilight=1,
                                    },
         } ;

OQ.patterns = 
  {
    [0] = { r= 2/255, g= 100/255, b= 255/255, a=0.9, bdrop=nil,
            r2= 0/255, g2=  0/255, b2=0/255, a2=0.0,
            left=25, top=-55, right=-25, bottom=45,
            adjust_top=-30, adjust_bottom=70, nosort=1 
          },
  } ;

function oq.process_vlist(vlist)
  if (vlist == nil) then
    return ;
  end
  local n = #vlist / 2 ;
  if (n == 0) then
    return ;
  end
  for i=1,n do
    oq.req_vlist( oq.decode_mime64_digits( vlist:sub( i*2-1, i*2 ))) ;
  end
end

function oq.req_vlist(id)
  if (id == nil) or (id == 0) then
    return ;
  end
  if (OQ_data.vlist == nil) then
    OQ_data.vlist = {} ;
  end
  if (OQ_data.vlistq == nil) then
    OQ_data.vlistq = {} ;
  end
  local now = utc_time() ;
  if (OQ_data.vlist[id] == nil) or (OQ_data.vlist[id] < now) then
    -- queue it up
    table.insert( OQ_data.vlistq, id ) ;
    if (not oq.is_timer("chk_vlist")) then
      oq.timer( "chk_vlist", OQ.CHK_VLIST_TM, oq.chk_vlistq, true ) ;
    end
  end
end

function oq.chk_vlistq()
  if (OQ_data.vlistq == nil) then
    return ;
  end
  local now = utc_time() ;
  if (OQ_data.vlistq_last) and ((now - OQ_data.vlistq_last) < OQ.CHK_VLIST_TM) then
    return ;
  end
  OQ_data.vlistq_last = now ;
  local id = table.remove( OQ_data.vlistq, 1 ) ;
  if (id == nil) then
    oq.timer( "chk_vlist", OQ.CHK_VLIST_TM, nil ) ;
    return ;
  end
  
  oq.send_req_vlist( id ) ;
end

function oq.send_req_vlist(id)
  if (id == nil) or (id == 0) then
    return ;
  end
  local now = utc_time() ;
  if (OQ_data.vlist[id]) and (OQ_data.vlist[id] > now) then
    return ;
  end
  
  local submit_token = "S".. oq.token_gen() ;
  oq.token_push( submit_token ) ;
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "req_vlist,"..
              tostring(player_realid) ..","..
              submit_token ..","..
              oq.encode_mime64_2digit(id) ;
  oq.send_to_scorekeeper( msg ) ;
end

local _vlist = {} ;
function oq.on_vlist(token, id, expiration, vlist)
  if (OQ_data.vlist == nil) then
    OQ_data.vlist = {} ;
  end
  if (not oq.is_my_req_token( token )) then
    return ;
  end
  id = oq.decode_mime64_digits(id) ;
  if (id == nil) or (id == 0) then
    return ;
  end
  expiration = oq.decode_mime64_digits(expiration) ;
  if (expiration == nil) or (expiration == 0) then
    return ;
  end
  -- parse
  OQ_data.vlist[id] = expiration ;
  local v ;
  local i = 0 ;
  tbl.clear(_vlist) ;
  for v in string.gmatch(vlist, "([^.]+)") do
    i = i + 1 ;
    _vlist[i] = v ;
  end
  
  if (OQ_data.vtags == nil) then
    OQ_data.vtags = {} ;
  end
  
  for i,v in pairs(_vlist) do
    local ndx   = oq.decode_mime64_digits(v:sub(5,5)) ;
    local nosrt = nil ;
    local btag  = v:sub(6,-1) ;
    if (v:sub(4,4) == '1') then
      nosrt = 1 ;
    end
    if (OQ_data.vtags[btag]) then
      OQ_data.vtags[btag] = tbl.delete( OQ_data.vtags[btag] ) ;
    end
    if (OQ.patterns[ndx]) then
      OQ_data.vtags[btag] = copyTable( OQ.patterns[ndx] ) ;
      OQ_data.vtags[btag] = { r = (oq.decode_mime64_digits(v:sub(1,1)) * 4)/255, 
                              g = (oq.decode_mime64_digits(v:sub(2,2)) * 4)/255, 
                              b = (oq.decode_mime64_digits(v:sub(3,3)) * 4)/255, 
                              nosort = nosrt,
                              expires = expiration,
                            } ;
    end
  end
end

function oq.vip_clear( f )
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                 edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                 tile=true, tileSize = 16, edgeSize = 16,
                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
                })
  if (f.emphasis_texture ~= nil) then
    f.emphasis_texture:SetTexture( "" ) ;
    f.emphasis_texture:SetVertexColor( 0,0,0 ) ;
    f.emphasis_texture:SetTexCoord( 0,1,0,1 ) ;
    f.emphasis_texture:SetPoint( "TOPLEFT"    , f, "TOPLEFT"    ,  10, -10 ) ;
    f.emphasis_texture:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", -10,  10 ) ;
  end
  if (f.splat ~= nil) then
    f.splat:SetTexture("") ;
    f.splat:SetVertexColor( 0,0,0 ) ;
  end
  f:SetBackdropColor( 0,0,0 ) ;
end

function oq.vip_set( f, btag )
  if (btag) and (oq.vip(btag)) then
    local v = oq.vip(btag) ;
    f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", tile=true, tileSize = 16, edgeSize = 16,
                       insets = { left = -7, right = -8, top = 1, bottom = 0 } }) ;
    if (v.r2) and (v.nohilight == nil) then
      f:SetBackdropColor( v.r2, v.g2, v.b2, v.a2 ) ;
    elseif (v.nohilight == nil) then
      f:SetBackdropColor( v.r , v.g , v.b , v.a  ) ;
    else
      f:SetBackdropColor( 0, 0, 0, 1 ) ;
    end
    return 1 ;
  end
  f:SetBackdrop( nil ) ;
  return nil ;
end

function oq.vip_set_emphasis( f, btag, dy, is_long )
  if (btag) and (oq.vip(btag)) then
    local v = oq.vip(btag) ;
    f:SetBackdrop({ bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                   edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                   tile=nil, tileSize = 16, edgeSize = 16,
                   insets = { left = 1, right = 1, top = 1, bottom = 1 }
                  }) ;
    if (f.emphasis_texture ~= nil) then
      f.emphasis_texture:SetTexture( v.bdrop ) ;
      if (v.x1) then
        f.emphasis_texture:SetTexCoord( v.x1,v.x2,v.y1,v.y2 ) ;
      else
        f.emphasis_texture:SetTexCoord( 0,1,0,1 ) ;
      end
      if (v.top) then
        if (v.adjust_top and is_long) then
          f.emphasis_texture:SetPoint( "TOPLEFT"    , f, "TOPLEFT"    , v.left,  v.top + v.adjust_top ) ;
        else
          f.emphasis_texture:SetPoint( "TOPLEFT"    , f, "TOPLEFT"    , v.left,  v.top + (dy or 0) ) ;
        end
        if (v.adjust_bottom and is_long) then
          f.emphasis_texture:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", v.right, v.bottom + v.adjust_bottom ) ;
        else
          f.emphasis_texture:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", v.right, v.bottom ) ;
        end
      else
        f.emphasis_texture:SetPoint( "TOPLEFT"    , f, "TOPLEFT"    ,  10, -10 ) ;
        f.emphasis_texture:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", -10,  10 ) ;
      end
      if (v.splat) and (f.splat) then
        f.splat:SetTexture(v.splat) ;
        f.splat:SetAllPoints( f ) ;
        f.splat:SetVertexColor( v.r2, v.g2, v.b2, v.a2 ) ;
      end
      f.emphasis_texture:SetVertexColor( v.r, v.g, v.b, v.a ) ;
    end
    f:SetBackdropColor( 0, 0, 0 ) ;
    return ((v.bdrop ~= nil) and (v.splat == nil)) or 
           ((v.bdrop ~= nil) and (v.splat ~= nil)) ;
  end
  oq.vip_clear(f) ;
  return nil ;
end

function oq.vip_set_dragon( f, rank, dy, is_long ) 
  if (f == nil) or (rank == nil) or (OQ.VIP[rank] == nil) then
    return nil ;
  end
  local v = OQ.VIP[rank] ;
  f:SetBackdrop({ bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                 edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                 tile=nil, tileSize = 16, edgeSize = 16,
                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
                }) ;
  if (f.emphasis_texture ~= nil) then
    f.emphasis_texture:SetTexture( v.bdrop ) ;
    if (v.x1 ~= nil) then
      f.emphasis_texture:SetTexCoord( v.x1,v.x2,v.y1,v.y2 ) ;
    else
      f.emphasis_texture:SetTexCoord( 0,1,0,1 ) ;
    end
    
    if (v.top) then
      if (v.adjust_top and is_long) then
        f.emphasis_texture:SetPoint( "TOPLEFT"    , f, "TOPLEFT"    , v.left,  v.top + v.adjust_top ) ;
      else
        f.emphasis_texture:SetPoint( "TOPLEFT"    , f, "TOPLEFT"    , v.left,  v.top + (dy or 0) ) ;
      end
      if (v.adjust_bottom and is_long) then
        f.emphasis_texture:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", v.right, v.bottom + v.adjust_bottom ) ;
      else
        f.emphasis_texture:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", v.right, v.bottom ) ;
      end
    else
      f.emphasis_texture:SetPoint( "TOPLEFT"    , f, "TOPLEFT"    ,  10, -10 ) ;
      f.emphasis_texture:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", -10,  10 ) ;
    end
    f.emphasis_texture:SetVertexColor( v.r, v.g, v.b, v.a ) ;
  end
  f:SetBackdropColor( 0, 0, 0 ) ;
  return 1 ;
end

function oq.premade_vip_check( f, token, emphasis )
  if (oq.premades[ token ] == nil) then
    return nil ;
  end
  if (emphasis) then
    return oq.vip_set_emphasis( f, strlower(oq.premades[ token ].leader_rid) ) ;
  else
    return oq.vip_set( f, strlower(oq.premades[ token ].leader_rid) ) ;
  end
end

function oq.waitlist_vip_check( f, token, emphasis )
  if (oq.waitlist[ token ] == nil) then
    return nil ;
  end
  if (emphasis) then
    return oq.vip_set_emphasis( f, strlower(oq.waitlist[ token ].realid) ) ;
  else
    return oq.vip_set( f, strlower(oq.waitlist[ token ].realid) ) ;
  end
end

function oq.create_raid_listing( parent, x, y, cx, cy, token, type ) 
  oq.nlistings = oq.nlistings + 1 ;
  local i = 1 ;
  local n = "ListingRegion".. oq.nlistings ;
  local f = oq.panel( parent, n, x, y, cx, cy, true ) ;
--  f:SetFrameLevel( parent:GetFrameLevel() + 10 ) ;

  oq.premade_vip_check( f, token ) ;

  f.cy = cy ;
  f.token = token ;
--  f.texture:SetTexture( 0.0, 0.0, 0.0, 1 ) ;
--  f:SetFrameStrata( "LOW" ) ;

  local x2 = 0 ;
  f.raid_name = oq.label  ( f, x2, 2, 175, cy, ""  ) ;  x2 = x2 + 185 ;
  f.raid_name:SetFont(OQ.FONT, 11, "") ;

  -- 
  -- dragon
  --
  local d = oq.CreateFrame("FRAME", "OQListing".. oq.nlistings .."Dragon", f ) ;
  d:SetBackdropColor(0.8,0.8,0.8,1.0) ;
  oq.setpos( d, x2-16, 0, 32, 32 ) ;
  local t = d:CreateTexture( nil, "OVERLAY" ) ;
  t:SetTexture( nil ) ;
  t:SetAllPoints(d) ;
  t:SetAlpha( 1.0 ) ;
  d.texture = t ;
  d:Show() ;
  f.dragon = d ;

  f.leader    = oq.label  ( f, x2, 2,  90, cy, ""  ) ;  x2 = x2 +  90 ;
  f.leader:SetFont( OQ.FONT, 11, "" ) ;
  f.leader:SetTextColor( 0.9, 0.9, 0.9 ) ;
  
  f.levels    = oq.label  ( f, x2, 2,  45, cy, ""  ) ;  x2 = x2 +  45 + 2 ; -- keep these 2 lines balanced to line up
  f.min_ilvl  = oq.label  ( f, x2, 2,  40, cy, "-" ) ;  x2 = x2 +  40 - 2 ; -- keep these 2 lines balanced to line up
  f.min_resil = oq.label  ( f, x2, 2,2*48, cy, "-" ) ;  x2 = x2 +  45 ; -- extra wide for dungeon icons
  f.min_mmr   = oq.label  ( f, x2, 2,  45, cy, "-" ) ;  x2 = x2 +  45 ;
  f.zones     = oq.label  ( f, x2, 2, 140, cy, ""  ) ;  x2 = x2 + 140 ;
  f.zones:SetTextColor( 0.9, 0.9, 0.9 ) ;
  f.zones:SetFont( OQ.FONT, 10, "" ) ;
  f.has_pword = oq.texture( f, x2, 2,  24, 38, nil ) ;  x2 = x2 + 22 ;
  f.req_but   = oq.button ( f, x2, 2,  75, cy-2, OQ.BUT_WAITLIST, 
                                              function(self) 
                                                oq.get_battle_tag() ;
                                                if ((player_realid == nil) or (player_realid == "")) then
                                                  return ;
                                                else
                                                  oq.check_and_send_request( self:GetParent().token ) ;
                                                end
                                              end ) ;
  x2 = x2 +  80 ;
  f.unlist_but = oq.button( f, x2, 2,  24, cy-2, "x", 
                                              function(self,button,down) 
                                                local tok = self:GetParent().token ;
                                                if (button == "LeftButton") then
                                                  oq.send_leave_waitlist( tok ) ; 
                                                elseif (button == "RightButton") then  
                                                  local premade = oq.premades[ tok ] ;
                                                  if (premade ~= nil) then
                                                    local dialog = StaticPopup_Show("OQ_BanUser", premade.leader_rid) ;
                                                    if (dialog ~= nil) then
                                                      dialog.data2 = { flag = 4, btag = premade.leader_rid, raid_tok = tok } ;
                                                    end                                                            
                                                  end
                                                end 
                                              end ) ;
                                              
  f.unlist_but:RegisterForClicks("LeftButtonUp", "RightButtonUp") ;
  f.unlist_but.tt = OQ.TT_LEAVEPREMADE ;
  -- add tooltip event handler 
  --
  f:SetScript("OnEnter", function(self, ...) oq.on_premade_item_enter(self) ; end ) ;
  f:SetScript("OnLeave", function(self, ...) oq.on_premade_item_exit (self) ; end ) ;
                                              
  f:Show() ;
  return f ;
end

function oq.set_waitlist_tooltip( f )
  if (f ~= nil) and (f.token ~= nil) then
    oq.tooltip_set2( f, oq.waitlist[ f.token ], true ) ;
  end
end

function oq.create_waitlist_item( parent, x, y, cx, cy, token, n_members ) 
  oq.nthings = (oq.nthings or 0) + 1 ;
  local i = 1 ;
  local n = "WaitRegion".. oq.nthings ;
  local f = oq.panel( parent, n, x, y, cx, cy, true ) ;
  f:SetFrameLevel( parent:GetFrameLevel() + 10 ) ;
  f:SetScript("OnEnter", function(self, ...) oq.set_waitlist_tooltip( self ) ; end ) ;
  f:SetScript("OnLeave", function(self, ...) oq.tooltip_hide() ; end ) ;
  oq.waitlist_vip_check( f, token ) ;

  f.cy = cy ;
  f.token = token ;
  local x2 = 0 ;
  f.remove_but = oq.button( f, x2, 2,  20, cy-2, "x", function(self,button,down)  
                                                        local tok = self:GetParent().req_token ;
                                                        if (button == "LeftButton") then
                                                          oq.remove_waitlist( tok ) ; 
                                                        elseif (button == "RightButton") then  
                                                          local req = oq.waitlist[ tok ] ;
                                                          if (req ~= nil) then
                                                            local dialog = StaticPopup_Show("OQ_BanUser", req.realid) ;
                                                            if (dialog ~= nil) then
                                                              dialog.data2 = { flag = 2, btag = req.realid, req_token = tok } ;
                                                            end                                                            
                                                          end
                                                        end 
                                                      end
                           ) ;
  f.remove_but:RegisterForClicks("LeftButtonUp", "RightButtonUp") ;
  x2 = x2 + 20+4 ;                                               
  f.bgroup     = oq.texture( f, x2, (cy - 24)/2,  24, 24, nil ) ;  x2 = x2 + 30 ;
  f.role       = oq.label  ( f, x2, 5,  20, cy, ""            ) ;  x2 = x2 + 24 ;
  f.role:SetJustifyV( "middle" ) ;
  f.toon_name  = oq.label  ( f, x2, 2, 108, cy, ""            ) ;  x2 = x2 + 108 ;
  f.toon_name:SetFont(OQ.FONT, 12, "") ;
  f.realm      = oq.label  ( f, x2, 2, 100, cy, ""            ) ;  x2 = x2 + 100 ;
  f.level      = oq.label  ( f, x2, 2,  40, cy, "85"          ) ;  x2 = x2 +  40 ;
  f.ilevel     = oq.label  ( f, x2, 2,  40, cy, "395"         ) ;  x2 = x2 +  40 ;
  f.ilevel:SetTextColor( 0.9, 0.9, 0.9 ) ;
  f.resil      = oq.label  ( f, x2, 2,  40, cy, "4100"        ) ;  x2 = x2 +  40 ;
  f.pvppower   = oq.label  ( f, x2, 2,  40, cy, "99999"       ) ;  x2 = x2 +  50 ;
  f.pvppower:SetTextColor( 0.9, 0.9, 0.9 ) ;
  f.mmr        = oq.label  ( f, x2, 2,  40, cy, "1500"        ) ;  x2 = x2 +  40 ;
  x2 = x2 + 10 ; -- nudge for time
  f.nMembers   = n_members ;

  if (n_members == 1) then
    f.invite_but = oq.button( f, x2, 2,  75, cy-2, OQ.BUT_INVITE, 
                                               function(self, button, down) 
                                                oq.get_battle_tag() ;
                                                if (player_realid == nil) then
                                                  return ;
                                                else
                                                   local now = utc_time() ;
                                                   if (now < next_invite_tm) then
                                                     return ;
                                                   end
                                                   next_invite_tm = now + 4 ;
                                                   if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
                                                     if (button == "LeftButton") then
                                                       -- right button should not work, as you cannot invite directly into a group
                                                       local tok = self:GetParent().req_token ;
                                                       local g, s = oq.first_raid_slot() ;
                                                       oq.group_invite_slot( tok, g, s ) ; -- always 1,5 ... will be reassigned later
                                                     end
                                                   elseif (button == "LeftButton") then
                                                     oq.group_invite_first_available( self:GetParent().req_token ) ;
                                                   elseif (button == "RightButton") then
                                                     oq.make_dropdown_04(self, self:GetParent().req_token) ;
                                                   end
                                                end
                                               end ) ;
    f.invite_but:RegisterForClicks("LeftButtonUp", "RightButtonUp") ;
    x2 = x2 +  75 + 5 ;
    f.ginvite_but = oq.button( f, x2, 2,  75, cy-2, OQ.BUT_GROUPLEAD, 
                                               function(self) 
                                                oq.get_battle_tag() ;
                                                if (player_realid == nil) then
                                                  return ;
                                                else
                                                  local now = utc_time() ;
                                                  if (now < next_invite_tm) then
                                                    return ;
                                                  end
                                                  next_invite_tm = now + 4 ;
                                                  if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
                                                    message( OQ.NOLEADS_IN_RAID ) ;
                                                  else
                                                    oq.make_dropdown_03(self, self:GetParent().req_token) ; 
                                                  end
                                                end
                                               end ) ;
    x2 = x2 +  75 ;
  else
    --
    -- group invite button
    --
    f.invite_but = oq.button( f, x2, 2, 75*2+2, cy-2, string.format( OQ.BUT_INVITEGROUP, n_members ), 
                                               function(self) 
                                                oq.get_battle_tag() ;
                                                if (player_realid == nil) then
                                                  return ;
                                                else
                                                  local now = utc_time() ;
                                                  if (now < next_invite_tm) then
                                                    return ;
                                                  end
                                                  next_invite_tm = now + 5 ;
                                                  if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
                                                    message( OQ.NOGROUPS_IN_RAID ) ;
                                                  else
                                                    oq.group_invite_party( self:GetParent().req_token ) ;
                                                  end
                                                end
                                               end ) ;
    x2 = x2 + 75*2 + 5 ;
  end
  f.wait_tm = oq.label ( f, x2+10, 2,  70, cy, "00:00" ) ;  x2 = x2 +  50 ;
  f:Show() ;
  return f ;
end

function oq.set_class( g_id, slot, class )
  g_id = tonumber(g_id) ;
  slot = tonumber(slot) ;
  local color = OQ.CLASS_COLORS[class] ;
  oq.raid.group[g_id].member[slot].class = class ;
  
  if (color == nil) then
    color = OQ.CLASS_COLORS[ OQ.SHORT_CLASS[class] ] ;
    if (color == nil) then
      return ;
    end
  end
  if (slot == 1) then
    if (class ~= nil) and (OQ.CLASS_COLORS[class] ~= nil) then
      oq.tab1_group[g_id].leader:SetTextColor( OQ.CLASS_COLORS[class].r, OQ.CLASS_COLORS[class].g, OQ.CLASS_COLORS[class].b ) ;
    end
  end  
  if (oq.tab1_group[g_id]) and (oq.tab1_group[g_id].slots[slot]) and (oq.tab1_group[g_id].slots[slot].texture) then
    oq.tab1_group[g_id].slots[slot].texture:SetTexture( color.r, color.g, color.b, 1 ) ;
  end
end

function oq.assure_slot_exists( group_id, slot ) 
  if (group_id == 0) or (slot == 0) then
    return ;
  end
  if (oq.raid.group[group_id] == nil) then
    oq.raid.group[group_id] = tbl.new() ;
    oq.raid.group[group_id].member = tbl.new() ;
  end
  if (oq.raid.group[group_id].member == nil) then
    oq.raid.group[group_id].member = tbl.new() ;
  end
  if (oq.raid.group[group_id].member[slot] == nil) then
    oq.raid.group[group_id].member[slot] = tbl.new() ;
  end
end

function oq.set_group_member( group_id, slot, name_, realm_, class_, rid, s1, s2 )
  group_id = tonumber( group_id ) or 0 ;
  slot     = tonumber( slot ) or 0 ;
  if (group_id == 0) or (slot == 0) then
    return ;
  end
  if (name_) and (name_ == "-") then
    name_  = nil ;
    realm_ = nil ;
  end
  local realm_id = realm_ ;
  if (tonumber(realm_) ~= nil) then
    realm_ = oq.realm_uncooked(realm_) ;
  else
    realm_id = oq.realm_cooked(realm_) ;
  end
  if (class_ == nil) then
    class_ = "XX" ;
  end
  if (class_ == nil) or (class_:len() > 2) then
    class_ = OQ.SHORT_CLASS[ class_ ] or "ZZ" ;
  end
  oq.assure_slot_exists( group_id, slot ) ;
  
  local bgroup_ = oq.find_bgroup( realm_ ) ;
  local m = oq.raid.group[group_id].member[slot] ;

  if (m.realid ~= rid) then 
    if (rid) and (rid ~= "-") and (rid ~= "") and (name_) and (realm_) and (realm_ ~= "nil") then
      -- new member
      oq.on_member_join( name_, realm_, rid ) ;
    elseif ((rid == nil) or ((rid) and ((rid == "") or (rid == "-")))) and (m.realid ~= "-") then
      -- member left
      oq.on_member_left( m.name, m.realm, m.realid ) ;
    end
  end

  m.name         = name_ ;
  m.class        = class_ ;
  m.realm        = realm_ ;
  m.realm_id     = realm_id ;
  m.bgroup       = bgroup_ ;
  m.realid       = rid ;

  if (s1) and (s2) and (m.bg) then
    m.bg[1].status = (s1 or "3") ;
    m.bg[2].status = (s2 or "4") ;
  end

  if (class_ ~= nil) then
    oq.set_class( group_id, slot, class_ ) ;
  end

  if (slot == 1) and (m.realm) and (m.name) then
    oq.tab1_group[group_id].realm :SetText( m.realm ) ;
    oq.tab1_group[group_id].leader:SetText( m.name ) ;
    if (class_ ~= nil) and (OQ.CLASS_COLORS[class_] ~= nil) then
      oq.tab1_group[group_id].leader:SetTextColor( OQ.CLASS_COLORS[class_].r, OQ.CLASS_COLORS[class_].g, OQ.CLASS_COLORS[class_].b ) ;
    end
    oq.tab1_group[group_id].bgroup.texture:SetTexture( OQ.BGROUP_ICON[ oq.find_bgroup(realm_) ] ) ;
  elseif (slot == 1) then
    -- clear it out
    oq.tab1_group[group_id].realm :SetText( "" ) ;
    oq.tab1_group[group_id].leader:SetText( "" ) ;
    oq.tab1_group[group_id].bgroup.texture:SetTexture( nil ) ;
  end
end

function oq.set_group_lead( g_id, name, realm, class, rid )
  oq.set_group_member( g_id, 1, name, realm, class, rid ) ;
end

function oq.on_queue_up() 
end

function oq.on_queue_leave() 
--print( "clicking button" ) ;
--QueueStatusMinimapButton:Click("LeftButton") ;
--oq.timer_oneshot( 1, oq.leaveQ_in_a_sec ) ;
end

function oq.queue_button_action(self, button, ndx) 
  if (self:GetText() == OQ.LEAVE_QUEUE) or (button == "RightButton") then
    if (oq.iam_raid_leader()) then
      oq.raid_announce( "leave_queue,".. ndx ) ;
    end
    oq.battleground_leave( ndx ) ; 
    self:SetText( OQ.LEAVE_QUEUE ) ;
    oq.on_queue_leave() ;
  end
end

function  oq.on_reload_now() 
  ReloadUI() ;
end

-- remove trailing and leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
function oq.trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- remove leading whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
function oq.ltrim(s)
  return (s:gsub("^%s*", ""))
end

-- remove trailing whitespace from string.
-- http://en.wikipedia.org/wiki/Trim_(8programming)
function oq.rtrim(s)
  local n = #s
  while n > 0 and s:find("^%s", n) do n = n - 1 end
  return s:sub(1, n)
end

function oq.tab3_create_activate()
  local in_party = (oq.GetNumPartyMembers() > 0) ;
  if (in_party and not UnitIsGroupLeader("player")) then
    StaticPopup_Show("OQ_CannotCreatePremade", nil, nil, ndx ) ;
    return ;
  end
  oq.get_battle_tag() ;
  local name = oq.rtrim( oq.tab3_raid_name:GetText() ) ;
  if ((name == nil) or (name == "")) then
    message( OQ.MSG_MISSINGNAME ) ;
    return ;
  end
  local low_name = strlower( name ) ;
  if (low_name:find( "lfg" )) then
    message( OQ.MSG_NOTLFG ) ;
    return ;
  end

  if ((player_realid == nil) or (player_realid == "")) then
    return ;
  elseif (not oq.valid_rid( player_realid )) then
    message( OQ.BAD_REALID .." ".. tostring(player_realid) ) ;
    return ;
  end
  local old_type = oq.raid.type ;
  if (oq.tab3_radio_selected == nil) then
    StaticPopup_Show("OQ_PremadeTypeMissing") ;
    return ;
  end
  oq.set_premade_type( oq.tab3_radio_selected ) ;
  if (old_type ~= oq.raid.type) then
    oq.reject_all_waitlist() ;
  end
  
  local rc = nil ;
  if (oq.tab3_create_but:GetText() == OQ.CREATE_BUTTON) then
    rc = oq.raid_create() ; 
    if (rc) then
      rc = oq.update_premade_note() ;
      oq.tab3_create_but:SetText( OQ.UPDATE_BUTTON ) ;
    end
  elseif (oq.tab3_create_but:GetText() == OQ.UPDATE_BUTTON) then
    rc = oq.update_premade_note() ;
  end
  if (rc) then
    -- do not let the user create, update, or disband the premade for 15 seconds
    oq.tab3_create_but:Disable() ;
    oq.timer_oneshot( OQ_CREATEPREMADE_CD, oq.enable_button, oq.tab3_create_but ) ;
    oq.tab1_quit_button:Disable() ;
    oq.timer_oneshot( OQ_CREATEPREMADE_CD, oq.enable_button, oq.tab1_quit_button ) ;
  end
end

function oq.enable_button( but ) 
  if (but ~= nil) then
    but:Enable() ;
  end
end

function oq.find_mesh() 
  oq.tab2_findmesh_but:Disable() ;
  oq.timer_oneshot( OQ_FINDMESH_CD, oq.enable_button, oq.tab2_findmesh_but ) ;
  
  local nOQlocals, nOQfriends = oq.get_nConnections() ;
  local connection = nOQlocals + nOQfriends ;
  if ((connection > OQ_MIN_CONNECTION) and (nOQfriends > OQ_MIN_BNET_CONNECTIONS)) then
    -- at least 3 friends off realm
    print( OQ_TRIANGLE_ICON .." ".. OQ.FINDMESH_OK ) ;
    return ;
  end
  local tok = "B" .. oq.token_gen() ;
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "req_btags,"..
              tostring(player_name) ..",".. 
              tostring(oq.realm_cooked(player_realm)) ..",".. 
              tostring(player_faction) ..",".. 
              tostring(player_realid) ..",".. 
              tok ;
  oq.token_push( tok ) ;
  oq.send_to_scorekeeper( msg ) ;
end

function oq.pull_btag() 
  oq.tab5_pullbtag_but:Disable() ;
  oq.timer_oneshot( OQ_FINDMESH_CD, oq.enable_button, oq.tab5_pullbtag_but ) ;
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "pull_btag,"..
              tostring(player_faction) ..",".. 
              tostring(player_realid) ;
  oq.send_to_scorekeeper( msg ) ;
  oq.tab5_pullbtag_but:Disable() ;
  
  oq.tab2_submit_but:Enable() ;
  OQ_data.btag_submitted = nil ;
end

function oq.submit_still_kickin() 
  if (player_realid == nil) then
    oq.get_battle_tag() ;
  end
  if (player_realm == nil) then
    player_realm = oq.GetRealmName() ;
  end
  if ((player_realid == nil) or (player_realm == nil)) then
    return ;
  end
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "still_kickin,"..
              tostring(player_faction) ..",".. 
              tostring(player_realid) ;
  oq.send_to_scorekeeper( msg ) ;
  return 1 ;
end

function oq.submit_btag( faction_, tag_ )
  local faction = player_faction ;
  local tag     = player_realid ;
  local now     = utc_time() ;
  local my_tag  = true ;

  if (faction_ ~= nil) and (tag_ ~= nil) then
    faction = faction_ ;
    tag     = tag_ ;
    my_tag  = nil ;
  elseif (OQ_data.btag_submitted ~= nil) and (OQ_data.btag_submitted > now) then
    -- no more then once per day
    return ;
  end
  local msg = OQSK_HEADER ..",".. 
              OQSK_VER ..","..
              "W1,"..
              "btag,"..
              tostring(faction) ..",".. 
              tostring(tag) ;
  oq.send_to_scorekeeper( msg ) ;
  if (my_tag) then
    oq.tab2_submit_but:Disable() ;
    OQ_data.ok2submit_tag = 1 ;
    oq.tab5_ok2submit_btag:SetChecked( true ) ;
    OQ_data.btag_submitted = now + 6*3600 ; -- no more then once every 6 hrs
  end
  return 1 ;
end

function oq.cache_btag( tag, note_ )
  if (tag == nil) or (tag == "") then
    return ;
  end
  if (OQ_data.btag_cache == nil) then
    OQ_data.btag_cache = tbl.new() ;
  end
  OQ_data.btag_cache[ strlower(tag) ] = { tm = utc_time() + OQ_BTAG_SUBMIT_INTERVAL, note = note_ } ;
end

function oq.clear_btag_cache()
  tbl.clear( OQ_data.btag_cache ) ;
end

function oq.in_btag_cache( tag )
  if (OQ_data.btag_cache == nil) then
    OQ_data.btag_cache = tbl.new() ;
    return nil ;
  end
  if (tag == nil) or (OQ_data.btag_cache[ strlower(tag) ] == nil) then
    return nil ;
  end
  return true ;
end

function oq.on_btags( token, t1, t2, t3, t4, t5, t6 )
  _ok2relay  = nil ;
  if (not oq.token_was_seen( token )) then
    -- not my token, bogus msg
    return ;
  end
  local msg = OQ_HEADER ..",".. 
              OQ_VER ..","..
              "W1,0,mesh_tag,0" ;

  if (not oq.is_banned( t1 )) then
    oq.BNSendFriendInvite( t1, msg, "OQ,mesh node" ) ;
  end
  if (not oq.is_banned( t2 )) then
    oq.BNSendFriendInvite( t2, msg, "OQ,mesh node" ) ;
  end
  if (not oq.is_banned( t3 )) then
    oq.BNSendFriendInvite( t3, msg, "OQ,mesh node" ) ;
  end
  if (not oq.is_banned( t4 )) then
    oq.BNSendFriendInvite( t4, msg, "OQ,mesh node" ) ;
  end
  if (not oq.is_banned( t5 )) then
    oq.BNSendFriendInvite( t5, msg, "OQ,mesh node" ) ;
  end
  if (not oq.is_banned( t6 )) then
    oq.BNSendFriendInvite( t6, msg, "OQ,mesh node" ) ;
  end
end

function oq.on_mesh_tag( faction_, rid_ ) 
  if (OQ_data.autoaccept_mesh_request ~= 1) then
    return ;
  end
  local ntotal, nonline = BNGetNumFriends() ;
  if (ntotal < OQ_MAX_BNFRIENDS) then
    _ok2decline = nil ;
    _oq_note    = "OQ,mesh node" ;
  end
end

--------------------------------------------------------------------------
-- main ui creation
--------------------------------------------------------------------------
--  Interface\\CastingBar\\UI-CastingBar-Arena-Shield.blp
function oq.create_karma_shield( parent )
  local d = oq.CreateFrame("FRAME", "OQKarmaShield", parent ) ;
  d:SetBackdropColor(0.0,0.0,0.0,1.0);
  d:SetAlpha( 1.0 ) ;
  d:SetPoint("TOPLEFT",parent,"TOPLEFT", -12, 12 ) ;
  d:SetWidth (38) ;
  d:SetHeight(38) ;
  d:SetScript("OnEnter", function(self, ...) oq.tooltip_me() ; end ) ;
  d:SetScript("OnLeave", function(self, ...) oq.tooltip_me_hide() ; end ) ;

  local s = d:CreateTexture( nil, "BORDER" ) ;
  s:SetTexture( "INTERFACE/COMMON/portrait-ring-withbg.blp" ) ;
  s:SetTexCoord(33/128, 94/128, 30/128, 93/128) ;
  s:SetAllPoints(d) ;
  s:SetAlpha( 1.0 ) ;
  d.shield = s ;
  
  d.label = d:CreateFontString( nil, "OVERLAY", "GameFontNormalSmall" ) ;
  d.label:SetAllPoints(d) ;
  d.label:SetPoint("TOPLEFT", d, "TOPLEFT", 0, -2 ) ;
  d.label:SetJustifyV( "CENTER" ) ;
  d.label:SetJustifyH( "CENTER" ) ;
  d.label:SetFont( "Fonts\\FRIZQT__.TTF", 14 ) ;
  d.label:SetText( "--" ) ;
  d.label:Show() ;

  d:Show() ;
  return d ;
end

function oq.set_karma_shield( karma )
  if (karma == 0) then
    oq.karma_shield.label:SetText( oq.karma_color( karma ) .."".. tostring("--") .."|r" ) ;
  elseif (karma >= 0) then
    oq.karma_shield.shield:SetTexture( "INTERFACE/COMMON/portrait-ring-withbg.blp" ) ;
    oq.karma_shield.shield:SetTexCoord(33/128, 94/128, 30/128, 93/128) ;
    oq.karma_shield.label :SetText( oq.karma_color( karma ) .."".. tostring(karma) .."|r" ) ;
  else
    oq.karma_shield.shield:SetTexture( "INTERFACE/GLUES/LOGIN/Glues-CheckBox-Background.blp" ) ;
    oq.karma_shield.shield:SetTexCoord(0.03, 0.99, 0.03, 0.99) ;
    oq.karma_shield.label:SetText( oq.karma_color( karma ) .."".. tostring(abs(karma)) .."|r" ) ;
  end
end

function oq.toggle_bounty_board()
  if (oq._bounty_board) and (oq._bounty_board:IsVisible()) then
    oq._bounty_board:Hide() ;
  elseif (oq._bounty_board) then
    oq._bounty_board:Show() ;
    oq._bounty_board:Raise() ;
--    tremove_value( UISpecialFrames, oq._bounty_board:GetParent():GetName() ) ;
--    tinsert( UISpecialFrames, oq._bounty_board:GetName() ) ;
  end
end

function oq.toggle_type2_bounty_board()
  if (oq._bounty_board) and (oq._bounty_board:IsVisible()) then
    oq._bounty_board:Hide() ;
  elseif (oq._bounty_board) then
    oq._bounty_board:Show() ;
    oq._bounty_board:Raise() ;
    -- jump to matchup page
    local now = utc_time() ;
    for i=1,OQ.MAXBOUNTIES do
      local c = oq.bounties[i] ;
      if (c) and (c.type > 1) and (c.type < 10) and (c.flags == 1) then
        oq._bounty_board:goto_contract( c.id ) ;
        return ;
      end
    end
  end
end

function oq.create_bounty_board( parent )
  -- headline:  INTERFACE/BlackMarket/BlackMarketSign
  -- main backdrop:  INTERFACE/BarberShop/UI-BARBERSHOP  
  -- bounties avilable:  INTERFACE/BUTTONS/UI-MICROBUTTON-SOCIALS-UP
  -- bounties avilable:  INTERFACE/BUTTONS/UI-MICROBUTTON-SOCIALS-DOWN
  -- no bounties alliance: INTERFACE/BUTTONS/UI-MicroButton-Guild-Disabled-Alliance
  -- no bounties horde: INTERFACE/BUTTONS/UI-MicroButton-Guild-Disabled-Horde
  local x = 28 ;
  local y = 4 ;
  local cx = 24 ;
  local cy = 26 ;
  local b = CreateFrame( "CheckButton", nil, parent ) ;
  b:SetFrameLevel( parent:GetFrameLevel() + 1 ) ;
  b:RegisterForClicks('anyUp') ;
  b:SetWidth( cx ) ;
  b:SetHeight( cy ) ;
  b:SetPoint( "TOPLEFT", x, y ) ;

  local pt = b:CreateTexture()
  pt:SetTexture([[Interface\Buttons\UI-MICROBUTTON-SOCIALS-DOWN]])
  pt:SetAllPoints(b)
--  pt:SetTexCoord(2/32,29/32,25/64,61/64);
  pt:SetTexCoord(4/32,26/32,30/64,59/64);
  b:SetPushedTexture(pt)

  local ht = b:CreateTexture()
  ht:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
  ht:SetAllPoints(b)
  b:SetHighlightTexture(ht)

  local ct = b:CreateTexture()
  ct:SetTexture([[Interface\Buttons\CheckButtonHilight]])
  ct:SetAllPoints(b)
  ct:SetBlendMode('ADD')
  ct:SetAlpha(0.5) ;
  b:SetCheckedTexture(ct)

  local icon = b:CreateTexture()
  icon:SetAllPoints(b)
  icon:SetTexture( [[Interface\Buttons\UI-MICROBUTTON-SOCIALS-UP]] )
--  icon:SetTexCoord(2/32,29/32,25/64,61/64);
  icon:SetTexCoord(4/32,26/32,30/64,59/64);

  b:SetScript( "OnClick", oq.toggle_bounty_board ) ;
  b:Show() ;
  
  ------------------------------------------------------------------------
  -- create bounty board
  ------------------------------------------------------------------------
  local d = oq.CreateFrame( "FRAME", "OQBountyBoard", UIParent ) ;
--  d:SetBackdrop({bgFile="INTERFACE/BarberShop/UI-BARBERSHOP", 
--                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
--                 })
  oq.make_frame_moveable( d ) ;
  d:SetScript( "OnShow", function(self) 
                           tinsert( UISpecialFrames, self:GetName() ) ; 
                           self:SetFrameLevel( 52 ) ; -- minimap button == 50
                           oq.update_bounty_page() ;
                           oq.timer( "bb_update", 0.5, oq.update_bounty_clock, true ) ;
                           PlaySound("igCharacterInfoOpen") ;
                         end ) ;
  d:SetScript( "OnHide", function(self) 
                           oq.timer( "bb_update", 0.5, nil ) ;
                           PlaySound("igCharacterInfoClose") ;
                         end ) ;
  d._save_position = function(self) 
                       OQ_data.bounty_x = max(0,floor(self:GetLeft())) ; 
                       OQ_data.bounty_y = max(0,floor(self:GetTop())) ; 
                     end ;

  d:SetPoint( "TOPLEFT", 100, -100 ) ;
  d:SetWidth ( 400 ) ;
  d:SetHeight( 500 ) ;
  d:SetFrameLevel( max( OQ_MinimapButton:GetFrameLevel(), parent:GetFrameLevel() ) + 10 ) ;

  local back = d:CreateTexture( nil, "BACKGROUND" ) ;
  back:SetTexture( "INTERFACE/BarberShop/UI-BARBERSHOP" ) ;
  back:SetTexCoord(5/512, 265/512, 1/512, 312/512) ;
  back:SetAllPoints( d ) ;
  back:SetAlpha( 1.0 ) ;
  d._backdrop = back ;
  
  local t = d:CreateTexture( nil, "BORDER" ) ;
  t:SetTexture( "INTERFACE/BlackMarket/BlackMarketSign" ) ;
  t:SetPoint( "TOPLEFT", 20, -50 ) ;
  t:SetAlpha( 1.0 ) ;
  t:SetWidth( d:GetWidth() -2*20 ) ;
  t:SetHeight( 200 ) ;
  d._banner = t ;
  
  local bones = d:CreateTexture( nil, "BORDER" ) ;
  bones:SetTexture( "INTERFACE/ARCHEOLOGY/ArchRare-TrollVoodooDoll" ) ;
  bones:SetTexCoord( 180/512, 375/512, 20/256,220/256 ) ;
  bones:SetVertexColor( 192/255, 192/255, 192/255 ) ;
  bones:SetPoint( "TOPLEFT", 90, -165 ) ;
  bones:SetAlpha( 0.3 ) ;
  bones:SetWidth( d:GetWidth() -2*90 ) ;
  bones:SetHeight( 200 ) ;
  d._bones = bones ;
  
  x = 90 ;
  y = -165 ;
  d._poster = oq.CreateFrame( "SimpleHTML", "OQBountyPoster", d ) ;
  d._poster:SetPoint( "TOPLEFT"    , x, y ) ;
  d._poster:SetFont( "Fonts\\FRIZQT__.TTF", 12 ) ;
  d._poster:SetWidth ( d:GetWidth() - 2*x ) ;
  d._poster:SetHeight( 100 ) ;
  d._poster:SetFont        ( 'h1', "Fonts\\FRIZQT__.TTF", 16 ) ;
  d._poster:SetTextColor   ( 'h1', 0.2, 0.2, 0.2, 0.8 ) ;
  
  d._poster:SetFont        ( 'h2', "Fonts\\MORPHEUS.ttf", 40 ) ;
  d._poster:SetShadowColor ( 'h2', 0, 0, 0, 1 ) ;
  d._poster:SetShadowOffset( 'h2', 1, -1 ) ;
  d._poster:SetTextColor   ( 'h2', 128/255, 0/255, 0/255, 1.0 ) ;
  
  d._poster:SetFont        ( 'h3', "Fonts\\FRIZQT__.ttf", 10 ) ;
  d._poster:SetShadowColor ( 'h3', 0, 0, 0, 1 ) ;
  d._poster:SetShadowOffset( 'h3', 0, 0 ) ;
  d._poster:SetTextColor   ( 'h3', 0.2, 0.2, 0.2, 0.8 ) ;

  d._poster:SetText( "" ) ;
  
  -- death-match: horde 
  y = d:GetHeight() - 240 ;
  x1 = x + 40 ;
  d._horde_score_l = oq.label( d, x1, y, 90, OQ.BUTTON_SZ, OQ.FACTION_ICON["H"] .." Horde" ) ;
  d._horde_score_l:SetJustifyV( "MIDDLE" ) ;
  d._horde_score_l:SetJustifyH( "LEFT" ) ;
  d._horde_score_l:SetFont( "Fonts\\FRIZQT__.TTF", 12 ) ;
  d._horde_score_l:SetTextColor( 0.1, 0.1, 0.1, 1.0 ) ;
  d._horde_score_l:SetShadowOffset( 0, 0 ) ;

  d._horde_score   = oq.label( d, x1+70, y+5, 70, 25, "0" ) ;
  d._horde_score:SetFont(OQ.FONT_FIXED, 12, "") ;
  d._horde_score:SetJustifyH("RIGHT") ;
  d._horde_score:SetJustifyV("MIDDLE") ;
  d._horde_score:SetTextColor( 0, 0, 0, 1 ) ;  
  d._horde_score:SetShadowOffset( 0, 0 ) ;
  
  d._horde_score_l:Hide() ;
  d._horde_score:Hide() ;
  
  -- death-match: alliance 
  y = y + 20 ;
  d._alliance_score_l = oq.label( d, x1, y, 90, OQ.BUTTON_SZ, OQ.FACTION_ICON["A"] .." Alliance" ) ;
  d._alliance_score_l:SetJustifyV( "MIDDLE" ) ;
  d._alliance_score_l:SetJustifyH( "LEFT" ) ;
  d._alliance_score_l:SetFont( "Fonts\\FRIZQT__.TTF", 12 ) ;
  d._alliance_score_l:SetTextColor( 0.1, 0.1, 0.1, 1.0 ) ;
  d._alliance_score_l:SetShadowOffset( 0, 0 ) ;

  d._alliance_score   = oq.label( d, x1+70, y+5, 70, 25, "0" ) ;
  d._alliance_score:SetFont(OQ.FONT_FIXED, 12, "") ;
  d._alliance_score:SetJustifyH("RIGHT") ;
  d._alliance_score:SetJustifyV("MIDDLE") ;
  d._alliance_score:SetTextColor( 0, 0, 0, 1 ) ;  
  d._alliance_score:SetShadowOffset( 0, 0 ) ;

  d._alliance_score_l:Hide() ;
  d._alliance_score:Hide() ;
  
  -- rewards
  y = d:GetHeight() - 200 ;
  d._reward_l = oq.label( d, x, y, 100, OQ.BUTTON_SZ, "Rewards" ) ;
  d._reward_l:SetJustifyV( "BOTTOM" ) ;
  d._reward_l:SetJustifyH( "LEFT" ) ;
  d._reward_l:SetFont( "Fonts\\FRIZQT__.TTF", 16 ) ;
  d._reward_l:SetTextColor( 0.2, 0.2, 0.2, 0.9 ) ;
  d._reward_l:SetShadowOffset( 0, 0 ) ;

  d._reward    = oq.label( d, x+100+20, y+10, 100, 25, "0 C" ) ;
  d._reward:SetFont(OQ.FONT_FIXED, 12, "") ;
  d._reward:SetJustifyH("RIGHT") ;
  d._reward:SetJustifyV("MIDDLE") ;
  d._reward:SetTextColor( 0, 0, 0, 1 ) ;  
  d._reward:SetShadowOffset( 0, 0 ) ;
  

  -- timeleft
  y = y + 35 ;
  d._remaining_l = oq.label( d, x, y, 100, OQ.BUTTON_SZ, "Time left" ) ;
  d._remaining_l:SetJustifyV( "CENTER" ) ;
  d._remaining_l:SetJustifyH( "LEFT" ) ;
  d._remaining_l:SetFont( "Fonts\\FRIZQT__.TTF", 16 ) ;
  d._remaining_l:SetTextColor( 0.2, 0.2, 0.2, 0.9 ) ;
  d._remaining_l:SetShadowOffset( 0, 0 ) ;

  d._remaining = oq.label( d, x+100, y, 100, OQ.BUTTON_SZ, "16:52" ) ;
  d._remaining:SetJustifyV( "CENTER" ) ;
  d._remaining:SetJustifyH( "RIGHT" ) ;
  d._remaining:SetFont( OQ.FONT_FIXED, 12 ) ;
  d._remaining:SetTextColor(  0, 0, 0, 1 ) ;
  d._remaining:SetShadowOffset( 0, 0 ) ;

  local x = 160 ;
  local y = d:GetHeight() - 100 ;
  d._prev = oq.prev_button( d, x+ 55, y, function(self) self:GetParent():prev(self) ; end ) ;
  d._next = oq.next_button( d, x+ 90, y, function(self) self:GetParent():next(self) ; end ) ;
  
--  oq.button_disable( d._prev ) ;
--  oq.button_disable( d._next ) ;

  d._page = oq.label( d, x, y, 75, OQ.BUTTON_SZ, "Page 1" ) ;
  d._page:SetJustifyV( "CENTER" ) ;
  d._page:SetJustifyH( "LEFT" ) ;
  d._page:SetFont( "Fonts\\FRIZQT__.TTF", 12 ) ;
  d._page:SetTextColor( 0.4, 0.4, 0.4, 0.5 ) ;
  
  d.top  = function(self, dontrefresh) self:goto(1, dontrefresh) ; end 
  d.prev = function(self) self:goto(self._pg - 1) ; end 
  d.next = function(self) self:goto(self._pg + 1) ; end 
  d.count_pgs = function(self) 
                  self._npages = 0 ;
                  for i,v in pairs(oq.bounties) do
                    if (v.id) and (v.target) and (v.target ~= 0) then
                      self._npages = self._npages + 1 ;
                    end
                  end
                end
  d.goto = function(self, pg, dontrefresh) 
             if (self._ids) then tbl.clear(self._ids) else self._ids = {} end
             self._pg      = 0 ;
             self._ndx     = nil ;
             self._npages  = 0 ;
             self._current = nil ;
             for i,v in pairs(oq.bounties) do
               if (v.id) and (v.target) and (v.target ~= 0) then
                 self._npages = self._npages + 1 ;
                 table.insert( self._ids, v.id ) ;
               end
             end
             if (self._npages == 0) then
               return ;
             end
             if (pg > self._npages) or (pg < 1) then
               pg = 1 ;
             end
             table.sort(self._ids, oq.basic_compare) ;  
             for i,v in pairs(oq.bounties) do
               if (v.id == self._ids[pg]) then
                 self._ndx = i ;
                 self._pg  = pg ;
                 self._current = v.id ;
                 break ;
               end
             end  
             -- display page
             if (dontrefresh == nil) then
               oq.update_bounty_page() ;
               PlaySound("igMainMenuOptionCheckBoxOn") ;
             end
           end
  d.goto_contract = function(self, id, dontrefresh) 
             if (self._ids) then tbl.clear(self._ids) else self._ids = {} end
             self._pg      = 0 ;
             self._ndx     = nil ;
             self._npages  = 0 ;
             self._current = nil ;
             for i,v in pairs(oq.bounties) do
               if (v.id) and (v.target) and (v.target ~= 0) then
                 self._npages = self._npages + 1 ;
                 table.insert( self._ids, v.id ) ;
               end
             end
             if (self._npages == 0) then
               return ;
             end
             local pg = 0 ; -- default page
             table.sort(self._ids, oq.basic_compare) ;  
             for i,v in pairs(oq.bounties) do
               if (v.id == tonumber(id)) then
                 self._ndx = i ;
                 self._current = v.id ;
                 self._pg  = 0 ;
                 for j,x in pairs(self._ids) do
                   if (x == v.id) then
                     self._pg = j ;
                     break ;
                   end
                 end
                 break ;
               end
             end  
             if (self._ndx == nil) then
               self:top(dontrefresh) ;
               return ;
             end
             -- display page
             if (dontrefresh == nil) then
               oq.update_bounty_page() ;
               PlaySound("igMainMenuOptionCheckBoxOn") ;
             end
           end

  d:Hide() ;
  d._pg = 0 ;
  oq._bounty_board = d ;
  if (OQ_data.bounty_x or OQ_data.bounty_y) then
    d:SetPoint( "TOPLEFT", UIParent, "BOTTOMLEFT", OQ_data.bounty_x, OQ_data.bounty_y ) ;
  end
  
  oq.bounties = tbl.new() ;
  
  d:top() ;
  return b ;
end

OQ.CONTRACT_TARGETS = { [2] = { H = 69968, A = 69966 },
                        [3] = { H = 19907, A = 19906 },
                        [4] = { H = 67801, A = 67461 },
                      } ; 
OQ.npc = {}
function oq.populate_npc_table()
  OQ.npc[18728] = L["Doom Lord Kazzak"] ; -- shared; outland
  OQ.npc[46254] = L["Hogger"] ; -- stockades
  OQ.npc[46264] = L["Lord Overheat"] ;  -- stockades
  OQ.npc[46383] = L["Randolph Moloch"] ;  -- stockades
  OQ.npc[61408] = L["Adarogg"] ; -- ragefire
  OQ.npc[61463] = L["Slagmaw"] ; -- ragefire
  OQ.npc[61528] = L["Lava Guard Gordoth"] ; -- ragefire
  OQ.npc[ 2456] = L["Newton Burnside"] ; -- SW banker
  OQ.npc[ 8670] = L["Auctioneer Chilton"] ; -- SW auctioneer
  OQ.npc[ 1215] = L["Alchemist Mallory"] ; -- outside SW
  OQ.npc[ 3935] = L["Toddrick"] ;  -- goldshire
  OQ.npc[ 6121] = L["Remen Marcot"] ; -- goldshire
  OQ.npc[  327] = L["Goldtooth"] ; -- south of goldshire
  OQ.npc[44865] = L["Auctioneer Fazdran"] ; -- org
  OQ.npc[44854] = L["Kixa"] ; -- org banker
  OQ.npc[39379] = L["Gor the Enforcer"] ; -- outside of org
  OQ.npc[ 3169] = L["Tarshaw Jaggedscar"] ; -- razorhill
  OQ.npc[ 6586] = L["Rokar Bladeshadow"] ; -- south of org
  OQ.npc[ 5519] = L["Kor'kron Spotter"] ; -- outside of org
  OQ.npc[42131] = L["Falstad Wildhammer"] ; -- ironforge council
  OQ.npc[36648] = L["Baine Bloodhoof"] ; -- thunderbluff chieftain
  OQ.npc[18733] = L["Fel Reaver"] ; -- shared; outland
  OQ.npc[64065] = L["Brewmaster Roland"] ; -- two moons
  OQ.npc[64585] = L["Reeler Uko"] ; -- two moons
  OQ.npc[50339] = L["Sulik'shor"] ; -- rare, four winds
  OQ.npc[50352] = L["Qu'nas"] ; -- rare, krasarang wilds
  OQ.npc[50364] = L["Nal'lak the Ripper"] ; -- rare, four winds
  OQ.npc[68322] = L["Muerta"] ; -- horde, domination point
  OQ.npc[68319] = L["Disha Fearwarden"] ; -- alliance, lion's landing
  OQ.npc[16972] = L["Bonestripper Buzzard"] ; -- test target
  OQ.npc[18678] = L["Fulgorge"] ; -- outland; extremely rare 
  OQ.npc[50780] = L["Sahn Tidehunter"] ; -- rare; eternal blossoms
  OQ.npc[50806] = L["Moldo One-Eye"] ; -- rare; eternal blossoms
  OQ.npc[50805] = L["Omnis Grinlok"] ; -- rare; pandaria
  OQ.npc[70101] = L["Armsmaster Holinka"] ; -- alli pvp vendor; four winds
  OQ.npc[70108] = L["Roo Desvin"] ; -- horde pvp vendor; four winds
  OQ.npc[68000] = L["Hiren Loresong"] ; -- isle of thunder; alli quartermaster 
  OQ.npc[67672] = L["Vasarin Redmorn"] ; -- isle of thunder; horde quartermaster 
  OQ.npc[19907] = L["Grumbol Grimhammer"] ; -- alli AV battlemaster
  OQ.npc[19906] = L["Usha Eyegouge"] ; -- horde AV battlemaster
  OQ.npc[42983] = L["Bartlett the Brave"] ; -- goldshire flightmaster
  OQ.npc[43124] = L["Anette Williams"] ; -- brill bat master
  OQ.npc[46638] = L["Auctioneer Vizput"] ; -- secondary org auctioneer
  OQ.npc[10181] = L["Lady Sylvanas Windrunner"] ; -- UC boss
  OQ.npc[ 3615] = L["Devrak"] ; -- horde; x-road flight master
  OQ.npc[ 2409] = L["Felicia Maline"] ; -- alliance; darkshire flight master
  OQ.npc[30231] = L["Radulf Leder"] ; -- alliance; AB battlemaster
  OQ.npc[19905] = L["The Black Bride"] ; -- horde; AB battlemaster
  OQ.npc[69835] = L["Shan'ze Battlemaster"] ; -- thunder isle  
  OQ.npc[ 4311] = L["Holgar Stormaxe"] ; -- outside of org
  OQ.npc[71255] = L["Ruskan Goreblade"] ; -- kor'kron commander
  OQ.npc[  331] = L["Maginor Dumas"] ; -- in SW mage tower 
  OQ.npc[ 5694] = L["High Sorcerer Andromath"] ; -- in SW mage tower 
  OQ.npc[69975] = L["Captain Dirgehammer"] ; -- SW conquest quartermaster
  OQ.npc[  917] = L["Keryn Sylvius"] ; -- goldshire
  OQ.npc[68408] = L["Bizmo's Brawlpub Bouncer"] ; -- brawler's pub
  OQ.npc[11145] = L["Myolor Sunderfury"] ; -- ironforge
  OQ.npc[ 4256] = L["Golnir Bouldertoe"] ; -- ironforge
  OQ.npc[ 9859] = L["Auctioneer Lympkin"] ; -- ironforge 
  OQ.npc[ 1373] = L["Jarven Thunderbrew"] ; -- outside of ironforge, kharanos
  OQ.npc[63179] = L["Mistblade Scale-Lord"] ; -- shared target, dread wastes, in hole next to BOA world drop (blade of the prime)
  OQ.npc[50840] = L["Major Nanners"] ; -- rare in eternal blossoms
  OQ.npc[69965] = L["Doris Chiltonius"] ; -- conquest vendor; horde
  OQ.npc[69967] = L["Lucan Malory"] ; -- conquest vendor; alli
  OQ.npc[69966] = L["Acon Deathwielder"] ; -- glorious conquest vendor; horde
  OQ.npc[69968] = L["Ethan Natice"] ; -- glorious conquest vendor; alliance
  OQ.npc[63978] = L["Kri'chon"] ; -- quest mob @ the wall
  OQ.npc[67461] = L["Warlord Bloodhilt"] ; -- horde keep boss in krasarang wilds
  OQ.npc[67801] = L["High Marshal Twinbraid"] ; -- alliance keep boss in krasarang wilds
end

function oq.npc_name( id )
  if (OQ_data.npc) and (OQ_data.npc[id]) then
    return OQ_data.npc[id] ;
  end
  
  local tooltip = oq.__scanning_tooltip ;
  if (tooltip == nil) then
    tooltip = oq.CreateFrame( "GameTooltip", "OQTooltipScanner", UIParent, "GameTooltipTemplate" ) ;
    local tooltipMethods = getmetatable(tooltip).__index ;
     tooltip = setmetatable( tooltip, 
               { __index = function(self, id)
                             local method = tooltipMethods[id] ; -- See if this key is a tooltip method
                             if method then return method end -- If it is, return the method now
            
                             -- Otherwise look up a unit
                             self:SetOwner(UIParent, "ANCHOR_NONE") ;
                             local id_str = string.format( "unit:0xF53%05X00000000", id ) ;
                             self:SetHyperlink( id_str ) ;
--                             self:Show() ;
                             return _G[ self:GetName() .."TextLeft1"]:GetText() ;
                           end
               } 
               ) ;
    oq.__scanning_tooltip = tooltip ;
  end
  local name = tooltip[id] ;
  if (name == nil) then
    if (OQ.npc[id]) then -- probably not localized; better then nothing if available
      return OQ.npc[id] ;
    end
    return nil ;
  else
    if (OQ_data.npc == nil) then
      OQ_data.npc = {} ;
    end
    OQ_data.npc[id] = name ;
    return name ;
  end
end

function oq.schweetness() 
  PlaySoundFile("Sound\\Events\\GuldanCheers.wav") ;
  PlaySoundFile("Sound/SPELLS/AchievmentSound1.ogg") ;
end

function oq.sour_grapes() 
   if (player_faction == "H") then
      PlaySoundFile("Sound/character/BloodElf/BloodElfFemaleRaspberry01.ogg") ;
      PlaySoundFile("Sound/character/BloodElf/BloodElfMaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Orc/OrcVocalFemale/OrcFemaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Orc/OrcVocalMale/OrcMaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/PCGoblinFemale/VO_PCGoblinFemale_Raspberry01.ogg")
      PlaySoundFile("Sound/character/PCGoblinMale/VO_PCGoblinMale_Raspberry01.ogg")
      PlaySoundFile("Sound/character/Scourge/ScourgeVocalFemale/UndeadFemaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Scourge/ScourgeVocalMale/UndeadMaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Tauren/TaurenVocalFemale/TaurenFemaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Tauren/TaurenVocalMale/TaurenMaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Troll/TrollVocalFemale/TrollFemaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Troll/TrollVocalMale/TrollMaleRaspberry01.ogg")
   elseif (player_faction == "A") then
      PlaySoundFile("Sound/character/Draenei/DraeneiFemaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Draenei/DraeneiMaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Dwarf/DwarfVocalFemale/DwarfFemaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Dwarf/DwarfVocalMale/DwarfMaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Gnome/GnomeVocalFemale/GnomeFemaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Gnome/GnomeVocalMale/GnomeMaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Human/HumanVocalFemale/HumanFemaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/Human/HumanVocalMale/HumanMaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/NightElf/NightElfVocalFemale/NightElfFemaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/NightElf/NightElfVocalMale/NightElfMaleRaspberry01.ogg")
      PlaySoundFile("Sound/character/PCWorgenFemale/VO_PCWorgenFemale_Raspberry01.OGG")
      PlaySoundFile("Sound/character/PCWorgenMale/VO_PCWorgenMale_Raspberry01.ogg")
   end
end

function oq.new_bounty_type2( b )
  print( OQ_LILCIRCLE_ICON .." ".. OQ.DEATHMATCH_BEGINS ) ;
  if (oq.marquee:IsVisible()) and (not oq.marquee.match_up:IsVisible()) then
    oq.marquee.match_up:Show() ;
    -- play sound to announce the match
    PlaySound("LevelUp") ;
    PlaySoundFile( "Sound\\Interface\\PVPFlagCapturedHordeMono.wav" ) ;
    PlaySoundFile( "Sound\\Creature\\FelReaver\\FelReaverPreAggro.wav" ) ;
  end
  -- announce new match start
  oq.update_bounty_type2( b ) ;
end

function oq.update_bounty_type2( b, winner ) 
  oq._bounty_board._horde_score   :SetText( tostring(b.h_x) ) ;
  oq._bounty_board._alliance_score:SetText( tostring(b.a_x) ) ;
  if (oq.marquee.match_up:IsVisible()) then
    oq.marquee.match_up.horde   :SetText( tostring(b.h_x) ) ;
    oq.marquee.match_up.alliance:SetText( tostring(b.a_x) ) ;
    if (winner) then
      if (winner:sub(1,1) == player_faction) then
        oq.schweetness() ;
      else
        oq.sour_grapes() ;
      end
    end
  end
  if (winner) then
    print( OQ_LILCIRCLE_ICON .."  ".. OQ.FACTION_ICON[winner:sub(1,1)] .." ".. winner .." ".. OQ.WONTHEMATCH ) ;
  end
end

function oq.bounty_update( bid, type, start, dur, h_reward, a_reward, flags, h_x, a_x, tm, pname )
  local bb =  oq._bounty_board ;
  if (type == 1) and ((oq.npc_name(h_x) == nil) or (oq.npc_name(a_x) == nil)) then
    -- unknown mob, invalid contract
    return ;
  end
  -- do we have the contract already?
  local reward = 0 ;
  for i=1,OQ.MAXBOUNTIES do
    if (oq.bounties[i]) and ((oq.bounties[i].id == bid) or (oq.bounties[i].target == npc_id)) then
      -- found it; update and bail
      local winner = nil ;
      oq.bounties[i].last_update = tm ;
      oq.bounties[i].h_x = h_x ;
      oq.bounties[i].a_x = a_x ;
      if (oq.bounties[i].flags ~= flags) then
        if (flags == 2) then
          winner = "Horde" ;
          reward = h_reward ;
        elseif (flags == 3) then
          winner = "Alliance" ;
          reward = a_reward ;
        elseif (flags == 4) then
          -- expired
        end
        if (OQ_data.show_contract_ads == 1) and (type == 1) then
          if (winner) and (pname) then
            print( OQ_LILSKULL_ICON .." ".. string.format( OQ.CONTRACT_CLAIMED01, pname, OQ.FACTION_ICON[winner:sub(1,1)], bid, oq.get_crowns( reward, 12 ) )) ;
          elseif (winner) then
            print( OQ_LILSKULL_ICON .." ".. string.format( OQ.CONTRACT_CLAIMED02, winner, bid, oq.get_crowns( reward, 12 ) )) ;
          end
        end
      end
      oq.bounties[i].flags = flags ;
      
      if (type > 1) and (type < 10) then
        oq.update_bounty_type2( oq.bounties[i], winner ) ;
      end
      if (bb._current) and (bb._current == bid) then
        oq.update_bounty_page() ;
      end
      return ;
    end
  end
  
  -- new contract  
  for i=1,OQ.MAXBOUNTIES do
    if (oq.bounties[i] == nil) then
      oq.bounties[i] = tbl.new() ;
    end
    if (oq.bounties[i].id == nil) then
      local b = oq.bounties[i] ;
      b.id          = bid ;
      b.type        = type ;
      b.start       = start ;
      b.dur         = dur ;
      b.h_reward    = h_reward ;
      b.a_reward    = a_reward ;
      b.h_x         = h_x ;
      b.a_x         = a_x ;
      b.flags       = flags ;
      b.target      = 0 ;
      if (type == 1) then
        if (player_faction == "H") then
          b.target = h_x ;
        else
          b.target = a_x ;
        end
      elseif (type > 1) and (type < 10) and (OQ.CONTRACT_TARGETS[type]) then
        -- h_x and a_x are the current 'score'
        b.target = OQ.CONTRACT_TARGETS[type][player_faction] ; 
        oq.new_bounty_type2( b ) ;
      end
      if (player_faction == "H") then
        b.reward = h_reward ;
      else
        b.reward = a_reward ;
      end
      
      b.expires     = start + dur ;      
      b.name        = oq.npc_name(b.target) ;
      b.last_update = tm ;
      if (OQ_data.show_contract_ads == 1) and (b.target ~= 0) and (flags == 1) then
        oq.announce_new_contract( b )
      end
      break ;
    end
  end

  -- update
  bb:count_pgs() ;
  if (bb._pg == 0) then
    bb:top() ;
  end
  if (bb._current) and (bb._current == bid) then
    oq.update_bounty_page() ;
  end
end

-- packet format:
--
-- bounty: bbbTTTTTTdddiiiccf
-- bbb     bounty id
-- TTTTTT  time started
-- ddd      duration 
-- iii     id of target mob
-- cc      crowns awarded 
-- f       flags; 6 bits; ab cdef = a: completed, b: 1-horde, 0-alli (only valid if a=1); c:expired
--
function oq.on_bounty( contract, tm, pname )
  local bb =  oq._bounty_board ;
  -- process
  local bid      = oq.decode_mime64_digits(contract:sub( 1, 2)) ;
  local type     = oq.decode_mime64_digits(contract:sub( 3, 3)) ;
  local start    = oq.decode_mime64_digits(contract:sub( 4, 9)) ;
  local dur      = oq.decode_mime64_digits(contract:sub(10,12)) ;
  local h_reward = oq.decode_mime64_digits(contract:sub(13,14)) ;
  local a_reward = oq.decode_mime64_digits(contract:sub(15,16)) ;
  local flags    = oq.decode_mime64_digits(contract:sub(17,17)) ;
  local h_x      = oq.decode_mime64_digits(contract:sub(18,20)) ;
  local a_x      = oq.decode_mime64_digits(contract:sub(21,23)) ;
  
  local t1 = oq.decode_mime64_digits(tm) or 0 ;
  if (bb._last_book_tm) and (t1 < bb._last_book_tm) then
    -- old data, disregard
    _ok2relay  = nil ;
    return ;
  end
  if (pname == "") then
    pname = nil ;
  end
  oq.bounty_update( bid, type, start, dur, h_reward, a_reward, flags, h_x, a_x, t1, pname )
end

function oq.show_the_book()
  local bb =  oq._bounty_board ;
  local now = utc_time() ;
  print( "--[ the book ]--" ) ;
  for i=1,OQ.MAXBOUNTIES do
    local c= oq.bounties[i] ;
    local s = "#".. i ..": " ;
    if (c) then
      for j,v in pairs(c) do
        s = s .."".. tostring(j) ..": ".. tostring(v) .." " ;
      end
      print( s ) ;
    end
--    if (c) and (c.end_tm) and (c.npc_id) then
--      print( i ..".  contract#".. c.id .."  target:".. tostring(c.name) .."(".. c.npc_id ..")  tm:".. c.end_tm - now ) ;
--    end
  end
  print( "---" ) ;
end

function oq.clear_the_book()
  local bb =  oq._bounty_board ;
  bb._current = nil ;  
  bb._pg = 0 ;
  for i=1,OQ.MAXBOUNTIES do
    if (oq.bounties[i]) then
      oq.bounties[i].start = nil ;
      oq.bounties[i].end_tm = nil ;
      oq.bounties[i].dur = nil ;
      oq.bounties[i].start_tm = nil ;
      oq.bounties[i].last_update = nil ;
      oq.bounties[i].id = nil ;
      oq.bounties[i].target = nil ;
      oq.bounties[i].reward = nil ;
      oq.bounties[i].name = nil ;
    end
  end
  oq.marquee.match_up:Hide() ;
  oq.update_bounty_page() ;
end

-- packet format:
--
-- bounty: bbbTTTTTTdddiiiccf
-- bbb     bounty id
-- TTTTTT  time started
-- ddd      duration 
-- iii     id of target mob
-- cc      crowns awarded 
-- f       flags; 6 bits; ab cdef = a: completed, b: 1-horde, 0-alli (only valid if a=1); c:expired
--
local _b = {} ;
function oq.on_thebook( n, start_tm, ... )
  n = tonumber(n or 0) ;
  start_tm = oq.decode_mime64_digits(start_tm) ;
  tbl.fill( _b, ... ) ;
  local bb =  oq._bounty_board ;
  local t1 = oq.decode_mime64_digits(_b[n+1]) or 0 ;
  if (bb._last_book_tm) and (t1 < bb._last_book_tm) then
    -- old data, disregard
    _ok2relay  = nil ;
    return ;
  end
  bb._last_book_tm = t1 ;

  local now = utc_time() ;
  local dT = (now - t1) ;
  if (n == nil) or (n == 0) then
    oq.clear_the_book() ;
    return ;
  end
  
  local p = bb._current ;
  local matchup_active = nil ;
  for i=1,n do
    -- process
    if (_b[i]) then
      local bid      = oq.decode_mime64_digits(_b[i]:sub( 1, 2)) ;
      local type     = oq.decode_mime64_digits(_b[i]:sub( 3, 3)) ;
      local start    = oq.decode_mime64_digits(_b[i]:sub( 4, 6)) ;
      local dur      = oq.decode_mime64_digits(_b[i]:sub( 7, 9)) ;
      local h_reward = oq.decode_mime64_digits(_b[i]:sub(10,11)) ;
      local a_reward = oq.decode_mime64_digits(_b[i]:sub(12,13)) ;
      local flags    = oq.decode_mime64_digits(_b[i]:sub(14,14)) ;
      local h_x      = oq.decode_mime64_digits(_b[i]:sub(15,17)) ; -- depends on type
      local a_x      = oq.decode_mime64_digits(_b[i]:sub(18,20)) ; -- depends on type

      oq.bounty_update( bid, type, start_tm + start, dur, h_reward, a_reward, flags, h_x, a_x, now, nil ) ;
      if (type > 1) and (type < 10) then
        matchup_active = true ;
        oq.marquee.match_up._end_tm = start_tm + start + dur ;
      end
    end
  end
  if (matchup_active) then
    if (oq.marquee:IsVisible()) and (not oq.marquee.match_up:IsVisible()) then
      oq.marquee.match_up:Show() ;
    end
  else
    oq.marquee.match_up:Hide() ;
  end
  -- remove any that didn't get updated
  for i=1,OQ.MAXBOUNTIES do
    if (oq.bounties[i]) and (oq.bounties[i].last_update) and (oq.bounties[i].last_update ~= now) then
      if (bb._current == oq.bounties[i].id) then
        bb._current = nil ;
      end
      oq.bounties[i] = tbl.delete( oq.bounties[i] ) ;
    end
  end
  if (p == nil) or (p == 0) or (bb._current == nil) then
    bb:top() ;
  end
  oq.update_bounty_page() ;
end

function oq.encode_bounty_collection( b, now )
  return oq.encode_mime64_3digit( b.id ) ..
         oq.encode_mime64_3digit( b.target ) ..
         oq.encode_mime64_6digit( now ) ;
end

function oq.is_bounty_target(id)
  if (id == nil) then
    return nil, nil ;
  end
  local now = utc_time() ;
  for i=1,OQ.MAXBOUNTIES do
    local b = oq.bounties[i] ;
    if (b) and (b.target) and (b.target > 0) and (b.expires > now) and (b.target == id) then
      return b.id, b ;
    end
  end
  return nil, nil ;
end

function oq.check_bounty_board( id ) 
  local now = utc_time() ;
  for i=1,OQ.MAXBOUNTIES do
    local b = oq.bounties[i] ;
    if (b) and (b.target) and (b.expires > now) and (b.target == id) then
      -- got one!
      local submit_token = "S".. oq.token_gen() ;
      oq.token_push( submit_token ) ;
      local msg = OQSK_HEADER ..",".. 
                  OQSK_VER ..","..
                  "W1,"..
                  "bty,"..
                  oq.encode_bounty_collection( b, now ) ..","..
                  tostring(player_name) ..",".. 
                  tostring(oq.realm_cooked(player_realm)) ..",".. 
                  tostring(player_faction) ..",".. 
                  tostring(player_realid) ..","..
                  submit_token ;
      oq.send_to_scorekeeper( msg ) ;
      break ;
    end
  end
end

--
-- packet format:
--
-- bounty: bbbTTTTTTdddiiiccf
-- bbb     bounty id
-- TTTTTT  time started
-- ddd      duration 
-- iii     id of target mob
-- cc      crowns awarded 
-- f       flags; 6 bits; ab cdef = a: completed, b: 1-horde, 0-alli (only valid if a=1); c:expired
--
-- claimed: bbbeeerr
-- bbb      bounty-id
-- eee      elapse time from start bounty collected
-- rr       realm-id of bounty hunter
-- ...      name of toon
--
function oq.update_bounty_page()
  local bb =  oq._bounty_board ;
  if (bb._pg <= 1) then
    oq.button_disable( bb._prev ) ;
  else
    oq.button_enable( bb._prev ) ;
  end
  if (bb._pg >= bb._npages) then
    oq.button_disable( bb._next ) ;
  else
    oq.button_enable( bb._next ) ;
  end
  
  if (bb._pg == 0) or (bb._npages == nil) or (bb._npages == 0) then
    oq.empty_bounty_board() ;
    return ;
  end
  
  oq.active_bounty_board() ;

  if (bb._pg == 0) or (bb._ndx == nil) or (oq.bounties[ bb._ndx ] == nil) then
    bb:top( true ) ;
  end
  
  local s = oq.bounties[ bb._ndx or 0 ] ;
  if (s) and (s.start) and (s.dur) then
    oq.set_bounty_target( s, s.start + s.dur ) ;
  end
end

function oq.update_bounty_clock()
  local bb =  oq._bounty_board ;
  local now = utc_time() ;
  if (bb._ndx == nil) then
    return ;
  end
  local s = oq.bounties[ bb._ndx ] ;
  if (s == nil) or (s.start == nil) then
    return ;
  end
  local dt = (s.start + s.dur) - now ;
  if (dt < 0) then
    dt = 0 ;
  end
  bb._remaining:SetText( string.format( "%3d:%02d", floor(dt/60), floor(dt%60) )) ;
end

function oq.empty_bounty_board() 
  local bb =  oq._bounty_board ;
  bb._page:Hide() ;  
  bb._reward_l:Hide() ;  
  bb._reward:Hide() ;  
  
  bb._remaining_l:Hide() ;  
  bb._remaining:Hide() ;  
  
  bb._poster:SetText( "<html><body>"..
                      "<br/>"..
                      "<br/>"..
                      "<h1 align=\"center\">".. 
                      "No Bounties Available".. 
                      "</h1>"..
                      "</body></html>" ) ;
end

function oq.active_bounty_board() 
  local bb =  oq._bounty_board ;
  bb._page:Show() ;  
  bb._reward_l:Show() ;  
  bb._reward:Show() ;  
  
  bb._remaining_l:Show() ;  
  bb._remaining:Show() ;  
end

function oq.set_bounty_target( s, end_tm ) 
  local bb =  oq._bounty_board ;
  local now = utc_time() ;
  local dt = end_tm - now ;
  if (dt < 0) then
    dt = 0 ;
  end
  
  bb._current = s.id ;
  bb._page:SetText( "Page ".. tostring(bb._pg) ) ;
  bb._reward:SetText( oq.get_crowns( s.reward ) ) ;
  bb._remaining:SetText( string.format( "%3d:%02d", floor(dt/60), floor(dt%60) )) ;
  if (s.type == 1) then
    bb._poster:SetText( "<html><body>"..
                        "<h3 align=\"right\">contract#".. s.id .."</h3>"..
                        "<h1>".. 
                        "Target: ".. 
                        "</h1><br/>"..
                        "<h2 align=\"center\">".. 
                        tostring(s.name)..
                        "</h2>"..
                        "</body></html>" ) ;
                        
    bb._horde_score_l   :Hide() ;
    bb._horde_score     :Hide() ; 
    bb._alliance_score_l:Hide() ;
    bb._alliance_score  :Hide() ; 
  elseif (s.type > 1) and (s.type < 10) then
    local spacer = "" ;
    if (strlen(s.name) <= 13) then
      spacer = "<br/>" ;
    end
    bb._poster:SetText( "<html><body>"..
                        "<h3 align=\"right\">contract#".. s.id .."</h3>"..
                        "<h1>".. 
                        "Target: ".. 
                        "</h1>".. spacer ..
                        "<h2 align=\"center\">".. 
                        tostring(s.name)..
                        "</h2>"..
                        "</body></html>" ) ;
    bb._horde_score_l   :Show() ;
    bb._horde_score     :Show() ; 
    bb._alliance_score_l:Show() ;
    bb._alliance_score  :Show() ; 
  end
end

function oq.toggle_filter( is_checked )
  local b = oq._filter ;
  if (is_checked) then
    -- show edit
    if (b._edit) then
      oq._filter._text = OQ_data._filter_text ;
      b._edit:SetText( oq._filter._text or "" ) ;
      b._edit:Show() ;
      b._edit:SetFocus() ;
    end
    PlaySound("igMainMenuOptionCheckBoxOn") ;
  else
    -- hide edit & clear filter text
    if (b._edit) then
      b._edit:Hide() ;
    end
    b._text = nil ;
    oq.reshuffle_premades() ; -- filter removed, force ui update
    PlaySound("igMainMenuOptionCheckBoxOff") ;
  end
end

function oq.update_filter( txt )
  oq._filter._text = txt ;
  OQ_data._filter_text = txt ;
  oq.reshuffle_premades() ;
end

function oq.pass_filter( p ) 
  if (p == nil) then
    return nil ;
  end
  local f = oq._filter._text ;
  if (f == nil) or (f == "") then
    return true ;
  end
  f = strlower(f) ;
  local t = strlower(p.name or "") ;
  if (t:find(f)) then
    return true ;
  end
  t = strlower(p.leader or "") ;
  if (t:find(f)) then
    return true ;
  end
  t = strlower(p.bgs or "") ;
  if (t:find(f)) then
    return true ;
  end
  return nil ;
end

function oq.filter_show()
  oq._filter:Show() ;
  if (oq._filter._was_filtering) then
    oq._filter._edit:Show() ;
    oq._filter._edit:SetFocus() ;
  end
end

function oq.filter_hide()
  oq._filter:Hide() ;
  oq._filter._was_filtering = oq._filter._edit:IsVisible() ;
  oq._filter._edit:Hide() ;
end

function oq.create_filter_button( parent ) 
  local x = 84 ;
  local y = 4 ;
  local cx = 24 ;
  local cy = 26 ;
  local b = CreateFrame( "CheckButton", nil, parent ) ;
  b:SetFrameLevel( parent:GetFrameLevel() + 1 ) ;
  b:RegisterForClicks('anyUp') ;
  b:SetWidth( cx ) ;
  b:SetHeight( cy ) ;
  b:SetPoint( "TOPLEFT", x, y ) ;

  local pt = b:CreateTexture()
  pt:SetTexture([[Interface\Buttons\UI-Quickslot-Depress]])
  pt:SetAllPoints(b)
  b:SetPushedTexture(pt)

  local ht = b:CreateTexture()
  ht:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
  ht:SetAllPoints(b)
  b:SetHighlightTexture(ht)

  local ct = b:CreateTexture()
  ct:SetTexture([[Interface\Buttons\CheckButtonHilight]])
  ct:SetAllPoints(b)
  ct:SetBlendMode('ADD')
  ct:SetAlpha(0.5) ;
  b:SetCheckedTexture(ct)

  local bdrop = b:CreateTexture(nil, "BORDER") ;
  bdrop:SetAllPoints(b)
  bdrop:SetTexture( 0, 0, 0.1, 1 ) ;
  
  local icon = b:CreateTexture()
  icon:SetTexture([[Interface\Icons\INV_Misc_Spyglass_03]])
  icon:SetPoint( "TOPLEFT"    , 2, -2 ) ;
  icon:SetPoint( "BOTTOMRIGHT", -2, 2 ) ;
  icon:SetTexCoord(3/64,60/64,3/64,60/64);
  
  b._edit = oq.editline( parent, "Filter", x, y, 130, cy, 15 )
  b._edit:SetPoint( "TOPLEFT", x + cx + 8, y-4 ) ;
  b._edit:SetWidth( 140 ) ;
  b._edit:SetHeight( cy ) ;
  b._edit:SetAlpha(1.0) ;
  if (OQ_data._filter_text ~= nil) then
    b._edit:SetText( OQ_data._filter_text ) ;
    b._edit:Show() ;
    b:SetChecked(true) ;
  else
    b._edit:Hide() ;
  end
--[[ will clear filter text; removed to allow user to hit esc to close the ui while keeping filter text
  b._edit:SetScript( "OnEscapePressed", 
          function(self) 
            self:ClearFocus() ; 
            self:SetText("") ;
            oq._filter:Click() ;
          end ) ;
]]--
  b._edit:SetScript( "OnTextChanged"  , function(self) oq.update_filter(self:GetText()) ; end ) ;

  b:SetScript( "OnClick", function(self) oq.toggle_filter( self:GetChecked() ) ; end ) ;
  b:Show() ;
  
  oq._filter = b ;
  return b ;
end

OQ.MAX_LOG_LINES = 43 ;
function oq.log( echo, ... )
  if (oq._log == nil) then
    return ;
  end
  local now = utc_time() ;
  tinsert( OQ_data._history, "|cFF00B000".. date("%H:%M:%S", now ) .."|r  ".. tostring(...) ) ;
  if (table.getn(OQ_data._history) > OQ.MAX_LOG_LINES) then
    local n = table.getn(OQ_data._history) - OQ.MAX_LOG_LINES ;
    for i=1,n do
      table.remove( OQ_data._history, 1 ) ;
    end
  end
  if (oq._log:IsVisible()) then
    oq._log:update_text() ;
  end
  if (echo) then
    print( ... ) ;
  end
end

function oq.toggle_log()
  if (oq._log) and (oq._log:IsVisible()) then
    oq._log:Hide() ;
  elseif (oq._log) then
    oq._log:Show() ;
    oq._log:Raise() ;
  end
end

function oq.log_realm_name() 
  oq.log( nil, "entering |cFFE0E000".. tostring(GetRealZoneText()) .."|r" ) ;
end

function oq.create_log_button( parent )
  local x = 56 ;
  local y = 4 ;
  local cx = 24 ;
  local cy = 26 ;
  local b = CreateFrame( "CheckButton", nil, parent ) ;
  b:SetFrameLevel( parent:GetFrameLevel() + 1 ) ;
  b:RegisterForClicks('anyUp') ;
  b:SetWidth( cx ) ;
  b:SetHeight( cy ) ;
  b:SetPoint( "TOPLEFT", x, y ) ;

  local pt = b:CreateTexture()
  pt:SetTexture([[INTERFACE/BUTTONS/UI-MicroButton-Spellbook-Down]])
  pt:SetAllPoints(b)
--  pt:SetTexCoord(2/32,29/32,25/64,61/64);
  pt:SetTexCoord(4/32,26/32,30/64,59/64);
  b:SetPushedTexture(pt)

  local ht = b:CreateTexture()
  ht:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
  ht:SetAllPoints(b)
  b:SetHighlightTexture(ht)

  local ct = b:CreateTexture()
  ct:SetTexture([[Interface\Buttons\CheckButtonHilight]])
  ct:SetAllPoints(b)
  ct:SetBlendMode('ADD')
  ct:SetAlpha(0.5) ;
  b:SetCheckedTexture(ct)

  local icon = b:CreateTexture()
  icon:SetAllPoints(b)
  icon:SetTexture( "INTERFACE/BUTTONS/UI-MicroButton-Spellbook-Up")
--  icon:SetTexCoord(2/32,29/32,25/64,61/64);  
  icon:SetTexCoord(4/32,26/32,30/64,59/64);

  b:SetScript( "OnClick", function(self) oq.toggle_log() ; end ) ;
  b:Show() ;

  local ht = b:CreateTexture()
  ht:SetTexture([[Interface\Buttons\ButtonHilight-Square]])
  ht:SetAllPoints(b)
  b:SetHighlightTexture(ht)
  
  local d = oq.CreateFrame( "FRAME", "OQLogBoard", UIParent ) ;
--  d:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
--                 edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
--                 tile=true, tileSize = 16, edgeSize = 16,
--                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
--                })
  d._save_position = function(self) 
                       OQ_data.log_x = max(0,floor(self:GetLeft())) ; 
                       OQ_data.log_y = max(0,floor(self:GetTop())) ; 
                     end ;

  d:SetBackdropColor(0.2,0.2,0.2,1.0);
  oq.make_frame_moveable( d ) ;
  oq.closebox( d ) ;
  d:SetScript( "OnShow", function(self) 
                           tinsert( UISpecialFrames, self:GetName() ) ; 
                           self:SetFrameLevel( 52 ) ; -- minimap button == 50
                           self:update_text() ;
                           PlaySound("igCharacterInfoOpen") ;
                         end ) ;
  d:SetScript( "OnHide", function(self) 
                           PlaySound("igCharacterInfoClose") ;
                         end ) ;

  d:SetPoint( "TOPLEFT", 100, -100 ) ;
  d:SetWidth ( 435 ) ;
  d:SetHeight( 518 ) ;
  d:SetFrameLevel( max( OQ_MinimapButton:GetFrameLevel(), parent:GetFrameLevel() ) + 10 ) ;
  
  d.update_text = function(self) 
                    local str = "<html><body>" ;
                    for i,v in pairs(OQ_data._history) do
                      str = str .."<h3>".. tostring(v) .."</h3>" ;
                    end
                    str = str .."</body></html>" ;
                    self._text:SetText( str ) ;
                  end ;

  local t = d:CreateTexture( nil, "ARTWORK" ) ;
  t:SetTexture( "INTERFACE/GUILDFRAME/GuildExtra" ) ;
  t:SetTexCoord( 0/512, 289/512, 0/128, 28/128 ) ;
  t:SetPoint( "TOPLEFT"    , d, "TOPLEFT" , 0,   0 ) ;
  t:SetPoint( "BOTTOMRIGHT", d, "TOPRIGHT", 0, -28 ) ;
  t:SetAlpha( 0.7 ) ;
  d.top_texture = t ;

  t = d:CreateTexture( nil, "ARTWORK" ) ;
  t:SetTexture( "INTERFACE/GUILDFRAME/GuildExtra" ) ;
  t:SetTexCoord( 0/512, 289/512, 36/128, 66/128 ) ;
  t:SetPoint( "TOPLEFT"    , d, "TOPLEFT"    , 0, -28 ) ;
  t:SetPoint( "BOTTOMRIGHT", d, "BOTTOMRIGHT", 0,  39 ) ;
  t:SetAlpha( 0.7 ) ;
  d.middle_texture = t ;

  t = d:CreateTexture( nil, "ARTWORK" ) ;
  t:SetTexture( "INTERFACE/GUILDFRAME/GuildExtra" ) ;
  t:SetTexCoord( 0/512, 289/512, 80/128, 119/128 ) ;
  t:SetPoint( "TOPLEFT"    , d, "BOTTOMLEFT" , 0,  39 ) ;
  t:SetPoint( "BOTTOMRIGHT", d, "BOTTOMRIGHT", 0,   0 ) ;
  t:SetAlpha( 0.7 ) ;
  d.bottom_texture = t ;

  t = d:CreateTexture( nil, "BACKGROUND" ) ;
  t:SetTexture( "INTERFACE/DialogFrame/UI-DialogBox-Background-Dark" ) ;
  t:SetPoint( "TOPLEFT"    , d, "TOPLEFT"    ,  10, -10 ) ;
  t:SetPoint( "BOTTOMRIGHT", d, "BOTTOMRIGHT", -10,  10 ) ;
  t:SetAlpha( 1.0 ) ;
  d.backdrop_texture = t ;

  local x = 25 ;
  local y = -23 ;
  d._text = oq.CreateFrame( "SimpleHTML", "OQLogPoster", d ) ;
  d._text:SetScript("OnHyperLinkClick", oq.onHyperlinkClick ) ;
  d._text:SetPoint( "TOPLEFT"    , x, y ) ;
  d._text:SetFont( "Fonts\\FRIZQT__.TTF", 12 ) ;
  d._text:SetWidth ( d:GetWidth() - 2*x ) ;
  d._text:SetHeight( d:GetHeight() - 2*abs(y) ) ;
  d._text:SetFont        ( 'h1', "Fonts\\FRIZQT__.TTF", 16 ) ;
  d._text:SetTextColor   ( 'h1', 0.9, 0.9, 0.9, 0.8 ) ;
  
  d._text:SetFont        ( 'h2', "Fonts\\MORPHEUS.ttf", 40 ) ;
  d._text:SetShadowColor ( 'h2', 0, 0, 0, 1 ) ;
  d._text:SetShadowOffset( 'h2', 1, -1 ) ;
  d._text:SetTextColor   ( 'h2', 128/255, 0/255, 0/255, 1.0 ) ;
  
  d._text:SetFont        ( 'h3', OQ.FONT_FIXED, 11 ) ;
  d._text:SetShadowColor ( 'h3', 0, 0, 0, 1 ) ;
  d._text:SetShadowOffset( 'h3', 0, 0 ) ;
  d._text:SetTextColor   ( 'h3', 0.9, 0.9, 0.9, 1.0 ) ;

  d._text:SetText( "" ) ; 
  
  d:Hide() ;
  oq._log = d ;
  
  if (OQ_data.log_x or OQ_data.log_y) then
    d:SetPoint( "TOPLEFT", UIParent, "BOTTOMLEFT", OQ_data.log_x, OQ_data.log_y ) ;
  end
  
  return b ;
end

function oq.tooltip_game_record( a, b )
  local s = "|cFFA0A0A0".. tostring(a or 0) .."|r" ;
  s = s .."|cFFB0B0B0".. " - " .."|r" ;
  s = s .."|cFFFFFF31".. tostring(b or 0) .."|r" ;
  return s ;
end

function oq.tooltip_game_record2( a, b, is_lead )
  local s = "|cFFA0A0A0" ;
  if (is_lead) then
    s = "|cFFFFFF31" ;
  end
  s = s .. tostring(a or 0) .." - ".. tostring(b or 0) .."|r" ;
  return s ;
end

function oq.tooltip_me_hide()
  local tooltip = oq.long_tooltip_create() ;
  tooltip:Hide() ;
end

function oq.tooltip_me()
  local tooltip = oq.long_tooltip_create() ;
  
  oq.gather_my_stats() ; -- force stats gather for display

  tooltip:ClearAllPoints() ;
  tooltip:SetParent( OQMainFrame, "ANCHOR_RIGHT" ) ;
  tooltip:SetPoint("TOPRIGHT", OQMainFrame, "TOPLEFT", -5, -20 ) ;
  tooltip:SetFrameLevel( OQMainFrame:GetFrameLevel() + 10 ) ;
  oq.tooltip_clear() ;

  local back_set = oq.vip_set_emphasis( tooltip, strlower(player_realid or ""), -20, true ) ;

  if (OQ.CLASS_COLORS[player_class] == nil) then
    return ;
  end

  local t = CLASS_ICON_TCOORDS[ OQ.LONG_CLASS[player_class] ] ;
  if t then
    tooltip.portrait.texture:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles") ;
    tooltip.portrait.texture:SetTexCoord(unpack(t)) ;
    tooltip.portrait.texture:SetAlpha( 1.0 ) ;
  end
  
  local color = OQ.CLASS_COLORS[player_class]
  
  tooltip.left [ 1]:SetText( player_name .." (".. tostring(player_level or 0) ..")" ) ;
  tooltip.left [ 1]:SetTextColor( color.r, color.g, color.b, 1 ) ;
  tooltip.left [ 2]:SetText( player_realm ) ;
  tooltip.left [ 2]:SetTextColor( 0.0, 0.9, 0.9, 1 ) ;
  
  tooltip.right[ 2]:SetText( oq.get_rank_icons( oq.get_pvp_experience() ) ) ;

  tooltip.left [ 3]:SetText( oq.find_bgroup( player_realm ) ) ;
  tooltip.left [ 3]:SetTextColor( 0.8, 0.8, 0.8, 1 ) ;

  tooltip.left [ 4]:SetText( OQ.TT_BATTLE_TAG ) ;
  tooltip.right[ 4]:SetText( player_realid ) ;
  
  tooltip.left [ 5]:SetText( OQ.TT_KARMA ) ;
  if (player_karma ~= nil) and (player_karma ~= 0) then
    tooltip.right[ 5]:SetText( oq.karma_color( player_karma ) .."".. tostring(player_karma) .."|r" ) ;
  else
    tooltip.right[ 5]:SetText( "--" ) ;
  end

  tooltip.left [ 6]:SetText( OQ.TT_ILEVEL ) ;
  tooltip.right[ 6]:SetText( player_ilevel ) ;

  tooltip.left [ 7]:SetText( OQ.TT_TEARS ) ;
  tooltip.right[ 7]:SetText( tostring(oq.total_tears()) ) ;
  
  tooltip.left [ 8]:SetText( OQ.TT_REGULAR_BG ) ;
  tooltip.right[ 8]:SetText( "" ) ;
--  tooltip.right[ 8]:SetText( oq.tooltip_game_record( OQ_toon.stats["bg"].nGames, OQ_data.leader["bg"].nGames )) ;
  
  tooltip.left [ 9]:SetText( "-  ".. OQ.TT_PERSONAL ) ;
  tooltip.right[ 9]:SetText( oq.tooltip_game_record2( OQ_toon.stats["bg"].nWins, OQ_toon.stats["bg"].nLosses, nil ) ) ;
  
  tooltip.left [10]:SetText( "-  ".. OQ.TT_ASLEAD ) ;
  local tag, y, cx, cy, bg_title = oq.get_dragon_rank( OQ.TYPE_BG, OQ_data.leader["bg"].nWins ) ;  
  if (tag) then
    if (y == 0) then
      tooltip.right[10]:SetText( "|T".. tag ..":32:32|t ".. oq.tooltip_game_record2( OQ_data.leader["bg"].nWins, OQ_data.leader["bg"].nLosses, true )) ;
    else
      tooltip.right[10]:SetText( "|T".. tag ..":20:20|t ".. oq.tooltip_game_record2( OQ_data.leader["bg"].nWins, OQ_data.leader["bg"].nLosses, true )) ;
    end
  else
    tooltip.right[10]:SetText( oq.tooltip_game_record2( OQ_data.leader["bg"].nWins, OQ_data.leader["bg"].nLosses, true )) ;
  end

  tooltip.left [11]:SetText( OQ.LABEL_RBGS ) ;
  tooltip.right[11]:SetText( "" ) ;
--  tooltip.right[11]:SetText( oq.tooltip_game_record( OQ_toon.stats["rbg"].nGames, OQ_data.leader["rbg"].nGames )) ;
  
  tooltip.left [12]:SetText( "-  ".. OQ.TT_PERSONAL ) ;
  tooltip.right[12]:SetText( oq.tooltip_game_record2( OQ_toon.stats["rbg"].nWins, OQ_toon.stats["rbg"].nLosses, nil ) ) ;
  
  tooltip.left [13]:SetText( "-  ".. OQ.TT_ASLEAD ) ;
  local tag, y, cx, cy, rbg_title = oq.get_dragon_rank( OQ.TYPE_RBG, OQ_data.leader["rbg"].nWins ) ;  
  if (tag) then
    if (y == 0) then
      tooltip.right[13]:SetText( "|T".. tag ..":32:32|t ".. oq.tooltip_game_record2( OQ_data.leader["rbg"].nWins, OQ_data.leader["rbg"].nLosses, true )) ;
    else
      tooltip.right[13]:SetText( "|T".. tag ..":20:20|t ".. oq.tooltip_game_record2( OQ_data.leader["rbg"].nWins, OQ_data.leader["rbg"].nLosses, true )) ;
    end
  else
    tooltip.right[13]:SetText( oq.tooltip_game_record2( OQ_data.leader["rbg"].nWins, OQ_data.leader["rbg"].nLosses, true )) ;
  end
  -- set dragon
  if ((bg_title == "golden") or (rbg_title == "golden")) and (back_set ~= true) then
    oq.vip_set_dragon( tooltip, "golden-dragon", -50, true ) ;
  elseif ((bg_title == "silver") or (rbg_title == "silver")) and (back_set ~= true) then
    oq.vip_set_dragon( tooltip, "dragon", -50, true ) ;
  elseif ((bg_title == "general") or (rbg_title == "general")) and (back_set ~= true) then
    oq.vip_set_dragon( tooltip, "general-".. oq._player_faction, -50, true ) ;
  elseif ((bg_title == "knight") or (rbg_title == "knight")) and (back_set ~= true) then
    oq.vip_set_dragon( tooltip, "knight-".. oq._player_faction, -50, true ) ;
  elseif (back_set ~= true) then
    oq.vip_clear( tooltip ) ;
  end
  
  tooltip.left [14]:SetText( OQ.TT_MMR ) ;
  local s = "|cFFF08040".. tostring(oq.get_arena_rating(1)) .."|r "..
   "|cFFF0F0A0".. tostring(oq.get_arena_rating(2)) .."|r "..
   "|cFFF08040".. tostring(oq.get_arena_rating(3)) .."|r "..
   "|cFFF0F0A0".. tostring(oq.get_mmr()) .."|r" ;
  
  tooltip.right[14]:SetText( s ) ;

  tooltip.left [15]:SetText( OQ.TT_5MANS ) ;
  tooltip.right[15]:SetText( tostring(OQ_data.leader["pve.5man"].nBosses or 0) .." - ".. tostring(OQ_data.leader["pve.5man"].nWipes or 0) ) ;
  
  tooltip.left [16]:SetText( OQ.TT_RAIDS ) ;
  tooltip.right[16]:SetText( tostring(OQ_data.leader["pve.raid"].nBosses or 0) .." - ".. tostring(OQ_data.leader["pve.raid"].nWipes or 0) ) ;
  
  tooltip.left [17]:SetText( OQ.TT_CHALLENGES ) ;
  tooltip.right[17]:SetText( tostring(OQ_data.leader["pve.challenge"].nBosses or 0) .." - ".. tostring(OQ_data.leader["pve.challenge"].nWipes or 0) ) ;
  
  tooltip.left [18]:SetText( OQ.TT_LEADER_DKP ) ;
  local tag, y, cx, cy, title = oq.get_dragon_rank( OQ.TYPE_DUNGEON, OQ_data.leader_dkp ) ;  
  if (tag) then
    if (y == 0) then
      tooltip.right[18]:SetText( "|T".. tag ..":32:32|t ".. tostring(OQ_data.leader_dkp or 0)) ;
    else
      tooltip.right[18]:SetText( "|T".. tag ..":20:20|t ".. tostring(OQ_data.leader_dkp or 0)) ;
    end
  else
    tooltip.right[18]:SetText( tostring(OQ_data.leader_dkp or 0) ) ;
  end
  
  tooltip.left [19]:SetText( OQ.TT_DKP ) ;
  tooltip.right[19]:SetText( tostring(OQ_data._dkp or 0) ) ;
  
  tooltip.left [tooltip.nRows - 0]:SetText( oq.get_rank_achieves( oq.get_pvp_experience() ) ) ;
  tooltip.right[tooltip.nRows - 0]:SetText( "" ) ;
    
  -- adjust dimensions of the box
  local w = tooltip.left[1]:GetStringWidth() ;
  for i=4,tooltip.nRows do
    tooltip.right[ i]:SetWidth( tooltip:GetWidth() - 30 ) ;
  end

  tooltip:Show() ;
end

function oq.create_tab1_bgs( parent )
  local x, y, cx, cy, label_cx ;

  oq.tab1_group = {} ;
  x = 20 ;
  y = 65 ;
  cx = parent:GetWidth() - 2 * x ;
  cy = (parent:GetHeight() - 2*y) / 10 ;
  label_cx = 150 ;

  -- group menus
  for i=1,8 do
    local f = oq.create_group( parent, x, y, cx, cy, label_cx, tostring(i), i ) ;
    f.slot = i ;
    f:Show() ;
    y = y + cy + 2 ;
    oq.tab1_group[i] = f ;
  end
  
  -- battleground selector
  oq.tab1_bg = {} ;
  oq.tab1_bg[1] = {} ;
  oq.tab1_bg[1].queue_button = oq.button( parent, 450, y, 100, 28, "queue", function(self, button) oq.queue_button_action(self, button, 1) ; end ) ;
  oq.tab1_bg[1].queue_button:RegisterForClicks( "AnyUp" ) ;
  oq.tab1_bg[1].queue_button:SetText( OQ.LEAVE_QUEUE ) ;
  oq.tab1_bg[1].queue_button:Show() ;
  oq.tab1_bg[1].status = "0" ;

  oq.tab1_bg[2] = {} ;
  oq.tab1_bg[2].queue_button = oq.button( parent, 625, y, 100, 28, "queue", function(self, button) oq.queue_button_action(self, button, 2) ; end ) ;
  oq.tab1_bg[2].queue_button:RegisterForClicks( "AnyUp" ) ;
  oq.tab1_bg[2].queue_button:SetText( OQ.LEAVE_QUEUE ) ;
  oq.tab1_bg[2].queue_button:Show() ;
  oq.tab1_bg[2].status = "0" ;
end

function oq.create_tab1_dungeon( parent )
  local x, y, cx, cy, label_cx ;
  local group_id = 1 ; -- only one group
  
  x  = 20 ;
  y  = 65 ;
  cx = 50 ;
  cy = 50 ;
  label_cx = 150 ;
  
  oq.dungeon_group = oq.create_dungeon_group( parent, x, y, parent:GetWidth()-x*2, 250, label_cx, title, group_id ) ;
end

function oq.create_tab1_challenge( parent )
  local x, y, cx, cy, label_cx ;
  local group_id = 1 ; -- only one group
  
  x  = 20 ;
  y  = 65 ;
  cx = 50 ;
  cy = 50 ;
  label_cx = 150 ;
  
  oq.challenge_group = oq.create_challenge_group( parent, x, y, parent:GetWidth()-x*2, 250, label_cx, title, group_id ) ;
end

function oq.create_tab1_ratedbgs( parent )
  local x, y, cx, cy, label_cx ;

  oq.rbgs_group = {} ;
  x = 20 ;
  y = 65 ;
  cx = parent:GetWidth() - 2 * x ;
  cy = (parent:GetHeight() - 2*y) / 10 ;
  label_cx = 150 ;

  -- group menus
  for i=1,2 do
    local f = oq.create_group( parent, x, y, cx, cy, label_cx, tostring(i), i ) ;
    f.slot = i ;
    f:Show() ;
    y = y + cy + 2 ;
    oq.rbgs_group[i] = f ;
  end
end

function oq.create_tab1_raid( parent )
  local x, y, cx, cy, label_cx ;

  oq.raid_group = {} ;
  x = 20 ;
  y = 65 ;
  cx = parent:GetWidth() - 2 * x ;
  cy = (parent:GetHeight() - 2*y) / 10 ;
  label_cx = 150 ;

  -- groups
  for i=1,8 do
    local f = oq.create_group( parent, x, y, cx, cy, label_cx, tostring(i), i ) ;
    f.slot = i ;
    f:Show() ;
    y = y + cy + 2 ;
    oq.raid_group[i] = f ;
  end
end

function oq.create_tab1_scenario( parent )
  local x, y, cx, cy, label_cx ;
  local group_id = 1 ; -- only one group
  
  x  = 20 ;
  y  = 65 ;
  cx = 50 ;
  cy = 50 ;
  label_cx = 150 ;
  
  oq.scenario_group = oq.create_scenario_group( parent, x, y, parent:GetWidth()-x*2, 250, label_cx, title, group_id ) ;
end

function oq.create_tab1_arena( parent )
  local x, y, cx, cy, label_cx ;
  local group_id = 1 ; -- only one group
  
  x  = 20 ;
  y  = 65 ;
  cx = 50 ;
  cy = 50 ;
  label_cx = 150 ;
  
  oq.arena_group = oq.create_arena_group( parent, x, y, parent:GetWidth()-x*2, 250, label_cx, title, group_id ) ;
end

function oq.create_tab1_ladder( parent )
  local x, y, cx, cy, label_cx ;
  local group_id = 1 ; -- only one group

  x = 20 ;
  y = 65 ;
  cx = parent:GetWidth() - 2 * x ;
  cy = (parent:GetHeight() - 2*y) ;
  cy = 250 ;
  label_cx = 150 ;

  oq.ladder_group = oq.create_ladder_group( parent, x, y, cx, cy, label_cx, title, group_id ) ;
  
  -- create ladder seats
  oq.ladder_seats = oq.create_ladder_seats( parent, x, y, cx, cy ) ;
  
  -- match up button
  local iy, ix ;
  iy = 16 ;
  ix = 16 ;

  x = x + (cx - 100)/2
  oq.button( parent, x, cy, 100, 28, OQ.MATCHUP, function(self) self:GetParent().matchup( self ) ; end ) ;

end

function oq.create_ladder_seats( parent, x_, y_, cx_, cy_ ) 
  local seats = {} ; 
  local ndx = 1 ;
  local x, y, cx, cy, dy ;
  
  cx = 20 ;
  cy = 20 ;
  
  --[[ 1st round - elimination round ]]--
  dy = 8 ;
  -- left side
  x = x_ + cx/2 ;
  y = y_ ;
  for i=1,8 do
    seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
    ndx = ndx + 1 ;
    y = y + cy + dy ;
    if ((i % 2) == 0) then
      y = y + dy ;
    end
  end
  -- right side
  x = x_ + cx_ - 3*cx/2 ;
  y = y_ ;
  for i=1,8 do
    seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
    ndx = ndx + 1 ;
    y = y + cy + dy ;
    if ((i % 2) == 0) then
      y = y + dy ;
    end
  end
  
  --[[ 2nd round - quarter finals ]]--
  dy = 12 ;
  -- left side
  x = x_ + (cx_/8) ;
  y = y_ + (cy_/4) - (cy + dy) ;
  for i=1,4 do
    seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
    ndx = ndx + 1 ;
    y = y + cy + dy ;
    if ((i % 2) == 0) then
      y = y_ + (3*cy_/4) - (cy + dy) ;
    end
  end
  -- right side
  x = x_ + cx_ - (cx_/8) - cx ;
  y = y_ + (cy_/4) - (cy + dy) ;
  for i=1,4 do
    seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
    ndx = ndx + 1 ;
    y = y + cy + dy ;
    if ((i % 2) == 0) then
      y = y_ + (3*cy_/4) - (cy + dy) ;
    end
  end
  
  --[[ 3rd round - semi finals ]]--
  dy = 16 ;
  -- left side
  x = x_ + (2*cx_/8) ;
  y = y_ + (cy_/2) - (cy + dy) ;
  seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
  ndx = ndx + 1 ;
  y = y_ + (cy_/2) + dy ;
  seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
  ndx = ndx + 1 ;

  -- right side
  x = x_ + cx_ - (2*cx_/8) - cx ;
  y = y_ + (cy_/2) - (cy + dy) ;
  seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
  ndx = ndx + 1 ;
  y = y_ + (cy_/2) + dy ;
  seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
  ndx = ndx + 1 ;
  
  --[[ final round ]]--
  -- left side
  x = x_ + (3*cx_/8) ;
  y = y_ + (cy_/2) - cy/2 ;
  seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
  ndx = ndx + 1 ;
  -- right side
  x = x_ + cx_ - (3*cx_/8) - cx ;
  y = y_ + (cy_/2) - cy/2 ;
  seats[ndx] = oq.create_ladder_seat( parent, x, y, cx, cy ) ;
  ndx = ndx + 1 ;
  
  return seats ;
end

function oq.create_tab1_common( parent )
  local x, y, cx, cy, label_cx ;
  x = 20 ;
  y = 65 ;
  cx = parent:GetWidth() - 2 * x ;
  cy = (parent:GetHeight() - 2*y) / 10 ;
  label_cx = 150 ;
  
  -- raid title
  oq.tab1_name = oq.label( parent, x, 30, 300, 30, "" ) ;
  oq.tab1_name:SetFont(OQ.FONT, 14, "") ;

  -- raid notes
  y = parent:GetHeight() - cy*2 - 45 ;
  oq.tab1_notes_label = oq.label( parent, x, y     , 100, 20, "notes:" ) ;
  oq.tab1_notes       = oq.label( parent, x, y + 12, 285, cy*2 - 10, "" ) ;
  oq.tab1_notes:SetNonSpaceWrap(true) ;
  oq.tab1_notes_label:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;
  oq.tab1_notes:SetTextColor( 0.9, 0.9, 0.9, 1 ) ;

  --[[ tag and version ]]--
  oq.tab1_tag = oq.place_tag( parent ) ;
  OQFrameHeaderLogo:SetText( OQ.TITLE_LEFT .."".. OQUEUE_VERSION .."".. OQ.TITLE_RIGHT ) ;

  -- brb button
  oq.tab1_brb_button = oq.button( parent, 300, y, 100, 28, OQ.ILL_BRB, 
                                  function(self) oq.brb() ; end ) ;

  -- lucky charms  
  y = y + 30 ;
  oq.tab1_lucky_charms = oq.button( parent, 250, parent:GetHeight()-40, 100, 25, OQ.LUCKY_CHARMS, 
                                    function(self) oq.assign_lucky_charms() ; end ) ;
  oq.tab1_lucky_charms:Hide() ;
  -- ready check
  oq.tab1_readycheck_button = oq.button( parent, 350, parent:GetHeight()-40, 100, 25, OQ.READY_CHK, 
                                         function(self) oq.start_ready_check() ; end ) ;

  -- quit premade
  oq.tab1_quit_button = oq.button( parent, parent:GetWidth()-155, parent:GetHeight()-40, 145, 25, OQ.LEAVE_PREMADE, 
                                   function(self) oq.quit_raid() ; end ) ;

  -- raid stats (ie: "5 / 4000 / 455" )
  x = parent:GetWidth()-155 - 110 ;
  y = parent:GetHeight() -  35 ;
  oq.tab1_raid_stats = oq.label( parent, x, y, 100, 15, "" ) ;  
  oq.tab1_raid_stats:SetJustifyH("RIGHT") ;
  oq.tab1_raid_stats:SetTextColor( 0.8, 0.8, 0.8, 1 ) ;
end

function oq.set_premade_type( t )
  oq.raid.type = t ;
  if (oq.iam_raid_leader()) then
    if (t == OQ.TYPE_RBG) or (t == OQ.TYPE_RAID) then
      ConvertToRaid() ;
    else
      ConvertToParty() ;
    end
  end
  
  if (OQTabPage7.header1 ~= nil) then
    if (oq.is_dungeon_premade() or (oq.raid.type == OQ.TYPE_RAID)) then
      -- change headers
      OQTabPage7.header1.label:SetText( OQ.HDR_HASTE ) ;
      OQTabPage7.header1.sortby = "haste" ;
      OQTabPage7.header2.label:SetText( OQ.HDR_MASTERY ) ;
      OQTabPage7.header2.sortby = "mastery" ;
      OQTabPage7.header3.label:SetText( OQ.HDR_HIT ) ;
      OQTabPage7.header3.sortby = "hit" ;
    else
      -- change headers
      OQTabPage7.header1.label:SetText( OQ.HDR_RESIL ) ;
      OQTabPage7.header1.sortby = "resil" ;
      OQTabPage7.header2.label:SetText( OQ.HDR_PVPPOWER ) ;
      OQTabPage7.header2.sortby = "power" ;
      OQTabPage7.header3.label:SetText( OQ.HDR_MMR ) ;
      OQTabPage7.header3.sortby = "mmr" ;
    end
  end
  
  -- hide all
  oq.ui.bg_frame       :Hide() ;  
  oq.ui.challenge_frame:Hide() ;
  oq.ui.dungeon_frame  :Hide() ;
  oq.ui.ratedbgs_frame :Hide() ;
  oq.ui.arena_frame    :Hide() ;
  oq.ui.raid_frame     :Hide() ;  
  oq.ui.scenario_frame :Hide() ;  
  oq.ui.ladder_frame   :Hide() ;  
  
  if (OQTabPage1:IsVisible()) then
    -- force the showing of the frame, incase the type changed 
    oq.onShow_tab1() ;
    oq.refresh_textures() ;
  end
end

function oq.onShow_tab1()
  -- hide all
  oq.ui.bg_frame       :Hide() ;  
  oq.ui.challenge_frame:Hide() ;
  oq.ui.dungeon_frame  :Hide() ;
  oq.ui.ratedbgs_frame :Hide() ;
  oq.ui.arena_frame    :Hide() ;
  oq.ui.raid_frame     :Hide() ;  
  oq.ui.scenario_frame :Hide() ;  
  oq.ui.ladder_frame   :Hide() ;  
  
  if (oq.raid.type == OQ.TYPE_BG) then
    oq.ui.bg_frame:Show() ;  
  elseif (oq.raid.type == OQ.TYPE_CHALLENGE) then
    oq.ui.challenge_frame:Show() ;
  elseif (oq.raid.type == OQ.TYPE_DUNGEON) then
    oq.ui.dungeon_frame:Show() ;
  elseif (oq.raid.type == OQ.TYPE_RBG) then
    oq.ui.ratedbgs_frame:Show() ;
  elseif (oq.raid.type == OQ.TYPE_RAID) then
    oq.ui.raid_frame:Show() ;
  elseif (oq.raid.type == OQ.TYPE_SCENARIO) then
    oq.ui.scenario_frame:Show() ;
  elseif (oq.raid.type == OQ.TYPE_ARENA) then
    oq.ui.arena_frame:Show() ;
  elseif (oq.raid.type == OQ.TYPE_QUESTS) then
    oq.ui.challenge_frame:Show() ;
  elseif (oq.raid.type == OQ.TYPE_LADDER) then
    oq.ui.ladder_frame:Show() ;
  end
end

function oq.create_tab1()
  local cx = OQTabPage1:GetWidth() ;
  local cy = OQTabPage1:GetHeight() ;
  local level = OQTabPage1:GetFrameLevel() + 2 ;

  OQTabPage1:SetScript( "OnShow", function() 
                                    oq.onShow_tab1() ; 
                                    oq.refresh_textures() ; 
                                    if (oq.iam_raid_leader()) then 
                                      oq.ui_raidleader() ; 
                                    else 
                                      oq.ui_player() ;
                                    end
                                  end ) ;

  -- create common elements
  oq.create_tab1_common( OQTabPage1 ) ;
  
  -- create specific component: battlegrounds
  oq.ui.bg_frame = oq.panel( OQTabPage1, "OQPage1BGs", 0, 0, cx, cy, true ) ;
  oq.ui.bg_frame:SetFrameLevel( level ) ;
  oq.create_tab1_bgs( oq.ui.bg_frame ) ;
  
  -- create specific component: dungeons
  oq.ui.dungeon_frame = oq.panel( OQTabPage1, "OQPage1Dungeon", 0, 0, cx, cy, true ) ;
  oq.ui.dungeon_frame:SetFrameLevel( level ) ;
  oq.create_tab1_dungeon( oq.ui.dungeon_frame ) ;
  
  -- create specific component: challenge
  oq.ui.challenge_frame = oq.panel( OQTabPage1, "OQPage1Challenge", 0, 0, cx, cy, true ) ;
  oq.ui.challenge_frame:SetFrameLevel( level ) ;
  oq.create_tab1_challenge( oq.ui.challenge_frame ) ;
  
  -- create specific component: rated-bgs
  oq.ui.ratedbgs_frame = oq.panel( OQTabPage1, "OQPage1RatedBGs", 0, 0, cx, cy, true ) ;
  oq.ui.ratedbgs_frame:SetFrameLevel( level ) ;
  oq.create_tab1_ratedbgs( oq.ui.ratedbgs_frame ) ;
  
  -- create specific component: raid
  oq.ui.raid_frame = oq.panel( OQTabPage1, "OQPage1Raid", 0, 0, cx, cy, true ) ;
  oq.ui.raid_frame:SetFrameLevel( level ) ;
  oq.create_tab1_raid( oq.ui.raid_frame ) ;
  
  -- create specific component: scenario
  oq.ui.scenario_frame = oq.panel( OQTabPage1, "OQPage1Scenario", 0, 0, cx, cy, true ) ;
  oq.ui.scenario_frame:SetFrameLevel( level ) ;
  oq.create_tab1_scenario( oq.ui.scenario_frame ) ;
  
  -- create specific component: arena
  oq.ui.arena_frame = oq.panel( OQTabPage1, "OQPage1Arena", 0, 0, cx, cy, true ) ;
  oq.ui.arena_frame:SetFrameLevel( level ) ;
  oq.create_tab1_arena( oq.ui.arena_frame ) ;
  
  -- create specific component: ladder
  oq.ui.ladder_frame = oq.panel( OQTabPage1, "OQPage1Ladder", 0, 0, cx, cy, true ) ;
  oq.ui.ladder_frame:SetFrameLevel( level ) ;
  oq.create_tab1_ladder( oq.ui.ladder_frame ) ;
  oq.ui.ladder_frame.matchup = oq.ladder_matchup ;
  
  -- show appropriate frame
  if (oq.raid == nil) or (oq.raid.type == nil) then
    oq.set_premade_type( OQ.TYPE_BG ) ;
  else
    oq.set_premade_type( oq.raid.type ) ;
  end
  
  -- enable proper controls
  oq.ui_player() ;
end

function oq.ladder_matchup( self )
print( "match up" ) ;
  local slots = oq.ladder_group.slots ;
  -- move dots 2-16 into ladder positions... randomly  
end

--  TODO: lighter weight scrolling:
--
--  http://us.battle.net/wow/en/forum/topic/9499431654
--
function oq.create_scrolling_list( parent, type_ )
  local scroll = oq.CreateFrame( "ScrollFrame", parent:GetName() .."ListScrollBar", parent, "FauxScrollFrameTemplate" ) ;
  scroll:SetScript("OnVerticalScroll", function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset, 16, OQ_ModScrollBar_Update); end ) ;
  scroll:SetScript("OnShow", function(self) OQ_ModScrollBar_Update(self) ; end ) ;
  scroll._type = type_ ;

  local list = oq.CreateFrame( "Frame", parent:GetName() .."List", scroll ) ;
  list:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                 edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                 tile=true, tileSize = 16, edgeSize = 16,
                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
                 })
  list:SetBackdropColor(0.0,0.0,0.0,1.0);
  oq.setpos( list, 0, 0, parent:GetWidth() - 2*30, 1000 ) ;

  scroll:SetScrollChild( list ) ;
  scroll:Show() ;
  
  return scroll, list ;
end

function oq.sort_premades( col )
  local order = oq.premade_sort_ascending ;
  if (oq.premade_sort ~= col) then
    order = true ;
  else
    if (order) then
      order = nil ;
    else
      order = true ;
    end
  end
  oq.premade_sort = col ;
  oq.premade_sort_ascending = order ;
  oq.reshuffle_premades() ;
end

function oq.on_premade_filter( arg1, arg2 )
  oq.premade_filter_type = arg1 ;
  oq.reshuffle_premades() ;
end

OQ._premade_types = { { text = OQ.LABEL_ALL       , arg1 = OQ.TYPE_NONE },
                      { text = OQ.LABEL_ARENAS    , arg1 = OQ.TYPE_ARENA },
                      { text = OQ.LABEL_BGS       , arg1 = OQ.TYPE_BG },
                      { text = OQ.LABEL_DUNGEONS  , arg1 = OQ.TYPE_DUNGEON },
                      { text = OQ.LABEL_QUESTERS  , arg1 = OQ.TYPE_QUESTS },
                      { text = OQ.LABEL_RBGS      , arg1 = OQ.TYPE_RBG },
                      { text = OQ.LABEL_RAIDS     , arg1 = OQ.TYPE_RAID },
                      { text = OQ.LABEL_SCENARIOS , arg1 = OQ.TYPE_SCENARIO },
                      { text = OQ.LABEL_CHALLENGES, arg1 = OQ.TYPE_CHALLENGE },
                    } ;
function oq.get_premade_type_desc( t )
  for i,v in pairs(OQ._premade_types) do
    if (v.arg1 == t) then
      return v.text ;
    end
  end
  return "" ;
end

--
-- good page for docs:
-- http://www.wowpedia.org/API_UIDropDownMenu_AddButton
-- 
OQ.findpremade_types = { { text = OQ.LABEL_ALL       , arg1 = OQ.TYPE_NONE },
                         { text = OQ.LABEL_ARENAS    , arg1 = OQ.TYPE_ARENA },
                         { text = OQ.LABEL_BGS       , arg1 = OQ.TYPE_BG },
                         { text = OQ.LABEL_CHALLENGES, arg1 = OQ.TYPE_CHALLENGE },
                         { text = OQ.LABEL_DUNGEONS  , arg1 = OQ.TYPE_DUNGEON },
                         { text = OQ.LABEL_QUESTERS  , arg1 = OQ.TYPE_QUESTS },
                         { text = OQ.LABEL_RBGS      , arg1 = OQ.TYPE_RBG },
                         { text = OQ.LABEL_RAIDS     , arg1 = OQ.TYPE_RAID },
                         { text = OQ.LABEL_SCENARIOS , arg1 = OQ.TYPE_SCENARIO },
                       } ;
function oq.make_dropdown_premade_filter() 
  local m = oq.menu_create() ;
  for i,v in pairs(OQ.findpremade_types) do
    local text = v.text ;
    if (v.arg1 ~= OQ.TYPE_NONE) then
      local n = oq.premades_of_type( v.arg1 ) ;
      if (n > 0) then
        text  = v.text .." ( ".. string.format("|cFFFFD331%d|r",n) .." )" ;
      end
    end
    
    oq.menu_add( text, v.arg1, text, nil, 
                 function(cb_edit,arg1,arg2) 
                   oq.on_premade_filter( arg1, arg2 ) ; 
                   cb_edit:SetText( arg2 ) ;
                   oq.tab2_scroller:SetVerticalScroll(0) ;
                   return true ; 
                 end 
               ) ;
  end
  return m ;  
end

function oq.update_findpremade_selection()
  if (oq.premade_filter_type ~= OQ.TYPE_NONE) then
    local n = oq.premades_of_type( oq.premade_filter_type ) ;
    local text = oq.get_premade_type_desc( oq.premade_filter_type ) ;
    if (n > 0) then
      text = text .." ( ".. string.format("|cFFFFD331%d|r",n) .." )" ;
    end
    oq.tab2_filter._edit:SetText( text ) ;
  end
end

function oq.update_premade_count() 
  local nShown, nPremades = oq.n_premades() ;

  local str = string.format( "%s  (|cFFE0E0E0%d|r - |cFF808080%d|r)", OQ.HDR_PREMADE_NAME, nShown, nPremades ) ;
  oq.premade_hdr.label:SetText( str ) ;
  oq.update_findpremade_selection() ;
end

function oq.create_tab2()
  local parent = OQTabPage2 ;
  local x, y, cx, cy ;

  -- sorting and filtering presets
  oq.premade_sort = "name" ;
  oq.premade_sort_ascending = true ;
  oq.premade_filter_qualified = 0 ;
  oq.premade_filter_type = OQ.TYPE_NONE ; -- show all premade types
  
  parent:SetScript( "OnShow", function() oq.populate_tab2() ; oq.filter_show() ; end ) ;
  parent:SetScript( "OnHide", function() oq.filter_hide() ; end ) ;

  oq.tab2_scroller, oq.tab2_list = oq.create_scrolling_list( parent, "premades" ) ;
  
  local f = oq.tab2_scroller ;
  oq.setpos( f, -40, 50, f:GetParent():GetWidth() - 2*30, f:GetParent():GetHeight() - (50+38) ) ;

  -- list header
  cy = 20 ;
  x  = 20 + 15 ;
  y  = 27 ;
  f = oq.click_label( parent, x, y, 185, cy, OQ.HDR_PREMADE_NAME  ) ;  x = x + 185 ;
  f:SetScript("OnClick", function(self) oq.sort_premades( "name" ) ; end ) ;
  oq.premade_hdr = f ;
  
  f = oq.click_label( parent, x, y,  90, cy, OQ.HDR_LEADER        ) ;  x = x +  90 ;
  f:SetScript("OnClick", function(self) oq.sort_premades( "lead" ) ; end ) ;
  f = oq.click_label( parent, x, y,  45, cy, OQ.HDR_LEVEL_RANGE   ) ;  x = x +  47 ;
  f:SetScript("OnClick", function(self) oq.sort_premades( "level" ) ; end ) ;
  f = oq.click_label( parent, x, y,  40, cy, OQ.HDR_ILEVEL        ) ;  x = x +  40 ;
  f:SetScript("OnClick", function(self) oq.sort_premades( "ilevel" ) ; end ) ;
  f = oq.click_label( parent, x, y,  45, cy, OQ.HDR_RESIL         ) ;  x = x +  45 ;
  f:SetScript("OnClick", function(self) oq.sort_premades( "resil" ) ; end ) ;
  f = oq.click_label( parent, x, y,  45, cy, OQ.HDR_MMR           ) ;  x = x +  45 ;
  f:SetScript("OnClick", function(self) oq.sort_premades( "mmr" ) ; end ) ;

  x = parent:GetWidth() - 200 ;
  oq.tab2_nfriends = oq.label( parent, x, y, 150, cy, string.format( OQ.BNET_FRIENDS, 0 ) ) ; 
  oq.tab2_nfriends:SetJustifyH("right") ;

  x = parent:GetWidth() - (120 + 50) ;
  y = parent:GetHeight() - 32 ;
  oq.tab2_connection = oq.label( parent, x, y, 120, 15, "connection  0 : 0" ) ;
  oq.tab2_connection:SetJustifyH("right") ;

  x = x - 110 ;
  oq.tab2_findmesh_but = oq.button2( parent, x, y-5, 90, 24, OQ.BUT_FINDMESH, 14,
                                     function(self) oq.find_mesh() ; end 
                                    ) ;
  oq.tab2_findmesh_but.string:SetFont(OQ.FONT, 10, "") ;
  
  x = x - 95 ;
  oq.tab2_submit_but = oq.button2( parent, x, y-5, 90, 24, OQ.BUT_SUBMIT2MESH, 14,
                                   function(self) oq.submit_btag() ; end 
                                 ) ;
  oq.tab2_submit_but.string:SetFont(OQ.FONT, 10, "") ;
  if (OQ_data.btag_submitted ~= nil) and (OQ_data.btag_submitted > utc_time()) then
    oq.tab2_submit_but:Disable() ;
  else
    oq.tab2_submit_but:Enable() ;
  end

  x = x - 195 ;

  oq.tab2_filter = oq.combo_box( parent, x, y-5, 170, 24, oq.make_dropdown_premade_filter, OQ.LABEL_ALL ) ;
  
  x = x - 85 ;
  oq.tab3_enforce = oq.checkbox( parent, x, y-2,  23, cy, 90, OQ.QUALIFIED, (oq.premade_filter_qualified == 1), 
                     function(self) oq.toggle_premade_qualified( self ) ; end ) ;  

  -- tooltips
  oq.tab2_findmesh_but.tt = OQ.TT_FINDMESH ;
  oq.tab2_submit_but.tt   = OQ.TT_SUBMIT2MESH ;

  -- add sample raids
  oq.tab2_raids = {} ;

  -- tag
  oq.tab2_tag = oq.place_tag( parent ) ;

  oq.reshuffle_premades() ;
end

function oq.tab3_radio_buttons_clear()
  oq.tab3_radio_bgs      :SetChecked( nil ) ;
  oq.tab3_radio_challenge:SetChecked( nil ) ;
  oq.tab3_radio_dungeon  :SetChecked( nil ) ;
  oq.tab3_radio_quests   :SetChecked( nil ) ; 
--  oq.tab3_radio_ladder   :SetChecked( nil ) ; 
  oq.tab3_radio_rbgs     :SetChecked( nil ) ;
  oq.tab3_radio_arena    :SetChecked( nil ) ;
  oq.tab3_radio_raid     :SetChecked( nil ) ;
  oq.tab3_radio_scenario :SetChecked( nil ) ;

  oq.tab3_radio_selected = nil ;
end

function oq.tab3_radio_buttons( but )
  local nmembers = oq.nMembers() ;
  if (but.value == OQ.TYPE_SCENARIO) and (nmembers > 3) then
    message( string.format( OQ.DLG_16, 3 ) ) ;
    oq.tab3_radio_scenario:SetChecked( nil ) ;
    return ;
  end
  if (but.value == OQ.TYPE_DUNGEON ) and (nmembers > 5) then
    message( string.format( OQ.DLG_16, 5 ) ) ;
    oq.tab3_radio_dungeon:SetChecked( nil ) ;
    return ;
  end
  if (but.value == OQ.TYPE_CHALLENGE) and (nmembers > 5) then
    message( string.format( OQ.DLG_16, 5 ) ) ;
    oq.tab3_radio_challenge:SetChecked( nil ) ;
    return ;
  end
  if (but.value == OQ.TYPE_QUESTS) and (nmembers > 5) then
    message( string.format( OQ.DLG_16, 5 ) ) ;
    oq.tab3_radio_quests:SetChecked( nil ) ;
    return ;
  end
  if (but.value == OQ.TYPE_ARENA) and (nmembers > 5) then
    message( string.format( OQ.DLG_16, 5 ) ) ;
    oq.tab3_radio_arena:SetChecked( nil ) ;
    return ;
  end
  if (but.value == OQ.TYPE_RBG     ) and (nmembers > 10) then
    message( string.format( OQ.DLG_16, 10 ) ) ;
    oq.tab3_radio_rbgs:SetChecked( nil ) ;
    return ;
  end

  oq.tab3_radio_bgs      :SetChecked( nil ) ;
  oq.tab3_radio_challenge:SetChecked( nil ) ;
  oq.tab3_radio_dungeon  :SetChecked( nil ) ;
  oq.tab3_radio_quests   :SetChecked( nil ) ; 
--  oq.tab3_radio_ladder   :SetChecked( nil ) ; 
  oq.tab3_radio_rbgs     :SetChecked( nil ) ;
  oq.tab3_radio_arena    :SetChecked( nil ) ;
  oq.tab3_radio_raid     :SetChecked( nil ) ;
  oq.tab3_radio_scenario :SetChecked( nil ) ;

  but:SetChecked( true ) ;
  oq.tab3_radio_selected = but.value ;
end

function oq.tab3_set_radiobutton( value )
  if (oq.tab3_radio_bgs.value == value) then
    oq.tab3_radio_buttons( oq.tab3_radio_bgs ) ;
  elseif (oq.tab3_radio_dungeon.value == value) then
    oq.tab3_radio_buttons( oq.tab3_radio_dungeon ) ;
  elseif (oq.tab3_radio_rbgs.value == value) then
    oq.tab3_radio_buttons( oq.tab3_radio_rbgs ) ;
  elseif (oq.tab3_radio_raid.value == value) then
    oq.tab3_radio_buttons( oq.tab3_radio_raid ) ;
  elseif (oq.tab3_radio_scenario.value == value) then
    oq.tab3_radio_buttons( oq.tab3_radio_scenario ) ;
  end
  oq.tab3_radio_selected = value ;
  oq.set_premade_type( value ) ;
end

function oq.create_tab3()
  local x, y, cx, cy ;

  OQTabPage3:SetScript( "OnShow", function() oq.populate_tab3() ; end ) ;
  x  = 20 ;
  y  = 30 ;
  cy = 25 ;
  local t = oq.label( OQTabPage3, x, y, 400, 30, OQ.CREATEURPREMADE ) ;
  t:SetFont(OQ.FONT, 14, "") ;
  t:SetTextColor( 1.0, 1.0, 1.0, 1 ) ;

  y = 65 ;
  x = 40 ;
  oq.label( OQTabPage3, x, y, 100, cy, OQ.PREMADE_NAME    ) ;   y = y + cy + 4 ;
  oq.label( OQTabPage3, x, y, 100, cy, OQ.LEADERS_NAME    ) ;   y = y + cy + 4 ;
  oq.label( OQTabPage3, x, y, 100, cy, OQ.REALID_MOP      ) ;   y = y + cy + 4 ;
  oq.label( OQTabPage3, x, y, 100, cy, OQ.MIN_ILEVEL      ) ;   y = y + cy + 4 ;
  oq.label( OQTabPage3, x, y, 100, cy, OQ.MIN_RESIL       ) ;   y = y + cy + 4 ;
  oq.label( OQTabPage3, x, y, 125, cy, OQ.MIN_MMR         ) ;   y = y + cy + 4 ;
  oq.label( OQTabPage3, x, y, 100, cy, OQ.BATTLEGROUNDS   ) ;   y = y + cy + 4 ;
  oq.label( OQTabPage3, x, y, 100, cy, OQ.NOTES           ) ;   y = y + 3*cy + 4 ;
  oq.label( OQTabPage3, x, y, 100, cy, OQ.PASSWORD        ) ;   

  -- set faciton emblem
  local txt ;
  if (player_faction == "A") then
    txt = "Interface\\FriendsFrame\\PlusManz-Alliance" ;
  else
    txt = "Interface\\FriendsFrame\\PlusManz-Horde" ;
  end
  oq.tab3_faction_emblem = oq.texture( OQTabPage3, 450, 55, 100, 100, txt ) ;

  -- set level range 
  if (player_level == 90) then
    t = oq.label( OQTabPage3, 540, 55, 100, 50, OQ.LABEL_LEVEL ) ;
  else
    t = oq.label( OQTabPage3, 540, 55, 100, 50, OQ.LABEL_LEVELS ) ;
  end
  t:SetFont(OQ.FONT, 22, "") ;
  t:SetJustifyH("center") ;

  local minlevel, maxlevel = oq.get_player_level_range() ;
  if (minlevel == 0) then
    txt = "unavailable" ;
  elseif (minlevel == 90) then
    txt = "90" ;
  else
    txt = minlevel .." - ".. maxlevel ;
  end
  oq.tab3_level_range = txt ;
  t = oq.label( OQTabPage3, 540, 90, 100, 50, txt ) ;
  t:SetFont(OQ.FONT, 22, "") ;
  t:SetJustifyH("center") ;

  y  = 65 ;
  x  = 175 ;
  cx = 200 ;
  cy = 25 ;
  oq.tab3_raid_name      = oq.editline( OQTabPage3, "RaidName"     , x, y,   cx,   cy,  25 ) ; y = y + cy + 4 ;
  oq.tab3_lead_name      = oq.editline( OQTabPage3, "LeadName"     , x, y,   cx,   cy,  30 ) ; y = y + cy + 4 ;
  oq.tab3_rid            = oq.editline( OQTabPage3, "RealID"       , x, y,   cx,   cy,  60 ) ; y = y + cy + 4 ;
  oq.tab3_min_ilevel     = oq.editline( OQTabPage3, "MinIlevel"    , x, y,   cx,   cy,  10 ) ; y = y + cy + 4 ;
  oq.tab3_min_resil      = oq.editline( OQTabPage3, "MinResil"     , x, y,   cx,   cy,  10 ) ; y = y + cy + 4 ;
  oq.tab3_min_mmr        = oq.editline( OQTabPage3, "MinMMR"       , x, y,   cx,   cy,  10 ) ; y = y + cy + 4 ;

  oq.tab3_enforce = oq.checkbox( OQTabPage3, x+cx+10, y,  23, cy, 200, OQ.ENFORCE_LEVELS, (oq.raid.enforce_levels == 1), 
                     function(self) oq.toggle_enforce_levels( self ) ; end ) ;  
  
  oq.tab3_bgs            = oq.editline( OQTabPage3, "Battlegrounds", x, y,   cx,   cy,  60 ) ; y = y + cy + 4 ;
  oq.tab3_notes          = oq.editbox ( OQTabPage3, "Notes"        , x, y,  350, 3*cy, 150 ) ; y = y + 3*cy + 4 ;
  oq.tab3_notes:SetMaxLetters( 125 ) ;
  oq.tab3_notes:SetFont(OQ.FONT, 10, "") ;
  oq.tab3_notes:SetTextColor( 0.9, 0.9, 0.9, 1 ) ;
  oq.tab3_notes:SetText( OQ.DEFAULT_PREMADE_TEXT ) ;
  
  oq.tab3_pword          = oq.editline( OQTabPage3, "password", x, y,   cx,   cy,  10 ) ; y = y + cy + 6 ;

  -- disable real-id to force user to setup tab
  -- in MoP, tab3_rid can only be the battle-tag
  oq.tab3_lead_name:Disable() ; 
  oq.tab3_rid      :Disable() ; 

  oq.tab3_faction        = player_faction ;
  oq.tab3_channel_pword  = "p".. oq.token_gen() ;  -- no reason for the leader to set password.  just auto generate
  oq.tab3_lead_name:SetText( player_name ) ; -- auto-populate the leader name
  if (player_realid ~= nil) then
    oq.tab3_rid:SetText( player_realid ) ; -- auto-populate the leader real-id, if we have it
  end

  -- premade type selector
  y  = 140 ;
  x  = OQTabPage3:GetWidth() - 250 ;
  cy = 22 ;
  oq.label( OQTabPage3, x, y, 100, cy, "Premade type:" ) ;   y = y + cy + 3 ;
  x = x + 25 ;
  oq.tab3_radio_bgs       = oq.radiobutton( OQTabPage3, x, y, 24, 22, 100, OQ.LABEL_BG       , OQ.TYPE_BG       , oq.tab3_radio_buttons ) ;   y = y + cy ;
  oq.tab3_radio_arena     = oq.radiobutton( OQTabPage3, x, y, 24, 22, 100, OQ.LABEL_ARENA    , OQ.TYPE_ARENA    , oq.tab3_radio_buttons ) ;   y = y + cy ;
  oq.tab3_radio_challenge = oq.radiobutton( OQTabPage3, x, y, 24, 22, 100, OQ.LABEL_CHALLENGE, OQ.TYPE_CHALLENGE, oq.tab3_radio_buttons ) ;   y = y + cy ;
  oq.tab3_radio_dungeon   = oq.radiobutton( OQTabPage3, x, y, 24, 22, 100, OQ.LABEL_DUNGEON  , OQ.TYPE_DUNGEON  , oq.tab3_radio_buttons ) ;   y = y + cy ;
  oq.tab3_radio_quests    = oq.radiobutton( OQTabPage3, x, y, 24, 22, 100, OQ.LABEL_QUESTING , OQ.TYPE_QUESTS   , oq.tab3_radio_buttons ) ;   y = y + cy ;
--  oq.tab3_radio_ladder    = oq.radiobutton( OQTabPage3, x, y, 24, 22, 100, OQ.LABEL_QUESTING , OQ.TYPE_LADDER  , oq.tab3_radio_buttons ) ;   y = y + cy ;
--  oq.tab3_radio_ladder:Disable() ; -- not ready yet
  oq.tab3_radio_rbgs      = oq.radiobutton( OQTabPage3, x, y, 24, 22, 100, OQ.LABEL_RBG      , OQ.TYPE_RBG      , oq.tab3_radio_buttons ) ;   y = y + cy ;
  oq.tab3_radio_raid      = oq.radiobutton( OQTabPage3, x, y, 24, 22, 100, OQ.LABEL_RAID     , OQ.TYPE_RAID     , oq.tab3_radio_buttons ) ;   y = y + cy ;
  oq.tab3_radio_scenario  = oq.radiobutton( OQTabPage3, x, y, 24, 22, 100, OQ.LABEL_SCENARIO , OQ.TYPE_SCENARIO , oq.tab3_radio_buttons ) ;   y = y + cy ;

  -- not ready yet
--  oq.tab3_radio_rbgs:Disable() ;
--  oq.tab3_radio_raid:Disable() ;

  if (oq.raid.type == nil) or (oq.raid.raid_token == nil) then
--    oq.tab3_radio_buttons( oq.tab3_radio_bgs ) ;
    oq.tab3_radio_buttons_clear() ;
  else
    oq.tab3_set_radiobutton( oq.raid.type ) ;
  end
  
  -- create/update button
  oq.tab3_create_but     = oq.button2( OQTabPage3, OQTabPage3:GetWidth() - 250, OQTabPage3:GetHeight() - 80, 150, 45, OQ.CREATE_BUTTON, 14,
                                      function(self) oq.tab3_create_activate() ; end 
                                    ) ;
  oq.tab3_create_but.string:SetFont(OQ.FONT, 14, "") ;

  -- tabbing order
  oq.set_tab_order( oq.tab3_raid_name    , oq.tab3_min_ilevel ) ;
  oq.set_tab_order( oq.tab3_min_ilevel   , oq.tab3_min_resil ) ;
  oq.set_tab_order( oq.tab3_min_resil    , oq.tab3_min_mmr ) ;
  oq.set_tab_order( oq.tab3_min_mmr      , oq.tab3_bgs ) ;
  oq.set_tab_order( oq.tab3_bgs          , oq.tab3_notes ) ;
  oq.set_tab_order( oq.tab3_notes        , oq.tab3_pword ) ;
  oq.set_tab_order( oq.tab3_pword        , oq.tab3_raid_name ) ;

  -- tag
  oq.tab3_tag = oq.place_tag( OQTabPage3 ) ;
end

function oq.sort_waitlist( col )
  local order = oq.waitlist_sort_ascending ;
  if (oq.waitlist_sort ~= col) then
    order = true ;
  else
    if (order) then
      order = nil ;
    else
      order = true ;
    end
  end
  oq.waitlist_sort = col ;
  oq.waitlist_sort_ascending = order ;
  oq.reshuffle_waitlist() ;
end

function oq.create_tab_waitlist()
  local x, y, cx, cy ;
  local parent = OQTabPage7 ;
  oq.tab7_scroller, oq.tab7_list = oq.create_scrolling_list( parent, "waitlist" ) ;
  local f = oq.tab7_scroller ;
  oq.setpos( f, -40, 50, f:GetParent():GetWidth() - 2*30, f:GetParent():GetHeight() - (50+38) ) ;

  -- list header
  cy = 20 ;
  x  = 43 ; 
  y  = 27 ;

  f = oq.click_label( parent, x, y,  50, cy, OQ.HDR_BGROUP    ) ;  x = x +  65 ;  -- leave space for role icon
  f:SetScript("OnClick", function(self) oq.sort_waitlist( "bgrp" ) ; end ) ;
  f = oq.click_label( parent, x, y, 120, cy, OQ.HDR_TOONNAME  ) ;  x = x + 105 ;  
  f:SetScript("OnClick", function(self) oq.sort_waitlist( "name" ) ; end ) ;
  f = oq.click_label( parent, x, y, 100, cy, OQ.HDR_REALM     ) ;  x = x + 100 ;
  f:SetScript("OnClick", function(self) oq.sort_waitlist( "rlm" ) ; end ) ;
  f = oq.click_label( parent, x, y,  40, cy, OQ.HDR_LEVEL     ) ;  x = x +  40 ;
  f:SetScript("OnClick", function(self) oq.sort_waitlist( "level" ) ; end ) ;
  f = oq.click_label( parent, x, y,  40, cy, OQ.HDR_ILEVEL    ) ;  x = x +  40 ;
  f:SetScript("OnClick", function(self) oq.sort_waitlist( "ilevel" ) ; end ) ;
  f = oq.click_label( parent, x, y,  50, cy, OQ.HDR_RESIL     ) ;  x = x +  41 ;
  f:SetScript("OnClick", function(self) oq.sort_waitlist( self.sortby ) ; end ) ;
  f.sortby = "resil" ;
  parent.header1 = f ;
  f = oq.click_label( parent, x, y,  48, cy, OQ.HDR_PVPPOWER  ) ;  x = x +  50 ;
  f:SetScript("OnClick", function(self) oq.sort_waitlist( self.sortby ) ; end ) ;
  f.sortby = "power" ;
  parent.header2 = f ;
  f = oq.click_label( parent, x, y,  40, cy, OQ.HDR_MMR       ) ;  x = x +  30 ;
  f:SetScript("OnClick", function(self) oq.sort_waitlist( self.sortby ) ; end ) ;
  f.sortby = "mmr" ;
  parent.header3 = f ;
  f = oq.click_label( parent, x+185, y,  40, cy, OQ.HDR_TIME ) ;  
  f:SetScript("OnClick", function(self) oq.sort_waitlist( "time" ) ; end ) ;

  -- add samples
  oq.tab7_waitlist = {} ;

  -- tag
  oq.tab7_tag = oq.place_tag( parent ) ;
  oq.waitlist_sort = "time" ;
  oq.waitlist_sort_ascending = true ;
  oq.reshuffle_waitlist() ;
end

function oq.create_tab_banlist()
  local x, y, cx, cy ;
  local parent = OQTabPage6 ;
  oq.tab6_scroller, oq.tab6_list = oq.create_scrolling_list( parent, "banlist" ) ;
  local f = oq.tab6_scroller ;
  oq.setpos( f, -40, 50, f:GetParent():GetWidth() - 2*30, f:GetParent():GetHeight() - (50+38) ) ;

  -- list header
  cy = 20 ;
  x  = 80 ;
  y  = 27 ;

--  oq.label( parent, x, y, 125, cy, OQ.HDR_BTAG    ) ;  x = x + 125 ;  
--  oq.label( parent, x, y, 450, cy, OQ.HDR_REASON  ) ;  
  f = oq.click_label( parent, x, y, 130, cy, OQ.HDR_DATE   ) ;  x = x +  130 + 6 ;
  f:SetScript("OnClick", function(self) oq.sort_banlist( "ts" ) ; end ) ;
  f = oq.click_label( parent, x, y, 125, cy, OQ.HDR_BTAG   ) ;  x = x +  125 + 4 ;
  f:SetScript("OnClick", function(self) oq.sort_banlist( "btag" ) ; end ) ;
  f = oq.click_label( parent, x, y, 450, cy, OQ.HDR_REASON ) ;  
  f:SetScript("OnClick", function(self) oq.sort_banlist( "reason" ) ; end ) ;

  x = parent:GetWidth() - 135 ;
  y = parent:GetHeight() - 30 ;
  oq.tab6_ban_but = oq.button2( parent, x, y-4, 90, 24, OQ.BUT_BAN_BTAG, 14,
                                     function(self) StaticPopup_Show("OQ_BanBTag") ; end 
                                    ) ;
  oq.tab6_ban_but.string:SetFont(OQ.FONT, 10, "") ;

  -- add samples
  oq.tab6_banlist = {} ;

  -- tag
  oq.tab6_tag = oq.place_tag( parent ) ;
  oq.banlist_sort = "ts" ;
  oq.banlist_sort_ascending = true ;

  oq.populate_ban_list() ; 
end

function oq.create_begbox( parent ) 
  local pcx = parent:GetWidth() ;
  local pcy = parent:GetHeight() ;
  local cx = floor(pcx/2) ;
  local cy = floor(4*pcy/5) ;
  local f = oq.panel( parent, "BegBox", floor((pcx - cx)/2), floor((pcy - cy)/2), cx, cy) ;
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                 edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                 tile=true, tileSize = 16, edgeSize = 16,
                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
                 })
  f:SetBackdropColor( 0.2, 0.2, 0.2, 1.0 ) ;
  f:SetAlpha( 1.0 ) ;
  f.texture:SetTexture( "INTERFACE/PVP-Banner-Emblem-1" ) ;
  f.texture:SetPoint( "TOPLEFT"    , f, "BOTTOMRIGHT", -130, 130 ) ;
  f.texture:SetPoint( "BOTTOMRIGHT", f, "BOTTOMRIGHT", - 10,  10 ) ;
  
  oq.closebox( f, function(self) self:GetParent():GetParent():Hide() ; end ) ;

  local x = 15 ;
  local y = 20 ;
  for i,v in pairs(OQ.CONTRIBUTION_DLG) do
    if (v ~= "beg.oq") and (v ~= "beg.vent") then
      local t = oq.label( f, x, y, cx-2*15, 20, v, "CENTER", "LEFT" ) ;
      t:SetFont(OQ.FONT, 16, "") ;
    elseif (v == "beg.oq") then
      f.beg_oq   = oq.editline( f, "oQueueBeg", x+10, y, cx-2*20, 24, 60 ) ;  
      f.beg_oq:SetText( "https://solidice.com/oqueue/beer-me.html" ) ;
    elseif (v == "beg.vent") then
      f.beg_vent = oq.editline( f, "VentBeg", x+10, y, cx-2*20, 24, 60 ) ;  
      f.beg_vent:SetText( "http://contribute.publicvent.org/" ) ;
    end
    y = y + 24 ;
  end

  return f ;
end

function oq.onShadeHide(f)
  oq.tremove_value( getglobal("UISpecialFrames"), f:GetName() ) ;
  tinsert( getglobal("UISpecialFrames"), oq.ui:GetName() ) ;
end

function oq.onShadeShow(f)
  tinsert( getglobal("UISpecialFrames"), f:GetName() ) ;
  oq.tremove_value( getglobal("UISpecialFrames"), oq.ui:GetName() ) ;
end

function oq.create_ui_shade()
  if (oq.ui_shade ~= nil) then
    return oq.ui_shade ;
  end
  local parent = oq.ui ;
  local cx = floor(parent:GetWidth()) ;
  local cy = floor(parent:GetHeight()) + 30 + 10 ;
  local f = oq.panel( parent, "Shade", 0, -10, cx, cy ) ;
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                 edgeFile=nil, 
                 tile=true, tileSize = 16, edgeSize = 16,
                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
                 })
  f:SetBackdropColor( 0.2, 0.2, 0.2, 0.75 ) ;
  f:SetFrameLevel( 125 ) ;
  f:EnableMouse(true) ;
  f:SetScript( "OnShow", function(self) oq.onShadeShow(self) ; end ) ;
  f:SetScript( "OnHide", function(self) oq.onShadeHide(self) ; end ) ;
  oq.onShadeShow(f) ; -- first time
  oq.ui_shade = f ;

-- HELP PLATE?
-- http://wowprogramming.com/utils/xmlbrowser/live/AddOns/Blizzard_TalentUI/Blizzard_TalentUI.lua
-- HelpPlate_Show
-- HelpPlate_Hide

  -- place contribution dialog  
  oq.create_begbox( oq.ui_shade ) ;
  
  return oq.ui_shade ;
end

function oq.contribute_dialog()
  -- cover entire oq ui with alpha screen to darken
  -- display dialog with request for contributions for oqueue dev and public vent servers
  -- should have dialogs to copy/paste from
  -- will have links to contribution pages
  -- solidice:   https://solidice.com/oqueue/contribute.html
  -- public vent:  http://donate.publicvent.org/
  local f = oq.create_ui_shade() ;
  f:Show() ;
end

function oq.place_tag( parent )
  local txt = "|cFF000000".. OQ.CONTRIBUTE .. "|r" ;
  local tag = oq.click_label( parent, 20, parent:GetHeight() - 30, 90, 18, txt, "CENTER", "CENTER" ) ;
  local t = tag:CreateTexture(nil,"BACKGROUND") ;
  t:SetAllPoints(tag) ;
  t:SetDrawLayer("BACKGROUND") ;
  tag.texture = t ;
  tag.texture:SetTexture( "Interface\\Addons\\oqueue\\art\\but_gold_blank.tga" ) ;
  tag:SetScript("OnClick", function(self) oq.contribute_dialog() ; end ) ;
  tag.label:SetFont(OQ.FONT, 12, "") ;
  return tag ;
end

function oq.create_score_tab_label( x, y, cx, cy, txt )
  local f = {} ;
  local parent = OQTabPage4 ;
  f.label = oq.label( parent, x, y, cx, cy, txt ) ;
  f.label:SetJustifyH("left") ;
  f.score = oq.label( parent, x + cx + 5, y, 25, cy, "50" ) ;
  f.score:SetJustifyH("left") ;
  
  f.bar = oq.texture( parent, x + cx, y, 170, cy, "Interface\\WorldStateFrame\\WorldState-CaptureBar" ) ;
  f.bar.texture:SetTexCoord( 0, 0.67578125, 0, 0.40625 ) ;
  f.bar.texture:SetDrawLayer( "BORDER" ) ;

  cy = 9 ;
  y  = y + 7 ;
  
  -- alliance blue
  f.bar_left = oq.texture( parent, x + cx+24, y, (170*0.20), cy, "Interface\\WorldStateFrame\\WorldState-CaptureBar" ) ;
  f.bar_left.texture:SetTexCoord( 0.8203125, 1.0, 0, 0.140625 ) ;

  -- horde red
  f.bar_right = oq.texture( parent, x + cx+170-52, y, (170*0.10), cy, "Interface\\WorldStateFrame\\WorldState-CaptureBar" ) ;
  f.bar_right.texture:SetTexCoord( 0.8203125, 1.0, 0.171875, 0.3125 ) ;
  
  -- indicator for middle
  f.indicator = oq.texture( parent, x + cx+(170/2)-5, y-1, 6, cy+8, "Interface\\WorldStateFrame\\WorldState-CaptureBar" ) ;
  f.indicator.texture:SetTexCoord( 0.77734375, 0.796875, 0, 0.28125 ) ;
  f.indicator.texture:SetDrawLayer( "ARTWORK" ) ;
  
  f.min_x = x + cx + 24 ;
  f.max_x = x + cx + 170 - 24 ;
  f.bar_y = y ;
  f.bar_cy = cy ;

  return f ;
end

function oq.set_bg_percent( f, v ) 
  local width = (f.max_x - f.min_x) ;
  local cx = width / 2 ;
  oq.setpos( f.bar_left , f.min_x, f.bar_y, cx, f.bar_cy ) ;
  oq.setpos( f.bar_right, f.max_x-cx, f.bar_y, cx, f.bar_cy ) ;
  
  cx = width * ((100-v) / 100) ;
  oq.moveto( f.indicator, f.min_x+cx, f.bar_y-2 ) ;
end

function oq.get_gametime()
  local t = oq.scores.timeleft or 0 ;
  if (t < 0) then
    t = 0 ;
  elseif (t ~= 0) then
    t = oq.scores.end_round_tm - utc_time() + oq.scores.time_lag ;
    if (t < 0) then
      t = 0 ;
    end
  end
  
  local hrs = floor( t / (60*60)) ;
  local min = floor( t / 60 ) % 60 ;
  local sec = t % 60 ;
  local tm_str = string.format( "%d:%02d:%02d", hrs, min, sec ) ;
  if (hrs == 0) then
    tm_str = string.format( "%02d:%02d", min, sec ) ;
  end
  return tm_str ;
end

function oq.update_gametime()
  local tm_str = oq.get_gametime() ;
  if (oq.tab4_timeleft:IsVisible()) then
    oq.tab4_timeleft:SetText( tm_str ) ;
  end
end

function oq.update_marquee_gametime()
  local tm_str = oq.get_gametime() ;
  if (oq.marquee.timeleft:IsVisible()) then
    oq.marquee.timeleft:SetText( tm_str ) ;
  end
end

function oq.create_tab_score() 
  local x, y, cx, cy, spacer ;
  local parent = OQTabPage4 ;
  
  parent:SetScript( "OnShow", function() oq.update_gametime() ; oq.timer( "scoreboard_ticker", 0.5, oq.update_gametime, true ) ; end ) ;
  parent:SetScript( "OnHide", function() oq.timer( "scoreboard_ticker", 0.5, nil ) ; end ) ;

  ------------------------------------------------------------------------
  -- utc date stamp
  ------------------------------------------------------------------------
  x = 40 ;
  y = 20 ;
  x = parent:GetWidth() - 208 ;
  y = parent:GetHeight() - 30 ;
  oq.tab4_now = oq.label( parent, x, y, 200, 25, "" ) ;
  oq.tab4_now:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_now:SetJustifyH("LEFT") ;
  oq.tab4_now:SetJustifyV("middle") ;
  oq.tab4_now:SetTextColor( 178/255, 178/255, 178/255, 1 ) ;
  oq.tab4_now:Hide() ;
  
  ------------------------------------------------------------------------
  -- horde
  ------------------------------------------------------------------------
  x = 390 ;
  y = 0 ;
  oq.tab4_horde_emblem    = oq.texture( parent, x,  y+40, 80, 80, "Interface\\FriendsFrame\\PlusManz-Horde" ) ;
  
  oq.tab4_horde_nCrowns     = oq.label( parent, x-5, y+40+80+10, 75, 25, "0 C" ) ;
  oq.tab4_horde_nCrowns:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_horde_nCrowns:SetJustifyH("RIGHT") ;
  oq.tab4_horde_nCrowns:SetJustifyV("MIDDLE") ;
  oq.tab4_horde_nCrowns:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  y = y + 20 ;
  x = x + 100 ;
  oq.tab4_horde_label     = oq.label( parent, x, y, 100, 100, OQ.HORDE ) ;
  oq.tab4_horde_label:SetFont(OQ.FONT, 22, "") ;
  oq.tab4_horde_label:SetJustifyH("left") ;
  oq.tab4_horde_label:SetJustifyV("middle") ;
--  oq.tab4_horde_score:SetTextColor( 255/255, 209/255, 0/255, 1 ) ;

  oq.tab4_horde_nGolden = oq.label( parent, x+225+6, y+ 5, 60, 100, "19 DD" ) ;
  oq.tab4_horde_nGolden:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_horde_nGolden:SetJustifyH("right") ;
  oq.tab4_horde_nGolden:SetJustifyV("middle") ;
  oq.tab4_horde_nGolden:SetTextColor( 178/255, 178/255, 178/255, 1 ) ;

  oq.tab4_horde_nSilver = oq.label( parent, x+225, y+30, 60, 100, "8 SS" ) ;
  oq.tab4_horde_nSilver:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_horde_nSilver:SetJustifyH("right") ;
  oq.tab4_horde_nSilver:SetJustifyV("middle") ;
  oq.tab4_horde_nSilver:SetTextColor( 178/255, 178/255, 178/255, 1 ) ;
  
  oq.tab4_horde_nGenerals = oq.label( parent, x+225, y+50, 60, 100, "8 GG" ) ;
  oq.tab4_horde_nGenerals:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_horde_nGenerals:SetJustifyH("right") ;
  oq.tab4_horde_nGenerals:SetJustifyV("middle") ;
  oq.tab4_horde_nGenerals:SetTextColor( 178/255, 178/255, 178/255, 1 ) ;
  
  oq.tab4_horde_nKnights = oq.label( parent, x+225, y+70, 60, 100, "8 KK" ) ;
  oq.tab4_horde_nKnights:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_horde_nKnights:SetJustifyH("right") ;
  oq.tab4_horde_nKnights:SetJustifyV("middle") ;
  oq.tab4_horde_nKnights:SetTextColor( 178/255, 178/255, 178/255, 1 ) ;

  
  oq.tab4_horde_nactive_l   = oq.label( parent, x, y+30, 125, 100, OQ.ACTIVE_LASTPERIOD ) ;
  oq.tab4_horde_nactive_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_horde_nactive_l:SetJustifyH("left") ;
  oq.tab4_horde_nactive_l:SetJustifyV("middle") ;
  oq.tab4_horde_nactive_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
    
  oq.tab4_horde_leaders_l   = oq.label( parent, x, y+50, 100, 100, OQ.SCORE_NLEADERS ) ;
  oq.tab4_horde_leaders_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_horde_leaders_l:SetJustifyH("left") ;
  oq.tab4_horde_leaders_l:SetJustifyV("middle") ;
  oq.tab4_horde_leaders_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
  
  oq.tab4_horde_ngames_l   = oq.label( parent, x, y+70, 100, 100, OQ.SCORE_NGAMES ) ;
  oq.tab4_horde_ngames_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_horde_ngames_l:SetJustifyH("left") ;
  oq.tab4_horde_ngames_l:SetJustifyV("middle") ;
  oq.tab4_horde_ngames_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
  
  oq.tab4_horde_nBosses_l   = oq.label( parent, x, y+90, 100, 100, OQ.SCORE_NBOSSES ) ;
  oq.tab4_horde_nBosses_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_horde_nBosses_l:SetJustifyH("left") ;
  oq.tab4_horde_nBosses_l:SetJustifyV("middle") ;
  oq.tab4_horde_nBosses_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
  
  oq.tab4_horde_dkp_l   = oq.label( parent, x, y+110, 140, 100, OQ.SCORE_DKP ) ;
  oq.tab4_horde_dkp_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_horde_dkp_l:SetJustifyH("left") ;
  oq.tab4_horde_dkp_l:SetJustifyV("middle") ;
  oq.tab4_horde_dkp_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
  
  x = x + 115 ;
  oq.tab4_horde_score     = oq.label( parent, x, y, 100, 100, "99,999" ) ;
  oq.tab4_horde_score:SetFont(OQ.FONT, 22, "") ;
  oq.tab4_horde_score:SetJustifyH("right") ;
  oq.tab4_horde_score:SetJustifyV("middle") ;
  oq.tab4_horde_score:SetTextColor( 0.8, 0.8, 0.8, 1 ) ;

  oq.tab4_horde_nactive     = oq.label( parent, x, y+30, 100, 100, "-" ) ;
  oq.tab4_horde_nactive:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_horde_nactive:SetJustifyH("right") ;
  oq.tab4_horde_nactive:SetJustifyV("middle") ;
  oq.tab4_horde_nactive:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  oq.tab4_horde_leaders     = oq.label( parent, x, y+50, 100, 100, "-" ) ;
  oq.tab4_horde_leaders:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_horde_leaders:SetJustifyH("right") ;
  oq.tab4_horde_leaders:SetJustifyV("middle") ;
  oq.tab4_horde_leaders:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  oq.tab4_horde_ngames     = oq.label( parent, x, y+70, 100, 100, "-" ) ;
  oq.tab4_horde_ngames:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_horde_ngames:SetJustifyH("right") ;
  oq.tab4_horde_ngames:SetJustifyV("middle") ;
  oq.tab4_horde_ngames:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;
  
  oq.tab4_horde_nBosses     = oq.label( parent, x, y+90, 100, 100, "-" ) ;
  oq.tab4_horde_nBosses:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_horde_nBosses:SetJustifyH("right") ;
  oq.tab4_horde_nBosses:SetJustifyV("middle") ;
  oq.tab4_horde_nBosses:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  oq.tab4_horde_dkp     = oq.label( parent, x, y+110, 100, 100, "-" ) ;
  oq.tab4_horde_dkp:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_horde_dkp:SetJustifyH("right") ;
  oq.tab4_horde_dkp:SetJustifyV("middle") ;
  oq.tab4_horde_dkp:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  ------------------------------------------------------------------------
  -- alliance
  ------------------------------------------------------------------------
  x = 390 ;
  y = y + 165 ;
  oq.tab4_alliance_emblem = oq.texture( parent, x, y+20, 80, 80, "Interface\\FriendsFrame\\PlusManz-Alliance" ) ;
  
  oq.tab4_alliance_nCrowns     = oq.label( parent, x-5, y+20+80+10, 75, 25, "0 C" ) ;
  oq.tab4_alliance_nCrowns:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_alliance_nCrowns:SetJustifyH("RIGHT") ;
  oq.tab4_alliance_nCrowns:SetJustifyV("MIDDLE") ;
  oq.tab4_alliance_nCrowns:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;
  
  x = x + 100 ;
  oq.tab4_alliance_label  = oq.label( parent, x, y, 100, 100, OQ.ALLIANCE ) ;
  oq.tab4_alliance_label:SetFont(OQ.FONT, 22, "") ;
  oq.tab4_alliance_label:SetJustifyH("left") ;
  oq.tab4_alliance_label:SetJustifyV("middle") ;
  
  oq.tab4_alliance_nGolden = oq.label( parent, x+225+6, y+ 5, 60, 100, "19 DD" ) ;
  oq.tab4_alliance_nGolden:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_alliance_nGolden:SetJustifyH("right") ;
  oq.tab4_alliance_nGolden:SetJustifyV("middle") ;
  oq.tab4_alliance_nGolden:SetTextColor( 178/255, 178/255, 178/255, 1 ) ;

  oq.tab4_alliance_nSilver = oq.label( parent, x+225, y+30, 60, 100, "8 SS" ) ;
  oq.tab4_alliance_nSilver:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_alliance_nSilver:SetJustifyH("right") ;
  oq.tab4_alliance_nSilver:SetJustifyV("middle") ;
  oq.tab4_alliance_nSilver:SetTextColor( 178/255, 178/255, 178/255, 1 ) ;
  
  oq.tab4_alliance_nGenerals = oq.label( parent, x+225, y+50, 60, 100, "8 GG" ) ;
  oq.tab4_alliance_nGenerals:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_alliance_nGenerals:SetJustifyH("right") ;
  oq.tab4_alliance_nGenerals:SetJustifyV("middle") ;
  oq.tab4_alliance_nGenerals:SetTextColor( 178/255, 178/255, 178/255, 1 ) ;
  
  oq.tab4_alliance_nKnights = oq.label( parent, x+225, y+70, 60, 100, "8 KK" ) ;
  oq.tab4_alliance_nKnights:SetFont(OQ.FONT_FIXED, 10, "") ;
  oq.tab4_alliance_nKnights:SetJustifyH("right") ;
  oq.tab4_alliance_nKnights:SetJustifyV("middle") ;
  oq.tab4_alliance_nKnights:SetTextColor( 178/255, 178/255, 178/255, 1 ) ;

  oq.tab4_alliance_nactive_l   = oq.label( parent, x, y+30, 125, 100, OQ.ACTIVE_LASTPERIOD ) ;
  oq.tab4_alliance_nactive_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_alliance_nactive_l:SetJustifyH("left") ;
  oq.tab4_alliance_nactive_l:SetJustifyV("middle") ;
  oq.tab4_alliance_nactive_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
  
  oq.tab4_alliance_leaders_l   = oq.label( parent, x, y+50, 100, 100, OQ.SCORE_NLEADERS ) ;
  oq.tab4_alliance_leaders_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_alliance_leaders_l:SetJustifyH("left") ;
  oq.tab4_alliance_leaders_l:SetJustifyV("middle") ;
  oq.tab4_alliance_leaders_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
  
  oq.tab4_alliance_ngames_l   = oq.label( parent, x, y+70, 100, 100, OQ.SCORE_NGAMES ) ;
  oq.tab4_alliance_ngames_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_alliance_ngames_l:SetJustifyH("left") ;
  oq.tab4_alliance_ngames_l:SetJustifyV("middle") ;
  oq.tab4_alliance_ngames_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
  
  oq.tab4_alliance_nBosses_l   = oq.label( parent, x, y+90, 100, 100, OQ.SCORE_NBOSSES ) ;
  oq.tab4_alliance_nBosses_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_alliance_nBosses_l:SetJustifyH("left") ;
  oq.tab4_alliance_nBosses_l:SetJustifyV("middle") ;
  oq.tab4_alliance_nBosses_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
  
  oq.tab4_alliance_dkp_l   = oq.label( parent, x, y+110, 140, 100, OQ.SCORE_DKP ) ;
  oq.tab4_alliance_dkp_l:SetFont(OQ.FONT, 12, "") ;
  oq.tab4_alliance_dkp_l:SetJustifyH("left") ;
  oq.tab4_alliance_dkp_l:SetJustifyV("middle") ;
  oq.tab4_alliance_dkp_l:SetTextColor( 206/255, 168/255, 1/255, 1 ) ;
  
  x = x + 115 ;
  oq.tab4_alliance_score     = oq.label( parent, x, y, 100, 100, "0" ) ;
  oq.tab4_alliance_score:SetFont(OQ.FONT, 22, "") ;
  oq.tab4_alliance_score:SetJustifyH("right") ;
  oq.tab4_alliance_score:SetJustifyV("middle") ;
  oq.tab4_alliance_score:SetTextColor( 0.8, 0.8, 0.8, 1 ) ;

  oq.tab4_alliance_nactive     = oq.label( parent, x, y+30, 100, 100, "-" ) ;
  oq.tab4_alliance_nactive:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_alliance_nactive:SetJustifyH("right") ;
  oq.tab4_alliance_nactive:SetJustifyV("middle") ;
  oq.tab4_alliance_nactive:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  oq.tab4_alliance_leaders     = oq.label( parent, x, y+50, 100, 100, "-" ) ;
  oq.tab4_alliance_leaders:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_alliance_leaders:SetJustifyH("right") ;
  oq.tab4_alliance_leaders:SetJustifyV("middle") ;
  oq.tab4_alliance_leaders:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  oq.tab4_alliance_ngames     = oq.label( parent, x, y+70, 100, 100, "-" ) ;
  oq.tab4_alliance_ngames:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_alliance_ngames:SetJustifyH("right") ;
  oq.tab4_alliance_ngames:SetJustifyV("middle") ;
  oq.tab4_alliance_ngames:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  oq.tab4_alliance_nBosses     = oq.label( parent, x, y+90, 100, 100, "-" ) ;
  oq.tab4_alliance_nBosses:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_alliance_nBosses:SetJustifyH("right") ;
  oq.tab4_alliance_nBosses:SetJustifyV("middle") ;
  oq.tab4_alliance_nBosses:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  oq.tab4_alliance_dkp     = oq.label( parent, x, y+110, 100, 100, "-" ) ;
  oq.tab4_alliance_dkp:SetFont(OQ.FONT_FIXED, 12, "") ;
  oq.tab4_alliance_dkp:SetJustifyH("right") ;
  oq.tab4_alliance_dkp:SetJustifyV("middle") ;
  oq.tab4_alliance_dkp:SetTextColor( 0.7, 0.7, 0.7, 1 ) ;

  ------------------------------------------------------------------------
  -- time left
  ------------------------------------------------------------------------
  x = 390 + 100 ;
  y = y + 155 ;
  oq.tab4_timeleft_label  = oq.label( parent, x, y, 100, 100, OQ.TIMELEFT ) ;
  oq.tab4_timeleft_label:SetFont(OQ.FONT, 14, "") ;
  oq.tab4_timeleft_label:SetJustifyH("left") ;
  oq.tab4_timeleft_label:SetJustifyV("middle") ;


  x = x + 115 ;  
  oq.tab4_timeleft  = oq.label( parent, x, y, 100, 100, "168:17" ) ;
--  oq.tab4_timeleft:SetFont(OQ.FONT, 14, "") ;
  oq.tab4_timeleft:SetFont(OQ.FONT_FIXED, 14, "") ;
  oq.tab4_timeleft:SetJustifyH("right") ;
  oq.tab4_timeleft:SetJustifyV("middle") ;
  oq.tab4_timeleft:SetTextColor( 0.8, 0.8, 0.8, 1 ) ;
  
  x = 40 ;
  y = 50 ;
  cx = 155 ;
  cy = 24 ;
  spacer = 2 ;
  oq.tab4_bg = {} ;
  oq.tab4_bg[ "DKP"  ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.DKP  ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "AB"   ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.AB   ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "AV"   ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.AV   ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "BFG"  ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.BFG  ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "EotS" ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.EOTS ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "IoC"  ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.IOC  ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "SotA" ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.SOTA ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "TP"   ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.TP   ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "WSG"  ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.WSG  ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "SSM"  ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.SSM  ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "ToK"  ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.TOK  ) ) ;
  y = y + cy + spacer ;
  oq.tab4_bg[ "DWG"  ] = oq.create_score_tab_label( x, y, cx, cy, oq.bg_name( OQ.DWG  ) ) ;
  
  oq.tab4_tag = oq.place_tag( parent ) ;
end

--
-- https://sea.battle.net/support/en/article/color-blind-mode-improvements-in-patch-4-3
--
OQ.colorblind_types = { { text = OQ.COLORBLINDSHADER[0], arg1 = 0 },
                        { text = OQ.COLORBLINDSHADER[1], arg1 = 1 },
                        { text = OQ.COLORBLINDSHADER[2], arg1 = 2 },
                        { text = OQ.COLORBLINDSHADER[3], arg1 = 3 },
                        { text = OQ.COLORBLINDSHADER[4], arg1 = 4 },
                        { text = OQ.COLORBLINDSHADER[5], arg1 = 5 },
                        { text = OQ.COLORBLINDSHADER[6], arg1 = 6 },
                        { text = OQ.COLORBLINDSHADER[7], arg1 = 7 },
                        { text = OQ.COLORBLINDSHADER[8], arg1 = 8 },
                      } ;
function oq.make_colorblind_dropdown()
  local m = oq.menu_create() ;
  for i,v in pairs(OQ.colorblind_types) do
    oq.menu_add( v.text, v.arg1, v.text, nil, 
                 function(cb_edit,arg1,arg2) 
                     if (oq.color_blind_mode( arg1 )) then
                       cb_edit:SetText( arg2 ) ;
                     end
                   return true ; 
                 end 
               ) ;
  end
  return m ;  
end

function oq.create_tab_setup() 
  local x, y, cx, cy, x2 ;
  local parent = OQTabPage5 ;
  
  parent:SetScript( "OnShow", function() oq.populate_tab_setup() ; end ) ;
  parent:SetScript( "OnHide", function() oq.onhide_tab_setup() ; end ) ;
  x  = 20 ;
  y  = 30 ;
  cy = 25 ;
  local t = oq.label( parent, x, y, 400, 30, OQ.SETUP_HEADING ) ;
  t:SetFont(OQ.FONT, 14, "") ;
  t:SetTextColor( 1.0, 1.0, 1.0, 1 ) ;

  y = 65 ;
  x = 40 ;
  oq.label( parent, x, y, 200, cy, OQ.REALID_MOP ) ;  
  y = y + cy + 6 ;

  oq.label( parent, x, y, 200, cy, OQ.SETUP_GODARK_LBL ) ; 
  y = y + cy ;
  oq.label( parent, x, y, 200, cy, OQ.SETUP_REMOQADDED ) ; 
  y = y + cy ;
  oq.label( parent, x, y, 200, cy, OQ.SETUP_REMOVEBTAG ) ; 
  y = y + cy ;
  oq.label( parent, x, y, 200, cy, OQ.SETUP_COLORBLIND ) ;
  y = y + cy ;
  oq.label( parent, x, y, 200, cy, OQ.SETUP_TIMERWIDTH ) ;

  x  = parent:GetWidth() - 225 ;
  y  = 25 ;  
  cy = 22 ;
  oq.tab5_ar = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_AUTOROLE, (OQ_toon.auto_role == 1), 
               function(self) oq.toggle_auto_role( self ) ; end ) ;
  y = y + cy ;
  oq.tab5_cp = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_CLASSPORTRAIT, (OQ_toon.class_portrait == 1), 
               function(self) oq.toggle_class_portraits( self ) ; end ) ;
  y = y + cy ;
  oq.tab5_autoinspect = oq.checkbox( parent, x, y,  23, cy, 200, OQ.AUTO_INSPECT, (OQ_data.ok2autoinspect == 1), 
               function(self) oq.toggle_autoinspect( self ) ; end ) ;
  y = y + cy ;
  oq.tab5_ss = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_SAYSAPPED, (OQ_toon.say_sapped == 1), 
               function(self) oq.toggle_say_sapped( self ) ; end ) ;
  y = y + cy ;
  oq.tab5_wp = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_WHOPOPPED, (OQ_toon.who_popped_lust == 1), 
               function(self) oq.toggle_who_popped_lust( self ) end ) ;
  y  = y + cy ;
  oq.tab5_shoutkbs = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_SHOUTKBS, (OQ_toon.shout_kbs == 1), 
               function(self) oq.toggle_shout_kbs( self ) ; end ) ;
  y  = y + cy ;
  oq.tab5_shoutcaps = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_SHOUTCAPS, (OQ_toon.shout_caps == 1), 
               function(self) oq.toggle_shout_caps( self ) ; end ) ;
  y  = y + cy ;
  oq.tab5_shoutads = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_SHOUTADS, (OQ_data.show_premade_ads == 1), 
               function(self) oq.toggle_premade_ads( self ) ; end ) ;
  y  = y + cy ;
  oq.tab5_shoutcontracts = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_SHOUTCONTRACTS, (OQ_data.show_contract_ads == 1), 
               function(self) oq.toggle_contract_ads( self ) ; end ) ;
  y  = y + cy ;
  oq.tab5_ok2submit_btag = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_OK2SUBMIT_BTAG, (OQ_data.ok2submit_tag == 1), 
               function(self) oq.toggle_btag_submit( self ) ; end ) ;
  y  = y + cy ;
  oq.tab5_autoaccept_mesh_request = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_AUTOACCEPT_MESH_REQ, (OQ_data.autoaccept_mesh_request == 1), 
               function(self) oq.toggle_autoaccept_mesh_request( self ) ; end ) ;
  y  = y + cy ;
  oq.tab5_show_controlled_towers = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_SHOW_CONTROLLED, (OQ_data.show_controlled == 1), 
               function(self) oq.toggle_show_controlled( self ) ; end ) ;
  y  = y + cy ;
  oq.tab5_ragequits = oq.checkbox( parent, x, y,  23, cy, 200, OQ.SETUP_ANNOUNCE_RAGEQUIT, (OQ_toon.shout_ragequits == 1), 
               function(self) oq.toggle_ragequits( self ) ; end ) ;
 
  x = 40 ;
  y  = parent:GetHeight() - 185 ;
  cx = 200 ;
  cy = 25 ;
  oq.label( parent, x, y, 225, cy*2, OQ.SETUP_ALTLIST ) ; 

  x  = 250 ;

  local f = oq.CreateFrame( "Frame", "OQTabPage5List", parent ) ;
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                 edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                 tile=true, tileSize = 16, edgeSize = 16,
                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
                 })
  f:SetBackdropColor(0.0,0.0,0.0,1.0);
  oq.setpos( f, 0, 0, 175, 150 ) ;
  oq.tab5_list = f ;

  f = oq.CreateFrame( "ScrollFrame", "OQTabPage5ListScrollBar", OQTabPage5, "FauxScrollFrameTemplate" ) ;
  f:SetScript("OnVerticalScroll", function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset, 16, OQ_ModScrollBar_Update); end ) ;
  f:SetScript("OnShow", function(self) OQ_ModScrollBar_Update(self) ; end ) ;
  f:SetScrollChild( oq.tab5_list ) ;
  f:Show() ;
  oq.setpos( f, x, y, 175, f:GetParent():GetHeight() - (y+30) ) ;
  oq.tab5_scroller = f ;
  
  oq.tab5_add_alt = oq.button( parent, x+200, y, 75, cy, OQ.SETUP_ADD, function() StaticPopup_Show("OQ_AddToonName") ; end ) ;
  y = y + cy + 2 ;
  oq.tab5_add_mycrew = oq.button( parent, x+200, y, 75, cy, OQ.SETUP_MYCREW, function() oq.mycrew() ; end ) ;
  y = y + cy + 2 ;
  oq.tab5_clear = oq.button( parent, x+200, y, 75, cy, OQ.SETUP_CLEAR, function() oq.mycrew("clear") ; end ) ;
  if (oq.tab5_alts == nil) then
    oq.tab5_alts = {} ;
  end

  --
  -- edits and buttons
  --
  y  = 65 ; -- skip comment
  x  = 250 ;
  cy = 25 ;
  cx = 145 ;
  oq.tab5_bnet        = oq.editline( parent, "BnetAddress", x, y, cx-4, cy,  60 ) ; 
  y = y + cy + 6 ;
  oq.tab5_go_dark     = oq.button( parent, x-5, y, cx, cy, OQ.SETUP_GODARK, 
                                     function() oq.godark() ; end )
  y = y + cy ;
  oq.tab5_prune_bnet  = oq.button( parent, x-5, y, cx, cy, OQ.SETUP_REMOVENOW, 
                                     function() oq.remove_OQadded_bn_friends() ; end )
  oq.tab5_bnet:Disable() ;
  y = y + cy ;
  oq.tab5_pullbtag_but = oq.button2( parent, x-5, y, cx, cy, OQ.BUT_PULL_BTAG, 14,
                                   function(self) oq.pull_btag() ; end ) ;
  oq.tab5_pullbtag_but.string:SetFont(OQ.FONT, 10, "") ;

  y = y + cy ;
  
  oq.tab5_colorblindshader = oq.combo_box( parent, x, y, 117, 24, oq.make_colorblind_dropdown, OQ.COLORBLINDSHADER[0] ) ;
  oq.button( parent, x+145, y+1, 22, cy, "+", function() oq.color_blind_mode( "next" ) ; end )
  
  y = y + cy ;
  local slider = oq.CreateFrame('Slider', 'oQSliderBar', parent, 'OptionsSliderTemplate') ;
  oq.setpos( slider, x-5, y, cx-2, cy ) ;
  slider:SetMinMaxValues( 75, 375 ) ;
  slider:SetValueStep( 5 ) ;
  getglobal(slider:GetName() .. 'Low' ):SetText('');
  getglobal(slider:GetName() .. 'High'):SetText(''); 
  getglobal(slider:GetName() .. 'Text'):SetText('');
  
  slider._value = oq.label( parent, x+150, y, 60, cy, "0", "CENTER", "LEFT" ) ; 
  slider:SetScript("OnValueChanged", function(self, value) 
                                       OQ_data.timer_width = floor(value) ;
                                       self._value:SetText( floor(value) ) ;
                                       oq.utimer_set_width( floor(value) ) ;
                                     end ) ;
               
  slider:SetValue( OQ_data.timer_width or 200 ) ;
  oq.utimer_set_width( OQ_data.timer_width or 200 ) ;
  
  --
  --  geek corner
  --
  x  = parent:GetWidth() - 200 ;
  x2 = parent:GetWidth() -  90 ;
  y  = parent:GetHeight() - 42 ;
  cy = 22 ;
  oq.label( parent, x, y, 150, cy, OQ.PPS_SENT ) ;
  oq.tab5_oq_pktsent = oq.label( parent, x2, y, 60, cy, "0", "MIDDLE", "RIGHT" ) ; 
  oq.tab5_oq_send_queuesz = oq.label( parent, x-30, y, 24, cy, "--", "MIDDLE", "RIGHT" ) ; 
  y = y - cy ; -- moving up
 
  oq.label( parent, x, y, 150, cy, OQ.PPS_PROCESSED ) ;
  oq.tab5_oq_pktprocessed = oq.label( parent, x2, y, 60, cy, "0", "CENTER", "RIGHT" ) ; 
  y = y - cy ; -- moving up
  
  oq.label( parent, x, y, 150, cy, OQ.PPS_RECVD ) ;
  oq.tab5_oq_pktrecv = oq.label( parent, x2, y, 60, cy, "0", "CENTER", "RIGHT" ) ; 
  y = y - cy ; -- moving up
  
  oq.tab5_oq_sk_dtime_err = oq.label( parent, x-26, y+4, 24, cy, OQ_REDX_ICON, "CENTER", "RIGHT" ) ; 
  oq.label( parent, x, y, 150, cy, OQ.OQSK_DTIME ) ;
  oq.tab5_oq_sk_dtime = oq.label( parent, x2-40, y, 100, cy, "0", "CENTER", "RIGHT" ) ; 
  y = y - cy ; -- moving up
  
  -- tag
  oq.tab5_tag = oq.place_tag( parent ) ;
  
  -- populate alt list
  oq.populate_alt_list() ; 
end

function oq.update_alltab_text() 
  OQMainFrameTab1:SetText( OQ.TAB_PREMADE       ) ; 
  OQMainFrameTab2:SetText( OQ.TAB_FINDPREMADE   ) ; 
  OQMainFrameTab3:SetText( OQ.TAB_CREATEPREMADE ) ; 
  OQMainFrameTab4:SetText( OQ.TAB_THESCORE      ) ; 
  OQMainFrameTab5:SetText( OQ.TAB_SETUP         ) ; 
  OQMainFrameTab6:SetText( OQ.TAB_BANLIST       ) ; 

  local nWaiting = oq.n_waiting() ;
  if (nWaiting > 0) then
    OQMainFrameTab7:SetText( string.format( OQ.TAB_WAITLISTN, nWaiting ) ) ;
  else
    OQMainFrameTab7:SetText( OQ.TAB_WAITLIST ) ;
  end
end

function oq.attach_pvp_queue()
  --
  -- hook pvp frame join-as-group button
  -- note: the bg-index and bg-type are now irrelevant since selection must be manual by the leaders
  --
  if (PVPUIFrame == nil) then
    return ;
  end
  local but = HonorFrameSoloQueueButton ; -- 5.2 update
  but:SetScript("PostClick", function(self) 
                               if (oq.iam_raid_leader()) then 
                                 oq.raid_join( 1, OQ.AB ) ; 
                               end 
                               oq.reset_button( self ) ;
                               self:Show() ;
                             end ) ;  
  but = HonorFrameGroupQueueButton ; -- 5.2 update
  but:SetScript("PostClick", function(self) 
                               if (oq.iam_raid_leader()) then 
                                 oq.raid_join( 1, OQ.AB ) ; 
                               end 
                               oq.reset_button( self ) ;
                               self:Show() ;
                             end ) ;  
  return 1 ; -- done
end

function oq.create_main_ui() 
  oq.karma_shield = oq.create_karma_shield( OQMainFrame ) ;
  oq.set_karma_shield( 0 ) ;

  oq.bounty_button = oq.create_bounty_board( OQMainFrame ) ;
  oq.log_button    = oq.create_log_button( OQMainFrame ) ;
  oq.filter_button = oq.create_filter_button( OQMainFrame ) ;
  
  ------------------------------------------------------------------------
  --  tab 1: current premade
  ------------------------------------------------------------------------
  oq.create_tab1() ;
  
  ------------------------------------------------------------------------
  --  tab 2: find premade
  ------------------------------------------------------------------------
  oq.create_tab2() ;
  
  ------------------------------------------------------------------------
  --  tab 3: create premade
  ------------------------------------------------------------------------
  oq.create_tab3() ;
    
  ------------------------------------------------------------------------
  --  tab 4: scores
  ------------------------------------------------------------------------
  oq.create_tab_score() ;
  
  ------------------------------------------------------------------------
  --  tab 5: setup
  ------------------------------------------------------------------------
  oq.create_tab_setup() ;
  
  ------------------------------------------------------------------------
  --  tab 6: ban list
  ------------------------------------------------------------------------
  oq.create_tab_banlist() ;
  
  ------------------------------------------------------------------------
  --  tab 7: waiting list
  ------------------------------------------------------------------------
  oq.create_tab_waitlist() ;
  
  oq.update_alltab_text() ;
  
  oq.timer( "attach_pvpui", 2, oq.attach_pvp_queue, true ) ;
    
  --
  -- leave queue macro button
  --
  oq.leaveQ = oq.CreateFrame("Button","OQLeaveQBut",UIParent,"SecureActionButtonTemplate UIPanelButtonTemplate") 
  oq.leaveQ:SetAttribute("type","macro") 

  oq.leaveQ:SetAttribute("macrotext", "/click QueueStatusMinimapButton \n/click DropDownList1Button3\n/click DropDownList1Button2");
  
  local t = oq.leaveQ:CreateTexture()
  t:SetParent(oq.leaveQ)
  t:SetTexture("Interface\\Addons\\Buttons\\UI-Panel-Button-Up.blp") ;
  oq.leaveQ:SetText( OQ.DLG_LEAVE ) ;
  oq.setpos( oq.leaveQ, 5,  65, 75, 25 ) ;
  oq.leaveQ:Hide() ;
  SecureHandlerWrapScript(oq.leaveQ,"OnClick",oq.leaveQ,[[ self:Hide() ; return nil,"done"]], [[ ]]) ;
  oq.leaveQ:SetScript( "OnHide", function(self) oq.angry_lil_button_done( self ) ; end ) ;
end

function oq.get_battle_tag()
  if (not BNConnected()) then
    local now = utc_time() ;
    oq._bnetdown_error_cnt = (oq._bnetdown_error_cnt or 0) + 1 ;
    if (oq._bnetdown_error_cnt < 3) then
      -- allow for 3 strikes before announcing.  
      -- b.net could just glitch for a few seconds, allow for recovery
      return nil ;
    end
    if (oq._bnetdown_error_tm == nil) or ((now - oq._bnetdown_error_tm) > 90) then
      oq._bnetdown_error_tm = now ;
      print( OQ_REDX_ICON ..L[" Battle.net is currently down."] ) ;
      print( OQ_REDX_ICON ..L[" oQueue will not function properly until Battle.net is restored."] ) ;
    end
    return nil ;
  end
  oq._bnetdown_error_cnt = nil ;
  oq._bnetdown_error_tm  = nil ;
  
  player_realid = select( 2, BNGetInfo() ) ;
  if (player_realid == nil) then
    local now = utc_time() ;
    if (oq._btag_error_tm == nil) or ((now - oq._btag_error_tm) > 120) then
      oq._btag_error_tm = now ;
      print( OQ_REDX_ICON ..L[" Please set your battle-tag before using oQueue."] ) ;
      print( OQ_REDX_ICON ..L[" Your battle-tag can only be set via your WoW account page."] ) ;
    end
    return nil ;
  end
  player_realid = strlower(player_realid) ;
  if (player_realid == strlower(OQ.SK_BTAG)) then
    oq._iam_scorekeeper = true ;
  end
  return player_realid ;
end

function oq.populate_tab2() 
  oq.get_battle_tag() ;
  oq.n_connections() ;
  oq.update_premade_count() ;
end

function oq.create_tab3_notice( parent )
  local pcx = parent:GetWidth() ;
  local pcy = parent:GetHeight() ;
  local cx = floor(pcx/2) ;
  local cy = floor(4*pcy/5) ;
  local f = oq.panel( parent, "Notice", floor((pcx - cx)/2), floor((pcy - cy)/2), cx, cy) ;
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                 edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                 tile=true, tileSize = 16, edgeSize = 16,
                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
                 })
  f:SetBackdropColor( 0.2, 0.2, 0.2, 1.0 ) ;
  f:SetAlpha( 1.0 ) ;
  oq.closebox( f, function(self) self:GetParent():GetParent():Hide() ; end ) ;

  local x = 15 ;
  local y = 20 ;
  for i,v in pairs(OQ.LFGNOTICE_DLG) do
    local s = v ;
    if (i ~= 2) then
      s = "|cFFE0E0E0".. v .."|r" ;
    end    
    local t = oq.label( f, x, y, cx-2*15, 20, string.format( s, dtstr ), "CENTER", "LEFT" ) ;
    t:SetFont(OQ.FONT, 16, "") ;
    y = y + 24 ;
  end
  
  f.ok_but = oq.button( f, floor((cx - 80)/2), cy - 50,  80, 32, "Okay", 
                        function(self) 
                          self:GetParent():GetParent():Hide() ; 
                        end ) ;
  return f ;
end

function oq.create_tab3_warning( parent )
  local pcx = parent:GetWidth() ;
  local pcy = parent:GetHeight() ;
  local cx = floor(pcx/2) ;
  local cy = floor(4*pcy/5) ;
  local f = oq.panel( parent, "TimeVariance", floor((pcx - cx)/2), floor((pcy - cy)/2), cx, cy) ;
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                 edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                 tile=true, tileSize = 16, edgeSize = 16,
                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
                 })
  f:SetBackdropColor( 0.2, 0.2, 0.2, 1.0 ) ;
  f:SetAlpha( 1.0 ) ;
  oq.closebox( f, function(self) self:GetParent():GetParent():Hide() ; end ) ;

  local x = 15 ;
  local y = 20 ;
  local dtstr = oq.render_tm( oq._sktime_last_dt ) ;
  for i,v in pairs(OQ.TIMEVARIANCE_DLG) do
    local s = v ;
    if (i ~= 2) then
      s = "|cFFE0E0E0".. v .."|r" ;
    end    
    local t = oq.label( f, x, y, cx-2*15, 20, string.format( s, dtstr ), "CENTER", "LEFT" ) ;
    t:SetFont(OQ.FONT, 16, "") ;
    if (v:find("%%s") ~= nil) then
      f.variance = t ;
      f.variance_str = s ;
    end
    y = y + 24 ;
  end

  return f ;
end

function oq.create_tab3_shade( parent )
  local cx = floor(parent:GetWidth()) ;
  local cy = floor(parent:GetHeight()) ;
  local f = oq.panel( parent, "Shade", 0, 0, cx, cy ) ;
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                 edgeFile=nil, 
                 tile=true, tileSize = 16, edgeSize = 16,
                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
               })
  f:SetBackdropColor( 0.2, 0.2, 0.2, 0.75 ) ;
  f:SetFrameLevel( 125 ) ;
  f:EnableMouse(true) ;
  return f ;
end

function oq.populate_tab3() 
  oq.get_battle_tag() ;
  
  oq.tab3_lead_name:SetText( player_name or "" ) ;
  oq.tab3_rid      :SetText( player_realid or "" ) ;
  
  local now = utc_time() ;
  local dt = oq._sktime_last_dt ;
  if (dt > 5*60) and (oq._sktime_last_tm > 0) then
    -- warning
    if (oq.ui_tab3_shade == nil) then
      oq.ui_tab3_shade = oq.create_tab3_shade( OQTabPage3 ) ;
    end
    if (oq.ui_tab3_warning == nil) then
      oq.ui_tab3_warning = oq.create_tab3_warning( oq.ui_tab3_shade ) ;
    end
    oq.ui_tab3_shade:Show() ;
    oq.ui_tab3_warning:Show() ;
    if (oq.ui_tab3_notice) then oq.ui_tab3_notice:Hide() ; end 
    
    local dtstr = oq.render_tm( oq._sktime_last_dt ) ;
    oq.ui_tab3_warning.variance:SetText( string.format( oq.ui_tab3_warning.variance_str, dtstr )) ;
  elseif (OQ_toon.tab3_notice == nil) or (OQ_toon.tab3_notice < now) then
    -- notice
    OQ_toon.tab3_notice = now + 7*24*60*60 ; -- once per week
    if (oq.ui_tab3_shade == nil) then
      oq.ui_tab3_shade = oq.create_tab3_shade( OQTabPage3 ) ;
    end
    if (oq.ui_tab3_notice == nil) then
      oq.ui_tab3_notice = oq.create_tab3_notice( oq.ui_tab3_shade ) ;
      oq.ui_tab3_shade:SetScript( "OnShow", function(self) oq.onShadeShow(self) ; end ) ;
      oq.ui_tab3_shade:SetScript( "OnHide", function(self) oq.onShadeHide(self) ; end ) ;
      oq.onShadeShow(oq.ui_tab3_shade) ; -- first time
    end
    oq.ui_tab3_shade:Show() ;
    if (oq.ui_tab3_warning) then oq.ui_tab3_warning:Hide() ; end
    oq.ui_tab3_notice:Show() ;    
  elseif (oq.ui_tab3_shade ~= nil) and (oq.ui_tab3_shade:IsVisible()) then
    oq.ui_tab3_shade:Hide() ;
    if (oq.ui_tab3_notice) then oq.ui_tab3_notice:Hide() ; end
    if (oq.ui_tab3_warning) then oq.ui_tab3_warning:Hide() ; end
  end
end

function oq.populate_dtime()
  if (not oq.tab5_oq_sk_dtime:IsVisible()) then
    return ;
  end
  local dtime_str = "--:--" ;
  if (oq._sktime_last_dt ~= nil) then
    dtime_str = oq.render_tm( oq._sktime_last_dt ) ;
    if (oq._sktime_last_dt > (15*60)) then
      oq.tab5_oq_sk_dtime_err:Show() ;
    else
      oq.tab5_oq_sk_dtime_err:Hide() ;
    end
  end
  oq.tab5_oq_sk_dtime:SetText( dtime_str ) ;
end

function oq.populate_tab_setup() 
  oq.get_battle_tag() ;

  oq.tab5_bnet:SetText( player_realid or "" ) ;
  if (_oqgeneral_id) then
    SetSelectedDisplayChannel( _oqgeneral_id ) ;
  end
  
  oq.populate_dtime() ;
end

function oq.onhide_tab_setup()
  OQ_data.realid = player_realid ;
end

function oq.on_monster_yell( ... ) 
  tbl.fill( _arg, ... ) ;  
  if (_arg[1]) and (OQ.DEFEAT_EMOTES[_arg[1]] ~= nil) then
    -- register boss kill
    local boss_id = OQ.DEFEAT_EMOTES[_arg[1]] ;
    oq.report_boss_kill( boss_id, oq._boss_guids[boss_id] ) ;
  end
end

function oq.on_party_event( msg, sender, lang, line_id )
  oq.echo_party_msg( sender, msg ) ;
end

function oq.on_lfg_completion_reward() 
  -- Fired when a random dungeon (picked by the Dungeon Finder) is completed
  -- only used by oQueue to detect scenario completion
  if (oq.raid.type == OQ.TYPE_SCENARIO) then
    oq.report_boss_kill( OQ.SCENARIO_BOSS_ID, OQ.SCENARIO_BOSS_ID ) ;
  end
end

function oq.is_my_req_token( req_tok )
  return oq.token_was_seen( req_tok ) ;
end

function oq.bnfriend_note( presenceId )
  if (presenceId == nil) or (presenceId == 0) then
    return nil ;
  end
  local noteText = select( 12, BNGetFriendInfoByID(presenceId)) ;
--  pid, givenName, surname, toonName, toonID, client, isOnline, lastOnline, 
--  isAFK, isDND, messageText, noteText, isFriend, unknown = BNGetFriendInfoByID(presenceID) ;
  return noteText ;
end

function oq.on_bnet_friend_invite() 
  local nInvites = BNGetNumFriendInvites() ; 
  if (nInvites == 0) then 
    return ;
  end
  -- 
  -- do the list backwards incase there are multiple
  --
  local valid_req = nil ;
  local is_lead = nil ;
  for i=nInvites,1,-1 do
    local presenceId, name, surname, message, timeSent, days = BNGetFriendInviteInfo( i ) ; 
    if ((message ~= nil) and (message ~= "")) then
      local msg_type = message:sub(1,#OQ_MSGHEADER) ;
      if (msg_type == OQ_MSGHEADER) then
        -- OQ message.  check note to see if i initiated it
        local msg = message:sub( message:find(OQ_MSGHEADER)+1, -1 ) ;
        local req_tok = nil ;
        local p = msg:find("#tok:") ;
        if (p) then
          req_tok = msg:sub( p+5, msg:find(",", p+5 )-1 ) ;
        end
        if (req_tok ~= nil) and (oq.is_my_req_token( req_tok )) then
          -- bn_realfriend_invite( r.realid, "#tok:".. req_token ..",#lead" ) ;
          if (msg:find("#lead")) then
            -- inviting to be group lead, bnfriend must stay
            BNAcceptFriendInvite(presenceId) ;
            oq.set_bn_enabled( presenceId ) ;
            oq.timer_oneshot( 1.5, oq.bn_check_online ) ;
            if (oq.bnfriend_note( presenceId ) == nil) then
              oq.timer_oneshot( 2, BNSetFriendNote, presenceId, "OQ,leader" ) ;    
            end                  
          elseif (msg:find("#grp:")) then
            -- inviting to be group member, bnfriend is temporary until grouped
            -- "#tok:".. req_token_ ..",#grp:".. my_group ..",#nam:".. player_name .."-".. player_realm 
            p = msg:find("#grp:") ;
            local group_id = msg:sub( p+5, p+5 ) ;
            if (group_id ~= nil) then
              my_group = tonumber(group_id) ;
              oq.ui_player() ;
              oq.update_my_premade_line() ;
              local lead = oq.raid.group[ my_group ].member[1] ;
              p = msg:find("#nam:") ;
              local n = msg:sub( p+5, -1 ) ;
              lead.name  = n:sub( 1, n:find("-")-1 ) ;
              lead.realm = n:sub( n:find("-")+1, -1 ) ;
              lead.realm = oq.realm_uncooked(lead.realm) ;
              BNAcceptFriendInvite(presenceId) ;
              oq.set_bn_enabled( presenceId ) ;
              oq.timer_oneshot( 1.5, oq.bn_check_online ) ;
              -- giving it some time to set the removal note
              local note = oq.bnfriend_note( presenceId ) ;
              if (note == nil) or (note:sub(1,7) == "REMOVE ") then
                oq.timer_oneshot( 1, BNSetFriendNote, presenceId, "" ) ; -- clear any previous note
                oq.timer_oneshot(15, BNSetFriendNote, presenceId, "REMOVE OQ" ) ;
              end
            end
          end
        else  -- not my token, inc OQ msg
          -- msg thru invite note, decline invite and process msg
           -- now process
           
           -- the b-tag is not sent along with the invite request (lame)
--          if (oq.is_banned( rid_ )) then
--            return ;
--          end
          oq._sender  = name .." ".. tostring(surname) ;
          _source     = "bnfinvite" ;
          _oq_note    = "OQ,leader" ;
          _oq_msg     = nil ;
          _ok2relay   = nil ; 
          _ok2decline = true ;
          oq.process_msg( oq._sender, message ) ;
          oq.post_process() ;

          -- valid OQ msg, remove from friend-req-list 
          if (_ok2decline) then
            oq.timer_oneshot( 1, BNDeclineFriendInvite, presenceId ) ; -- allow other accts to process the message before removing
          else
            BNAcceptFriendInvite(presenceId) ;
            oq.set_bn_enabled( presenceId ) ;
            oq.timer_oneshot( 1.5, oq.bn_check_online ) ;
            oq.timer_oneshot( 2, BNSetFriendNote, presenceId, _oq_note ) ;
          end
        end
      end
    end
  end
end

function oq.on_disband( raid_tok, token, local_override )
  oq._error_ignore_tm  = GetTime() + 5 ;
  if (oq.token_was_seen( token ) and (local_override == nil)) then
    _ok2relay = nil ; 
    return ;
  end
  oq.token_push( token ) ;
  oq.remove_premade( raid_tok ) ;
  -- clear from cache
  if (raid_tok) and (OQ_data._premade_info) then
    OQ_data._premade_info[ raid_tok ] = nil ; 
  end
  if (oq.raid.raid_token ~= raid_tok) then
    -- not my raid
    return ;
  end
  oq.raid_cleanup() ;
end

local oq_find_request = {} ;
--
-- this is called in response to a "find" message
--
function oq.queue_find_request( reply_token_, faction_, level_range_, realm_ )
  if (oq.token_was_seen( reply_token_ )) then
    _ok2relay = nil ;
    return ;
  end
  oq.token_push( reply_token_ ) ;
  realm_ = oq.realm_uncooked(realm_) ;

  -- to be processed within the next 10 seconds
  local now  = utc_time() ;
  local when = now + random( 3, 10 ) ;
  local tok  = reply_token_ ..".".. (utc_time() % 1000) ;
  oq_find_request[ tok ] = { reply_token = reply_token_, 
                             faction = faction_,
                             level_range = level_range_,
                             realm = realm_,
                             tm = when 
                           } ;
  oq.send_my_premade_info() ;
end

--
-- each group slot is 2 characters in group_hp representing the max_hp of the unit
-- max_hp of 0 for the slot means that slot is empty
-- this is reported by every group leader and echoe'd by the raid leader
-- ####
function oq.on_group_hp( raid_token, group_id, group_hp )
  if (oq.raid.raid_token ~= raid_token) then
    return ;
  end

  local a, b, hp ;
  group_id = tonumber(group_id) ;
  for i=1,5 do
    a  = oq_mime64[ group_hp:sub((i-1)*2+1,(i-1)*2+1) ] ;
    b  = oq_mime64[ group_hp:sub((i-1)*2+2,(i-1)*2+2) ] ;
    hp = (a * 36) + b ;
    if (hp == 0) then
      -- deadspot
      oq.raid_cleanup_slot( group_id, i ) ;
    else
      oq.raid.group[ group_id ].member[ i ].hp = hp ;
    end
  end
end

-- 
-- called by party_leader (my_group == group_id)
-- dead slots have hp of 0
--
function oq.get_group_hp()
  if ((my_group < 1) or (my_slot < 1)) then
    return ;
  end
  local spots = "" ;
  local hp, n, a, b ;
  for i = 1,5 do
    if (oq.raid.group[my_group].member) and (oq.raid.group[my_group].member[i]) then
      n  = oq.raid.group[ my_group ].member[ i ].name ;
      hp = 0 ;
      if ((n ~= nil) and (n ~= "held") and (n ~= "n/a") and (oq.raid.group[ my_group ].member[ i ].realm ~= nil)) then
        if (oq.raid.group[ my_group ].member[ i ].realm ~= player_realm) then
          n = n .."-".. oq.raid.group[ my_group ].member[ i ].realm ;
        end
        hp = UnitHealthMax( n ) ;
      end
      a = floor((hp / 1000) / 36) ;
      b = floor((hp / 1000) % 36) ;
      oq.raid.group[ my_group ].member[ i ].hp = (a * 36) + b ;
      spots = spots .."".. oq_mime64[ a ] .."".. oq_mime64[ b ] ;

      oq.set_status_online( my_group, i, (hp > 0) ) ;

      if (hp == 0) then
      -- deadspot
--      oq.raid_cleanup_slot( my_group, i ) ;
      end
    end
  end
  return spots ;
end

function oq.send_group_hp()
  if (oq.raid.raid_token == nil) then
    return ; 
  end
  if (not oq.iam_party_leader() and not oq.iam_raid_leader()) then
    return ;
  end
  local spots = oq.get_group_hp() ;
  if (spots) then
    oq.raid_announce( "group_hp,".. 
                       oq.raid.raid_token ..","..
                       my_group ..","..
                       spots
                    ) ;
  end
end

function oq.on_join( ndx, bg_type )
  oq.battleground_join( tonumber(ndx), tonumber(bg_type) ) ;
end

function oq.on_leave( ndx )
  oq.battleground_leave( tonumber(ndx) ) ;
end

function oq.on_leave_group( name, realm )
  -- clean up the raid ui
  for i=1,8 do
    for j=1,5 do
      local mem = oq.raid.group[i].member[j] ;
      if ((mem ~= nil) and (mem.name == name) and (mem.realm == realm)) then
        -- clean out the locker
        mem.name   = nil ;
        mem.class  = "XX" ;
        mem.realm  = nil ;
        mem.realid = nil ;
        oq.set_group_member( i, j, nil, nil, "XX", nil, "0", "0" ) ;
        oq.set_deserter( i, j, nil ) ;
        oq.set_role( i, j, OQ.ROLES["NONE"] ) ;
        if (j == 1) then
        
          oq.group_left( i ) ;
          oq.raid_announce( "remove_group,".. i ) ;          
        else
          oq.member_left( i, j ) ;
        end
        return ;
      end
    end
  end
end

function oq.on_leave_slot( g_id, slot )
  g_id = tonumber(g_id) ;
  slot = tonumber(slot) ;
  if (g_id == 0) or (slot == 0) then
    return ;
  end
  local mem = oq.raid.group[g_id].member[slot] ;
  if (mem == nil) then
    return ;
  end
  mem.name   = nil ;
  mem.class  = "XX" ;
  mem.realm  = nil ;
  mem.realid = nil ;
  oq.set_group_member( g_id, slot, nil, nil, "XX", nil ) ;
  oq.set_deserter( g_id, slot, nil ) ;
  oq.set_role( g_id, slot, OQ.ROLES["NONE"] ) ;
  if (slot == 1) then
    oq.group_left( g_id ) ;
    oq.raid_announce( "remove_group,".. g_id ) ;
  else
    oq.member_left( g_id, slot ) ;
  end
end

--
-- intended for group leader 
--
function oq.on_proxy_invite( group_id, slot_, enc_data_, req_token_ ) 
  group_id = tonumber( group_id ) ;
  slot     = tonumber( slot ) ;

  if ((not oq.iam_party_leader()) or (group_id == nil) or (group_id ~= my_group)) then
    return ;
  end
  if (oq.raid.raid_token == nil) then
    return ;
  end

  local enc_data = oq.encode_data( "abc123", 
                                   player_name, 
                                   player_realm, 
                                   player_realid ) ;
  local msg = "OQ,".. 
              OQ_VER ..",".. 
              "W1,"..
              "1,"..
              "proxy_target,".. 
              group_id ..","..
              slot_ ..","..
              enc_data ..","..
              oq.raid.raid_token ..","..
              req_token_ ;
              
  -- this is the target name, realm, and real-id
  local  name, realm, rid_ = oq.decode_data( "abc123", enc_data_ ) ;
  if (realm == player_realm) then
    -- on my realm, let player know he's in my group then invite him
    oq.realid_msg( name, realm, rid_, msg ) ;
    oq.timer_oneshot( 1.5, oq.InviteUnit, name, realm ) ;
    oq.timer_oneshot( 2.5, oq.brief_group_members ) ;  
    return ;
  end
  
  local n = name .."-".. realm ;
  if (oq.pending_invites == nil) then
    oq.pending_invites = {} ;
  end
  oq.pending_invites[ n ] = { raid_tok = oq.raid.raid_token, gid = my_group, slot = slot_, rid = rid_, req_token = req_token_ } ;
  
  local pid = oq.bnpresence( name .."-".. realm ) ;
  if (pid ~= 0) then
    oq.realid_msg( name, realm, rid_, msg ) ;
    oq.timer_oneshot( 1.5, oq.InviteUnit, name, realm ) ;
    oq.timer_oneshot( 2.5, oq.brief_group_members ) ;  
    return ;
  end
  
  -- if reaches here, player is not b-net friend or not on realm... must b-net friend then invite
  oq.bn_realfriend_invite( name, realm, rid_, "#tok:".. req_token_ ..",#grp:".. my_group ..",#nam:".. player_name .."-".. tostring(oq.realm_cooked(player_realm)) ) ; 

  _ninvites = _ninvites + 1 ;
  oq.timer( "invite_to_group".. _ninvites, 2, oq.timer_invite_group_member, true, name, realm, rid_, msg, my_group, slot_, req_token_ ) ;  
end

--
-- intended for recruit  
--
function oq.on_proxy_target( group_id, slot, enc_data, raid_token ) 
  group_id = tonumber( group_id ) ;
  slot     = tonumber( slot ) ;

  local  gl_name, gl_realm, gl_rid = oq.decode_data( "abc123", enc_data ) ;
  my_group = group_id ;
  my_slot  = slot ;
  oq.ui_player() ;
  oq.update_my_premade_line() ;
  
  -- set group leader to prepare for invite
  oq.raid.group[ group_id ].member[ 1 ].name   = gl_name ;
  oq.raid.group[ group_id ].member[ 1 ].realm  = gl_realm ;
  oq.raid.group[ group_id ].member[ 1 ].realid = gl_rid ;
  oq.raid.raid_token = raid_token ;

  if (gl_realm ~= player_realm) then
    oq.bn_realfriend_invite( gl_name, gl_realm, gl_rid ) ; -- will need to be b-net friends to invite cross-realm (!!!!)
  end
end

--
-- fired by raid leader
--
function oq.proxy_invite( group_id, slot, name, realm, rid, req_token ) 
  if ((oq.raid.group[ group_id ].member[1].name == nil) or (oq.raid.group[ group_id ].member[1].name == "-")) then
    return ;
  end

  --
  -- creating new msgs... ok to turn off sender info
  --
  oq._sender = nil ;

  --[[ if group to be invited to isn't my group, send message out for that group-leader to do the invite ]]--
  if (my_group == group_id) then
    local enc_data = oq.encode_data( "abc123", name, realm, rid ) ;
    oq.on_proxy_invite( group_id, slot, enc_data, req_token ) ;
  else
    -- not my group, ask the other group leader to invite
    msg_tok = "W".. oq.token_gen() ;
    oq.token_push( msg_tok ) ;

    enc_data = oq.encode_data( "abc123", name, realm, rid ) ;
    local m = "OQ,".. 
              OQ_VER ..",".. 
              msg_tok ..","..
              OQ_TTL ..","..
              "proxy_invite,".. 
              group_id ..","..
              slot ..","..
              enc_data ..","..
              req_token ;

    local lead = oq.raid.group[ group_id ].member[1] ;
    oq.realid_msg( lead.name, lead.realm, lead.realid, m ) ;
  end
end

function oq.valid_rid( rid )
   if (rid == nil) or (rid == OQ_NOEMAIL) then
      return nil ;
   end
   -- good battle-tag has a '#' in the middle
   if (rid:find("#") ~= nil) then
      -- battle-tag
      return true ;
   end
   if (rid:find("+") or rid:find("&")) then
      return nil ;
   end
   -- good email has a '@' and a '.'
   local f1 = rid:find("@") ;
   if (f1 ~= nil) then
      local f2 = rid:find(".", f1) ;
      if (f2 ~= nil) then
         -- possible email 
         return true ;
      end
   end
   return nil ;
end

-- will need to real-id friend the person in order to invite  (!!!!)
function oq.bn_realfriend_invite( name, realm, rid, extra_note ) 
  if ((rid == nil) or (rid == OQ_NOEMAIL)) then
    return ;
  end
  if (not oq.valid_rid( rid )) then
    message( OQ.BAD_REALID .." ".. tostring(rid) ) ;
    return ;
  end
  
  oq.bntoons() ;
  local friend = OQ_data.bn_friends[ name .."-".. realm ] ;
  if (friend ~= nil) and friend.isOnline and friend.oq_enabled then
    -- won't try to add if friended at all.  oq enabled or not
    return ;
  end
  if (friend ~= nil) and (friend.presenceId == 0) then
    return ;
  end
  
  -- if already friended, ok to re-try.  will fail silently (well, red text top center)
  local msg = "OQ,".. oq.raid.raid_token ;
  if (extra_note) then
    msg = msg ..",".. extra_note ;
  end
  oq.BNSendFriendInvite( rid, msg, "OQ,mesh node" ) ;
  
  oq.timer_oneshot( 15, oq.set_note_if_null, name, realm, "OQ,".. oq.raid.raid_token ) ;
end

function oq.set_note_if_null( name, realm, note )
  oq.bntoons() ;
  local friend = OQ_data.bn_friends[ name .."-".. realm ] ;
  if (friend == nil) or (not friend.isOnline) then
    return ;
  end
  local pid = friend.presenceID or 0 ;
  if (oq.bnfriend_note( pid ) == nil) then
    BNSetFriendNote( pid, note ) ;
  end
end

function oq.raid_identify_self()
  oq.raid_announce( "identify,0" ) ;
end

function oq.brief_group_lead( group_id ) 
  local name  = oq.raid.group[group_id].member[1].name ;
  local realm = oq.raid.group[group_id].member[1].realm ;
  if (name == nil) or (realm == nil) then
    return ;
  end
  oq._sender = nil ;
  for i=1,8 do
    if (i ~= group_id) then
      local grp = oq.raid.group[i] ;
      if (grp._names ~= nil) then
        oq.whisper_msg( name, realm, grp._names ) ;
      end
      if (grp._stats ~= nil) then
        oq.whisper_msg( name, realm, grp._stats ) ;
      end
    end
  end
end

function oq.assign_lucky_charms()
  if (oq.raid.raid_token == nil) then
    return ;
  end
  -- assigning lucky charms, first come first served
  local charm = 1 ;
  for i=1,8 do
    if (oq.raid.group[i]) then
      for j=1,5 do
        if (oq.raid.group[i].member) then
          local m = oq.raid.group[i].member[j] ;
          if (m) and (m.name) and (m.name ~= "-") and (m.name ~= "") then
            if (m.role == OQ.ROLES["HEALER"]) and (charm < 8) then
              if (m.charm ~= charm) then
                oq.leader_set_charm( i, j, charm ) ;
              end
              charm = charm + 1 ;
            elseif (m.charm ~= 0) then
              oq.leader_set_charm( i, j, 0 ) ;
            end
        
            -- set the charm if currently in the bg
            if (oq._inside_instance and oq.IsRaidLeader()) then
              if (m.name == player_name) then
                SetRaidTarget( "player", m.charm or 0 ) ;
              else
                local n = m.name ;
                if (m.realm ~= player_realm) then
                  n = n .."-".. m.realm ;
                end
                SetRaidTarget( n, m.charm or 0 ) ;
              end
            end
          end
        end
      end
    end
  end
  _lucky_charms = (_inside_bg and oq.IsRaidLeader()) ;
end

function oq.handout_lucky_charms()
  if (not oq.IsRaidLeader()) or (oq.raid.raid_token == nil) then
    return ;
  end
  -- i am the bg leader and we are inside, hand out lucky charms
  for i=1,8 do
    for j=1,5 do
      local m = oq.raid.group[i].member[j] ;
      if (m.name) and (m.name ~= "-") and (m.name ~= "") and (m.realm) then
        if (m.name == player_name) then
          SetRaidTarget( "player", m.charm or 0 ) ;
        else
          local n = m.name ;
          if (m.realm) and (m.realm ~= player_realm) then
            n = n .."-".. m.realm ;
          end
          SetRaidTarget( n, m.charm or 0 ) ;
        end
      end
    end
  end
  _lucky_charms = true ;
end

function oq.IsRaidLeader()
  if (oq._instance_type and ((oq._instance_type == "party") or (oq._instance_type == "raid"))) then
    return oq.iam_raid_leader() ; -- OQ leader is the lead
  else
    return UnitIsGroupLeader("player") ;  -- pandaria update
  end
end

local last_group_brief = 0 ;
function oq.group_lead_bookkeeping()
  if (oq.iam_raid_leader() and _inside_bg and (not _lucky_charms) and oq.IsRaidLeader()) then
    oq.timer_oneshot( 30, oq.handout_lucky_charms ) ;    
  end

  if (my_slot ~= 1) or (_inside_bg) then
    return ;
  end
  local now = utc_time() ;
  if (now < (last_group_brief + OQ_BOOKKEEPING_INTERVAL)) then
    return ;
  end
  last_group_brief = now ;
  
  -- update online status
  for slot=2,5 do
    local m = oq.raid.group[my_group].member[slot] ;
    if (m.name) and (m.name ~= "-") then
      local n = m.name ;
      if (m.realm ~= player_realm) then
        n = n .."-".. m.realm ;
      end
      
      -- online status check
      oq.set_status_online( my_group, slot, UnitIsConnected( n ) ) ;
    end
  end
end
  
function oq.ready_check( g_id, slot, stat )
  g_id = tonumber( g_id ) ;
  slot = tonumber( slot ) ;
  stat = tonumber( stat ) ;
  if (g_id == 0) or (slot == 0) then
    return ;
  end
  oq.raid.group[ g_id ].member[ slot ].check = stat ;
  oq.set_textures( g_id, slot ) ;
end

function oq.on_ready_check_complete()
  for grp=1,8 do
    for s=1,5 do
      oq.raid.group[grp].member[s].check = OQ.FLAG_CLEAR ;
      oq.set_textures( grp, s ) ;
    end
  end
end

local last_brief_tm = 0 ;
function oq.brief_group_members() 
  local now = utc_time() ;
  if (my_slot ~= 1) or (now < (last_brief_tm + OQ_BRIEF_INTERVAL) or (_inside_bg)) then
    return ;
  end
  last_brief_tm = now ;
  
  local mygrp = oq.raid.group[my_group] ;
  
  -- send party info
  local enc_data = oq.encode_data( "abc123", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ;
  oq.party_announce( "party_join,".. 
                      my_group ..","..
                      oq.encode_name( oq.raid.name ) ..",".. 
                      oq.raid.leader_class ..",".. 
                      enc_data ..",".. 
                      oq.raid.raid_token  ..",".. 
                      oq.encode_note( oq.raid.notes )
                   ) ;

  -- send party slots
  local msg = "party_slots,"..
               my_group ..",".. 
               oq.raid.type ;
  for i=1,5 do
    local name = mygrp.member[i].name ;
    if (name == nil) or (name == "") or (name == "-") then
      name = "-" ;
    end
    msg = msg ..",".. name ;
  end 
  oq.party_announce( msg ) ;
  
  -- send group info from other known groups
  oq._sender = nil ;
  for i=1,8 do
    local grp = oq.raid.group[i] ;
    if (grp._names ~= nil) then
      oq.party_announce( grp._names ) ;
    end
    if (grp._stats ~= nil) then
      oq.party_announce( grp._stats ) ;
    end
  end
end

--
--  received by the raid-leader
--
function oq.on_invite_accepted( raid_token, group_id, slot, class, enc_data, req_token )
  if (oq.raid.raid_token ~= raid_token) then
    return ;
  end
  if (not oq.iam_raid_leader()) then
    return ;
  end

  group_id = tonumber( group_id ) ;
  slot     = tonumber( slot ) ;

  local  name, realm, rid = oq.decode_data( "abc123", enc_data ) ;
  oq.set_group_member( group_id, slot, name, realm, class, rid ) ;

  if (slot == 1) then
    -- unit is new group leader, brief him
    oq.timer( "brief_leader", 1.5, oq.brief_group_lead, nil, group_id ) ;
    return ;
  end 

  -- invite (by proxy if needed)
  if ((realm == player_realm) and (group_id == my_group)) then
    -- direct invite ok
    local enc = oq.encode_data( "abc123", name, realm, rid ) ;  -- rid not needed, as the invite goes to this realm
    oq.on_proxy_invite( group_id, slot, enc, req_token ) ;
  else
    oq.proxy_invite( group_id, slot, name, realm, rid, req_token ) 
  end
  
  -- not the best, as we don't have resil and ilevel, but that will be updated when we queue.
-- this is on a 60 sec timer
--  oq.send_my_premade_info() ;  
end

function oq.update_my_premade_line()
  if (oq.raid.raid_token == nil) then
    return ;
  end
  
  -- update status 
  local raid = oq.premades[ oq.raid.raid_token ] ;
  if (raid ~= nil) then
    local s = raid.stats ;
    local line = oq.find_premade_entry( raid.raid_token ) ;
    if (line ~= nil) then
      line.req_but:Disable() ;
      if (raid.has_pword) then
        line.has_pword.texture:Show() ;
        line.has_pword.texture:SetTexture( OQ_KEY ) ;
      else
        line.has_pword.texture:Hide() ;
        line.has_pword.texture:SetTexture( nil ) ;
      end
    end  
  end
  
  local now = utc_time() ;
  if (oq._last_btag_send == nil) or ((now - oq._last_btag_send) > 30) or ((my_group * 10 + my_slot) ~= oq._last_btag_pos) then
    oq._last_btag_send = now ;
    oq._last_btag_pos  = my_group * 10 + my_slot ;
    oq.send_my_btag_to_raid() ;
  end
end

function oq.on_invite_group_lead( req_token, group_id, raid_name, raid_leader_class, enc_data, raid_token, raid_notes )
  if (not oq.token_was_seen( req_token )) then
    return ;
  end
  local  raid_leader, raid_leader_realm, raid_leader_rid = oq.decode_data( "abc123", enc_data ) ;
  _received = true ;
  group_id = tonumber(group_id) ;
  raid_name  = oq.decode_name( raid_name ) ;
  raid_notes = oq.decode_note( raid_notes ) ;
  if (not raid_notes) then
    raid_notes = "" ;
  end
  
  if (oq.iam_raid_leader() and (oq.raid.raid_token ~= raid_token)) then
    -- tried to start my own premade, but join another instead.  
    -- my original premade must be disbanded
    oq.raid_disband() ;
  end

  -- activate in-raid only procs
  oq.procs_join_raid() ;
  
  -- make sure i'm not queue'd
  oq.battleground_leave( 1 ) ;
  oq.battleground_leave( 2 ) ;  

  my_group             = group_id ;
  my_slot              = 1 ;
  oq.raid.name         = raid_name ;
  oq.raid.leader       = raid_leader ;
  oq.raid.leader_class = raid_leader_class ;
  oq.raid.leader_realm = raid_leader_realm ;
  oq.raid.leader_rid   = raid_leader_rid ;
  oq.raid.notes        = (raid_notes or "") ;
  oq.raid.raid_token   = raid_token ;
  
  oq.log( nil, "|cFF808080joined group:|r ".. tostring(oq.raid.name) .."" ) ;
  oq.log( nil, oq.btag_link( "group leader", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ) ;

  oq.tab1_name :SetText( raid_name ) ;
  oq.tab1_notes:SetText( raid_notes ) ;

  oq.set_group_lead( group_id, player_name, player_realm, player_class, player_realid ) ;
  local me = oq.raid.group[group_id].member[1] ;
  me.name   = player_name ;
  me.realm  = player_realm ;
  me.level  = player_level ;
  me.class  = player_class ;
  me.resil  = player_resil ;
  me.ilevel = player_ilevel ;
  me.realid = player_realid ;
  me.check  = OQ.FLAG_CLEAR ;

  oq.send_invite_accept( raid_token, group_id, my_slot, player_name, player_class, player_realm, player_realid, req_token ) ;
  
  -- assign slots to the party members
  oq.party_assign_slots( group_id, enc_data ) ;
  
  -- remove myself from other waitlists
  oq.clear_pending() ;
  oq.ui_player() ;
  oq.update_my_premade_line() ;
  
  -- null out the group stats will force stats send
  last_stats = nil ;
  oq.raid.group[ my_group ]._stats = nil ;
  oq.raid.group[ my_group ]._names = nil ; 
  
  -- make sure we don't decline the friend request
  _ok2decline = nil ;
end

function oq.party_assign_slots( group_id, enc_data )
  local  n_members = oq.GetNumPartyMembers() ;
  if (n_members == 0) then
    return ;
  end
  
  -- send party members raid info and slot assignment
  oq.party_announce( "party_join,".. 
                      group_id ..","..
                      oq.encode_name( oq.raid.name ) ..",".. 
                      oq.raid.leader_class ..",".. 
                      enc_data ..",".. 
                      oq.raid.raid_token  ..",".. 
                      oq.encode_note( oq.raid.notes )
                   ) ;
  local msg = "party_slots,"..                   
               group_id ..","..
               oq.raid.type ..","..
               player_name ;
  for i=1,4 do
    local name = GetUnitName( "party".. i, true )
    if (name) then
      if (name:find(" - ") ~= nil) then
        name  = name:sub(1,name:find(" - ")-1) ;
      end
    else
      name = "-" ;
    end
    msg = msg ..",".. name ;
  end 
  
  oq.party_announce( msg ) ;
end

function oq.on_raid_join( raid_name, premade_type, raid_leader_class, enc_data, raid_token, raid_notes )
  if (_msg_type ~= 'R') then
    return ;
  end
  
  local  raid_leader, raid_leader_realm, raid_leader_rid = oq.decode_data( "abc123", enc_data ) ;
  _received = true ;

  raid_name  = oq.decode_name( raid_name ) ;
  raid_notes = oq.decode_note( raid_notes ) ;

  oq.raid.name         = raid_name ;
  oq.raid.leader       = raid_leader ;
  oq.raid.leader_class = raid_leader_class ;
  oq.raid.leader_realm = raid_leader_realm ;
  oq.raid.leader_rid   = raid_leader_rid ;
  oq.raid.notes        = raid_notes or "" ;
  oq.raid.raid_token   = raid_token ;

  oq.set_group_member( 1, 1, raid_leader, raid_leader_realm, raid_leader_class, raid_leader_rid, "0", "0" ) ;
  
  oq.tab1_name :SetText( raid_name ) ;
  oq.tab1_notes:SetText( raid_notes ) ;
  
  -- activate in-raid only procs
  oq.procs_join_raid() ;  
  oq.set_premade_type( premade_type ) ;
  oq.ui_player() ;
  oq.update_my_premade_line() ;
  oq.timer_oneshot( 3, oq.send_my_btag_to_raid ) ;
end

function oq.on_party_join( group_id, raid_name, raid_leader_class, enc_data, raid_token, raid_notes )
  if (_msg_type ~= 'P') then
    return ;
  end
  
  local  raid_leader, raid_leader_realm, raid_leader_rid = oq.decode_data( "abc123", enc_data ) ;
  _received = true ;

  raid_name  = oq.decode_name( raid_name ) ;
  raid_notes = oq.decode_note( raid_notes ) ;

  my_group             = tonumber(group_id) ;
  oq.raid.name         = raid_name ;
  oq.raid.leader       = raid_leader ;
  oq.raid.leader_class = raid_leader_class ;
  oq.raid.leader_realm = raid_leader_realm ;
  oq.raid.leader_rid   = raid_leader_rid ;
  oq.raid.notes        = raid_notes or "" ;
  oq.raid.raid_token   = raid_token ;
  
  oq.set_group_member( 1, 1, raid_leader, raid_leader_realm, raid_leader_class, raid_leader_rid, "0", "0" ) ;

  oq.tab1_name :SetText( raid_name ) ;
  oq.tab1_notes:SetText( raid_notes ) ;
  
  -- activate in-raid only procs
  oq.procs_join_raid() ;  
  oq.ui_player() ;
  oq.update_my_premade_line() ;
  oq.timer_oneshot( 3, oq.send_my_btag_to_raid ) ;
end

function oq.on_party_slots( group_id, premade_type, n1, n2, n3, n4, n5 )
  if (_msg_type ~= 'P') then
    return ;
  end
  if (premade_type ~= nil) then
    oq.set_premade_type( premade_type ) ;
  end
  oq.on_party_slot( n1, group_id, 1 ) ;
  oq.on_party_slot( n2, group_id, 2 ) ;
  oq.on_party_slot( n3, group_id, 3 ) ;
  oq.on_party_slot( n4, group_id, 4 ) ;
  oq.on_party_slot( n5, group_id, 5 ) ;
end

function oq.player_demographic()
  local _, raceId = UnitRace( "player" ) ;
  local gender = UnitSex( "player" ) ; 
  -- gender can now be: 2(male) 3(female) or 1(neutrum/unknown) ......
  if (gender == 2) then
    gender = 0 ; -- represented in a bit flag, 0 and 1 are better
  else
    gender = 1 ;
  end
  return gender, OQ.RACE[raceId] ; -- 1 == female, 0 == male
end

function oq.on_party_slot( name, group_id, slot, premade_type )
  if (name ~= player_name) or ((_msg_type ~= 'P') and (_msg_type ~= 'A') and (_msg_type ~= 'R')) then
    return ;
  end
  my_group  = tonumber( group_id ) ;
  my_slot   = tonumber( slot ) ;
  
  if (premade_type ~= nil) then
    oq.set_premade_type( premade_type ) ;
  end

  -- populate the slot for myself
  local me = oq.raid.group[ my_group ].member[ my_slot ] ;
  oq.get_my_stats() ; -- will populate 'me'

-- use to be:
-- OQ_NONE, 0, OQ_NONE, 0, 
--  local stats = oq.encode_my_stats( me.flags, me.check, me.charm, me.bg[1].status, me.bg[2].status ) ;
  oq._override = true ;
  oq.on_stats( player_name, oq.realm_cooked(player_realm), me.stats ) ;
  oq.ui_player() ;
  oq.update_my_premade_line() ;

  -- push stats for everyone else in the raid
  last_stats = nil ;
end

function oq.mmr_check(base)
  if (base == 0) then
    return true ;
  end
  if (oq.raid.type == OQ.TYPE_ARENA) then
    if (oq.get_arena_rating(1) < base) and (oq.get_arena_rating(2) < base) and (oq.get_arena_rating(3) < base) then
      return nil ;
    end
  elseif (base > oq.get_mmr()) then
    return nil ;
  end
  return true ;
end

function oq.update_premade_note()
  if (not oq.iam_raid_leader()) then
    return ;
  end
  local name = oq.tab3_raid_name:GetText() ;
  local note = oq.tab3_notes:GetText() ;
  
  oq.raid.name  = name ;  
  oq.raid.notes = note ;
  
  if (oq.get_resil()  < oq.numeric_sanity( oq.tab3_min_resil:GetText() )) or 
     (oq.get_ilevel() < oq.numeric_sanity( oq.tab3_min_ilevel:GetText() )) or 
     (not oq.mmr_check(oq.numeric_sanity( oq.tab3_min_mmr:GetText() ))) then
    StaticPopup_Show("OQ_DoNotQualifyPremade") ;
    return ;
  end

  
  oq.tab1_name :SetText( oq.raid.name ) ;
  oq.tab1_notes:SetText( oq.raid.notes ) ; 
  oq.raid.level_range      = oq.tab3_level_range ;
  oq.raid.min_ilevel       = oq.numeric_sanity( oq.tab3_min_ilevel:GetText() ) ;
  oq.raid.min_resil        = oq.numeric_sanity( oq.tab3_min_resil:GetText() ) ;
  oq.raid.min_mmr          = oq.numeric_sanity( oq.tab3_min_mmr:GetText() ) ;
  oq.raid.bgs              = string.gsub( oq.tab3_bgs:GetText() or ".", ",", ";" ) ;
  oq.raid.pword            = oq.tab3_pword:GetText() or "" ;
  if (oq.raid.pword == nil) or (oq.raid.pword == "") then
    oq.raid.has_pword = nil ;
  else
    oq.raid.has_pword = true ;
  end

  oq.raid_announce( "premade_note,"..
                    oq.raid.raid_token ..","..
                    oq.encode_name( name ) ..","..
                    oq.encode_note( note ) 
                  ) ;
  local premade = oq.premades[ oq.raid.raid_token ] ;                  
  if (premade ~= nil) then      
    premade.tm          = 0 ;            
    premade.last_seen   = utc_time() ;
    premade.next_advert = 0 ;    
    premade.min_ilevel  = oq.raid.min_ilevel ;
    premade.min_resil   = oq.raid.min_resil ;
    premade.min_mmr     = oq.raid.min_mmr ;
    premade.pdata       = oq.get_pdata() ;
  end
  oq.send_my_premade_info() ;
  return 1 ;
end

function oq.on_premade_note( raid_token, name, note )
  if (oq.raid.raid_token == nil) or (oq.raid.raid_token ~= raid_token) then
    return ;
  end
  name = oq.decode_name( name ) ;
  note = oq.decode_note( note ) ;

  oq.raid.name = name ;  
  oq.tab1_name :SetText( oq.raid.name ) ;
  
  oq.raid.notes = note ;
  oq.tab1_notes:SetText( oq.raid.notes ) ; 
end

function oq.find_player_slot( g_id, name, realm )
  for i=1,5 do
    local p = oq.raid.group[g_id].member[i] ;
    if (p.name ~= nil) and (p.name == name) and (p.realm == realm) then
      return i ;
    end
  end
  return 0 ;
end

function oq.on_promote( g_id, name, realm, lead_rid, leader_realm, req_token )
  g_id = tonumber(g_id) ;
  slot = tonumber(slot) ;
  if (my_group ~= g_id) and (g_id ~= 1) then
    return ;
  end
  oq.token_push( req_token ) ; -- push it to the list so auto-realid-invites can happen

  if (g_id == 1) and (my_group ~= 1) and (my_slot == 1) then
    -- connect with oq-leader
    if (realm ~= player_realm) then
      local pid = oq.bnpresence( name .."-".. realm ) ;
      if (pid == 0) then
        -- real-id the oq-leader
        oq.realid_msg( name, realm, lead_rid, "#tok:".. req_token ..",#lead" ) ;
      end
    end
    -- push info
    lead_ticker = 0 ;
    oq.timer_oneshot( 1, oq.force_stats ) ;
    return ;
  end
  if (my_slot == 1) or oq.iam_party_leader() then
    -- take the slot of the target
    local p_slot = oq.find_player_slot( g_id, name, realm ) ;
    if (p_slot == 0) then
      return ;
    end
    -- send to party BEFORE processing
    oq.channel_party( _msg ) ;
    _ok2relay = nil ;
    
    -- promote
    my_slot = p_slot ;
    if (realm ~= player_realm) then
      PromoteToLeader( name .."-".. realm ) ;
    else
      PromoteToLeader( name ) ;
    end
    -- update info
--    oq.set_group_lead( g_id, name, realm, oq.raid.group[g_id].member[p_slot].class, nil ) ;
    oq.set_group_lead( g_id, name, realm, player_class, player_realid ) ;
    oq.set_name      ( g_id, my_slot, player_name, player_realm, player_class ) ;
    
    -- push info
    lead_ticker = 0 ;
    oq.timer_oneshot( 1, oq.force_stats ) ;
  elseif (player_name == name) then
    -- change my_slot
    local p_slot = my_slot ;
    my_slot = 1 ;
    -- update info
    local p = oq.raid.group[g_id].member[1] ;
    oq.set_name      ( g_id, p_slot, p.name, p.realm, p.class ) ;
    oq.set_group_lead( g_id, name, realm, player_class, player_realid ) ;
    -- push info
    lead_ticker = 0 ;
    oq.timer_oneshot( 3, oq.force_stats ) ;
    if (g_id == 1) then
      oq.ui_raidleader() ;
    end

    -- connect with oq-leader
    if (player_realm ~= leader_realm) and (g_id ~= 1) then
      local r = oq.raid.group[1].member[1] ;
      local pid = oq.bnpresence( r.name .."-".. r.realm ) ;
      if (pid == 0) then
        -- real-id the oq-leader
        oq.realid_msg( r.name, r.realm, lead_rid, "#tok:".. req_token ..",#lead" ) ;
      end
    end
    -- push info
    lead_ticker = 0 ;
    oq.timer_oneshot( 1, oq.force_stats ) ;
  end
end

function oq.on_invite_group( req_token, group_id, slot, raid_name, raid_leader_class, enc_data, raid_token, raid_notes )
  if (not oq.token_was_seen( req_token )) then
    return ;
  end
  local  raid_leader, raid_leader_realm, raid_leader_rid = oq.decode_data( "abc123", enc_data ) ;
  _received = true ;
  _ok2relay = nil ;

  if (oq.iam_raid_leader() and (oq.raid.raid_token ~= raid_token)) then
    -- tried to start my own premade, but join another instead.  
    -- my original premade must be disbanded
    oq.raid_disband() ;
  end

  -- activate in-raid only procs
  oq.procs_join_raid() ;

  -- make sure i'm not queue'd
  oq.battleground_leave( 1 ) ;
  oq.battleground_leave( 2 ) ;  
  
  raid_name  = oq.decode_name( raid_name ) ;
  raid_notes = oq.decode_note( raid_notes ) ;
  
  my_group             = tonumber(group_id) ;
  my_slot              = tonumber(slot) ;
  oq.raid.name         = raid_name ;
  oq.raid.leader       = raid_leader ;
  oq.raid.leader_class = raid_leader_class ;
  oq.raid.leader_realm = raid_leader_realm ;
  oq.raid.leader_rid   = raid_leader_rid ;
  oq.raid.notes        = raid_notes ;
  oq.raid.raid_token   = raid_token ;

  oq.log( nil, "|cFF808080joined group:|r ".. tostring(oq.raid.name) .."" ) ;
  oq.log( nil, oq.btag_link( "group leader", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ) ;
  
  local me = oq.raid.group[my_group].member[my_slot] ;
  me.name   = player_name ;
  me.realm  = player_realm ;
  me.level  = player_level ;
  me.class  = player_class ;
  me.resil  = player_resil ;
  me.ilevel = player_ilevel ;
  me.realid = player_realid ;
  me.check  = OQ.FLAG_CLEAR ;
  me.charm  = 0 ;

  oq.tab1_name :SetText( raid_name ) ;
  oq.tab1_notes:SetText( raid_notes ) ;

  oq.set_group_lead( 1, raid_leader, raid_leader_realm, raid_leader_class, raid_leader_rid ) ;
  oq.set_group_member( group_id, slot, player_name, player_realm, player_class, player_realid, "0", "0" ) ;

  -- send out invite acceptance
  oq.send_invite_accept( raid_token, group_id, slot, player_name, player_class, player_realm, player_realid, req_token ) ;

  -- send out my status (give it time for the group invites to settle)
--  oq.timer( "mystatus", 2, oq.send_my_status ) ; 

  -- remove myself from other waitlists
  oq.clear_pending() ;
  oq.ui_player() ;
  oq.update_my_premade_line() ;

  -- null out the group stats will force stats send
  last_stats = nil ;
  oq.raid.group[ my_group ]._stats = nil ;
  oq.raid.group[ my_group ]._names = nil ; 
  
end

function oq.on_member( group_id, slot, class, name, realm )
  realm = oq.realm_uncooked(realm) ;
  oq.set_group_member( group_id, slot, name, realm, class, nil ) ;
end

function oq.on_pass_lead( raid_token, nuleader, nuleader_realm, nuleader_rid )
  oq.raid.leader        = nuleader ;
  oq.raid.leader_realm  = nuleader_realm ;
  oq.raid.leader_realid = nuleader_rid ;
end

function oq.on_party_update( raid_token )
  oq.raid.raid_token = raid_token ;
end

function oq.on_ping( token, ts )
  if (_to_name == _player_name) then
    _ok2relay = nil ;
  end
  if (not oq.iam_party_leader()) then
    return ;
  end
  oq.raid_ping_ack( token, ts ) ;
end

function oq.on_ping_ack( token, ts, g_id )
  local now = GetTime() * 1000 ;
  if (token ~= oq.my_tok) then
    return ;
  end
  local lag = floor((now - tonumber(ts))/2) ;
  g_id = tonumber(g_id) ;
  if (g_id ~= nil) and (g_id > 0) and (g_id <= 8) then
    local grp = oq.raid.group[ g_id ] ;
    local m = grp.member[1] ;
    grp._last_ping = utc_time() ;
    m.lag = lag ;
    oq.tab1_group[g_id].lag:SetText( string.format( "%5.2f", m.lag/1000 )) ;
    oq.timer( "push_lagtimes", 1, oq.send_lag_times ) ;
    return ;
  end
  
  -- update lag on group leaders
  for i,grp in pairs(oq.raid.group) do
    if ((grp.member[1].name) and (grp.member[1].name ~= "") and (grp.member[1].name ~= "-")) then
      local m = grp.member[1] ;
      local n = m.name ;
      if (m.realm ~= player_realm) then
        n = n .."-".. m.realm ;
      end
      if (m.name == oq._sender) then
        grp._last_ping = utc_time() ;
        m.lag = lag ;
        oq.tab1_group[i].lag:SetText( string.format( "%5.2f", m.lag/1000 )) ;
        oq.timer( "push_lagtimes", 1, oq.send_lag_times ) ;
        break ;
      end
    end
  end
end

function oq.premade_remove( lead_name, lead_realm, lead_rid, tm ) 
  local found = nil ;
  for i,v in pairs(oq.premades) do
--    if ((v.leader == lead_name) and (v.leader_realm == lead_realm) and (v.leader_rid == lead_rid)) then
    if (v.leader_rid == lead_rid) then
      if ((tm == nil) or (v.tm == nil) or (v.tm < tm)) then
        oq.remove_premade( v.raid_token ) ;
        found = true ;
      end
    end
  end
  return found ;
end

function oq.get_role_icon( n )
  if (n == "T") then
    -- OQ_TANK_ICON     
    return "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:0:64:64:0:19:22:41|t";
  elseif (n == "H") then
    -- OQ_HEALER_ICON   
    return "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:0:64:64:20:39:1:20|t";
  elseif (n == "D") then
    -- OQ_DAMAGE_ICON    
    return "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:0:64:64:20:39:22:41|t" ;
  end
  -- OQ_EMPTY_ICON 
  return "|TInterface\\TARGETINGFRAME\\UI-PhasingIcon.blp:16:16:0:0:64:64:0:64:0:64|t";
--  return "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:16:16:0:%d:64:64:0:0:0:0|t";
end

function oq.nMaxGroups()
  if (oq.raid.type == OQ.TYPE_RBG) then
    return 2 ;
  elseif (oq.raid.type == OQ.TYPE_ARENA) then
    return 1 ;
  elseif (oq.raid.type == OQ.TYPE_SCENARIO) then
    return 1 ;
  elseif (oq.raid.type == OQ.TYPE_DUNGEON) then
    return 1 ;
  elseif (oq.raid.type == OQ.TYPE_CHALLENGE) then
    return 1 ;
  elseif (oq.raid.type == OQ.TYPE_QUESTS) then
    return 1 ;
  elseif (oq.raid.type == OQ.TYPE_LADDER) then
    return 1 ;
  end
  return 8 ;
end

function oq.get_n_roles() 
  local ntanks = 0 ;
  local nheals = 0 ;
  local ndps   = 0 ;
  local ngroups = oq.nMaxGroups() ;

  for i=1,ngroups do
    if (oq.raid.group[i]) then
      for j=1,5 do
        if (oq.raid.group[i].member) then
          local m = oq.raid.group[i].member[j] ;
          if (m.name) and (m.name ~= "-") then
            if (OQ.ROLES[ m.role ] == "TANK") then
              ntanks = ntanks + 1 ;
            elseif (OQ.ROLES[ m.role ] == "HEALER") then
              nheals = nheals + 1 ;
            else
              ndps   = ndps + 1 ;
            end
          end
        end
      end
    end
  end
  return ntanks, nheals, ndps ;
end

function oq.get_karma_color(karma)
  local perc = 1.0 - abs(karma)/25.0 ;
  local r, g, b ;
  if (karma < 0) then
    r = 1.0 ;
    g = perc ;
    b = perc ;
  else
    r = perc ;
    g = 1.0 ;
    b = perc ;
  end
  return r, g, b ;
end

function oq.update_raid_listitem( raid_tok, raid_name, ilevel, resil, mmr, battlegrounds, tm_, status, has_pword, lead_name, pdata, type, karma_ )
  if (oq.tab2_raids == nil) then 
    return ;
  end
  
  if (_msg) then
    if (OQ_data._premade_info == nil) then
      OQ_data._premade_info = {} ;
    end
    OQ_data._premade_info[raid_tok] = tostring(utc_time()) ..".".. _msg ;
  end
  
  status = tonumber(status) ;
  for i,f in pairs( oq.tab2_raids ) do
    if (f.raid_token == raid_tok) then
      f.leader   :SetText( lead_name ) ;
      f.leader   :SetTextColor( oq.get_karma_color(karma_) ) ;

      f.raid_name:SetText( raid_name ) ;
      f.min_ilvl :SetText( ilevel ) ;
      if (type == OQ.TYPE_DUNGEON) or (type == OQ.TYPE_CHALLENGE) or (type == OQ.TYPE_QUESTS) then
        oq.moveto( f.min_resil, 360, 6 ) ; -- move down slightly 
        local s = "" ;
        for j=1,5 do
          local ch = pdata:sub(j,j) ;
          if (ch ~= "") and (ch ~= "-") then
            s = s .."".. oq.get_role_icon( ch ) ;
          else
            s = s .."".. oq.get_role_icon( "X" ) ; -- empty slot
          end
        end
        f.min_resil:SetText( s ) ;
        f.min_mmr  :SetText( "" ) ;
      elseif (type == OQ.TYPE_SCENARIO) then
        oq.moveto( f.min_resil, 360, 6 ) ; -- move down slightly 
        local s = "" ;
        for j=1,3 do
          local ch = pdata:sub(j,j) ;
          if (ch ~= "") and (ch ~= "-") then
            s = s .."".. oq.get_role_icon( ch ) ;
          else
            s = s .."".. oq.get_role_icon( "X" ) ; -- empty slot
          end
        end
        f.min_resil:SetText( s ) ;
        f.min_mmr  :SetText( "" ) ;
      elseif (type == OQ.TYPE_RAID) then
--        oq.moveto( f.min_resil, 360, 6 ) ; -- move down slightly 
        if (pdata:sub(1,3) == "---") then
          pdata = "AAA" ; -- equivalent to 000 in mime64
        end
        local ntanks = oq.decode_mime64_digits(pdata:sub(1,1)) ;
        local nheals = oq.decode_mime64_digits(pdata:sub(2,2)) ;
        local ndps   = oq.decode_mime64_digits(pdata:sub(3,3)) ;
        local s = string.format( "%01d", ntanks ) .."".. oq.get_role_icon( "T" ) ;
        s = s .." ".. string.format( "%01d", nheals ) .."".. oq.get_role_icon( "H" ) ;
        s = s .." ".. string.format( "%02d", ndps   ) .."".. oq.get_role_icon( "D" ) ;
        f.min_resil:SetText( s ) ;
        f.min_mmr  :SetText( "" ) ;
      else
        oq.moveto( f.min_resil, 360, 2 ) ; -- back to normal position
        f.min_resil:SetText( resil ) ;
        f.min_mmr  :SetText( mmr ) ;
      end
      f.zones  :SetText( battlegrounds ) ;
      -- update status 
      if (status == 2) or (raid_tok == oq.raid.raid_token) then
        -- inside, disable button
        f.req_but:Disable() ;
      else
        f.req_but:Enable() ;
        f.has_pword.texture:Show() ;
        if (has_pword) then
          f.has_pword.texture:SetTexture( OQ_KEY ) ;
        else
          f.has_pword.texture:SetTexture( nil ) ;
        end
      end
      
      local r = oq.premades[ raid_tok ] ;
      if (r ~= nil) then
        r.leader       = lead_name ;
        r.name         = raid_name ;
        r.min_ilevel   = ilevel ; 
        r.min_resil    = resil ;
        r.min_mmr      = mmr ;
        r.bgs          = battlegrounds ;
        r.tm           = tm_ ;
      end
      return ;
    end
  end
end

local npremades = 0 ;
function oq.on_premade( raid_tok, raid_name, premade_info, enc_data, bgs_, type_, pdata_, leader_xp_ )
  if (enc_data == nil) then
    return ;
  end
  if (type_ == nil) then
    type_ = OQ.TYPE_BG ; -- default type, regular battlegrounds
  end
  if (pdata_ == nil) or (pdata_:find( "#rlm" )) then
    pdata_ = "-----" ;
  end
  oq._raid_token = raid_tok ;
  local faction, has_pword, is_realm_specific, is_source, level_range, 
        min_ilevel, min_resil, nmembers, nwaiting, status, tm_, min_mmr, karma  = oq.decode_premade_info( premade_info ) ;
        
  local raid_tm_token = raid_tok ..".".. tm_ ;
  if (oq.token_was_seen( raid_tm_token ) or (faction ~= player_faction)) then
    _ok2relay = nil ;
    return ;
  end
  oq.token_push( raid_tm_token ) ;
  
  oq.process_premade_info( raid_tok, raid_name, faction, level_range, min_ilevel, min_resil, min_mmr,
                           enc_data, bgs_, nmembers, 
                           is_source, tm_, status, 
                           nwaiting, has_pword, is_realm_specific, type_, pdata_, leader_xp_, karma ) ;
                           
  -- group leaders opt out of forwarding premade info, except their own premade
  --  this is to lessen the number of bnet msgs being sent and prevent the queue from backing up
  if (my_slot == 1) and (oq._raid_token ~= oq.raid.raid_token) then
    _ok2relay = nil ;
  end
end
  
function oq.process_premade_info( raid_tok, raid_name, faction, level_range, ilevel, resil, mmr, enc_data, 
                                  bgs_, nMem, is_source, tm_, status, nWait, has_pword, 
                                  is_realm_specific, type_, pdata_, leader_xp_, karma_ )
  if (OQ_toon.disabled) then
    return ;
  end
  local  now = utc_time() ;
  local  wins = 0 ; 
  local battlegrounds = oq.decode_bg( bgs_ ) ;
  raid_name = oq.ltrim( oq.decode_name( raid_name ) ) ;
  -- decode data
  local lead_name, lead_realm, lead_rid = oq.decode_data( "abc123", enc_data ) ;

  if (oq.is_banned( lead_rid )) then
    -- do not record or relay premade info for banned people
    _ok2relay = nil ;
    return ;
  end
  if (raid_tok == oq.raid.raid_token) then
    if (type_ ~= oq.raid.type) then
      oq.set_premade_type( type_ ) ;
    end
    oq.update_my_premade_line() ;
  end
  if (oq.premades[ raid_tok ] ~= nil) then
    -- already seen
    local premade = oq.premades[ raid_tok ] ;
    if (tm_ < premade.tm) then
      -- drop old data
      _ok2relay = nil ;
      return ;
    end
    -- data is newer then what i have.. replace
    premade.leader        = lead_name ;
    premade.leader_realm  = lead_realm ;
    premade.leader_rid    = lead_rid ;
    premade.last_seen     = now ;
    premade.type          = type_ ; 
    premade.pdata         = pdata_ ;
    premade.leader_xp     = leader_xp_ ;
    premade.karma         = karma_ ;
    if (is_source == 0) then
      premade.next_advert = now + OQ_SEC_BETWEEN_ADS + random(1,10) ;
    end
    local is_update = (premade.name ~= raid_name) and (raid_name ~= nil) ;
    premade.has_pword         = has_pword ;
    premade.is_realm_specific = is_realm_specific ;
    oq.on_premade_stats( raid_tok, nMem, is_source, tm_, status, nWait, type_ ) ;
    oq.update_raid_listitem( raid_tok, raid_name, ilevel, resil, mmr, battlegrounds, tm_, status, has_pword, lead_name, pdata_, type_, karma_ ) ;
    if (is_update) then
      -- announce premade name change
      oq.announce_new_premade( raid_name, true, raid_tok ) ;
    end
    return ;
  end

  oq.premade_remove( lead_name, lead_realm, lead_rid, tm_ ) ;

  oq.premades[ raid_tok ] = { raid_token   = raid_tok, 
                              name         = raid_name, 
                              leader       = lead_name, 
                              leader_realm = lead_realm,
                              leader_rid   = lead_rid, 
                              level_range  = level_range, 
                              faction      = faction, 
                              min_ilevel   = ilevel, 
                              min_resil    = resil, 
                              min_mmr      = mmr,
                              bgs          = battlegrounds,
                              type         = type_,
                              pdata        = pdata_,
                              leader_xp    = leader_xp_,
                              karma        = karma_,
                              tm           = tm_,  -- owner's time
                              last_seen    = now,  -- my time
                              next_advert  = now + OQ_SEC_BETWEEN_ADS + random(1,10),
                              stats = { nMembers    = tonumber(nMem), 
                                        nWaiting    = tonumber(nWait),
                                      }
                            } ;
  
  oq.premades[ raid_tok ].has_pword         = has_pword ;
  oq.premades[ raid_tok ].is_realm_specific = is_realm_specific ;
  local ok2add = true ;
  if (abs(now - tm_) >= 10*60) then
    -- premade leader's time is off.  don't add
    ok2add = nil ;
  end
  
  if (ok2add) then  
    local x, y, cy ;
    cy = 25 ;
    x  = 20 ;
    y  =  npremades * (cy + 2) + 10 ; 
    npremades = npremades + 1 ;
    
    local f   = oq.create_raid_listing( oq.tab2_list, x, y, oq.tab2_list:GetWidth() - 2*x, cy, raid_tok, type_ ) ;
    f.leader   :SetText( lead_name ) ;
    f.levels   :SetText( level_range ) ;
    f.raid_token = raid_tok ;
    table.insert( oq.tab2_raids, f ) ;
    oq.reshuffle_premades() ;
    oq.on_premade_stats( raid_tok, nMem, is_source, tm_, status, nWait, type_ ) ;
    oq.update_raid_listitem( raid_tok, raid_name, ilevel, resil, mmr, battlegrounds, tm_, status, has_pword, lead_name, pdata_, type_, karma_ ) ;
    if (raid_tok == oq.raid.raid_token) then
      oq.update_my_premade_line() ;
    end
    oq.announce_new_premade( raid_name, nil, raid_tok ) ;
  end
end

function oq.on_premade_stats( raid_token, nMem, is_source, tm, status, nWait, type_ )
  _ok2relay = "bnet" ; -- should only bounce to bn-friends and oqgeneral, if raid-leader not on realm and msg never seen
  local raid = oq.premades[ raid_token ] ;
  if (raid == nil) then
    -- never seen, nothing to do
    return ;
  end
  local s = raid.stats ;
  local wins = 0 ;
  tm = tonumber(tm) ;
  if ((raid.tm == nil) or (raid.tm <= tm)) then
    s.nMembers     = tonumber(nMem) ;
    s.status       = tonumber(status) ;
    s.nWaiting     = tonumber(nWait) ;
    if (is_source) then
      raid.tm = tm ; -- so only the latest data is kept
    end
    -- update status 
    local line = oq.find_premade_entry( raid_token ) ;
    if (line ~= nil) then
      if (s.status == 2) or (raid_token == oq.raid.raid_token) then
        -- if inside, disable the waitlist button
        line.req_but:Disable() ;
      else
        line.req_but:Enable() ;
      end
      oq.set_dragon( line, type_ ) ;
    end  
  end
end

function oq.set_dragon( line, type )
  local leader_xp = oq.premades[ line.raid_token ].leader_xp ;
  if (leader_xp == nil) then
    return ;
  end  
  
  local tag, y, cx, cy, title = oq.get_dragon_rank( type, nil, leader_xp ) ;  
  local x  = 169 ;
  
  line.dragon.texture:SetTexture( tag ) ;
  oq.setpos( line.dragon, x, y, cx, cy ) ;
end

function oq.on_invite_req_response( raid_token, req_token, answer, reason )
  if (not oq.token_was_seen( req_token )) then
    -- multi-boxer can receive same msg if via real-id msg
    _ok2decline = nil ;
    return ;
  end
  if (answer == "N") then
    PlaySound( "RaidWarning" ) ;
    message( string.format( OQ.MSG_REJECT, reason )) ;
  elseif (answer == "Y") then
    PlaySound( "AuctionWindowOpen" ) ;
    local f = oq.find_premade_entry( raid_token ) ;
    if (f ~= nil) then
      f.req_but:SetText( OQ.BUT_PENDING ) ;
      f.req_but:SetBackdropColor( 0.5, 0.5, 0.5, 1 ) ;
      f.pending = true ;
    end
  end
end

function oq.send_invite_response( name, realm, realid, raid_token, req_token, answer, reason )
  if (realid == nil) or (realid == "") then
    return ;
  end
  oq.timer_oneshot( 2, oq.realid_msg, name, realm, realid, 
                    OQ_MSGHEADER .."".. 
                    OQ_VER ..","..
                    "W1,"..
                    "0,"..
                    "invite_req_response,"..                 
                    raid_token ..","..
                    req_token ..","..
                    answer ..","..
                    (reason or ".")
                  ) ;
end

function oq.on_report_recvd( report, token )
  if (token == nil) or (report == nil) or (OQ_toon.reports == nil) then
    return ;
  end
  local r = OQ_toon.reports[token] ;
  if (r == nil) then
    -- why am i getting this response?
    return ;
  end
  
  r.report_recvd = true ;
  if (r.report_recvd and r.top_dps_recvd and r.top_heals_recvd) then
    OQ_toon.reports[token] = nil ;
  end
end

function oq.on_top_dps_recvd( token )
  if (token == nil) or (OQ_toon.reports == nil) then
    return ;
  end
  local r = OQ_toon.reports[token] ;
  if (r == nil) then
    -- why am i getting this response?
    return ;
  end
  
  r.top_dps_recvd = true ;
  if (r.report_recvd and r.top_dps_recvd and r.top_heals_recvd) then
    OQ_toon.reports[token] = nil ;
  end
end

function oq.on_top_heals_recvd( token )
  if (token == nil) or (OQ_toon.reports == nil) then
    return ;
  end
  local r = OQ_toon.reports[token] ;
  if (r == nil) then
    -- why am i getting this response?
    return ;
  end
  
  r.top_heals_recvd = true ;
  if (r.report_recvd and r.top_dps_recvd and r.top_heals_recvd) then
    OQ_toon.reports[token] = nil ;
  end
end

function oq.is_banned( rid, only_local )
  if (rid == nil) or (rid == "") or (rid == "nil") then
    return nil ;
  end
  if (OQ_data.banned == nil) then
    OQ_data.banned = {} ;
  end
  if (OQ_data.banned[rid] ~= nil) then
    return true ;
  end
  if (only_local == nil) and (OQ.gbl[strlower(rid)] ~= nil) then
    return true ;
  end
  return nil ;
end

function oq.ban_add( rid, reason_ )
  if (rid == nil) or (rid == "") or (rid == player_realid) then
    print( OQ_REDX_ICON .." invalid battle-tag (".. tostring(rid) ..")" ) ;
    return ;
  end
  if (OQ_data.banned == nil) then
    OQ_data.banned = {} ;
  end
  OQ_data.banned[ rid ] = { ts = utc_time(), reason = reason_ } ;  
  
  -- now add to the list
  local f = oq.create_ban_listitem( oq.tab6_list, 1, 1, 200, 22, rid, reason_, OQ_data.banned[ rid ].ts ) ;
  table.insert( oq.tab6_banlist, f ) ;
  oq.reshuffle_banlist() ;  
end

function oq.ban_remove( rid )
  if (rid == nil) or (rid == "") then
    print( OQ_REDX_ICON .." invalid battle-tag (".. tostring(rid) ..")" ) ;
    return ;
  end
  if (OQ_data.banned == nil) then
    OQ_data.banned = {} ;
  end
  OQ_data.banned[ rid ] = nil ;
end

function oq.ban_clearall()
  OQ_data.banned = {} ;
end

-- function oq.is_qualified( level_, faction, resil_, ilevel_, role_, mmr_ )
function oq.is_qualified( m )
  local level_min, level_max = oq.get_player_level_range() ;
  if (m.level < level_min) or (m.level > level_max) then
    return (oq.raid.enforce_levels == 0) ;
  end
  if (m.ilevel == nil) then
    return nil ;
  end
  if (oq.raid.min_ilevel ~= 0) and (oq.raid.min_ilevel > m.ilevel) then
    return nil ;
  end
  if (oq.is_dungeon_premade() or (oq.raid.type == OQ.TYPE_RAID)) then
    return true ;
  end
  if (oq.raid.min_resil ~= 0) and (oq.raid.min_resil > m.resil) then
    return nil ;
  end
  if (oq.raid.min_mmr ~= 0) then
    if (oq.raid.min_mmr > m.mmr) then
      return nil ;
    end
--[[
    if (oq.raid.type == OQ.TYPE_ARENA) then
      if (m.arena2s < oq.raid.min_mmr) and (m.arena3s < oq.raid.min_mmr) and (m.arena5s < oq.raid.min_mmr) then
        return nil ;
      end
    elseif (oq.raid.min_mmr > m.mmr) then
      return nil ;
    end
]]--
  end
  return true ;
end

function oq.on_req_invite( raid_token, raid_type, n_members_, req_token, enc_data, stats, pword )
  if (not oq.iam_raid_leader()) then
    return ;
  end
  -- not my raid
  --
  if (raid_token ~= oq.raid.raid_token) then
    return ;
  end
  local  name_, realm_, realid_ = oq.decode_data( "abc123", enc_data ) ;
  pword      = oq.decode_pword( pword ) ;
  n_members_ = tonumber( n_members_ ) ;
  
  local m = tbl.new() ;
  local demos = oq.decode_their_stats( m, stats ) ;
  local flags_ = 0 ;
  local hp_ = 0 ;
  m.spec_id = select( 3, oq.get_class_spec_type( m.spec_id )) ;

  if (oq.n_waiting() > OQ_MAX_WAITLIST) then  
    oq.send_invite_response( name_, realm_, realid_, raid_token, req_token, "N", "wait list full" ) ;
    tbl.delete( m ) ;
    return ;
  elseif (not m.class) then
    oq.send_invite_response( name_, realm_, realid_, raid_token, req_token, "N", "invalid class" ) ;
    tbl.delete( m ) ;
    return ;
  elseif (oq.is_banned( realid_ )) then
    oq.send_invite_response( name_, realm_, realid_, raid_token, req_token, "N", "banned" ) ;
    tbl.delete( m ) ;
    return ;
  elseif (n_members_ == 1) and (not oq.is_qualified( m )) then
    oq.send_invite_response( name_, realm_, realid_, raid_token, req_token, "N", "not qualified" ) ;
    tbl.delete( m ) ;
    return ;
  elseif (oq.raid.has_pword and (oq.raid.pword ~= pword)) then
    oq.send_invite_response( name_, realm_, realid_, raid_token, req_token, "N", "invalid password" ) ;
    tbl.delete( m ) ;
    return ;
  end

  if (oq.waitlist == nil) then
    oq.waitlist = tbl.new() ;
  end

  -- check to see if the toon is already queue'd
  if (not oq.ok_for_waitlist( name_, realm_ )) then
    tbl.delete( m ) ;
    return ;
  end

  oq.waitlist[ req_token ] = m ;
  oq.waitlist[ req_token ].name      = name_ ;
  oq.waitlist[ req_token ].realm     = realm_ ;
  oq.waitlist[ req_token ].realid    = realid_ ;
  oq.waitlist[ req_token ].n_members = n_members_ ;
  oq.waitlist[ req_token ].bgroup    = oq.find_bgroup( realm_ ) ;
  oq.waitlist[ req_token ].create_tm = utc_time() ;
  
  local x, y, cy ;
  x  = 2 ;
  cy = 25 ;
  y  = oq.nwaitlist * (cy + 2) + 10 ;
  oq.nwaitlist = oq.nwaitlist + 1 ;
  
  local f = oq.insert_waitlist_item( x, y, req_token, n_members_, name_, realm_, oq.waitlist[ req_token ] ) ;
  table.insert( oq.tab7_waitlist, f ) ;
  oq.reshuffle_waitlist() ;
  oq.send_invite_response( name_, realm_, realid_, raid_token, req_token, "Y" ) ;  
  -- play sound to alert raid leader
  PlaySound( "AuctionWindowOpen" ) ;
end

function oq.get_spec_icon_text( spec_id )
  if (spec_id == nil) or (spec_id == 0) then
    return "" ;
  end
  local id, name, description, icon, background, role, class = GetSpecializationInfoByID( spec_id ) ;
  if (icon ~= nil) then
    return "|T".. icon ..":20:20:0:0|t" ;
  else
    return "--" ;
  end
end

function oq.insert_waitlist_item( x, y, req_token, n_members_, name_, realm_, m ) 
  local f = oq.create_waitlist_item( oq.tab7_list, x, y, oq.tab7_list:GetWidth() - 2*x, 25, req_token, n_members_ ) ;
  f.bgroup.texture:SetTexture( OQ.BGROUP_ICON[oq.find_bgroup(realm_)] ) ;
  if (m.role == 2) then
    local s = "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:20:20:0:%d:64:64:20:39:1:20|t";
    f.role:SetText( s ) ;
  elseif (m.role == 4) then
    local s = "|TInterface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES.blp:20:20:0:%d:64:64:0:19:22:41|t";
    f.role:SetText( s ) ;
  else
    -- set icon for spec
    f.role:SetText( oq.get_spec_icon_text( m.spec_id )) ;
  end
--  f.create_tm = utc_time() ;
  f.m = m ; -- hopefully a ptr to the table
  f.toon_name :SetText( name_ ) ;
  f.realm     :SetText( realm_ ) ;
  f.level     :SetText( m.level ) ;
  f.ilevel    :SetText( m.ilevel ) ;
  
  if (oq.is_dungeon_premade() or (oq.raid.type == OQ.TYPE_RAID)) then
    f.resil     :SetText( m.haste ) ;
    f.pvppower  :SetText( m.mastery ) ;
    f.mmr       :SetText( m.hit ) ;
  else
    f.resil     :SetText( m.resil ) ;
    f.pvppower  :SetText( m.pvppower ) ;
    f.mmr       :SetText( m.mmr ) ;
  end
  
  f.toon_name :SetTextColor( OQ.CLASS_COLORS[m.class].r, OQ.CLASS_COLORS[m.class].g, OQ.CLASS_COLORS[m.class].b, 1 ) ;
-- 
-- set texture for role (might not work as ppl can't set role without a party/raid)
--
  f.req_token = req_token ;
  return f ;
end

function oq.update_wait_times()
  local now = utc_time() ;
  for i,v in pairs(oq.tab7_waitlist) do
    if (v.m.create_tm) then
      v.wait_tm:SetText( date("!%H:%M:%S", (now - v.m.create_tm) )) ;
    end
  end
end

function oq.on_req_mesh( token )
  if (OQ_data.autoaccept_mesh_request ~= 1) or (token == nil) then
    return ;
  end
  local ntotal, nonline = BNGetNumFriends() ;
  if (ntotal >= OQ_MAX_BNFRIENDS) then
    return ;
  end
  if (_source ~= "oqgeneral") or (oq._sender == nil) then
    -- only works locally
    return ;
  end
  if (oq.is_toon_friended( oq._sender, player_realm )) then
    return ;
  end
  _ok2relay = nil ; -- this should be a realm only msg
  local msg = OQ_HEADER ..",".. 
              OQ_VER ..","..
              "W1,0,imesh,".. tostring(token) ..",".. tostring(player_realid) ;
              
  oq.SendAddonMessage( "OQ", msg, "WHISPER", oq._sender ) ;
end

function oq.on_imesh( token, btag )
  _ok2relay = nil ; -- this should be a targeted msg
  if (not oq.token_was_seen( token )) then
    -- not my token, bogus msg
    return ;
  end
  if (player_realid == btag) then
    -- my tag, disregard
    return ;
  end
  local ntotal, nonline = BNGetNumFriends() ;
  if (ntotal >= OQ_MAX_BNFRIENDS) then
    return ;
  end

  local pid, is_online = oq.is_bnfriend( btag ) ;
  if (pid ~= nil) then
    -- already friended
    return ;
  end
  
  if (not oq.is_banned( btag )) then
    local msg = OQ_HEADER ..",".. 
                OQ_VER ..","..
                "W1,0,mesh_tag,0" ;
    oq.BNSendFriendInvite( btag, msg, "OQ,mesh node" ) ;
  end
end

function oq.ok_for_waitlist( name, realm )
  -- check to see if the toon is already queue'd
  for i,v in pairs(oq.waitlist) do
    if ((name == v.name) and (realm == v.realm)) then
      return nil ;
    end
  end
  -- or already in the group
  
  for i=1,8 do
    for j=1,5 do
      local mem = oq.raid.group[i].member[j] ;
      if (mem.name == name) and (mem.realm == realm) and (mem.class ~= "XX") then
        return nil ;
      end
    end
  end
  return true ;
end

function oq.start_role_check()
  oq.boss_announce( "role_check" ) ;
  InitiateRolePoll() ;
end

function oq.start_ready_check()
  oq.raid_announce( "ready_check" ) ;
  oq.on_ready_check() ;
end

function oq.brb()
  if (oq.raid.raid_token == nil) or (my_group == 0) or (my_slot == 0) then
    return ;
  end
  oq.raid_announce( "brb,".. oq.raid.raid_token ..",".. my_group ..",".. my_slot ) ;
  player_away = true ;
  oq.on_brb( oq.raid.raid_token, my_group, my_slot ) ;
  
  oq.brb_dlg() ;
  if ((oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID)) then
    SendChatMessage( "brb", "RAID", nil ) ;  
  else
    SendChatMessage( "brb", "PARTY", nil ) ;  
  end
end

function oq.iam_back()
  player_away = nil ;
  oq.raid_announce( "iam_back,".. oq.raid.raid_token ..",".. my_group ..",".. my_slot ) ;
  oq.on_iam_back( oq.raid.raid_token, my_group, my_slot ) ;
  if ((oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID)) then
    SendChatMessage( "back", "RAID", nil ) ;  
  else
    SendChatMessage( "back", "PARTY", nil ) ;  
  end
end

function oq.on_brb( raid_token, g_id, slot )
  if (raid_token ~= oq.raid.raid_token) then
    return ;
  end
  g_id = tonumber( g_id ) ;
  slot = tonumber( slot ) ;

  if (g_id <= 0) or (slot <= 0) then
    return ;
  end
  local m = oq.raid.group[g_id].member[slot] ;
  m.flags = oq.bset( m.flags, OQ.FLAG_BRB, true ) ;
  oq.set_textures( g_id, slot ) ;
end

function oq.on_iam_back( raid_token, g_id, slot )
  if (raid_token ~= oq.raid.raid_token) then
    return ;
  end
  g_id = tonumber( g_id ) ;
  slot = tonumber( slot ) ;

  if (g_id <= 0) or (slot <= 0) then
    return ;
  end
  local m = oq.raid.group[g_id].member[slot] ;
  m.flags = oq.bset( m.flags, OQ.FLAG_BRB, nil ) ;
  oq.set_textures( g_id, slot ) ;
end

function oq.ready_check_complete()
  oq.on_ready_check_complete() ;
end

function oq.on_ready_check()
  local ngroups = oq.nMaxGroups() ;
  for grp=1,ngroups do
    for s=1,5 do
      oq.raid.group[grp].member[s].check = OQ.FLAG_WAITING ;
      oq.set_textures( grp, s ) ;
    end
  end

  if (my_group > 0) and (my_slot > 0) and (oq.iam_raid_leader()) then
    oq.ready_check( my_group, my_slot, OQ.FLAG_READY ) ;
    oq.timer( "rdycheck_end", 30, oq.ready_check_complete ) ;
    return ;
  end
  local dialog = StaticPopup_Show("OQ_ReadyCheck", nil, nil, ndx ) ;
  last_group_brief = 0 ; -- force the update for ready-check status
  oq.timer( "rdycheck_end", 20, oq.ready_check_complete ) ;
end

function oq.on_role_check()
  if (not oq.iam_party_leader()) then
    return ;
  end
  InitiateRolePoll() ;
end

function oq.nMembers() 
  if (oq.raid.type ~= OQ.TYPE_BG) then
    return max( 1, GetNumGroupMembers() ) ;
  end
  local i, j, nMembers ;
  nMembers = 0 ;
  for i=1,8 do
    for j=1,5 do
      if (oq.raid.group[i]) and (oq.raid.group[i].member) then
        local m = oq.raid.group[i].member[j] ;
        if (m) and ((m.name) and (m.name ~= "-")) then
          nMembers = nMembers + 1 ;
        end
      end
    end
  end
  return nMembers ;
end

function oq.strrep(value, insert, place)
  if (value == nil) then
    return insert ;
  end
  if place == nil or (place > #value) then
    place = string.len(value)+1
  elseif (place <= 0) then
    place = 1 ;
  end
  return string.sub( value, 1, place-1) .. insert .. string.sub( value, place+1, -1 ) ;
end

function oq.calc_raid_stats()
  local nMembers = oq.nMembers() ;
  local resil    = 0 ;
  local ilevel   = 0 ;
  local nWaiting = oq.n_waiting() ;
  
  for i=1,8 do
    if (oq.raid.group[i]) then
      for j=1,5 do
        if (oq.raid.group[i].member) then
          local mem = oq.raid.group[i].member[j] ;
          if (mem) and (mem.name) and (mem.name ~= "-") then
            if ((mem.ilevel == 0) and (mem.name == player_name)) then
              mem.ilevel = player_ilevel ;
              mem.resil  = player_resil ;
            end
            resil    = resil  + (mem.resil  or 0) ;
            ilevel   = ilevel + (mem.ilevel or 0) ;
          end
        end
      end
    end
  end
  if (nMembers == 0) then
    return 0, 0, 0, 0 ;
  end
  return  nMembers, floor(resil / nMembers), floor(ilevel / nMembers), nWaiting ;
end

function oq.update_tab1_stats()
  local nMembers, avg_resil, avg_ilevel = oq.calc_raid_stats() ;

  if (nMembers == 0) then
    oq.tab1_raid_stats:SetText( "0 / - / -" ) ;
  else
    oq.tab1_raid_stats:SetText( nMembers .." / ".. avg_resil .." / ".. avg_ilevel ) ;
  end
end

function oq.update_tab3_info()
  if ((oq.raid.raid_token == nil) or (not oq.iam_raid_leader())) then
    return ;
  end
  oq.tab3_raid_name :SetText( oq.raid.name ) ;
  oq.tab3_lead_name :SetText( player_name ) ;
  oq.tab3_rid       :SetText( player_realid or "" ) ;
  oq.tab3_min_ilevel:SetText( oq.raid.min_ilevel or 0 ) ;
  oq.tab3_min_resil :SetText( oq.raid.min_resil or 0 ) ;
  oq.tab3_min_mmr   :SetText( oq.raid.min_mmr or 0 ) ;
  oq.tab3_bgs       :SetText( oq.raid.bgs or "" ) ;
  oq.tab3_notes     :SetText( oq.raid.notes or "" ) ;
  oq.tab3_pword     :SetText( oq.raid.pword or "" ) ;
  
  oq.tab3_set_radiobutton( oq.raid.type ) ;
end

function oq.bset( flags, mask, set )
  flags = bit.bor( flags, mask ) ;
  if ((set == nil) or (set == 0) or (set == false)) then
    flags = bit.bxor( flags, mask ) ;
  end
  return flags ;
end

function oq.is_set( flags, mask )
  if (flags) and (mask) and (bit.band( flags, mask ) ~= 0) then
    return true ;
  end
  return nil ;
end

function oq.refresh_textures() 
  local ngroups = oq.nMaxGroups() ;
  for i=1,ngroups do
    for j=1,5 do
      oq.set_textures( i, j ) ;
    end
  end
end

function oq.set_textures( g_id, slot )
  if (oq.raid.type == nil) then
    return ;
  end
  g_id = tonumber( g_id ) ;
  slot = tonumber( slot ) ;
  if (g_id == nil) or (slot == nil) then
    return ;
  end
  local m     = oq.raid.group[g_id].member[slot] ;
  if (m == nil) then
    return ;
  end
  if (oq.raid.type == OQ.TYPE_BG) then
    oq.set_textures_cell( m, oq.tab1_group[g_id].slots[slot] ) ; -- bgs
  end
  if (oq.raid.type == OQ.TYPE_RAID) then
    oq.set_textures_cell( m, oq.raid_group[g_id].slots[slot] ) ; -- raid
  end
  if (oq.raid.type == OQ.TYPE_RBG) and ((g_id == 1) or (g_id == 2)) and ((slot >= 1) and (slot <= 5)) then
    oq.set_textures_cell( m, oq.rbgs_group[g_id].slots[slot] ) ; -- rbgs
  end
  if (oq.raid.type == OQ.TYPE_ARENA) then
    oq.set_textures_cell( m, oq.arena_group.slots[slot]   ) ; -- scenario
  end
  if (oq.raid.type == OQ.TYPE_DUNGEON) then
    oq.set_textures_cell( m, oq.dungeon_group.slots[slot] ) ; -- dungeon
  end
  if (oq.raid.type == OQ.TYPE_CHALLENGE) then
    oq.set_textures_cell( m, oq.challenge_group.slots[slot] ) ; -- challenge
  end
  if (oq.raid.type == OQ.TYPE_QUESTS) then
    oq.set_textures_cell( m, oq.challenge_group.slots[slot] ) ; -- challenge
  end
  if (oq.raid.type == OQ.TYPE_LADDER) then
    oq.set_textures_cell( m, oq.ladder_group.slots[slot] ) ; -- ladder
  end
  if (oq.raid.type == OQ.TYPE_SCENARIO) then
    oq.set_textures_cell( m, oq.scenario_group.slots[slot]   ) ; -- scenario
  end
end

function oq.get_model_standin( gender, race )
  -- Character\\NightElf\\Female\\NightElfFemale.m2
  --
  local fname = "Character" ;
  local base = "" ;
  for i,v in pairs(OQ.RACE) do
    if (v == race) then
      base = i ;
      fname = fname .."\\".. base ;
      break ;
    end
  end
  if (gender == 0) then
    fname = fname .."\\Male" ;
    base = base .."Male" ;
  else
    fname = fname .."\\Female" ;
    base = base .."Female" ;
  end
  return fname .."\\".. base ..".m2" ;  
end

function oq.is_dungeon_premade( m )
  if (m == nil) then
    return (oq.raid.type == OQ.TYPE_DUNGEON) or (oq.raid.type == OQ.TYPE_SCENARIO) or 
           (oq.raid.type == OQ.TYPE_CHALLENGE) or (oq.raid.type == OQ.TYPE_QUESTS) ;
  else
    return (m.premade_type == OQ.TYPE_DUNGEON) or (m.premade_type == OQ.TYPE_SCENARIO) or 
           (m.premade_type == OQ.TYPE_CHALLENGE) or (m.premade_type == OQ.TYPE_QUESTS) ;
  end
end

function oq.camera_profile_mode( f )
--[[
  f:SetCamera(1) ; 
  f:SetCustomCamera(1) ;
  if (not f:HasCustomCamera()) then
    f:Show() ;
    return ;
  end
  f:SetModelScale(0.5) ;
  f:SetCameraDistance(0.25)
  f:SetCameraFacing(-0.71290230751038) 
   
  f.z = 0.69999998807907 ; -- closer / further
  f.y = 0.20000000298023 ; -- vertical
  f.x = 0.20000000298023 ;
  f:SetPosition( f.z, f.x, f.y ) ;
   
  f.cam_z =  0.856227159500120 ;
  f.cam_y = -0.099748730659485 ;
  f.cam_x =  0.637427389621730 ;
  f:SetCameraPosition( f.cam_z, f.cam_y, f.cam_x ) ;
]]--
  f:SetCamera(0) ;
--  f:SetCameraDistance(25) ; -- must be a custom view to be used
  f:Show() ;
end

function oq.model_slot_empty( panel ) 
  if (panel.model_frame ~= nil) and (panel.model_frame:IsVisible()) and (panel.model ~= nil) and (panel._model ~= nil) then
    panel._model = nil ;
    panel.model:ClearModel() ;
  end
  panel.model:Hide() ;
  panel.standin:Hide() ;
  if ((oq.raid.type == OQ.TYPE_BG) or (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID)) then
    panel.model_frame:Hide() ;
  else
    panel.model_frame:Show() ;
  end
end

function oq.model_slot_create( panel )
  oq.nmodels = (oq.nmodels or 0) + 1 ;
  panel.model_frame = oq.CreateFrame("Button", "OQModelFrame".. oq.nmodels, panel ) ;
  panel.model_frame:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                                 edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                                 tile=true, tileSize = 16, edgeSize = 16,
                                 insets = { left = 1, right = 1, top = 1, bottom = 1 }
                                })
  panel.model_frame:SetBackdropColor(0.0,0.0,0.0,1.0);
  panel.model_frame:SetAlpha( 0.8 ) ;
  panel.model_frame:Show() ;
  oq.setpos( panel.model_frame, 0,  0, panel:GetWidth(),  panel:GetHeight()-17 ) ;
  if (panel.model == nil) then
    panel.model = oq.CreateFrame("DressUpModel", "OQModel".. oq.nmodels, panel.model_frame ) ;
    panel.model:SetPoint( "TOPLEFT"    , panel.model_frame, "TOPLEFT"    ,  5, -5 ) ;
    panel.model:SetPoint( "BOTTOMRIGHT", panel.model_frame, "BOTTOMRIGHT", -5,  5 ) ;
    panel.model:Hide() ;
      
    panel.standin = oq.CreateFrame("Model", "OQModelStandin".. oq.nmodels, panel.model_frame ) ;
    panel.standin:SetPoint( "TOPLEFT"    , panel.model_frame, "TOPLEFT"    ,  5, -5 ) ;
    panel.standin:SetPoint( "BOTTOMRIGHT", panel.model_frame, "BOTTOMRIGHT", -5,  5 ) ;
    panel.standin:Hide() ;
  end
end

function oq.adjust_camera( panel, name, gender, race )
  if (not panel:IsVisible()) then
    return ;
  end
  
  if (panel._model ~= nil) and (panel._model ~= name) then
    panel.model:ClearModel() ;
    panel._model = nil ;
  end
  if (name == nil) or (name == "") then
    panel.model:Hide() ;
    panel.standin:Hide() ;
    panel.model_frame:Show() ;
    return ;
  end
  local fname = panel.model:GetModel() ;
  if (name) and (UnitIsVisible(name)) and (name ~= panel._model) and (fname == "") then
    panel.model:Show() ;
    panel.model:SetUnit( name ) ;
    panel.model:RefreshUnit() ; 
    panel.model:Dress() ; 
    panel._model = name ;
    oq.camera_profile_mode( panel.model ) ;
    panel.standin:Hide() ;
  end
  fname = panel.model:GetModel() ;

  if (fname == "") or (not UnitIsVisible(name)) then
    panel._model = nil ;
    fname = oq.get_model_standin( gender, race ) ;
    if (fname ~= panel.standin._model) then
      panel.standin:ClearModel() ;
      panel.standin:Show() ;
      panel.standin:SetModel( fname ) ;
      panel.standin:SetAlpha(0.95) ;    
      panel.standin:SetPoint( "TOPLEFT"    , panel.model_frame, "TOPLEFT"    ,  5, -5 ) ;
      panel.standin:SetPoint( "BOTTOMRIGHT", panel.model_frame, "BOTTOMRIGHT", -5,  5 ) ;
      panel.standin._model = fname ;
    end
    oq.camera_profile_mode( panel.standin ) ;
    panel.model:Hide() ;
  else
    oq.camera_profile_mode( panel.model ) ;
  end
  panel.model_frame:Show() ;
end

function oq.set_player_model( panel, name, gender, race )
  if (panel.model_frame == nil) then
    oq.model_slot_create( panel ) ;
  end
  
  if ((name == nil) and (gender == nil) and (race == nil)) or (not oq.is_dungeon_premade() and (oq.raid.type ~= OQ.TYPE_ARENA))  then
    oq.model_slot_empty( panel ) ;
    return ;
  end
  
  oq.adjust_camera( panel, name, gender, race ) ;
end

function oq.set_textures_cell( m, cell )
  if (m == nil) or (cell == nil) or (cell.texture == nil) then
    if (cell ~= nil) and (cell.texture ~= nil) and ((oq.raid.type == OQ.TYPE_DUNGEON) or 
       (oq.raid.type == OQ.TYPE_SCENARIO) or (oq.raid.type == OQ.TYPE_ARENA) or (oq.raid.type == OQ.TYPE_CHALLENGE) or 
       (oq.raid.type == OQ.TYPE_QUESTS)) then
      cell.texture:SetPoint("TOPLEFT"    , cell.model_frame,"TOPLEFT"    ,  2, -3) ;
      cell.texture:SetPoint("BOTTOMRIGHT", cell.model_frame,"BOTTOMRIGHT", -2,  3) ;
    end
    return ;
  end
  local color = OQ.CLASS_COLORS["XX"] ;

  -- set color of cell
  if ((m.class ~= nil) and oq.is_set( m.flags, OQ.FLAG_ONLINE ) and (OQ.CLASS_COLORS[m.class] ~= nil)) then
    color = OQ.CLASS_COLORS[m.class] ;
  end
  if (color ~= nil) then
    cell.texture:SetTexture( color.r, color.g, color.b, 1 ) ;
  else
    -- should not get here
  end

  if ((m.name == nil) or (m.name == "") or (m.name == "-")) then
    -- unused slot
    cell.status:SetTexture( nil ) ;
    cell.class :SetTexture( nil ) ;
    cell.role  :SetTexture( nil ) ;
    cell.charm :SetTexture( nil ) ;
    oq.set_player_model( cell, nil, nil, nil ) ;
    if (cell.texture ~= nil) and (oq.is_dungeon_premade() or (oq.raid.type == OQ.TYPE_ARENA)) then
      cell.texture:SetPoint("TOPLEFT", cell.model_frame,"TOPLEFT", 2, -3) ;
      cell.texture:SetPoint("BOTTOMRIGHT", cell.model_frame,"BOTTOMRIGHT", -2, 3) ;
    end
    return ;
  end
  -- set overlap state
  if (m.check == nil) then
    m.check = OQ.FLAG_CLEAR ;
  end
  if (m.check == OQ.FLAG_WAITING) then
    cell.status:SetTexCoord( 0, 1.0, 0.0, 1.0 ) ; 
    cell.status:SetTexture( "Interface\\RAIDFRAME\\ReadyCheck-Waiting" ) ;
  elseif (m.check == OQ.FLAG_READY) then
    cell.status:SetTexCoord( 0, 1.0, 0.0, 1.0 ) ; 
    cell.status:SetTexture( "Interface\\RAIDFRAME\\ReadyCheck-Ready" ) ;
  elseif (m.check == OQ.FLAG_NOTREADY) then
    cell.status:SetTexCoord( 0, 1.0, 0.0, 1.0 ) ; 
    cell.status:SetTexture( "Interface\\RAIDFRAME\\ReadyCheck-NotReady" ) ;
  elseif (not oq.is_set( m.flags, OQ.FLAG_ONLINE )) then
    cell.status:SetTexCoord( 0, 1.0, 0.0, 1.0 ) ; 
    cell.status:SetTexture( "Interface\\CHARACTERFRAME\\Disconnect-Icon" ) ; -- "Interface\\GuildFrame\\GuildLogo-NoLogoSm" ) ;
  elseif (oq.is_set( m.flags, OQ.FLAG_BRB )) then
    cell.status:SetTexCoord( 0, 0.50, 0.0, 0.50 ) ; 
    cell.status:SetTexture( "Interface\\CHARACTERFRAME\\UI-StateIcon" ) ; -- Interface\\RAIDFRAME\\ReadyCheck-Waiting" ) ;
  elseif (oq.is_set( m.flags, OQ.FLAG_DESERTER )) then
    cell.status:SetTexCoord( 0, 1.0, 0.0, 1.0 ) ; 
    cell.status:SetTexture( "Interface\\Icons\\Ability_Druid_Cower" ) ;
  elseif (oq.is_set( m.flags, OQ.FLAG_QUEUED )) then
    cell.status:SetTexCoord( 0, 1.0, 0.0, 1.0 ) ; 
    if (player_faction == "A") then
      cell.status:SetTexture( "Interface\\BattlefieldFrame\\Battleground-Alliance" ) ;
    else
      cell.status:SetTexture( "Interface\\BattlefieldFrame\\Battleground-Horde" ) ;
    end
  else
    cell.status:SetTexture( nil ) ;
  end

  -- set role
  if (oq.is_set( m.flags, OQ.FLAG_TANK )) then
    cell.role:SetTexture( "Interface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES" ) ;
    cell.role:SetTexCoord( 0, 19/64, 22/64, 41/64 ) ;
  elseif (oq.is_set( m.flags, OQ.FLAG_HEALER )) then
    cell.role:SetTexture( "Interface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES" ) ;
    cell.role:SetTexCoord( 20/64, 39/64, 1/64, 20/64 ) ;
  elseif oq.is_dungeon_premade() then
    cell.role:SetTexture( "Interface\\LFGFRAME\\UI-LFG-ICON-PORTRAITROLES" ) ;
    cell.role:SetTexCoord( 20/64, 39/64, 22/64, 41/64 ) ;
  else
    cell.role:SetTexture( nil ) ; 
  end
  
  -- set model (dungeons & scenarios)
  if (m.realm_id == nil) then
    m.realm_id = 0 ;
  end
  m.realm_id = tonumber(m.realm_id) ;

  if (cell.class ~= nil) and (m.realm_id > 0) and (oq.is_dungeon_premade() or (oq.raid.type == OQ.TYPE_ARENA)) then
    local name = m.name ;
    if (m.realm_id ~= player_realm_id) then
      name = name .."-".. oq.realm_uncooked(m.realm_id) ;
    end
    if (name ~= nil) then
      oq.set_player_model( cell, name, m.gender, m.race ) ;
    end
    if (cell.texture ~= nil) then
      cell.texture:SetPoint("TOPLEFT", cell.model_frame,"TOPLEFT", 2, -3) ;
      cell.texture:SetPoint("BOTTOMRIGHT", cell.model_frame,"BOTTOMRIGHT", -2, 3) ;
    end
  end

  -- set lucky charm
  if (cell.charm ~= nil) then
    cell.charm:SetTexture( "Interface\\TARGETINGFRAME\\UI-RaidTargetingIcons" ) ;
    cell.charm:SetTexCoord( unpack(OQ.ICON_COORDS[ m.charm or 0 ]) ); 
  end
end

function oq.set_status( g_id, slot, deserter, queued, online )
  g_id = tonumber( g_id ) ;
  slot = tonumber( slot ) ;
  if ((g_id <= 0) or (slot <= 0)) then
    return ;
  end

  local m = oq.raid.group[g_id].member[slot] ;
  local old_stat = m.flags ;

  m.flags = oq.bset( m.flags, OQ.FLAG_DESERTER, deserter ) ;
  m.flags = oq.bset( m.flags, OQ.FLAG_QUEUED  , queued ) ;
  m.flags = oq.bset( m.flags, OQ.FLAG_ONLINE  , online ) ;

  oq.set_textures( g_id, slot ) ;
end

function oq.gather_my_stats() 
  oq.check_for_deserter() ;
  player_ilevel   = oq.get_ilevel() ;
  player_resil    = oq.get_resil() ;
  if (player_realm == nil) or (player_realm == "") then
    player_realm = oq.GetRealmName() ;
  end
  if (player_realm_id == nil) or (player_realm_id == 0) then
    player_realm = oq.GetRealmName() ;
    player_realm_id = oq.realm_cooked( player_realm ) ;
  end

  local s1 = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(1)) ] ;
  local s2 = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(2)) ] ;
  local old_q = player_queued ;
  player_queued = ((s1 ~= "0") or (s2 ~= "0")) ;
  player_online = true ;

  if ((my_group <= 0) or (my_slot <= 0)) then
    return ;
  end
  local me = oq.raid.group[ my_group ].member[ my_slot ] ;
  me.bg[1].status = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(1)) ] ;
  me.bg[2].status = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(2)) ] ;
  me.gender, me.race = oq.player_demographic() ;  

  me.flags = 0 ; -- reset to 0
  me.flags = oq.bset( me.flags, OQ.FLAG_DESERTER, player_deserter ) ;
  me.flags = oq.bset( me.flags, OQ.FLAG_QUEUED  , player_queued ) ;
  me.flags = oq.bset( me.flags, OQ.FLAG_ONLINE  , player_online ) ;
  me.flags = oq.bset( me.flags, OQ.FLAG_BRB     , player_away ) ;
  if (player_role == OQ.ROLES["TANK"]) then
    me.flags = oq.bset( me.flags, OQ.FLAG_TANK  , true ) ;
  elseif (player_role == OQ.ROLES["HEALER"]) then
    me.flags = oq.bset( me.flags, OQ.FLAG_HEALER, true ) ;
  end
  
  if (me.check == nil) then
    me.check = OQ.FLAG_CLEAR ;
  end

  oq.set_role( my_group, my_slot, player_role ) ;

  local s = OQ_toon.stats["bg"] ;
  if (oq.raid.type == OQ.TYPE_RBG) then
    s = OQ_toon.stats["rbg"] ;
  end

  me.resil    = player_resil ;
  me.ilevel   = player_ilevel ;
  me.hp       = floor(UnitHealthMax("player")/1000) ;
  me.wins     = s.nWins or 0 ;
  me.losses   = s.nLosses or 0 ;
  local hks = GetStatistic(588) ;
  if (hks == "--") then
    hks = 0 ;
  end
  me.hks      = floor(hks / 1000) ;  
  me.oq_ver   = oq.get_version_id() ;
  me.tears    = oq.total_tears() ;
  me.pvppower = oq.get_pvppower() ;
  me.mmr      = oq.get_mmr() ;
  
  -- send out update if queue status changed
  if (player_queued and (old_q ~= player_queued) and (not _inside_bg)) then
    PlaySound("PVPENTERQUEUE") ;
  end

  --
  -- note: statistic id list
  --       http://www.wowwiki.com/Complete_list_of_Achievement_ID%27s
  --       588   Total Honorable Kills 
end

function oq.set_deserter( g_id, slot, deserter ) 
  if ((g_id <= 0) or (slot <= 0)) then
    return ;
  end
  local m = oq.raid.group[g_id].member[slot] ;
  if (m) then
    m.flags = oq.bset( m.flags or 0, OQ.FLAG_DESERTER, deserter ) ;
  end

  oq.set_textures( g_id, slot ) ;
end

function oq.set_status_queued( g_id, slot, queued ) 
  if ((g_id <= 0) or (slot <= 0)) then
    return ;
  end
  local m = oq.raid.group[g_id].member[slot] ;

  m.flags = oq.bset( m.flags, OQ.FLAG_QUEUED, queued ) ;

  oq.set_textures( g_id, slot ) ;
end

function oq.set_status_online( g_id, slot, online ) 
  if ((g_id <= 0) or (slot <= 0)) then
    return ;
  end
  if (oq.raid.group[g_id] == nil) or (oq.raid.group[g_id].member == nil) or (oq.raid.group[g_id].member[slot] == nil) then
    return ;
  end
  local m = oq.raid.group[g_id].member[slot] ;

  if (m.flags == nil) then
    m.flags = 0 ;
  end
  m.flags = oq.bset( m.flags, OQ.FLAG_ONLINE, online ) ;

  oq.set_textures( g_id, slot ) ;
end

function oq.set_role( g_id, slot, role ) 
  if ((g_id <= 0) or (slot <= 0)) then
    return ;
  end
  local m = oq.raid.group[g_id].member[slot] ;
  m.role = role ;

  if (role == OQ.ROLES["TANK"]) then
    m.flags = oq.bset( m.flags, OQ.FLAG_HEALER, false ) ;
    m.flags = oq.bset( m.flags, OQ.FLAG_TANK  , true  ) ;
  elseif (role == OQ.ROLES["HEALER"]) then
    m.flags = oq.bset( m.flags, OQ.FLAG_HEALER, true  ) ;
    m.flags = oq.bset( m.flags, OQ.FLAG_TANK  , false ) ;
  else
    m.flags = oq.bset( m.flags, OQ.FLAG_HEALER, false ) ;
    m.flags = oq.bset( m.flags, OQ.FLAG_TANK  , false ) ;
  end
  oq.set_textures( g_id, slot ) ;
end

function oq.scores_init_bgs()
  oq.scores.bg = {} ;
  oq.scores.bg[ "AB"   ] = 50 ;
  oq.scores.bg[ "AV"   ] = 50 ;
  oq.scores.bg[ "BFG"  ] = 50 ;
  oq.scores.bg[ "EotS" ] = 50 ;
  oq.scores.bg[ "IoC"  ] = 50 ;
  oq.scores.bg[ "SotA" ] = 50 ;
  oq.scores.bg[ "TP"   ] = 50 ;
  oq.scores.bg[ "WSG"  ] = 50 ;
  oq.scores.bg[ "DWG"  ] = 50 ;
end

function oq.scores_init()
  -- no acct level data, initialize
  OQ_data.scores = {} ;
  oq.scores = OQ_data.scores ;
  oq.scores = { ngames = 0, horde = 0, alliance = 0 } ;
  oq.scores_init_bgs() ;
  oq.scores.timeleft       = 1 * 60*60 ;
  oq.scores.end_round_tm   = utc_time() + oq.scores.timeleft ;
  oq.scores.start_round_tm = oq.scores.end_round_tm - (7 * 24 * 60 * 60) ;
  oq.scores.time_lag       = 0 ;
  oq.update_scores() ;
end

-- returns: alliance ngames, nleaders, nactive, 
--          horde ngames, nleaders, nactive
function oq.decode_score_xdata( xdata )
  if (xdata == nil) then
    return 0, 0, 0, 0, 0, 0 ;
  end
  return oq.decode_mime64_digits(xdata:sub( 1, 3)),
         oq.decode_mime64_digits(xdata:sub( 4, 6)),
         oq.decode_mime64_digits(xdata:sub( 7, 9)),
         oq.decode_mime64_digits(xdata:sub(10,12)),
         oq.decode_mime64_digits(xdata:sub(13,15)),
         oq.decode_mime64_digits(xdata:sub(16,18)) ;
end

local _score_args = {} ;
function oq.on_scores( enc_data, sk_time, curr_oq_version, xdata, officers, xrealm_arena, sig )
  tbl.clear(_score_args) ;
  local i = 0 ;
  for v in string.gmatch( enc_data, "[^.]+" ) do
    i = i + 1 ;
    _score_args[i] = v ;
  end
  
  sk_time = tonumber( sk_time or 0, 16 ) ;
  if (oq._sktime_notice_tm == nil) then
    oq._sktime_notice_tm = 0 ;
  end ;
  if (oq._sktime_last_tm == nil) then
    oq._sktime_last_tm = 0 ;
  end
  
  OQ_data._xrealm_arena = tonumber(xrealm_arena or 0) or 0 ;

  if (oq._sktime_last_tm > 0) and (sk_time > 0) and (sk_time < oq._sktime_last_tm) then
    -- old score info, drop
    _ok2relay = nil ;  -- do not relay 
    return ;
  end
  local now = utc_time() ;
  -- to do: compare sk_time with now to see if there is a significant difference.  if so, alert user
  -- to do: insure user notification does not happen more then once per hour or so
  local dt = abs(now - sk_time) ;
  if (sk_time > 0) and (dt > 5*60) and (now > oq._sktime_notice_tm) then
    -- spit out notice only once per 5 minute interval
    print( OQ_LILREDX_ICON .." ".. string.format( OQ.TIMEERROR_1, oq.render_tm( dt ) ) ) ;
    print( OQ_LILREDX_ICON .." ".. OQ.TIMEERROR_2 ) ;
    oq._sktime_notice_tm = now + 5*60 ; -- notify every 5 minutes
  end
  oq._sktime_last_tm = sk_time ; -- holding onto the last sk time
  oq._sktime_last_dt = dt ; -- holding onto the last dtime

  -- update score info
  if (oq.scores == nil) then
    oq.scores = {} ;
  end
  if (oq.scores.bg == nil) then
    oq.scores.bg = {} ;
  end
  oq.scores.bg[ "AB"   ] = tonumber(_score_args[ 1], 16 ) ;
  oq.scores.bg[ "AV"   ] = tonumber(_score_args[ 2], 16 ) ;
  oq.scores.bg[ "BFG"  ] = tonumber(_score_args[ 3], 16 ) ;
  oq.scores.bg[ "EotS" ] = tonumber(_score_args[ 4], 16 ) ;
  oq.scores.bg[ "IoC"  ] = tonumber(_score_args[ 5], 16 ) ;
  oq.scores.bg[ "SotA" ] = tonumber(_score_args[ 6], 16 ) ;
  oq.scores.bg[ "TP"   ] = tonumber(_score_args[ 7], 16 ) ;
  oq.scores.bg[ "WSG"  ] = tonumber(_score_args[ 8], 16 ) ;
  oq.scores.bg[ "SSM"  ] = tonumber(_score_args[ 9], 16 ) ;
  oq.scores.bg[ "ToK"  ] = tonumber(_score_args[10], 16 ) ;
  oq.scores.horde        = tonumber(_score_args[11], 16 ) ;
  oq.scores.alliance     = tonumber(_score_args[12], 16 ) ;
  oq.scores.ngames       = tonumber(_score_args[13], 16 ) ;
  oq.scores.timeleft     = tonumber(_score_args[14], 16 ) ;
  oq.scores.end_round_tm = tonumber(_score_args[15], 16 ) ;
  oq.scores.bg[ "DWG"  ] = tonumber(_score_args[16], 16 ) ;
  oq.scores.bg[ "DKP"  ] = tonumber(_score_args[17], 16 ) ;
  
  if (xdata) and (xdata:find("#to") == nil) then
    oq.scores.a_ngames, oq.scores.a_nleaders, oq.scores.a_nactive,
    oq.scores.h_ngames, oq.scores.h_nleaders, oq.scores.h_nactive = oq.decode_score_xdata( xdata ) ;
  end
  
  local local_tmleft = oq.scores.end_round_tm - now ;
  oq.scores.time_lag = (oq.scores.timeleft - local_tmleft) ;
  oq.scores.start_round_tm = oq.scores.end_round_tm - (7 * 24 * 60 * 60) ;
  
  if (oq.scores.officers == nil) then
    oq.scores.officers = { ["H"] = { nKnights = 0, nGenerals = 0, nSilver = 0, nGolden = 0 },
                           ["A"] = { nKnights = 0, nGenerals = 0, nSilver = 0, nGolden = 0 },
                         } ;
  end
  oq.scores.officers["H"].nGolden   = oq.decode_mime64_digits(officers:sub( 1, 2)) ;
  oq.scores.officers["H"].nSilver   = oq.decode_mime64_digits(officers:sub( 3, 4)) ;
  oq.scores.officers["H"].nGenerals = oq.decode_mime64_digits(officers:sub( 5, 6)) ;
  oq.scores.officers["H"].nKnights  = oq.decode_mime64_digits(officers:sub( 7, 8)) ;
  oq.scores.officers["A"].nGolden   = oq.decode_mime64_digits(officers:sub( 9,10)) ;
  oq.scores.officers["A"].nSilver   = oq.decode_mime64_digits(officers:sub(11,12)) ;
  oq.scores.officers["A"].nGenerals = oq.decode_mime64_digits(officers:sub(13,14)) ;
  oq.scores.officers["A"].nKnights  = oq.decode_mime64_digits(officers:sub(15,16)) ;
  
  oq.scores.h_crowns = oq.decode_mime64_digits(officers:sub(17,19)) ;
  oq.scores.a_crowns = oq.decode_mime64_digits(officers:sub(20,22)) ;
  
  oq.scores.h_bosses = oq.decode_mime64_digits(_score_args[18]:sub(1,3)) ;
  oq.scores.a_bosses = oq.decode_mime64_digits(_score_args[18]:sub(4,6)) ;
  
  oq.scores.h_dkp    = oq.decode_mime64_digits(_score_args[19]:sub(1,3)) ;
  oq.scores.a_dkp    = oq.decode_mime64_digits(_score_args[19]:sub(4,6)) ;
  
  oq.update_scores() ;
  
  -- check current version against sk version
  oq.verify_version( OQ_VER, curr_oq_version ) ;
end

function oq.verify_version( proto_version, oq_version ) 
  if (proto_version == nil) or (oq_version == nil) then
    return ;
  end
  if (proto_version == OQ_VER) and (oq_version == OQ_VERSION) then
    if (oq.version_marquee ~= nil) then
      oq.version_marquee:Hide() ;
    end
    return ;
  end
  -- older or newer?
  local major = tonumber(oq_version:sub(1,1)) ;
  local minor = tonumber(oq_version:sub(2,2)) ;
  local rev   = tonumber(oq_version:sub(3,3)) ;
  if (major == nil) or (minor == nil) or (rev == nil) then
    -- all digits, no alpha allowed
    if (oq.version_marquee ~= nil) then
      oq.version_marquee:Hide() ;
    end
    return ;
  end
  local ver = major * 100 + minor * 10 + rev ; -- ie: 107
  local my_ver = OQ_MAJOR * 100 + OQ_MINOR * 10 + OQ_REVISION  ;
  if (ver <= my_ver) then
    if (oq.version_marquee ~= nil) then
      oq.version_marquee:Hide() ;
    end
    return ;
  end
  local is_required = (proto_version ~= OQ_VER) ;
  -- update ui component to reflect new version
  oq.version_marquee = oq.create_version_marquee() ;
  oq.version_marquee.line_1:SetText( string.format( OQ.DLG_18a, major, minor, rev )) ;
  if (is_required) then
    oq.version_marquee.line_2:SetText( OQ.DLG_18b ) ;
    oq.version_marquee:SetHeight(65) ;
    oq.version_marquee.line_2:Show() ;
  else
    oq.version_marquee:SetHeight(35) ;
    oq.version_marquee.line_2:Hide() ;
  end
  oq.version_marquee:Show() ;
  if (oq._fanfare_queued == nil) then
    oq._fanfare_queued = 1 ;
    -- will check every second to see if the marquee is up, and when it is 
    -- it'll play the fanfare and stop the timer
    oq.timer( "fanfare", 1, oq.new_version_fanfare, true ) ;
  end
end

function oq.new_version_fanfare()
  if (not oq.version_marquee:IsVisible()) then
    return nil ;
  end
  oq.excited_cheer() ;
  return 1 ;
end

function oq.create_version_marquee()
  if (oq.version_marquee ~= nil) then
    return oq.version_marquee ;
  end
  
  local cx = 300 ;
  local cy = 65 ;
  local parent = OQMainFrame ;
  local x = floor(parent:GetWidth() - cx)/2 ;
  local y = parent:GetHeight() - 2*cy ;

  local f = oq.panel( parent, "OQVerMarquee", x, y, cx, cy ) ;
  
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                          edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                          tile=true, tileSize = 16, edgeSize = 16,
                          insets = { left = 4, right = 3, top = 4, bottom = 3 }
                         })
  f:SetBackdropColor(0.2,0.2,0.2,1.0);
  f:SetFrameLevel( f:GetFrameLevel() + 100 ) ; -- top
  
  f.line_1 = oq.label( f, 10, 10, cx-2*10, 22, "new version available", "TOP", "CENTER", font ) ;
  f.line_1:SetFont(OQ.FONT, 14, "") ;
  f.line_2 = oq.label( f, 10, 35, cx-2*10, 22, "required", "TOP", "CENTER", font ) ;
  f.line_2:SetFont(OQ.FONT, 14, "") ;
  return f ;
end

function oq.fmt_time( t )
  if (t == nil) then
    t = 0 ;
  end
  local hrs = floor( t / (60*60)) ;
  local min = floor( t / 60 ) % 60 ;
  return string.format( "%d:%02d", hrs, min ) ;
end

function oq.get_officer( n, tag )
  local sz = "16" ;
  if (tag == 4) then -- golden
    sz = "22" ;
  end
  if (n == nil) or (n == 0) then
    return string.format( "- |T%s:".. sz ..":".. sz .."|t", OQ.dragon_rank[tag].tag ) ;
  else
    return string.format( "%3d |T%s:".. sz ..":".. sz .."|t", n, OQ.dragon_rank[tag].tag ) ;
  end
end

function oq.get_crowns( n, sz_ )
  local crown = "Interface\\PvPRankBadges\\PvPRank15" ;
  local sz = "16" ;
  if (sz_) then
    sz = sz_ ;
  end

  if (n == nil) or (n == 0) then
    return string.format( "- |T%s:".. sz ..":".. sz .."|t", crown ) ;
  else
    return string.format( "%4d |T%s:".. sz ..":".. sz .."|t", n, crown ) ;
  end
end

function oq.update_scores()
  if (oq.scores.start_round_tm == nil) or (oq.scores.end_round_tm == nil) then
    if (oq.scores.timeleft == nil) then
      oq.scores.timeleft     = 1 * 60*60 ;
    end
    oq.scores.end_round_tm   = utc_time() + oq.scores.timeleft ;
    oq.scores.start_round_tm = oq.scores.end_round_tm - (7 * 24 * 60 * 60) ;
  end
  if (oq.scores.officers == nil) then
    oq.scores.officers = { ["H"] = { nKnights = 0, nGenerals = 0, nSilver = 0, nGolden = 0 },
                           ["A"] = { nKnights = 0, nGenerals = 0, nSilver = 0, nGolden = 0 },
                         } ;
  end
  
  -- update UI elements
  local now = utc_time() ;
  if (OQ_data._show_datestamp) then
    oq.tab4_now:SetText( date("!%H:%M %d-%b UTC", now ) .." (".. strupper(OQ.REGION) ..")" ) ;
  end

  oq.tab4_horde_score    :SetText( comma_value(oq.scores.horde)    ) ;
  oq.tab4_horde_nactive  :SetText( comma_value(oq.scores.h_nactive) ) ;
  oq.tab4_horde_leaders  :SetText( comma_value(oq.scores.h_nleaders or 0) ) ;
  oq.tab4_horde_ngames   :SetText( comma_value(oq.scores.h_ngames) ) ;
  oq.tab4_horde_nBosses  :SetText( comma_value(oq.scores.h_bosses) ) ;
  oq.tab4_horde_dkp      :SetText( comma_value(oq.scores.h_dkp) ) ;
  oq.tab4_horde_nGolden  :SetText(oq.get_officer( oq.scores.officers["H"].nGolden  , 4 )) ;
  oq.tab4_horde_nSilver  :SetText(oq.get_officer( oq.scores.officers["H"].nSilver  , 3 )) ;
  oq.tab4_horde_nGenerals:SetText(oq.get_officer( oq.scores.officers["H"].nGenerals, 2 )) ;
  oq.tab4_horde_nKnights :SetText(oq.get_officer( oq.scores.officers["H"].nKnights , 1 )) ;
  oq.tab4_horde_nCrowns  :SetText( comma_value( oq.get_crowns(oq.scores.h_crowns)) ) ;
  if (oq.scores.h_crowns) and (oq.scores.h_crowns > 0) then
    oq.tab4_horde_nCrowns:SetAlpha(1.0) ;
  else
    oq.tab4_horde_nCrowns:SetAlpha(0.5) ;
  end
  
  oq.tab4_alliance_score    :SetText( comma_value(oq.scores.alliance) ) ;
  oq.tab4_alliance_nactive  :SetText( comma_value(oq.scores.a_nactive) ) ;
  oq.tab4_alliance_leaders  :SetText( comma_value(oq.scores.a_nleaders or 0) ) ;
  oq.tab4_alliance_ngames   :SetText( comma_value(oq.scores.a_ngames) ) ;
  oq.tab4_alliance_nBosses  :SetText( comma_value(oq.scores.a_bosses) ) ;
  oq.tab4_alliance_dkp      :SetText( comma_value(oq.scores.a_dkp) ) ;
  oq.tab4_alliance_nGolden  :SetText(oq.get_officer( oq.scores.officers["A"].nGolden  , 4 )) ;
  oq.tab4_alliance_nSilver  :SetText(oq.get_officer( oq.scores.officers["A"].nSilver  , 3 )) ;
  oq.tab4_alliance_nGenerals:SetText(oq.get_officer( oq.scores.officers["A"].nGenerals, 2 )) ;
  oq.tab4_alliance_nKnights :SetText(oq.get_officer( oq.scores.officers["A"].nKnights , 1 )) ;
  
  oq.tab4_alliance_nCrowns  :SetText( comma_value( oq.get_crowns(oq.scores.a_crowns)) ) ;
  if (oq.scores.a_crowns) and (oq.scores.a_crowns > 0) then
    oq.tab4_alliance_nCrowns:SetAlpha(1.0) ;
  else
    oq.tab4_alliance_nCrowns:SetAlpha(0.5) ;
  end

  oq.marquee.horde_score   :SetText( comma_value( oq.scores.horde    )) ;
  oq.marquee.alliance_score:SetText( comma_value( oq.scores.alliance )) ;
  
  for i,v in pairs(oq.scores.bg) do
    oq.set_bg_percent( oq.tab4_bg[ i ], v ) ;
  end
end

function oq.on_stats( name, realm, stats, btag )
  local g_id, slot = oq.decode_slot( stats ) ;
  if (my_group == g_id) and (my_slot == slot) and (oq._override == nil) then
    -- don't tell me my own status
    return ;
  end
  if (g_id == 0) or (slot == 0) then
    -- bad info
    return ;
  end
  name, realm = oq.name_sanity( name, realm ) ;
  
  local force_grp_stats = nil ;
  local m = oq.raid.group[g_id].member[slot] ;
  if (my_group == g_id) and (m ~= nil) and (m.stats ~= stats) then
    force_grp_stats = true ;
  end
  if (btag ~= nil) then
    m.realid = btag ;
  end
  
  local g, s, lvl, demos = oq.decode_stats2( name, realm, stats ) ;
  oq._override = nil ;
  if (g == 0) and (s == 0) then
    -- most likely my slot... ignore
    return ;
  end
  if (lvl == 0) then
    if (name) and (name ~= "-") then
      oq.on_member_left( name, realm, m.realid ) ;
    end
    oq.raid_cleanup_slot( g_id, slot ) ;
    return ;
  end
  if ((name == nil) or (name == "-")) then
    name = "n/a" ;
  end
  local realm_id = 0 ;
  if (realm == nil) or (realm == "-") then
    realm = "n/a" ;
  else
    realm_id = tonumber(realm) ;
    realm = oq.realm_uncooked(realm) ;
  end

  oq.update_tab1_stats() ;
  
--  if (force_grp_stats) then
--    oq.lead_send_party_stats() ;
--  end  
  _ok2relay = nil ;  -- do not relay the stats message
end

function oq.init_table()
   for i=0,255 do
      local c = string.format("%c", i ) ;
      local n = i ;
      oq_ascii[n] = c ;
      oq_ascii[c] = n ;
   end
   
   local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" ;
   local n = strlen(charset) ;
   for i=1,n do
      local c = charset:sub(i,i) ;
      oq_mime64[i-1] = c ;
      oq_mime64[c] = i-1 ;
   end
end

function oq.base64( a, b, c )
   local w, x, y, z ;
   a = oq_ascii[ a ] ;
   b = oq_ascii[ b ] ;
   c = oq_ascii[ c ] ;
   
   --   w = (a & 0xFC) >> 2 ;
   w = bit.rshift( bit.band( a, 0xFC ), 2 ) ;
   
   --   x = ((a & 0x03) << 4) + ((b & 0xF0) >> 4) ;
   x =  bit.lshift( bit.band( a, 0x03 ), 4 ) + bit.rshift( bit.band( b, 0xF0 ), 4 ) ;
   
   --   y = ((b & 0x0F) << 2) + ((c & 0xC0) >> 6) ;
   y = bit.lshift( bit.band( b, 0x0F ), 2 ) + bit.rshift( bit.band( c, 0xC0 ), 6 ) ;
   
   --   z = (c & 0x3F) ;
   z = bit.band( c, 0x3F ) ;
   
   w = oq_mime64[ w ] ;
   x = oq_mime64[ x ] ;
   y = oq_mime64[ y ] ;
   z = oq_mime64[ z ] ;
   return  w, x, y, z ;
end

function oq.base256( w, x, y, z )
   local a, b, c ;
   w = oq_mime64[ w ] or 0 ;
   x = oq_mime64[ x ] or 0 ;
   y = oq_mime64[ y ] or 0 ;
   z = oq_mime64[ z ] or 0 ;
   
   --   a = (w << 2) + ((x & 0x30) >> 4) ;
   a = bit.lshift( w, 2 ) + bit.rshift( bit.band( x, 0x30 ), 4 ) ;
   
   --   b = ((x & 0x0F) << 4) + ((y & 0x3C) >> 2) ;
   b = bit.lshift( bit.band( x, 0x0F ), 4 ) + bit.rshift( bit.band( y, 0x3C ), 2 ) ;
   
   --   c = ((y & 0x03) << 6) + z ;
   c = bit.lshift( bit.band( y, 0x03 ), 6 ) + z ;
   
   a = oq_ascii[ a ] ;
   b = oq_ascii[ b ] ;
   c = oq_ascii[ c ] ;
   return a, b, c ;
end

function oq.decode256( enc ) 
   local str = "" ;
   local n = strlen(enc) ;
   local w, x, y, z, a, b, c ;
   for i=1,n,4 do
      w = enc:sub(i,i) ;
      x = enc:sub(i+1,i+1) ;
      y = enc:sub(i+2,i+2) ;
      z = enc:sub(i+3,i+3) ;
      a, b, c = oq.base256( w, x, y, z ) ;
      str = str .."".. a .."".. b .."".. c ;
   end
   return str ;
end

function oq.encode64( str ) 
   local enc = "" ;
   local n = strlen(str) ;
   local w, x, y, z, a, b, c ;
   for i=1,n,3 do
      a = str:sub(i,i) ;
      b = str:sub(i+1,i+1) ;
      c = str:sub(i+2,i+2) ;
      w, x, y, z = oq.base64( a, b, c ) ;
      enc = enc .."".. w .."".. x .."".. y .."".. z ;
   end
   return enc ;
end

function oq.encrypt( pword, str )
   local enc = "" ;
   local plen = strlen(pword) ;
   local len = strlen(str) ;
   local n = 1 ;
   local i ;
   for i=1,len do
      local a = oq_ascii[ str:sub(i,i) ] ;
      local b = oq_ascii[ pword:sub(n,n) ] ;
      enc = enc .. oq_ascii[ bit.bxor( a, b ) ] ;
      n = n + 1 ;
      if (n > plen) then
         n = 1 ;
      end
   end
   return enc ;
end

function oq.decrypt( pword, enc )
   local str = "" ;
   local plen = strlen(pword) ;
   local len = strlen(enc) ;
   local n = 1 ;
   local i ;
   for i=1,len do
      local a = oq_ascii[ enc:sub(i,i) ] ;
      local b = oq_ascii[ pword:sub(n,n) ] ;
      str = str .. oq_ascii[ bit.bxor( a, b ) ] ;
      n = n + 1 ;
      if (n > plen) then
         n = 1 ;
      end
   end
   return str ;
end

function oq.encode_data( pword, name, realm, rid )
  local s = tostring(name) ..",".. tostring(oq.realm_cooked(realm)) ..",".. tostring(rid) ;

  -- sub then reverse
  s = string.gsub( s, ",", ";" ) ;
  s = s:reverse() ;

  -- encrypt
-- current bug with encrypt / decrypt
--  s = oq.encrypt( pword, s ) ;

  -- put in cocoon
  return oq.encode64( s ) ;
end

local _dvars = {} ;
function oq.decode_data( pword, data )
  -- pull from the cocoon
  local s = oq.decode256( data ) ;

  -- decrypt
-- current bug with encrypt / decrypt
--  s = oq.decrypt( pword, s ) ;
   
  -- reverse then sub
  s = s:reverse() ;
  s = string.gsub( s, ";", "," ) ;
   
  -- pull vars out of it
  tbl.clear( _dvars ) ;
  local v ;
  local i = 0 ;
  for v in string.gmatch( s, "([^,]+)") do
    i = i + 1 ;
    _dvars[i] = v ; 
  end
   
  return _dvars[1], OQ.SHORT_BGROUPS[tonumber(_dvars[2])], _dvars[3] ;
end

function oq.encode_pword( pword )
  local s = pword or "." ;
  if (s:len() > 10) then
    s = s:sub( 1, 10 ) ;
  elseif (s == "") then
    s = "." ;
  end

  -- sub then reverse
  s = string.gsub( s, ",", ";" ) ;
  s = s:reverse() ;
   
  -- put in cocoon
  return oq.encode64( s ) ;
end

function oq.decode_pword( data )
  if (data == nil) or (data == "") then
    return "" ;
  end
  -- pull from the cocoon
  local s = oq.decode256( data ) ;
   
  -- reverse then sub
  s = s:reverse() ;
  s = string.gsub( s, ";", "," ) ;
  
  if (s == ".") then
    s = "" ;
  end
   
  return s ;
end

function oq.encode_name( name )
  local s = name or "." ;
  if (s:len() > 25) then
    s = s:sub( 1, 25 ) ;
  elseif (s == "") then
    s = "." ;
  end

  -- sub then reverse
  s = string.gsub( s, ",", ";" ) ;
  s = s:reverse() ;
   
  -- put in cocoon
  return oq.encode64( s ) ;
end

function oq.decode_name( data )
  -- pull from the cocoon
  local s = oq.decode256( data ) ;
   
  -- reverse then sub
  s = s:reverse() ;
  s = string.gsub( s, ";", "," ) ;
  
  if (s == ".") then
    s = "" ;
  end
   
  return s ;
end

function oq.encode_note( note )
  local s = note or "." ;
  if (s:len() > 150) then
    s = s:sub( 1, 150 ) ;
  elseif (s == "") then
    s = "." ;
  end

  -- sub then reverse
  s = string.gsub( s, ",", ";" ) ;
  s = s:reverse() ;
   
  -- put in cocoon
  return oq.encode64( s ) ;
end

function oq.decode_note( data )
  -- pull from the cocoon
  local s = oq.decode256( data ) ;
   
  -- reverse then sub
  s = s:reverse() ;
  s = string.gsub( s, ";", "," ) ;
  
  if (s == ".") then
    s = "" ;
  end
   
  return s ;
end

function oq.encode_bg( note )
  local s = note or "." ;
  if (s:len() > 35) then
    s = s:sub( 1, 35 ) ;
  elseif (s == "") then
    s = "." ;
  end

  -- sub then reverse
  s = string.gsub( s, ",", ";" ) ;
  s = s:reverse() ;
   
  -- put in cocoon
  return oq.encode64( s ) ;
end

function oq.decode_bg( data )
  if (data == nil) then
    return "" ;
  end
  -- pull from the cocoon
  local s = oq.decode256( data ) ;
   
  -- reverse then sub
  s = s:reverse() ;
  s = string.gsub( s, ";", "," ) ;
  
  if (s == ".") then
    s = "" ;
  end
   
  return s ;
end

function oq.decode_stats( s )
  local gid      = tonumber( s:sub( 1,1 )) ;
  local slot     = tonumber( s:sub( 2,2 )) ;
  local lvl      = tonumber( s:sub( 3,4 )) ;
  local demos    = oq_mime64[ s:sub( 5,5 ) ] ;
  if (demos == "0") then
    return gid, slot, lvl, demos ;
  end
  local gender   = bit.rshift( bit.band( 0x02, demos ), 1 ) ;
  local race     = bit.rshift( bit.band( 0x3C, demos ), 2 ) ;
  local faction  = 'H' ;
  if (bit.band( 0x01, demos ) ~= 0) then
    faction = 'A' ;
  end

  local class    = OQ.TINY_CLASS[ s:sub( 6, 6 ) ] ;
  local stat1    = s:sub(7, 7) ;
  local stat2    = s:sub(8, 8) ;
  local resil    = oq.decode_mime64_digits( s:sub(9,11) ) ;
  local ilevel   = oq.decode_mime64_digits( s:sub(12,13) ) ;

  local f1       = oq_mime64[ s:sub(14, 14)] ;
  local f2       = oq_mime64[ s:sub(15, 15)] ;
  local flags    = bit.lshift( f1, 4 ) + f2 ;
  local hp       = oq.decode_mime64_digits( s:sub(16,17) ) ;
  local role     = tonumber(s:sub(18,18) or 3) ;
  local charm    = tonumber(s:sub(19,19) or 0) ;
  local f3       = oq_mime64[ s:sub(20, 20)] ;
  local f4       = oq_mime64[ s:sub(21, 21)] ;
  local xflags   = bit.lshift( f3, 4 ) + f4 ;
  
  local wins     = oq.decode_mime64_digits( s:sub(22,24) ) ;
  local losses   = oq.decode_mime64_digits( s:sub(25,27) ) ;
  local hks      = oq.decode_mime64_digits( s:sub(28,29) ) ;
  local oq_ver   = oq.decode_mime64_digits( s:sub(30,30) ) ;
  local tears    = oq.decode_mime64_digits( s:sub(31,33) ) ;
  local pvppower = oq.decode_mime64_digits( s:sub(34,36) ) ;
  local mmr      = oq.decode_mime64_digits( s:sub(37,38) ) ;

  return gid, slot, lvl, faction, class, race, gender, 
         stat1, stat2, resil, ilevel, flags, 
         hp, role, charm, xflags, wins, losses, hks, oq_ver, tears, pvppower, mmr ;  
end

function oq.encode_hp( hp )
  if (hp == nil) then
    hp = 0 ;
  end
  local  a = floor(hp / 36) ;
  local  b = floor(hp % 36) ;
  return oq_mime64[ a ] .."".. oq_mime64[ b ] ;
end

function oq.decode_hp( code )
  local a = tonumber(oq_mime64[ code:sub( 1,1 ) ]) ;
  local b = tonumber(oq_mime64[ code:sub( 2,2 ) ]) ;
  return (a * 36) + b ;
end

function oq.encode_stats( g_id, slot, level, faction, class, race, gender, s1, s2, resil, ilevel, flags, hp, role, charm, xflags, wins, losses, hks, oq_ver, tears, pvppower, mmr )
  local lvl = level or 0 ;
  if (lvl < 10) then
    lvl = "0" .. tostring(lvl) ;
  end
  if (flags == nil) then
    flags = 0 ;
  end
  if (xflags == nil) then
    xflags = 0 ;
  end
  local faction_ = 0 ; -- 0 == horde, 1 == alliance
  if (faction ~= "H") then
    faction_ = 1 ;
  end
  local f1 = oq_mime64[ bit.rshift( flags ,    4 )] ;
  local f2 = oq_mime64[ bit.band  ( flags , 0x0F )] ;
  local f3 = oq_mime64[ bit.rshift( xflags,    4 )] ;
  local f4 = oq_mime64[ bit.band  ( xflags, 0x0F )] ;
  local demos = oq_mime64[ bit.lshift( race, 2 ) + bit.lshift( gender, 1 ) + faction_ ] ;
  if (not b1) then
    b1 = oq_mime64[ OQ.NONE ] ;
  else
    b1 = oq_mime64[ b1 ] ;
  end
  if (not b2) then
    b2 = oq_mime64[ OQ.NONE ] ;
  else
    b2 = oq_mime64[ b2 ] ;
  end
  local cls = class ;
  if (cls == nil) or (cls:len() > 2) then
    cls = (OQ.SHORT_CLASS[ class ] or "ZZ") ;
  end
  
  local stats = g_id .."".. 
                slot .."".. 
                lvl .."".. 
                demos .."".. 
                OQ.TINY_CLASS[cls] .."".. 
                (s1 or "A") ..""..
                (s2 or "A") ..""..
                oq.encode_mime64_3digit( resil ) ..""..
                oq.encode_mime64_2digit( ilevel ) ..""..
                f1 .."".. f2 ..""..
                oq.encode_mime64_2digit( hp ) ..""..
                tostring( role or 3 ) ..""..
                tostring( charm or 0 ) ..""..
                f3 .."".. f4 ..""..
                oq.encode_mime64_3digit( wins ) ..""..
                oq.encode_mime64_3digit( losses ) ..""..
                oq.encode_mime64_2digit( hks ) ..""..
                oq.encode_mime64_1digit( oq_ver ) ..""..
                oq.encode_mime64_3digit( tears ) ..""..
                oq.encode_mime64_3digit( pvppower or 0 ) ..""..
                oq.encode_mime64_2digit( mmr or 0 ) 
                ;
  return stats ;
end

function oq.encode_slot( gid, slot )
  gid  = tonumber(gid)  or 0 ;
  slot = tonumber(slot) or 0 ;
  if (gid == 0) then
    return oq.encode_mime64_1digit( gid ) ; -- 0 == no slot assigned
  end
  return oq.encode_mime64_1digit( (gid - 1) * 5 + slot ) ;
end

function oq.decode_slot( m )
  local n = oq.decode_mime64_digits( m:sub(1,1) ) ;
  return floor( ((n-1) / 5) + 1 ), floor( (n-1) % 5 ) + 1 ;
end

function oq.get_class_spec_type( spec_id )
  for i,v in pairs(OQ.CLASS_SPEC) do
    if (v.id == spec_id) then
      return v.type, v.n, i ;
    end
  end
  return 0, nil, 0 ;
end

function oq.encode_my_stats( flags, xflags, charm, s1, s2 )
  local class, spec, spec_id = oq.get_spec() ;
  local gender, race = oq.player_demographic() ;  
  local faction_ = 0 ; -- 0 == horde, 1 == alliance
  if (player_faction ~= "H") then
    faction_ = 1 ;
  end
  local demos = bit.lshift( race, 2 ) + bit.lshift( gender, 1 ) + faction_ ;
  local m = nil ;
  if (my_group > 0) then
    m = oq.raid.group[my_group].member[my_slot] ;
  end
  
  --[[ all purpose header data ]]--
  local s = oq.encode_slot( my_group, my_slot ) ;
  s = s .."".. oq.raid.type ;
  s = s .."".. oq.encode_mime64_2digit( UnitLevel("player") ) ; -- 1..90, requires 2 digits
  s = s .."".. oq.encode_mime64_1digit( demos ) ;
  s = s .."".. OQ.TINY_CLASS[ player_class ] ;
  s = s .."".. oq.encode_mime64_1digit( flags ) ;
  s = s .."".. oq.encode_mime64_1digit( xflags ) ;
  s = s .."".. oq.encode_mime64_1digit( charm ) ;
  s = s .."".. oq.encode_mime64_2digit( floor(UnitHealthMax("player") / 1000) ) ; -- hp
  s = s .."".. oq.encode_mime64_1digit( oq.get_player_role() ) ;
  s = s .."".. oq.encode_mime64_1digit( OQ.CLASS_SPEC[ spec_id ].id ) ;
  s = s .."".. oq.encode_mime64_2digit( player_ilevel ) ;
  s = s .."".. oq.encode_mime64_1digit( oq.get_version_id() ) ;

  --[[ premade type specific data ]]--
  if oq.is_dungeon_premade() or (oq.raid.type == OQ.TYPE_RAID) then
    -- class.spec specific pve data
    local type = OQ.CLASS_SPEC[ spec_id ].type ;
    if     (type == OQ.TANK  ) then
      s = s .."".. oq.encode_mime64_3digit(floor(GetDodgeChance()*100)) ;
      s = s .."".. oq.encode_mime64_3digit(floor(GetParryChance()*100)) ;
      s = s .."".. oq.encode_mime64_3digit(floor(GetBlockChance()*100)) ;      
      s = s .."".. oq.encode_mime64_3digit(floor(GetMasteryEffect()*100)) ;
    elseif (type == OQ.RDPS  ) then
      s = s .."".. oq.encode_mime64_3digit(UnitRangedAttackPower("player")) ;
      s = s .."".. oq.encode_mime64_3digit(GetCombatRatingBonus(CR_HIT_RANGED) * 100) ;
      s = s .."".. oq.encode_mime64_3digit(floor(GetRangedCritChance() * 100)) ; 
      s = s .."".. oq.encode_mime64_3digit(floor(GetMasteryEffect() * 100)) ;
      s = s .."".. oq.encode_mime64_3digit(floor(GetRangedHaste() * 100)) ; 
    elseif (type == OQ.CASTER) then
      s = s .."".. oq.encode_mime64_3digit(oq.get_spell_power()) ;
      s = s .."".. oq.encode_mime64_3digit(GetCombatRatingBonus(CR_HIT_SPELL) * 100) ;
      s = s .."".. oq.encode_mime64_3digit(floor(oq.get_spell_crit() * 100)) ; 
      s = s .."".. oq.encode_mime64_3digit(floor(GetMasteryEffect() * 100)) ;
      s = s .."".. oq.encode_mime64_3digit(floor(UnitSpellHaste("player") * 100)) ; 
    else -- (type == OQ.MDPS) 
      s = s .."".. oq.encode_mime64_3digit(UnitAttackPower("player")) ;
      s = s .."".. oq.encode_mime64_3digit(GetCombatRatingBonus(CR_HIT_MELEE) * 100) ;
      s = s .."".. oq.encode_mime64_3digit(floor(GetCritChance() * 100)) ; 
      s = s .."".. oq.encode_mime64_3digit(floor(GetMasteryEffect() * 100)) ;
      s = s .."".. oq.encode_mime64_3digit(floor(GetMeleeHaste() * 100)) ; 
    end
    
    -- raid progression data
    if (oq.raid.type == OQ.TYPE_CHALLENGE) then
      s = s .."".. oq.get_past_experience() ;
    else
      s = s .."".. oq.get_raid_progression() ;
    end
  else
    -- pvp stats
    local bg_stats = OQ_toon.stats["rbg"] ;
    if (oq.raid.type == OQ.TYPE_BG) then
      bg_stats = OQ_toon.stats["bg"] ;
    end
    s = s .."".. oq.encode_mime64_3digit( oq.get_resil() ) ;
    s = s .."".. oq.encode_mime64_3digit( oq.get_pvppower() ) ;
    s = s .."".. oq.encode_mime64_3digit( bg_stats.nWins ) ;
    s = s .."".. oq.encode_mime64_3digit( bg_stats.nLosses ) ;
    s = s .."".. oq.encode_mime64_3digit( oq.total_tears() ) ; -- the only tears that count are those of your enemy; rbgs could be same faction
    s = s .."".. oq.encode_mime64_2digit( oq.get_best_mmr(oq.raid.type) ) ; -- rbg rating
    s = s .."".. oq.encode_mime64_2digit( oq.get_hks() ) ; -- total hks
    s = s .."".. s1 ;
    s = s .."".. s2 ;
    if (m ~= nil) then
      m.ranks = oq.get_pvp_experience() ;
      s = s .."".. m.ranks ; -- ranks & titles
    else
      s = s .."".. oq.get_pvp_experience() ;
    end

--    s = s .."".. oq.encode_mime64_2digit( oq.get_arena_rating(1) ) ; -- 2s
--    s = s .."".. oq.encode_mime64_2digit( oq.get_arena_rating(2) ) ; -- 3s
--    s = s .."".. oq.encode_mime64_2digit( oq.get_arena_rating(3) ) ; -- 5s
  end
  -- karma, tacked on the back to avoid protocol change and forced update
  s = s .."".. oq.encode_mime64_1digit( min( 50, max( 0, player_karma + 25 )) ) ;

  if (my_group > 0) then
    oq.decode_stats2( player_name, player_realm, s, true ) ;
  end
  return s ;  
end

function oq.decode_their_stats( m, s )
  m.premade_type = s:sub(2,2) ;
  m.stats     = s ; -- hold onto the last stats

  m.level     = oq.decode_mime64_digits( s:sub(3,4) ) ;
  local demos = oq.decode_mime64_digits( s:sub(5,5) ) ;
  if (demos == "0") then
    return demos ;
  end
  m.gender    = bit.rshift( bit.band( 0x02, demos ), 1 ) ;
  m.race      = bit.rshift( bit.band( 0x3C, demos ), 2 ) ;
  m.faction   = 'H' ;
  if (bit.band( 0x01, demos ) ~= 0) then
    m.faction = 'A' ;
  end
  m.class     = OQ.TINY_CLASS[ s:sub(6,6) ] ;
  m.hp        = oq.decode_mime64_digits( s:sub(10,11) ) ;
  m.role      = oq.decode_mime64_digits( s:sub(12,12) ) ;
  m.spec_id   = oq.decode_mime64_digits( s:sub(13,13) ) ;
  m.ilevel    = oq.decode_mime64_digits( s:sub(14,15) ) ;
  m.oq_ver    = oq.decode_mime64_digits( s:sub(16,16) ) ;
  m.spec_type = oq.get_class_spec_type( m.spec_id ) ; -- tank, healer, dmg
  m.karma     = nil ;

  if oq.is_dungeon_premade( m ) or (m.premade_type == OQ.TYPE_RAID) then
    if     (m.spec_type == OQ.TANK  ) then
      m.dodge  = (oq.decode_mime64_digits( s:sub(17,19) ) or 0)/100 ; -- now a percentage
      m.parry  = (oq.decode_mime64_digits( s:sub(20,22) ) or 0)/100 ; 
      m.block  = (oq.decode_mime64_digits( s:sub(23,25) ) or 0)/100 ; 
      m.mastery= (oq.decode_mime64_digits( s:sub(26,28) ) or 0)/100 ; 
      m.raids  = s:sub(29,-1) ;
    elseif (m.spec_type == OQ.RDPS  ) then
      m.power  = (oq.decode_mime64_digits( s:sub(17,19) ) or 0) ;
      m.hit    = (oq.decode_mime64_digits( s:sub(20,22) ) or 0)/100 ; 
      m.crit   = (oq.decode_mime64_digits( s:sub(23,25) ) or 0)/100 ; 
      m.mastery= (oq.decode_mime64_digits( s:sub(26,28) ) or 0)/100 ; 
      m.haste  = (oq.decode_mime64_digits( s:sub(29,31) ) or 0)/100 ; 
      m.raids  = s:sub(32,-1) ;
    elseif (m.spec_type == OQ.CASTER) then
      m.power  = (oq.decode_mime64_digits( s:sub(17,19) ) or 0) ;
      m.hit    = (oq.decode_mime64_digits( s:sub(20,22) ) or 0)/100 ; 
      m.crit   = (oq.decode_mime64_digits( s:sub(23,25) ) or 0)/100 ; 
      m.mastery= (oq.decode_mime64_digits( s:sub(26,28) ) or 0)/100 ; 
      m.haste  = (oq.decode_mime64_digits( s:sub(29,31) ) or 0)/100 ; 
      m.raids  = s:sub(32,-1) ;
    elseif (m.spec_type == OQ.MDPS  ) then
      m.power  = (oq.decode_mime64_digits( s:sub(17,19) ) or 0) ;
      m.hit    = (oq.decode_mime64_digits( s:sub(20,22) ) or 0)/100 ; 
      m.crit   = (oq.decode_mime64_digits( s:sub(23,25) ) or 0)/100 ; 
      m.mastery= (oq.decode_mime64_digits( s:sub(26,28) ) or 0)/100 ; 
      m.haste  = (oq.decode_mime64_digits( s:sub(29,31) ) or 0)/100 ; 
      m.raids  = s:sub(32,-1) ;
    end
    m.karma  = m.raids:sub( -1, -1 ) ; -- last character
    m.raids  = m.raids:sub( 1, -2 ) ; -- trim off last character
  else
    --[[ pvp data ]]--  
    m.resil    = oq.decode_mime64_digits( s:sub(17,19) ) ;
    m.pvppower = oq.decode_mime64_digits( s:sub(20,22) ) ;
    m.wins     = oq.decode_mime64_digits( s:sub(23,25) ) ;
    m.losses   = oq.decode_mime64_digits( s:sub(26,28) ) ;
    m.tears    = oq.decode_mime64_digits( s:sub(29,31) ) ;
    m.mmr      = oq.decode_mime64_digits( s:sub(32,33) ) ;
    m.hks      = oq.decode_mime64_digits( s:sub(34,35) ) ;
    
    m.ranks    = s:sub(38,-1) ;
    
    -- tail:  223355k
--    m.arena2s  = oq.decode_mime64_digits( m.ranks:sub( -7, -6 ) ) ; 
--    m.arena3s  = oq.decode_mime64_digits( m.ranks:sub( -5, -4 ) ) ; 
--    m.arena5s  = oq.decode_mime64_digits( m.ranks:sub( -3, -2 ) ) ; 

    m.karma    = m.ranks:sub( -1, -1 ) ; -- last character
    m.ranks    = m.ranks:sub( 1, -2 ) ; -- trim off last character
  end
  if (m.karma == nil) or (m.karma == "") then
    m.karma = 0 ;
  else
    m.karma  = oq.decode_mime64_digits( m.karma ) - 25 ; -- 0..50, must rebalance to -25..25
  end
  return demos ;
end

function oq.decode_stats2( name, realm, s, force_it )
  local g_id, slot = oq.decode_slot( s ) ;
  if (((my_group == g_id) and (my_slot == slot) and (force_it == nil)) or (g_id == 0) or (slot == 0)) then
    return 0, 0, 0, 0 ;
  end
  oq.assure_slot_exists( g_id, slot ) ;
  
  -- decode directly into member slot
  local m = oq.raid.group[g_id].member[slot] ;
  if (m == nil) then
    return 0,0,0,0 ;
  end
  m.name, m.realm_id, m.realm = oq.name_sanity( m.name, m.realm_id ) ;
  
  if (oq.decode_their_stats( m, s ) == "0") then
    return g_id, slot, m.level, "0" ;
  end
  if ((g_id ~= my_group) or (slot ~= my_slot)) then
    m.flags     = oq.decode_mime64_digits( s:sub( 7, 7) ) ;
    m.check     = oq.decode_mime64_digits( s:sub( 8, 8) ) ;
    oq.set_charm( g_id, slot, oq.decode_mime64_digits( s:sub( 9, 9) )) ;
  end
  oq.set_role ( g_id, slot, oq.decode_mime64_digits( s:sub(12,12) )) ;

  if oq.is_dungeon_premade( m ) or (m.premade_type == OQ.TYPE_RAID) then
    oq.set_group_member( g_id, slot, name, realm, m.class, m.realid, "0", "0" ) ;
  else
    oq.set_group_member( g_id, slot, name, realm, m.class, m.realid, s:sub(36,36), s:sub(37,37) ) ;
  end
  
  -- set overlays
  oq.set_textures( g_id, slot ) ;  
  return g_id, slot, m.level, demos ;
end

function oq.decode_short_stats( s )
  local lvl      = tonumber( s:sub( 1,2 )) ;
  local faction  = s:sub( 3, 3 ) ;
  if (faction == "0") then
    return lvl, faction ;
  end
  local class    = s:sub( 4, 5 ) ;
  local resil    = oq.decode_mime64_digits( s:sub(6, 8)) ;
  local ilevel   = oq.decode_mime64_digits( s:sub(9, 10)) ;
  local role     = tonumber( s:sub(11,11) or 3 ) ;
  local mmr      = oq.decode_mime64_digits( s:sub(12,13) ) ;
  local pvppower = oq.decode_mime64_digits( s:sub(14,16) ) ;
  local spec_id  = oq.decode_mime64_digits( s:sub(17,18) ) ;

  return lvl, faction, class, resil, ilevel, role, mmr, pvppower, spec_id ;
end

function oq.encode_short_stats( level, faction, class, resil, ilevel, role, mmr, pvppower, spec_id )
  local lvl = level ;
  if (lvl < 10) then
    lvl = "0" .. tostring(lvl) ;
  end
  local cls = class ;
  if (cls == nil) or (cls:len() > 2) then
    cls = OQ.SHORT_CLASS[ class ] or "ZZ" ;
  end
  
  local stats = lvl .."".. 
                faction .."".. 
                cls .."".. 
                oq.encode_mime64_3digit( resil  ) ..""..
                oq.encode_mime64_2digit( ilevel ) ..""..
                tostring( role or 3 ) ..""..
                oq.encode_mime64_2digit( mmr ) ..""..
                oq.encode_mime64_3digit( pvppower )  ..""..
                oq.encode_mime64_2digit( spec_id )
                ;
  return stats ;
end

function oq.encode_mime64_6digit( n_ )
  local n = oq.numeric_sanity(n_) ;
  local f = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local e = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local d = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local c = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local b = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local a = floor( n % 64 ) ;  
  return oq_mime64[ a ] .."".. oq_mime64[ b ] .."".. oq_mime64[ c ] .."".. oq_mime64[ d ] .."".. oq_mime64[ e ] .."".. oq_mime64[ f ] ;
end

function oq.encode_mime64_5digit( n_ )
  local n = oq.numeric_sanity(n_) ;
  local e = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local d = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local c = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local b = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local a = floor( n % 64 ) ;  
  return oq_mime64[ a ] .."".. oq_mime64[ b ] .."".. oq_mime64[ c ] .."".. oq_mime64[ d ] .."".. oq_mime64[ e ] ;
end

function oq.encode_mime64_4digit( n_ )
  local n = oq.numeric_sanity(n_) ;
  local d = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local c = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local b = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local a = floor( n % 64 ) ;  
  return oq_mime64[ a ] .."".. oq_mime64[ b ] .."".. oq_mime64[ c ] .."".. oq_mime64[ d ] ;
end

function oq.encode_mime64_3digit( n_ )
  local n = oq.numeric_sanity(n_) ;
  local c = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local b = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local a = floor( n % 64 ) ;  
  return oq_mime64[ a ] .."".. oq_mime64[ b ] .."".. oq_mime64[ c ] ;
end

function oq.encode_mime64_2digit( n_ )
  local n = oq.numeric_sanity(n_) ;
  local b = floor( n % 64 ) ;
  n = floor( n / 64 ) ;
  local a = floor( n % 64 ) ;  
  return oq_mime64[ a ] .."".. oq_mime64[ b ] ;
end

function oq.encode_mime64_1digit( n_ )
  local n = oq.numeric_sanity(n_) ;
  local a = floor( n % 64 ) ;  
  return oq_mime64[ a ] ;
end

function oq.encode_mime64_flags( f1, f2, f3, f4, f5, f6 )
  local a = 0 ;
  a = oq.bset( a, 0x01, f1 ) ;
  a = oq.bset( a, 0x02, f2 ) ;
  a = oq.bset( a, 0x04, f3 ) ;
  a = oq.bset( a, 0x08, f4 ) ;
  a = oq.bset( a, 0x10, f5 ) ;
  a = oq.bset( a, 0x20, f6 ) ;
  return oq_mime64[ a ] ;
end

function oq.decode_mime64_digits( s )
  if (s == nil) then
    return 0 ;
  end
  local n = 0 ;
  for i=1,#s do
    n = n * 64 + oq_mime64[ s:sub( i,i ) or 'A' ] ;
  end
  return n ;
end

function oq.decode_mime64_flags( data )
  local n = oq_mime64[ data ] ;
  local f1 = oq.is_set( n, 0x01 ) ;
  local f2 = oq.is_set( n, 0x02 ) ;
  local f3 = oq.is_set( n, 0x04 ) ;
  local f4 = oq.is_set( n, 0x08 ) ;
  local f5 = oq.is_set( n, 0x10 ) ;
  return f1, f2, f3, f4, f5 ;
end

function oq.encode_premade_info( raid_token, stat, tm, has_pword, is_realm_specific, is_source, karma )
  local raid = oq.premades[ raid_token ] ;
  if (raid == nil) then
    return ;
  end
  return oq.encode_mime64_flags ( (raid.faction == "H"), has_pword, is_realm_specific, is_source ) ..""..
         oq.encode_mime64_1digit( OQ.SHORT_LEVEL_RANGE[ raid.level_range ] ) ..""..
         oq.encode_mime64_2digit( raid.min_ilevel ) ..""..
         oq.encode_mime64_3digit( raid.min_resil ) ..""..
         oq.encode_mime64_1digit( raid.stats.nMembers ) ..""..
         oq.encode_mime64_1digit( raid.stats.nWaiting ) ..""..
         oq.encode_mime64_1digit( stat ) ..""..
         oq.encode_mime64_6digit( tm ) .."".. 
         oq.encode_mime64_2digit( raid.min_mmr ) ..""..
         oq.encode_mime64_1digit( (karma or 0) + 25 ) ; -- will change it from -25..25 to 0..50
end

function oq.decode_premade_info( data ) 
  local is_horde, has_pword, is_realm_specific, is_source = oq.decode_mime64_flags( data:sub(1,1) ) ;
  local faction = "A" ;
  if (is_horde) then
    faction = "H" ;
  end
  local  range = OQ.SHORT_LEVEL_RANGE[ oq.decode_mime64_digits( data:sub(2,2) ) ] ;
  local  karma = data:sub(19,19) ;
  if (karma == nil) or (karma == "") then
    karma = 0 ;
  else
    karma = oq.decode_mime64_digits( karma ) - 25 ;
  end
  
  return faction, has_pword, is_realm_specific, is_source, 
         range,
         oq.decode_mime64_digits( data:sub( 3, 4) ), -- min ilevel
         oq.decode_mime64_digits( data:sub( 5, 7) ), -- min resil
         oq.decode_mime64_digits( data:sub( 8, 8) ), -- nmembers
         oq.decode_mime64_digits( data:sub( 9, 9) ), -- nwaiting
         oq.decode_mime64_digits( data:sub(10,10) ), -- stat
         oq.decode_mime64_digits( data:sub(11,16) ), -- raid.tm
         oq.decode_mime64_digits( data:sub(17,18) ), -- min mmr
         karma                                       -- karma; must be -25..25
         ;         
end

function oq.echo_party_msg( sender, msg ) 
  if (oq.raid.raid_token == nil) or (my_slot ~= 1) or _inside_bg then
    return ;
  end
  if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
    return ;
  end
  local name  = sender ;
  local realm = player_realm ;
  if (sender:find("-")) then
    name  = sender:sub( 1, sender:find("-")-1 ) ;
    realm = sender:sub( sender:find("-")+1, -1 ) ;
  end
  if (name == player_name) then
    if (msg:find('[[]') == 1) then
      -- most likely a relayed msg, do not echo 
      -- (this is buggy, as any messages sent by the group leader starting with '[' won't be relayed)
      return ;
    end
  end
  oq.boss_announce( "party_msg,".. oq.raid.raid_token ..",".. name ..",".. realm ..",".. oq.encode_note( msg ) ) ;  
end

function oq.on_party_msg( raid_token, name, realm, enc_note ) 
  _ok2relay = nil ;
  if (oq.raid.raid_token == nil) or (my_slot ~= 1) then
    return ;
  end
  if (oq.iam_raid_leader()) then
    _ok2relay = 1 ;
  end
  local n = name ;
  if (realm ~= player_realm) then
    n = n .."-".. realm ;
  end
  local note = "[".. n .."] ".. oq.decode_note( enc_note ) ;

  if (oq.iam_in_a_party()) then
    SendChatMessage( note, "PARTY" ) ;
  else
    SendChatMessage( note, "WHISPER", nil, player_name ) ;
  end
end

function oq.check_party_members()
  if (my_group == 0) then
    return ;
  end
  local grp = oq.raid.group[ my_group ] ;
  local new_mem = nil ;
  local mem_gone = nil ;
  local n_members = oq.GetNumPartyMembers() ;
  local rost = {} ;
  
  for i=1,4 do
    if (grp.member[i].name) and (grp.member[i].name ~= "") and (grp.member[i].name ~= "-") then
      rost[ grp.member[i].name ] = { ndx = i, raidid = 0 } ;
    end
  end

  for i = 1,n_members do
    name = UnitName("party".. i)
    if (rost[name] == nil) then
      new_mem = true ;
    else
      rost[name].raidid = i ;
    end
  end

  for name,v in pairs(rost) do
    if (name ~= nil) and (v.raidid == 0) and (name ~= player_name) then
      mem_gone = true ;
      oq.raid_cleanup_slot( my_group, v.ndx ) ;
    end
  end
  
  if (oq.iam_party_leader() and (new_mem or mem_gone)) then
    local now = utc_time() ;
    if ((last_ident_tm + 5) < now) then
      last_ident_tm = now ;
      oq.party_announce( "identify,".. my_group ) ;
    end
  end
end

function oq.get_party_roles()
  local grp = oq.raid.group[ my_group ] ;
  local m = "" ;
  
  for i=1,5 do
    local p = grp.member[i] ;
    if (p.name == nil) or (p.name == "-") or (p.name == "") then
      m = m .."x" ;
    else
      m = m .."".. UnitGroupRolesAssigned( p.name ):sub(1,1) ;
    end
  end
  return m ;
end

function oq.find_first_empty_slot( gid )
  local grp = oq.raid.group[ my_group ] ;
  for i = 2,5 do
    local p = grp.member[i] ;
    if (p.name == nil) or (p.name == "-") then
      return i ;
    end
  end
  return nil ;
end

-- makes sure slots are filled with party member names to insure someone doesn't 
-- disappear from group
--
function oq.verify_group_members() 
  if (not oq.iam_party_leader() or _inside_bg) then 
    return ;
  end
  if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
    -- short circuit for raids
    return ;
  end
  local i, j ;
  local n_members = oq.GetNumPartyMembers() ;
  local grp = oq.raid.group[ my_group ] ;
  if (grp == nil) or (grp.member == nil) then
    return ; -- ??
  end
  
  -- check for members that left
  for i=2,5 do
    if (grp.member[i].name) and (grp.member[i].name ~= "-") and (grp.member[i].name ~= "") then
      grp.member[i].not_here = true ;
    else
      grp.member[i].not_here = nil ;
    end
  end
  for i=1,4 do
    local n = GetUnitName( "party".. i, true )
    local name  = n ;
    if (name) then
      local realm = player_realm ;
      if (name) and (name:find("-")) then
        name  = n:sub(1,n:find("-")-1) ;
        realm = n:sub(n:find("-")+1, -1) ;
      end
      for j=2,5 do
        if (grp.member[j].name == name) then
          grp.member[j].not_here = nil ;
          break ;
        end
      end
    end
  end
  for i=2,5 do
    if (grp.member[i].not_here) then
      oq.set_group_member( my_group, i, nil, nil, "XX", nil, "0", "0" ) ;
      oq.raid_cleanup_slot( my_group, i ) ;
    end
  end

  -- look for new members  
  for i=1,4 do
    local n = GetUnitName( "party".. i, true )
    local name  = n ;
    local realm = player_realm ;
    if (name ~= nil) and (name:find("-") ~= nil) then
      name  = n:sub(1,n:find("-")-1) ;
      realm = n:sub(n:find("-")+1, -1) ;
    end
    if (name ~= nil) then
      local found = nil ;
      for j=2,5 do
        if (grp.member) then
          local p = grp.member[j] ;
          if (p) and (p.name ~= nil) and (p.name == name) then
            p.realm    = realm ;
            found      = true ;
            p.not_here = nil ;
            break ;
          end
        end
      end
      if (not found) then
        -- new member found; party member not in OQ raid group
        slot = oq.find_first_empty_slot( my_group ) ;
        if (slot) and (grp.member) then
          grp.member[slot].name     = name ; -- reserve the spot for this player
          grp.member[slot].realm    = realm ;
          grp.member[slot].class    = OQ.SHORT_CLASS[ select(2, UnitClass("party".. i)) ] or "ZZ" ;
          grp.member[slot].not_here = nil  ; -- reserve the spot for this player
--          oq.brief_player( slot, name ) ;
          oq.timer( "brief_new_member", 1.0, oq.brief_group_members ) ;
        else
          -- error.  all slots full, unknown people in party
        end
      end
    end
  end
end

function oq.get_party_stats( gid )
  -- create message
  gid = gid or my_group ;
  local msg = "gs,".. gid ; -- changed from "grp_stats"
  local grp = oq.raid.group[ gid ] ;
  
  oq.verify_group_members() ;  
  oq.get_my_stats() ; -- will populate 'me'
  
  for i=1,5 do
    local p = grp.member[i] ;
    local stats ;
    if (p.name == nil) or (p.name == "-") or (p.name == "") then
      stats = oq.encode_slot( gid, i ) .."0" ;
    else
      local n = p.name ;
      if (p.realm ~= nil) and (p.realm ~= player_realm) then
        n = n .."-".. p.realm ;
      end
      if (UnitIsConnected(n) == nil) then
        oq.set_member_stats_offline( p ) ;
      end
      p.hp = floor(UnitHealthMax(n) / 1000) ;      
      if (p.check == nil) then
        p.check = OQ.FLAG_CLEAR ;
      end
      stats = p.stats ;
    end
    if (stats ~= nil) then
      msg = msg ..",".. stats ;
    else
      msg = msg ..",".. oq.encode_slot( gid, i ) .."0"
    end
  end
  
  -- tack on queue_tm
  local s1 = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(1)) ] ;
  local s2 = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(2)) ] ;
  local m  = oq.raid.group[ gid ].member[ 1 ] ;

  msg = msg ..",".. 
        (s1 or "0") ..","..
        oq.encode_mime64_6digit( m.bg[1].queue_ts ) ..","..
        (s2 or "0") ..","..
        oq.encode_mime64_6digit( m.bg[2].queue_ts ) ..","..
        tostring(oq.raid.type or OQ.TYPE_NONE) 
        ;

  -- add on roles
  return msg ;
end

function oq.first_raid_slot()
  local n = oq.nMaxGroups() ;
  for g=1,n do
    for s=1,5 do
      local p = oq.raid.group[g].member[s] ;
      if (p.name == nil) or (p.name == "-") then
        return g, s ;
      end
    end
  end
  return 0,0 ;
end

function oq.get_party_names( gid )
  oq.verify_group_members() ;
  if (gid == nil) then
    gid = my_group ;
  end
  -- create message
  local msg = "party_names,".. gid ;
  local grp = oq.raid.group[ gid ] ;
  local i ;
  local online_stats = "" ;
  
  for i=1,5 do
    local p = grp.member[i] ;
    local name ;
    if (p.name == nil) or (p.name == "-") or (p.name == "") or (p.realm == nil) or (p.realm == "-") then
      name = "-,0,-" ;
      online_stats = online_stats .."A" ;
    else
      local cls = p.class ;
      if (cls == nil) or (cls:len() > 2) then
        cls = OQ.SHORT_CLASS[ cls ] or "YY" ;
      end
--      name = p.name ..",".. tostring(oq.realm_cooked(p.realm)) ..",".. cls ;
      name = p.name ..",".. tostring(p.realm_id) ..",".. cls ;
      if (UnitIsConnected(p.name) == nil) then
        online_stats = online_stats .."A" ;
      else
        online_stats = online_stats .."B" ;
      end
    end
    msg = msg ..",".. name ;
  end
  msg = msg ..",".. online_stats ;
  return msg ;
end

function oq.clear_the_dead()
  if (not oq.iam_raid_leader()) or (oq.raid.type ~= OQ.TYPE_BGS) then
    return ;
  end
  local n = oq.nMaxGroups() ;
  for i=2,n do
    local p = oq.raid.group[i].member[1] ;
    if (p == nil) or (p.name == nil) or (p.name == "") or (p.name == "-") then
      local stats = oq.get_party_stats( i ) ; 
      oq.boss_announce( stats ) ;
      oq.party_announce( stats ) ;
    end
  end
end

function oq.send_party_names() 
  if ((my_group <= 0) or (my_slot <= 0)) then
    return ;
  end
  
  local msg = oq.get_party_names() ;
  
  -- send message
  oq.boss_announce( msg ) ;
  oq.raid.group[ my_group ]._names = msg ; -- used to brief new players  
end

function oq.on_member_join( name, realm, btag )
  if (btag == nil) or (btag == "") then
    return ; -- don't report if no btag
  end
  realm = oq.realm_uncooked(realm) ;
  oq.log( nil, oq.btag_link( "member", name, realm, btag ) ) ;
end

function oq.on_member_left( name, realm, btag )
  if (btag == nil) or (btag == "") then
    return ; -- don't report if no btag
  end
  realm = oq.realm_uncooked(realm) ;
  oq.log( nil, oq.btag_link2( "left", name, realm, btag )) ;
end

function oq.set_name( gid, slot, name, realm, class, is_online )
--  oq.set_group_member( gid, slot, name, realm, class, nil, nil, nil ) ;
--  return ;
  if ((gid == 0) or (slot == 0)) then
    return ;
  end
  local realm_id = realm ;
  if(tonumber(realm) ~= nil) then
    realm = oq.realm_uncooked(realm) ;
  else
    realm_id = oq.realm_cooked(realm) ;
  end
  local m = oq.raid.group[ gid ].member[ slot ] ;
  if (name == "-") then
    if (m.name ~= nil) then
      oq.on_member_left( m.name, m.realm, m.realid ) ;
    end
    m.name     = nil ;
    m.realm    = nil ;
    m.realm_id = 0 ;
    m.class    = nil ;
  else
    if (m.name ~= name) then
      oq.on_member_join( name, realm, m.realid ) ; -- use existing realid if already have it, otherwise it'll be nil
    end
    m.name     = name ;
    m.realm    = realm ;
    m.realm_id = realm_id ;
    m.class    = class ;
    if (slot == 1) then
      -- update group leader info
    end
  end
  m.flags = oq.bset( m.flags, OQ.FLAG_ONLINE, (is_online == nil) or (is_online == "B") ) ;
  if (name == player_name) and ((realm == nil) or (realm == "-") or (realm == player_realm)) then
    local force_stats = nil ;
    if ((my_group ~= gid) or (my_slot ~= slot)) then
      force_stats = true ;
    end
    my_group   = gid ;
    my_slot    = slot ;
    m.realm    = player_realm ;
    m.realm_id = player_realm_id ;
    m.class    = player_class ;
    oq.ui_player() ;
    oq.update_my_premade_line() ;
    -- push my stats if needed
    if (force_stats) then
      oq.force_stats() ;
    end
  end
  oq.set_textures( gid, slot ) ;
end

function oq.name_sanity( name, realm_id )
  local realm = oq.realm_uncooked(realm_id) ;
  if (name) and (name ~= "-") and (name:find("-")) then
    realm = name:sub( name:find("-")+1, -1 ) ;
    name  = name:sub( 1, name:find("-")-1 ) ;
    realm_id = oq.realm_cooked( realm ) ;
  end
  return name, realm_id, realm ;
end

function oq.on_party_names( gid, n1, r1, c1, n2, r2, c2, n3, r3, c3, n4, r4, c4, n5, r5, c5, online_stats )
  gid = tonumber(gid) ;
  if (gid == 0) or ((my_group == gid) and (my_slot == 1) and (not oq.is_raid())) then
    return ;
  end
  if (online_stats == nil) then
    online_stats = "BBBBB" ;
  end
  n1, r1 = oq.name_sanity( n1, r1 ) ;
  n2, r2 = oq.name_sanity( n2, r2 ) ;
  n3, r3 = oq.name_sanity( n3, r3 ) ;
  n4, r4 = oq.name_sanity( n4, r4 ) ;
  n5, r5 = oq.name_sanity( n5, r5 ) ;
  
  oq.set_name( gid, 1, n1, r1, c1, online_stats:sub(1,1) ) ;
  oq.set_group_lead( gid, n1, r1, c1, oq.raid.group[gid].member[1].realid ) ;
  
  oq.set_name( gid, 2, n2, r2, c2, online_stats:sub(2,2) ) ;
  oq.set_name( gid, 3, n3, r3, c3, online_stats:sub(3,3) ) ;
  oq.set_name( gid, 4, n4, r4, c4, online_stats:sub(4,4) ) ;
  oq.set_name( gid, 5, n5, r5, c5, online_stats:sub(5,5) ) ;
  
  if (oq.is_raid()) then
    return ;
  end

  if (oq.iam_raid_leader()) then
    local msg = "party_names,".. gid ..",".. 
                 n1 ..",".. r1 ..",".. (c1 or "QQ") ..",".. 
                 n2 ..",".. r2 ..",".. (c2 or "QQ") ..",".. 
                 n3 ..",".. r3 ..",".. (c3 or "QQ") ..",".. 
                 n4 ..",".. r4 ..",".. (c4 or "QQ") ..",".. 
                 n5 ..",".. r5 ..",".. (c5 or "QQ") ;
    if (online_stats) and (online_stats ~= "") then
      msg = msg ..",".. online_stats ;
    end
    oq.boss_announce( msg )
    oq.raid.group[ gid ]._names = msg ; -- used to brief new players
  end  
  
  if (oq.iam_party_leader()) then
    -- tell party
    local msg = "party_names,".. gid ..",".. 
                 n1 ..",".. r1 ..",".. (c1 or "QQ") ..",".. 
                 n2 ..",".. r2 ..",".. (c2 or "QQ") ..",".. 
                 n3 ..",".. r3 ..",".. (c3 or "QQ") ..",".. 
                 n4 ..",".. r4 ..",".. (c4 or "QQ") ..",".. 
                 n5 ..",".. r5 ..",".. (c5 or "QQ") ;
    if (online_stats) and (online_stats ~= "") then
      msg = msg ..",".. online_stats ;
    end
    oq.party_announce( msg ) ;
    oq.raid.group[ gid ]._names = msg ; -- used to brief new players
  end
end

function oq.on_grp_stats( gid, m1, m2, m3, m4, m5, s1, tm1, s2, tm2, raid_type )
  gid = tonumber(gid) ;
  if (gid == 0) or (gid == my_group) then
    return ;
  end
--  if (gid == my_group) and (oq.iam_party_leader()) then
--    return ;
--  end
  local grp = oq.raid.group[ gid ] ;
  tm1 = oq.decode_mime64_digits( tm1 ) ;
  tm2 = oq.decode_mime64_digits( tm2 ) ;

  if (raid_type == OQ.TYPE_NONE) then
    raid_type = OQ.TYPE_BG ;
  end
--  if (oq.raid.type == nil) or (oq.raid.token == nil) then
--    oq.set_premade_type( raid_type ) ;
--  end
  for i=1,5 do
    local m = grp.member[i] ;
    if (m.name) and (m.name ~= "-") and (m.name:find("-")) then
      m.realm    = m.name:sub( m.name:find("-")+1, -1 ) ;
      m.realm_id = oq.realm_cooked( m.realm ) ;
      m.name     = m.name:sub( 1, m.name:find("-")-1 ) ;
    end
  end
  oq.on_stats( grp.member[1].name, grp.member[1].realm_id, m1 ) ;
  oq.on_stats( grp.member[2].name, grp.member[2].realm_id, m2 ) ;
  oq.on_stats( grp.member[3].name, grp.member[3].realm_id, m3 ) ;
  oq.on_stats( grp.member[4].name, grp.member[4].realm_id, m4 ) ;
  oq.on_stats( grp.member[5].name, grp.member[5].realm_id, m5 ) ;
  
  -- deal with queue tms
  oq.on_queue_tm( gid, s1, tm1, s2, tm2 ) ;
  
  if (my_slot == 1) then
    -- changed from "grp_stats"
    local msg = "gs,".. 
                 gid ..",".. 
                 m1 ..",".. 
                 m2 ..",".. 
                 m3 ..",".. 
                 m4 ..",".. 
                 m5 ..",".. 
                 (s1 or "0") ..",".. oq.encode_mime64_6digit(tm1) ..",".. 
                 (s2 or "0") ..",".. oq.encode_mime64_6digit(tm2) ..","..
                 tostring(oq.raid.type or OQ.TYPE_NONE) 
                 ;

    local now = utc_time() ;
    if (grp._stat_tm == nil) then
      grp._stat_tm = 0 ;
    end
    if (grp._stats == msg) and ((now - grp._stat_tm) < 5) then
      _ok2relay = nil ;
    else
      if (my_group == 1) then
        oq.boss_announce( msg ) ;
      end
      oq.party_announce( msg ) ;
      grp._stats = msg ; -- used to brief new players
      grp._stat_tm = now ; -- tm of last update
    end
  end  
end

function oq.on_identify( gid )
  gid = tonumber(gid) ;
  if (gid == 0) then
    gid = nil ;
  end 
  _ok2relay = nil ;
  if (_inside_bg) or ((gid ~= nil) and (gid ~= my_group)) then
    return ;
  end
  local now = utc_time() ;
  if ((last_ident_tm + 5) > now) then
    return ;
  end
  last_ident_tm = now ;
  oq.party_announce( "name,".. my_group ..",".. my_slot ..",".. player_name ..",".. player_realm ) ;
  if (oq.iam_party_leader()) then            
    oq.timer( "party_names", 2, oq.send_party_names ) ;    
  end  
end

function oq.on_name( gid, slot, name, realm )
  gid  = tonumber(gid) ;
  slot = tonumber(slot) ;
  if ((oq.raid.raid_token ~= raid_tok) or _inside_bg or (gid == 0) or (slot == 0)) then
    return ;
  end
  local m = oq.raid.group[ gid ].member[ slot ] ;
  m.name  = name ;
  m.realm = realm ;
end

function oq.get_my_stats()
  oq.gather_my_stats() ;

  -- pack up info and ship
  local m = oq.raid.group[ my_group ].member[ my_slot ] ;
  m.realid = player_realid ; -- just in case
  m.stats = oq.encode_my_stats( m.flags, m.check, m.charm, m.bg[1].status, m.bg[2].status ) ;
  return m.stats ;
end

function oq.force_stats()
  last_stats = nil ;
  lead_ticker = 1 ; -- so the stats pop first
  if (my_group == 0) then
    return ;
  end
  oq.raid.group[ my_group ]._stats = "" ;
  oq.check_stats() ;
end

-- fired on a timer once every 5 seconds.  only send if stats change
--
function oq.check_stats()
  -- if not in an OQ raid, leave
  if (my_group == nil) or (my_slot == nil) or (my_group <= 0) or (my_slot <= 0) or (oq.raid.raid_token == nil) or (_inside_bg) then
    return ;
  end

  -- gather bg queue status
  if (oq.raid.group[ my_group ] == nil) or (oq.raid.group[ my_group ].member[ my_slot ] == nil) then
    return ;
  end
  local me = oq.raid.group[ my_group ].member[ my_slot ] ;
  if (me.bg) then
    me.bg[1].status = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(1)) ] ;
    me.bg[2].status = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(2)) ] ;
  end

  -- if i'm lead, check party stats
  if (my_slot == 1) and (not oq.is_raid()) then
    oq.check_stats_lead() ;
  end

  -- check my stats, post if changed
  local my_stats = oq.get_my_stats() ;
  skip_stats = skip_stats + 1 ;
  if (last_stats == nil) or (my_stats ~= last_stats) or (skip_stats >= 3) then
    last_stats = my_stats ;
    skip_stats = 0 ;
    oq._override = true ;
    oq.on_stats( player_name, oq.realm_cooked(player_realm), my_stats ) ;
    if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
      oq.raid_announce( "stats,".. 
                        player_name ..",".. 
                        tostring(oq.realm_cooked(player_realm)) ..","..
                        my_stats ..","..
                        tostring(player_realid)
                      ) ;
    else
      oq.party_announce( "stats,".. 
                         player_name ..",".. 
                         tostring(oq.realm_cooked(player_realm)) ..","..
                         my_stats ..","..
                         tostring(player_realid)
                       ) ;
    end
  end
end

function oq.lead_send_party_names()
  local grp = oq.raid.group[ my_group ] ;
  local now = utc_time() ;
  --  send_party_names
  local party_names = oq.get_party_names() ;
  if (party_names ~= grp._names) or ((grp._names_tm == nil) or (grp._names_tm < now)) then
    grp._names    = party_names ;
    grp._names_tm = now + random(25,35) ;
    
    local enc_data = oq.encode_data( "abc123", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ;
    oq.party_announce( "party_join,".. 
                       my_group ..","..
                       oq.encode_name( oq.raid.name ) ..",".. 
                       oq.raid.leader_class ..",".. 
                       enc_data ..",".. 
                       oq.raid.raid_token  ..",".. 
                       oq.encode_note( oq.raid.notes )
                     ) ;    
    oq.boss_announce( party_names ) ;
    oq.party_announce( party_names ) ;
  end
end

function oq.lead_send_party_stats()
  local grp = oq.raid.group[ my_group ] ;
  local now = utc_time() ;
  -- send_party_stats() 
  local party_stats = oq.get_party_stats() ;
  if (party_stats ~= grp._stats) or ((grp._stats_tm == nil) or (grp._stats_tm < now)) then
    grp._stats    = party_stats ;
    grp._stats_tm = now + 2 ; -- no need to delay anymore; queue'd msgs help restrict flow
    oq.boss_announce( party_stats ) ;
    oq.party_announce( party_stats ) ;
  end
end

function oq.check_stats_lead()
  lead_ticker = lead_ticker + 1 ;

  -- alternating the sending of party_names and party_stats
  -- in an effort to reduce the number of msgs coming from the lead
  -- at any one moment
  --
  if ((lead_ticker % 2) == 1) then
    oq.lead_send_party_names() ;
  else
    oq.lead_send_party_stats() ;
  end
end

function oq.send_lag_times()
  local msg = "lag_times" ;
  for i=1,8 do
    msg = msg ..",".. (oq.raid.group[i].member[1].lag or 0) ;
  end
  oq.raid_announce( msg ) ;  
end

function oq.set_lag( grp, label, tm )
  tm = tonumber(tm) or 0 ;
  grp.member[1].lag = tm ;
  if (grp.member[1].name == nil) or (grp.member[1].name == "-") then
    label:SetText( "" ) ;
  else
    label:SetText( string.format( "%5.2f", tm/1000 )) ;  
  end
end

function oq.on_lag_times( t1, t2, t3, t4, t5, t6, t7, t8 )
  oq.set_lag( oq.raid.group[1], oq.tab1_group[1].lag, t1 ) ;
  oq.set_lag( oq.raid.group[2], oq.tab1_group[2].lag, t2 ) ;
  oq.set_lag( oq.raid.group[3], oq.tab1_group[3].lag, t3 ) ;
  oq.set_lag( oq.raid.group[4], oq.tab1_group[4].lag, t4 ) ;
  oq.set_lag( oq.raid.group[5], oq.tab1_group[5].lag, t5 ) ;
  oq.set_lag( oq.raid.group[6], oq.tab1_group[6].lag, t6 ) ;
  oq.set_lag( oq.raid.group[7], oq.tab1_group[7].lag, t7 ) ;
  oq.set_lag( oq.raid.group[8], oq.tab1_group[8].lag, t8 ) ;
  oq.raid._last_lag = utc_time() ;
end

function oq.procs_init()
  -- all procs
  --
  oq.proc = {} ;
  oq.proc[ "boss"               ] = oq.on_boss ;
  oq.proc[ "contract"           ] = oq.on_bounty ; -- was "bounty"
  oq.proc[ "brb"                ] = oq.on_brb ;
  oq.proc[ "btag"               ] = oq.on_btag ;
  oq.proc[ "btags"              ] = oq.on_btags ;
  oq.proc[ "charm"              ] = oq.on_charm ;
  oq.proc[ "disband"            ] = oq.on_disband ;
  oq.proc[ "enter_bg"           ] = oq.on_enter_bg ;
  oq.proc[ "find"               ] = oq.queue_find_request ;
  oq.proc[ "fog"                ] = oq.fog_new_data ;
  oq.proc[ "group_hp"           ] = oq.on_group_hp ;
  oq.proc[ "gs"                 ] = oq.on_grp_stats ;  -- changed from "grp_stats"
  oq.proc[ "iam_back"           ] = oq.on_iam_back ;
  oq.proc[ "identify"           ] = oq.on_identify ;
  oq.proc[ "imesh"              ] = oq.on_imesh ; 
  oq.proc[ "invite_accepted"    ] = oq.on_invite_accepted ;
  oq.proc[ "invite_group_lead"  ] = oq.on_invite_group_lead ;
  oq.proc[ "invite_group"       ] = oq.on_invite_group ;
  oq.proc[ "invite_req_response"] = oq.on_invite_req_response ;
  oq.proc[ "join"               ] = oq.on_join ;
  oq.proc[ "k2"                 ] = oq.on_karma ;
  oq.proc[ "lag_times"          ] = oq.on_lag_times ;
  oq.proc[ "leave"              ] = oq.on_leave ;
  oq.proc[ "leave_slot"         ] = oq.on_leave_slot ;
  oq.proc[ "leave_queue"        ] = oq.on_leave_queue ;
  oq.proc[ "leave_waitlist"     ] = oq.on_leave_waitlist ;  
  oq.proc[ "mbox_bn_enable"     ] = oq.on_mbox_bn_enable ;
  oq.proc[ "member"             ] = oq.on_member ;
  oq.proc[ "mesh_tag"           ] = oq.on_mesh_tag ;
  oq.proc[ "name"               ] = oq.on_name ;
  oq.proc[ "need_btag"          ] = oq.on_need_btag ;
  oq.proc[ "new_lead"           ] = oq.on_new_lead ;
  oq.proc[ "party_join"         ] = oq.on_party_join ;
  oq.proc[ "party_msg"          ] = oq.on_party_msg ;
  oq.proc[ "party_names"        ] = oq.on_party_names ;
  oq.proc[ "party_slot"         ] = oq.on_party_slot ;
  oq.proc[ "party_slots"        ] = oq.on_party_slots ;
  oq.proc[ "party_update"       ] = oq.on_party_update ;
  oq.proc[ "pass_lead"          ] = oq.on_pass_lead ;
  oq.proc[ "ping"               ] = oq.on_ping ;
  oq.proc[ "ping_ack"           ] = oq.on_ping_ack ;
  oq.proc[ "p8"                 ] = oq.on_premade ;
  oq.proc[ "premade_note"       ] = oq.on_premade_note ;
  oq.proc[ "promote"            ] = oq.on_promote ;
  oq.proc[ "proxy_invite"       ] = oq.on_proxy_invite ;
  oq.proc[ "proxy_target"       ] = oq.on_proxy_target ;
  oq.proc[ "oq_version"         ] = oq.on_oq_version ;   
  oq.proc[ "queue_tm"           ] = oq.on_queue_tm ;
  oq.proc[ "raid_join"          ] = oq.on_raid_join ;
  oq.proc[ "ready_check"        ] = oq.on_ready_check ;
  oq.proc[ "ready_check_complete"] = oq.on_ready_check_complete ;
  oq.proc[ "remove"             ] = oq.on_remove ;
  oq.proc[ "remove_group"       ] = oq.on_remove_group ;
  oq.proc[ "removed_from_waitlist" ] = oq.on_removed_from_waitlist ;
  oq.proc[ "report_recvd"       ] = oq.on_report_recvd ;
  oq.proc[ "ri"                 ] = oq.on_req_invite ; -- was "req_invite"
  oq.proc[ "req_mesh"           ] = oq.on_req_mesh ;
  oq.proc[ "role_check"         ] = oq.on_role_check ;
  oq.proc[ "scores"             ] = oq.on_scores ;
  oq.proc[ "stats"              ] = oq.on_stats ;
  oq.proc[ "bb"                 ] = oq.on_thebook ; -- was "thebook"
  oq.proc[ "top_dps_recvd"      ] = oq.on_top_dps_recvd ;
  oq.proc[ "top_heals_recvd"    ] = oq.on_top_heals_recvd ;
  oq.proc[ "v8"                 ] = oq.on_vlist ;
  
  -- these msgids will be processed while in a bg
  oq.bg_msgids                = {} ;
  oq.bg_msgids[ "boss"            ] = 1 ;
  oq.bg_msgids[ "contract"        ] = 1 ; -- was "bounty"
  oq.bg_msgids[ "pass_lead"       ] = 1 ;
  oq.bg_msgids[ "p8"              ] = 1 ;
  oq.bg_msgids[ "fog"             ] = 1 ;
  oq.bg_msgids[ "k2"              ] = 1 ;
  oq.bg_msgids[ "report_recvd"    ] = 1 ;
  oq.bg_msgids[ "bb"              ] = 1 ;  -- was "thebook"
  oq.bg_msgids[ "top_dps_recvd"   ] = 1 ;
  oq.bg_msgids[ "top_heals_recvd" ] = 1 ;
  oq.bg_msgids[ "v8"              ] = 1 ;

  -- remove raid-only procs
  oq.procs_no_raid() ;
end

-- in-raid only procs
--
function oq.procs_join_raid()
--[[ no raid required
  oq.proc[ "boss"                  ] = oq.on_boss ;
  oq.proc[ "contract"              ] = oq.on_bounty ; -- was "bounty"
  oq.proc[ "btags"                 ] = oq.on_btags ;
  oq.proc[ "disband"               ] = oq.on_disband ;
  oq.proc[ "find"                  ] = oq.queue_find_request ;
  oq.proc[ "imesh"                 ] = oq.on_imesh ; 
  oq.proc[ "invite_accepted"       ] = oq.on_invite_accepted ;
  oq.proc[ "invite_group_lead"     ] = oq.on_invite_group_lead ;
  oq.proc[ "invite_group"          ] = oq.on_invite_group ;
  oq.proc[ "invite_req_response"   ] = oq.on_invite_req_response ;
  oq.proc[ "k2"                    ] = oq.on_karma ;
  oq.proc[ "leave_waitlist"        ] = oq.on_leave_waitlist ;  
  oq.proc[ "mbox_bn_enable"        ] = oq.on_mbox_bn_enable ;
  oq.proc[ "mesh_tag"              ] = oq.on_mesh_tag ;
  oq.proc[ "oq_version"            ] = oq.on_oq_version ;   
  oq.proc[ "party_join"            ] = oq.on_party_join ;
  oq.proc[ "party_slot"            ] = oq.on_party_slot ;
  oq.proc[ "party_slots"           ] = oq.on_party_slots ;
  oq.proc[ "p8"                    ] = oq.on_premade ;
  oq.proc[ "proxy_invite"          ] = oq.on_proxy_invite ;
  oq.proc[ "proxy_target"          ] = oq.on_proxy_target ;
  oq.proc[ "raid_join"             ] = oq.on_raid_join ;
  oq.proc[ "removed_from_waitlist" ] = oq.on_removed_from_waitlist ;
  oq.proc[ "report_recvd"          ] = oq.on_report_recvd ;
  oq.proc[ "ri"                    ] = oq.on_req_invite ; -- was "req_invite"
  oq.proc[ "req_mesh"              ] = oq.on_req_mesh ;
  oq.proc[ "scores"                ] = oq.on_scores ;
  oq.proc[ "bb"                    ] = oq.on_thebook ;  -- was "thebook"
  oq.proc[ "tops_recvd"            ] = oq.on_tops_recvd ;
  oq.proc[ "v8"                    ] = oq.on_vlist ;
]]
  -- raid required procs
  --
  oq.proc[ "brb"                ] = oq.on_brb ;
  oq.proc[ "btag"               ] = oq.on_btag ;
  oq.proc[ "charm"              ] = oq.on_charm ;
  oq.proc[ "enter_bg"           ] = oq.on_enter_bg ;
  oq.proc[ "fog"                ] = oq.fog_new_data ;
  oq.proc[ "group_hp"           ] = oq.on_group_hp ;
  oq.proc[ "gs"                 ] = oq.on_grp_stats ;  -- changed from "grp_stats"
  oq.proc[ "iam_back"           ] = oq.on_iam_back ;
  oq.proc[ "identify"           ] = oq.on_identify ;
  oq.proc[ "join"               ] = oq.on_join ;
  oq.proc[ "lag_times"          ] = oq.on_lag_times ;
  oq.proc[ "leave"              ] = oq.on_leave ;
  oq.proc[ "leave_slot"         ] = oq.on_leave_slot ;
  oq.proc[ "leave_queue"        ] = oq.on_leave_queue ;
  oq.proc[ "member"             ] = oq.on_member ;
  oq.proc[ "name"               ] = oq.on_name ;
  oq.proc[ "need_btag"          ] = oq.on_need_btag ;
  oq.proc[ "new_lead"           ] = oq.on_new_lead ;
  oq.proc[ "party_msg"          ] = oq.on_party_msg ;
  oq.proc[ "party_names"        ] = oq.on_party_names ;
  oq.proc[ "party_update"       ] = oq.on_party_update ;
  oq.proc[ "pass_lead"          ] = oq.on_pass_lead ;
  oq.proc[ "ping"               ] = oq.on_ping ;
  oq.proc[ "ping_ack"           ] = oq.on_ping_ack ;
  oq.proc[ "premade_note"       ] = oq.on_premade_note ;
  oq.proc[ "promote"            ] = oq.on_promote ;
  oq.proc[ "queue_tm"           ] = oq.on_queue_tm ;
  oq.proc[ "ready_check"        ] = oq.on_ready_check ;
  oq.proc[ "ready_check_complete"] = oq.on_ready_check_complete ;
  oq.proc[ "remove"             ] = oq.on_remove ;
  oq.proc[ "remove_group"       ] = oq.on_remove_group ;
  oq.proc[ "role_check"         ] = oq.on_role_check ;
  oq.proc[ "stats"              ] = oq.on_stats ;
end

-- nulls the in-raid only procs
--
function oq.procs_no_raid()
  -- clear the associated function for raid-only procs
  --
  oq.proc[ "brb"                ] = nil ;
  oq.proc[ "btag"               ] = nil ;
  oq.proc[ "charm"              ] = nil ;
  oq.proc[ "enter_bg"           ] = nil ;
  oq.proc[ "group_hp"           ] = nil ;
  oq.proc[ "gs"                 ] = nil ;   -- changed from "grp_stats"
  oq.proc[ "iam_back"           ] = nil ;
  oq.proc[ "identify"           ] = nil ;
  oq.proc[ "join"               ] = nil ;
  oq.proc[ "lag_times"          ] = nil ;
  oq.proc[ "leave"              ] = nil ;
  oq.proc[ "leave_group"        ] = nil ;
  oq.proc[ "leave_queue"        ] = nil ;
  oq.proc[ "member"             ] = nil ;
  oq.proc[ "name"               ] = nil ;
  oq.proc[ "need_btag"          ] = nil ;
  oq.proc[ "new_lead"           ] = nil ;
  oq.proc[ "party_msg"          ] = nil ;
  oq.proc[ "party_names"        ] = nil ;
  oq.proc[ "party_update"       ] = nil ;
  oq.proc[ "pass_lead"          ] = nil ;
  oq.proc[ "ping"               ] = nil ;
  oq.proc[ "ping_ack"           ] = nil ;
  oq.proc[ "premade_note"       ] = nil ;
  oq.proc[ "promote"            ] = nil ;
  oq.proc[ "queue_tm"           ] = nil ;
  oq.proc[ "ready_check"        ] = nil ;
  oq.proc[ "ready_check_complete"] = nil ;
  oq.proc[ "remove"             ] = nil ;
  oq.proc[ "remove_group"       ] = nil ;
  oq.proc[ "role_check"         ] = nil ;
  oq.proc[ "stats"              ] = nil ;
end

--------------------------------------------------------------------------
--  event handlers
--------------------------------------------------------------------------
function oq.on_addon_event( prefix, msg, channel, sender )
  if ((prefix ~= "OQ") or (sender == player_name)) or ((msg == nil) or (msg == "")) then
    return ;
  end
  if ((channel == "WHISPER") and oq.iam_party_leader() and (sender == oq.raid.leader) and (not OQ_toon.disabled)) then
    -- from the leader and i'm party leader, send only to my party
    oq.SendAddonMessage( "OQ", msg, "PARTY" ) ;
  end

  -- just process, do not send it on
  _local_msg = true ;
  _source    = "addon" ;
  if (channel == "PARTY") then
    _source = "party" ;
  end
  _ok2relay  = nil ;
  oq._sender = sender ;

  oq.process_msg( sender, msg ) ;  
  oq.post_process() ;
end

function tbl.new()
  if (tbl.__pool == nil) then
    tbl.__pool = {} ;
  end
  local t = next(tbl.__pool) ;
  if t then
    tbl.__pool[t] = nil ;
  else
    t = {} 
  end
  return t ;
end

function tbl.delete(t)
  if (t) then
    tbl.clear(t) ;
    tbl.__pool[t] = true ;
  end
  return nil ;
end

function tbl.clear(t)
  if (t) then
    wipe(t) ;
--[[
    for k in pairs(t) do 
      if (type(t[k]) == "table") then
        tbl.delete( t[k] ) ;    -- clear sub tables and be able to reclaim
      end
      t[k] = nil ;
    end
]]--
  end
  return t ;
end

function tbl.size(t)
  if (t == nil) then
    return nil ;
  end
  local n = 0 ;
  for i,v in pairs(t) do
    n = n + 1 ;
  end
  return n ;
end

function tbl.fill( t, ... )
  if (t ~= nil) then
    tbl.clear(t) ;
    for i = 1,select('#', ... ) do
      t[i] = select(i, ...) ;
    end
  end
end

-- returns deep copy of table object
function copyTable( t, copied )
  if (t == nil) then
    return t, copied ;
  end
  copied = copied or tbl.new() ;
  local copy = tbl.new() ;
  copied[t] = copy ;
  for i,v in pairs(t) do
    if (type(v) == "table") then
      if copied[v] then
        copy[i] = copied[v] ;
      else
        copy[i] = copyTable( v, copied ) ;
      end
    else
      copy[i] = v ;
    end
  end
  return copy, copied ;
end

function oq.on_bn_event( ... )
  if (OQ_toon.disabled or (not oq.loaded)) then
    return ;
  end
  tbl.fill( _arg, ... ) ;  
  
  local msg        = _arg[1] ;
  local presenceID = _arg[13] ;
  if (presenceID == nil) or (presenceID == 0) or ((msg == nil) or (msg == "")) then
    oq.post_process() ;
    return ;
  end
  
  tbl.fill( _opts, BNGetToonInfo(presenceID) ) ;
  local toonName   = _opts[2] ;
  local realmName  = _opts[4] ;
  local faction    = _opts[6] ;
  
  if (toonName == nil) or (realmName == nil) then
    oq.post_process() ;
    return ;
  end
  local name = toonName .."-".. realmName ;
  
  oq._sender  = name ;
  _sender_pid = presenceID ;
  _source     = "bnet" ;
  _oq_msg     = nil ;
  _ok2relay   = 1 ; 
  
  oq.check_if_new( presenceID, toonName, realmName ) ;

  oq.process_msg( name, msg ) ;
  
  oq.post_process() ;
end

function oq.on_channel_msg( ... )
  tbl.fill( _arg, ... ) ;  
  
  if ((_arg[2] == player_name) and (oq._iam_scorekeeper == nil)) or ((_arg[1] == nil) or (_arg[1] == "")) then
    oq.post_process() ;
    return ;
  end

  local chan_name = strlower(_arg[9]) ;
  if (not oq.channel_isregistered( chan_name )) then
    oq.post_process() ;
    return ;
  end
  if (chan_name == "oqgeneral") then
    _inc_channel = "oqgeneral" ;
    _local_msg   = true ;
    _source      = "oqgeneral" ;
    oq._sender   = _arg[2] ;
    _ok2relay    = 1 ; 
    oq.process_msg( _arg[2], _arg[1] ) ;
  end
  oq.post_process() ;
end

function oq.forward_msg_raid( msg )
  if (oq.iam_party_leader() and (_source == "party")) then
    oq.whisper_raid_leader( msg ) ;
  elseif (oq.iam_party_leader() and (_source ~= "party")) then
    oq.channel_party( msg ) ;
  end
end

function oq.forward_msg( source, sender, msg_type, msg_id, msg ) 
  if (_source == "bnet") and (not oq.iam_party_leader()) and (msg_type == 'B') then
    _ok2relay = 1 ;
  end
  
  -- no relaying while in a BG.  BATTLEGROUND msgs are BG-wide, everything else stops here
  --
  if (_msg_id == "p8") and (_inc_channel ~= "oqgeneral") and (my_slot ~= 1) and (oq._raid_token ~= oq.raid.raid_token) then
    oq.channel_general( msg ) ;
  end
  if (_inside_bg) then
    return ;
  end
  if (source == "party") and (my_slot ~= 1) then
    return ;
  end
  
  if (_to_realm ~= nil) and (_to_name ~= nil) then
    if (_to_realm == player_realm) and (_msg_id ~= "p8") then
      _ok2relay = nil ;  -- on the realm, just send direct
    end
    if (_to_name == player_name) then
      -- msg was for me, do not forward unless it was an announcement ... then strip off the to & realm fields and send
      if (msg_type == 'A') then
        if (_msg_id == nil) or (_msg_id ~= "p8") then
          oq.announce_relay( _core_msg ) ;
        end
      elseif (msg_type == 'R') then
        -- raid msg coming from raid leader, just send to channel
        oq.forward_msg_raid( msg ) ;
      end
      return ;
    end
    -- delivered
    if (_ok2relay ~= "bnet") then
      oq.SendAddonMessage( "OQ", msg, "WHISPER", _to_name ) ;
      return ;
    end
  end
  if (_ok2relay == "bnet") then
    oq.bnfriends_relay( msg ) ;
    _ok2relay = nil ; -- it's been sent via bnfriends, stop it there
    return ;
  end
  if (not _ok2relay) then
    return ;
  end
  if (oq.iam_raid_leader()) and ((msg_type == 'B') or (msg_type == 'R')) then
    -- relay to group leads
    oq.send_to_group_leads( msg ) ;
    oq.channel_party( msg ) ;
    return ;
  end
  if (source == "bnet") and ((msg_type == 'B') or (msg_type == 'P') or (msg_type == 'R')) and (not oq.iam_raid_leader()) then
    -- receiving msg via an alt (happens with multi-boxers); must send to raid leader
    if (sender ~= oq.raid.leader) then  -- prevent back flow
      oq.whisper_raid_leader( msg ) ;
    end
    oq.whisper_party_leader( msg ) ;
  end
  if ((msg_type == 'A') or ((msg_type == 'W') and (not _received))) then
    oq.bn_echo_raid( msg ) ;
    oq.announce_relay( msg ) ;
  elseif (msg_type == 'P') then
    oq.channel_party( msg ) ;
  elseif (msg_type == 'R') then
    oq.forward_msg_raid( msg ) ;
  end
end

function oq.on_oq_version( version, build )
  build = tonumber(build) ;
  if (build == nil) or (build == OQ_BUILD) then
    -- match, bail out
    return ;
  end
  -- x.xx
  if (#version > 4) then
    return ;
  end
  local major, minor, revision =  version:match( "(%d+).(%d+)(%w?)" ) ;
  if (major == nil) or (minor == nil) then
    return ;
  end
  local now = utc_time() ;
  if (build < OQ_BUILD) then
    -- my version is the same or newer, nothing to do.  
    return ;
  elseif (OQ_data.next_update_notice == nil) or (OQ_data.next_update_notice < now) then
    -- notify user
    local dialog = StaticPopup_Show("OQ_NewVersionAvailable", version, build ) ;
    dialog:SetWidth( 400 ) ;
    dialog:SetHeight( 175 ) ;
    -- update notification cycle
    OQ_data.next_update_notice = now + OQ_NOTIFICATION_CYCLE ; 
  end
end

function oq.check_version( vars )
  local oq_sig   = vars[1] ;
  local oq_ver   = vars[2] ;
--  local token    = vars[3] ;
  local msg_id   = vars[5] ;
  local version  = vars[6] ;
  local build    = vars[7] ;
  if (msg_id == nil) or (oq_sig ~= "OQ") then
    -- definitely not an OQ msg
    return ;
  end
  -- definitely an OQ msg if it gets this far
  --
  if (msg_id == "oq_version") then
    oq.on_oq_version( version, build ) ;
  elseif (msg_id == "scores") then
    oq.verify_version( oq_ver, vars[8] ) ; -- vars[8] is the 3rd arg for 'scores'
  end
end

function oq.stricmp(a,b)
  if (a == nil) and (b == nil) then
    return true ;
  end
  if (a == nil) or (b == nil) then
    return nil ;
  end
  if (strlower(a) == strlower(b)) then
    return true ;
  end
  return nil ;
end

function oq.iam_related_to_boss()
  if (player_realm ~= oq.raid.leader_realm) then
    return nil ;
  end
  for i,v in pairs(OQ_toon.my_toons) do
    if (oq.stricmp(v.name, oq.raid.leader)) then
      return true ;
    end
  end
  return nil ;
end

function oq.route_to_boss( msg )
  if (oq._sender ~= oq.raid.leader) then  -- prevent back flow
    oq.whisper_raid_leader( msg ) ;
  end
end

function oq.recover_premades()
  if (OQ_data._premade_info == nil) then
    OQ_data._premade_info = {} ;
  end
  local now = utc_time() ;
  local tm  = nil ;
  local msg = nil ;
  local p   = nil ;
  for i,v in pairs(OQ_data._premade_info) do
    p = v:find("%.") ;
    if (p) then
      tm  = tonumber(v:sub(1, p-1)) ;
      msg = v:sub(p+1, -1) ;
    end
    if (tm) and (msg) and ((now - tm) < OQ_PREMADE_STAT_LIFETIME) then
      _inc_channel = "oqgeneral" ;
      _local_msg   = true ;
      _source      = "oqgeneral" ;
      oq._sender   = "#backup" ;
      _ok2relay    = nil ; 
      oq.process_msg( oq._sender, msg ) ;
      oq.post_process() ;
    end
    tm  = nil ;
    msg = nil ;
  end
  tbl.clear( OQ_data._premade_info ) ; 
end

function oq.process_msg( sender, msg )
  if (msg:find(OQ.DRUNK)) then
    return ;
  end
  local v ;
  local i = 0 ;
  for v in string.gmatch(msg, "([^,]+)") do
    i = i + 1 ;
    _vars[i] = v ;
  end
  _msg = msg ;
  _core_msg, _to_name, _to_realm, _from = oq.crack_bn_msg( msg ) ;
  --
  -- format:  "OQ,".. OQ_VER ..",".. msg_tok ..",".. hop | raid-token ..",".. msg ;
  --
  local oq_sig   = _vars[1] ;
  local oq_ver   = _vars[2] ;
  local token    = _vars[3] ;
  local msg_id   = _vars[5] ;
  local atok     = nil ;

  -- every msg recv'd is counted, not just those processed
  oq.pkt_recv:inc() ;
  
  if (_inside_bg and (oq.bg_msgids[msg_id] == nil)) or (oq._banned) then
    return ;
  end
  if (oq_sig ~= "OQ") or (oq_ver ~= OQ_VER) or (OQ_toon.disabled) then
    -- not the same protocol, cannot proceed
    oq.check_version( _vars ) ;
    return ;
  end
  _msg_type = token:sub(1,1) ;
  _oq_msg   = true ;
  
  if (_msg_type == 'A') then
    atok = _vars[6] ; -- announce token
    if (not oq.atok_ok2process( atok )) then
      return ;
    end
  end
  
  --
  -- squash any echo
  --
  if ((token ~= "W1") and oq.token_was_seen( token )) then
    return ;
  end
  if ((token == "W1") and (_source == "oqgeneral")) then
    -- these messages cannot come from OQgen
    return ;
  elseif (token == "W1") then
    _ok2relay = nil ;
  end
  _msg_token     = token ;
  _msg_id        = msg_id ;
  _received      = nil ;
  oq.pkt_processed:inc() ;

  if ((_msg_id ~= "scores") and (_msg_id ~= "p8")) then
    if (_source == "bnet") and (_to_name ~= nil) and (_to_name ~= player_name) and
       (_to_realm ~= nil) and (_to_realm == player_realm) then
      oq.SendAddonMessage( "OQ", _core_msg, "WHISPER", _to_name ) ;
      return ;
    end
    if (_source == "bnet") and (not oq.iam_raid_leader()) and oq.iam_related_to_boss() then
      oq.route_to_boss( _core_msg ) ;
      return ;
    end
  end
  
  -- hang onto token to reduce echo
  -- note: hold token after sending to boss as multi-acct bnets will route the data back 
  --       and dont want to ignore it when it comes back
  oq.token_push( token ) ;
  --
  -- unseen message-token.  ok to process
  --
  local inc_channel = _inc_channel ;
  _inc_channel = nil ;  -- suspend the nonsending for processing.  afterwards, put it back for relaying
  -- raid, party or boss msgs
  if ((_msg_type == 'R') or (_msg_type == 'P') or (_msg_type == 'B')) then
    local raid_token = _vars[4] ;
    -- check to see if it's my raid token
    if (((oq.raid.raid_token == nil) or (raid_token == oq.raid.raid_token) or (msg_id == "party_join") or (msg_id == "raid_join")) and (oq.proc[ msg_id ] ~= nil)) then
      oq.proc[ msg_id ]( _vars[ 6], _vars[ 7], _vars[ 8], _vars[ 9], _vars[10], 
                         _vars[11], _vars[12], _vars[13], _vars[14], _vars[15], 
                         _vars[16], _vars[17], _vars[18], _vars[19], _vars[20],
                         _vars[21], _vars[22], _vars[23], _vars[24], _vars[25],
                         _vars[26], _vars[27], _vars[28], _vars[29], _vars[30],
                         _vars[31], _vars[32], _vars[33], _vars[34], _vars[35]
                        ) ;
    end
  elseif ((_msg_type == 'A') or (_msg_type == 'W')) then
    _hop = tonumber(_vars[4]) ;
    if (oq.proc[ msg_id ] ~= nil) then
      oq.proc[ msg_id ]( _vars[ 6], _vars[ 7], _vars[ 8], _vars[ 9], _vars[10], 
                         _vars[11], _vars[12], _vars[13], _vars[14], _vars[15], 
                         _vars[16], _vars[17], _vars[18], _vars[19], _vars[20],
                         _vars[21], _vars[22], _vars[23], _vars[24], _vars[25],
                         _vars[26], _vars[27], _vars[28], _vars[29], _vars[30],
                         _vars[31], _vars[32], _vars[33], _vars[34], _vars[35]
                        ) ;
    else
      _ok2relay = nil ;
    end
    -- rebuild msg for transport, incrementing #hops
    if ((_msg_type == 'A') and (_hop > 0) and (_hop <= OQ_TTL)) then
      if (_source ~= "oqgeneral") then
        -- only decrement when crossing realms, not crossing the realm channel
        _vars[4] = _hop - 1 ;
      end
      msg = "" ;
      for i=1,#_vars do
        if (i == 1) then
          msg = _vars[i] ;
        else
          msg = msg ..",".. _vars[i] ;
        end
      end
      -- re-crack to get update the core_msg
      _core_msg, _to_name, _to_realm, _from = oq.crack_bn_msg( msg ) ;      
    elseif (_msg_type == 'A') then
      _ok2relay = nil ;
    end
  end

  -- reset the inc channel
  _inc_channel = inc_channel ;

  --
  -- spread message 
  --
  if (token ~= "W1") or ((token == "W1") and (_to_name ~= nil) and (_to_name ~= player_name)) then
    if (_msg_type == 'A') and (not _ok2relay) then
      -- # hops exceeded, do nothing and return 
    else
      oq.forward_msg( _source, sender, _msg_type, msg_id, msg ) ;
    end
  end
end

function oq.post_process()
  oq._sender   = nil ;
  _sender_pid  = nil ;
  _local_msg   = nil ;
  _source      = nil ;
  _ok2relay    = 1 ; 
  _dest_realm  = nil ;
  _msg_type    = nil ;
  _msg_id      = nil ;
  _core_msg    = nil ;
  _to_name     = nil ;
  _to_realm    = nil ;  
  _inc_channel = nil ;
  _msg         = nil ;
  _core_msg    = nil ;
  oq._raid_token  = nil ;
  tbl.clear(_opts) ;
  tbl.clear(_vars) ;
  tbl.clear(_arg) ;
end

function oq.send_queue_tm( g_id, s1, tm1, s2, tm2 ) 
  if (oq.raid.raid_token == nil) then
    return ; 
  end
  if (not oq.iam_party_leader() or _inside_bg) then
    return ;
  end
  oq.raid_announce( "queue_tm,".. 
                     g_id ..",".. 
                     (s1 or "0") ..","..
                     (tm1 or 0) ..","..
                     (s2 or "0") ..","..
                     (tm2 or 0) 
                  ) ;  
                  
end

-- TODO: subtract off leader timestamp to show time difference
--
function oq.update_status_txt()
  local lead = oq.raid.group[ 1 ].member[1] ;
  
  for i,v in pairs(oq.raid.group) do
    local mem = v.member[1] ;
    if ((mem) and (mem.name) and (mem.name ~= "") and (mem.name ~= "-")) then
      for j=1,2 do
        local txt = OQ.QUEUE_STATUS[ mem.bg[j].status ] ;
        oq.tab1_group[ i ].status[ j ]:SetText( txt or "-" ) ; 
        oq.tab1_group[ i ].status[ j ]:SetTextColor( 0.9, 0.9, 0.1, 1 ) ; 
        
        if (mem.bg[j].status == "2") then
          -- status: confirmed
          local dt = mem.bg[j].queue_ts or 0 ;
          -- if raid lead has popped, subtract times to show diff from raid lead
          if ((i ~= 1) and (lead.bg[j].queue_ts ~= nil) and (lead.bg[j].queue_ts > 0) and (dt ~= nil)) then
            dt = math.abs(dt - lead.bg[j].queue_ts) ;
          end
          -- times are all milliseconds.  display in hundredths (ie: ss.hh)
          if (dt ~= nil) and (i == 1) then
            oq.tab1_group[ i ].dtime [ j ]:SetText( string.format( "%5.2f", (dt / 1000) ) ) ; 
            oq.tab1_group[ i ].dtime [ j ]:SetTextColor( 0.9, 0.9, 0.9, 1  ) ;
            oq.tab1_group[ i ].status[ j ]:SetTextColor( 0.1, 0.9, 0.1, 1 ) ; -- first group is always good
          else
            oq.tab1_group[ i ].dtime[ j ]:SetText( string.format( "%5.2f", (dt / 1000) ) ) ; 
            oq.tab1_group[ i ].dtime[ j ]:SetTextColor( 0.9, 0.9, 0.9, 1  ) ;
            if (mem.lag ~= nil) then
              if ((dt < (2 * mem.lag)) or (dt < 0.3)) then -- 2*lag or less then 0.30 seconds; trying to remove the guess work
                oq.tab1_group[ i ].dtime [ j ]:SetTextColor( 0.1, 0.9, 0.1, 1 ) ;  
                oq.tab1_group[ i ].status[ j ]:SetTextColor( 0.1, 0.9, 0.1, 1 ) ;  
              elseif (math.abs(dt) < (3 * mem.lag)) then
                oq.tab1_group[ i ].dtime [ j ]:SetTextColor( 0.9, 0.9, 0.1, 1 ) ;
                oq.tab1_group[ i ].status[ j ]:SetTextColor( 0.9, 0.9, 0.1, 1 ) ;  
              else
                oq.tab1_group[ i ].dtime [ j ]:SetTextColor( 0.9, 0.1, 0.1, 1 ) ;
                oq.tab1_group[ i ].status[ j ]:SetTextColor( 0.9, 0.1, 0.1, 1 ) ;  
              end
            end
          end
        else
          oq.tab1_group[ i ].dtime[ j ]:SetText( "" ) ; 
        end
      end
    end
  end
end

function oq.excited_cheer()
  PlaySoundFile("Sound\\Events\\GuldanCheers.wav") ;
  PlaySound("LevelUp") ;
  PlaySoundFile("Sound\\interface\\levelup2.wav") ;
  DoEmote("hail") ;
end

OQ.RANGED_SPELL = { ["DK"] = "death grip", 
                    ["DR"] = "entangling roots", 
                    ["HN"] = "arcane shot",
                    ["MG"] = "frostbolt",  
                    ["MK"] = "crackling jade lightning",  -- ?
                    ["PA"] = "hammer of wrath", 
                    ["PR"] = "smite",  
                    ["RO"] = "throw", 
                    ["SH"] = "lightning bolt",
                    ["LK"] = "drain life",
                    ["WA"] = "shattering throw", 
                  } ;
function oq.IsTargetInRange() 
  if (OQ.RANGED_SPELL[ player_class ] ~= nil) then
    local in_range = IsSpellInRange( OQ.RANGED_SPELL[ player_class ], "target" ) ;
    if (in_range ~= nil) and (in_range == 1) then
      return true ;
    end
  end
  return nil ;
end

function oq.is_da_king(name)
  if (oq.IsTargetInRange() == nil) then
    return nil ;
  end
  if (name == "tinystomper-magtheridon") and (player_faction == "A") then
    return true ;
  end
  if (name == "weegeezer-magtheridon") and (player_faction == "H") then
    return true ;
  end  
  return nil ;
end

-- meant to be 'small' noises that will be replayed no more then once every 3 min
OQ.RARE_ELITES = { ["tinystomper - magtheridon"  ] = { tm = 0, snd = "Sound/Creature/Rabbit/Pet_Rabbit_Clickable01.ogg" },
                   ["weegeezer - magtheridon"    ] = { tm = 0, snd = "Sound/Creature/Rabbit/Pet_Rabbit_Clickable01.ogg" },
                   -- oath
                   ["hotshotone - magtheridon"   ] = { tm = 0, snd = "Sound/Spells/Taunt.wav" },
                   ["oathbreakerz - magtheridon" ] = { tm = 0, snd = "Sound/Spells/Taunt.wav" },
                   ["shamanone - magtheridon"    ] = { tm = 0, snd = "Sound/Spells/Taunt.wav" },
                   -- weanii
                   ["bareweanii - kil'jaeden"    ] = { tm = 0, snd = "Sound/Creature/Babymurloc/Babymurloca.ogg" },
                   ["weanii - kil'jaeden"        ] = { tm = 0, snd = "Sound/Creature/Babymurloc/Babymurloca.ogg" },
                   ["weaniigasmic - tichondrius" ] = { tm = 0, snd = "Sound/Creature/Babymurloc/Babymurloca.ogg" },
                   -- sorina & erick
                   ["sorina - icecrown"          ] = { tm = 0, snd = "Sound/Creature/Gryphonpet/Gryphonpetclicable_01.ogg" },
                   ["erickah - icecrown"         ] = { tm = 0, snd = "Sound/Creature/Cinderkitty/Pet_Cinderkitty_Clickable06.ogg" },
                   -- aellias
                   ["aellias - kel'thuzad"       ] = { tm = 0, snd = "Sound/Item/Weapons/Mace1Hmetal/1Hmacemetalhitflesh1A.ogg" },
                   -- skitt
                   ["skitterin - stormreaver"    ] = { tm = 0, snd = "Sound/Doodad/Fx_Kl_Hawk01.ogg" },
                   ["vendulka - stormreaver"     ] = { tm = 0, snd = "Sound/Doodad/Fx_Kl_Hawk01.ogg" },
                   -- Rrog (10-aug-2013)
                   ["rrog - tichondrius"         ] = { tm = 0, snd = "Sound/creature/Murloc/mMurlocAggroOld.ogg" },
                   ["rrogg - tichondrius"        ] = { tm = 0, snd = "Sound/creature/Murloc/mMurlocAggroOld.ogg" },
                 } ;
function oq.is_rare(name)
  return OQ.RARE_ELITES[name] ;
end

function oq.inspect_check()
  if ((OQ_data.ok2autoinspect == 1) and IsControlKeyDown() and UnitIsFriend("player","target") and CanInspect("target") and not InCombatLockdown()) then
    InspectUnit("target") ;
  end
end

function oq.on_boss( guid, id, level ) 
  level = tonumber( level or 0 ) ;
  id = tonumber(id) ;
  if (oq.BossID[id]) and (level > 0) then
    oq._boss_level[id] = level ;
    oq._boss_guids[id] = guid ;
  end
end

-- need to track if boss is level appropriate 
function oq.save_boss_level()
  local guid  = UnitGUID("target") ;
  local type = guid:sub( 5, 5) ;
  if (OQ._unit_type[type] ~= "npc") and (OQ._unit_type[type] ~= "vehicle") then
    return nil ;
  end
  local id = tonumber(guid:sub( 6,10), 16) ;
  if (oq.BossID[id]) then
    local level = UnitLevel("target") ;
    local nu_boss = ((oq._boss_level[id] == nil) or (oq._boss_level[id] ~= level)) ;
    if (nu_boss) then
      oq._boss_level[id] = UnitLevel("target") ;
      oq._boss_guids[id] = guid ;
      if (oq._instance_type and ((oq._instance_type == "party") or (oq._instance_type == "raid"))) then
        oq.bg_announce( "boss,".. guid ..",".. id ..",".. tostring(oq._boss_level[id]) ) ;
      end
    end
  end
end

function oq.get_boss_level( id )
  id = tonumber(id) ;
  if (id == OQ.SCENARIO_BOSS_ID) then
    return 90 ; -- max level
  end
  return oq._boss_level[id] or 0 ;
end

function oq.on_player_target_change()
  local name = GetUnitName("target", true ) ;
--  if (name == nil) or (oq._inside_instance == nil) then
--    return ;
--  end
  if (name == nil) then
    return ;
  end
  local now = utc_time() ;
  if (name:find( "-" ) == nil) then
    name = name .." - ".. player_realm ;
  end
  name = strlower(name or "") ;
  if oq.is_da_king(name) and ((_hailtiny == nil) or ((now - _hailtiny) > HAILTOTHEKINGBABY)) then
    -- hail to the king, baby
    _hailtiny = now ;
    oq.excited_cheer() ;
  elseif (OQ.RARE_ELITES[name]) and ((now - OQ.RARE_ELITES[name].tm) > 3*60) then
    PlaySoundFile( OQ.RARE_ELITES[name].snd ) ;
    OQ.RARE_ELITES[name].tm = now ;
  else
    local guid = UnitGUID("target") ;
    if (guid ~= nil) then
      local id = tonumber(guid:sub(6,10),16) ; 
      local is_bty_target = oq.is_bounty_target(id) ;
      if (is_bty_target) then
--        print( OQ_LILSKULL_ICON .." ".. string.format( OQ.TARGET_MARK, is_bty_target ) ) ;
        PlaySoundFile("Sound/Doodad/DwarfHorn.ogg")
        if (player_faction == "H") then
          PlaySoundFile("Sound/Doodad/BellTollHorde.ogg")
        else
          PlaySoundFile("Sound/Doodad/BellTollAlliance.ogg")
        end
      end
    end
    oq.save_boss_level() ; -- conditional
  end

  oq.inspect_check() ;  
end

function oq.on_queue_tm( g_id, s1, tm1, s2, tm2 ) 
  g_id   = tonumber( g_id ) ;

  local bg1    = oq.raid.group[ g_id ].member[1].bg[ 1 ] ;
  bg1.queue_ts = tonumber(tm1) ;

  local bg2    = oq.raid.group[ g_id ].member[1].bg[ 2 ] ;
  bg2.queue_ts = tonumber(tm2) ;
  
  oq.update_status_txt() ;
end

function oq.on_bg_event(event,...)
  if (my_group < 1) or (my_slot < 1) then
    return ;
  end
  local me = oq.raid.group[my_group].member[my_slot] ;
  for i = 1,2 do
    if (oq.tab1_bg[i].status == "1") then
      oq.tab1_bg[i].status = "2" ; -- queue'd
      me.bg[i].start_tm = GetTime() ;
      return ;
    end
  end
end

function oq.bn_enabled( toonName, realm, faction, presenceID, isOnline, enabled )
  local name = toonName .."-".. realm ;
  local friend = OQ_data.bn_friends[name] ;
  
  if (friend == nil) then
    OQ_data.bn_friends[name] = {} ;
  elseif (friend.oq_enabled == enabled) then
    friend.presenceID = presenceID ;
    friend.isOnline   = isOnline ;
    return ;
  end
  friend = OQ_data.bn_friends[name] ;
 
  friend.toonName      = toonName ;
  friend.realm         = realm ;
  friend.faction       = faction ;
  friend.presenceID    = presenceID ;
  friend.isOnline      = isOnline ;
  if (enabled ~= "unk") then
    friend.oq_enabled    = enabled ;
    if (enabled) then
      oq.mbnotify_bn_enable( friend.toonName, friend.realm, 1 ) ;
    else
      oq.mbnotify_bn_enable( friend.toonName, friend.realm, 0 ) ;
    end
  end
  oq.n_connections() ;
end

function oq.isNewPresenceID( pid )
  if (pid ~= nil) then
    for i,v in pairs(OQ_data.bn_friends) do
      if (v.presenceID == pid) then
        return true ;
      end
    end
  end
  return nil ;
end

function oq.check_if_new( pid, toonName, realmName )
  local name = toonName .."-".. realmName ;
  local friend = OQ_data.bn_friends[ name ] ;
  --
  -- only does the check if more then 30 seconds have passed or the name is new
  --
  if (friend ~= nil) then
    local now = utc_time() ;
    if (next_bn_check > now) then
      return ;
    end
  else
    OQ_data.bn_friends[ name ] = tbl.new() ;
    friend = OQ_data.bn_friends[ name ] ;
    friend.isOnline      = true ;
    friend.toonName      = toonName ;
    friend.realm         = realmName ;
    friend.presenceID    = pid ;
  end
 
  friend.oq_enabled    = nil ;
  tbl.fill( _f, BNGetFriendInfoByID( pid ) ) ;
  local broadcast  = _f[12] ;
  if (broadcast ~= nil) and (broadcast:sub(1, #OQ_BNHEADER ) == OQ_BNHEADER) then
    friend.oq_enabled = true ;
  end
  if (broadcast ~= nil) and (broadcast:sub(1, #OQ_SKHEADER ) == OQ_SKHEADER) then
    friend.sk_enabled = true ;
  end
  oq.n_connections() ;
end

function oq.clear_postclicks()
  PVPReadyDialogEnterBattleButton:SetScript("PostClick", nil ) ;
  PVPReadyDialogLeaveQueueButton :SetScript("PostClick", nil ) ;
end

function oq.queue_popped( ndx ) 
  if ((my_group == 0) or (my_slot == 0)) then
    return ;
  end
  -- hide wow standard dialog buttons
  -- if raid leader, show dialog with choice
  -- leader can choose to 'leave queue', abandoning the pop
  -- or choose to 'enter', which will send a msg to the raid 
  -- the message will display the 'enter now' button for raid members
  
--  local which = "CONFIRM_BATTLEFIELD_ENTRY" ;
--  StaticPopup_Hide( which ) ;
  
  -- would be nice to hide the buttons... but Hide() is nil 
  --    local OnCancel = StaticPopupDialogs[which].OnCancel
  
  if (oq.iam_raid_leader()) then
    -- show raid leader dialog
    PVPReadyDialogEnterBattleButton:SetScript("PostClick", function(self) oq.raid_announce( "enter_bg,".. ndx    ) ; oq.timer_oneshot( 1, oq.clear_postclicks ) ; end ) ;
    PVPReadyDialogLeaveQueueButton :SetScript("PostClick", function(self) oq.raid_announce( "leave_queue,".. ndx ) ; oq.timer_oneshot( 1, oq.clear_postclicks ) ; end ) ;
  else
    -- disable buttons so user can't click by accident
    PVPReadyDialogEnterBattleButton:Show() ;
    PVPReadyDialogLeaveQueueButton :Show() ;
    PVPReadyDialogEnterBattleButton:Disable() ;
    PVPReadyDialogLeaveQueueButton :Disable() ;
    
    -- show member dialog
    local dialog = StaticPopup_Show("OQ_QueuePoppedMember", nil, nil, ndx ) ;
    if (dialog) then
      dialog.data = ndx ;
    end
  end
end

function oq.send_my_queue_status()
  if ((my_group == 0) or (my_slot == 0) or not oq.iam_party_leader()) then
    return ;
  end
  local s1 = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(1)) ] ;
  local s2 = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(2)) ] ;
  local m  = oq.raid.group[ my_group ].member[ my_slot ] ;
  oq.send_queue_tm( my_group, s1, m.bg[1].queue_ts, s2, m.bg[2].queue_ts ) ;
end

function oq.get_zone_info()
  if (_bg_zone == nil) then
    _bg_zone = GetZoneText() ;
    oq._bg_zone = GetZoneText() ;
  end
  if (_bg_shortname == nil) then  
    _bg_shortname = OQ.BG_SHORT_NAME[ _bg_zone ] ;
    oq._bg_shortname = OQ.BG_SHORT_NAME[ _bg_zone ] ;
    if (_bg_shortname == nil) then
      _bg_zone = nil ;
    end
  end
end

function oq.on_bg_score_update() 
  oq.flag_watcher() ;
  oq.get_zone_info() ;
  
  if ((my_group == 0) or (my_slot == 0)) then
    -- not in an OQ group
    if (GetBattlefieldWinner() ~= nil) and (_winner == nil) then
      oq.game_ended() ;
    end
    return ;
  end
  if (GetBattlefieldWinner() == nil) then
    oq.game_in_process() ;
  elseif (_winner == nil) then
    -- there is a winner and we haven't calc'd the stats yet
    oq.game_ended() ;
  end
end

function oq.on_bg_status_update() 
  if ((my_group == 0) or (my_slot == 0) or _inside_bg) then
    return ;
  end
  
  local s1 = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(1)) ] ;
  local s2 = OQ.QUEUE_STATUS[ select(1, GetBattlefieldStatus(2)) ] ;
  local m  = oq.raid.group[ my_group ].member[ my_slot ] ;
  local queued = nil ;
  if ((s1 ~= "0") or (s2 ~= "0")) then
    queued = 1 ;
  end
  oq.set_status_queued( my_group, my_slot, queued ) ;

  -- determine 'queue time'.  SS.ss
  --
  if ((s1 == "1") or (s1 == "0")) then
    -- reset the clock
    m.bg[1].queue_ts = 0 ;
  end
  if ((s1 == "1") and (m.bg[1].status == "0")) then
    -- from none to queue'd
    m.bg[1].start_tm = GetTime() ;
  end
  if ((s1 == "2") and (m.bg[1].status ~= s1)) then
    -- queue popped
    m.bg[1].confirm_tm = GetTime() ;
    if (m.bg[1].start_tm == nil) then
      m.bg[1].start_tm = m.bg[1].confirm_tm ;
    end
    m.bg[1].queue_ts = floor((m.bg[1].confirm_tm - m.bg[1].start_tm) * 1000) ; -- rounding to milliseconds
    oq.queue_popped( 1 ) ;
  end
  
  if ((s2 == "1") or (s2 == "0")) then
    -- reset the clock
    m.bg[2].queue_ts = 0 ;
  end
  if ((s2 == "1") and (m.bg[2].status == "0")) then
    -- from none to queue'd
    m.bg[2].start_tm = GetTime() ;
  end
  if ((s2 == "2") and (m.bg[2].status ~= s2)) then
    -- queue popped
    m.bg[2].confirm_tm = GetTime() ;
    if (m.bg[2].start_tm == nil) then
      m.bg[2].start_tm = m.bg[2].confirm_tm ;
    end
    m.bg[2].queue_ts = floor((m.bg[2].confirm_tm - m.bg[2].start_tm) * 1000) ; -- rounding to milliseconds
    oq.queue_popped( 2 ) ;
  end

  local changed = nil ;
  if (my_slot == 1) then
    -- only party leaders should send info
--    oq.timer( "snd_qstat", 2, oq.send_my_queue_status ) ;
  end

  if (m.bg[1].status ~= s1) then
    changed = 1 ;
  end
  if (m.bg[2].status ~= s2) then
    changed = 1 ;
  end

  m.bg[1].status = s1 ;
  m.bg[2].status = s2 ;

  oq.update_status_txt() ;

  -- only insta-trip if not leader, giving the leader a chance to bundle up stats
  if (changed) then
    if (my_slot == 1) then  
      oq.timer_oneshot( 0.75, oq.force_stats ) ; -- allow party members a bit of time to send their status update
    else
      oq.force_stats() ; 
    end
  end
end

function oq.on_addon_loaded( name )
--  if (name == "oqueue") then
--    oq.on_init( GetTime() ) ;
--  end
end

function oq.good_region_info()
  if (string.sub(GetCVar("realmList"),1,2) == "us") then
    return true ;
  end
  if (string.sub(GetCVar("realmList"),1,2) == "eu") then
    return true ;
  end
  return nil ;
end

function oq.on_player_enter_world()
  if (oq.loaded) then
    return ;
  end
  if (oq.good_region_info()) and (oq.get_raid_progression ~= nil) then
    oq.on_init( GetTime() ) ;
  elseif (not oq.good_region_info()) then
    -- no region info.
    print( OQ_REDX_ICON ) ;
    print( OQ_REDX_ICON .." Error : oQueue disabled" ) ;
    print( OQ_REDX_ICON .." Reason: Invalid realmlist information (".. GetCVar("realmList") ..")" ) ;
    print( OQ_REDX_ICON .." Reason: This usually happens due to private server use." ) ;
    print( OQ_REDX_ICON .." Action: Please exit wow, delete your config.wtf, and restart your wow" ) ;
    print( OQ_REDX_ICON ) ;
  else
    print( OQ_REDX_ICON ) ;
    print( OQ_REDX_ICON .." Error : oQueue did not load all modules properly." ) ;
    print( OQ_REDX_ICON .." Reason: If you recently updated, a full restart of your wow may be required" ) ;
    print( OQ_REDX_ICON .." Action: If a restart does not resolve it, try re-installing oQueue" ) ;
    print( OQ_REDX_ICON .." Action: If you're still having problems, find tiny in public vent" ) ;
    print( OQ_REDX_ICON .." Action: wow.publicvent.org : 4135" ) ;
  end
  oq.loaded = true ;
end

function oq.fmt_time( tm )
  local nmin, nsec ;
  if (tm == nil) then
    return "0:00" ;
  end
  nmin = floor( tm / 60) ;
  nsec = floor( tm % 60) ;
  return string.format( "%d:%02d", nmin, nsec ) ;  
end

--------------------------------------------------------------------------
-- initialization functions & event handlers
--------------------------------------------------------------------------
function oq.on_event(self,event,...)
  if (oq.msg_handler[event] ~= nil) then
    oq.msg_handler[event]( ... ) ;
  end  
end

function oq.on_bn_friend_invite_added( ... )
  oq.on_bnet_friend_invite( ... ) ;
  oq.bn_check_online() ;
end

function oq.get_seat( name )
  if (name:find('-')) then
    name = name:sub(1, (name:find('-') or 0)-1 ) ;
  end
  for gid=1,8 do
    for slot=1,5 do
      local m = oq.raid.group[gid].member[slot] ;
      if (m.name == name) then
        return gid, slot ;
      end
    end
  end
  return 0, 0 ;
end

function oq.check_seat( name, group_id, slot )
  if (name:find('-')) then
    name = name:sub(1, (name:find('-') or 0)-1 ) ;
  end
  local m = oq.raid.group[group_id].member[slot] ;
  return (m.name == name) ;
end

function oq.first_open_seat( gid )
  for j=1,5 do
    if ((oq.raid.group[gid].member[j].name == nil) or (oq.raid.group[gid].member[j].name == "-")) then
      return gid, j ;
    end
  end
  return gid, 0 ;
end

function oq.swap_seats( m, x ) 
  local tmp1 = copyTable( m ) ;
  local tmp2 = copyTable( x ) ;
  m = copyTable( tmp2 ) ;
  x = copyTable( tmp1 ) ;
end

function oq.move_member( name, new_gid, new_slot ) 
  local old_gid, old_slot = oq.get_seat( name ) ;
  
  if (old_slot ~= 0) then
    local m = oq.raid.group[new_gid].member[new_slot] ;
    local x = oq.raid.group[old_gid].member[old_slot] ;
    oq.raid_announce( "party_slot,".. 
                       x.name ..","..
                       new_gid ..","..
                       new_slot
                    ) ;
--[[
    if (m.name ~= nil) and (m.name ~= "-") then
      oq.raid_announce( "party_slot,".. 
                         m.name ..","..
                         old_gid ..","..
                         old_slot
                      ) ;
    end
]]--
    oq.swap_seats( m, x ) ;
--    oq.raid_cleanup_slot( old_gid, old_slot ) ;  
  end 
--[[  
  local enc_data = oq.encode_data( "abc123", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ;
  oq.raid_announce( "party_join,".. 
                      new_gid ..","..
                      oq.encode_name( oq.raid.name ) ..",".. 
                      oq.raid.leader_class ..",".. 
                      enc_data ..",".. 
                      oq.raid.raid_token  ..",".. 
                      oq.encode_note( oq.raid.notes )
                   ) ;
]]--
end

function oq.find_member( table, name )
  if (name == nil) or (name == "-") then
    return nil ;
  end
  for i=1,8 do
    for j=1,5 do
      local m = table[i].member[j] ;
      if (m.name ~= nil) and (m.name == name) then
        return m ;
      end
    end
  end
  return nil ;
end

function oq.assign_raid_seats()
  local n = GetNumGroupMembers() ;
  local slot = 0 ;
  local i, j ;
  local cur = copyTable( oq.raid.group ) ;
  local grp = tbl.new() ;
  my_group = 1 ;
  my_slot  = 1 ;
  for i=1,8 do
    grp[i] = 0 ;
  end

  for i=1,n do
    local name, _, gid = GetRaidRosterInfo(i) ;
    local realm ;
    name, realm = oq.crack_name( name ) ;

    grp[ gid ] = grp[ gid ] + 1 ;
    slot = grp[ gid ] ;
    if (name ~= nil) then
      local m = oq.find_member( cur, name ) ;
      if (m ~= nil) then
        oq.raid.group[gid].member[ slot ] = copyTable( m ) ;
        oq.raid.group[gid].member[ slot ].realm = realm ;
        oq.raid.group[gid].member[ slot ].realm_id = oq.realm_cooked(realm) ;
        oq.set_textures( gid, slot ) ;
      else
        oq.raid.group[gid].member[ slot ].name  = name ;
        oq.raid.group[gid].member[ slot ].realm = realm ;
        oq.raid.group[gid].member[ slot ].realm_id = oq.realm_cooked(realm) ;
      end
    end
  end
  if (n == 0) then
    -- only one person in the 'raid'
    local m = oq.find_member( cur, player_name ) ;
    gid = 1 ;
    grp[ gid ] = grp[ gid ] + 1 ;
    slot = grp[ gid ] ;
    oq.raid.group[gid].member[ slot ] = copyTable( m ) ;
    oq.set_textures( gid, slot ) ;    
  end
  -- make sure everyone knows we're in the raid
  local enc_data = oq.encode_data( "abc123", oq.raid.leader, oq.raid.leader_realm, oq.raid.leader_rid ) ;
  oq.raid_announce( "raid_join,".. 
                     oq.encode_name( oq.raid.name ) ..",".. 
                     tostring(oq.raid.type) ..","..
                     oq.raid.leader_class ..",".. 
                     enc_data ..",".. 
                     oq.raid.raid_token  ..",".. 
                     oq.encode_note( oq.raid.notes )
                  ) ;

  -- clear the other seats
  local ngroups = oq.nMaxGroups() ;
  for i=1,ngroups do
    if (grp[i] < 5) then
      for j=grp[i]+1,5 do
        oq.raid_cleanup_slot( i, j ) ;
      end
    end
    local names = oq.get_party_names( i ) ;
    
    -- the 'R' stands for 'raid' and should not be echo'd far and wide
    local msg_tok = "R".. oq.token_gen() ;
    oq.token_push( msg_tok ) ;
    local msg = "OQ,".. OQ_VER ..",".. msg_tok ..",".. oq.raid.raid_token ..",".. names ;
    oq.SendAddonMessage( "OQ", msg, "RAID" ) ;
  end
  -- cleanup (how to actually delete/free-up the memory??)
  tbl.clear( cur ) ;
end

function oq.on_party_members_changed()
  oq.closeInvitePopup() ;
  local instance, instanceType = IsInInstance() ;
  if (_inside_bg) then
    return ;
  end
  if (oq.iam_party_leader()) then
    last_brief_tm = 0 ;
    lead_ticker = 1 ; -- force the sending of stats on the next tick
    if (my_group > 0) then
      oq.raid.group[ my_group ]._stats = nil ;
      oq.raid.group[ my_group ]._names = nil ; 
    end
    if ((oq.raid.raid_token ~= nil) and
        (oq.GetNumPartyMembers() > 0) and 
        (select(1,GetLootMethod()) ~= "freeforall") and 
        (instance == nil) and
        (oq.raid.type ~= OQ.TYPE_DUNGEON) and 
        (oq.raid.type ~= OQ.TYPE_CHALLENGE) and
        (oq.raid.type ~= OQ.TYPE_QUESTS) and
        (oq.raid.type ~= OQ.TYPE_RAID)) then
      SetLootMethod( "freeforall" ) ;
    end
    if (oq.GetNumPartyMembers() == 2) and (oq.iam_raid_leader()) then
      -- make sure it's a raid if required
      if (oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID) then
        ConvertToRaid() ;
      else
        ConvertToParty() ;
      end
    end
  elseif ((oq.GetNumPartyMembers() == 0) and (not oq.iam_raid_leader())) then
    -- was a party member and left party... need to clean up
    if (my_slot > 1) and (my_group > 0) then
      oq.quit_raid_now() ;
    end
  end
  if (oq.iam_raid_leader() and ((oq.raid.type == OQ.TYPE_RBG) or (oq.raid.type == OQ.TYPE_RAID))) then
    -- re-assign slots
    oq.assign_raid_seats() ;
  end
  if (my_slot == 1) then
    oq.timer_oneshot( 1, oq.force_stats ) ;
  else
    oq.force_stats() ;
  end
end

function oq.on_party_member_disable( party_member )
  local name, realm = UnitName(party_member) ;
  local m = oq.find_group_member( name ) ;
  if (m) then
    oq.set_member_stats_offline( m ) ;
    if (my_slot == 1) then
      oq.force_stats() ;
    end
  end
end

-- hook the world map show function so we can know if the UI was forced closed by the map
function oq.WorldMap_show(...)
  local now = GetTime() ;
  if (oq.ui.old_show) then
    oq.ui.old_show(...) ;
  end
  if (now == oq.ui.hide_tm) then
    _ui_open = true ;
  end
end

-- hook for BNSetCustomMessage
function oq.BNSetCustomMessage(...)
  tbl.fill( _arg, ... ) ;  

  if (oq.old_bncustommsg ~= nil) then
    oq.old_bn_msg = _arg[1] or "" ;
    if (oq.old_bn_msg:sub(1, #OQ_BNHEADER ) == OQ_BNHEADER) or
       (oq.old_bn_msg:sub(1, #OQ_OLDBNHEADER ) == OQ_OLDBNHEADER) then
      -- strip it
      oq.old_bn_msg = oq.old_bn_msg:sub( #OQ_BNHEADER+1, -1 ) ;
    end
    if (oq.old_bncustommsg ~= oq.BNSetCustomMessage) then
      oq.old_bncustommsg( OQ_BNHEADER .."".. oq.old_bn_msg ) ;
    end
  else
  print( "b-net custom msg not available" ) ;
  end
end

function oq.set_bn_msg_clear()
  if (oq.old_bncustommsg ~= nil) and (oq.old_bn_msg ~= nil) then
    oq.old_bncustommsg( oq.old_bn_msg ) ;
  end
end

function oq.init_bn_custom_msg()
  if (BNSetCustomMessage ~= nil) and (oq.old_bncustommsg ~= BNSetCustomMessage) then
    oq.old_bncustommsg = BNSetCustomMessage ;
    BNSetCustomMessage = oq.BNSetCustomMessage ;
  end
  -- grab last msg and tack an [OQ] on the front
  tbl.fill( _arg, BNGetInfo() ) ;
  
--  pid, toonID, broadcast, bnetAFK, bnetDND  = BNGetInfo() ;
  local broadcast = _arg[4] ;
  -- pandaria update
  if (broadcast ~= nil) then
    broadcast = tostring(broadcast) ;
  end
  if (broadcast == nil) then
    oq.BNSetCustomMessage( "" ) ;
  elseif (broadcast:sub(1, #OQ_BNHEADER ) ~= OQ_BNHEADER) and (broadcast:sub(1, #OQ_SKHEADER ) ~= OQ_SKHEADER) then
    oq.BNSetCustomMessage( broadcast ) ;
  end
  OQ_data["_" .. oq.encode_mime64_3digit(121705)] = tbl.size(dtp)*1000 + OQ_BUILD ;
end

function oq.reset_bn_custom_msg()
  if (oq.old_bncustommsg == nil) then
    return ;
  end
  BNSetCustomMessage = oq.old_bncustommsg ;
  oq.old_bncustommsg = nil ;
  BNSetCustomMessage( "" ) ; -- just clear it out completely (old msg was in 'oq.old_bn_msg')
  oq.old_bn_msg = nil ;
end

function oq.on_channel_roster_update(id)
  if (_oqgeneral_id ~= nil) and (_oqgeneral_id == id) then
    oq.n_connections() ;
  end
end

function oq.toggle_autoinspect( cb )
  if (cb:GetChecked()) then 
    OQ_data.ok2autoinspect = 1 ; 
  else 
    OQ_data.ok2autoinspect = 0 ; 
  end 
end

function oq.toggle_shout_kbs( cb )
  if (cb:GetChecked()) then 
    OQ_toon.shout_kbs = 1 ; 
    oq.ui:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") ;    
  else 
    OQ_toon.shout_kbs = 0 ; 
    if (OQ_toon.who_popped_lust == 0) and (OQ_toon.say_sapped == 0) and (OQ_toon.shout_kbs == 0) then
      oq.ui:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED") ;
    end
  end 
end

function oq.toggle_premade_ads( cb )
  if (cb:GetChecked()) then 
    OQ_data.show_premade_ads = 1 ; 
    _announcePremades = true ;
  else 
    OQ_data.show_premade_ads = 0 ; 
    _announcePremades = nil ;
  end 
end

function oq.toggle_contract_ads( cb )
  if (cb:GetChecked()) then 
    OQ_data.show_contract_ads = 1 ; 
  else 
    OQ_data.show_contract_ads = 0 ; 
  end 
end

function oq.toggle_say_sapped( cb )
  if (cb:GetChecked()) then 
    OQ_toon.say_sapped = 1 ; 
    oq.ui:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") ;    
  else 
    OQ_toon.say_sapped = 0 ; 
    if (OQ_toon.who_popped_lust == 0) and (OQ_toon.say_sapped == 0) and (OQ_toon.shout_kbs == 0) then
      oq.ui:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED") ;
    end
  end 
end

function oq.toggle_who_popped_lust( cb )
  if (cb:GetChecked()) then 
    OQ_toon.who_popped_lust = 1 ; 
    oq.ui:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") ;    
  else 
    OQ_toon.who_popped_lust = 0 ; 
    if (OQ_toon.who_popped_lust == 0) and (OQ_toon.say_sapped == 0) and (OQ_toon.shout_kbs == 0) then
      oq.ui:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED") ;
    end
  end 
end

function oq.toggle_premade_qualified(cb)
  if (cb:GetChecked()) then
    oq.premade_filter_qualified = 1 ;
  else
    oq.premade_filter_qualified = 0 ;
  end
  oq.reshuffle_premades() ;
end

function oq.toggle_enforce_levels( cb )
  if (cb:GetChecked()) then
    oq.raid.enforce_levels = 1 ;
  else
    oq.raid.enforce_levels = 0 ;
  end
end

function oq.toggle_auto_role( cb )
  if (cb:GetChecked()) then
    OQ_toon.auto_role = 1 ;
  else
    OQ_toon.auto_role = 0 ;
  end
end

function oq.toggle_shout_caps( cb )
  if (cb:GetChecked()) then
    OQ_toon.shout_caps = 1 ;
  else
    OQ_toon.shout_caps = 0 ;
  end
end

function oq.toggle_btag_submit( cb )
  if (cb:GetChecked()) then
    OQ_data.ok2submit_tag = 1 ;
    OQ_data.btag_submittal_tm = utc_time() ;
  else
    OQ_data.ok2submit_tag = 0 ;
  end
end

function oq.toggle_ragequits( cb ) 
  if (cb:GetChecked()) then 
    OQ_toon.shout_ragequits = 1 ; 
  else 
    OQ_toon.shout_ragequits = 0 ; 
  end
end

function oq.toggle_show_controlled( cb )
  if (cb:GetChecked()) then 
    OQ_data.show_controlled = 1 ; 
  else 
    OQ_data.show_controlled = 0 ; 
  end
  if (_bg_shortname ~= nil) and (oq._bg_checks[ _bg_shortname ] ~= nil) and (oq._bg_checks[ _bg_shortname ].show_controlled ~= nil) then
    oq._bg_checks[ _bg_shortname ].show_controlled( OQ_data.show_controlled ) ;
  end
end

function oq.toggle_autoaccept_mesh_request( cb )
  if (cb:GetChecked()) then 
    OQ_data.autoaccept_mesh_request = 1 ; 
  else 
    OQ_data.autoaccept_mesh_request = 0 ; 
  end
end

---------------------------------
-- General (local) functions --
---------------------------------
-- checks if a given value is in an array
-- returns true if it finds the value, false otherwise
local function checkEntry(t, val)
  for i, v in ipairs(t) do
    if v == val then
      return true
    end
  end
  return false
end

function oq.is_boss( cId )
  if (oq.BossID[cId]) then
    return true ;
  end
  return nil ;
end

function oq.on_combat_damage_inflicted(...)
  -- should already be populated in on_combat_log_event_unfiltered
  --  _arg = { ... } ;
  -- arg[15] == dmg
  -- arg[16] == overage
  if (_arg[16] == nil) or (_arg[16] <= 0) then
    -- if there is no overage dmg, then bail
    return ;
  end
  local pet_guid = UnitGUID("pet") ;
  if (pet_guid == nil) or (_arg[4] ~= pet_guid) then
    -- if i have no pet, or it's not my pet, then bail
    return ;
  end
  
  -- pet scored the killing blow  
  local id = tonumber(_arg[8]:sub( 6,10), 16) ;
  local is_bty_target, contract = oq.is_bounty_target(id) ;
  if (is_bty_target) then
    oq.timer_oneshot( 1.0, PlaySoundFile, "Sound/Doodad/WoW_MoP_Intro_SFX_Bell_wGong.OGG" ) ;
    if (contract.type == 1) then
      oq.log( true, OQ_LILSKULL_ICON .." ".. string.format( OQ.BOUNTY_TARGET, is_bty_target ) ) ;
    elseif (contract.type > 1) and (contract.type < 10) then
      oq.log( true, OQ_LILSKULL_ICON .." ".. OQ.DEATHMATCH_SCORE ) ;
    end
    oq.check_bounty_board( id ) ;
  end
end

-- killing blow
function oq.on_party_kill( ... ) 
-- should already be populated in on_combat_log_event_unfiltered
--  _arg = { ... } ;
  if (oq._instance_type and ((oq._instance_type == "party") or (oq._instance_type == "raid"))) then
    -- boss kills
    oq.on_unit_died( ... ) ;
  end

  -- pet never gets credit for a kill as the 'hideCaster' field is true for pets
  -- no way to detect pet kill of bounty target  
  -- i can determine the target died.. but don't know which pet killed it.  
  -- or which faction the pet belonged to
  --  local pet_guid = UnitGUID("pet") ;
  if (_arg[4]) and (_arg[4] == player_guid) and ((_arg[8]) and (_arg[8] ~= "")) then
    local id = tonumber(_arg[8]:sub( 6,10), 16) ;
    local is_bty_target, contract = oq.is_bounty_target(id) ;
    if (is_bty_target) then
      oq.check_bounty_board( id ) ;
      oq.timer_oneshot( 1.0, PlaySoundFile, "Sound/Doodad/WoW_MoP_Intro_SFX_Bell_wGong.OGG" ) ;
      if (contract.type == 1) then
        oq.log( true, OQ_LILSKULL_ICON .." ".. string.format( OQ.BOUNTY_TARGET, is_bty_target ) ) ;
      elseif (contract.type > 1) and (contract.type < 10) then
        oq.log( true, OQ_LILSKULL_ICON .." ".. OQ.DEATHMATCH_SCORE ) ;
      end
    end
  end

  if (oq._instance_type) and (oq._instance_type == "pvp") then
    local caster = _arg[5] ;
    local target = _arg[9] ;
    if (OQ_toon.shout_kbs == 1) and (_enemy ~= nil) and (target ~= nil) then
      if (caster == player_name) and (_enemy[target] ~= nil) then
        _nkbs = _nkbs + 1 ;
        print( OQ_SKULL_ICON .." killing blow: ".. target .."  (".. _nkbs .." so far)" ) ;
      end
    end
  end
end

-- unit died
function oq.on_unit_died( ... )
  -- should already be populated in on_combat_log_event_unfiltered
  --  _arg = { ... } ;
  -- destGUID  _arg[8]
  -- destName  _arg[9]
  
  -- check to see if a boss, report if leading an oQueue group
  local type = _arg[8]:sub( 5, 5) ;
  if (OQ._unit_type[type] == "npc") or (OQ._unit_type[type] == "vehicle") then -- some bosses are 'vehicles'?
    local id = tonumber(_arg[8]:sub( 6,10), 16) ;
    -- only reported by oQueue leaders
    if oq.is_boss( id ) and ((oq._last_boss_kill == nil) or (oq._last_boss_kill ~= id)) then
      oq.report_boss_kill( id, _arg[8] ) ;
    end
  end
end

function oq.get_group_level_range()
  local highest = UnitLevel("player") ;
  local lowest  = UnitLevel("player") ;
  local nMembers = GetNumGroupMembers() ;
  for i=1,nMembers-1 do
    if (IsInRaid()) then
      highest = max( highest, UnitLevel( "raid".. i )) ;
      lowest  = min( lowest , UnitLevel( "raid".. i )) ;
    else
      highest = max( highest, UnitLevel( "party".. i )) ;
      lowest  = min( lowest , UnitLevel( "party".. i )) ;
    end
  end
  return lowest, highest ;
end

function oq.report_boss_kill( id, guid )
--  local cls = UnitClassification( target ) ;
--  if (cls == "worldboss") then
--    return 0 ;
--  end
  local level = oq.get_boss_level( id ) ;
  local _, highest = oq.get_group_level_range() ;
  local name, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID = GetInstanceInfo() ;
  if (level >= MAX_PLAYER_LEVEL) or (highest < (level+2)) then
    -- good kill, report
    if (oq._instance_header == nil) then
      local mapid = GetCurrentMapAreaID() ;
      oq._instance_header = oq.encode_mime64_2digit( mapid ) .."".. 
                            oq.encode_mime64_6digit( oq._instance_tm ) ;                          
    end
    local pts = 0 ;
    if (OQ._difficulty[difficultyID]) then
      pts = OQ._difficulty[difficultyID].n ;
    end
    -- now record for keeper
    -- note: some instances can change their difficulty after the start.  
    --       keep difficulty with boss kill info
    OQ_data._dkp       = (OQ_data._dkp or 0) + pts ; -- member dkp
    oq._instance_pts   = (oq._instance_pts or 0) + pts ;
    oq._last_boss_kill = id ;
    if (pts > 0) then
      print( OQ_LILSKULL_ICON .." boss killed (pts: ".. pts .."  total: ".. tostring(oq._instance_pts or 0) ..")" ) ;
    end
    
    if (pts == 0) or (not oq.iam_raid_leader()) or (oq.iam_alone()) then
      return pts ;
    end
    
    local leader_stats = OQ_data.leader["pve.5man"] ;
    if (IsInRaid()) then
      leader_stats = OQ_data.leader["pve.raid"] ;
    elseif (OQ._difficulty[difficultyID].desc == "challenge mode") then
      leader_stats = OQ_data.leader["pve.challenge"] ;
    elseif (OQ._difficulty[difficultyID].desc == "scenario") or (OQ._difficulty[difficultyID].desc == "scenario (heroic)") then
      leader_stats = OQ_data.leader["pve.scenario"] ;
    end
    leader_stats.nBosses = leader_stats.nBosses + 1 ;
    leader_stats.pts     = leader_stats.pts + pts ;
    OQ_data.leader_dkp   = (OQ_data.leader_dkp or 0) + pts ;
    
    local submit_token = "S".. oq.token_gen() ;
    oq.token_push( submit_token ) ;

    -- TODO: make sure to get the receipt for the transaction
    --
    local msg = OQSK_HEADER ..",".. 
                OQSK_VER ..","..
                "W1,"..
                "bk,".. -- bk == boss-kill
                tostring(player_name) ..",".. 
                tostring(oq.realm_cooked(player_realm)) ..",".. 
                tostring(player_faction) ..",".. 
                tostring(player_realid) ..","..
                submit_token ..","..
                oq._instance_header ..",".. 
                oq.encode_mime64_2digit( lowest ) .."".. oq.encode_mime64_2digit( highest ) ..",".. 
                guid ..",".. 
                oq.encode_mime64_1digit( difficultyID ) ..""..
                oq.encode_mime64_3digit( id ) .."".. 
                oq.encode_mime64_3digit( utc_time() - oq._instance_tm ) ;
    oq.send_to_scorekeeper( msg ) ;
    return pts ;
  end
  return 0 ;
end

-- say sapped
function oq.on_spell_aura_applied( ... ) 
-- should already be populated in on_combat_log_event_unfiltered
--  _arg = { ... } ;
  local spellId = _arg[12] ;
  local target = _arg[9] ;
  local caster = _arg[5] ;
  
  if (OQ_toon.say_sapped == 1) then
    if ((spellId == 6770)
    and (target == player_name)
    and (_arg[2] == "SPELL_AURA_APPLIED" or _arg[2] == "SPELL_AURA_REFRESH"))
    then
      SendChatMessage(OQ.SAPPED, "SAY")
      DEFAULT_CHAT_FRAME:AddMessage("Sapped by: "..(caster or "(unknown)"))
    end
  end
end

-- who popped lust?
function oq.on_spell_cast_success( ... )
-- should already be populated in on_combat_log_event_unfiltered
--  _arg = { ... } ;

  local spellId = _arg[12] ;
  local caster  = _arg[5] ;
  if (OQ_toon.who_popped_lust == 1) and (_inside_bg) and (caster ~= nil) then
    -- _flags holding same faction player list by player name
    -- 
    if ((_arg[2] == "SPELL_CAST_SUCCESS") and (oq.WhoPoppedList_Ids[ spellId ] ~= nil) and (_flags ~= nil) and (_flags[caster] ~= nil)) then
      _last_lust = OQ_SKULL_ICON .." ".. (caster or "(unknown)") .." popped ".. oq.WhoPoppedList_Ids[ spellId ] ;
      print( _last_lust ) ;
    end
  end
end

function oq.attr( attr, s )
  return "|cFF".. attr .."".. tostring(s) .."|r" ;
end

function oq.on_combat_log_event_unfiltered(...)
  -- first 2 args have been removed by the onEvent handler
  tbl.fill( _arg, ... ) ;  
  
  -- _arg[2] == event id
  -- _arg[3] == hideCaster
  -- _arg[4] == guid of caster
  --
  if (_arg[3] ~= true) and (oq.combat_handler[ _arg[2] ] ~= nil) then
    oq.combat_handler[ _arg[2] ]( ... ) ;
  elseif (_arg[2]:find("_DAMAGE")) then
    oq.on_combat_damage_inflicted( ... ) ;
  elseif (_inside_bg) then
    local h = oq.get_hostiles() ;
    if (h) and (_arg[5]) and (h[_arg[5]]) then
--      h[_arg[5]].tm = _arg[1] ; -- not sure timezone.  not GetTime
      h[_arg[5]].tm = GetTime() ;
    end
--  else
-- in the world, could be useful to display # friendly and unfriendly in the area
--    UnitIsEnemy( "player", _arg[5] ) ;
  end
end

function oq.on_bg_neutral_event( event, msg )
  if (_bg_shortname == nil) then
    -- not ready yet
    oq.get_zone_info() ;
  end
  if (event) and (event:find(OQ.BG_BEGINS) or event:find(OQ.BG_BEGUN)) then
    if (_bg_shortname ~= nil) and (oq._bg_checks[ _bg_shortname ] ~= nil) then
      oq._bg_checks[ _bg_shortname ].start() ;
    end
  end
end

function oq.on_group_roster_update()
end

-- triggered by bn friends going online/offline
-- wait a half second to allow the data to populate before pulling
--
function oq.timer_bn_check_online()
  oq.timer_oneshot( 0.5, oq.bn_check_online ) ;
end

function oq.register_events() 
--  oq.create_timer() ;
  oq.msg_handler = tbl.new() ;
  oq.msg_handler[ "ADDON_LOADED"                  ] = oq.on_addon_loaded ;
  oq.msg_handler[ "BN_CONNECTED"                  ] = oq.timer_bn_check_online ;
  oq.msg_handler[ "BN_FRIEND_ACCOUNT_OFFLINE"     ] = oq.timer_bn_check_online ;
  oq.msg_handler[ "BN_FRIEND_ACCOUNT_ONLINE"      ] = oq.timer_bn_check_online ;
  oq.msg_handler[ "BN_FRIEND_INVITE_ADDED"        ] = oq.on_bn_friend_invite_added ;
  oq.msg_handler[ "BN_SELF_ONLINE"                ] = oq.timer_bn_check_online ;
  oq.msg_handler[ "CHAT_MSG_ADDON"                ] = oq.on_addon_event ;
  oq.msg_handler[ "CHAT_MSG_BG_SYSTEM_NEUTRAL"    ] = oq.on_bg_neutral_event ;
  oq.msg_handler[ "CHAT_MSG_BN_WHISPER"           ] = oq.on_bn_event ;
  oq.msg_handler[ "CHAT_MSG_CHANNEL"              ] = oq.on_channel_msg ;
  oq.msg_handler[ "CHAT_MSG_MONSTER_YELL"         ] = oq.on_monster_yell ;
  oq.msg_handler[ "CHAT_MSG_PARTY"                ] = oq.on_party_event ;
  oq.msg_handler[ "CHAT_MSG_PARTY_LEADER"         ] = oq.on_party_event ;
  oq.msg_handler[ "CHAT_MSG_RAID"                 ] = oq.on_party_event ;
  oq.msg_handler[ "CHAT_MSG_RAID_LEADER"          ] = oq.on_party_event ;
  oq.msg_handler[ "LFG_COMPLETION_REWARD"         ] = oq.on_lfg_completion_reward ;
  oq.msg_handler[ "PLAYER_EQUIPMENT_CHANGED"      ] = oq.on_equipment_changed ;
  oq.msg_handler[ "INSPECT_READY"                 ] = oq.on_inspect_ready ;
  oq.msg_handler[ "SOCKET_INFO_UPDATE"            ] = oq.on_equipment_changed ;
  oq.msg_handler[ "PARTY_INVITE_REQUEST"          ] = oq.on_party_invite_request ;
  oq.msg_handler[ "PARTY_MEMBER_DISABLE"          ] = oq.on_party_member_disable ;
  oq.msg_handler[ "GROUP_ROSTER_UPDATE"           ] = oq.on_party_members_changed ;
--  oq.msg_handler[ "PARTY_MEMBERS_CHANGED"         ] = oq.on_party_members_changed ;
--  oq.msg_handler[ "PLAYER_ENTERING_BATTLEGROUND"  ] = oq.bg_start ;
  oq.msg_handler[ "PLAYER_DEAD"                   ] = oq.player_died ;
  oq.msg_handler[ "PLAYER_LEVEL_UP"               ] = oq.player_new_level ;
  oq.msg_handler[ "PLAYER_LOGOUT"                 ] = oq.on_logout ;
  oq.msg_handler[ "PLAYER_ENTERING_WORLD"         ] = oq.on_player_enter_world ;
  oq.msg_handler[ "PLAYER_TARGET_CHANGED"         ] = oq.on_player_target_change ;
  oq.msg_handler[ "PVP_RATED_STATS_UPDATE"        ] = oq.on_player_mmr_change ;
  
  oq.msg_handler[ "PVPQUEUE_ANYWHERE_SHOW"        ] = oq.on_bg_event ;
  oq.msg_handler[ "ROLE_CHANGED_INFORM"           ] = oq.check_my_role ;
-- too many messages for what i need.  changed to a check every 3-5 seconds via check_stats
--  oq.msg_handler[ "UNIT_AURA"                     ] = oq.check_for_deserter ;
  oq.msg_handler[ "UPDATE_BATTLEFIELD_SCORE"      ] = oq.on_bg_score_update ;
  oq.msg_handler[ "UPDATE_BATTLEFIELD_STATUS"     ] = oq.on_bg_status_update ;
  oq.msg_handler[ "WORLD_MAP_UPDATE"              ] = oq.on_world_map_change ;
  oq.msg_handler[ "CHANNEL_ROSTER_UPDATE"         ] = oq.on_channel_roster_update ;
  oq.msg_handler[ "COMBAT_LOG_EVENT_UNFILTERED"   ] = oq.on_combat_log_event_unfiltered ;
  
  oq.combat_handler = tbl.new() ;
  oq.combat_handler[ "UNIT_DIED"          ] = oq.on_unit_died ;
  oq.combat_handler[ "UNIT_DESTROYED"     ] = oq.on_unit_died ;
  oq.combat_handler[ "PARTY_KILL"         ] = oq.on_party_kill ;
  oq.combat_handler[ "SPELL_AURA_APPLIED" ] = oq.on_spell_aura_applied ;
  oq.combat_handler[ "SPELL_AURA_REFRESH" ] = oq.on_spell_aura_applied ;
  oq.combat_handler[ "SPELL_CAST_SUCCESS" ] = oq.on_spell_cast_success ;
  
  oq.ui:SetScript( "OnShow", function( self ) oq.onShow( self ) ; end ) ;
  oq.ui.closepb:SetScript("OnHide",function(self) oq.onHide( self ) ; end) ;

  -- hook the world map show method so we can bring the OQ UI back up if it was forced-hidden  
  hooksecurefunc(WorldMapFrame, 'Show', function(self) oq.WorldMap_show() ; end) ;
  
  ------------------------------------------------------------------------
  --  register for events
  ------------------------------------------------------------------------
  oq.ui:RegisterEvent("ADDON_LOADED") ;
  oq.ui:RegisterEvent("PVPQUEUE_ANYWHERE_SHOW") ;
  oq.ui:RegisterEvent("BN_CONNECTED") ;
  oq.ui:RegisterEvent("BN_SELF_ONLINE") ;
  oq.ui:RegisterEvent("BN_FRIEND_ACCOUNT_OFFLINE") ;
  oq.ui:RegisterEvent("BN_FRIEND_ACCOUNT_ONLINE") ;
  oq.ui:RegisterEvent("BN_FRIEND_INVITE_ADDED") ;
  oq.ui:RegisterEvent("CHANNEL_ROSTER_UPDATE") ;
  oq.ui:RegisterEvent("CHAT_MSG_ADDON") ;
  oq.ui:RegisterEvent("CHAT_MSG_CHANNEL") ;
  oq.ui:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL") ;
  oq.ui:RegisterEvent("CHAT_MSG_BN_WHISPER") ;
  oq.ui:RegisterEvent("CHAT_MSG_MONSTER_YELL") ;
  oq.ui:RegisterEvent("CHAT_MSG_PARTY") ;
  oq.ui:RegisterEvent("CHAT_MSG_PARTY_LEADER") ;
  oq.ui:RegisterEvent("CLOSE_WORLD_MAP") ;
  oq.ui:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED") ;
--  oq.ui:RegisterEvent("COMBAT_LOG_EVENT") ;
  oq.ui:RegisterEvent("LFG_COMPLETION_REWARD") ;
  oq.ui:RegisterEvent("INSPECT_READY") ;
  oq.ui:RegisterEvent("PARTY_INVITE_REQUEST") ;
  oq.ui:RegisterEvent("PARTY_MEMBER_DISABLE") ;
  oq.ui:RegisterEvent("GROUP_ROSTER_UPDATE") ;
--  oq.ui:RegisterEvent("PARTY_MEMBERS_CHANGED") ;
  oq.ui:RegisterEvent("PLAYER_DEAD") ;
  oq.ui:RegisterEvent("PLAYER_EQUIPMENT_CHANGED") ;
  oq.ui:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND") ;
  oq.ui:RegisterEvent("PLAYER_ENTERING_WORLD") ;
  oq.ui:RegisterEvent("PLAYER_LEVEL_UP") ;
  oq.ui:RegisterEvent("PLAYER_LOGOUT") ;
  oq.ui:RegisterEvent("PLAYER_TARGET_CHANGED") ;
  oq.ui:RegisterEvent("PVP_RATED_STATS_UPDATE") ;
  oq.ui:RegisterEvent("ROLE_CHANGED_INFORM") ;
  oq.ui:RegisterEvent("SOCKET_INFO_UPDATE") ;
  oq.ui:RegisterEvent("UNIT_AURA") ;
  oq.ui:RegisterEvent("UPDATE_BATTLEFIELD_SCORE") ;
  oq.ui:RegisterEvent("UPDATE_BATTLEFIELD_STATUS") ;
  oq.ui:RegisterEvent("WORLD_MAP_UPDATE") ;
  oq.ui:SetScript("OnEvent", oq.on_event ) ;
  if (RegisterAddonMessagePrefix( "OQ" ) ~= true) then
    print( "Error:  unable to register addon prefix: OQ" ) ;
  end
end

function oq.init_bnet_friends()
  OQ_data.bn_friends = tbl.new() ;
  if ((OQ_data ~= nil) and (OQ_data.btag_cache == nil)) then
    OQ_data.btag_cache = tbl.new() ;
  end
end

function oq.pass_bg_leader()
  if (not _inside_bg) then
    return ;
  end
  if (oq.raid.raid_token == nil) then
    return ;
  end
  if (not oq.IsRaidLeader()) then
    return ;
  end
  if (oq.iam_raid_leader()) then
    return ;
  end
  
  -- i'm in a BG, have BG leader, and should pass to OQ leader
  --
  local n = oq.raid.leader ;
  if (oq.raid.leader_realm ~= player_realm) then
    n = n .."-".. oq.raid.leader_realm ;
  end
  if (not UnitInRaid(n)) then
    return ;
  end
  if (UnitExists( n )) then
    print( "OQ: transferred BG leader to ".. n ) ;
    PromoteToLeader( n ) ;
  end
end

function oq.player_died()
  oq.fog_clear() ;
end

function oq.player_new_level()
  player_level = UnitLevel("player") ;
  if (my_group ~= 0) and (my_slot ~= 0) then
    oq.raid.group[my_group].member[my_slot].level = player_level ;
  end
  
  local minlevel, maxlevel = oq.get_player_level_range() ;
  if (minlevel == 0) then
    txt = "unavailable" ;
  elseif (minlevel == 90) then
    txt = "90" ;
  else
    txt = minlevel .." - ".. maxlevel ;
  end
  oq.tab3_level_range = txt ;
end

function oq.init_locals()
  oq.nwaitlist = 0 ;
  oq.nlistings = 0 ;
  oq._sktime_last_tm = 0 ;
  oq._sktime_last_dt = 0 ;
  oq.old_raids = tbl.new() ;
  oq.send_q = tbl.new() ;
  oq.premades  = tbl.new() ;
  oq._error_ignore_tm = 0 ;
  oq._next_gc = 0 ;
  oq._boss_level = tbl.new() ;
  oq._boss_guids = tbl.new() ;
  if (OQ_toon.player_wallet == nil) then
    OQ_toon.player_wallet  = tbl.new() ;
  end
  if (OQ_data._history == nil) then  
    OQ_data._history = tbl.new() ;
  end
  oq._hyperlinks = tbl.new() ;
  oq._hyperlinks["btag"    ] = oq.onHyperlink_btag ;
  oq._hyperlinks["contract"] = oq.onHyperlink_contract ;
  oq._hyperlinks["log"     ] = oq.onHyperlink_log ;
  oq._hyperlinks["oqueue"  ] = oq.onHyperlink_oqueue ;
  
  oq.populate_npc_table() ;
end

function oq.firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

function oq.GetRealmName() 
  local name = GetRealmName() ;
  if (OQ.SHORT_BGROUPS[ name ] ~= nil) then
    -- normal realm name
    return name ;
  end
  name = oq.firstToUpper(name) ;
  if (OQ.SHORT_BGROUPS[ name ] ~= nil) then
    -- normal realm name
    return name ;
  end
  
  -- special case
  if (OQ.REALMNAMES_SPECIAL[ name ] ~= nil) then
    return OQ.REALMNAMES_SPECIAL[ name ] ;
  end
  if (OQ.REALMNAMES_SPECIAL[ strlower( name ) ] ~= nil) then
    return OQ.REALMNAMES_SPECIAL[ strlower( name ) ] ;
  end
  return nil ;
end

function oq.btag_hyperlink_action( btag, action )
  if (btag == nil) or (btag == "") or (btag == "nil") then
    return ;
  end
  if (action == "upvote") then
    oq.karma_vote_btag( btag, 1 ) ;
  elseif (action == "dnvote") then
    oq.karma_vote_btag( btag, -1 ) ;
  elseif (action == "ban") then
    oq.ban_user( btag ) ;
  elseif (action == "friend") then
    local pid, is_online = oq.is_bnfriend(btag) ;
    if (pid ~= nil) then
      print( OQ_LILTRIANGLE_ICON .." ".. string.format( OQ.ALREADY_FRIENDED, btag )) ;
    else
      BNSendFriendInvite( btag, string.format( OQ.FRIEND_REQUEST, player_name, player_realm )) ;
    end
  end
end

OQ.btag_hyperlink = { { text = OQ.TT_KARMA ..":  ".. OQ.karma_up .."  ".. OQ.UP  , action = "upvote" },
                      { text = OQ.TT_KARMA ..":  ".. OQ.karma_dn .."  ".. OQ.DOWN, action = "dnvote" },
                      { text = OQ.DD_BAN           , action = "ban"    },
                      { text = OQ.TT_FRIEND_REQUEST, action = "friend" },
                    } ;

function oq.onHyperlink_btag( link, text, button )
  local n1 = link:find( ":" ) or 0 ;
  local n2 = link:find( ":", n1+1 ) or -1 ;
  local token = link:sub( n1 + 1, n2 - 1 ) ;
  local tm = tonumber(link:sub( n2+1, -1 )) or 0 ;
  local now = utc_time() ;
  
  if (token == nil) or (token == "nil") or (token:find("#") == nil) then
    return ;
  end
  if (token == player_realid) then
    -- can't click yourself
    return ;
  end
  if ((now - tm) > 2*60*60) then
    -- battletag hyperlinks are only good for 2 hours
    return ;
  end
  -- popup menu on the battle-tag
  oq.menu_create():Raise() ; 
  
  for i,v in pairs(OQ.btag_hyperlink) do
    oq.menu_add( v.text, token, v.action, nil, 
                 function(self,btag,action) 
                   oq.btag_hyperlink_action( btag, action ) ;
                   return true ; 
                 end 
               ) ;
  end  
  oq.menu_show_at_cursor( 150, -20, 0 ) ;  
end

function oq.onHyperlink_log( link, text, button )
  local n = link:find( ":" ) or 0 ;
  local token = link:sub( n + 1, -1 ) ;
  if (token == nil) then
    return ;
  end
--print( "log hyperlink: [".. tostring(token) .."] L[".. tostring(link) .."]" ) ; 
end

function oq.onHyperlink_contract( link, text, button )
  local n = link:find( ":" ) or 0 ;
  local token = link:sub( n+1, -1 ) ;
  if (token == nil) then
    return ;
  end
  if (oq._bounty_board:IsVisible()) and 
     (oq._bounty_board._ndx ~= nil) and 
     (oq.bounties[oq._bounty_board._ndx] ~= nil) and
     (tostring(oq.bounties[oq._bounty_board._ndx].id) == token) then
    oq.toggle_bounty_board() ; -- toggle it off
    return ;
  end
  if (not oq._bounty_board:IsVisible()) then
    oq.toggle_bounty_board() ; -- toggle it on
  end
  oq._bounty_board:goto_contract( token ) ;
end

OQ.premade_hyperlink = { { text = OQ.WAITLIST   , action = "waitlist" },
                         { text = "---"         , action = ""         },
                         { text = OQ.DD_BAN     , action = "ban"      },
                    } ;
function oq.onHyperlink_oqueue( link, text, button )
  local token = link:sub( link:find( ":" ) +1, -1 ) ;
  if (token == nil) then
    return ;
  end
  -- popup menu on the battle-tag
  oq.menu_create():Raise() ; 
  
  for i,v in pairs(OQ.premade_hyperlink) do
    oq.menu_add( v.text, token, v.action, nil, 
                 function(self,token,action) 
                   if (action == "waitlist") then
                     oq.check_and_send_request( token ) ;
                   elseif (action == "ban") then
                     local premade = oq.premades[ token ] ;
                     if (premade == nil) and (oq.old_raids ~= nil) and (oq.old_raids[token] ~= nil) then
                       -- trolls may have disbanded, check if its on the 'old' list
                       premade = { leader_rid = oq.old_raids[token].btag } ;
                     end
                     if (premade ~= nil) then
                       local dialog = StaticPopup_Show("OQ_BanUser", premade.leader_rid) ;
                       if (dialog ~= nil) then
                         dialog.data2 = { flag = 4, btag = premade.leader_rid, raid_tok = token } ;
                       end                                                            
                     end
                   end
                   return true ; 
                 end 
               ) ;
  end  
  oq.menu_show_at_cursor( 150, -20, 0 ) ;  
end

function oq.onHyperlinkClick( self, link, text, button )
  local n = link:find( ":" ) or 0 ;
  local service = link:sub( 1, n - 1 ) ;
  if (oq._hyperlinks[service]) then
    oq._hyperlinks[service]( link, text, button ) ;
  else
-- print( "unknown hyperlink type [".. tostring(service) .."] L[".. tostring(link) .."]" ) ;  
    if (oq.old_hyperlink_handler) then
      oq.old_hyperlink_handler( self, link, text, button ) ;
    end
  end
end

function oq.get_player_faction()
  if (oq._player_faction) then
    return oq._player_faction ;
  end
  player_faction   = "H" ;
  if (strlower(select( 1, UnitFactionGroup("player"))) == "alliance") then
    player_faction = "A" ;
  end
  oq._player_faction = player_faction ;
  return player_faction ;
end

function oq.on_equipment_changed()
  oq.paperdoll_update( PaperDollFrame, "player" ) ;
end

function oq.on_inspect_ready()
  if (UnitIsPlayer("target") and UnitIsFriend("player", "target")) then
    -- update every 1/2 second for 2 seconds to insure data comes in (caching from server)
    oq.paperdoll_clear( InspectFrame ) ;
    for i=1,3 do
      oq.timer_oneshot( i * 0.75, oq.paperdoll_update, InspectFrame, "target" ) ;
    end
  end
end

local function printable( ilink )
   return gsub(ilink, "\124", "\124\124");
end

local S_ITEM_LEVEL = ITEM_LEVEL:gsub( "%%d", "(%%d+)" )
function oq.get_actual_ilevel( itemLink )
   -- Pass the item link to the tooltip:
  local scantip = GameTooltip ;
  scantip:SetOwner( UIParent, "ANCHOR_NONE" ) ;
  scantip:SetHyperlink( itemLink ) ;
  scantip:Show() ;
   
  -- Scan the tooltip:
  local ilevel = 0 ;
  local enchant_text = "" ;
  for i = 2, scantip:NumLines() do -- Line 1 is always the name so you can skip it.
    local text = _G[ scantip:GetName() .."TextLeft"..i]:GetText() ;
    if text and text ~= "" then
      local n = tonumber( text:match(S_ITEM_LEVEL) ) ;
      if n then
        ilevel = n ;
      elseif (text:find( OQ.ENCHANTED )) then
        enchant_text = text ;
      end
    end
  end
  scantip:Hide() ;
  return ilevel, enchant_text ;
end

local __enchantable = { [  1 ] = nil , -- head
                        [  2 ] = nil , -- neck
                        [  3 ] = true, -- shoulder
                        [ 15 ] = true, -- back
                        [  5 ] = true, -- chest
                        [  9 ] = true, -- wrist
                        [ 10 ] = true, -- hands
                        [  6 ] = nil , -- waist
                        [  7 ] = true, -- legs
                        [  8 ] = true, -- feet
                        [ 11 ] = nil , -- finger0
                        [ 12 ] = nil , -- finger1
                        [ 13 ] = nil , -- trinket0
                        [ 14 ] = nil , -- trinket1
                        [ 16 ] = true, -- main hand
                        [ 17 ] = true, -- off hand
                      } ;

local __profession_enchantable = { [  1 ] = nil, -- head
                                   [  2 ] = nil, -- neck
                                   [  3 ] = nil, -- shoulder
                                   [ 15 ] = nil, -- back
                                   [  5 ] = nil, -- chest
                                   [  9 ] = nil, -- wrist
                                   [ 10 ] = "ENG", -- hands
                                   [  6 ] = nil, -- waist
                                   [  7 ] = nil, -- legs
                                   [  8 ] = "ENG", -- feet
                                   [ 11 ] = "ENC", -- finger0
                                   [ 12 ] = "ENC", -- finger1
                                   [ 13 ] = nil, -- trinket0
                                   [ 14 ] = nil, -- trinket1
                                 } ;

local gem_colors = {} ; -- to avoid uncleaned up table (very annoying lua problem)
local __gems = {} ;
local __info = {} ;
local __ilink_info = {} ;

function oq.nGems( target, slot )
  local ilink      = GetInventoryItemLink( target, slot ) ;
  if (ilink == nil) then
    return 0, nil, nil, nil, nil ;
  end
  local i = 0 ;
  tbl.clear( __ilink_info ) ;
  for v in string.gmatch( ilink, "[^:]+" ) do
    i = i + 1 ;
    __ilink_info[i] = v ;
  end
  
  local item_id    = __ilink_info[2] ;
  local enchant_id = __ilink_info[3] or 0 ;
  local enchant_text = "" ;
  if (item_id == nil) then
    return 0, nil, nil, nil, nil ;
  end
  gem_colors[1] = nil ;
  gem_colors[2] = nil ;
  gem_colors[3] = nil ;
  gem_colors[4] = nil ;
  __gems[1]     = nil ;
  __gems[2]     = nil ;
  __gems[3]     = nil ;
  __gems[4]     = nil ;
  
  tbl.fill( __info, GetItemInfo( item_id ) ) ;    
  
  local name  = __info[1] ;
  local iid   = __info[4] ;
  local ibare = __info[2] ; 
  local line  = nil ;
  local ilink = GetInventoryItemLink( target, slot ) ;
  local ievel = 0 ;
  if (ibare == nil) then
    return 0, nil, nil, nil, nil, nil, nil ;
  end
--  local g = scantip ;
  local g = GameTooltip ;
  g:SetOwner( UIParent, "ANCHOR_NONE" ) ;
  g:SetHyperlink( ibare ) ;
  g:Show() ;
  local ngems = 0 ;
  for i=1,g:NumLines() do 
    local mytext=_G[ g:GetName() .."TextLeft"..i] ;
    if (mytext ~= nil) then
      line = mytext:GetText() ;
      if (line ~= nil) and (line:find( OQ.SOCKET )) then
        ngems = ngems + 1 ;
        gem_colors[ngems] = line:sub( 1, line:find( OQ.SOCKET ) - 1) ;
      elseif (line ~= nil) and (line:find( OQ.SHA_TOUCHED )) and (line:find("\"".. OQ.SHA_TOUCHED .."\"") == nil) then
        ngems = ngems + 1 ;
        gem_colors[ngems] = "sha" ;
      end
    end
  end
  g:Hide() ;
  _, __gems[1] = GetItemGem( ilink or ibare, 1 ) ;
  _, __gems[2] = GetItemGem( ilink or ibare, 2 ) ;
  _, __gems[3] = GetItemGem( ilink or ibare, 3 ) ;
  _, __gems[4] = GetItemGem( ilink or ibare, 4 ) ;
  if (__gems[ngems+1] ~= nil) then
    ngems = ngems + 1 ;
  end

  -- get real ilevels
  ilevel, enchant_text = oq.get_actual_ilevel( ilink ) ;
  info = nil ;
  return ngems, __gems[1], __gems[2], __gems[3], __gems[4], 
                gem_colors[1], gem_colors[2], gem_colors[3], gem_colors[4], 
                enchant_id, enchant_text,
                ilevel ;
end

OQ.EMPTY_GEMSLOT =   "|TInterface\\TARGETINGFRAME\\UI-PhasingIcon.blp:16|t" ;
function oq.gem_string( ngems, gem1, gem2, gem3 )
  local gstr = "" ;
  if (ngems >= 1) then
    if (gem1) then
      gstr = gstr .."|T".. select( 10, GetItemInfo(gem1)) ..".blp:14|t " ;
    else
      gstr = gstr .."".. OQ.EMPTY_GEMSLOT ;
    end
  end   
  if (ngems >= 2) then
    if (gem2) then
      gstr = gstr .."|T".. select( 10, GetItemInfo(gem2)) ..".blp:14|t " ;
    else
      gstr = gstr .."".. OQ.EMPTY_GEMSLOT ;
    end
  end   
  if (ngems >= 3) then
    if (gem3) then
      gstr = gstr .."|T".. select( 10, GetItemInfo(gem3)) ..".blp:14|t" ;
    else
      gstr = gstr .."".. OQ.EMPTY_GEMSLOT ;
    end
  end   
  return gstr ;
end

function oq.paperdoll_overlay( frame, is_on )
  for i,p in pairs( frame._ilevels ) do
    if (is_on == 1) then
      p:Show() ;
    else
      p:Hide() ;
    end
  end
  if (frame:GetParent() == InspectFrame) and (is_on == 0) then
    frame.avg_ilevel:Hide() ;
  elseif (frame:GetParent() == InspectFrame) and (is_on == 1) then
    frame.avg_ilevel:Show() ;
  end
  if (is_on == 1) then
    frame.paperdoll_update( frame:GetParent(), frame._target ) ;
  end
end

OQ.EMPTY_GEMSLOTS = { ["Meta"]    = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Prismatic",
                      ["Red"]     = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Red",
                      ["Yellow"]  = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Yellow",
                      ["Blue"]    = "INTERFACE/ITEMSOCKETINGFRAME/UI-EmptySocket-Blue",
                      ["sha"]     = "INTERFACE/ITEMSOCKETINGFRAME/UI-EMPTYSOCKET",
                      ["unk"]     = "Interface\\TARGETINGFRAME\\UI-PhasingIcon.blp",
                    } ;

function oq.paperdoll_set_gem( p, n, ilink, color )
  if (n < 1) or (n > 5) then
    return ;
  end
  p.gem[n]._ilink = ilink ;
  if (p.gem[n]._ilink == nil) then
    if (color) then
      p.gem[n].texture:SetTexture( OQ.EMPTY_GEMSLOTS[ color ] ) ;
    else
      p.gem[n].texture:SetTexture( OQ.EMPTY_GEMSLOTS[ "unk" ] ) ;
    end
  else
    p.gem[n].texture:SetTexture( select( 10, GetItemInfo(p.gem[n]._ilink)) ) ;
  end
  p.gem[n].texture:SetAlpha( 1.0 ) ;
  p.gem[n].texture:Show() ;
  p.gem[n]:Show() ;
end

OQ.ENCHANT_SLOT  =  { [0] = "INTERFACE/COMMON/Indicator-Gray",
                      [1] = "INTERFACE/ICONS/INV_Jewelry_Talisman_08",
                    } ;

function oq.paperdoll_set_enchant( p, n, e_id, enchant_text )
  e_id = tonumber(e_id or 0) or 0 ;
  if (e_id == 0) and ((enchant_text == nil) or (enchant_text == "")) and (__enchantable[ p._slot ] == nil) then
    return 0 ;
  end
  p.gem[n]._ilink = enchant_text or "" ;
  if (e_id == 0) then
    p.gem[n].texture:SetTexture( OQ.ENCHANT_SLOT[1] ) ;
    p.gem[n].texture:SetAlpha( 0.4 ) ;
  else
    p.gem[n].texture:SetTexture( OQ.ENCHANT_SLOT[1] ) ;
    p.gem[n].texture:SetAlpha( 1.0 ) ;
  end
  p.gem[n].texture:Show() ;
  p.gem[n]:Show() ;
  return 1 ;
end

function oq.paperdoll_update( frame, target )
  if (not frame:IsVisible()) or (OQ_data._paperdoll_show_ilevel == 0) then
    return ;
  end
  local f = frame._ilevelcb ;
  local n = 0 ;
  local e = 0 ;
  local e_id = 0 ;
  local g1, g2, g3, g4 ;
  local c1, c2, c3, c4 ;
  local ilevel = 0 ;
  local sum = 0 ;
  local count = 0 ;
  local enchant_text = "" ;
  for i,p in pairs( f._ilevels ) do
    local ilink = GetInventoryItemLink( target, i ) ;
    local iid   = select( 2, strsplit(":", ilink or "" )) ;
    p._ilink = ilink ;
    n, g1, g2, g3, g4, c1, c2, c3, c4, e_id, enchant_text, ilevel = oq.nGems( target, i ) ;
    if (iid ~= nil) or ((iid == nil) and (i ~= 17)) then -- don't count the offhand if empty
      if (ilevel ~= nil) then
        sum = (sum or 0) + ilevel ;
      end
      count = count + 1 ;
    end
    if (iid ~= nil) and (iid ~= 0) then
      if (ilevel == nil) or (ilevel == 0) then
        ilevel = select( 4, GetItemInfo(iid)) ;
      end
      if (ilevel ~= nil) then
        p.ilevel:SetText( tostring(ilevel) ) ;
      else
        p.ilevel:SetText("--") ;
      end
    else
      p.ilevel:SetText("") ;
    end
    for k=1,5 do
      p.gem[k].texture:SetTexture(nil) ;
      p.gem[k]:Hide() ;
    end
    if (p.is_left and (iid ~= nil)) then
      e = oq.paperdoll_set_enchant( p, 1, e_id, enchant_text ) ; 
      if (n >= 1) then oq.paperdoll_set_gem( p, 1 + e, g1, c1 ) ; end
      if (n >= 2) then oq.paperdoll_set_gem( p, 2 + e, g2, c2 ) ; end
      if (n >= 3) then oq.paperdoll_set_gem( p, 3 + e, g3, c3 ) ; end
      if (n >= 4) then oq.paperdoll_set_gem( p, 4 + e, g4, c4 ) ; end
    elseif (iid ~= nil) then
      e = oq.paperdoll_set_enchant( p, (5-n), e_id, enchant_text ) ; 
      if (n >= 1) then oq.paperdoll_set_gem( p, 1 + (5-n), g1, c1 ) ; end
      if (n >= 2) then oq.paperdoll_set_gem( p, 2 + (5-n), g2, c2 ) ; end
      if (n >= 3) then oq.paperdoll_set_gem( p, 3 + (5-n), g3, c3 ) ; end
      if (n >= 4) then oq.paperdoll_set_gem( p, 4 + (5-n), g4, c4 ) ; end
    end
  end
  if (count > 0) and (frame == InspectFrame) then 
    f.avg_ilevel:SetText( string.format( OQ.AVG_ILEVEL, floor(sum / count)) ) ;
  end
end

function oq.paperdoll_slot_tooltip( self, ok2show )
  local g = GameTooltip ;
  if (not ok2show) then
    g:Hide() ;
    return ;
  end
  if (self._ilink and (self._ilink ~= "")) then
    g:SetOwner( self ) ;
    if (self._ilink:find( OQ.ENCHANTED )) then
      g:ClearLines() ;
      g:AddLine( OQ.ENCHANTED ) ;
      local s = self._ilink:sub( strlen(OQ.ENCHANTED)+1, -1 ) ;
      g:AddLine( "    |cFF00E000".. tostring(s) .."|r  " ) ;
    else
      g:SetHyperlink( self._ilink ) ;
    end
    g:SetPoint( "LEFT", self, "RIGHT", 50 ) ;
    g:Show() ;
  end
end

function oq.paperdoll_slot_onclick( self, button )
  if (self._ilink == nil) or (button ~= "LeftButton") or (IsShiftKeyDown() == nil) then
    return ;
  end

  -- allow for shift-click items into chat
  local chat = ChatEdit_GetActiveWindow() ;
  if ((chat ~= nil) and chat:IsVisible()) then
    -- Insert itemlink into chat
    chat:Insert(self._ilink)
    return ;
  end
  
  -- standard auction house support
  if (BrowseName and BrowseName:IsVisible()) then
    -- Insert itemlink into AH browse editbox
    local itemName = GetItemInfo(self._ilink) ;
    BrowseName:SetText( itemName ) ;
    QueryAuctionItems( itemName, nil,nil, 0, 0, 0, 0, 0, 0, 0 ) ;
    return ;
  end

  -- auctionator support
  if (Atr_Search_Box and Atr_Search_Box:IsVisible()) then
    -- Insert itemName into Auctionator search box
    local itemName = GetItemInfo(self._ilink) ;
    Atr_Search_Box:SetText( itemName ) ;
    Atr_Search_Button:Click() ;
    return ;
  end
end

function oq.get_slot_id( p )
  local x = p:GetName() ;
  if (x:find("Character")) then
    x = x:sub( strlen( "Character" ) + 1, -1 ) ;
  elseif (x:find("Inspect")) then
    x = x:sub( strlen( "Inspect" ) + 1, -1 ) ;
  end
  return GetInventorySlotInfo( x ) or 0 ;
end

function oq.paperdoll_slot_label( slot, is_left )
  oq.ngemslots = (oq.ngemslots or 0) + 1 ;
  local d = oq.CreateFrame("FRAME", "OQGems".. oq.ngemslots, slot ) ;
  d:SetBackdropColor(0.8,0.2,0.2,1.0) ;
  d:SetWidth (50) ;
  d:SetHeight(40) ;

  d.ilevel = oq.label ( d, 0, 0, 3*12, 25, "xxx" ) ;
  d.is_left = is_left ;
  d._slot = oq.get_slot_id( slot ) ;

  if (is_left) then
    local x  = -2 ;
    local y  = 22 ;    
    local cx = 16 ;
    
    if (slot == CharacterMainHandSlot) or (slot == InspectMainHandSlot) then 
      d:SetPoint( "BOTTOMLEFT", slot, "TOPLEFT",  0, 0 ) ;
      x = x - cx ;
    else
      d:SetPoint( "TOPLEFT", slot, "TOPRIGHT",  12, -5 ) ;
    end
    
    d.gem = tbl.new() ;
    for i=1,5 do
      d.gem[i] = oq.CreateFrame("BUTTON", "OQGems".. oq.ngemslots .."Gem".. i, d, nil ) ;
      d.gem[i].texture = d:CreateTexture( nil, "OVERLAY" ) ;
      d.gem[i].texture:SetTexture( nil ) ;
      d.gem[i].texture:SetAllPoints(d.gem[i]) ;
      d.gem[i].texture:SetAlpha( 1.0 ) ;

      d.gem[i]:SetScript("OnEnter", function(self, ...) oq.paperdoll_slot_tooltip( self, true ) ; end ) ;
      d.gem[i]:SetScript("OnLeave", function(self, ...) oq.paperdoll_slot_tooltip( self ) ; end ) ;
      d.gem[i]:SetScript("OnClick", function(self, button, ...) oq.paperdoll_slot_onclick( self, button ) ; end ) ;
      
      d.gem[i]:SetPoint ( "BOTTOMLEFT", d, "BOTTOMLEFT", x,  y ) ;
      d.gem[i]:SetWidth ( cx ) ;
      d.gem[i]:SetHeight( cx ) ;
      d.gem[i]:Show() ;
      d.gem[i]._gem  = i ;
      x = x + cx ;
    end
   
    d.ilevel:SetPoint   ( "BOTTOMLEFT", d, "BOTTOMLEFT",  0, -12 ) ;
    d.ilevel:SetJustifyH("LEFT") ;
  else
    local x  =  2 ;
    local y  = 22 ;    
    local cx = 16 ;
    x = -1 * 4*cx ;
    if (slot == CharacterSecondaryHandSlot) or (slot == InspectSecondaryHandSlot) then 
      d:SetPoint( "BOTTOMLEFT", slot, "TOPLEFT",  -12, 0 ) ;
      x = x + cx ;
    else
      d:SetPoint( "TOPRIGHT", slot, "TOPLEFT", -12, -5 ) ;
    end
    
    d.gem = tbl.new() ;
    for i=1,5 do
      d.gem[i] = oq.CreateFrame("BUTTON", "OQGems".. oq.ngemslots .."Gem".. i, d, nil ) ;
      d.gem[i].texture = d:CreateTexture( nil, "OVERLAY" ) ;
      d.gem[i].texture:SetTexture( nil ) ;
      d.gem[i].texture:SetAllPoints(d.gem[i]) ;
      d.gem[i].texture:SetAlpha( 1.0 ) ;
      
      d.gem[i]:SetScript("OnEnter", function(self, ...) oq.paperdoll_slot_tooltip( self, true ) ; end ) ;
      d.gem[i]:SetScript("OnLeave", function(self, ...) oq.paperdoll_slot_tooltip( self ) ; end ) ;
      d.gem[i]:SetScript("OnClick", function(self, button, ...) oq.paperdoll_slot_onclick( self, button ) ; end ) ;

      d.gem[i]:SetPoint ( "BOTTOMRIGHT", d, "BOTTOMRIGHT", x,  y ) ;
      d.gem[i]:SetWidth ( cx ) ;
      d.gem[i]:SetHeight( cx ) ;
      d.gem[i]:Show() ;
      d.gem[i]._gem  = i ;
      x = x + cx ;
    end

    d.ilevel:SetPoint   ( "BOTTOMRIGHT", d, "BOTTOMRIGHT",  0, -10 ) ;
    d.ilevel:SetJustifyH("RIGHT") ;
  end
  d.ilevel:SetTextColor( 1.0, 1.0, 1.0, 1 ) ;
  d.ilevel:Show() ;
  return d ;
end

function oq.toggle_show_ilevel( checked )
  PaperDollFrame._ilevelcb:SetChecked( (checked == 1) ) ;
  InspectFrame  ._ilevelcb:SetChecked( (checked == 1) ) ;
  
  oq.paperdoll_overlay( PaperDollFrame._ilevelcb, checked ) ;
  oq.paperdoll_overlay( InspectFrame._ilevelcb  , checked ) ;
end

function oq.the_check()
  if (player_realid == nil) then
    oq.get_battle_tag() ;
    if (player_realid == nil) then
      return ;
    end
  end
  if (oq.is_banned( player_realid )) then
    oq._banned = 1 ;
    oq.process_msg = function() end 
    oq.remove_all_premades() ;
    oq.oqgeneral_leave() ;
  end
  return 1 ;
end

function oq.paperdoll_clear( frame )
  for i,v in pairs(frame._ilevelcb._ilevels) do
    v.ilevel:SetText( "" ) ;
    for j=1,3 do
      v.gem[j].texture:SetTexture( nil ) ;
    end
  end
end

function oq.hook_paperdoll()
  if (PaperDollFrame == nil) then
    return ;
  end
  local parent = PaperDollFrame ;
  local f = oq.checkbox( parent, 10, parent:GetHeight() - 5, 25, 25, 100, OQ.SHOW_ILEVEL, OQ_data._paperdoll_show_ilevel, 
                         function(self) 
                           if (self:GetChecked()) then
                             OQ_data._paperdoll_show_ilevel = 1 ;
                           else
                             OQ_data._paperdoll_show_ilevel = 0 ;
                           end
                           oq.toggle_show_ilevel( OQ_data._paperdoll_show_ilevel ) ;
                         end ) ;
  f._ilevels = tbl.new() ;
  -- left side
  f._ilevels[  1 ] = oq.paperdoll_slot_label( CharacterHeadSlot         , true ) ;
  f._ilevels[  2 ] = oq.paperdoll_slot_label( CharacterNeckSlot         , true ) ;
  f._ilevels[  3 ] = oq.paperdoll_slot_label( CharacterShoulderSlot     , true ) ;
  f._ilevels[ 15 ] = oq.paperdoll_slot_label( CharacterBackSlot         , true ) ;
  f._ilevels[  5 ] = oq.paperdoll_slot_label( CharacterChestSlot        , true ) ;
  f._ilevels[  9 ] = oq.paperdoll_slot_label( CharacterWristSlot        , true ) ;
  f._ilevels[ 16 ] = oq.paperdoll_slot_label( CharacterMainHandSlot     , true ) ;
  -- right side
  f._ilevels[ 10 ] = oq.paperdoll_slot_label( CharacterHandsSlot        , false ) ;
  f._ilevels[  6 ] = oq.paperdoll_slot_label( CharacterWaistSlot        , false ) ;
  f._ilevels[  7 ] = oq.paperdoll_slot_label( CharacterLegsSlot         , false ) ;
  f._ilevels[  8 ] = oq.paperdoll_slot_label( CharacterFeetSlot         , false ) ;
  f._ilevels[ 11 ] = oq.paperdoll_slot_label( CharacterFinger0Slot      , false ) ;
  f._ilevels[ 12 ] = oq.paperdoll_slot_label( CharacterFinger1Slot      , false ) ;
  f._ilevels[ 13 ] = oq.paperdoll_slot_label( CharacterTrinket0Slot     , false ) ;
  f._ilevels[ 14 ] = oq.paperdoll_slot_label( CharacterTrinket1Slot     , false ) ;
  f._ilevels[ 17 ] = oq.paperdoll_slot_label( CharacterSecondaryHandSlot, false ) ;
  for i,v in pairs(f._ilevels) do
    for j=1,3 do
      v.gem[j]._slot = i ;
    end
  end
  
  f:Show() ;
  f._old_show_func   = parent:GetScript( "OnShow" ) ;
  f._old_hide_func   = parent:GetScript( "OnHide" ) ;
  f.paperdoll_update = oq.paperdoll_update ;
  f._target          = "player" ;
  
  parent._ilevelcb = f ;
  parent:SetScript( "OnShow", function(self) self._ilevelcb._old_show_func(self) ; oq.paperdoll_overlay( self._ilevelcb, OQ_data._paperdoll_show_ilevel or 0 ) ; end ) ;
  parent:SetScript( "OnHide", function(self) oq.paperdoll_overlay( self._ilevelcb, 0 ) ; self._ilevelcb._old_hide_func(self) ; end ) ;
end

function oq.hook_inspectdoll()
  if (InspectFrame == nil) then
    return ;
  end
  local parent = InspectFrame ;
  local f = oq.checkbox( parent, 10, parent:GetHeight() - 30, 25, 25, 100, OQ.SHOW_ILEVEL, OQ_data._paperdoll_show_ilevel, 
                         function(self) 
                           if (self:GetChecked()) then
                             OQ_data._paperdoll_show_ilevel = 1 ;
                           else
                             OQ_data._paperdoll_show_ilevel = 0 ;
                           end
                           oq.toggle_show_ilevel( OQ_data._paperdoll_show_ilevel ) ;
                         end ) ;
  f.avg_ilevel = oq.label ( parent, parent:GetWidth() - 125, parent:GetHeight() - 30, 110, 25, string.format( OQ.AVG_ILEVEL, 0 ) ) ;
  f.avg_ilevel:SetJustifyH( "RIGHT" ) ;
  f._ilevels = tbl.new() ;
  f:SetFrameLevel( parent:GetFrameLevel() + 10 ) ;
  -- left side
  f._ilevels[  1 ] = oq.paperdoll_slot_label( InspectHeadSlot         , true ) ;
  f._ilevels[  2 ] = oq.paperdoll_slot_label( InspectNeckSlot         , true ) ;
  f._ilevels[  3 ] = oq.paperdoll_slot_label( InspectShoulderSlot     , true ) ;
  f._ilevels[ 15 ] = oq.paperdoll_slot_label( InspectBackSlot         , true ) ;
  f._ilevels[  5 ] = oq.paperdoll_slot_label( InspectChestSlot        , true ) ;
  f._ilevels[  9 ] = oq.paperdoll_slot_label( InspectWristSlot        , true ) ;
  f._ilevels[ 16 ] = oq.paperdoll_slot_label( InspectMainHandSlot     , true ) ;
  -- right side
  f._ilevels[ 10 ] = oq.paperdoll_slot_label( InspectHandsSlot        , false ) ;
  f._ilevels[  6 ] = oq.paperdoll_slot_label( InspectWaistSlot        , false ) ;
  f._ilevels[  7 ] = oq.paperdoll_slot_label( InspectLegsSlot         , false ) ;
  f._ilevels[  8 ] = oq.paperdoll_slot_label( InspectFeetSlot         , false ) ;
  f._ilevels[ 11 ] = oq.paperdoll_slot_label( InspectFinger0Slot      , false ) ;
  f._ilevels[ 12 ] = oq.paperdoll_slot_label( InspectFinger1Slot      , false ) ;
  f._ilevels[ 13 ] = oq.paperdoll_slot_label( InspectTrinket0Slot     , false ) ;
  f._ilevels[ 14 ] = oq.paperdoll_slot_label( InspectTrinket1Slot     , false ) ;
  f._ilevels[ 17 ] = oq.paperdoll_slot_label( InspectSecondaryHandSlot, false ) ;
  for i,v in pairs(f._ilevels) do
    for j=1,3 do
      v.gem[j]._slot = i ;
    end
  end
  
  f:Show() ;
  f._old_show_func   = parent:GetScript( "OnShow" ) ;
  f._old_hide_func   = parent:GetScript( "OnHide" ) ;
  f.paperdoll_update = oq.paperdoll_update ;
  f._target          = "target" ;

  parent._ilevelcb = f ;
  parent:SetScript( "OnShow", function(self) self._ilevelcb._old_show_func(self) ; oq.paperdoll_overlay( self._ilevelcb, OQ_data._paperdoll_show_ilevel or 0 ) ; end ) ;
  parent:SetScript( "OnHide", function(self) oq.paperdoll_overlay( self._ilevelcb, 0 ) ; self._ilevelcb._old_hide_func(self) ; end ) ;
end

function oq.HideSafely(f) 
  if not InCombatLockdown() then 
    f:Hide() 
  end
end

function oq.on_init( now )
  if (oq._initialized) then
    return ;
  end
  if (oq.ui == nil) then
    print( "OQ ui not initalized properly" ) ;
  end
  oq.init_locals() ;
  oq.init_bnet_friends() ;
  oq.hook_options() ;
  oq.init_table() ;
  oq.init_stats_data() ;
  oq.procs_init() ;    -- populates procs with all functions
  oq.procs_no_raid() ; -- remove in-raid only functions 
  oq.raid_init() ;
  oq.token_list_init() ;
  oq.utimer_check_init() ;
  oq.my_tok = "C".. oq.token_gen() ;
  oq.make_frame_moveable( oq.ui ) ;
  oq.BossID = LibStub("LibBossIDs-1.0").BossIDs ;

  player_name       = UnitName("player") ;
  player_guid       = UnitGUID("player") ;
  player_realm      = oq.GetRealmName() ;
  player_realm_id   = oq.realm_cooked( player_realm ) ;
  player_class      = OQ.SHORT_CLASS[ select(2, UnitClass("player")) ] ;
  player_level      = UnitLevel("player") ;
  player_ilevel     = oq.get_ilevel() ;
  player_resil      = oq.get_resil() ;
  player_realid     = oq.get_battle_tag() ;
  player_faction    = oq.get_player_faction() ;
  player_karma      = 0 ; 
  oq.player_faction = player_faction ; -- for the other modules

  if (OQ_toon ~= nil) and (OQ_toon.raid ~= nil) and (OQ_toon.raid.type ~= nil) then
    oq.raid.type = OQ_toon.raid.type ;
  end
  oq.create_main_ui() ;
  
  oq.ui:SetFrameStrata( "MEDIUM" ) ;
  oq.marquee = oq.create_marquee() ;
  
  ChatFrame_AddMessageEventFilter( "CHAT_MSG_SYSTEM"           , oq.chat_filter ) ;
  ChatFrame_AddMessageEventFilter( "CHAT_MSG_BN_WHISPER"       , oq.chat_filter ) ;
  ChatFrame_AddMessageEventFilter( "CHAT_MSG_BN_WHISPER_INFORM", oq.chat_filter ) ;
  ChatFrame_AddMessageEventFilter( "CHAT_MSG_BN_INLINE_TOAST_BROADCAST", oq.chat_filter ) ;

  oq.old_hyperlink_handler = ChatFrame1:GetScript("OnHyperLinkClick") ;
  ChatFrame1:SetScript("OnHyperLinkClick", oq.onHyperlinkClick ) ;

  -- first time check
  oq.timer_oneshot(  2, oq.init_bn_custom_msg          ) ;
  oq.timer_oneshot(  2, oq.hook_paperdoll              ) ;
  oq.timer_oneshot(  2, oq.hook_inspectdoll            ) ;
  oq.timer_oneshot(2.5, oq.recover_premades            ) ;
  oq.timer_oneshot(  3, oq.advertise_my_raid           ) ;
  oq.timer_oneshot(  3, oq.cache_mmr_stats             ) ;
  oq.timer_oneshot(  4, oq.clean_karma_log             ) ;
  oq.timer_oneshot(  5, oq.delayed_button_load         ) ;
  oq.timer_oneshot(  6, Register_Logout_Prehook        ) ;
  oq.timer_oneshot( 10, oq.bump_scorekeeper            ) ;
  if (InspectFrame == nil) then
    LoadAddOn("Blizzard_InspectUI") ; -- make sure its loaded
  end

  oq.on_bnet_friend_invite() ;
  oq.bn_check_online() ;
  
  -- define timers
  oq.timer( "chk4dead_premade"  ,   30, oq.remove_dead_premades          , true ) ;
  oq.timer( "advertise_premade" ,   30, oq.advertise_my_raid             , true ) ;  
  oq.timer( "join_OQGeneral"    ,   20, oq.oqgeneral_join                , nil  ) ; 
  oq.timer( "report_premades"   ,   20, oq.report_premades               , nil  ) ; 
  oq.timer( "report_submits"    ,   20, oq.timed_submit_report           , true ) ;
  oq.timer( "clear_the_dead"    ,   15, oq.clear_the_dead                , true ) ;
  oq.timer( "update_nfriends"   ,   15, oq.bn_check_online               , true ) ;
  oq.timer( "chk4dead_group"    ,   15, oq.check_for_dead_group          , true ) ;
  oq.timer( "auto_role_check"   ,   15, oq.auto_set_role                 , true ) ;
  oq.timer( "bnet_friend_req"   ,   10, oq.on_bnet_friend_invite         , true ) ;
  oq.timer( "the_check"         ,    5, oq.the_check                     , true ) ;
  oq.timer( "reset_buttons"     ,    5, oq.normalize_static_button_height, true ) ;
  oq.timer( "populate_dtime"    ,    5, oq.populate_dtime                , true ) ;
  oq.timer( "calc_pkt_stats"    ,    1, oq.calc_pkt_stats                , true ) ;
  oq.timer( "check_stats"       ,    4, oq.check_stats                   , true ) ;  -- check party and personal stats every 3 seconds; only send if changed
  oq.timer( "chk_bg_status"     ,    3, oq.check_bg_status               , true ) ;
  oq.timer( "waitlist update"   ,    1, oq.update_wait_times             , true ) ;
  oq.timer( "bn_send_q"         , 0.05, oq.BNSendQ_pop                   , true ) ; -- 20 times per second, throttles bn msgs

-- should be no need for this, as any changes to your karma should be waiting for you in your btag friends list
-- *  except if you're friended to the scorekeeper
--  oq.timer_oneshot( 15, oq.req_karma, "player" ) ; -- get my current karma rating, could have changed while away
  
  oq.j2tw(1) ;
  
  oq.clear_report_attempts() ;
  oq.attempt_group_recovery() ;
  oq.log( nil, "|cFF808080logged on|r ".. player_name .."-".. player_realm .." "..
               "|cFF808080v".. OQUEUE_VERSION .."(".. tostring(OQ.REGION) ..")".. tostring(OQ_SPECIAL_TAG or "") .."|r" ) ;

--  oq.log( nil, "|cFF808080testing link|r |Hlog:123|hhello there world|h" ) ;
  oq.show_version() ;

  if (OQ_toon.marquee_hide) then
    oq.marquee:Hide() ;
  else
    oq.marquee:Show() ;
  end

  OQ_MinimapButton_Reposition() ;
  if (OQ_toon.mini_hide) then
    OQ_MinimapButton:Hide() ;
  else
    OQ_MinimapButton:Show() ;
  end
  
  if (OQ_toon.my_toons == nil) then
    OQ_toon.my_toons = {} ;
  end

  oq.fog_init() ;
  
  -- initialize person bg ratings
  -- this will, hopefully, force the bg-rating info to come from the server (must be a better way)
  if (PVPUIFrame == nil) then
    LoadAddOn("Blizzard_PVPUI") ; -- make sure its loaded
  end
  if (OQ.BGROUP_ICON == nil) or (OQ.BGROUPS == nil) or (OQ.SHORT_BGROUPS == nil) then  
    oq.log( true, OQ_REDX_ICON .."  ".. OQ.ERROR_REGIONDATA ) ;
  end
  
  oq._initialized = true ;
end

function oq.cache_mmr_stats()
  if ((player_level >= 10) and PVPUIFrame) then
    PVPUIFrame:Show() ;
    PVPQueueFrameCategoryButton2:Click() ;
--    oq.timer_oneshot( 0.25, function(f) f:Hide() ; end, PVPUIFrame ) ;
    PVPQueueFrameCategoryButton1:Click() ;
    PVPUIFrame:Hide() ;
  end
  oq.n_connections() ;
end

function oq.clear_report_attempts()
  if (OQ_toon.reports == nil) then
    OQ_toon.reports = {} ;
    return ;
  end
  for i,v in pairs(OQ_toon.reports) do
    v.last_tm       = 0 ;
    v.attempt       = nil ;
    v.submit_failed = nil ;
  end
end

-- the hope is this event will fire as the user is logging out and before bnet is down
function Register_Logout_Prehook()
  oq._old_logout = Logout ;
  Logout = OQPrehook_Logout ;
  
  oq._old_exit = Exit ;
  Exit = OQPrehook_Exit ;
  
  if (ACP_Data) then
    oq._old_reload = ReloadUI ;
    ReloadUI = OQPrehook_Reload ;
  end
end

function OQPrehook_Exit(...)
  -- clear '(OQ)' from broadcast
  oq.reset_bn_custom_msg() ;
  if (oq._old_exit) then
    oq.timer_oneshot( 1, oq._old_exit, ... ) ; -- give bnet some time to send the broadcast update
  end
end

function OQPrehook_Logout(...)
  -- clear '(OQ)' from broadcast
  oq.reset_bn_custom_msg() ;
  if (oq._old_logout) then
    oq.timer_oneshot( 1, oq._old_logout, ... ) ; -- give bnet some time to send the broadcast update
  end
end

function OQPrehook_Reload(...)
  -- clear '(OQ)' from broadcast
  oq.reset_bn_custom_msg() ;
  if (oq._old_reload) then
    oq._old_reload( ... ) ; 
  end
end

function oq.on_logout() 
  -- leave party & disband raid if you started one
--  oq.raid_disband() ;  -- only triggers if i am raid leader
--  oq.raid_announce( "leave_group,".. player_name ..",".. player_realm ) ;

  -- remove myself from other waitlists
  -- note:  doesn't work, no msgs sent
  oq.clear_pending() ;
  
  -- set the bn message without the OQ header
--  oq.reset_bn_custom_msg() ;
  
  -- leave channels
  oq.channel_leave( "OQGeneral" ) ;
  
  oq.log( nil, "logging out" ) ;
  -- hang onto group data if still in an OQ_group (may come back)
  local disabled = OQ_toon.disabled ;
  
  if (OQ_toon == nil) then
    OQ_toon = {} ; 
    OQ_toon.auto_role  = 1 ;
  end
  if (OQ_toon.shout_kbs == nil) then
    OQ_toon.shout_kbs = 0 ;
  end
  if (OQ_toon.shout_caps == nil) then
    OQ_toon.shout_caps = 0 ;
  end
  if (OQ_toon.shout_ragequits == nil) then
    OQ_toon.shout_ragequits = 1 ;
  end
  if (OQ_data.autoaccept_mesh_request == nil) then
    OQ_data.autoaccept_mesh_request = 0 ;
  end
  if (OQ_data.show_premade_ads == nil) then
    OQ_data.show_premade_ads = 0 ; -- off by default
  end
  if (OQ_data.show_contract_ads == nil) then
    OQ_data.show_contract_ads = 1 ;
  end
  if (OQ_data.ok2submit_tag == nil) then
    OQ_data.ok2submit_tag = 0 ;
  end
  OQ_toon.my_group         = my_group ;
  OQ_toon.my_slot          = my_slot ;
  OQ_toon.last_tm          = utc_time() ; 
  OQ_toon.player_role      = player_role;
  OQ_toon.disabled         = disabled ;
  OQ_toon.raid             = {} ;
  OQ_toon.waitlist         = {} ;
  if (oq.marquee ~= nil) then
    OQ_toon.marquee_x = max( 0, oq.marquee:GetLeft()) ;
    OQ_toon.marquee_y = max( 0, GetScreenHeight() - oq.marquee:GetTop()) ;
  end
  if (oq.raid.raid_token) then
    OQ_toon.raid     = copyTable( oq.raid ) ; 
    OQ_toon.waitlist = copyTable( oq.waitlist ) ; 
  end
  
  OQ_toon._idata = { inst  = oq._inside_instance,
                     type  = oq._instance_type,
                     pts   = oq._instance_pts,
                     hdr   = oq._instance_header,
                     tm    = oq._instance_tm,
                     alone = oq._entered_alone,
                   } ;
  
  OQ_data.scores = copyTable( oq.scores ) ;
  OQ_data.bn_friends = nil ; -- clear out bnfriends; will reload next login
  OQ_data.reports    = nil ; -- old data; making sure it's cleaned out
  OQ_data.setup      = nil ; -- old data; making sure it's cleaned out
end

function oq.attempt_group_recovery() 
  local now = utc_time() ;
  if (OQ_data ~= nil) and (OQ_data.scores ~= nil) then
    tbl.delete( oq.scores ) ;
    oq.scores = copyTable( OQ_data.scores ) ;
    if (oq.scores.bg == nil) then
      oq.scores_init_bgs() ;
    end
    oq.update_scores() ;
  else
    oq.scores_init() ;
  end
  oq.color_blind_mode( OQ_data.colorblindshader ) ;
  
  if (OQ_toon) then
    -- class portrait
    if (OQ_toon.class_portrait == nil) then
      OQ_toon.class_portrait = 1 ;
    end
    if (OQ_toon.say_sapped == nil) then
      OQ_toon.say_sapped = 1 ;
    end
    if (OQ_toon.who_popped_lust == nil) then
      OQ_toon.who_popped_lust = 1 ;
    end
    if (OQ_toon.shout_kbs == nil) then
      -- not set... on by default. 0 == off
      OQ_toon.shout_kbs = 1 ;
    end
    if (OQ_toon.shout_caps == nil) then
      -- not set... on by default. 0 == off
      OQ_toon.shout_caps = 1 ;
    end
    if (OQ_toon.shout_ragequits == nil) then
      -- not set... on by default. 1 == on
      OQ_toon.shout_ragequits = 1 ;
    end
    if (OQ_data.autoaccept_mesh_request == nil) then
      -- default is on
      OQ_data.autoaccept_mesh_request = 1 ; 
    end
    if (OQ_data.ok2submit_tag == nil) then
      -- default is on
      OQ_data.ok2submit_tag = 1 ; 
    end
    if (OQ_data.ok2autoinspect == nil) then
      -- default is gc off
      OQ_data.ok2autoinspect = 1 ;
    end
      
    -- more then 60 seconds passed, recovery not an option
    if ((now - OQ_toon.last_tm) <= OQ_GROUP_RECOVERY_TM) then
      my_group = OQ_toon.my_group or 0 ;
      my_slot  = OQ_toon.my_slot or 0 ;
      if (OQ_toon.raid.raid_token) then
        tbl.delete( oq.raid ) ;
        oq.raid  = copyTable( OQ_toon.raid ) ;
        oq.set_premade_type( OQ_toon.raid.type ) ;
        
        -- make sure all the sub tables are there
        if (not oq.raid.group) then
          oq.raid.group = tbl.new() ;
        end
        for i = 1,8 do
          if (not oq.raid.group[i]) then
            oq.raid.group[i] = tbl.new() ;
          end
          if (not oq.raid.group[i].member) then
            oq.raid.group[i].member = tbl.new() ;
          end
          for j=1,5 do
            if (not oq.raid.group[i].member[j]) then
              oq.raid.group[i].member[j] = tbl.new() ;
              oq.raid.group[i].member[j].flags = 0 ;
            end
            if (not oq.raid.group[i].member[j].bg) then
              oq.raid.group[i].member[j].bg = tbl.new() ;
            end
            if (not oq.raid.group[i].member[j].bg[1]) then
              oq.raid.group[i].member[j].bg[1] = tbl.new() ;
            end
            if (not oq.raid.group[i].member[j].bg[2]) then
              oq.raid.group[i].member[j].bg[2] = tbl.new() ;
            end
          end
        end
      end
    end
    player_role = OQ_toon.player_role or 3 ;
    
    -- update UI elements
    if (oq.raid.raid_token) then
      if (oq.iam_raid_leader()) then
        oq.ui_raidleader() ;
        oq.set_group_lead( 1, player_name, player_realm, player_class, player_realid ) ;
        oq.raid.group[1].member[1].resil  = player_resil ;
        oq.raid.group[1].member[1].ilevel = player_ilevel ;
        oq.get_group_hp() ;
        oq.check_for_deserter() ;
        oq.tab3_create_but:SetText( OQ.UPDATE_BUTTON ) ;
        
        if (oq.waitlist ~= nil) then
          oq.waitlist = tbl.delete(oq.waitlist) ;
        end
        oq.waitlist = copyTable( OQ_toon.waitlist ) ;
        if (oq.waitlist == nil) then
          oq.waitlist = tbl.new() ;
        end
        oq.populate_waitlist() ;
      else
        oq.ui_player() ;
      end
      for i=1,8 do
        local grp = oq.raid.group[i] ;
        for j=1,5 do
          local m = grp.member[j] ;
          if (j == 1) then
            oq.set_group_lead( i, m.name, m.realm, m.class, m.realid ) ;
          else
            oq.set_group_member( i, j, m.name, m.realm, m.class, m.realid, m.bg[1].status, m.bg[2].status ) ;
          end
          m.check = OQ.FLAG_CLEAR ;
        end
      end
      if (my_group ~= 0) and (my_slot ~= 0) then
        oq.raid.group[my_group].member[my_slot].level = player_level ;
      end

      -- update tab_1
      oq.tab1_name :SetText( oq.raid.name ) ;
      oq.tab1_notes:SetText( oq.raid.notes ) ;

      oq.update_tab1_stats() ;
      oq.update_tab3_info() ;

      -- activate in-raid only procs
      oq.procs_join_raid() ;
    end
  else
    OQ_toon = {} ;
  end
  if (OQ_toon.MinimapPos == nil) then
    OQ_toon.MinimapPos = 0 ;
  end
  if (OQ_data.show_premade_ads == nil) then
    OQ_data.show_premade_ads = 0 ; -- off by default; 'sticky' between sessions
  end
  if (OQ_data.show_contract_ads == nil) then
    OQ_data.show_contract_ads = 1 ;
  end
  
  if (oq.raid.enforce_levels == nil) then
    oq.raid.enforce_levels = 1 ;
  end
  oq.tab3_enforce:SetChecked( (oq.raid.enforce_levels == 1) ) ;
  
  if (OQ_toon.reports == nil) then
    OQ_toon.reports = {} ;
  end
  if (OQ_data.announce_spy == nil) then
    OQ_data.announce_spy = 1 ;
  end
  if (OQ_data.fog_enabled == nil) then
    OQ_data.fog_enabled = 1 ;
  end
  if (OQ_data._paperdoll_show_ilevel == nil) then
    OQ_data._paperdoll_show_ilevel = 1 ; -- on by default
  end
  local instance, instanceType = IsInInstance() ;
  if ((OQ_data.threat_show == nil) or (OQ_data.threat_show == 1)) and (instanceType == "pvp") and (instance == 1) then
    oq.threat_frame():Show() ;
  end
  if ((OQ_data.timer_show == nil) or (OQ_data.timer_show == 1)) and (instanceType == "pvp") and (instance == 1) then
    oq.utimer_frame():Show() ;
  end
  if (OQ_data.show_controlled == nil) then
    OQ_data.show_controlled = 0 ;
  end
  if (OQ_data.leader == nil) then
    OQ_data.leader = {} ;
  end
  if (OQ_data._karma_last_tm == nil) then
    OQ_data._karma_last_tm = 0 ;
  end
  if (OQ_data.leader["pve.raid"] == nil) then
    OQ_data.leader["pve.raid"] = { nBosses = 0 ;  pts = 0 } ;
  end
  if (OQ_data.leader["pve.5man"] == nil) then
    OQ_data.leader["pve.5man"] = { nBosses = 0 ;  pts = 0 } ;
  end
  if (OQ_data.leader["pve.challenge"] == nil) then
    OQ_data.leader["pve.challenge"] = { nBosses = 0 ;  pts = 0 } ;
  end
  if (OQ_data.leader["pve.scenario"] == nil) then
    OQ_data.leader["pve.scenario"] = { nBosses = 0 ;  pts = 0 } ;
  end
  if (OQ_toon._idata) and (OQ_toon._idata.tm) and ((now - OQ_toon._idata.tm) < 60*60) then
    -- data only 'good' for an hour
    oq._inside_instance = OQ_toon._idata.inst ;
    oq._instance_type   = OQ_toon._idata.type ;
    oq._instance_pts    = OQ_toon._idata.pts ;
    oq._instance_header = OQ_toon._idata.hdr ;
    oq._instance_tm     = OQ_toon._idata.tm ;
    oq._entered_alone   = OQ_toon._idata.alone ;
  end
  if (OQ_data._show_datestamp) and (OQ_data._show_datestamp == 1) then
    oq.tab4_now:Show() ;
  end

  -- initialize UI elements
  oq.tab5_ar:SetChecked( (OQ_toon.auto_role == 1) ) ;
  oq.tab5_cp:SetChecked( (OQ_toon.class_portrait == 1) ) ;
  oq.tab5_autoinspect:SetChecked( (OQ_data.ok2autoinspect == 1) ) ;
  oq.tab5_ss:SetChecked( (OQ_toon.say_sapped == 1) ) ;
  oq.tab5_wp:SetChecked( (OQ_toon.who_popped_lust == 1) ) ;
  oq.tab5_shoutkbs:SetChecked( (OQ_toon.shout_kbs == 1) ) ;
  oq.tab5_shoutads:SetChecked( (OQ_data.show_premade_ads == 1) ) ;
  oq.tab5_shoutcontracts:SetChecked( (OQ_data.show_contract_ads == 1) ) ;
  oq.tab5_shoutcaps:SetChecked( (OQ_toon.shout_caps == 1) ) ;
  oq.tab5_ragequits:SetChecked( (OQ_toon.shout_ragequits == 1) ) ;
  oq.tab5_autoaccept_mesh_request:SetChecked( (OQ_data.autoaccept_mesh_request == 1) ) ;
  oq.tab5_ok2submit_btag:SetChecked( (OQ_data.ok2submit_tag == 1) ) ;
  
  oq._filter._text = OQ_data._filter_text or "" ;

  player_karma = OQ_data._karma or 0 ;
  oq.set_karma_shield( player_karma ) ;
  oq.timer_oneshot( 4, oq.req_karma_if_needed ) ;
  oq._sktime_notice_tm = 0 ;
end

function oq.closeInvitePopup()
  if (_inside_bg) then
    return ;
  end
  StaticPopup_Hide("PARTY_INVITE")
end

function oq.on_party_invite_request( leader_name ) 
  if (my_group <= 0) then
    return ;
  end
  local  grp_lead = oq.raid.group[ my_group ].member[1] ;
  local  n        = grp_lead.name ;
  if (grp_lead == nil) or (grp_lead.realm == nil) then
    return ;
  end
  if (grp_lead.realm ~= player_realm) then
    n = n .."-".. grp_lead.realm ;
  end

  if (n == leader_name) then
    AcceptGroup() ;
  end
end

function oq.ui_toggle()
  if (oq.get_battle_tag() == nil) then
    return ;
  end

  if (oq.ui:IsVisible()) then
    oq.ui:Hide() ;
    _ui_open = nil ;
  else
    oq.channel_join( "OQGeneral" ) ;  -- just in case
    if (OQ_toon.disabled) then
      OQ_toon.disabled = nil ;    
      print( OQ.ENABLED ) ;
    end
    oq.ui:Show() ;
    _ui_open = true ;
  end
end

function OQ_onLoad( self )
  oq.ui = self ;
  oq.ui.closepb = oq.closebox( oq.ui ) ;
  oq.register_events() ;
end

function oq.onHide( self )
  _ui_open = nil ;
  oq.ui.hide_tm = GetTime() ; -- hold this in-case the UI was forced-closed when the map was brought up
  PlaySound("igCharacterInfoClose") ;
end

function oq.hide_shade()
  if (oq.ui_shade ~= nil) and (oq.ui_shade:IsVisible()) then
    oq.ui_shade:Hide() ;
  end
end

function oq.onShow( self )
  _ui_open = true ;
  PlaySound("igCharacterInfoOpen") ;

  oq.hide_shade() ;  
  OQTabPage1:Hide() ;  -- my premade 
  OQTabPage2:Hide() ;  -- find premade
  OQTabPage3:Hide() ;  -- create premade
  OQTabPage4:Hide() ;  -- score
  OQTabPage5:Hide() ;  -- setup
  OQTabPage6:Hide() ;  -- waitlist
  OQTabPage7:Hide() ;  -- banlist

  if (oq.raid.raid_token == nil) and (oq.GetNumPartyMembers() > 0) then
    -- not in an oQueue group but in a party
    local islead = UnitIsGroupLeader("player") ;
    if (islead) then
      -- party leader straight to create premade
      PanelTemplates_SetTab(OQMainFrame, 3) ;
      OQTabPage3:Show() ;
    else
      PanelTemplates_SetTab(OQMainFrame, 1) ;
      OQTabPage1:Show() ;
    end
  elseif (oq.GetNumPartyMembers() > 0) or (oq.raid.raid_token ~= nil) then
    -- in an oQueue group
    PanelTemplates_SetTab(OQMainFrame, 1) ;
    OQTabPage1:Show() ;
  else
    -- solo toon, looking for raid
    PanelTemplates_SetTab(OQMainFrame, 2) ;
    OQTabPage2:Show() ;
  end

  -- set the text on the wait-list tab
  local nWaiting = oq.n_waiting() ;
  if (nWaiting > 0) then
    OQMainFrameTab7:SetText( string.format( OQ.TAB_WAITLISTN, nWaiting ) ) ;
  else
    OQMainFrameTab7:SetText( OQ.TAB_WAITLIST ) ;
  end
end

function oq.show_score_tab()
  if (oq.get_battle_tag() == nil) then
    return ;
  end

  if (oq.ui:IsVisible()) then
    oq.ui_toggle() ;
    return ;
  end
  
  oq.ui_toggle() ; -- will make visible  
  
  PanelTemplates_SetTab(OQMainFrame, 4);
  OQTabPage1:Hide();
  OQTabPage2:Hide();
  OQTabPage3:Hide();
  OQTabPage4:Show();
  OQTabPage5:Hide();
  OQTabPage6:Hide();
  OQTabPage7:Hide();
  PlaySound("igCharacterInfoTab");
end

function oq.create_matchup_scoretab( parent )
  local f = oq.CreateFrame("Button", "OQMatchupMarquee", parent, nil ) ;
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                          edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                          tile=true, tileSize = 16, edgeSize = 16,
                          insets = { left = 4, right = 3, top = 4, bottom = 3 }
                         })
  f:SetScript("OnUpdate", function(self, elapsed) 
                            local now = GetTime() ;
                            if (self._next_update ~= nil) and (now < self._next_update) then
                              return ;
                            end
                            self._next_update = now + 0.5 ;
                            if (self._end_tm == nil) then
                              return ;
                            end
                            local dt = max( 0, self._end_tm - utc_time() ) ;
                            self.timeleft:SetText( string.format( "%d:%02d", floor(dt/60), floor(dt%60)) ) ;
                          end ) ;
  f:SetScript( "OnClick", oq.toggle_type2_bounty_board ) ;

  f:SetBackdropColor(0.2,0.2,0.2,1.0);
  f:SetPoint( "TOPLEFT", parent, "TOPRIGHT", -1, 0 ) ;
  f:SetWidth( 60 ) ;
  f:SetHeight( parent:GetHeight() + 22 ) ;

  local x = 5 ;
  local y = 5 ;
  f.horde     = oq.label( f, x, y, 45, 20, "0" ) ;
  f.horde:SetFont(OQ.FONT, 10, "") ;
  f.horde:SetJustifyH("right") ;
  f.horde:SetJustifyV("middle") ;
  f.horde:SetTextColor( 1, 1, 1, 1 ) ;  
  f.horde:SetShadowOffset( 0, 0 ) ;

  y = y + 20 ;  
  f.alliance     = oq.label( f, x, y, 45, 20, "0" ) ;
  f.alliance:SetFont(OQ.FONT, 10, "") ;
  f.alliance:SetJustifyH("right") ;
  f.alliance:SetJustifyV("middle") ;
  f.alliance:SetTextColor( 1, 1, 1, 1 ) ;  
  f.alliance:SetShadowOffset( 0, 0 ) ;
  
  y = y + 20 ;  
  f.timeleft     = oq.label( f, x, y, 45, 20, "23:25" ) ;
  f.timeleft:SetFont(OQ.FONT_FIXED, 10, "") ;
  f.timeleft:SetJustifyH("right") ;
  f.timeleft:SetJustifyV("middle") ;
  f.timeleft:SetTextColor( 1, 1, 1, 1 ) ;  
  f.timeleft:SetShadowOffset( 0, 0 ) ;
  
  return f ;
end

function oq.create_marquee()
  local cx = 135 ;
  local cy = 50 ;
--  local f = oq.panel( UIParent, "OQMarquee", 100, 10, cx, cy ) ;
  local f = oq.CreateFrame("Button", "OQMarquee", UIParent, nil ) ;
  f:RegisterForClicks("LeftButtonUp", "RightButtonUp") ;
  f:SetScript("OnClick", function(self,button) 
                           if (button == "LeftButton") then
                             oq.show_score_tab() ; 
                           elseif (button == "RightButton") then
                             oq.toggle_bounty_board() ;
                           end
                         end ) ;
  oq.setpos( f, 100, 10, cx, cy ) ;  
  
  f:SetBackdrop({bgFile="Interface/Tooltips/UI-Tooltip-Background", 
                          edgeFile="Interface/Tooltips/UI-Tooltip-Border", 
                          tile=true, tileSize = 16, edgeSize = 16,
                          insets = { left = 4, right = 3, top = 4, bottom = 3 }
                         })
  f:SetBackdropColor(0.2,0.2,0.2,1.0);
  f:SetMovable(true) ;
  f:EnableMouse(true) ;
  f:RegisterForDrag( "LeftButton" ) ;
  f:SetScript( "OnDragStart", f.StartMoving ) ;
  f:SetScript( "OnDragStop", f.StopMovingOrSizing ) ;
  if (OQ_toon.marquee_y ~= nil) and (OQ_toon.marquee_x ~= nil) then
    oq.moveto( f, OQ_toon.marquee_x, OQ_toon.marquee_y ) ;
  else
    oq.moveto( f, (UIParent:GetWidth() - cx)/2, 10 ) ;
  end
  
  local x = 5 ;
  local y = 5 ;
  f.horde_emblem    = oq.texture( f, x, y+2, 18, 16, "Interface\\FriendsFrame\\PlusManz-Horde" ) ;

  x = x + 20 ;
  f.horde_label     = oq.label( f, x, y, 60, 20, "Horde" ) ;
  f.horde_label:SetFont(OQ.FONT, 10, "") ;
  f.horde_label:SetJustifyH("left") ;
  f.horde_label:SetJustifyV("middle") ;
  
  x = x + 50 ;
  f.horde_score     = oq.label( f, x, y, 50, 20, "99,999" ) ;
  f.horde_score:SetFont(OQ.FONT, 10, "") ;
  f.horde_score:SetJustifyH("right") ;
  f.horde_score:SetJustifyV("middle") ;

  x = 5 ;
  y = y + 20 ;
  f.alliance_emblem = oq.texture( f, x, y+2, 18, 16, "Interface\\FriendsFrame\\PlusManz-Alliance" ) ;
  
  x = x + 20 ;
  f.alliance_label  = oq.label( f, x, y, 60, 20, "Alliance" ) ;
  f.alliance_label:SetFont(OQ.FONT, 10, "") ;
  f.alliance_label:SetJustifyH("left") ;
  f.alliance_label:SetJustifyV("middle") ;
  
  x = x + 50 ;
  f.alliance_score     = oq.label( f, x, y, 50, 20, "0" ) ;
  f.alliance_score:SetFont(OQ.FONT, 10, "") ;
  f.alliance_score:SetJustifyH("right") ;
  f.alliance_score:SetJustifyV("middle") ;
  
  -- match-up score tab
  f.match_up = oq.create_matchup_scoretab( f ) ;
  f.match_up:Hide() ;

  f:Hide() ;
  return f ;
end

function oq.toggle_marquee()
  if (oq.marquee == nil) then
    return ;
  end

  if (oq.marquee:IsVisible()) then
    oq.marquee:Hide() ;
    OQ_toon.marquee_hide = true ;
  else
    oq.marquee:Show() ;
    OQ_toon.marquee_hide = nil ;
  end
end

function oq.delayed_button_load() 
  oq.mini:RegisterForClicks( "AnyUp" ) ;
  oq.mini:RegisterForDrag  ( "LeftButton", "RightButton" ) ;
  if (OQ_toon.mini_hide) then
    oq.mini:Hide() ;
  else
    oq.mini:Show() ;
  end
  oq.mini:SetScript("OnClick", OQ_buttonShow ) ;
  OQ_MinimapButton:SetToplevel(true) ;
  OQ_MinimapButton:SetFrameStrata( "MEDIUM" ) ;
  OQ_MinimapButton:SetFrameLevel(50) ;
end

function OQ_buttonLoad(self)
  oq.mini = self ;
end

OQ.minimap_menu_options = { 
  { text = OQ.MM_OPTION1 , f = function(self, arg1) oq.ui_toggle() ; end },
  { text = OQ.MM_OPTION2 , f = function(self, arg1) oq.toggle_marquee() ; end },
  { text = OQ.MM_OPTION2a, f = function(self, arg1) oq.toggle_bounty_board() ; end },
  { text = OQ.MM_OPTION3 , f = function(self, arg1) oq.toggle_timers() ; end },
  { text = OQ.MM_OPTION4 , f = function(self, arg1) oq.toggle_threat_level() ; end },
  { text = OQ.MM_OPTION5 , f = function(self, arg1) oq.utimer_stop_all() ; end },
  { text = OQ.MM_OPTION6 , f = function(self, arg1) oq.show_now() ; end },
  { text = OQ.MM_OPTION7 , f = function(self, arg1) oq.reposition_ui() ; end },
  { text = OQ.MM_OPTION8 , f = function(self, arg1) oq.where_am_i() ; end },
  { text = "---"         , f = function(self, arg1) end },
  { text = OQ.MM_OPTION9 , f = function(self, arg1) oq.godark() ; end },
} ;
function oq.make_minimap_dropdown()
  local m = oq.menu_create() ;
  for i,v in pairs(OQ.minimap_menu_options) do
    oq.menu_add( v.text, i, v.text, nil, v.f ) ;
  end
  return m ;  
end

-- left button : toggles main ui
-- right button: toggles minimap dropdown menu
--
function OQ_buttonShow(self, button, down)
  if (button == "RightButton") and (not down) then
    if (oq.menu_is_visible()) then
      oq.menu_hide() ;
    else
      oq.make_minimap_dropdown() ;
      oq.menu_show( self, "TOPLEFT", -150, -25, "BOTTOMLEFT", 150 ) ;
    end
  elseif (button == "LeftButton") and (not down) then
    oq.ui_toggle() ;
  end
end

function OQ_MinimapButton_Reposition()
  local xpos
  local ypos
  local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
  if minimapShape == "SQUARE" then
    xpos = 110 * cos(OQ_toon.MinimapPos or 0)
    ypos = 110 * sin(OQ_toon.MinimapPos or 0)
    xpos = math.max(-82, math.min(xpos, 84))
    ypos = math.max(-86, math.min(ypos, 82))
  else
    xpos = 80 * cos(OQ_toon.MinimapPos or 0)
    ypos = 80 * sin(OQ_toon.MinimapPos or 0)
  end
  OQ_MinimapButton:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 54-xpos, ypos-54)
end

function OQ_MinimapButton_DraggingFrame_OnUpdate()
  local xpos,ypos = GetCursorPosition()
  local xmin,ymin = Minimap:GetLeft() or 400, Minimap:GetBottom() or 400 ;

  local scale = OQ_MinimapButton:GetEffectiveScale()
  xpos = xmin-xpos/scale+70
  ypos = ypos/scale-ymin-70

  OQ_toon.MinimapPos = math.deg(math.atan2(ypos,xpos))
  OQ_MinimapButton_Reposition() -- move the button
end


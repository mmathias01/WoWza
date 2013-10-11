local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs", "koKR")
if not L then return end
-- These localization strings are translated on WoWAce: http://www.wowace.com/addons/big-wigs/localization/
L["about"] = "정보"
L["activeBossModules"] = "사용 중인 보스 모듈:" -- Needs review
L["advanced"] = "고급 옵션"
L["allRightsReserved"] = "모든 권리 보유" -- Needs review
L["alphaOutdated"] = "사용 중인 Big Wigs 알파 버전의 날짜가 만료되었습니다 (/bwv)." -- Needs review
L["alphaRelease"] = "Big Wigs %s (revision %d) 의 알파 릴리스가 실행 중입니다." -- Needs review
L["already_registered"] = "|cffff0000경고:|r |cff00ff00%s|r (|cffffff00%d|r) 이미 Big Wigs 에서 보스 모듈로 존재하지만, 다시 등록이 필요합니다 (revision에 |cffffff00%d|r). 이 것은 일반적으로 애드온 업데이트 실패로 인하여 이 모듈이 당신의 애드온 폴더에 두개의 사본이 있는 것을 뜻합니다. 당신이 가지고 있는 Big Wigs 폴더의 삭제와 재설치를 권장합니다."
L["autoRole"] = "자동 역할 업데이트"
L["autoRoleDesc"] = [=[레이드에서 자신의 역할을 알리면 다른 사람들을 위해 Big Wigs 경고를 향상시킵니다. 이 옵션은 Big Wigs가 자동으로 당신의 역할을 업데이트하도록 합니다. 예를 들어 플레이어가 탱커이고, 우두머리의 능력이 탱커에게 영향을 미치지 않는 경우, 일부 모듈을 확인합니다.
|cffff4411이것은 역할별 특정 경고와 관련이 없으며, 이 옵션을 켜두도록 강력히 권장합니다!|r]=] -- Needs review
L["back"] = "<< 뒤로"
L["BAR"] = "바"
L["BAR_desc"] = "일부 기술에 대하여 적절한 바를 생성하여 표시합니다. 만약 옵션에서 체크를 해제하면 표시하지 않습니다. 크기 위치등 형태에 관한 설정은 '설정...'을 통하여 하실수 있습니다."
L["berserk"] = "광폭화"
L["berserk_desc"] = "보스가 언제 광폭화가 되는지 경고합니다."
L["bestkill"] = "Best Kill:"
L["blockMovies"] = "보스 영상 차단"
L["blockMoviesDesc"] = "보스 영상을 한번 본 이후, Big Wigs 를 통해 보스 영상을 차단 할수있습니다."
L["bosskill"] = "보스 사망"
L["bosskill_desc"] = "보스를 물리쳤을 때 알림니다."
L["chatMessages"] = "대화 창 메시지"
L["chatMessagesDesc"] = "모든 BigWigs 메세지를 디스플레이 설정에 추가된 기본 대화창에 출력합니다."
L["colors"] = "색상"
L["configure"] = "설정"
L["configureBtn"] = "설정 ..."
L["configureBtnDesc"] = [=[인터페이스 옵션 창을 닫습니다. 그리고 바와 같은 것들에 대한 메시지가 표시가 되며 구성할 수있습니다.

만약 더 많은 사용자 정의를 하고 싶다면, 왼쪽 옵션 트리에서 Big Wigs 옵션을 클릭하여 확장하여 '사용자 정의 ...' 찾으세요.]=]
L["contact"] = "연락처"
L["coreAddonDisabled"] = "%s 애드온 비활성화이기 때문에 Big Wigs가 제대로 작동하지 않습니다. 캐릭터 선택 화면에서 좌측하단의 '외부 인터페이스'에서 활성화/비활성화를 설정할 수 있습니다."
L["customizeBtn"] = "사용자 설정 ..."
L["dbmBar"] = "사용자 DBM 바 생성"
L["dbmBarDesc"] = "DBM 사용자가 풀링 타이머나 사용자 'pizza' 바를 보내면 Big Wigs에 표시합니다."
L["dbmFaker"] = "DBM 사용 확인"
L["dbmFakerDesc"] = "DBM 사용자가 DBM 사용을 체크하기 위해 버전 정보를 확인하면 그 목록에 표시되도록 합니다. DBM을 강제로 사용하는 길드에 유용합니다."
L["dbmUsers"] = "DBM users:"
L["defeated"] = "%s 물리침"
L["developers"] = "개발자"
L["DISPEL"] = "해제 가능할 때만"
L["DISPEL_desc"] = "당신이 해제 가능한 능력일 경우 경고를 사용합니다. 그렇지 않다면 이 옵션을 해제합니다."
L["dispeller"] = "|cFFFF0000해제 가능할 경우만 경고합니다.|r "
L["EMPHASIZE"] = "특수 강조"
L["EMPHASIZE_desc"] = "특수 강조 바를 통해 설정한 카운트와 번쩍임등 효과를 사용합니다."
L["FLASH"] = "깜박임"
L["FLASH_desc"] = "몇몇 능력이 다른 것보다 더 중요할 수 있습니다. 이 능력이 임박하거나 사용할 때 화면의 가장자리를 깜박이려면 이 옵션을 선택합니다."
L["flashScreen"] = "화면 깜박임"
L["flashScreenDesc"] = "중요 능력에 대한 주위가 필요할 때, 화면 가장자리에 깜박이는 효과를 냅니다."
L["flex"] = "Flex"
L["healer"] = "|cFFFF0000치유 전담만 경고합니다.|r "
L["HEALER"] = "치유 전담만"
L["HEALER_desc"] = "일부 능력은 치유 전담에게만 중요합니다. 당신의 역할에 대한 능력 경고를 표시하지 않으려면 이 옵션을 해제합니다."
L["heroic10"] = "10h"
L["heroic25"] = "25h"
L["ICON"] = "아이콘"
L["ICON_desc"] = "Big Wigs에서 일부 중요한 기술에 걸린 플레이어에게 전술 아이콘을 지정합니다."
L["introduction"] = "Big Wigs에 오신 것을 환영합니다. 보스와의 전투시 어느 정도의 여유를 드립니다. 귀하의 공격대 그룹을 위하여 새로운 보스와의 조우시 준비에 도움이 됩니다."
L["ircChannel"] = "irc.freenode.net의 #wowace 채널"
L["kills"] = "Kills:"
L["lfr"] = "LFR"
L["license"] = "라이센스"
L["listAbilities"] = "대화창에 스킬 목록 표시"
L["ME_ONLY"] = "자신일 때만"
L["ME_ONLY_desc"] = "이 옵션이 활성화되면 당신에게 영향을 주는 능력의 메시지를 표시합니다. 예를 들어, 자신일 경우 '폭발: 플레이어'로 표시합니다."
L["MESSAGE"] = "메시지" -- Needs review
L["MESSAGE_desc"] = "Big Wigs에서 기술에 대하여 게임 화면에 메세지를 표시합니다. 만약 옵션에서 체크를 해제하면 표시하지 않습니다. 크기 위치등 형태에 관한 설정은 '설정...'을 통하여 하실수 있습니다."
L["minimapIcon"] = "미니맵 아이콘"
L["minimapToggle"] = "미니맵 아이콘을 표시하거나 숨깁니다."
L["modulesDisabled"] = "모든 실행중인 모듈을 비활성화 합니다."
L["modulesReset"] = "활성화된 모든 모듈이 초기화 되었습니다."
L["newReleaseAvailable"] = "Big Wigs을 사용할 수있는 새로운 릴리즈 버전을 (/bwv)을 통해서 알수있으며, curse.com, wowinterface.com, wowace.com 또는 Curse Updater를 통하여 새로운 릴리스 버전을 찾아 사용할수 있습니다."
L["noBossMod"] = "No boss mod:"
L["norm10"] = "10"
L["norm25"] = "25"
L["officialRelease"] = "Big Wigs %s (revision %d) 의 공식 릴리스가 실행중입니다."
L["oldVersionsInGroup"] = "Big Wigs가 자신보다 최근 버전이나 이전 버전인 사람들을 /BWV 를 입력하여 확인 가능합니다."
L["outOfDate"] = "구 버전"
L["profiles"] = "프로필"
L["PROXIMITY"] = "근접 표시"
L["PROXIMITY_desc"] = "스킬에 대한 거리 측정이 필요합니다. 근접 표시는 당신이 안전한지 여부에 한 눈에를 알수있도록 기능이 특별히 설정됩니다."
L["PULSE"] = "깜박임" -- Needs review
L["PULSE_desc"] = "화면을 깜박이는 외에도 일시적으로 사용자의 관심을 사로잡기 위해 화면 중앙에 표시되는 특정 능력에 관련된 아이콘을 표시 할 수 있습니다."
L["raidIcons"] = "공격대 아이콘"
L["raidIconsDesc"] = [=[일부 '폭탄'과 같은 중요한 경고에 대하여 플레이어에게 공격대 전술을 지정합니다.

|cffff4411오직 공격대장이나 승급된 사람만이 가능합니다!|r]=]
L["resetPositions"] = "위치 초기화"
L["roleUpdate"] = "당신의 역할을 업데이트합니다."
L["SAY"] = "일반 대화"
L["SAY_desc"] = "당신이 기술에 걸렸을시 일반 대화로 알립니다. 말풍선으로 쉽게 구별하기 좋습니다."
L["selectEncounter"] = "교전 선택"
L["showBlizzWarnings"] = "블리자드 경고 표시"
L["showBlizzWarningsDesc"] = [=[블리자드에서 보스에 대한 몇몇 중요 능력에 대하여 경고를 제공합니다. 이러한 메세지를 Big Wigs에서 보다 쉽게 따로 메세지를 제공하기에 블리자드 경고가 방해가 될수 있습니다. 

|cffff4411이것을 끌경우 블리자드 경고가 화면 중앙에 나타나지 않지만, 여전히 대화창 프레임에는 표시가 됩니다.|r]=]
L["sound"] = "효과음"
L["soundDesc"] = [=[메세지와 함께 효과음을 사용합니다.

|cffff4411각 메세지에 대한 효과음이 있으며 그 효과음을 통하여 보다 효율적으로 메세지에 대하여 인지가 가능합니다.|r]=]
L["sourceCheckout"] = "저장소에서 Big Wigs %s 을 직접 소스를 체크 아웃을 실행하고 있습니다."
L["stages"] = "단계"
L["stages_desc"] = "근접 표시, 바, 기타등 보스의 다양한 단계(페이즈)에 관련된 기능을 사용합니다."
L["statistics"] = "통계"
L["tank"] = "|cFFFF0000방어 전담만 경고합니다.|r "
L["TANK"] = "방어 전담만"
L["TANK_desc"] = "일부 능력은 방어 전담에게만 중요합니다. 당신의 역할에 대한 능력 경고를 표시하지 않으려면 이 옵션을 해제합니다."
L["tankhealer"] = "|cFFFF0000방어 & 치유 전담만 경고합니다.|r "
L["TANK_HEALER"] = "방어 & 치유 전담만"
L["TANK_HEALER_desc"] = "일부 능력은 방어 전담과 치유 전담에게만 중요합니다. 당신의 역할에 대한 능력 경고를 표시하지 않으려면 이 옵션을 해제합니다."
L["test"] = "테스트"
L["thanks"] = "다양한 분야에서 개발을 위해 다음과 같은 사람들의 도움이 있었습니다."
L["tooltipHint"] = "|cffeda55f클릭|r : 모두 초기화 |cffeda55f알트-클릭|r 비활성화 |cffeda55f컨트롤-알트-클릭|r : BigWigs 비활성화."
L["upToDate"] = "최신 버전:"
L["website"] = "웹사이트"
L["wipes"] = "Wipes:"



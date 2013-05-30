﻿-- To update a translation please use the localization utility at:
-- http://wow.curseforge.com/addons/spellflash/localization/

local AddonName, a = ...
a.Localize = setmetatable({}, {__index = function(_, key) return key end})
local L = a.Localize

-- Example:
L["English text goes here."] = "Translated text goes here."

if GetLocale() == "ptBR" then -- Brazilian Portuguese
L["Asleep"] = "Adormecido"
L["Blink Spells"] = "Piscar das Magias"
L["Configure Class Module"] = "Configure o módulo de classe"
L["Default Proc Highlighting"] = "Padrão Destacar Proc" -- Needs review
L["Error loading:"] = "Erro ao carregar" -- Needs review
L["Flash Brightness:"] = "Intensidade do Brilho:"
L["Flash Macros"] = "Macros de Brilho"
L["Flash Size:"] = "Tamanho do Brilho:"
L["In Combat Only"] = "Somente em Combate"
L["Movement Check"] = "Verifique movimento"
L["Range Check"] = "Verifique o Alcance"
L["Selected Class Module:"] = "Módulo de classe selecionada:"
L["Shields"] = "Escudo"
L["Spell Flashing"] = "Brilho do Feitiço"
L["SpellFlash settings have been reset for all players"] = "Brilho do Feitiço foram redefinidas para todos os jogadores"
L["<SPELL> has not been defined in a table!"] = "<SPELL> não foi definido em uma função!" -- Needs review
L["This module has not been updated to work with the latest expansion:"] = "Este módulo não foi atualizado para trabalhar com a mais recente expansão:" -- Needs review
L["Use All Class Modules"] = "Use todos os módulos de classe"

elseif GetLocale() == "frFR" then -- French
L["Asleep"] = "Endormi"
L["Blink Spells"] = "Clignotement des sorts"
L["Configure Class Module"] = "Configurer le module de la classe"
L["Default Proc Highlighting"] = "Surbrillance du proc par défaut"
L["Error loading:"] = "Erreur de chargement :"
L["Flash Brightness:"] = "Luminosité du flash"
L["Flash Macros"] = "Flash sur les macro "
L["Flash Size:"] = "Taille du flash"
L["In Combat Only"] = "En combat seulement"
L["Movement Check"] = "vérification du mouvement"
L["Range Check"] = "vérification de la distance"
L["Selected Class Module:"] = "Module de classe sélectionné"
L["Shields"] = "Boucliers"
L["Spell Flashing"] = "Flash du sort"
L["SpellFlash settings have been reset for all players"] = "Les paramètres de Flash du sort ont été réinitialisés pour tous les personnages"
L["<SPELL> has not been defined in a table!"] = "<SPELL> n'a pas été défini dans une table ! "
L["This module has not been updated to work with the latest expansion:"] = "Ce module n'a pas été mis à jour pour fonctionner avec la dernière extension :"
L["Use All Class Modules"] = "Utiliser tous les modules de classe"

elseif GetLocale() == "deDE" then -- German
L["Asleep"] = "Schlafend"
L["Blink Spells"] = "Zaubersprüche aufblinken"
L["Configure Class Module"] = "Klassen-Module konfigurieren"
L["Default Proc Highlighting"] = "Standard Proc Hervorhebung"
-- L["Error loading:"] = ""
L["Flash Brightness:"] = "Aufblitz-Leuchtkraft:"
L["Flash Macros"] = "Aufblitz-Makros"
L["Flash Size:"] = "Aufblitz-Größe:"
L["In Combat Only"] = "Nur im Kampf"
L["Movement Check"] = "Bewegungsüberprüfung"
L["Range Check"] = "Reichweitenüberprüfung"
L["Selected Class Module:"] = "Ausgewählte Klassen-Module:"
L["Shields"] = "Schilde"
L["Spell Flashing"] = "Aufblitzende Zauber"
L["SpellFlash settings have been reset for all players"] = "SpellFlash-Einstellungen wurden für alle Spieler zurückgesetzt."
L["<SPELL> has not been defined in a table!"] = "<SPELL> wurde in keiner Funktion definiert!" -- Needs review
-- L["This module has not been updated to work with the latest expansion:"] = ""
L["Use All Class Modules"] = "Alle Klassen-Module verwenden"

elseif GetLocale() == "koKR" then -- Korean
L["Asleep"] = "수면"
L["Blink Spells"] = "주문 깜박거림"
L["Configure Class Module"] = "직업 모듈 설정"
L["Default Proc Highlighting"] = "기본 발동 효과 강조"
-- L["Error loading:"] = ""
L["Flash Brightness:"] = "번쩍임 밝기:"
L["Flash Macros"] = "매크로 번쩍임"
L["Flash Size:"] = "번쩍임 크기:"
L["In Combat Only"] = "전투 중에 한해"
L["Movement Check"] = "이동 확인"
L["Range Check"] = "사정 거리 확인"
L["Selected Class Module:"] = "선택된 직업 모듈:"
L["Shields"] = "방패"
L["Spell Flashing"] = "주문 번쩍임"
L["SpellFlash settings have been reset for all players"] = "SpellFlash 설정이 모든 플레이어에 대해 초기화 되었습니다."
-- L["<SPELL> has not been defined in a table!"] = ""
-- L["This module has not been updated to work with the latest expansion:"] = ""
L["Use All Class Modules"] = "모든 직업 모듈 사용"

elseif GetLocale() == "esMX" then -- Latin American Spanish
L["Asleep"] = "Dormido"
L["Blink Spells"] = "Parpadear hechizos"
L["Configure Class Module"] = "Configurar módulo de clase"
L["Default Proc Highlighting"] = "Resaltar proc por defecto"
L["Error loading:"] = "Error de carga:"
L["Flash Brightness:"] = "Brillo de destello:"
L["Flash Macros"] = "Hacer destellar las macros"
L["Flash Size:"] = "Tamaño de destello:"
L["In Combat Only"] = "Sólo en combate"
L["Movement Check"] = "Comprobación de movimiento"
L["Range Check"] = "Comprobación de rango"
L["Selected Class Module:"] = "Módulo de clase seleccionado:"
L["Shields"] = "Escudos"
L["Spell Flashing"] = "Destello de hechizo"
L["SpellFlash settings have been reset for all players"] = "Las opciones de SpellFlash han sido reiniciadas para todos los personajes"
L["<SPELL> has not been defined in a table!"] = "¡<SPELL> no se ha definido en una tabla!"
L["This module has not been updated to work with the latest expansion:"] = "Este módulo no ha sido actualizado para trabajar con la última expansión:"
L["Use All Class Modules"] = "Usar todos los módulos de clase"

elseif GetLocale() == "ruRU" then -- Russian
L["Asleep"] = "Сон"
L["Blink Spells"] = "Мигать заклинаниями"
L["Configure Class Module"] = "Настройка модуля класса"
L["Default Proc Highlighting"] = "Подсветка прока по умолчанию"
L["Error loading:"] = "Загрузка ошибки:" -- Needs review
L["Flash Brightness:"] = "Яркость подсветки:"
L["Flash Macros"] = "Подсвечивать макросы"
L["Flash Size:"] = "Размер подсветки:"
L["In Combat Only"] = "Только в режиме боя"
L["Movement Check"] = "Проверка движения"
L["Range Check"] = "Проверка дистанции"
L["Selected Class Module:"] = "Модуль выбранного класса"
L["Shields"] = "Щиты"
L["Spell Flashing"] = "Подсветка заклинания"
L["SpellFlash settings have been reset for all players"] = "Настройки SpellFlash были сброшены для всех игроков"
L["<SPELL> has not been defined in a table!"] = "Заклинание <SPELL> не найдено в списке!" -- Needs review
L["This module has not been updated to work with the latest expansion:"] = "Этот модуль не был обновлен для работы с последним дополнением:" -- Needs review
L["Use All Class Modules"] = "Использовать все модули классов"

elseif GetLocale() == "zhCN" then -- Simplified Chinese
L["Asleep"] = "睡眠" -- Needs review
L["Blink Spells"] = "闪动法术" -- Needs review
L["Configure Class Module"] = "设置职业分类" -- Needs review
L["Default Proc Highlighting"] = "默认Proc闪动" -- Needs review
L["Error loading:"] = "加载错误:" -- Needs review
L["Flash Brightness:"] = "闪动亮度" -- Needs review
L["Flash Macros"] = "闪动集合" -- Needs review
L["Flash Size:"] = "闪动尺寸" -- Needs review
L["In Combat Only"] = "只在战斗中" -- Needs review
L["Movement Check"] = "移动确定" -- Needs review
L["Range Check"] = "距离确定" -- Needs review
L["Selected Class Module:"] = "选定职业分类" -- Needs review
L["Shields"] = "盾牌" -- Needs review
L["Spell Flashing"] = "法术闪动" -- Needs review
L["SpellFlash settings have been reset for all players"] = "重置所有角色的SpellFlash设定" -- Needs review
L["<SPELL> has not been defined in a table!"] = "<SPELL> 还没有定义在函数式中" -- Needs review
L["This module has not been updated to work with the latest expansion:"] = "这个模组没有升级至最新版本,可能无法正常工作:" -- Needs review
L["Use All Class Modules"] = "使用所有职业分类" -- Needs review

elseif GetLocale() == "esES" then -- Spanish
L["Asleep"] = "Dormido"
L["Blink Spells"] = "Parpadear hechizos"
L["Configure Class Module"] = "Configurar Módulo de Clase"
-- L["Default Proc Highlighting"] = ""
-- L["Error loading:"] = ""
L["Flash Brightness:"] = "Brillo de Destello:" -- Needs review
L["Flash Macros"] = "Hacer destellar las Macros"
L["Flash Size:"] = "Tamaño de Destello:"
L["In Combat Only"] = "Sólo en combate" -- Needs review
L["Movement Check"] = "Comprobación de Movimiento"
L["Range Check"] = "Comprobación de Rango"
L["Selected Class Module:"] = "Módulo de Clase Seleccionado:"
L["Shields"] = "Escudos"
L["Spell Flashing"] = "Destello de Hechizo"
L["SpellFlash settings have been reset for all players"] = "Las opciones de SpellFlash han sido reiniciadas para todos los personajes"
-- L["<SPELL> has not been defined in a table!"] = ""
-- L["This module has not been updated to work with the latest expansion:"] = ""
L["Use All Class Modules"] = "Usar Todos los Módulos de Clase"

elseif GetLocale() == "zhTW" then -- Traditional Chinese
L["Asleep"] = "睡眠"
L["Blink Spells"] = "閃爍的法術"
L["Configure Class Module"] = "設定職業模組"
L["Default Proc Highlighting"] = "預設Proc顏色"
L["Error loading:"] = "載入錯誤:"
L["Flash Brightness:"] = "閃爍亮度"
L["Flash Macros"] = "閃爍巨集"
L["Flash Size:"] = "閃爍尺寸"
L["In Combat Only"] = "只用於戰門中"
L["Movement Check"] = "移動確認"
L["Range Check"] = "距離確認"
L["Selected Class Module:"] = "選定職業模組"
L["Shields"] = "盾牌"
L["Spell Flashing"] = "法術閃爍"
L["SpellFlash settings have been reset for all players"] = "重設所有角色的法術閃爍設定"
L["<SPELL> has not been defined in a table!"] = "<SPELL> 還沒有定義在函式中" -- Needs review
L["This module has not been updated to work with the latest expansion:"] = "這個模組沒有升級至最新版本,可能無法正常使用:"
L["Use All Class Modules"] = "使用所有職業模組"

end
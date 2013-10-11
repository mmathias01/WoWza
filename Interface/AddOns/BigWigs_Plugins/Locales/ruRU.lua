local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs: Plugins", "ruRU")
if not L then return end

-----------------------------------------------------------------------
-- Bars.lua
--

L["Style"] = "Стиль"
L.bigWigsBarStyleName_Default = "По умолчанию"

L["Clickable Bars"] = "Интерактивные полосы"
L.clickableBarsDesc = "Полосы Big Wigs по умолчанию не реагируют на щелчки мыши в их области. Таким образом, можно выделять объекты или применять АоЕ заклинания за ними, изменять ракурс камеры и т.д., в то время, как курсор находится в области полос. |cffff4411Если вы включите полосы, реагирующие на щелчки мыши, всё это будет невозможно.|r Полосы будут перехватывать любые щелчки мыши в пределах их области.\n"
L["Enables bars to receive mouse clicks."] = "Включает реагирование полос на щелчки мыши."
L["Modifier"] = "Модификатор"
L["Hold down the selected modifier key to enable click actions on the timer bars."] = "Удерживайте выбранную клавишу, чтобы разрешить нажатие по полосе таймера."
L["Only with modifier key"] = "Только с клавишей-модификатором"
L["Allows bars to be click-through unless the specified modifier key is held down, at which point the mouse actions described below will be available."] = "Блокирует нажатие на полосы, за исключением удерживания заданной клавиши, после чего действия мышкой, описанные ниже, будут доступны."

L["Temporarily Super Emphasizes the bar and any messages associated with it for the duration."] = "Временное Супер Увеличение полосы и всех связанных с ней сообщений в течение всего срока действия."
L["Report"] = "Сообщить"
L["Reports the current bars status to the active group chat; either instance chat, raid, party or say, as appropriate."] = "Сообщает текущий статус полосы в активный групповой чат; будь то чат подземелья, рейда, группы или гильдии."
L["Remove"] = "Убрать"
L["Temporarily removes the bar and all associated messages."] = "Временно убирает полосу и все связанные с ней сообщения."
L["Remove other"] = "Убрать другие"
L["Temporarily removes all other bars (except this one) and associated messages."] = "Временно удаляет все другие полосы (кроме этой) и связанные с ними сообщения."
L.disable = "Отключить"
L["Permanently disables the boss encounter ability option that spawned this bar."] = "Полностью отключает способность босса, которая вызывает эту полосу."

L["Emphasize at... (seconds)"] = "Увеличение на... (секунды)"
L["Scale"] = "Масштаб"
L["Grow upwards"] = "Рост вверх"
L["Toggle bars grow upwards/downwards from anchor."] = "Переключение направления роста полос вверх или вниз."
L["Texture"] = "Текстура"
L["Emphasize"] = "Увеличение"
L["Enable"] = "Включить"
L["Move"] = "Перемещение"
L.moveDesc = "Перемещение увеличенных полос. Если эта опция отключена, увеличенные полосы просто будут изменять масштаб и окраску."
L["Regular bars"] = "Обычные полосы"
L["Emphasized bars"] = "Увеличенные полосы"
L["Align"] = "Выравнивание"
L["Left"] = "Влево"
L["Center"] = "По центру"
L["Right"] = "Вправо"
L["Time"] = "Время"
L["Whether to show or hide the time left on the bars."] = "Показывать или скрывать остаток времени на полосах."
L["Icon"] = "Иконка"
L["Shows or hides the bar icons."] = "Показывать или скрывать иконку полосы."
L.font = "Шрифт"
L["Restart"] = "Перезапуск"
L["Restarts emphasized bars so they start from the beginning and count from 10."] = "Перезапуск увеличенных полос так, что они стартуют с самого начала, отсчитывая от 10."
L["Fill"] = "Заполнение"
L["Fills the bars up instead of draining them."] = "Заполнение полос, вместо убывания."

L["Local"] = "Локальный"
L["%s: Timer [%s] finished."] = "%s: Таймер [%s] готов."
L["Custom bar '%s' started by %s user %s."] = "Таймер '%s' начат %s игроком %s."

L["Pull"] = "Атака"
L["Pulling!"] = "Выступаем!"
L["Pull timer started by %s user %s."] = "Таймер атаки начат %s игроком %s."
L["Pull in %d sec"] = "Атакуем через %d сек"
L["Sending a pull timer to Big Wigs and DBM users."] = "Отправка таймера атаки пользователям Big Wigs и DBM."
L["Sending custom bar '%s' to Big Wigs and DBM users."] = "Отправка таймера '%s' пользователям Big Wigs и DBM."
L["This function requires raid leader or raid assist."] = "Эта функция требует быть лидером рейда или помощником."
L["Must be between 1 and 60. A correct example is: /pull 5"] = "Должно быть между 1 и 60. Например: /pull 5"
L["Incorrect format. A correct example is: /raidbar 20 text"] = "Неверный формат. Правильно будет: /raidbar 20 текст"
L["Invalid time specified. <time> can be either a number in seconds, a M:S pair, or Mm. For example 5, 1:20 or 2m."] = "Неверно указанное время. <время> может быть числом в секундах, М:С парой, или Mm. Например, 5, 1:20 или 2m."
L["This function can't be used during an encounter."] = "Это функция не может быть использована во время битвы."
L["Pull timer cancelled by %s."] = "Таймер атаки отменен |3-4(%s)."



-- These localization strings are translated on WoWAce: http://www.wowace.com/addons/big-wigs/localization/
L["abilityName"] = "Название способности"
L["abilityNameDesc"] = "Показывает или скрывает название способности в верхней части окна."
L["Alarm"] = "Тревога"
L["Alert"] = "Оповещение"
L["Attention"] = "Внимание"
L["background"] = "Фон"
L["backgroundDesc"] = "Показать или скрыть фон."
L["bars"] = "Полосы"
L["bestTimeBar"] = "Лучшее время"
L["Beware"] = "Берегитесь (Алгалон)"
L["bossDefeatDurationPrint"] = "'%s' терпит поражение спустя %s"
L["bossStatistics"] = "Статистика боссов"
L["bossStatsDescription"] = "Запись статистики боссов, включает в себя количество побед, поражений, общее время сражений или самое быстрое убийство. Эта статистика видна для каждого босса в окне настроек, либо спрятана, если нет записей."
L["bossWipeDurationPrint"] = "'%s' побеждает спустя %s"
L["bwEmphasized"] = "Big Wigs Увеличение"
L["chatMessages"] = "Сообщения в чат"
L["classColors"] = "Окраска по классу"
L["classColorsDesc"] = "Имена игроков окрасятся в их класс."
L["close"] = "Закрыть"
L["closeButton"] = "Кнопка закрытия"
L["closeButtonDesc"] = "Показать или скрыть кнопку закрытия."
L["closeProximityDesc"] = [=[Закрыть окно модуля близости.

Чтобы полностью его отключить для любого боя, вам нужно зайти в опции соответствующего босса и там отключить опцию 'Близость'.]=]
L["colors"] = "Цвета"
L["countDefeats"] = "Количество побед"
L["countdown"] = "Отсчет времени"
L["countdownDesc"] = "Если соответствующий таймер больше, чем 5 секунд, звуковой и визуальный отсчет времени будет добавлен для последних 5 секунд."
L["countWipes"] = "Количество поражений"
L["createTimeBar"] = "Отображать полосу 'Лучшее время'"
L["customRange"] = "Пользовательский индикатор досягаемости"
L["customSoundDesc"] = "Воспроизводить пользовательский звук, вместо используемого в модуле"
L["defaultOnly"] = "Только стандартные"
L["Destruction"] = "Разрушение (Кил'джеден)"
L["disabled"] = "Отключить"
L["disabledDesc"] = "Отключить отображение окна близости для всех модулей, использующих его."
L["displayTime"] = "Время отображения"
L["displayTimeDesc"] = "Сколько секунд будет показываться сообщение"
L["doubleSize"] = "Двойной размер"
L["doubleSizeDesc"] = "Удвоит размер супер увеличенных полос и сообщений."
L["emphasized"] = "Увеличенные"
L["emphasizedCountdown"] = "Увеличенный обратный отсчет"
L["emphasizedCountdownSinkDescription"] = "Пути вывода увеличенных сообщений с обратным отсчетом. Отображение поддерживает текст и цвета, и позволяет вывести одно сообщение за один раз."
L["emphasizedMessages"] = "Увеличенные сообщения"
L["emphasizedSinkDescription"] = "Пути вывода увеличенных сообщений. Отображение поддерживает текст и цвета, и позволяет вывести одно сообщение за один раз."
L["enableStats"] = "Включить Статистику"
L["fadeTime"] = "Время затухания"
L["fadeTimeDesc"] = "Сколько секунд будет затухать сообщение"
L["FlagTaken"] = "Взятие флага (PvP)"
L["flash"] = "Мигание"
L["fontColor"] = "Цвет шрифта"
L["fontSize"] = "Размер шрифта"
L["icons"] = "Метки"
L["Important"] = "Важные"
L["Info"] = "Информация"
L["lock"] = "Фиксировать"
L["lockDesc"] = "Фиксирование рамки, предотвращает перемещение и изменение размера."
L["Long"] = "Долгий"
L["messages"] = "Сообщения"
L["monochrome"] = "Монохромный"
L["monochromeDesc"] = "Включение монохромного флага, убирается любое сглаживание краев шрифта."
L["Neutral"] = "Нейтральные"
L["newBestTime"] = "Рекордное убийство!"
L["none"] = "Нет"
L["normal"] = "Обычные"
L["normalMessages"] = "Обычные сообщения"
L["outline"] = "Контур"
L["output"] = "Вывод"
L["Personal"] = "Личные"
L["Positive"] = "Положительные"
L["primary"] = "Основная"
L["primaryDesc"] = "Первая метка рейда, которая будет использоваться скриптом события."
L["printBestTimeOption"] = "Уведомление о лучшем убийстве"
L["printDefeatOption"] = "Время победы"
L["printWipeOption"] = "Время поражения"
L["proximity"] = "Отображение близости"
L["proximity_desc"] = "Показывать окно близости при соответствующей схватке, выводя список игроков, которые стоят слишком близко к вам."
L["proximityTitle"] = "%d м / %d |4игрок:игрока:игроков;"
L["raidIconsDescription"] = [=[Некоторые битвы могут включать способности типа 'бомба', накладываемые на определенных игроков или способности преследования. Здесь вы можете настроить рейдовые метки, используемые для обозначения таких игроков.

Если в битве имеется только одна такая способность, будет использована первая метка. Одна метка никогда не будет использована для разных способностей, в следующий раз будет использована та же иконка.

|cffff4411Помните, если игрок был отмечен вручную, Big Wigs не будет менять его метку.|r]=]
L["recordBestTime"] = "Запоминать лучшее убийство"
L["reset"] = "Сброс"
L["resetAll"] = "Сбросить все"
L["resetAllCustomSound"] = "Если вы используете свои звуки для какой-либо битвы, это кнопка спросит ВСЕ такие звуки на стандартные."
L["resetAllDesc"] = "Если вы настроили цвета для каких-либо событий боя с боссом, эта кнопка сбросит ВСЕ такие настройки."
L["resetDesc"] = "Сброс цветов на стандартные значения."
L["RunAway"] = "Беги, малышка, беги (Злой и страшный серый волк)"
L["secondary"] = "Второстепенная"
L["secondaryDesc"] = "Вторая метка рейда, которая будет использоваться скриптом события."
L["showHide"] = "Показ/скрыть"
L["sinkDescription"] = "Пути вывода сообщений. Отображение поддерживает иконки, цвета и позволяет вывести до 4х сообщений на экран. Новые сообщения будут расти в размерах, и вновь сокращатся, чтобы уведомить игрока."
L["sound"] = "Звук"
L["soundButton"] = "Кнопка звука"
L["soundButtonDesc"] = "Показать или скрыть кнопку звука."
L["soundDefaultDescription"] = "При выборе данной опции Big Wigs будет использовать только стандартные звуки объявления рейду для тех сообщений, которые сопровождаются звуковым сигналом. Помните, что только некоторые сообщения из скриптов сражений сопровождаются звуковым сигналом."
L["soundDelay"] = "Задержка звука"
L["soundDelayDesc"] = "Определяет как долго Big Wigs должен подождать между повторением заданного звука, когда кто-то слишком близко к вам."
L["Sounds"] = "Звуки"
L["superEmphasize"] = "Супер Увеличение"
L["superEmphasizeDesc"] = [=[Увеличивает полосы и сообщения, относящиеся к определенным способностям босса.

Здесь вы можете настроить, что должно произойти, когда вы включаете супер увеличение в расширенном разделе способностей босса.

|cffff4411Помните, что супер увеличение отключено по умолчанию для всех способностей.|r
]=]
L["text"] = "Текст"
L["textShadow"] = "Тень текста"
L["thick"] = "Толстый"
L["thin"] = "Тонкий"
L["title"] = "Название"
L["titleDesc"] = "Показать или скрыть название."
L["toggleProximityPrint"] = "Модуль близости будет показан в следующий раз. Чтобы полностью его отключить для данного боя, вам нужно зайти в опции этого боя и отключить его там."
L["toggleSound"] = "Переключение звука"
L["toggleSoundDesc"] = "Включить/выключить звуковое оповещение окна близости, когда вы находитесь слишком близко к другому игроку."
L["tooltip"] = "Подсказка"
L["tooltipDesc"] = "Показывает или скрывает подсказку заклинания в окне близости, если эта способность связана боссом."
L["uppercase"] = "БОЛЬШИМИ БУКВАМИ"
L["uppercaseDesc"] = "Отображать все сообщения, связанные с настройками супер увеличения, в верхнем регистре"
L["Urgent"] = "Экстренные"
L["useColors"] = "Использовать цвета"
L["useColorsDesc"] = "Не раскрашивать сообщения (белый текст)."
L["useIcons"] = "Использовать иконки"
L["useIconsDesc"] = "Показывать иконку возле сообщения."
L["Victory"] = "Победа"
L["Warning"] = "Предупреждение"



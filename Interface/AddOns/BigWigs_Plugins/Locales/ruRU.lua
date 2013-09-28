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
L["Disable"] = "Отключить"
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
L["Font"] = "Шрифт"
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

L.customBarSlashPrint = "Данная функция переименована. Используйте /raidbar чтобы отправить полосу в рейд или /localbar для полосы, которую увидите только вы."

-----------------------------------------------------------------------
-- Colors.lua
--

L.Colors = "Цвета"

L.Messages = "Сообщения"
L.Bars = "Полосы"
L.Background = "Фон"
L.Text = "Текст"
L.TextShadow = "Тень текста"
L.Flash = "Мигание"
L.Normal = "Обычные"
L.Emphasized = "Увеличенные"

L.Reset = "Сброс"
L["Resets the above colors to their defaults."] = "Сброс цветов на стандартные значения."
L["Reset all"] = "Сбросить все"
L["If you've customized colors for any boss encounter settings, this button will reset ALL of them so the colors defined here will be used instead."] = "Если вы настроили цвета для каких-либо событий боя с боссом, эта кнопка сбросит ВСЕ такие настройки."

L.Important = "Важные"
L.Personal = "Личные"
L.Urgent = "Экстренные"
L.Attention = "Внимание"
L.Positive = "Положительные"
L.Neutral = "Нейтральные"

-----------------------------------------------------------------------
-- Emphasize.lua
--

L["Super Emphasize"] = "Супер Увеличение"
L.superEmphasizeDesc = "Увеличивает полосы и сообщения, относящиеся к определенным способностям босса.\n\nЗдесь вы можете настроить, что должно произойти, когда вы включаете супер увеличение в расширенном разделе способностей босса.\n\n|cffff4411Помните, что супер увеличение отключено по умолчанию для всех способностей.|r\n"
L["UPPERCASE"] = "БОЛЬШИМИ БУКВАМИ"
L["Uppercases all messages related to a super emphasized option."] = "Отображать все сообщения, связанные с настройками супер увеличения, в верхнем регистре"
L["Double size"] = "Двойной размер"
L["Doubles the size of super emphasized bars and messages."] = "Удвоит размер супер увеличенных полос и сообщений."
L["Countdown"] = "Отсчет времени"
L["If a related timer is longer than 5 seconds, a vocal and visual countdown will be added for the last 5 seconds. Imagine someone counting down \"5... 4... 3... 2... 1... COUNTDOWN!\" and big numbers in the middle of your screen."] = "Если соответствующий таймер больше, чем 5 секунд, звуковой и визуальный отсчет времени будет добавлен для последних 5 секунд."

-----------------------------------------------------------------------
-- Messages.lua
--

L.sinkDescription = "Пути вывода сообщений. Отображение поддерживает иконки, цвета и позволяет вывести до 4х сообщений на экран. Новые сообщения будут расти в размерах, и вновь сокращатся, чтобы уведомить игрока."
L.emphasizedSinkDescription = "Пути вывода увеличенных сообщений. Отображение поддерживает текст и цвета, и позволяет вывести одно сообщение за один раз."
L.emphasizedCountdownSinkDescription = "Пути вывода увеличенных сообщений с обратным отсчетом. Отображение поддерживает текст и цвета, и позволяет вывести одно сообщение за один раз."

L["Big Wigs Emphasized"] = "Big Wigs Увеличение"
L["Messages"] = "Сообщения"
L["Normal messages"] = "Обычные сообщения"
L["Emphasized messages"] = "Увеличенные сообщения"
L["Output"] = "Вывод"
L["Emphasized countdown"] = "Увеличенный обратный отсчет"

L["Use colors"] = "Использовать цвета"
L["Toggles white only messages ignoring coloring."] = "Не раскрашивать сообщения (белый текст)."

L["Use icons"] = "Использовать иконки"
L["Show icons next to messages, only works for Raid Warning."] = "Отображать иконки сообщений, работает только для объявлений рейда."

L["Class colors"] = "Окраска по классу"
L["Colors player names in messages by their class."] = "Окрашивает имя игрока в сообщениях в соответствии с его классом."

L["Font size"] = "Размер шрифта"
L["None"] = "Нет"
L["Thin"] = "Тонкий"
L["Thick"] = "Толстый"
L["Outline"] = "Контур"
L["Monochrome"] = "Монохромный"
L["Toggles the monochrome flag on all messages, removing any smoothing of the font edges."] = "Переключение монохромного флага на всех сообщениях, удаляя все сглаживание краев шрифта."
L["Font color"] = "Цвет шрифта"

L["Display time"] = "Время отображения"
L["How long to display a message, in seconds"] = "Сколько секунд будет показываться сообщение"
L["Fade time"] = "Время затухания"
L["How long to fade out a message, in seconds"] = "Сколько секунд будет затухать сообщение"

-----------------------------------------------------------------------
-- Proximity.lua
--

L["Custom range indicator"] = "Пользовательский индикатор досягаемости"
L.proximityTitle = "%d м / %d |4игрок:игрока:игроков;"
L["Proximity"] = "Близость"
L.sound = "Звук"
L["Disabled"] = "Отключить"
L["Disable the proximity display for all modules that use it."] = "Отключить отображение окна близости для всех модулей, использующих его."
L["The proximity display will show next time. To disable it completely for this encounter, you need to toggle it off in the encounter options."] = "Модуль близости будет показан в следующий раз. Чтобы полностью его отключить для данного боя, вам нужно зайти в опции этого боя и отключить его там."
L["Sound delay"] = "Задержка звука"
L["Specify how long Big Wigs should wait between repeating the specified sound when someone is too close to you."] = "Определяет как долго Big Wigs должен подождать между повторением заданного звука, когда кто-то слишком близко к вам."

L.proximity = "Отображение близости"
L.proximity_desc = "Показывать окно близости при соответствующей схватке, выводя список игроков, которые стоят слишком близко к вам."

L["Close"] = "Закрыть"
L["Closes the proximity display.\n\nTo disable it completely for any encounter, you have to go into the options for the relevant boss module and toggle the 'Proximity' option off."] = "Закрыть окно модуля близости.\n\nЧтобы полностью его отключить для любого боя, вам нужно зайти в опции соответствующего босса и там отключить опцию 'Близость'."
L["Lock"] = "Фиксировать"
L["Locks the display in place, preventing moving and resizing."] = "Фиксирование рамки, предотвращает перемещение и изменение размера."
L["Title"] = "Название"
L["Shows or hides the title."] = "Показать или скрыть название."
L["Background"] = "Фон"
L["Shows or hides the background."] = "Показать или скрыть фон."
L["Toggle sound"] = "Переключение звука"
L["Toggle whether or not the proximity window should beep when you're too close to another player."] = "Включить/выключить звуковое оповещение окна близости, когда вы находитесь слишком близко к другому игроку."
L["Sound button"] = "Кнопка звука"
L["Shows or hides the sound button."] = "Показать или скрыть кнопку звука."
L["Close button"] = "Кнопка закрытия"
L["Shows or hides the close button."] = "Показать или скрыть кнопку закрытия."
L["Show/hide"] = "Показ/скрыть"
L["Ability name"] = "Название способности"
L["Shows or hides the ability name above the window."] = "Показывает или скрывает название способности в верхней части окна."
L["Tooltip"] = "Подсказка"
L["Shows or hides a spell tooltip if the Proximity display is currently tied directly to a boss encounter ability."] = "Показывает или скрывает подсказку заклинания в окне близости, если эта способность связана боссом."

-----------------------------------------------------------------------
-- RaidIcon.lua
--

L["Icons"] = "Метки"

L.raidIconsDescription = "Некоторые битвы могут включать способности типа 'бомба', накладываемые на определенных игроков или способности преследования. Здесь вы можете настроить рейдовые метки, используемые для обозначения таких игроков.\n\nЕсли в битве имеется только одна такая способность, будет использована первая метка. Одна метка никогда не будет использована для разных способностей, в следующий раз будет использована та же иконка.\n\n|cffff4411Помните, если игрок был отмечен вручную, Big Wigs не будет менять его метку.|r"
L["Primary"] = "Основная"
L["The first raid target icon that a encounter script should use."] = "Первая метка рейда, которая будет использоваться скриптом события."
L["Secondary"] = "Второстепенная"
L["The second raid target icon that a encounter script should use."] = "Вторая метка рейда, которая будет использоваться скриптом события."

L["Star"] = "Звезда"
L["Circle"] = "Круг"
L["Diamond"] = "Ромб"
L["Triangle"] = "Треугольник"
L["Moon"] = "Луна"
L["Square"] = "Квадрат"
L["Cross"] = "Крест"
L["Skull"] = "Череп"
L["|cffff0000Disable|r"] = "|cffff0000Отключить|r"

-----------------------------------------------------------------------
-- Sound.lua
--

L.soundDefaultDescription = "При выборе данной опции Big Wigs будет использовать только стандартные звуки объявления рейду для тех сообщений, которые сопровождаются звуковым сигналом. Помните, что только некоторые сообщения из скриптов сражений сопровождаются звуковым сигналом."

L.Sounds = "Звуки"

L.Alarm = "Тревога"
L.Info = "Информация"
L.Alert = "Оповещение"
L.Long = "Долгий"
L.Warning = "Предупреждение"
L.Victory = "Победа"

L.Beware = "Берегитесь (Алгалон)"
L.FlagTaken = "Взятие флага (PvP)"
L.Destruction = "Разрушение (Кил'джеден)"
L.RunAway = "Беги, малышка, беги (Злой и страшный серый волк)"

L["Set the sound to use for %q.\n\nCtrl-Click a sound to preview."] = "Установите звук для использования в %q.\n\n[Ctrl-Клик] для предварительного прослушивания звука."
L["Default only"] = "Только стандартные"

L.customSoundDesc = "Воспроизводить пользовательский звук, вместо используемого в модуле"
L.resetAllCustomSound = "Если вы используете свои звуки для какой-либо битвы, это кнопка спросит ВСЕ такие звуки на стандартные."

-----------------------------------------------------------------------
-- Statistics.lua
--

L.bossKillDurationPrint = "'%s' терпит поражение спустя %s"
L.bossWipeDurationPrint = "'%s' побеждает спустя %s"
L.newBestKill = "Рекордное убийство!"
L.bossStatistics = "Статистика боссов"
L.bossStatsDescription = "Запись статистики боссов, включает в себя количество побед, поражений, общее время сражений или самое быстрое убийство. Эта статистика видна для каждого босса в окне настроек, либо спрятана, если нет записей."
L.enableStats = "Включить Статистику"
L.chatMessages = "Сообщения в чат"
L.printBestKillOption = "Уведомление о лучшем убийстве"
L.printKillOption = "Время победы"
L.printWipeOption = "Время поражения"
L.countKills = "Количество побед"
L.countWipes = "Количество поражений"
L.recordBestKills = "Запоминать лучшее убийство"
L.createTimeBar = "Отображать полосу 'Лучшее время'"
L.bestTimeBar = "Лучшее время"


local L = BigWigs:NewBossLocale("Immerseus", "esES") or BigWigs:NewBossLocale("Immerseus", "esMX")
if not L then return end
if L then
L["win_yell"] = "Ah ¡Lo has hecho!"

end

L = BigWigs:NewBossLocale("The Fallen Protectors", "esES") or BigWigs:NewBossLocale("The Fallen Protectors", "esMX")
if L then
L["defile_you"] = "Suelo Mancillado debajo de ti" -- Needs review
L["defile_you_desc"] = "Advertencia cuando Suelo Mancillado esté debajo de ti" -- Needs review
L["inferno_self"] = "Golpe de Infierno en ti" -- Needs review
L["inferno_self_bar"] = "¡Vas a explotar!" -- Needs review
L["inferno_self_desc"] = "Cuenta atrás especial cuando tengas Golpe de Infierno" -- Needs review
L["intermission_desc"] = "Advertir cuando los jefes usen Medidas Desesperadas." -- Needs review
L["no_meditative_field"] = "¡No estas en la burbuja!" -- Needs review


	L.custom_off_bane_marks = "Palabra de las Sombras: terror marcador"
	L.custom_off_bane_marks_desc = "Para ayudar a asignar los dispels, marca inicialmente a la gente que tiene Palabra de las Sombras: terror en ellos con {rt1}{rt2}{rt3}{rt4}{rt5} (en este orden, puede que no se usen todas las marcas), requiere ayudante o líder."
end

L = BigWigs:NewBossLocale("Norushen", "esES") or BigWigs:NewBossLocale("Norushen", "esMX")
if L then
L["big_add"] = "Esbirro grande (%d)"
L["big_add_killed"] = "Esbirro grande muerto (%d)"
L["big_adds"] = "Esbirros grandes"
L["big_adds_desc"] = "Alertas para la aparición de esbirros grandes y sus muertes."
L["warmup_trigger"] = "Muy bien, creare un campo que contendrá la corrupción en cuarentena."

end

L = BigWigs:NewBossLocale("Sha of Pride", "esES") or BigWigs:NewBossLocale("Sha of Pride", "esMX")
if L then
L["titan_pride"] = "Titán+Orgullo: %s" -- Needs review


	L.custom_off_titan_mark = "Marcador de Ofrenda de los titanes"
	L.custom_off_titan_mark_desc = "Marca la gente que tiene Ofrenda de los titanes con {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}{rt8}, requiere ayudante o líder.\n|cFFFF0000Solo 1 persona de la raid debería tener activada esta opción para prevenir conflictos con las marcas.|r"

	L.custom_off_fragment_mark = "Marcador de Fragmento corrupto"
	L.custom_off_fragment_mark_desc = "Marca los Fragmentos corruptos con {rt8}{rt7}{rt6}, requiere ayudante o líder.\n|cFFFF0000Solo 1 persona de la raid deberia tener activada esta opción para prevenir conflictos con las marcas.\nEn modo de 25 jugadores, estó provocará conflictos con el marcador de Ofrenda de los titanes.|r"
end

L = BigWigs:NewBossLocale("Galakras", "esES") or BigWigs:NewBossLocale("Galakras", "esMX")
if L then
L["adds_desc"] = "Temporizadores cuando un nuevo grupo de esbirros entren en el combate." -- Needs review
L["demolisher_message"] = "Demoledor" -- Needs review
L["drakes"] = "Protodracos" -- Needs review
L["north_tower"] = "Torre Norte" -- Needs review
L["north_tower_trigger"] = "¡La puerta de la Torre Norte se ha roto!" -- Needs review
L["south_tower"] = "Torre Sur" -- Needs review
L["south_tower_trigger"] = "¡La puerta de la Torre Sur se ha roto!" -- Needs review
L["tower_defender"] = "Defensor de la Torre" -- Needs review
L["towers"] = "Torres" -- Needs review
L["towers_desc"] = "Advertencia cuando las torres se rompan." -- Needs review
L["warlord_zaela"] = "Señora de la guerra Zaela"


	L.custom_off_shaman_marker = "Marcador del Chamán"
	L.custom_off_shaman_marker_desc = "Para ayudar con las interrupciones, marca los Chamanes de mareas Faucedraco con {rt1}{rt2}{rt3}{rt4}{rt5}, requiere ayudante o líder.\n|cFFFF0000Solo 1 persona de la raid debería tener esta opción activada para prevenir conflictos con las marcas.|r\n|cFFADFF2FCONSEJO: Si la raid te ha elegido para que la actives, mover rápidamente el ratón por encima de los chamanes es la manera más rápida de marcarlos.|r"
end

L = BigWigs:NewBossLocale("Iron Juggernaut", "esES") or BigWigs:NewBossLocale("Iron Juggernaut", "esMX")
if L then
	L.custom_off_mine_marks = "Marcador de Minas"
	L.custom_off_mine_marks_desc = "Para ayudar con las asignaciones de las minas, marca las Minas reptadoras con {rt1}{rt2}{rt3}, requiere ayudante o líder.\n|cFFFF0000Solo 1 persona de la raid debería tener activada esta opción para prevenir coflictos con las marcas.|r\n|cFFADFF2FCONSEJO: Si la raid te ha elegido para que la actives, mover rápidamente el ratón por encima de todas las minas es la manera más rápida de marcarlas.|r"

end

L = BigWigs:NewBossLocale("Kor'kron Dark Shaman", "esES") or BigWigs:NewBossLocale("Kor'kron Dark Shaman", "esMX")
if L then


	L.custom_off_mist_marks = "Marcador de Niebla tóxica"
	L.custom_off_mist_marks_desc = "Para ayudar con las tareas de sanación, marca la gente que tiene Niebla tóxica con {rt1}{rt2}{rt3}{rt4}{rt5}, requiere ayudante o líder.\n|cFFFF0000Solo 1 persona de la raid debería tener activada esta opción para prevenir conflictos con las marcas.|r"
end

L = BigWigs:NewBossLocale("General Nazgrim", "esES") or BigWigs:NewBossLocale("General Nazgrim", "esMX")
if L then
	L.custom_off_bonecracker_marks = "Marcador de Partehuesos"
	L.custom_off_bonecracker_marks_desc = "Para ayudar en las tareas de sanación, marca la gente que tiene Partehuesos con {rt1}{rt2}{rt3}{rt4}{rt5}, requiere ayudante o líder.\n|cFFFF0000Solo 1 persona de la raid debería tener activada esta opción para prevenir conflictos con las marcas.|r"

	L.stance_bar = "%s(AHORA:%s)"
	-- shorten stances so they fit on the bars
	L.battle = "Batalla"
	L.berserker = "Rabiosa"
	L.defensive = "Defensiva"

	L.adds_trigger1 = "¡Defended la puerta!"
	L.adds_trigger2 = "¡Reunid a las tropas!"
	L.adds_trigger3 = "¡Siguiente escuadrón, al frente!"
	L.adds_trigger4 = "¡Guerreros, paso ligero!"
	L.adds_trigger5 = "¡Kor'kron, conmigo!"
	--L.adds_trigger_extra_wave = "All Kor'kron... under my command... kill them... NOW!"
	L.extra_adds = "Adds extra"
	L.final_wave = "Oleada final"

	L.chain_heal_message = "¡Tu foco está casteando Sanación en cadena!"

	L.arcane_shock_message = "¡Tu foco está casteando Choque Arcano!"
end

L = BigWigs:NewBossLocale("Malkorok", "esES") or BigWigs:NewBossLocale("Malkorok", "esMX")
if L then

end

L = BigWigs:NewBossLocale("Spoils of Pandaria", "esES") or BigWigs:NewBossLocale("Spoils of Pandaria", "esMX")
if L then

end

L = BigWigs:NewBossLocale("Thok the Bloodthirsty", "esES") or BigWigs:NewBossLocale("Thok the Bloodthirsty", "esMX")
if L then
L["adds_desc"] = "Alarmas para cuando el Yeti o los murciélagos se unan al combate."
L["cage_opened"] = "Jaula abierta"
L["npc_akolik"] = "Akolik"
L["npc_waterspeaker_gorai"] = "Orador del agua Gorai"

end

L = BigWigs:NewBossLocale("Siegecrafter Blackfuse", "esES") or BigWigs:NewBossLocale("Siegecrafter Blackfuse", "esMX")
if L then

end

L = BigWigs:NewBossLocale("Paragons of the Klaxxi", "esES") or BigWigs:NewBossLocale("Paragons of the Klaxxi", "esMX")
if L then

end

L = BigWigs:NewBossLocale("Garrosh Hellscream", "esES") or BigWigs:NewBossLocale("Garrosh Hellscream", "esMX")
if L then

end


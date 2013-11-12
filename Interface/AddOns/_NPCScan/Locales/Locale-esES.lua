--[[****************************************************************************
  * _NPCScan by Saiket                                                         *
  * Locales/Locale-esES.lua - Localized string constants (es-ES/es-MX).        *
  ****************************************************************************]]


if ( GetLocale() ~= "esES" and GetLocale() ~= "esMX" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan/localization/esES/
local private = select( 2, ... );
private.L = setmetatable( {
	NPCs = setmetatable( {
	}, { __index = private.L.NPCs; } );
}, { __index = private.L; } );

-- private.L["BLOCKFLIGHTSCAN"] = "Supresses Alerts while on a flight path."
-- private.L["BLOCKFLIGHTSCAN_DESC"] = "Suppresses Alerts while on a flight path.  Note: Mob will still be cached and will not get an alert until the cache is cleared."
private.L["BUTTON_FOUND"] = "NPC Encontrado!"
private.L["CACHED_FORMAT"] = "Los siguientes NPC se encuentran en la cache: %s"
private.L["CACHED_LONG_FORMAT"] = "Los siguientes NPC ya han sido encontrados. Piensate el borrarlos usando el menu de |cff808080“/npcscan”|r o reiniciarlos borrando su cache: %s"
private.L["CACHED_PET_RESTING_FORMAT"] = "La(s) siguiente(s) mascota(s) domesticable(s) fueron vistas mientras descansabas: %s"
private.L["CACHED_STABLED_FORMAT"] = "Los siguientes NPC(s) no pueden buscarse si han sido domesticados: %s"
private.L["CACHED_WORLD_FORMAT"] = "Los siguientes %2$s NPC (s) se encuentran en la cache: %1$s."
private.L["CACHELIST_ENTRY_FORMAT"] = "|cff808080“%s”|r"
private.L["CACHELIST_SEPARATOR"] = ","
private.L["CMD_ADD"] = "AÑADIR"
private.L["CMD_CACHE"] = "CACHE"
private.L["CMD_CACHE_EMPTY"] = "Ninguno de los NPC buscados han sido encontrados"
private.L["CMD_HELP"] = "Los comandos son: |cff808080“/npcscan add <NpcID> <Nombre>”|r, |cff808080“/npcscan remove <NpcID o Nombre>”|r, |cff808080“/npcscan cache”|r para listar los NPC en cache, y simplemente |cff808080“/npcscan”|r para el menu de opciones."
private.L["CMD_REMOVE"] = "BORRAR"
private.L["CMD_REMOVENOTFOUND_FORMAT"] = "NPC  |cff808080“%s”|r no encontrado."
private.L["CONFIG_ALERT"] = "Opciones de Alerta"
private.L["CONFIG_ALERT_SOUND"] = "Sonido de la alerta"
private.L["CONFIG_ALERT_SOUND_DEFAULT"] = "|cffffd200Por defecto|r"
private.L["CONFIG_ALERT_SOUND_DESC"] = "Selecciona el sonido de alerta cuando se encuentra un NPC. Se pueden añadir sonidos adicionales por medio de addons |cff808080“SharedMedia”|r"
private.L["CONFIG_ALERT_UNMUTE"] = "Quitar el silencio al sonido de alerta"
private.L["CONFIG_ALERT_UNMUTE_DESC"] = "Activa el sonido del juego cuando se muestra el boton de objetivo NPC para que pueda oir la alerta, incluso con el silencio activado."
private.L["CONFIG_CACHEWARNINGS"] = "Muestra recordatorios sobre el cache al conectar y al cambiar de mundo"
private.L["CONFIG_CACHEWARNINGS_DESC"] = "Si un PNJ ya está en cache cuando conectas o cambias de mundo, esta opción muestra un recordatorio sobre los PNJs que están en caché y no pueden buscarse." -- Needs review
private.L["CONFIG_DESC"] = "Estas opciones permiten configurar el modo en que _NPCScan te alerta cuando encuentra un NPC raro."
private.L["CONFIG_PRINTTIME"] = "Publicar tiempos en la ventana de chat"
private.L["CONFIG_PRINTTIME_DESC"] = "Añade el tiempo actual a todos los mensajes publicados. Útil para recordar cuando fueron encontrados los PNJs"
private.L["CONFIG_TEST"] = "Probar alerta al encontrar"
private.L["CONFIG_TEST_DESC"] = "Simula una alerta de |cff808080“NPC encontrado”|r para que sepas qué buscar"
private.L["CONFIG_TEST_HELP_FORMAT"] = "Pulsa en el botón de objetivo o usa la macro de teclado para seleccionar el NPC encontrado. Mantén pulsado |cffffffff<%s>|r y arrastra para mover el botón objetivo. Ten en cuenta que si encuentras un NPC mientras estas en combate, el botón solo aparecera cuando salgas del combate."
private.L["CONFIG_TEST_NAME"] = "Tu! (Prueba)"
private.L["CONFIG_TITLE"] = "_|cffCCCC88NPCScan|r"
private.L["FOUND_FORMAT"] = "Encontrado |cff808080“%s”|r!"
private.L["FOUND_TAMABLE_FORMAT"] = "Encontrado |cff808080“%s”|r!  |cffff2020(Nota: NPC domesticable, puede ser solo una mascota.)|r"
private.L["FOUND_TAMABLE_WRONGZONE_FORMAT"] = "|cffff2020Falsa alarma:|r Encontrado un NPC domesticable |cff808080“%s”|r en %s en vez de %s (ID %d); Definitivamente es una mascota."
-- private.L["FOUND_UNIT_DEAD"] = "%s found but is dead."
-- private.L["FOUND_UNIT_TAXI"] = "%s found during flight path near %d, %d in %s."
private.L["PRINT_FORMAT"] = "%s_|cffCCCC88NPCScan|r: %s"
-- private.L["RAREMOBS"] = "Rare Mobs"
private.L["SEARCH_ACHIEVEMENTADDFOUND"] = "Busca NPCs de logros ya completados"
private.L["SEARCH_ACHIEVEMENTADDFOUND_DESC"] = "Continua buscando todos los NPC de logros, incluso si ya no los necesitas"
private.L["SEARCH_ACHIEVEMENT_DISABLED"] = "Desactivado"
private.L["SEARCH_ADD"] = "+"
private.L["SEARCH_ADD_DESC"] = "Añade un nuevo NPC o guarda los cambios de uno existente"
private.L["SEARCH_ADD_TAMABLE_FORMAT"] = "Nota: |cff808080“%s”|r es domesticable, así que verlo como mascota de cazador puede producir una falsa alarma."
private.L["SEARCH_CACHED"] = "En cache"
private.L["SEARCH_COMPLETED"] = "Listo"
private.L["SEARCH_DESC"] = "Esta tabla te permite añadir o borrar NPCs y busquedas de logros"
private.L["SEARCH_ID"] = "NPC ID:"
private.L["SEARCH_ID_DESC"] = "El ID del NPC a buscar. Puedes buscar este valor en webs como wowhead.com"
-- private.L["SEARCH_IGNORE"] = "Remove"
-- private.L["SEARCH_IGNORE_DESC"] = "Remove selected mob from list."
-- private.L["SEARCH_IGNORE_LIST"] = "Ignore List"
-- private.L["SEARCH_IGNORE_LIST_DESC"] = "List of Mobs that NPCScan will not track."
private.L["SEARCH_MAP"] = "Zona:"
private.L["SEARCH_NAME"] = "Nombre:"
private.L["SEARCH_NAME_DESC"] = "Un nombre para el NPC. No tiene por qué coincidir con el nombre actual del NPC"
private.L["SEARCH_NPCS"] = "NPC personalizado"
private.L["SEARCH_NPCS_DESC"] = "Añadir cualquier NPC a la búsqueda, incluso cuando no tiene logro"
-- private.L["SEARCH_RAREMOBS_DESC"] = "Default list of Rare Mobs."
private.L["SEARCH_REMOVE"] = "-"
-- private.L["SEARCH_TAMEBEAST_DECS"] = "Tameable Rare Beasts"
private.L["SEARCH_TITLE"] = "Buscar"
private.L["SEARCH_WORLD"] = "Mundo:"
private.L["SEARCH_WORLD_DESC"] = "Un nombre de mundo opcional para limitar la busqueda. Puede ser el nombre de un continente o |cffff7f3f nombre de estancia|r (diferencia minusculas-mayusculas)"
private.L["SEARCH_WORLD_FORMAT"] = "(%s)"
-- private.L["TAMEDBEASTS"] = "Tameable Beasts"
private.L["TIME_FORMAT"] = "|cff808080[%H:%M:%S]|r "
private.L["TOOLS_TITLE"] = "|cff808080Tools|r" -- Needs review

private.L.NPCs["100"] = "Bronco Mordeveloz"
private.L.NPCs["10077"] = "Faucemuerte"
private.L.NPCs["10078"] = "Chispa terrorífica"
private.L.NPCs["10080"] = "Sandarr Asaltadunas"
private.L.NPCs["10081"] = "Ánima de polvo"
private.L.NPCs["10082"] = "Zerillis"
private.L.NPCs["10119"] = "Volchan"
private.L.NPCs["10196"] = "General Colbatann"
private.L.NPCs["10197"] = "Mezzir el Aullador"
private.L.NPCs["10198"] = "Kashoch el Atracador"
private.L.NPCs["10199"] = "Pardo Patanieve"
private.L.NPCs["10200"] = "Rak'shiri"
private.L.NPCs["10202"] = "Azurous"
private.L.NPCs["10263"] = "Guardia vil ardiente"
private.L.NPCs["10356"] = "Bayne"
private.L.NPCs["10357"] = "Ressan el Agujas"
private.L.NPCs["10358"] = "Sombra de Felicent"
private.L.NPCs["10359"] = "Sri'skulk"
private.L.NPCs["10376"] = "Colmillo de cristal"
private.L.NPCs["10393"] = "Skul"
private.L.NPCs["10509"] = "Jed Vigía de las Runas"
private.L.NPCs["10558"] = "Cantachimeneas Forresten"
private.L.NPCs["10559"] = "Lady Vespia"
private.L.NPCs["1063"] = "Jade"
private.L.NPCs["10639"] = "Rorgish Jowl"
private.L.NPCs["10640"] = "Pataroble"
private.L.NPCs["10641"] = "Quebrarramas"
private.L.NPCs["10642"] = "Eck'alom"
private.L.NPCs["10644"] = "Aullanieblas"
private.L.NPCs["10647"] = "Príncipe Raze"
private.L.NPCs["10741"] = "Sian-Rotam"
private.L.NPCs["10809"] = "Pidrespina"
private.L.NPCs["10817"] = "Duggan Martillo Salvaje"
private.L.NPCs["10818"] = "Robaalmas caballero de la Muerte"
private.L.NPCs["10819"] = "Barón Malasangre"
private.L.NPCs["10820"] = "Duque Atracador"
private.L.NPCs["10821"] = "Hed'mush el Podrido"
private.L.NPCs["10823"] = "Ramurdimbre Zul'Brin"
private.L.NPCs["10824"] = "Cazador letal Lanzalcón"
private.L.NPCs["10825"] = "Gish el Inamovible"
private.L.NPCs["10826"] = "Lord Hoz Oscura"
private.L.NPCs["10827"] = "Portavoz de la muerte Selendre"
private.L.NPCs["10828"] = "Lynnia Abbendis"
private.L.NPCs["1106"] = "Cocinero Perdido"
private.L.NPCs["1112"] = "Viuda sanguijuela"
private.L.NPCs["1119"] = "Martidorsal"
private.L.NPCs["1130"] = "Bjarn"
private.L.NPCs["1132"] = "Gris"
private.L.NPCs["1137"] = "Edan el Aullador"
private.L.NPCs["11383"] = "Suma sacerdotisa Hai'watna"
private.L.NPCs["1140"] = "Matriarca Tajobuche"
private.L.NPCs["11447"] = "Mushgog"
private.L.NPCs["11467"] = "Tsu'zee"
private.L.NPCs["11497"] = "El Razza"
private.L.NPCs["11498"] = "Skarr el Roto"
private.L.NPCs["11688"] = "Centauro maldito"
private.L.NPCs["12037"] = "Ursol'lok"
private.L.NPCs["12237"] = "Meshlok el Cosechador"
private.L.NPCs["12431"] = "Mandisangre"
private.L.NPCs["12433"] = "Krethis Tejeumbra"
private.L.NPCs["1260"] = "Gran patriarca Arctikus"
private.L.NPCs["12902"] = "Lorgus Jett"
private.L.NPCs["13896"] = "Barbascamas"
private.L.NPCs["1398"] = "Jefe Vayachi"
private.L.NPCs["1399"] = "Magosh"
private.L.NPCs["14221"] = "Gravis Nudocorredizo"
private.L.NPCs["14222"] = "Araga"
private.L.NPCs["14223"] = "Cascarrabias Ben"
private.L.NPCs["14224"] = "7:XT"
private.L.NPCs["14225"] = "Príncipe Kellen"
private.L.NPCs["14226"] = "Kaskk"
private.L.NPCs["14227"] = "Hissperak"
private.L.NPCs["14228"] = "Mueca"
private.L.NPCs["14229"] = "Filozante detestable"
private.L.NPCs["14230"] = "Ojo Ladrón"
private.L.NPCs["14231"] = "Drogoth el Vagabundo"
private.L.NPCs["14232"] = "Dardo"
private.L.NPCs["14233"] = "Rasgascama"
private.L.NPCs["14234"] = "Hayoc"
private.L.NPCs["14235"] = "El Podrido"
private.L.NPCs["14236"] = "Señor Pescador"
private.L.NPCs["14237"] = "Mocogusano"
private.L.NPCs["1424"] = "Maestro excavador"
private.L.NPCs["1425"] = "Kubb"
private.L.NPCs["14266"] = "Shanda la Giratoria"
private.L.NPCs["14267"] = "Emogg el Triturador"
private.L.NPCs["14268"] = "Lord Condar"
private.L.NPCs["14269"] = "Buscador Aqualon"
private.L.NPCs["14270"] = "Squiddic"
private.L.NPCs["14271"] = "Rompecostillas"
private.L.NPCs["14272"] = "Llamagruños"
private.L.NPCs["14273"] = "Corapetra"
private.L.NPCs["14275"] = "Tamra Pico Tormenta"
private.L.NPCs["14276"] = "Rasgabranquia"
private.L.NPCs["14277"] = "Lady Zephris"
private.L.NPCs["14278"] = "Ro'Bark"
private.L.NPCs["14279"] = "Trepazoso"
private.L.NPCs["14280"] = "Gran Samras"
private.L.NPCs["14281"] = "Jimmy el Sangrador"
private.L.NPCs["14339"] = "Aullador de la Muerte"
private.L.NPCs["14340"] = "Alshirr Respiramiedo"
private.L.NPCs["14342"] = "Patafuria"
private.L.NPCs["14343"] = "Olm el Sabio"
private.L.NPCs["14344"] = "Mongress"
private.L.NPCs["14345"] = "El Ongar"
private.L.NPCs["14424"] = "Lodonante"
private.L.NPCs["14425"] = "Roehuesos"
private.L.NPCs["14426"] = "Harb Monte Fétido"
private.L.NPCs["14427"] = "Gibblesnik"
private.L.NPCs["14428"] = "Uruson"
private.L.NPCs["14429"] = "Faucenestra"
private.L.NPCs["14430"] = "Acechador nocturno"
private.L.NPCs["14431"] = "Furia Shelda"
private.L.NPCs["14432"] = "Threggil"
private.L.NPCs["14433"] = "Barrosín"
private.L.NPCs["14445"] = "Capitán Wyrmak"
private.L.NPCs["14446"] = "Fingat"
private.L.NPCs["14447"] = "Gilmorian"
private.L.NPCs["14448"] = "Fundespino"
private.L.NPCs["14471"] = "Setis"
private.L.NPCs["14472"] = "Gretheer"
private.L.NPCs["14473"] = "Lapress"
private.L.NPCs["14474"] = "Zora"
private.L.NPCs["14475"] = "Rex Ashil"
private.L.NPCs["14476"] = "Krellack"
private.L.NPCs["14477"] = "Grubthor"
private.L.NPCs["14478"] = "Huricanian"
private.L.NPCs["14479"] = "Señor Crepuscular Everun"
private.L.NPCs["14487"] = "Gluggl"
private.L.NPCs["14488"] = "Roloch"
private.L.NPCs["14490"] = "Rippa"
private.L.NPCs["14491"] = "Kurmokk"
private.L.NPCs["14492"] = "Verifonix"
private.L.NPCs["1531"] = "Alma perdida"
private.L.NPCs["1533"] = "Espíritu atormentado"
private.L.NPCs["1552"] = "Panzascama"
private.L.NPCs["16179"] = "Hyakiss el Rondador"
private.L.NPCs["16180"] = "Shadikith el Planeador"
private.L.NPCs["16181"] = "Rokad el Devastador"
private.L.NPCs["16184"] = "Sobrestante nerubiano"
private.L.NPCs["16854"] = "Eldinarcus"
private.L.NPCs["16855"] = "Tregla"
private.L.NPCs["17144"] = "Dientegore"
private.L.NPCs["18241"] = "Pincitas"
private.L.NPCs["1837"] = "Juez Escarlata"
private.L.NPCs["1838"] = "Interrogador Escarlata"
private.L.NPCs["1839"] = "Alto Clérigo Escarlata"
private.L.NPCs["1841"] = "Verdugo Escarlata"
private.L.NPCs["1843"] = "Supervisor Jerris"
private.L.NPCs["1844"] = "Supervisor Marcrid"
private.L.NPCs["1847"] = "Crinatroz"
private.L.NPCs["1848"] = "Lord Maldazzar"
private.L.NPCs["1849"] = "Rumoratroz"
private.L.NPCs["1850"] = "Putridus"
private.L.NPCs["1851"] = "La Cáscara"
private.L.NPCs["18677"] = "Mekthorg el Salvaje"
private.L.NPCs["18678"] = "Atiborrador"
private.L.NPCs["18679"] = "Vorakem Augurador"
private.L.NPCs["18680"] = "Marticar"
private.L.NPCs["18681"] = "Emisaria Colmillo Torcido"
private.L.NPCs["18682"] = "Rondador de ciénaga"
private.L.NPCs["18683"] = "Cazador del vacío Yar"
private.L.NPCs["18684"] = "Bro'Gaz sin Clan"
private.L.NPCs["18685"] = "Okrek"
private.L.NPCs["18686"] = "Orador del Sino Jurim"
private.L.NPCs["18689"] = "Lisiador"
private.L.NPCs["18690"] = "Morchaca"
private.L.NPCs["18692"] = "Hemathion"
private.L.NPCs["18693"] = "Portavoz Mar'grom"
private.L.NPCs["18694"] = "Collidus el Vigía"
private.L.NPCs["18695"] = "Embajador Jerrikar"
private.L.NPCs["18696"] = "Kraator"
private.L.NPCs["18697"] = "Ingeniero jefe Lorthander"
private.L.NPCs["18698"] = "Núcleo eterno el Castigador"
private.L.NPCs["1885"] = "Herrero Escarlata"
private.L.NPCs["1910"] = "Muad"
private.L.NPCs["1911"] = "Deeb"
private.L.NPCs["1936"] = "Granjero Solliden"
private.L.NPCs["2090"] = "Ma'ruk Vermiscala"
private.L.NPCs["20932"] = "Nuramoc"
private.L.NPCs["2108"] = "Garneg Hullacráneo"
private.L.NPCs["2162"] = "Agal"
private.L.NPCs["2172"] = "Zancador Madrezarpa"
private.L.NPCs["21724"] = "Aterralcón"
private.L.NPCs["2175"] = "Garrasombría"
private.L.NPCs["2184"] = "Lady Miraluna"
private.L.NPCs["2186"] = "Carnivous el Rompedor"
private.L.NPCs["2191"] = "Licillin"
private.L.NPCs["2192"] = "Clamafuegos Radison"
private.L.NPCs["22060"] = "Fenissa la Asesina"
private.L.NPCs["22062"] = "Dr. Miembro Marchito"
private.L.NPCs["2258"] = "Maggarrak"
private.L.NPCs["2452"] = "Skhowl"
private.L.NPCs["2453"] = "Lo'Grosh"
private.L.NPCs["2476"] = "Gosh-Haldir"
private.L.NPCs["2541"] = "Lord Sakrasis"
private.L.NPCs["2598"] = "Darbel Montrosa"
private.L.NPCs["2600"] = "Kantor"
private.L.NPCs["2601"] = "Panzatroz"
private.L.NPCs["2602"] = "Ruul Onapiedra"
private.L.NPCs["2603"] = "Kovork"
private.L.NPCs["2604"] = "Molok el Triturador"
private.L.NPCs["2605"] = "Zalas Secacorteza"
private.L.NPCs["2606"] = "Nimar el Destripador"
private.L.NPCs["2609"] = "Geomántico Dagasílex"
private.L.NPCs["2744"] = "Comandante de Forjatiniebla"
private.L.NPCs["2749"] = "Barricada"
private.L.NPCs["2751"] = "Gólem de guerra"
private.L.NPCs["2752"] = "Estruendor"
private.L.NPCs["2753"] = "Barnabus"
private.L.NPCs["2754"] = "Anathemus"
private.L.NPCs["2779"] = "Príncipe Nazjak"
private.L.NPCs["2850"] = "Diente partido"
private.L.NPCs["2931"] = "Zaricotl"
private.L.NPCs["3058"] = "Arra'chea"
private.L.NPCs["3068"] = "Mazzranache"
private.L.NPCs["32357"] = "Viejo Ladracristal"
private.L.NPCs["32358"] = "Fumblub Vientoencajado"
private.L.NPCs["32361"] = "Hielocuerno"
private.L.NPCs["32377"] = "Perobas el Sediento de sangre"
private.L.NPCs["32386"] = "Vigdis la Doncella de la guerra"
private.L.NPCs["32398"] = "Rey Ping"
private.L.NPCs["32400"] = "Tukemuth"
private.L.NPCs["32409"] = "Superviviente Indu'le enloquecido"
private.L.NPCs["32417"] = "Alta señora Escarlata Daion"
private.L.NPCs["32422"] = "Grocklar"
private.L.NPCs["32429"] = "Odio hirviente"
private.L.NPCs["32435"] = "Vern"
private.L.NPCs["32438"] = "Syreian la Talahuesos"
private.L.NPCs["32447"] = "Centinela de Zul'drak"
private.L.NPCs["32471"] = "Griegen"
private.L.NPCs["32475"] = "Hilador de terror"
private.L.NPCs["32481"] = "Aotona"
private.L.NPCs["32485"] = "Rey Krush"
private.L.NPCs["32487"] = "Putridus el Antiguo"
private.L.NPCs["32491"] = "Protodraco Tiempo Perdido"
private.L.NPCs["32495"] = "Hildana Quitaalmas"
private.L.NPCs["32500"] = "Dirkee"
private.L.NPCs["32501"] = "Señor feudal Jorfus"
private.L.NPCs["32517"] = "Loque'nahak"
private.L.NPCs["3253"] = "Cosechador silítido"
private.L.NPCs["32630"] = "Vyragosa"
private.L.NPCs["3270"] = "Anciana mística Filocico"
private.L.NPCs["3295"] = "Anomalía de lodo"
private.L.NPCs["33776"] = "Gondria"
private.L.NPCs["3398"] = "Gesharahan"
private.L.NPCs["3470"] = "Rathorian"
private.L.NPCs["35189"] = "Skoll"
private.L.NPCs["3535"] = "Musgonegro el Fétido"
private.L.NPCs["3581"] = "Bestia de cloaca"
private.L.NPCs["3652"] = "Tritesta el Azotador"
private.L.NPCs["3672"] = "Boahn"
private.L.NPCs["3735"] = "Boticario Falthis"
private.L.NPCs["3736"] = "Destripador Oscuro Mordenthal"
private.L.NPCs["3773"] = "Akkrilus"
private.L.NPCs["3792"] = "Señor de la manada Luporror"
private.L.NPCs["38453"] = "Arcturis"
private.L.NPCs["3872"] = "Capitán Juramorte"
private.L.NPCs["39183"] = "Escorpitar"
private.L.NPCs["39185"] = "Mandíbula Esclavizadora"
private.L.NPCs["39186"] = "Observainfiernos"
private.L.NPCs["4066"] = "Nal'taszar"
private.L.NPCs["4132"] = "Krkk'kx"
private.L.NPCs["4339"] = "Brotasangre"
private.L.NPCs["43488"] = "Mordei el Procuratierra"
private.L.NPCs["43613"] = "Vidente corredor Orador del Sino"
private.L.NPCs["43720"] = "\"Lento\" Matospina"
private.L.NPCs["4380"] = "Viuda Niebla Negra"
private.L.NPCs["44224"] = "Dos Zapatos"
private.L.NPCs["44225"] = "Rufus Tiroscuro"
private.L.NPCs["44226"] = "Sarldente"
private.L.NPCs["44227"] = "Gazz el Cazador del Lago"
private.L.NPCs["4425"] = "Cazador ciego"
private.L.NPCs["44714"] = "Fronkle el Perturbado"
private.L.NPCs["44722"] = "Reflejo retorcido de Narain"
private.L.NPCs["44750"] = "Califa Escorpijón"
private.L.NPCs["44759"] = "Andre Barbafuego"
private.L.NPCs["44761"] = "Aquamentas el Desencadenado"
private.L.NPCs["44767"] = "Occulus el Corrupto"
private.L.NPCs["45257"] = "Mordak Juerganocturna"
private.L.NPCs["45258"] = "Cassia la Reina Deslizante"
private.L.NPCs["45260"] = "Ramanegra"
private.L.NPCs["45262"] = "Narixxus el Fatídico"
private.L.NPCs["45369"] = "Morick Cerveoscura"
private.L.NPCs["45380"] = "Colaceniza"
private.L.NPCs["45384"] = "Sabiopata"
private.L.NPCs["45398"] = "Grizlak"
private.L.NPCs["45399"] = "Optimo"
private.L.NPCs["45401"] = "Blancaleta"
private.L.NPCs["45402"] = "Nix"
private.L.NPCs["45404"] = "Geomoldeadora Maren"
private.L.NPCs["45739"] = "El Soldado Desconocido"
private.L.NPCs["45740"] = "Vigía Eva"
private.L.NPCs["45771"] = "Marus"
private.L.NPCs["45785"] = "El Trinchado"
private.L.NPCs["45801"] = "Eliza"
private.L.NPCs["45811"] = "Marina DeSirrus"
private.L.NPCs["462"] = "Vultros"
private.L.NPCs["46981"] = "Latipesadilla"
private.L.NPCs["46992"] = "Berard el Lunático"
private.L.NPCs["47003"] = "Bolgaff"
private.L.NPCs["47008"] = "Fenwick Thatros"
private.L.NPCs["47009"] = "Aquarius el Desvinculado"
private.L.NPCs["47010"] = "Índigo"
private.L.NPCs["47012"] = "Effritus"
private.L.NPCs["47015"] = "Último hijo de Arugal"
private.L.NPCs["47023"] = "Thule Corvozarpa"
private.L.NPCs["471"] = "Madre Colmillo"
private.L.NPCs["472"] = "Fedfennel"
private.L.NPCs["47386"] = "Ainamiss la Abeja Reina"
private.L.NPCs["47387"] = "Harakiss el Infeccioso"
private.L.NPCs["4842"] = "Clamatierras Halmgar"
private.L.NPCs["49822"] = "Colmillo de Jade"
private.L.NPCs["49913"] = "Lady La-La"
private.L.NPCs["50005"] = "Poseidus"
private.L.NPCs["50009"] = "Mobus"
private.L.NPCs["50050"] = "Shok'sharak"
private.L.NPCs["50051"] = "Reptafantasmas"
private.L.NPCs["50052"] = "Burgy Corazón Negro"
private.L.NPCs["50053"] = "Thartuk el Exiliado"
private.L.NPCs["50056"] = "Garr"
private.L.NPCs["50057"] = "Alardiente"
private.L.NPCs["50058"] = "Terrorpín"
private.L.NPCs["50059"] = "Golgarok"
private.L.NPCs["50060"] = "Terborus"
private.L.NPCs["50061"] = "Xariona"
private.L.NPCs["50062"] = "Aeonaxx"
private.L.NPCs["50063"] = "Akma'hat"
private.L.NPCs["50064"] = "Cyrus el Oscuro"
private.L.NPCs["50065"] = "Armagedillo"
private.L.NPCs["50085"] = "Señor supremo Furiahendida"
private.L.NPCs["50086"] = "Tarvus el Vil"
private.L.NPCs["50089"] = "Julak Fatalidad"
private.L.NPCs["50138"] = "Karoma"
private.L.NPCs["50154"] = "Madexx"
private.L.NPCs["50159"] = "Sambas"
private.L.NPCs["50328"] = "Colmillor"
private.L.NPCs["50329"] = "Rrakk"
private.L.NPCs["50330"] = "Kree"
private.L.NPCs["50331"] = "Go-Kan"
private.L.NPCs["50332"] = "Korda Torros"
private.L.NPCs["50333"] = "Lon el Toro"
private.L.NPCs["50334"] = "Dak el Destructor"
private.L.NPCs["50335"] = "Alitus"
private.L.NPCs["50336"] = "Yorik Vistafilada"
private.L.NPCs["50337"] = "Carcajo"
private.L.NPCs["50338"] = "Kor'nas Salvaje Nocturno"
private.L.NPCs["50339"] = "Sulik'shor"
private.L.NPCs["50340"] = "Gaarn el Tóxico"
private.L.NPCs["50341"] = "Borginn Puño Oscuro"
private.L.NPCs["50342"] = "Heronis"
private.L.NPCs["50343"] = "Quall"
private.L.NPCs["50344"] = "Norlaxx"
private.L.NPCs["50345"] = "Alit"
private.L.NPCs["50346"] = "Ronak"
private.L.NPCs["50347"] = "Karr el Oscurecedor"
private.L.NPCs["50348"] = "Norissis"
private.L.NPCs["50349"] = "Kang, el Ladrón de Almas"
private.L.NPCs["50350"] = "Morgrinn Colmillo Rajado"
private.L.NPCs["50351"] = "Jonn-Dar"
private.L.NPCs["50352"] = "Qu'nas"
private.L.NPCs["50353"] = "Manas"
private.L.NPCs["50354"] = "Havak"
private.L.NPCs["50355"] = "Kah'tir"
private.L.NPCs["50356"] = "Krol la Espada"
private.L.NPCs["50357"] = "Aladía"
private.L.NPCs["50358"] = "Ensamblaje Atracasol descontrolado"
private.L.NPCs["50359"] = "Urgolax"
private.L.NPCs["50361"] = "Ornat"
private.L.NPCs["50362"] = "Charconegro el Colmillo"
private.L.NPCs["50363"] = "Krax'ik"
private.L.NPCs["50364"] = "Nal'lak el Destripador"
private.L.NPCs["50370"] = "Karapax"
private.L.NPCs["50388"] = "Torik-Ethis"
private.L.NPCs["50409"] = "Figurilla de camello misteriosa"
private.L.NPCs["50410"] = "Figurilla de camello misteriosa"
private.L.NPCs["506"] = "Sargento Garravil"
private.L.NPCs["507"] = "Fenros"
private.L.NPCs["50724"] = "Reptaspinas"
private.L.NPCs["50725"] = "Azelisk"
private.L.NPCs["50726"] = "Kalixx"
private.L.NPCs["50727"] = "Strix el Barbado"
private.L.NPCs["50728"] = "Lancemortal"
private.L.NPCs["50730"] = "Púa Venenosa"
private.L.NPCs["50731"] = "Dientespina"
private.L.NPCs["50733"] = "Ski'thik"
private.L.NPCs["50734"] = "Lith'ik el Acechador"
private.L.NPCs["50735"] = "Guiñojo el Cascabel"
private.L.NPCs["50737"] = "Acroniss"
private.L.NPCs["50738"] = "Brilloescama"
private.L.NPCs["50739"] = "Gar'lok"
private.L.NPCs["50741"] = "Kaxx"
private.L.NPCs["50742"] = "Qem"
private.L.NPCs["50743"] = "Manax"
private.L.NPCs["50744"] = "Qu'rik"
private.L.NPCs["50745"] = "Losaj"
private.L.NPCs["50746"] = "Bornix el Cavador"
private.L.NPCs["50747"] = "Tix"
private.L.NPCs["50748"] = "Nyaj"
private.L.NPCs["50749"] = "Kal'tik la Plaga"
private.L.NPCs["50750"] = "Aethis"
private.L.NPCs["50752"] = "Tarantis"
private.L.NPCs["50759"] = "Iriss la Viuda"
private.L.NPCs["50763"] = "Acechasombras"
private.L.NPCs["50764"] = "Paraliss"
private.L.NPCs["50765"] = "Miasmiss"
private.L.NPCs["50766"] = "Sele'na"
private.L.NPCs["50768"] = "Cournith Tranco de Agua"
private.L.NPCs["50769"] = "Zai el Exiliado"
private.L.NPCs["50770"] = "Zorn"
private.L.NPCs["50772"] = "Eshelon"
private.L.NPCs["50775"] = "Likk el Cazador"
private.L.NPCs["50776"] = "Nalash Verdantis"
private.L.NPCs["50777"] = "Aguja"
private.L.NPCs["50778"] = "Tejehierro"
private.L.NPCs["50779"] = "Esporagón"
private.L.NPCs["50780"] = "Sahn Cazador de Olas"
private.L.NPCs["50782"] = "Sarnak"
private.L.NPCs["50783"] = "Explorador de guerra Salyin"
private.L.NPCs["50784"] = "Anith"
private.L.NPCs["50785"] = "Sombracielo"
private.L.NPCs["50786"] = "Alacentella"
private.L.NPCs["50787"] = "Arness la Escama"
private.L.NPCs["50788"] = "Quetzl"
private.L.NPCs["50789"] = "Nessos el Oráculo"
private.L.NPCs["50790"] = "Ionis"
private.L.NPCs["50791"] = "Siltriss el Afilador"
private.L.NPCs["50792"] = "Chiaa"
private.L.NPCs["50797"] = "Yukiko"
private.L.NPCs["50803"] = "Mascahuesos"
private.L.NPCs["50804"] = "Rasgala"
private.L.NPCs["50805"] = "Omnis Grinlok"
private.L.NPCs["50806"] = "Moldo el Tuerto"
private.L.NPCs["50807"] = "Catal"
private.L.NPCs["50808"] = "Urobi el Caminante"
private.L.NPCs["50809"] = "Heress"
private.L.NPCs["50810"] = "Favorecido de Isiset"
private.L.NPCs["50811"] = "Nasra Piel Pecosa"
private.L.NPCs["50812"] = "Arae"
private.L.NPCs["50813"] = "Plumal"
private.L.NPCs["50814"] = "Comecarroña"
private.L.NPCs["50815"] = "Skarr"
private.L.NPCs["50816"] = "Ruun Zarpa Espectral"
private.L.NPCs["50817"] = "Ahone el Errante"
private.L.NPCs["50818"] = "El Merodeador Oscuro"
private.L.NPCs["50819"] = "Garrahielo"
private.L.NPCs["50820"] = "Yul Zarpa Salvaje"
private.L.NPCs["50821"] = "Ai-Li Reflejo Celeste"
private.L.NPCs["50822"] = "Ai-Ran, la Nube Flotante"
private.L.NPCs["50823"] = "Señor Feroz"
private.L.NPCs["50825"] = "Feras"
private.L.NPCs["50828"] = "Bonobos"
private.L.NPCs["50830"] = "Matojo"
private.L.NPCs["50831"] = "Chillidos"
private.L.NPCs["50832"] = "El Aullador"
private.L.NPCs["50833"] = "Gatumbrío"
private.L.NPCs["50836"] = "Ik-Ik el Ágil"
private.L.NPCs["50837"] = "Kash"
private.L.NPCs["50838"] = "Atigrado"
private.L.NPCs["50839"] = "Sabueso cromático"
private.L.NPCs["50840"] = "Mayor Nanners"
private.L.NPCs["50842"] = "Magmagan"
private.L.NPCs["50846"] = "Faucesclava"
private.L.NPCs["50855"] = "Jaxx el Rabioso"
private.L.NPCs["50856"] = "Snark"
private.L.NPCs["50858"] = "Alapolvo"
private.L.NPCs["50864"] = "Zarzal"
private.L.NPCs["50865"] = "Saurix"
private.L.NPCs["50874"] = "Tenok"
private.L.NPCs["50875"] = "Nychus"
private.L.NPCs["50876"] = "Avis"
private.L.NPCs["50882"] = "Chupacabras"
private.L.NPCs["50884"] = "Polvuelo el Cobarde"
private.L.NPCs["50886"] = "Alamar"
private.L.NPCs["50891"] = "Boros"
private.L.NPCs["50892"] = "Cyn"
private.L.NPCs["50895"] = "Volux"
private.L.NPCs["50897"] = "Ffexk el Acechadunas"
private.L.NPCs["50901"] = "Teromak"
private.L.NPCs["50903"] = "Orlix, Señora del Pantano"
private.L.NPCs["50905"] = "Cida"
private.L.NPCs["50906"] = "Mutilax"
private.L.NPCs["50908"] = "Aullanoches"
private.L.NPCs["50915"] = "Bufante"
private.L.NPCs["50916"] = "Malagarra el Gemebundo"
private.L.NPCs["50922"] = "Huargus"
private.L.NPCs["50925"] = "Patarboleda"
private.L.NPCs["50926"] = "Ben Osogris"
private.L.NPCs["50929"] = "Pequeño Bjorn"
private.L.NPCs["50930"] = "Hibernus el Dormilón"
private.L.NPCs["50931"] = "Mange"
private.L.NPCs["50937"] = "Pellejamón"
private.L.NPCs["50940"] = "Swee"
private.L.NPCs["50942"] = "Hocicón el Comerraíces"
private.L.NPCs["50945"] = "Zarrapastro"
private.L.NPCs["50946"] = "Puercozilla"
private.L.NPCs["50947"] = "Varah"
private.L.NPCs["50948"] = "Lomocristal"
private.L.NPCs["50949"] = "Gambito de Finn"
private.L.NPCs["50952"] = "Percebe Jim"
private.L.NPCs["50955"] = "Cancerak"
private.L.NPCs["50957"] = "Pinzón"
private.L.NPCs["50959"] = "Karkin" -- Needs review
private.L.NPCs["50964"] = "Chuletín"
private.L.NPCs["50967"] = "Craw el Arrasador"
private.L.NPCs["50986"] = "Pieldorada"
private.L.NPCs["50993"] = "Gal'dorak"
private.L.NPCs["50995"] = "Moretón"
private.L.NPCs["50997"] = "Bornak el Corneador"
private.L.NPCs["51000"] = "Conchanegra el Abstruso"
private.L.NPCs["51001"] = "Garraveneno"
private.L.NPCs["51002"] = "Scorpoxx"
private.L.NPCs["51004"] = "Toxx"
private.L.NPCs["51007"] = "Serkett"
private.L.NPCs["51008"] = "El horror barbado"
private.L.NPCs["51010"] = "Tijeretas"
private.L.NPCs["51014"] = "Terrapis"
private.L.NPCs["51017"] = "Gezan"
private.L.NPCs["51018"] = "Zormus"
private.L.NPCs["51021"] = "Vorticus"
private.L.NPCs["51022"] = "Acordix"
private.L.NPCs["51025"] = "Dilennaa"
private.L.NPCs["51026"] = "Gnath"
private.L.NPCs["51027"] = "Espiráculo"
private.L.NPCs["51028"] = "El Tunelador Profundo"
private.L.NPCs["51029"] = "Parasitus"
private.L.NPCs["51031"] = "Rastreador"
private.L.NPCs["51037"] = "Perro de guerra gilneano perdido"
private.L.NPCs["51040"] = "Resoplón"
private.L.NPCs["51042"] = "Corazón Lóbrego"
private.L.NPCs["51044"] = "Apestoso"
private.L.NPCs["51045"] = "Arcanus"
private.L.NPCs["51046"] = "Fidonis"
private.L.NPCs["51048"] = "Rexxus"
private.L.NPCs["51052"] = "Gib el Bananero"
private.L.NPCs["51053"] = "Quirix"
private.L.NPCs["51057"] = "Gorgojo"
private.L.NPCs["51058"] = "Aphis"
private.L.NPCs["51059"] = "Pezuña Negra"
private.L.NPCs["51061"] = "Roth-Salam"
private.L.NPCs["51062"] = "Khep-Re"
private.L.NPCs["51063"] = "Phalanax"
private.L.NPCs["51066"] = "Dientecristal"
private.L.NPCs["51067"] = "Centella"
private.L.NPCs["51069"] = "Centellax"
private.L.NPCs["51071"] = "Capitán Florence"
private.L.NPCs["51076"] = "Lopex"
private.L.NPCs["51077"] = "Colarbusto"
private.L.NPCs["51078"] = "Ferdinand"
private.L.NPCs["51079"] = "Capitán Vientinfecto"
private.L.NPCs["51401"] = "Madexx"
private.L.NPCs["51402"] = "Madexx"
private.L.NPCs["51403"] = "Madexx"
private.L.NPCs["51404"] = "Madexx"
private.L.NPCs["51658"] = "Mogh el Muerto"
private.L.NPCs["51661"] = "Tsul'Kalu"
private.L.NPCs["51662"] = "Mahamba"
private.L.NPCs["51663"] = "Pogeyan"
private.L.NPCs["519"] = "Eslarc"
private.L.NPCs["520"] = "Brack"
private.L.NPCs["521"] = "Lupos"
private.L.NPCs["52146"] = "Delatora"
private.L.NPCs["534"] = "Nefaru"
private.L.NPCs["5343"] = "Lady Szallah"
private.L.NPCs["5345"] = "Cabeza Diamante"
private.L.NPCs["5346"] = "Rugesangre el Acechador"
private.L.NPCs["5347"] = "Antilus el Surcador"
private.L.NPCs["5348"] = "Vigía de los sueños Lengua Bífida"
private.L.NPCs["5349"] = "Arash-ethis"
private.L.NPCs["5350"] = "Qirot"
private.L.NPCs["5352"] = "Viejo Tripasgrises"
private.L.NPCs["5354"] = "Núdor Fraterfolio"
private.L.NPCs["5356"] = "Gruñidor"
private.L.NPCs["54318"] = "Ankha" -- Needs review
private.L.NPCs["54319"] = "Magria" -- Needs review
private.L.NPCs["54320"] = "Ban'thalos" -- Needs review
private.L.NPCs["54321"] = "Solix" -- Needs review
private.L.NPCs["54322"] = "Deth'tilac" -- Needs review
private.L.NPCs["54323"] = "Kirix" -- Needs review
private.L.NPCs["54324"] = "Correllama"
private.L.NPCs["54338"] = "Anthriss" -- Needs review
private.L.NPCs["54533"] = "Príncipe Lakma"
private.L.NPCs["56081"] = "Optimista Ben"
private.L.NPCs["572"] = "Leprithus"
private.L.NPCs["573"] = "Siegaenemigos 4000"
private.L.NPCs["574"] = "Naraxis"
private.L.NPCs["5785"] = "Hermana Azote de Odio"
private.L.NPCs["5786"] = "Jalalanza"
private.L.NPCs["5787"] = "Déspota Emilgund"
private.L.NPCs["5807"] = "El Despedazador"
private.L.NPCs["5809"] = "Sargento Curtis"
private.L.NPCs["5822"] = "Tejeyel Scronn"
private.L.NPCs["5823"] = "Despellejador de la Muerte"
private.L.NPCs["5824"] = "Capitán Colmillo Plano"
private.L.NPCs["5826"] = "Geoseñor Motas"
private.L.NPCs["5828"] = "Humar el Señor Orgulloso"
private.L.NPCs["5829"] = "Bufo el Molesto"
private.L.NPCs["5830"] = "Hermana Rathtalon"
private.L.NPCs["5831"] = "Velocrín"
private.L.NPCs["5832"] = "Silenciatruenos"
-- private.L.NPCs["58336"] = "Darkmoon Rabbit"
private.L.NPCs["5834"] = "Azzere el Filo del Cielo"
private.L.NPCs["5835"] = "Supervisor Asas"
private.L.NPCs["5836"] = "Ingeniero Giralesín"
private.L.NPCs["5837"] = "Brazorroca"
private.L.NPCs["5838"] = "Lanzarrota"
private.L.NPCs["584"] = "Kazon"
private.L.NPCs["5841"] = "Lanzapiedras"
private.L.NPCs["5842"] = "Takk el Saltarín"
private.L.NPCs["5847"] = "Heggin Pelopiedra"
private.L.NPCs["58474"] = "Picasangre"
private.L.NPCs["5848"] = "Malgin Cebadiz"
private.L.NPCs["5849"] = "Cavador Flamaforja"
private.L.NPCs["5851"] = "Capitán Gerogg Piemartillo"
private.L.NPCs["5859"] = "Hagg Taurruina"
private.L.NPCs["5863"] = "Geosacerdote Gukk'rok"
private.L.NPCs["5864"] = "Suingart Cuerolanza"
private.L.NPCs["5865"] = "Dishu"
private.L.NPCs["58768"] = "Crujecolmillos"
private.L.NPCs["58769"] = "Quijasaña"
private.L.NPCs["58771"] = "Cadozo"
private.L.NPCs["58778"] = "Aetha"
private.L.NPCs["58817"] = "Espíritu de Lao-Fe"
private.L.NPCs["58949"] = "Bai-Jin el Carnicero"
private.L.NPCs["5912"] = "Dragón feérico descarriado"
private.L.NPCs["5915"] = "Hermano Roblecuervo"
private.L.NPCs["5928"] = "Alapenas"
private.L.NPCs["5930"] = "Hermana Riven"
private.L.NPCs["5932"] = "Capataz Latimillo"
private.L.NPCs["5933"] = "Achellios el Desterrado"
private.L.NPCs["5935"] = "Ojohierro el Invencible"
private.L.NPCs["59369"] = "Doctor Theolen Krastinov"
private.L.NPCs["5937"] = "Aguijón vil"
private.L.NPCs["596"] = "Noble con lavado de cerebro"
private.L.NPCs["599"] = "Marisa du'Paige"
-- private.L.NPCs["60491"] = "Sha of Anger"
private.L.NPCs["61"] = "Thuros Dedos Ligeros"
private.L.NPCs["6118"] = "Fantasma de Varo'then"
private.L.NPCs["616"] = "Castañeta"
private.L.NPCs["62"] = "Gug Velagorda"
private.L.NPCs["6228"] = "Embajador Hierro Negro"
private.L.NPCs["62346"] = "Galeón" -- Needs review
private.L.NPCs["62880"] = "Gochao el Severo"
private.L.NPCs["62881"] = "Gaohun el Desmembraalmas"
private.L.NPCs["63101"] = "General Temuja"
private.L.NPCs["63240"] = "Maestro de las Sombras Sydow"
-- private.L.NPCs["63509"] = "Wulon"
private.L.NPCs["63510"] = "Wulon"
private.L.NPCs["63691"] = "Huo-Shuang"
private.L.NPCs["63695"] = "Baolai el Inmolador"
private.L.NPCs["63977"] = "Vyraxxis"
private.L.NPCs["63978"] = "Kri'chon"
private.L.NPCs["64004"] = "Pescador pandaren fantasmal"
private.L.NPCs["64191"] = "Artesano pandaren fantasmal"
-- private.L.NPCs["64403"] = "Alani"
private.L.NPCs["6581"] = "Matriarca ravasaurio"
private.L.NPCs["6582"] = "Madrezarpa Zavas"
private.L.NPCs["6583"] = "Gruff"
private.L.NPCs["6584"] = "Rey Mosh"
private.L.NPCs["6585"] = "Uhk'loc"
private.L.NPCs["6648"] = "Antilos"
private.L.NPCs["6649"] = "Lady Sesspira"
private.L.NPCs["6650"] = "General Colmiterror"
private.L.NPCs["6651"] = "Guardián Gruñefuria"
private.L.NPCs["68317"] = "Mavis Lesiones"
private.L.NPCs["68318"] = "Dalan Rasganoche"
private.L.NPCs["68319"] = "Disha Eludemiedo"
private.L.NPCs["68320"] = "Ubunti la Sombra"
private.L.NPCs["68321"] = "Kar Libraguerras"
private.L.NPCs["68322"] = "Muerta"
-- private.L.NPCs["69099"] = "Nalak"
private.L.NPCs["69161"] = "Oondasta"
private.L.NPCs["69664"] = "Mumta"
private.L.NPCs["69768"] = "Explorador de guerra Zandalari"
private.L.NPCs["69769"] = "Belisario Zandalari"
private.L.NPCs["69841"] = "Belisario Zandalari"
private.L.NPCs["69842"] = "Belisario Zandalari"
private.L.NPCs["69843"] = "Zao'cho"
private.L.NPCs["69996"] = "Ku'lai el Garracielo"
private.L.NPCs["69997"] = "Progenitus"
private.L.NPCs["69998"] = "Goda"
private.L.NPCs["69999"] = "Dios mole Ramuk"
private.L.NPCs["70000"] = "Al'tabim, El que todo lo ve"
private.L.NPCs["70001"] = "Uru Partedorsales"
private.L.NPCs["70002"] = "Lu Ban"
private.L.NPCs["70003"] = "Molthor"
private.L.NPCs["70096"] = "Dios de la guerra Dokah"
private.L.NPCs["70126"] = "Willy Wilder"
private.L.NPCs["7015"] = "Flagglemurk el Cruel"
private.L.NPCs["7016"] = "Lady Vespira"
private.L.NPCs["7017"] = "Lord Sesgapecados"
private.L.NPCs["70238"] = "Ojo imperturbable"
private.L.NPCs["70243"] = "Archirritualista Kelada"
private.L.NPCs["70249"] = "Ojo enfocado"
private.L.NPCs["70276"] = "Orador de la tormenta No'ku"
private.L.NPCs["70323"] = "Krakkanon"
private.L.NPCs["70430"] = "Horror rocoso"
private.L.NPCs["70440"] = "Monara"
private.L.NPCs["70530"] = "Ra'sha"
private.L.NPCs["7104"] = "Dessecus"
private.L.NPCs["7137"] = "Immolatus"
private.L.NPCs["71864"] = "Espectrante"
private.L.NPCs["71919"] = "Zhu Gon el Agrio"
-- private.L.NPCs["71992"] = "Moonfang"
private.L.NPCs["72045"] = "Quelón"
private.L.NPCs["72048"] = "Ossotremulus"
private.L.NPCs["72049"] = "Mascagrullas"
private.L.NPCs["72193"] = "Karkanos"
private.L.NPCs["72245"] = "Zesqua"
private.L.NPCs["72769"] = "Espíritu de fuego de jade"
private.L.NPCs["72775"] = "Buffo"
private.L.NPCs["72808"] = "Tsavo'ka"
private.L.NPCs["72909"] = "Gu'chi el Portaenjambres"
private.L.NPCs["72970"] = "Golganarr"
private.L.NPCs["73157"] = "Musgo de roca"
private.L.NPCs["73158"] = "Ganso esmeralda"
private.L.NPCs["73160"] = "Astado acerado Cueracero"
private.L.NPCs["73161"] = "Gran tortuga Irazón"
private.L.NPCs["73163"] = "Pitón imperial"
private.L.NPCs["73166"] = "Pinzaespina monstruoso"
private.L.NPCs["73167"] = "Huolon"
private.L.NPCs["73169"] = "Jakur el Ordon"
private.L.NPCs["73170"] = "Vigía Osu"
private.L.NPCs["73171"] = "Campeón de la Llama Negra"
private.L.NPCs["73172"] = "Señor del sílex Gairan"
private.L.NPCs["73173"] = "Urdur el Cauterizador"
private.L.NPCs["73174"] = "Sacerdote ilustre de las llamas"
private.L.NPCs["73175"] = "Carbonos"
private.L.NPCs["73277"] = "Sanador de hojas"
private.L.NPCs["73279"] = "Fauce Eterna"
private.L.NPCs["73281"] = "Barco aterrador Vazuvius"
private.L.NPCs["73282"] = "Garnia"
private.L.NPCs["73293"] = "Whizzig"
private.L.NPCs["73666"] = "Sacerdote ilustre de las llamas"
private.L.NPCs["73704"] = "Barbasucia"
private.L.NPCs["763"] = "Cabecilla Perdido"
private.L.NPCs["7846"] = "Teremus el Devorador"
private.L.NPCs["79"] = "Narg el Capataz"
private.L.NPCs["8199"] = "Líder de guerra Krazzilak"
private.L.NPCs["8200"] = "Jin'Zallah el Arenero"
private.L.NPCs["8201"] = "Omgorn el Perdido"
private.L.NPCs["8203"] = "Kregg Volcayecto"
private.L.NPCs["8204"] = "Soriid el Devorador"
private.L.NPCs["8205"] = "Haarka el Voraz"
private.L.NPCs["8207"] = "Alascuas"
private.L.NPCs["8208"] = "Llagapata mortífera"
private.L.NPCs["8210"] = "Filogarra"
private.L.NPCs["8211"] = "Viejo Saltariscos"
private.L.NPCs["8212"] = "El Rik"
private.L.NPCs["8213"] = "Espaldacerada"
private.L.NPCs["8214"] = "Jalinde Dracoestío"
private.L.NPCs["8215"] = "Grimungus"
private.L.NPCs["8216"] = "Retherokk el Rabioso"
private.L.NPCs["8217"] = "Mith'rethis el Encantador"
private.L.NPCs["8218"] = "Blancorazón el Acechador"
private.L.NPCs["8219"] = "Matagallinas Zul'arek"
private.L.NPCs["8277"] = "Rekk'tilac"
private.L.NPCs["8278"] = "Smoldar"
private.L.NPCs["8279"] = "Gólem de guerra defectuoso"
private.L.NPCs["8280"] = "Shleipnarr"
private.L.NPCs["8281"] = "Escaldar"
private.L.NPCs["8282"] = "Alto señor Mastrogonde"
private.L.NPCs["8283"] = "Maestro de esclavos Negrozón"
private.L.NPCs["8296"] = "Mojo el Retorcido"
private.L.NPCs["8297"] = "Magronos el Implacable"
private.L.NPCs["8298"] = "Akubar el Vidente"
private.L.NPCs["8299"] = "Escupetripas"
private.L.NPCs["8300"] = "Devastatia"
private.L.NPCs["8301"] = "Clack el Atracador"
private.L.NPCs["8302"] = "Ojo de la Muerte"
private.L.NPCs["8303"] = "Gruñón"
private.L.NPCs["8304"] = "Desdeñamiedos"
private.L.NPCs["8503"] = "Gibblewilt"
private.L.NPCs["8660"] = "El Evalcharr"
private.L.NPCs["8923"] = "Panzor el Invencible"
private.L.NPCs["8924"] = "El Behemoth"
private.L.NPCs["8976"] = "Hematos"
private.L.NPCs["8978"] = "Thauris Balgarr"
private.L.NPCs["8979"] = "Gruklash"
private.L.NPCs["8981"] = "Atracador estropeado"
private.L.NPCs["9217"] = "Señor Magus Cumbrerroca"
private.L.NPCs["9218"] = "Señor de batalla Cumbrerroca"
private.L.NPCs["9219"] = "Carnicero Cumbrerroca"
private.L.NPCs["947"] = "Rohh el Silencioso"
private.L.NPCs["9596"] = "Bannok Hacha Macabra"
private.L.NPCs["9602"] = "Hahk'Zor"
private.L.NPCs["9604"] = "Gorgon'och"
private.L.NPCs["9718"] = "Ghok Bashguud"
private.L.NPCs["9736"] = "Intendente Zigris"
private.L.NPCs["99"] = "Morgaine la Astuta"



_G[ "BINDING_NAME_CLICK _NPCScanButton:LeftButton" ] = [=[Marca el último NPC encontrado
|cff808080(Usalo cuando _NPCScan te alerta)|r]=];
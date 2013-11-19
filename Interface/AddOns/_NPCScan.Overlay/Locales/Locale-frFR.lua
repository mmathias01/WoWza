--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * Locales/Locale-frFR.lua - Localized string constants (fr-FR).              *
  ****************************************************************************]]


if ( GetLocale() ~= "frFR" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan-overlay/localization/frFR/
local private = select( 2, ... );
private.L = setmetatable( {
	NPCs = setmetatable( {
	}, { __index = private.L.NPCs; } );
}, { __index = private.L; } );

private.L.NPCs["100"] = "Gruff Mord-vite"
private.L.NPCs["10077"] = "Gueule-du-trépas"
private.L.NPCs["10078"] = "Lueur terrifiante"
private.L.NPCs["10080"] = "Sandarr Ravadune"
private.L.NPCs["10081"] = "Ame en peine poudreuse"
private.L.NPCs["10082"] = "Zerillis"
private.L.NPCs["10119"] = "Volchan"
private.L.NPCs["10196"] = "Général Colbatann"
private.L.NPCs["10197"] = "Mezzir le hurleur"
private.L.NPCs["10198"] = "Kashoch le saccageur"
private.L.NPCs["10199"] = "Grison Neigepatte"
private.L.NPCs["10200"] = "Rak'shiri"
private.L.NPCs["10202"] = "Azurous"
private.L.NPCs["10263"] = "Gangregarde ardent"
private.L.NPCs["10356"] = "Bayne"
private.L.NPCs["10357"] = "Ressan le Harceleur"
private.L.NPCs["10358"] = "Ombre de Fellicent"
private.L.NPCs["10359"] = "Sri'skulk"
private.L.NPCs["10376"] = "Croc cristallin"
private.L.NPCs["10393"] = "Krân"
private.L.NPCs["10509"] = "Jed Guette-runes"
private.L.NPCs["10558"] = "Chanteloge Forrestin"
private.L.NPCs["10559"] = "Dame Vespia"
private.L.NPCs["1063"] = "Jade"
private.L.NPCs["10639"] = "Joufflu le croquant"
private.L.NPCs["10640"] = "Chênepatte"
private.L.NPCs["10641"] = "Brise-Branche"
private.L.NPCs["10642"] = "Eck'alom"
private.L.NPCs["10644"] = "Hurleur des brumes"
private.L.NPCs["10647"] = "Prince Raze"
private.L.NPCs["10741"] = "Sian-Rotam"
private.L.NPCs["10809"] = "Echine-de-pierre"
private.L.NPCs["10817"] = "Duggan Marteau-hardi"
private.L.NPCs["10818"] = "Chevalier de la mort Porte-l'âme"
private.L.NPCs["10819"] = "Baron Sangreplaie"
private.L.NPCs["10820"] = "Duc Ravarage"
private.L.NPCs["10821"] = "Hed'mush le Pourrissant"
private.L.NPCs["10823"] = "Zul'Brin Voilebranche"
private.L.NPCs["10824"] = "Chasse-mort Eperlance"
private.L.NPCs["10825"] = "Gish l'Immobile"
private.L.NPCs["10826"] = "Seigneur Sombrefaux"
private.L.NPCs["10827"] = "Nécroratrice Selendre"
private.L.NPCs["10828"] = "Lynnia Abbendis"
private.L.NPCs["1106"] = "Cuisinier perdu"
private.L.NPCs["1112"] = "Veuve sanguine"
private.L.NPCs["1119"] = "Martelléchine"
private.L.NPCs["1130"] = "Bjarn"
private.L.NPCs["1132"] = "Grumeux"
private.L.NPCs["1137"] = "Edan le Hurleur"
private.L.NPCs["11383"] = "Grande prêtresse Hai'watna"
private.L.NPCs["1140"] = "Matriarche tranchegueule"
private.L.NPCs["11447"] = "Mushgog"
private.L.NPCs["11467"] = "Tsu'zee"
private.L.NPCs["11497"] = "La Razza"
private.L.NPCs["11498"] = "Bâlhafr le Brisé"
private.L.NPCs["11688"] = "Centaure maudit"
private.L.NPCs["12037"] = "Ursol'lok"
private.L.NPCs["12237"] = "Meshlok le Moissonneur"
private.L.NPCs["12431"] = "Croquetripe"
private.L.NPCs["12433"] = "Krethis Tisse-l'ombre"
private.L.NPCs["1260"] = "Grand-père Arctikus"
private.L.NPCs["12902"] = "Lorgus Jett"
private.L.NPCs["13896"] = "Barbe-d'écailles"
private.L.NPCs["1398"] = "Boss Galgosh"
private.L.NPCs["1399"] = "Magosh"
private.L.NPCs["14221"] = "Gravis Lecollet"
private.L.NPCs["14222"] = "Araga"
private.L.NPCs["14223"] = "Benj le teigneux"
private.L.NPCs["14224"] = "7:XT"
private.L.NPCs["14225"] = "Prince Kellen"
private.L.NPCs["14226"] = "Kaskk"
private.L.NPCs["14227"] = "Hissperak"
private.L.NPCs["14228"] = "Glousse"
private.L.NPCs["14229"] = "Ondulame maudit"
private.L.NPCs["14230"] = "Pique-les-Yeux"
private.L.NPCs["14231"] = "Drogoth le Vagabond"
private.L.NPCs["14232"] = "Flèche"
private.L.NPCs["14233"] = "Arrachécaille"
private.L.NPCs["14234"] = "Hayoc"
private.L.NPCs["14235"] = "La Pourriture"
private.L.NPCs["14236"] = "Seigneur Baudroie"
private.L.NPCs["14237"] = "Ver de limon"
private.L.NPCs["1424"] = "Maître Terrassier"
private.L.NPCs["1425"] = "Kubb"
private.L.NPCs["14266"] = "Shanda la Tisseuse"
private.L.NPCs["14267"] = "Emogg le Broyeur"
private.L.NPCs["14268"] = "Seigneur Condar"
private.L.NPCs["14269"] = "Aqualon le Chercheur"
private.L.NPCs["14270"] = "Squiddic"
private.L.NPCs["14271"] = "Chassecôtes"
private.L.NPCs["14272"] = "Grondefuse"
private.L.NPCs["14273"] = "Rochecœur"
private.L.NPCs["14275"] = "Tamra Foudrepique"
private.L.NPCs["14276"] = "Scargil"
private.L.NPCs["14277"] = "Dame Zephris"
private.L.NPCs["14278"] = "Ro'Bark"
private.L.NPCs["14279"] = "Insinueuse"
private.L.NPCs["14280"] = "Gros Samras"
private.L.NPCs["14281"] = "Jimmy le Saignant"
private.L.NPCs["14339"] = "Hurlemort"
private.L.NPCs["14340"] = "Alshirr Souffléau"
private.L.NPCs["14342"] = "Ragepatte"
private.L.NPCs["14343"] = "Olm la Sage"
private.L.NPCs["14344"] = "Mongress"
private.L.NPCs["14345"] = "L'Ongar"
private.L.NPCs["14424"] = "Bas-boueux"
private.L.NPCs["14425"] = "Ronge-les-os"
private.L.NPCs["14426"] = "Harb Mont-Souillé"
private.L.NPCs["14427"] = "Margouilloche"
private.L.NPCs["14428"] = "Uruson"
private.L.NPCs["14429"] = "Mornegueule"
private.L.NPCs["14430"] = "Traqueur de la pénombre"
private.L.NPCs["14431"] = "Furie Shelda"
private.L.NPCs["14432"] = "Threggil"
private.L.NPCs["14433"] = "Bouillasseux"
private.L.NPCs["14445"] = "Capitaine Wyrmak"
private.L.NPCs["14446"] = "Fingat"
private.L.NPCs["14447"] = "Gilmorian"
private.L.NPCs["14448"] = "Rougeronce"
private.L.NPCs["14471"] = "Setis"
private.L.NPCs["14472"] = "Gretheer"
private.L.NPCs["14473"] = "Lapress"
private.L.NPCs["14474"] = "Zora"
private.L.NPCs["14475"] = "Rex Ashil"
private.L.NPCs["14476"] = "Krellack"
private.L.NPCs["14477"] = "Grubthor"
private.L.NPCs["14478"] = "Ouraganien"
private.L.NPCs["14479"] = "Seigneur du Crépuscule Everun"
private.L.NPCs["14487"] = "Glougloug"
private.L.NPCs["14488"] = "Roloch"
private.L.NPCs["14490"] = "Rippa"
private.L.NPCs["14491"] = "Kurmokk"
private.L.NPCs["14492"] = "Drolatix"
private.L.NPCs["1531"] = "Ame égarée"
private.L.NPCs["1533"] = "Esprit tourmenté"
private.L.NPCs["1552"] = "Ventrécaille"
private.L.NPCs["16179"] = "Hyakiss la Rôdeuse"
private.L.NPCs["16180"] = "Shadikith le glisseur"
private.L.NPCs["16181"] = "Rodak le ravageur"
private.L.NPCs["16184"] = "Surveillant nérubien"
private.L.NPCs["16854"] = "Eldinarcus"
private.L.NPCs["16855"] = "Tregla"
private.L.NPCs["17144"] = "Sangredent"
private.L.NPCs["18241"] = "Croustille"
private.L.NPCs["1837"] = "Juge écarlate"
private.L.NPCs["1838"] = "Interrogateur écarlate"
private.L.NPCs["1839"] = "Grand prêtre écarlate"
private.L.NPCs["1841"] = "Bourreau écarlate"
private.L.NPCs["1843"] = "Contremaître Jerris"
private.L.NPCs["1844"] = "Contremaître Marcrid"
private.L.NPCs["1847"] = "Vilcrin"
private.L.NPCs["1848"] = "Seigneur Maldazzar"
private.L.NPCs["1849"] = "Bruissangoisse"
private.L.NPCs["1850"] = "Putridius"
private.L.NPCs["1851"] = "La Bogue"
private.L.NPCs["18677"] = "Mekthorg le Sauvage"
private.L.NPCs["18678"] = "Goinfreplein"
private.L.NPCs["18679"] = "Vorakem Parleruine"
private.L.NPCs["18680"] = "Marticar"
private.L.NPCs["18681"] = "Emissaire de Glissecroc"
private.L.NPCs["18682"] = "Rôdeur des tourbières"
private.L.NPCs["18683"] = "Chasseur du Vide Yar"
private.L.NPCs["18684"] = "Bro'Gaz Sans-Clan"
private.L.NPCs["18685"] = "Okrek"
private.L.NPCs["18686"] = "Auspice funeste Jurim"
private.L.NPCs["18689"] = "Estropieur"
private.L.NPCs["18690"] = "Morcrase"
private.L.NPCs["18692"] = "Hemathion"
private.L.NPCs["18693"] = "Porte-parole Mar'grom"
private.L.NPCs["18694"] = "Collidus le Guetteur-Dimensionnel"
private.L.NPCs["18695"] = "Ambassadeur Jerrikar"
private.L.NPCs["18696"] = "Kraator"
private.L.NPCs["18697"] = "Ingénieur en chef Lorthander"
private.L.NPCs["18698"] = "Permacœur le Punisseur"
private.L.NPCs["1885"] = "Forgeron écarlate"
private.L.NPCs["1910"] = "Muad"
private.L.NPCs["1911"] = "Deeb"
private.L.NPCs["1936"] = "Fermier de Solliden"
private.L.NPCs["2090"] = "Ma'ruk Wyrmécaille"
private.L.NPCs["20932"] = "Nuramoc"
private.L.NPCs["2108"] = "Garneg Grille-crâne"
private.L.NPCs["2162"] = "Agal"
private.L.NPCs["2172"] = "Matriarche trotteuse"
private.L.NPCs["21724"] = "Plaie-des-rapaces"
private.L.NPCs["2175"] = "Ombregriffe"
private.L.NPCs["2184"] = "Dame Mirelune"
private.L.NPCs["2186"] = "Carnivous le Casseur"
private.L.NPCs["2191"] = "Licillin"
private.L.NPCs["2192"] = "Mandefeu Radison"
private.L.NPCs["22060"] = "Fenissa l'Assassin"
private.L.NPCs["22062"] = "Docteur Gâtemembre"
private.L.NPCs["2258"] = "Maggarrak"
private.L.NPCs["2452"] = "Grybou"
private.L.NPCs["2453"] = "Lo'Grosh"
private.L.NPCs["2476"] = "Gosh-Haldir"
private.L.NPCs["2541"] = "Seigneur Sakrasis"
private.L.NPCs["2598"] = "Darbel Montrose"
private.L.NPCs["2600"] = "Singer"
private.L.NPCs["2601"] = "Souillebedon"
private.L.NPCs["2602"] = "Ruul Unepierre"
private.L.NPCs["2603"] = "Kovork"
private.L.NPCs["2604"] = "Molok l’Anéantisseur"
private.L.NPCs["2605"] = "Zalas fanécorce"
private.L.NPCs["2606"] = "Nimar le Pourfendeur"
private.L.NPCs["2609"] = "Géomancien Dague-de-silex"
private.L.NPCs["2744"] = "Commandant ombreforge"
private.L.NPCs["2749"] = "Barricade"
private.L.NPCs["2751"] = "Golem de guerre"
private.L.NPCs["2752"] = "Grondeur"
private.L.NPCs["2753"] = "Barnabus"
private.L.NPCs["2754"] = "Anathemus"
private.L.NPCs["2779"] = "Prince Nazjak"
private.L.NPCs["2850"] = "Brèchedent"
private.L.NPCs["2931"] = "Zaricotl"
private.L.NPCs["3058"] = "Arra'chea"
private.L.NPCs["3068"] = "Mazzranache"
private.L.NPCs["32357"] = "Vieil Ecorce-de-Cristal"
private.L.NPCs["32358"] = "Larmagauche Venbraye"
private.L.NPCs["32361"] = "Corneglace"
private.L.NPCs["32377"] = "Perobas le Carnassier"
private.L.NPCs["32386"] = "Vigdis la Vierge de guerre"
private.L.NPCs["32398"] = "Roi Ping"
private.L.NPCs["32400"] = "Tukemuth"
private.L.NPCs["32409"] = "Survivant d'Indu'le affolé"
private.L.NPCs["32417"] = "Généralissime écarlate Daion"
private.L.NPCs["32422"] = "Grocklar"
private.L.NPCs["32429"] = "Haine vengeresse"
private.L.NPCs["32435"] = "Vern"
private.L.NPCs["32438"] = "Syreian la Sculpteuse d'os"
private.L.NPCs["32447"] = "Sentinelle de Zul'Drak"
private.L.NPCs["32471"] = "Griegen"
private.L.NPCs["32475"] = "Tisseuse de terreur"
private.L.NPCs["32481"] = "Aotona"
private.L.NPCs["32485"] = "Roi Krush"
private.L.NPCs["32487"] = "Putridus l'Antique"
private.L.NPCs["32491"] = "Proto-drake perdu dans le temps"
private.L.NPCs["32495"] = "Hildana Voleuse-de-Mort"
private.L.NPCs["32500"] = "Dirkee"
private.L.NPCs["32501"] = "Grand thane Jorfus"
private.L.NPCs["32517"] = "Loque'nahak"
private.L.NPCs["3253"] = "Moissonneur silithide"
private.L.NPCs["32630"] = "Vyragosa"
private.L.NPCs["3270"] = "Ancienne mystique Tranchegroin"
private.L.NPCs["3295"] = "Anomalie de vase"
private.L.NPCs["33776"] = "Gondria"
private.L.NPCs["3398"] = "Gesharahan"
private.L.NPCs["3470"] = "Rathorian"
private.L.NPCs["35189"] = "Skoll"
private.L.NPCs["3535"] = "Noiremousse le Fétide"
private.L.NPCs["3581"] = "Bête des égouts"
private.L.NPCs["3652"] = "Trigore le Flagelleur"
private.L.NPCs["3672"] = "Boahn"
private.L.NPCs["3735"] = "Apothicaire Falthis"
private.L.NPCs["3736"] = "Assassin Mordenthal"
private.L.NPCs["3773"] = "Akkrilus"
private.L.NPCs["3792"] = "Chef de meute Frayeloup"
private.L.NPCs["38453"] = "Arcturis"
private.L.NPCs["3872"] = "Capitaine Ligemort"
private.L.NPCs["39183"] = "Scorpitar"
private.L.NPCs["39185"] = "Mâchécume"
private.L.NPCs["39186"] = "Mirenfer"
private.L.NPCs["4066"] = "Nal'taszar"
private.L.NPCs["4132"] = "Krkk'kx"
private.L.NPCs["4339"] = "Soufresang"
private.L.NPCs["43488"] = "Mordei le Trancheterre"
private.L.NPCs["43613"] = "Auspice funeste Cours-avec-Sagesse"
private.L.NPCs["43720"] = "Mantépine « la flemme »"
private.L.NPCs["4380"] = "Veuve de Sombrebrume"
private.L.NPCs["44224"] = "Deux-Orteils"
private.L.NPCs["44225"] = "Rufus Sombretrait"
private.L.NPCs["44226"] = "Grondecroc"
private.L.NPCs["44227"] = "Gazz le Chasseur du loch"
private.L.NPCs["4425"] = "Chasseur aveugle"
private.L.NPCs["44714"] = "Fronkle le Dérangé"
private.L.NPCs["44722"] = "Reflet tordu de Narain"
private.L.NPCs["44750"] = "Caliph Dard-de-Scorpide"
private.L.NPCs["44759"] = "André Barbe-en-Feu"
private.L.NPCs["44761"] = "Aquementas le Libéré"
private.L.NPCs["44767"] = "Occulus le Corrompu"
private.L.NPCs["45257"] = "Mordak Torlanuit"
private.L.NPCs["45258"] = "Cassia la reine ondulante"
private.L.NPCs["45260"] = "Feuillenuit"
private.L.NPCs["45262"] = "Narixxus le Porte-destin"
private.L.NPCs["45369"] = "Morick Sombrebière"
private.L.NPCs["45380"] = "Queue-Cendrée"
private.L.NPCs["45384"] = "Sagepatte"
private.L.NPCs["45398"] = "Grizlak"
private.L.NPCs["45399"] = "Optimo"
private.L.NPCs["45401"] = "Aileron-Blanc"
private.L.NPCs["45402"] = "Nix"
private.L.NPCs["45404"] = "Géoformeuse Maren"
private.L.NPCs["45739"] = "Le Soldat Inconnu"
private.L.NPCs["45740"] = "Gardien Eva"
private.L.NPCs["45771"] = "Marus"
private.L.NPCs["45785"] = "Le Sculpté"
private.L.NPCs["45801"] = "Eliza"
private.L.NPCs["45811"] = "Marina DeSirrus"
private.L.NPCs["462"] = "Vultros"
private.L.NPCs["46981"] = "Cinglenuit"
private.L.NPCs["46992"] = "Berard le Lunatique"
private.L.NPCs["47003"] = "Bolgaff"
private.L.NPCs["47008"] = "Fenwick Thatros"
private.L.NPCs["47009"] = "Aquarius le Délié"
private.L.NPCs["47010"] = "Indigos"
private.L.NPCs["47012"] = "Effritus"
private.L.NPCs["47015"] = "Fils perdu d'Arugal"
private.L.NPCs["47023"] = "Thule Serres-de-corbeau"
private.L.NPCs["471"] = "Mère Croc"
private.L.NPCs["472"] = "Fenouillard"
private.L.NPCs["47386"] = "Ainamiss la Reine de la ruche"
private.L.NPCs["47387"] = "Harakiss l'Infestateur"
private.L.NPCs["4842"] = "Implorateur de la terre Halmgar"
private.L.NPCs["49822"] = "Jadecroc"
private.L.NPCs["49913"] = "Dame La-La"
private.L.NPCs["50005"] = "Poséidus"
private.L.NPCs["50009"] = "Mobus"
private.L.NPCs["50050"] = "Shok'sharak"
private.L.NPCs["50051"] = "Clampant fantôme"
private.L.NPCs["50052"] = "Burgy Cœur-Noir"
private.L.NPCs["50053"] = "Thartuk l'Exilé"
private.L.NPCs["50056"] = "Garr"
private.L.NPCs["50057"] = "Ailembrase"
private.L.NPCs["50058"] = "Terrorpene"
private.L.NPCs["50059"] = "Golgarok"
private.L.NPCs["50060"] = "Terborus"
private.L.NPCs["50061"] = "Xariona"
private.L.NPCs["50062"] = "Aeonaxx"
private.L.NPCs["50063"] = "Akma'hat"
private.L.NPCs["50064"] = "Cyrus le Noir"
private.L.NPCs["50065"] = "Armaglyptodon"
private.L.NPCs["50085"] = "Suzerain Fractefurie"
private.L.NPCs["50086"] = "Tarvus le Vil"
private.L.NPCs["50089"] = "Julak-Dram"
private.L.NPCs["50138"] = "Karoma"
private.L.NPCs["50154"] = "Madexx"
private.L.NPCs["50159"] = "Samba"
private.L.NPCs["50328"] = "Fangor"
private.L.NPCs["50329"] = "Rrakk"
private.L.NPCs["50330"] = "Kree"
private.L.NPCs["50331"] = "Go Kan"
private.L.NPCs["50332"] = "Korda Torros"
private.L.NPCs["50333"] = "Lon le Buffle"
private.L.NPCs["50334"] = "Dak le Briseur"
private.L.NPCs["50335"] = "Alitus"
private.L.NPCs["50336"] = "Yorik Œil Vif"
private.L.NPCs["50337"] = "Pioupiou"
private.L.NPCs["50338"] = "Kor’nas Nuit Sauvage"
private.L.NPCs["50339"] = "Sulik’shor"
private.L.NPCs["50340"] = "Gaarn le Toxique"
private.L.NPCs["50341"] = "Borginn Sombre Poing"
private.L.NPCs["50342"] = "Heronis"
private.L.NPCs["50343"] = "Quall"
private.L.NPCs["50344"] = "Norlaxx"
private.L.NPCs["50345"] = "Alit"
private.L.NPCs["50346"] = "Ronak"
private.L.NPCs["50347"] = "Karr l’Assombrisseur"
private.L.NPCs["50348"] = "Norissis"
private.L.NPCs["50349"] = "Kang le Voleur d’âmes"
private.L.NPCs["50350"] = "Morgrinn Casse Crocs"
private.L.NPCs["50351"] = "Jonn-Dar"
private.L.NPCs["50352"] = "Qu’nas"
private.L.NPCs["50353"] = "Manas"
private.L.NPCs["50354"] = "Havak"
private.L.NPCs["50355"] = "Kah’tir"
private.L.NPCs["50356"] = "Krol la Lame"
private.L.NPCs["50357"] = "Vol-Solaire"
private.L.NPCs["50358"] = "Assemblage saccage-soleil détraqué"
private.L.NPCs["50359"] = "Urgolax"
private.L.NPCs["50361"] = "Ornat"
private.L.NPCs["50362"] = "Sombre-Tourbe le Croc"
private.L.NPCs["50363"] = "Krax’ik"
private.L.NPCs["50364"] = "Nal’lak l’Éventreur"
private.L.NPCs["50370"] = "Karapax"
private.L.NPCs["50388"] = "Torik-Ethis"
private.L.NPCs["506"] = "Sergent Promptegriffe"
private.L.NPCs["507"] = "Fenros"
private.L.NPCs["50724"] = "Rampe-Epine"
private.L.NPCs["50725"] = "Azelisk"
private.L.NPCs["50726"] = "Kalixx"
private.L.NPCs["50727"] = "Strix le Barbelé"
private.L.NPCs["50728"] = "Frappe-de-Mort"
private.L.NPCs["50730"] = "Echine-de-Venin"
private.L.NPCs["50731"] = "Dentapique"
private.L.NPCs["50733"] = "Ski’thik"
private.L.NPCs["50734"] = "Lith’ik le Traqueur"
private.L.NPCs["50735"] = "Cligne-L'œil le serpent à sonnette"
private.L.NPCs["50737"] = "Acroniss"
private.L.NPCs["50738"] = "Scintécaille"
private.L.NPCs["50739"] = "Gar’lok"
private.L.NPCs["50741"] = "Kaxx"
private.L.NPCs["50742"] = "Qem"
private.L.NPCs["50743"] = "Manax"
private.L.NPCs["50744"] = "Qu'rik"
private.L.NPCs["50745"] = "Losaj"
private.L.NPCs["50746"] = "Bornix le Creuseur"
private.L.NPCs["50747"] = "Tix"
private.L.NPCs["50748"] = "Nyaj"
private.L.NPCs["50749"] = "Kal’tik le Chancre"
private.L.NPCs["50750"] = "Aethis"
private.L.NPCs["50752"] = "Tarantis"
private.L.NPCs["50759"] = "Iriss la Veuve"
private.L.NPCs["50763"] = "Traqueur des ombres"
private.L.NPCs["50764"] = "Paraliss"
private.L.NPCs["50765"] = "Miasmanque"
private.L.NPCs["50766"] = "Sele’na"
private.L.NPCs["50768"] = "Cournith Court-sur-l’Eau"
private.L.NPCs["50769"] = "Zaï le Paria"
private.L.NPCs["50770"] = "Zorn"
private.L.NPCs["50772"] = "Eshelon"
private.L.NPCs["50775"] = "Likk le Chasseur"
private.L.NPCs["50776"] = "Nalash Verdantis"
private.L.NPCs["50777"] = "Aiguille"
private.L.NPCs["50778"] = "Toile-de-Fer"
private.L.NPCs["50779"] = "Sporeggon"
private.L.NPCs["50780"] = "Sahn Chasse Marée"
private.L.NPCs["50782"] = "Sarnak"
private.L.NPCs["50783"] = "Eclaireur de guerre salyin"
private.L.NPCs["50784"] = "Anith"
private.L.NPCs["50785"] = "Ombreciel"
private.L.NPCs["50786"] = "Etinçaile"
private.L.NPCs["50787"] = "Arness l’Écaille"
private.L.NPCs["50788"] = "Quetzl"
private.L.NPCs["50789"] = "Nessos l'Oracle"
private.L.NPCs["50790"] = "Ionis"
private.L.NPCs["50791"] = "Siltriss l’Affûteur"
private.L.NPCs["50792"] = "Chii"
private.L.NPCs["50797"] = "Yukiko"
private.L.NPCs["50803"] = "Mâche-les-Os"
private.L.NPCs["50804"] = "Arrache-Aile"
private.L.NPCs["50805"] = "Omnis Grimalok"
private.L.NPCs["50806"] = "Moldo le Borgne"
private.L.NPCs["50807"] = "Catal"
private.L.NPCs["50808"] = "Urobi le Marcheur"
private.L.NPCs["50809"] = "Héress"
private.L.NPCs["50810"] = "Favori d'Isiset"
private.L.NPCs["50811"] = "Nasra Poil Ocellé"
private.L.NPCs["50812"] = "Arae"
private.L.NPCs["50813"] = "Fene-Mal"
private.L.NPCs["50814"] = "Nécrobi"
private.L.NPCs["50815"] = "Bal'afr"
private.L.NPCs["50816"] = "Runn Patte Fantôme"
private.L.NPCs["50817"] = "Ahone l’Errante"
private.L.NPCs["50818"] = "Le rôdeur sombre"
private.L.NPCs["50819"] = "Griffe-glace"
private.L.NPCs["50820"] = "Yul Patte Folle"
private.L.NPCs["50821"] = "Ai Li Moire Ciel"
private.L.NPCs["50822"] = "Ai Ran le Nuage Fantasque"
private.L.NPCs["50823"] = "Monsieur Féroce"
private.L.NPCs["50825"] = "Feras"
private.L.NPCs["50828"] = "Bonobos"
private.L.NPCs["50830"] = "Spriggin"
private.L.NPCs["50831"] = "Grattouille"
private.L.NPCs["50832"] = "Le Couineur"
private.L.NPCs["50833"] = "Sombre-Poil"
private.L.NPCs["50836"] = "Ik-Ik l’Agile"
private.L.NPCs["50837"] = "Kash"
private.L.NPCs["50838"] = "Tabbs"
private.L.NPCs["50839"] = "Chromolosse"
private.L.NPCs["50840"] = "Major Sinok"
private.L.NPCs["50842"] = "Magmagan"
private.L.NPCs["50846"] = "Bavegueule"
private.L.NPCs["50855"] = "Jaxx l'Enragé"
private.L.NPCs["50856"] = "Snark"
private.L.NPCs["50858"] = "Poudraile"
private.L.NPCs["50864"] = "Fourré"
private.L.NPCs["50865"] = "Saurix"
private.L.NPCs["50874"] = "Tenok"
private.L.NPCs["50875"] = "Nychus"
private.L.NPCs["50876"] = "Avis"
private.L.NPCs["50882"] = "Chupacabros"
private.L.NPCs["50884"] = "Cours-Poussière le Poltron"
private.L.NPCs["50886"] = "Aile-mer"
private.L.NPCs["50891"] = "Boros"
private.L.NPCs["50892"] = "Cyn"
private.L.NPCs["50895"] = "Volux"
private.L.NPCs["50897"] = "Ffexk le Traquedune"
private.L.NPCs["50901"] = "Teromak"
private.L.NPCs["50903"] = "Orlix le Seigneur des marais"
private.L.NPCs["50905"] = "Cida"
private.L.NPCs["50906"] = "Mutilax"
private.L.NPCs["50908"] = "Nocthurle"
private.L.NPCs["50915"] = "Nifle"
private.L.NPCs["50916"] = "Pattefolle le Pleurnicheur"
private.L.NPCs["50922"] = "Warg"
private.L.NPCs["50925"] = "Arpente-Bosquet"
private.L.NPCs["50926"] = "Vieux Ben"
private.L.NPCs["50929"] = "Petit Bjorn"
private.L.NPCs["50930"] = "Hibernus le Dormeur"
private.L.NPCs["50931"] = "Galou"
private.L.NPCs["50937"] = "Lacouenne"
private.L.NPCs["50940"] = "Swee"
private.L.NPCs["50942"] = "Groin le Fouinard"
private.L.NPCs["50945"] = "Bouriffe"
private.L.NPCs["50946"] = "Porzilla"
private.L.NPCs["50947"] = "Varah"
private.L.NPCs["50948"] = "Dos-de-Cristal"
private.L.NPCs["50949"] = "Gambit de Finn"
private.L.NPCs["50952"] = "Jim le Bigorneau"
private.L.NPCs["50955"] = "Carcinak"
private.L.NPCs["50957"] = "Grosse-Pince"
private.L.NPCs["50959"] = "Karkin"
private.L.NPCs["50964"] = "Babines"
private.L.NPCs["50967"] = "Panse le Ravageur"
private.L.NPCs["50986"] = "Toison-d’Or"
private.L.NPCs["50993"] = "Gal'dorak"
private.L.NPCs["50995"] = "Cogneur"
private.L.NPCs["50997"] = "Bornak l’Eventreur"
private.L.NPCs["51000"] = "Sombrecoque l'Impénétrable"
private.L.NPCs["51001"] = "Griffe-Venin"
private.L.NPCs["51002"] = "Scorpoxx"
private.L.NPCs["51004"] = "Toxx"
private.L.NPCs["51007"] = "Serkett"
private.L.NPCs["51008"] = "L'horreur barbelée"
private.L.NPCs["51010"] = "Cisoire"
private.L.NPCs["51014"] = "Terrapis"
private.L.NPCs["51017"] = "Gezan"
private.L.NPCs["51018"] = "Zormus"
private.L.NPCs["51021"] = "Vorticus"
private.L.NPCs["51022"] = "Chordix"
private.L.NPCs["51025"] = "Dilennaa"
private.L.NPCs["51026"] = "Gnath"
private.L.NPCs["51027"] = "Spirocula"
private.L.NPCs["51028"] = "Le tunnelier des profondeurs"
private.L.NPCs["51029"] = "Parasitus"
private.L.NPCs["51031"] = "Pisteur"
private.L.NPCs["51037"] = "Chien de guerre gilnéen égaré"
private.L.NPCs["51040"] = "Sniffeur"
private.L.NPCs["51042"] = "Pâlecœur"
private.L.NPCs["51044"] = "Peste"
private.L.NPCs["51045"] = "Arcanus"
private.L.NPCs["51046"] = "Fidonis"
private.L.NPCs["51048"] = "Rexxus"
private.L.NPCs["51052"] = "Gib l'Amasseur de bananes"
private.L.NPCs["51053"] = "Quirix"
private.L.NPCs["51057"] = "Calamitus"
private.L.NPCs["51058"] = "Aphis"
private.L.NPCs["51059"] = "Sabot d’Encre"
private.L.NPCs["51061"] = "Roth-Salam"
private.L.NPCs["51062"] = "Khep-Ré"
private.L.NPCs["51063"] = "Phalanax"
private.L.NPCs["51066"] = "Croc-de-Cristal"
private.L.NPCs["51067"] = "Moire"
private.L.NPCs["51069"] = "Scintillex"
private.L.NPCs["51071"] = "Capitaine Florence"
private.L.NPCs["51076"] = "Lopex"
private.L.NPCs["51077"] = "Panache"
private.L.NPCs["51078"] = "Ferdinand"
private.L.NPCs["51079"] = "Capitaine Souillaile"
private.L.NPCs["51401"] = "Madexx"
private.L.NPCs["51402"] = "Madexx"
private.L.NPCs["51403"] = "Madexx"
private.L.NPCs["51404"] = "Madexx"
private.L.NPCs["51658"] = "Mogh le Mort"
private.L.NPCs["51661"] = "Tsul'Kalu"
private.L.NPCs["51662"] = "Mahamba"
private.L.NPCs["51663"] = "Pogeyan"
private.L.NPCs["519"] = "Slark"
private.L.NPCs["520"] = "Brack"
private.L.NPCs["521"] = "Lupos"
private.L.NPCs["52146"] = "Crisseuse"
private.L.NPCs["534"] = "Nefaru"
private.L.NPCs["5343"] = "Dame Szallah"
private.L.NPCs["5345"] = "Tête-de-diamant"
private.L.NPCs["5346"] = "Rugissang le Traqueur"
private.L.NPCs["5347"] = "Antilus le Planeur"
private.L.NPCs["5348"] = "Gardien des rêves Langue-Fourchue"
private.L.NPCs["5349"] = "Arash-ethis"
private.L.NPCs["5350"] = "Qirot"
private.L.NPCs["5352"] = "Vieux Grisebedaine"
private.L.NPCs["5354"] = "Noueux Frèrefeuilles"
private.L.NPCs["5356"] = "Grogneur"
private.L.NPCs["54318"] = "Ankha"
private.L.NPCs["54319"] = "Magria"
private.L.NPCs["54320"] = "Ban’thalos"
private.L.NPCs["54321"] = "Solix"
private.L.NPCs["54322"] = "Deth’tilac"
private.L.NPCs["54323"] = "Kirix"
private.L.NPCs["54324"] = "Rampeflamme"
private.L.NPCs["54338"] = "Anthriss"
private.L.NPCs["54533"] = "Prince Lakma"
private.L.NPCs["56081"] = "Benj l’optimiste"
private.L.NPCs["572"] = "Leprithus"
private.L.NPCs["573"] = "Faucheur 4000"
private.L.NPCs["574"] = "Naraxis"
private.L.NPCs["5785"] = "Sœur Cinglehaine"
private.L.NPCs["5786"] = "Travépieu"
private.L.NPCs["5787"] = "Massacreur Emilgund"
private.L.NPCs["5807"] = "Le Griffu"
private.L.NPCs["5809"] = "Sergent Curtis"
private.L.NPCs["5822"] = "Gangretisseur Arrogg"
private.L.NPCs["5823"] = "Ecorcheur mortel"
private.L.NPCs["5824"] = "Capitaine Plate-Défense"
private.L.NPCs["5826"] = "Géomaîtresse Mouchette"
private.L.NPCs["5828"] = "Humar le Fier"
private.L.NPCs["5829"] = "Nifle la Moqueuse"
private.L.NPCs["5830"] = "Sœur Rathtalon"
private.L.NPCs["5831"] = "Vif-crins"
private.L.NPCs["5832"] = "Grondeterre"
-- private.L.NPCs["58336"] = "Darkmoon Rabbit"
private.L.NPCs["5834"] = "Azzere la lame céleste"
private.L.NPCs["5835"] = "Contremaître Grills"
private.L.NPCs["5836"] = "Ingénieur Tourbicoton"
private.L.NPCs["5837"] = "Bras-de-pierre"
private.L.NPCs["5838"] = "Brise-Epieu"
private.L.NPCs["584"] = "Kazon"
private.L.NPCs["5841"] = "Rochelance"
private.L.NPCs["5842"] = "Takk le Bondisseur"
private.L.NPCs["5847"] = "Heggin Moustache-de-pierre"
private.L.NPCs["58474"] = "Pointe-sanglante"
private.L.NPCs["5848"] = "Malgin Brasselorge"
private.L.NPCs["5849"] = "Terrassier Forgeflamme"
private.L.NPCs["5851"] = "Capitaine Gerogg Martèlorteil"
private.L.NPCs["5859"] = "Hagg Plaie-des-taurens"
private.L.NPCs["5863"] = "Géoprêtresse Gukk'rok"
private.L.NPCs["5864"] = "Peau-piquante Pourcegart"
private.L.NPCs["5865"] = "Dishu"
private.L.NPCs["58768"] = "Crachecroc"
private.L.NPCs["58769"] = "Mâchevice"
private.L.NPCs["58771"] = "Quid"
private.L.NPCs["58778"] = "Aetha"
private.L.NPCs["58817"] = "Esprit de Lao Fe"
private.L.NPCs["58949"] = "Bai Jin le Boucher"
private.L.NPCs["5912"] = "Dragon féerique déviant"
private.L.NPCs["5915"] = "Frère Corvichêne"
private.L.NPCs["5928"] = "Ailes du désespoir"
private.L.NPCs["5930"] = "Sœur Riven"
private.L.NPCs["5932"] = "Sous-chef Fouettecroc"
private.L.NPCs["5933"] = "Achellios le Banni"
private.L.NPCs["5935"] = "Ferregard l’Invincible"
private.L.NPCs["59369"] = "Docteur Theolen Krastinov"
private.L.NPCs["5937"] = "Dardeur"
private.L.NPCs["596"] = "Noble manipulé"
private.L.NPCs["599"] = "Marisa du'Paige"
private.L.NPCs["60491"] = "Sha de la colère" -- Needs review
private.L.NPCs["61"] = "Thuros Doigts-agiles"
private.L.NPCs["6118"] = "Fantôme de Varo'then"
private.L.NPCs["616"] = "Cliqueteuse"
private.L.NPCs["62"] = "Gug Grosse-Bougie"
private.L.NPCs["6228"] = "Ambassadeur sombrefer"
private.L.NPCs["62346"] = "Galion" -- Needs review
private.L.NPCs["62880"] = "Gochao le Poing de Fer"
private.L.NPCs["62881"] = "Gaohun le Sectionneur d’âmes"
private.L.NPCs["63101"] = "Général Temuja"
private.L.NPCs["63240"] = "Maître d'ombre Sydow"
private.L.NPCs["63510"] = "Wulon"
private.L.NPCs["63691"] = "Huo Shuang"
private.L.NPCs["63695"] = "Baolai l’Immolateur"
private.L.NPCs["63977"] = "Vyraxxis"
private.L.NPCs["63978"] = "Kri’chon"
private.L.NPCs["64403"] = "Alani" -- Needs review
private.L.NPCs["6581"] = "Matriarche ravasaure"
private.L.NPCs["6582"] = "Matriarche Zavas"
private.L.NPCs["6583"] = "Gruff"
private.L.NPCs["6584"] = "Roi Mosh"
private.L.NPCs["6585"] = "Uhk'loc"
private.L.NPCs["6648"] = "Antilos"
private.L.NPCs["6649"] = "Dame Sesspira"
private.L.NPCs["6650"] = "Général Crocdangoiffe"
private.L.NPCs["6651"] = "Portier Hurlerage"
private.L.NPCs["68317"] = "Mavis Laruine"
private.L.NPCs["68318"] = "Dalan Brisenuit"
private.L.NPCs["68319"] = "Disha Gardepeur"
private.L.NPCs["68320"] = "Ubunti l’Ombre"
private.L.NPCs["68321"] = "Kar le Va-t-en-Guerre"
private.L.NPCs["68322"] = "Muerta"
-- private.L.NPCs["69099"] = "Nalak"
private.L.NPCs["69664"] = "Mumta"
private.L.NPCs["69768"] = "Eclaireur de guerre zandalari"
private.L.NPCs["69769"] = "Porteguerre zandalari"
private.L.NPCs["69841"] = "Porteguerre zandalari"
private.L.NPCs["69842"] = "Porteguerre zandalari"
private.L.NPCs["69843"] = "Zao’cho"
private.L.NPCs["69996"] = "Ku’lai, la Griffe du ciel"
private.L.NPCs["69997"] = "Progénitus"
private.L.NPCs["69998"] = "Goda"
private.L.NPCs["69999"] = "Dieu-mastodonte Ramuk"
private.L.NPCs["70000"] = "Al’tabim Qui-Voit-Tout"
private.L.NPCs["70001"] = "Brise-dos Uru"
private.L.NPCs["70002"] = "Lu Ban"
private.L.NPCs["70003"] = "Molthor"
private.L.NPCs["70096"] = "Dieu-guerrier Dokah"
private.L.NPCs["70126"] = "Willy Wilder"
private.L.NPCs["7015"] = "Flagglemurk le Cruel"
private.L.NPCs["7016"] = "Dame Vespira"
private.L.NPCs["7017"] = "Seigneur Salvassio"
private.L.NPCs["70238"] = "Oeil impassible"
private.L.NPCs["70243"] = "Archiritualiste Kelada"
private.L.NPCs["70249"] = "Oeil focalisé"
private.L.NPCs["70276"] = "No’ku Parle-Tempête"
private.L.NPCs["70323"] = "Krakkanon"
private.L.NPCs["70430"] = "Horreur rocheuse"
private.L.NPCs["70440"] = "Monara"
private.L.NPCs["70530"] = "Ra’sha"
private.L.NPCs["7104"] = "Dessecus"
private.L.NPCs["7137"] = "Immolatus"
private.L.NPCs["71864"] = "Souterrant"
private.L.NPCs["71919"] = "Zhu Gon l’Amer"
-- private.L.NPCs["71992"] = "Moonfang"
private.L.NPCs["72045"] = "Chelon"
private.L.NPCs["72048"] = "Déglingois"
private.L.NPCs["72049"] = "Croque-grue"
private.L.NPCs["72193"] = "Karkanos"
private.L.NPCs["72245"] = "Zesqua"
private.L.NPCs["72769"] = "Esprit de Jadefeu"
private.L.NPCs["72775"] = "Bufo"
private.L.NPCs["72808"] = "Tsavo’ka"
private.L.NPCs["72909"] = "Gu’chi l’Essaimeur"
private.L.NPCs["72970"] = "Golganarr"
private.L.NPCs["73157"] = "Mousse des rochers"
private.L.NPCs["73158"] = "Jars émeraude"
private.L.NPCs["73160"] = "Corne-d’acier ferpoil"
private.L.NPCs["73161"] = "Grande tortue Écaille-de-Fureur"
private.L.NPCs["73163"] = "Python impérial"
private.L.NPCs["73166"] = "Pincépine monstrueux"
private.L.NPCs["73167"] = "Huolon"
private.L.NPCs["73169"] = "Jakur d’Ordos"
private.L.NPCs["73170"] = "Guetteur Osu"
private.L.NPCs["73171"] = "Champion de la flamme noire"
private.L.NPCs["73172"] = "Seigneur des silex Gairan"
private.L.NPCs["73173"] = "Urdur le Cautérisateur"
private.L.NPCs["73174"] = "Archiprêtre de flammes"
private.L.NPCs["73175"] = "Cendrechute"
private.L.NPCs["73277"] = "Soigne-Feuille"
private.L.NPCs["73279"] = "Gueule-Éternelle"
private.L.NPCs["73281"] = "Bateau de l’effroi Vazuvius"
private.L.NPCs["73282"] = "Garnia"
private.L.NPCs["73293"] = "Siffleur"
private.L.NPCs["73666"] = "Archiprêtre de flammes"
private.L.NPCs["73704"] = "Fouettnatte"
private.L.NPCs["763"] = "Chef Perdu"
private.L.NPCs["7846"] = "Teremus le Dévoreur"
private.L.NPCs["79"] = "Narg le Sous-chef"
private.L.NPCs["8199"] = "Chef de guerre Krazzilak"
private.L.NPCs["8200"] = "Jin'Zallah Porte-sable"
private.L.NPCs["8201"] = "Omgorn l'Egaré"
private.L.NPCs["8203"] = "Kregg Soulaquille"
private.L.NPCs["8204"] = "Soriid le Dévoreur"
private.L.NPCs["8205"] = "Haarka le Féroce"
private.L.NPCs["8207"] = "Braisaile"
private.L.NPCs["8210"] = "Trancheserre"
private.L.NPCs["8211"] = "Vieux Saute-falaise"
private.L.NPCs["8212"] = "Le Jonc"
private.L.NPCs["8213"] = "Dos-de-fer"
private.L.NPCs["8214"] = "Jalinde Drake-d'été"
private.L.NPCs["8215"] = "Grimungous"
private.L.NPCs["8216"] = "Retherokk le Berserker"
private.L.NPCs["8217"] = "Mith'rethis l'Enchanteur"
private.L.NPCs["8218"] = "Flétricœur le Traqueur"
private.L.NPCs["8219"] = "Zul'arek Volaillaîne"
private.L.NPCs["8277"] = "Rekk'tilac"
private.L.NPCs["8278"] = "Fumar"
private.L.NPCs["8279"] = "Golem de guerre défaillant"
private.L.NPCs["8280"] = "Shleipnarr"
private.L.NPCs["8281"] = "Brûlar"
private.L.NPCs["8282"] = "Généralissime Mastrogonde"
private.L.NPCs["8283"] = "Maître des esclaves Cœur-Noir"
private.L.NPCs["8296"] = "Mojo le Tordu"
private.L.NPCs["8297"] = "Magronos l'Inflexible"
private.L.NPCs["8298"] = "Akubar le Prophète"
private.L.NPCs["8299"] = "Ecorchebile"
private.L.NPCs["8300"] = "Ravage"
private.L.NPCs["8301"] = "Clack le Saccageur"
private.L.NPCs["8302"] = "Oeil-de-mort"
private.L.NPCs["8303"] = "Grunter"
private.L.NPCs["8304"] = "Dériseffroi"
private.L.NPCs["8503"] = "Margouilleur"
private.L.NPCs["8660"] = "L'Evalcharr"
private.L.NPCs["8923"] = "Panzor l'Invincible"
private.L.NPCs["8924"] = "Le Béhémoth"
private.L.NPCs["8976"] = "Hématos"
private.L.NPCs["8978"] = "Thauris Balgarr"
private.L.NPCs["8979"] = "Gruklash"
private.L.NPCs["8981"] = "Saccageur défectueux"
private.L.NPCs["9217"] = "Seigneur magus pierre-du-pic"
private.L.NPCs["9218"] = "Seigneur de bataille pierre-du-pic"
private.L.NPCs["9219"] = "Boucher pierre-du-pic"
private.L.NPCs["947"] = "Rohh le silencieux"
private.L.NPCs["9596"] = "Bannok Hache-Sinistre"
private.L.NPCs["9602"] = "Hahk'Zor"
private.L.NPCs["9604"] = "Gorgon'och"
private.L.NPCs["9718"] = "Ghok Bounnebaffe"
private.L.NPCs["9736"] = "Intendant Zigris"
private.L.NPCs["99"] = "Morgaine la rusée"

-- private.L["BUTTON_TOOLTIP_LINE1"] = "|cffffee00 _NPCScan.Overlay|r"
-- private.L["BUTTON_TOOLTIP_LINE2"] = "|cffd6ff00 Click: |r Toggles World Map paths"
-- private.L["BUTTON_TOOLTIP_LINE3"] = "|cffd6ff00 Shift Click: |r Toggles World Map key"
-- private.L["BUTTON_TOOLTIP_LINE4"] = "|cffd6ff00 Right-Click: |r Toggles Mini Map paths"
-- private.L["BUTTON_TOOLTIP_LINE5"] = "|cffaaf200 Middle-Click: |r Toggle display of Both Mini & World Map paths"
-- private.L["BUTTON_TOOLTIP_LINE6"] = "|cff6cff00 Shift Middle-Click:: |r Open Options Menu"
private.L["CONFIG_ALPHA"] = "Transparence"
private.L["CONFIG_DESC"] = "Détermine sur quelles cartes les trajets des monstres seront ajoutés. La plupart des addons modifiant la carte se contrôlent avec les options de la carte du monde."
private.L["CONFIG_SHOWALL"] = "Toujours afficher tous les trajets"
private.L["CONFIG_SHOWALL_DESC"] = "Normalement, quand un monstre n'est pas recherché, son trajet n'est pas affiché sur la carte. L'activation de ce paramètre affichera tous les trajets connus."
private.L["CONFIG_TITLE"] = "Superposition"
private.L["CONFIG_TITLE_STANDALONE"] = "_|cffCCCC88NPCScan|r.Overlay"
private.L["MODULE_ALPHAMAP3"] = "AddOn AlphaMap3"
private.L["MODULE_BATTLEFIELDMINIMAP"] = "Carte locale"
private.L["MODULE_MINIMAP"] = "Mini-carte"
-- private.L["MODULE_OMEGAMAP"] = "OmegaMap AddOn"
private.L["MODULE_RANGERING_DESC"] = "Note : le cercle de portée n'apparait que dans les zones où des rares sont recherchés."
private.L["MODULE_RANGERING_FORMAT"] = "Aff. un cercle de %dyd approximant la portée de détection"
private.L["MODULE_WORLDMAP"] = "Carte du monde principale"
private.L["MODULE_WORLDMAP_KEY_FORMAT"] = "• %s"
-- private.L["MODULE_WORLDMAP_KEYTOGGLE"] = "Key"
-- private.L["MODULE_WORLDMAP_KEYTOGGLE_DESC"] = "Toggle Path Key."
private.L["MODULE_WORLDMAP_TOGGLE"] = "PNJs"
private.L["MODULE_WORLDMAP_TOGGLE_DESC"] = "Affiche ou non les trajets de _|cffCCCC88NPCScan|r.Overlay des PNJs recherchés."


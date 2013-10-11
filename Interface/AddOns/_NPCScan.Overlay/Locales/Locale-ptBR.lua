--[[****************************************************************************
  * _NPCScan.Overlay by Saiket                                                 *
  * Locales/Locale-ptBR.lua - Localized string constants (pt-BR/pt-PT).        *
  ****************************************************************************]]


if ( GetLocale() ~= "ptBR" and GetLocale() ~= "ptPT" ) then
	return;
end


-- See http://wow.curseforge.com/addons/npcscan-overlay/localization/ptBR/
local Overlay = select( 2, ... );
Overlay.L = setmetatable( {
	NPCs = setmetatable( {
			[ 61 ] = "Turos Mão-leve";
		[ 62 ] = "Guga Velagorda";
		[ 79 ] = "Narg, o Capataz";
		[ 99 ] = "Morgana, a Dissimulada";
		[ 100 ] = "Rude Mordelogo";
		[ 462 ] = "Vultros";
		[ 471 ] = "Mãe Veneno";
		[ 472 ] = "Comefuncho";
		[ 506 ] = "Sargento Garrafina";
		[ 507 ] = "Fenros";
		[ 519 ] = "Raso";
		[ 520 ] = "Leso";
		[ 521 ] = "Lupos";
		[ 534 ] = "Nefaru";
		[ 572 ] = "Leprithus";
		[ 573 ] = "Ceifador de Inimigos 4000";
		[ 574 ] = "Naraxis";
		[ 584 ] = "Kazon";
		[ 596 ] = "Nobre Reprogramado";
		[ 599 ] = "Marisa du'Paige";
		[ 616 ] = "Palpos";
		[ 763 ] = "Chefe dos Perdidos";
		[ 947 ] = "Rohh, o Taciturno";
		[ 1063 ] = "Jade";
		[ 1106 ] = "Cozinheiro dos Perdidos";
		[ 1112 ] = "Viúva Negra Sanguessuga";
		[ 1119 ] = "Martela-Espinha";
		[ 1130 ] = "Bjarn";
		[ 1132 ] = "Lenho";
		[ 1137 ] = "Edan, o Uivador";
		[ 1140 ] = "Matriarca Rasgaqueixo";
		[ 1260 ] = "Grande Pai Articos";
		[ 1398 ] = "Chefe Galgosh";
		[ 1399 ] = "Magosh";
		[ 1424 ] = "Mestre Escavador";
		[ 1425 ] = "Kubb";
		[ 1531 ] = "Alma Perdida";
		[ 1533 ] = "Espírito Atormentado";
		[ 1552 ] = "Ventrescama";
		[ 1837 ] = "Juiz Escarlate";
		[ 1838 ] = "Interrogador Escarlate";
		[ 1839 ] = "Alto-clérigo Escarlate";
		[ 1841 ] = "Carrasco Escarlate";
		[ 1843 ] = "Encarregado Jerris";
		[ 1844 ] = "Encarregado Marcrid";
		[ 1847 ] = "Crinapodre";
		[ 1848 ] = "Lorde Maldazzar";
		[ 1849 ] = "Murmuratroz";
		[ 1850 ] = "Putrídius";
		[ 1851 ] = "Cascabulho";
		[ 1885 ] = "Ferreiro Escarlate";
		[ 1910 ] = "Muad";
		[ 1911 ] = "Díbi";
		[ 1936 ] = "Fazendeiro Solliden";
		[ 2090 ] = "Ma'ruk Serpescama";
		[ 2108 ] = "Garneg Carbocrânio";
		[ 2162 ] = "Agal";
		[ 2172 ] = "Mamãe Moa da Floresta";
		[ 2175 ] = "Garrassombra";
		[ 2184 ] = "Lady Miralua";
		[ 2186 ] = "Carnivo, o Quebrador";
		[ 2191 ] = "Licillino";
		[ 2192 ] = "Arauto das Chamas Radison";
		[ 2258 ] = "Maggarrak";
		[ 2452 ] = "Scol";
		[ 2453 ] = "Lo'Grosh";
		[ 2476 ] = "Gosh-Haldir";
		[ 2541 ] = "Lorde Sakrasis";
		[ 2598 ] = "Darbel Montrose";
		[ 2600 ] = "Canora";
		[ 2601 ] = "Buchorrendo";
		[ 2602 ] = "Ruul Uma-pedra";
		[ 2603 ] = "Kovork";
		[ 2604 ] = "Molok, o Esmagador";
		[ 2605 ] = "Zalas Cascasseca";
		[ 2606 ] = "Nimar, o Matador";
		[ 2609 ] = "Geomante Adaga-de-sílex";
		[ 2744 ] = "Comandante de Umbraforja";
		[ 2749 ] = "Barricada";
		[ 2751 ] = "Golem de Guerra";
		[ 2752 ] = "Estrondor";
		[ 2753 ] = "Barnabus";
		[ 2754 ] = "Anátemus";
		[ 2779 ] = "Príncipe Nazjak";
		[ 2850 ] = "Dente Quebrado";
		[ 2931 ] = "Zaricotl";
		[ 3058 ] = "Arra'chea";
		[ 3068 ] = "Mazzranache";
		[ 3253 ] = "Ceifador Silitídeo";
		[ 3270 ] = "Místico Ancião Cardafuça";
		[ 3295 ] = "Anomalia no Lodo";
		[ 3398 ] = "Gesharahan";
		[ 3470 ] = "Rathorian";
		[ 3535 ] = "Limonegro, o Fétido";
		[ 3581 ] = "Fera do Esgoto";
		[ 3652 ] = "Trígora, a Açoitadora";
		[ 3672 ] = "Jibohm";
		[ 3735 ] = "Boticário Fábio";
		[ 3736 ] = "Matador Mordenthal";
		[ 3773 ] = "Akkrilus";
		[ 3792 ] = "Senhor da Alcateia Terrorlupo";
		[ 3872 ] = "Capitão Devoto da Morte";
		[ 4066 ] = "Nal'taszar";
		[ 4132 ] = "Krkk'kx";
		[ 4339 ] = "Sulfúrio";
		[ 4380 ] = "Viúva Névoa Negra";
		[ 4425 ] = "Caçador Cego";
		[ 4842 ] = "Arauto da Terra Halmgar";
		[ 5343 ] = "Lady Szallah";
		[ 5345 ] = "Cabeça de Diamante";
		[ 5346 ] = "Rugessangue, o Espreitador";
		[ 5347 ] = "Antilus, que Voa Alto";
		[ 5348 ] = "Forquilíngua Velassonhos";
		[ 5349 ] = "Arash-ethis";
		[ 5350 ] = "Qirot";
		[ 5352 ] = "Velho Pançagris";
		[ 5354 ] = "Rosno Frondefráter";
		[ 5356 ] = "Rosnador";
		[ 5785 ] = "Irmã Raivergasta";
		[ 5786 ] = "Lança Infame";
		[ 5787 ] = "Impositor Emilgund";
		[ 5807 ] = "O Estraçalhador";
		[ 5809 ] = "Sargento Carlos";
		[ 5822 ] = "Tecevil Dezzprezo";
		[ 5823 ] = "Açoita-morte";
		[ 5824 ] = "Capitão Presa Chata";
		[ 5826 ] = "Geolorde Mosqueado";
		[ 5828 ] = "Humar, o Senhor dos Leões";
		[ 5829 ] = "Roncão, o Importuno";
		[ 5830 ] = "Irmã Rathalon";
		[ 5831 ] = "Crinaveloz";
		[ 5832 ] = "Atroadonte";
		[ 5834 ] = "Azzere, o Cortacéu";
		[ 5835 ] = "Feitor Grelha";
		[ 5836 ] = "Engenheiro Revestrés";
		[ 5837 ] = "Braço-de-pedra";
		[ 5838 ] = "Lança-partida";
		[ 5841 ] = "Lança-de-rocha";
		[ 5842 ] = "Takk, o Saltador";
		[ 5847 ] = "Heggin Barbapedra";
		[ 5848 ] = "Malgin Cervevada";
		[ 5849 ] = "Cavador Forjaflama";
		[ 5851 ] = "Capitão Gerogg Pé-de-malho";
		[ 5859 ] = "Hagg Quebra-tauren";
		[ 5863 ] = "Geo-sacerdote Gukk'rok";
		[ 5864 ] = "Porcino Couriço";
		[ 5865 ] = "Dishu";
		[ 5912 ] = "Dragoleta Anormal";
		[ 5915 ] = "Irmão Corvalho";
		[ 5928 ] = "Pesarasa";
		[ 5930 ] = "Irmã Rasga";
		[ 5932 ] = "Capataz Presaçoite";
		[ 5933 ] = "Achellios, o Banido";
		[ 5935 ] = "Olho-de-ferro, o Invencível";
		[ 5937 ] = "Torpicada";
		[ 6118 ] = "Fantasma de Varo'then";
		[ 6228 ] = "Embaixador Ferro Negro";
		[ 6581 ] = "Matriarca Ravassauro";
		[ 6582 ] = "Mamãe Zavas";
		[ 6583 ] = "Grufo";
		[ 6584 ] = "Rei Mosh";
		[ 6585 ] = "Uhk'loc";
		[ 6648 ] = "Antilos";
		[ 6649 ] = "Lady Sesspira";
		[ 6650 ] = "General Presaferror";
		[ 6651 ] = "Guarda-pórtico Rugifúria";
		[ 7015 ] = "Gorgulho, o Cruel";
		[ 7016 ] = "Lady Vespira";
		[ 7017 ] = "Lorde Iniquicida";
		[ 7104 ] = "Áridus";
		[ 7137 ] = "Immolatus";
		[ 7846 ] = "Teremus, o Devorador";
		[ 8199 ] = "Líder Guerreiro Krazzilak";
		[ 8200 ] = "Jin'Zallah, o Arauto da Areia";
		[ 8201 ] = "Omgorn, o Perdido";
		[ 8203 ] = "Kregg Khaldus";
		[ 8204 ] = "Soriid, o Devorador";
		[ 8205 ] = "Haarka, o Voraz";
		[ 8207 ] = "Brasalado";
		[ 8210 ] = "Garravalha";
		[ 8211 ] = "Velho Pula-penhasco";
		[ 8212 ] = "A Fedegosa";
		[ 8213 ] = "Cascaférrea";
		[ 8214 ] = "Jalinde Dracoestio";
		[ 8215 ] = "Grandônum";
		[ 8216 ] = "Retherokk, o Berserker";
		[ 8217 ] = "Mith'rethis, o Encantador";
		[ 8218 ] = "[Witherheart the Stalker]";
		[ 8219 ] = "Zul'arek Odiento";
		[ 8277 ] = "Rekk'tilac";
		[ 8278 ] = "Fervar";
		[ 8279 ] = "Golem de Guerra Defeituoso";
		[ 8280 ] = "Shleipnarr";
		[ 8281 ] = "Escaldo";
		[ 8282 ] = "Grão-lorde Hastragand";
		[ 8283 ] = "Senhor de Escravos Cordisnero";
		[ 8296 ] = "Mojo, o Pervertido";
		[ 8297 ] = "Magronos, o Inflexível";
		[ 8298 ] = "Akubar, o Vidente";
		[ 8299 ] = "Láquila";
		[ 8300 ] = "Rasgarga";
		[ 8301 ] = "Clack, o Aniquilador";
		[ 8302 ] = "Olho da Morte";
		[ 8303 ] = "Grunhido";
		[ 8304 ] = "Skárnio";
		[ 8503 ] = "Gibblewilt";
		[ 8660 ] = "Malifatius";
		[ 8923 ] = "Panzor, o Invencível";
		[ 8924 ] = "O Beemote";
		[ 8976 ] = "Hematos";
		[ 8978 ] = "Thauris Balgarr";
		[ 8979 ] = "Gruklash";
		[ 8981 ] = "Aniquilador Defeituoso";
		[ 9217 ] = "Mestre Mago Agulhapétrea";
		[ 9218 ] = "Senhor da Batalha Agulhapétrea";
		[ 9219 ] = "Carniceiro Agulhapétrea";
		[ 9596 ] = "Bannok Sinistracha";
		[ 9602 ] = "Hahk'Zor";
		[ 9604 ] = "Gorgon'och";
		[ 9718 ] = "Ghok Surrabem";
		[ 9736 ] = "Intendente Zigris";
		[ 10077 ] = "Goela da Morte";
		[ 10078 ] = "Chamuska";
		[ 10080 ] = "Sandarr Aniquiladunas";
		[ 10081 ] = "Assombração de Poeira";
		[ 10082 ] = "Zerillis";
		[ 10119 ] = "Volchan";
		[ 10196 ] = "General Colbatann";
		[ 10197 ] = "Mezzir, o Rugidor";
		[ 10198 ] = "Kashoch, o Aniquilador";
		[ 10199 ] = "Pardo Pataneve";
		[ 10200 ] = "Rak'shiri";
		[ 10202 ] = "Azuros";
		[ 10263 ] = "Guarda Vil Ardente";
		[ 10356 ] = "Bayne";
		[ 10357 ] = "Ressan, o Agulheiro";
		[ 10358 ] = "Vulto de Fellicent";
		[ 10359 ] = "Tok'aya";
		[ 10376 ] = "Presa de Cristal";
		[ 10393 ] = "Kranio";
		[ 10509 ] = "Jed Mirarruna";
		[ 10558 ] = "Cantalar Forresten";
		[ 10559 ] = "Lady Véspia";
		[ 10639 ] = "Rórguis Papão";
		[ 10640 ] = "Fagarra";
		[ 10641 ] = "Quebra-galhos";
		[ 10642 ] = "Eck'alom";
		[ 10644 ] = "Uivador da Névoa";
		[ 10647 ] = "Príncipe Arrazear";
		[ 10741 ] = "Sian-Rotam";
		[ 10809 ] = "Petrespáduas";
		[ 10817 ] = "Duggan Martelo Feroz";
		[ 10818 ] = "Cavaleiro da Morte Portalmas";
		[ 10819 ] = "Barão Ruinassangue";
		[ 10820 ] = "Duque Rasgafúria";
		[ 10821 ] = "Hed'mush, o Apodrecente";
		[ 10823 ] = "Zul'Brin Entortagalho";
		[ 10824 ] = "Caça-morte Falcolança";
		[ 10825 ] = "Gish, o Impassível";
		[ 10826 ] = "Lorde Foicenegra";
		[ 10827 ] = "Morta-voz Selendre";
		[ 10828 ] = "Lynnia Abbendis";
		[ 11383 ] = "Alta-sacerdotisa Hai'watna";
		[ 11447 ] = "Papagog";
		[ 11467 ] = "Tsu'zee";
		[ 11497 ] = "A Razia";
		[ 11498 ] = "Cikkatriz, o Alquebrado";
		[ 11688 ] = "Centauro Amaldiçoado";
		[ 12037 ] = "Ursol'lok";
		[ 12237 ] = "Meshloc, o Ceifador";
		[ 12431 ] = "Dilaceros";
		[ 12433 ] = "Krethis Umbrateia";
		[ 12902 ] = "Lorgus Jett";
		[ 13896 ] = "Barbescama";
		[ 14221 ] = "Galvão Filmaeu";
		[ 14222 ] = "Araga";
		[ 14223 ] = "Benji Rabugento";
		[ 14224 ] = "7:XT";
		[ 14225 ] = "Príncipe Kellen";
		[ 14226 ] = "Kaskk";
		[ 14227 ] = "Ssibilak";
		[ 14228 ] = "Risadinha";
		[ 14229 ] = "Maledicente Lâmina Fugídia";
		[ 14230 ] = "Olho Gordo";
		[ 14231 ] = "Drogoth, o Errante";
		[ 14232 ] = "Dardo";
		[ 14233 ] = "Rancascame";
		[ 14234 ] = "Hayoc";
		[ 14235 ] = "A Podrisqueira";
		[ 14236 ] = "Senhor Pesqueiro";
		[ 14237 ] = "Vermelesga";
		[ 14266 ] = "Shanda, a Tecelã";
		[ 14267 ] = "Emogg, o Esmagador";
		[ 14268 ] = "Lorde Condar";
		[ 14269 ] = "Perscrutador Aqualon";
		[ 14270 ] = "Lulício";
		[ 14271 ] = "Quebra-costelas";
		[ 14272 ] = "Rosnaflama";
		[ 14273 ] = "Pedregoso";
		[ 14275 ] = "Tâmara Lançatroz";
		[ 14276 ] = "Rasguelra";
		[ 14277 ] = "Lady Zefris";
		[ 14278 ] = "Do'Late";
		[ 14279 ] = "Rastejatriz";
		[ 14280 ] = "Zé Comilão";
		[ 14281 ] = "Jimmy, o Sangrador";
		[ 14339 ] = "Uivo Mortífero";
		[ 14340 ] = "Alshirr Ruinálito";
		[ 14342 ] = "Patafúria";
		[ 14343 ] = "Olm, o Sábio";
		[ 14344 ] = "Mestiça";
		[ 14345 ] = "O Ongar";
		[ 14424 ] = "Lamedo";
		[ 14425 ] = "Roedosso";
		[ 14426 ] = "Harb Montanha Suja";
		[ 14427 ] = "Quiproquó";
		[ 14428 ] = "Uruson";
		[ 14429 ] = "Bocarranca";
		[ 14430 ] = "Espreitador do Crepúsculo";
		[ 14431 ] = "Fúria Shelda";
		[ 14432 ] = "Threggil";
		[ 14433 ] = "Lodogã";
		[ 14445 ] = "Capitão Serpeac";
		[ 14446 ] = "Pinato";
		[ 14447 ] = "Guelrrânio";
		[ 14448 ] = "Brotacardos";
		[ 14471 ] = "Setis";
		[ 14472 ] = "Gretheer";
		[ 14473 ] = "Lapress";
		[ 14474 ] = "Zora";
		[ 14475 ] = "Rex Ashil";
		[ 14476 ] = "Krellack";
		[ 14477 ] = "Larvator";
		[ 14478 ] = "Furacônio";
		[ 14479 ] = "Senhor do Crepúsculo Everun";
		[ 14487 ] = "Gluggl";
		[ 14488 ] = "Roloch";
		[ 14490 ] = "Razga";
		[ 14491 ] = "Kurmokk";
		[ 14492 ] = "Piadonix";
		[ 16179 ] = "Hyakiss, a Tocaieira";
		[ 16180 ] = "Shadikith, o Planador";
		[ 16181 ] = "Rokad, o Assolador";
		[ 16184 ] = "Feitor Nerubiano";
		[ 16854 ] = "Eldinarcos";
		[ 16855 ] = "Tregla";
		[ 17144 ] = "Trincador";
		[ 18241 ] = "Siri Cascudo";
		[ 18677 ] = "Mekthorg, o Selvagem";
		[ 18678 ] = "Engole-tudo";
		[ 18679 ] = "Vorakem Voz-da-Ruína";
		[ 18680 ] = "Marticar";
		[ 18681 ] = "Emissária Presacurva";
		[ 18682 ] = "Tocaieiro do Brejo";
		[ 18683 ] = "Caçador Caótico Yar";
		[ 18684 ] = "Bro'Gaz, o sem Clã";
		[ 18685 ] = "Okrek";
		[ 18686 ] = "Agoureiro Jurim";
		[ 18689 ] = "Aleijador";
		[ 18690 ] = "Smagga";
		[ 18692 ] = "Hemathion";
		[ 18693 ] = "Orador Mar'grom";
		[ 18694 ] = "Collidus, o Observador Dimensional";
		[ 18695 ] = "Embaixador Jerrikar";
		[ 18696 ] = "Kraator";
		[ 18697 ] = "Engenheiro-chefe Lorthander";
		[ 18698 ] = "Perenúcleo, o Castigador";
		[ 20932 ] = "Nuramoc";
		[ 21724 ] = "Falcazar";
		[ 22060 ] = "Fenissa, a Assassina";
		[ 22062 ] = "Dr. Mirracorpo";
		[ 32357 ] = "Velho Tronco Cristalino";
		[ 32358 ] = "Bolharrir Marchavento";
		[ 32361 ] = "Chifrígido";
		[ 32377 ] = "Ruginante, o Sanguinário";
		[ 32386 ] = "Vigdis, a Donzela Guerreira";
		[ 32398 ] = "Rei Pingoo";
		[ 32400 ] = "Tokemute";
		[ 32409 ] = "Sobrevivente Indu'le Enlouquecido";
		[ 32417 ] = "Grã-senhora Escarlate Daion";
		[ 32422 ] = "Grocklar";
		[ 32429 ] = "Ódio Calcinante";
		[ 32435 ] = "Vern";
		[ 32438 ] = "Syreian, a Entalha-ossos";
		[ 32447 ] = "Sentinela de Zul'Drak";
		[ 32471 ] = "Griegen";
		[ 32475 ] = "Tece-Terror";
		[ 32481 ] = "Aotona";
		[ 32485 ] = "Rei Mó";
		[ 32487 ] = "Putridus, o Ancestral";
		[ 32491 ] = "Protodraco do Tempo Perdido";
		[ 32495 ] = "Hildana Furta-morte";
		[ 32500 ] = "Dirkee";
		[ 32501 ] = "Grão-Thane Iorfus";
		[ 32517 ] = "Loque'nahak";
		[ 32630 ] = "Viragosa";
		[ 33776 ] = "Gondria";
		[ 35189 ] = "Skoll";
		[ 38453 ] = "Arcturis";
		[ 39183 ] = "Escórpitar";
		[ 39185 ] = "Babaqueixo";
		[ 39186 ] = "Fitaverno";
		[ 43488 ] = "Mordai, o Rasgaterra";
		[ 43613 ] = "Agoureiro Trilha Astuta";
		[ 43720 ] = "\"Cutuco\" Mantospinho";
		[ 44224 ] = "Dois-dedão";
		[ 44225 ] = "Rúbio Tironegro";
		[ 44226 ] = "Sarilodonte";
		[ 44227 ] = "Gazz, o Caçador do Lago";
		[ 44714 ] = "Fronkel, o Perturbado";
		[ 44722 ] = "Reflexão Distorcida de Narain";
		[ 44750 ] = "Califa Escorpicada";
		[ 44759 ] = "André Barbarruiva";
		[ 44761 ] = "Aquementas, o Desacorrentado";
		[ 44767 ] = "Occulus, o Corrompido";
		[ 45257 ] = "Mordak Dobranoite";
		[ 45258 ] = "Cássia Flavya, a Rainha Serpenteante";
		[ 45260 ] = "Folhanegra";
		[ 45262 ] = "Narixxus, o Arauto da Ruína";
		[ 45369 ] = "Morick Malzibirra";
		[ 45380 ] = "Caudagris";
		[ 45384 ] = "Patassábio";
		[ 45398 ] = "Grizlak";
		[ 45399 ] = "Optimo";
		[ 45401 ] = "Pinalva";
		[ 45402 ] = "Nix";
		[ 45404 ] = "Geoscultora Maren";
		[ 45739 ] = "O Soldado Desconhecido";
		[ 45740 ] = "Vigia Veloso";
		[ 45771 ] = "Marus";
		[ 45785 ] = "Abroba";
		[ 45801 ] = "Elisa";
		[ 45811 ] = "Marina DeSirrus";
		[ 46981 ] = "Vergasta";
		[ 46992 ] = "Bernardo, o Lunático";
		[ 47003 ] = "Bolgaff";
		[ 47008 ] = "Fernão Thatros";
		[ 47009 ] = "Aquarius, o Desatado";
		[ 47010 ] = "Índigos";
		[ 47012 ] = "Effritus";
		[ 47015 ] = "Filho Perdido de Arugal";
		[ 47023 ] = "Thule Corvinalle";
		[ 47386 ] = "Aniamiss, a Rainha da Colônia";
		[ 47387 ] = "Harakiss, o Infestador";
		[ 49822 ] = "Presajade";
		[ 49913 ] = "Lady La-La";
		[ 50005 ] = "[Poseidus]";
		[ 50050 ] = "Shok'sharak";
		[ 50051 ] = "Rastejante Espectral";
		[ 50052 ] = "Burgy Cordisnero";
		[ 50053 ] = "Thartuk, o Exilado";
		[ 50057 ] = "Chaminasa";
		[ 50058 ] = "Terrortuga";
		[ 50059 ] = "Golgarok";
		[ 50060 ] = "Terborus";
		[ 50062 ] = "Aeonaxx";
		[ 50064 ] = "Cyrus, o Negro";
		[ 50065 ] = "Tatudumal";
		[ 50085 ] = "Lorde Supremo Furicorte";
		[ 50086 ] = "Tarvus, o Torpe";
		[ 50138 ] = "Karoma";
		[ 50154 ] = "Madexx";
		[ 50159 ] = "Simbas";
		[ 50328 ] = "Fangora";
		[ 50329 ] = "Rrakk";
		[ 50330 ] = "Kree";
		[ 50331 ] = "Go-Kan";
		[ 50332 ] = "Korda Torros";
		[ 50333 ] = "Lon, o Touro";
		[ 50334 ] = "Dak, o Quebrador";
		[ 50335 ] = "Uíscas";
		[ 50336 ] = "Yorik Vistaboa";
		[ 50337 ] = "Gárgala";
		[ 50338 ] = "Kor'nas Noite Preta";
		[ 50339 ] = "Sulik'shor";
		[ 50340 ] = "Gaarn, o Tóxico";
		[ 50341 ] = "Borginn Punho Negro";
		[ 50342 ] = "Heronis";
		[ 50343 ] = "Quall";
		[ 50344 ] = "Norlaxx";
		[ 50345 ] = "Alit";
		[ 50346 ] = "Ronak";
		[ 50347 ] = "Karr, o Obscurecente";
		[ 50348 ] = "Norissis";
		[ 50349 ] = "Kang, o Ladrão de Almas";
		[ 50350 ] = "Morgrinn Rachapresa";
		[ 50351 ] = "Jonn-Dar";
		[ 50352 ] = "Qa'nas";
		[ 50353 ] = "Manas";
		[ 50354 ] = "Havak";
		[ 50355 ] = "Kah'tir";
		[ 50356 ] = "Krol, a Lâmina";
		[ 50357 ] = "Asassol";
		[ 50358 ] = "Constructo Fendessol Enlouquecido";
		[ 50359 ] = "Urgolax";
		[ 50361 ] = "Ornat";
		[ 50362 ] = "Charcabreu";
		[ 50363 ] = "Krax'ik";
		[ 50364 ] = "Nal'lak, o Estripador";
		[ 50370 ] = "Carapax";
		[ 50388 ] = "Torik-Ethis";
		[ 50724 ] = "Naracna";
		[ 50725 ] = "Azelisk";
		[ 50726 ] = "Kalixx";
		[ 50727 ] = "Strix, o Farpado";
		[ 50728 ] = "Golpe da Morte";
		[ 50730 ] = "Envenenas";
		[ 50731 ] = "Perfúria";
		[ 50733 ] = "Ski'thik";
		[ 50734 ] = "Lith'ik, o Espreitador";
		[ 50735 ] = "Guizante";
		[ 50737 ] = "Acroniss";
		[ 50738 ] = "Brilhescama";
		[ 50739 ] = "Gar'lok";
		[ 50741 ] = "Kaxx";
		[ 50742 ] = "Chem";
		[ 50743 ] = "Manax";
		[ 50744 ] = "Qu'rik";
		[ 50745 ] = "Losaj";
		[ 50746 ] = "Bornix, o Escavador";
		[ 50747 ] = "Tix";
		[ 50748 ] = "Nyaj";
		[ 50749 ] = "Kal'tik, a Praga";
		[ 50750 ] = "Aethis";
		[ 50752 ] = "Tarantis";
		[ 50759 ] = "Iriss, a Viúva";
		[ 50763 ] = "Assombrante";
		[ 50764 ] = "Paraliss";
		[ 50765 ] = "Miasmiss";
		[ 50766 ] = "Sele'na";
		[ 50768 ] = "Andáguas Cournith";
		[ 50769 ] = "Zai, o Pária";
		[ 50770 ] = "Zorn";
		[ 50772 ] = "Eshelon";
		[ 50775 ] = "Likk, o Caçador";
		[ 50776 ] = "Nalash Verdantis";
		[ 50777 ] = "Agulha";
		[ 50778 ] = "Ferroteia";
		[ 50779 ] = "Bátima";
		[ 50780 ] = "Sahn Caçador de Maré";
		[ 50782 ] = "Sarnak";
		[ 50783 ] = "Salyin Batedor da Guerra";
		[ 50784 ] = "Anith";
		[ 50785 ] = "Caelumbra";
		[ 50786 ] = "Fagulhasa";
		[ 50787 ] = "Arness, a Balança";
		[ 50788 ] = "Quetzl";
		[ 50789 ] = "Nessos, o Oráculo";
		[ 50790 ] = "Ionis";
		[ 50791 ] = "Siltriss, o Afiador";
		[ 50792 ] = "Chiaa";
		[ 50797 ] = "Yukiko";
		[ 50803 ] = "Mascaosso";
		[ 50804 ] = "Rasgasa";
		[ 50805 ] = "Omnis Grinlok";
		[ 50806 ] = "Moldo Caolho";
		[ 50807 ] = "Catal";
		[ 50808 ] = "Urobi, o Andarilho";
		[ 50809 ] = "Menga";
		[ 50810 ] = "Favorito de Isiset";
		[ 50811 ] = "Nasra Pintalgas";
		[ 50812 ] = "Arae";
		[ 50813 ] = "Fene-mal";
		[ 50814 ] = "Comecorpos";
		[ 50815 ] = "Skarr";
		[ 50816 ] = "Ruun Patalmas";
		[ 50817 ] = "Ahone, o Errante";
		[ 50818 ] = "O Predador Sombrio";
		[ 50819 ] = "Garrálgido";
		[ 50820 ] = "Yul Garragreste";
		[ 50821 ] = "Ai-Li Espelho do Céu";
		[ 50822 ] = "Ai-Ran, a Nuvem que Passa";
		[ 50823 ] = "Mestre Feroz";
		[ 50825 ] = "Feras";
		[ 50828 ] = "Bonobos";
		[ 50830 ] = "Gálion";
		[ 50831 ] = "Kossa";
		[ 50832 ] = "O Berrante";
		[ 50833 ] = "Courescuro";
		[ 50836 ] = "Ik-Ik, o Ligeiro";
		[ 50837 ] = "Kash";
		[ 50838 ] = "Tabbs";
		[ 50839 ] = "Cão Cromado";
		[ 50840 ] = "Major Nananina";
		[ 50842 ] = "Magmadan";
		[ 50846 ] = "Babagorja";
		[ 50855 ] = "Jaxx Raivoso";
		[ 50856 ] = "Snark";
		[ 50858 ] = "Asapó";
		[ 50864 ] = "Estígia";
		[ 50865 ] = "Saurix";
		[ 50874 ] = "Tenok";
		[ 50875 ] = "Nychus";
		[ 50876 ] = "Avis";
		[ 50882 ] = "Chupacabras";
		[ 50884 ] = "Levanta-poeira, o Covarde";
		[ 50886 ] = "Asamar";
		[ 50891 ] = "Boros";
		[ 50892 ] = "Cyn";
		[ 50895 ] = "Volux";
		[ 50897 ] = "Fexik, o Espreitador das Dunas";
		[ 50901 ] = "Teromak";
		[ 50903 ] = "Orlix, o Senhor do Pântano";
		[ 50905 ] = "Matante";
		[ 50906 ] = "Mutilax";
		[ 50908 ] = "Uivo Noturno";
		[ 50915 ] = "Bufa";
		[ 50916 ] = "Aleijão, o Lamuriento";
		[ 50922 ] = "Warg";
		[ 50925 ] = "Patada";
		[ 50926 ] = "Ben Grisalho";
		[ 50929 ] = "Pequeno Bjorn";
		[ 50930 ] = "Hibernus, o Adormecido";
		[ 50931 ] = "Sarna";
		[ 50937 ] = "Porcouro";
		[ 50940 ] = "Swee";
		[ 50942 ] = "Roto Rúter";
		[ 50945 ] = "Kaska";
		[ 50946 ] = "Porcozilla";
		[ 50947 ] = "Uira Puru";
		[ 50948 ] = "Lomboduro";
		[ 50949 ] = "Gambito do Finn";
		[ 50952 ] = "João Conchão";
		[ 50955 ] = "Carcinak";
		[ 50957 ] = "Garrão";
		[ 50959 ] = "Karkin";
		[ 50964 ] = "Kortz";
		[ 50967 ] = "Nopapo, o Assolador";
		[ 50986 ] = "Cernelha Dourada";
		[ 50993 ] = "Gal'dorak";
		[ 50995 ] = "Bordoeiro";
		[ 50997 ] = "Bornak, o Lacerante";
		[ 51000 ] = "Cascabreu, o Impenetrável";
		[ 51001 ] = "Garra de Peçonha";
		[ 51002 ] = "Escorpoxx";
		[ 51004 ] = "Toxx";
		[ 51007 ] = "Serkett";
		[ 51008 ] = "O Terror Farpado";
		[ 51010 ] = "Picada";
		[ 51014 ] = "Duracasca";
		[ 51017 ] = "Ferrante";
		[ 51018 ] = "Zormus";
		[ 51021 ] = "Vórticos";
		[ 51022 ] = "Córdix";
		[ 51025 ] = "Dilennaa";
		[ 51026 ] = "Gnath";
		[ 51027 ] = "Agúlica";
		[ 51028 ] = "O Escavador do Abismo";
		[ 51029 ] = "Parasitus";
		[ 51031 ] = "Farejador";
		[ 51037 ] = "Cão de Guerra Guilneano Perdido";
		[ 51040 ] = "Buffo";
		[ 51042 ] = "Cordúmbria";
		[ 51044 ] = "Peste";
		[ 51045 ] = "Arcanus";
		[ 51046 ] = "Fidonis";
		[ 51048 ] = "Rexxus";
		[ 51052 ] = "Gib, o Guardador de Bananas";
		[ 51053 ] = "Quirix";
		[ 51057 ] = "Bezorra";
		[ 51058 ] = "Aphis";
		[ 51059 ] = "Yaungol Nível 2";
		[ 51061 ] = "Roth-Salam";
		[ 51062 ] = "Khep-Re";
		[ 51063 ] = "Phalanax";
		[ 51066 ] = "Prezacristal";
		[ 51067 ] = "Brílio";
		[ 51069 ] = "Cintillex";
		[ 51071 ] = "Capitão Florêncio";
		[ 51076 ] = "Lupicínio";
		[ 51077 ] = "Felpas";
		[ 51078 ] = "Ferdinando";
		[ 51079 ] = "Capitão Ventoruim";
		[ 51401 ] = "Madexx";
		[ 51402 ] = "Madexx";
		[ 51403 ] = "Madexx";
		[ 51404 ] = "Madexx";
		[ 51658 ] = "Mogh, o Morto";
		[ 51661 ] = "Tsul'kalu";
		[ 51662 ] = "Mahamba";
		[ 51663 ] = "Pogeyan";
		[ 52146 ] = "Tremida";
		[ 54318 ] = "Ankha";
		[ 54319 ] = "Magria";
		[ 54320 ] = "Ban'thalos";
		[ 54321 ] = "Solix";
		[ 54322 ] = "Deth'tilac";
		[ 54323 ] = "Kirix";
		[ 54324 ] = "Rastejante das Chamas";
		[ 54338 ] = "Anthriss";
		[ 54533 ] = "Príncipe Lakma";
		[ 56081 ] = "Benji Otimista";
		[ 58474 ] = "Matriarca Aguilhão Sangrento";
		[ 58768 ] = "Estaladonte";
		[ 58769 ] = "Boca-de-alicate";
		[ 58771 ] = "Quid";
		[ 58778 ] = "Aetha";
		[ 58817 ] = "Espírito de Lao-Fe";
		[ 58949 ] = "Bai-Jin, o Carniceiro";
		[ 59369 ] = "Doutor Theolen Krastinov";
		[ 62880 ] = "Gochao, o Punho de Ferro";
		[ 62881 ] = "Gaohun, o Corta-almas";
		[ 63101 ] = "General Temuja";
		[ 63240 ] = "Mestre Sombrio Sydow";
		[ 63510 ] = "Wulon";
		[ 63691 ] = "Huo-Shuang";
		[ 63695 ] = "Baolai, o Imolador";
		[ 63977 ] = "Vyraxxis";
		[ 63978 ] = "Kri'chon";
		[ 68317 ] = "Mavis Prejuz";
		[ 68318 ] = "Dalan Rompenoite";
		[ 68319 ] = "Disha Fazmedrar";
		[ 68320 ] = "Ubunti, o Vulto";
		[ 68321 ] = "Kar Belikoz";
		[ 68322 ] = "Muerta";
		[ 69664 ] = "Mumta";
		[ 69768 ] = "Batedor da Guerra Zandalari";
		[ 69769 ] = "Armipotente Zandalari";
		[ 69841 ] = "Armipotente Zandalari";
		[ 69842 ] = "Armipotente Zandalari";
		[ 69843 ] = "Zao'cho";
		[ 69996 ] = "Ku'lai, a Garra dos Céus";
		[ 69997 ] = "Primogenitus";
		[ 69998 ] = "Goda";
		[ 69999 ] = "Deus-bruto Ramuk";
		[ 70000 ] = "Al'tabim, que Tudo Vê";
		[ 70001 ] = "Quebradorso Uru";
		[ 70002 ] = "Lu-Ban";
		[ 70003 ] = "Molthor";
		[ 70096 ] = "Deus da Guerra Dokah";
		[ 70126 ] = "Willy Wilder";
		[ 70238 ] = "Olho Sempre Aberto";
		[ 70243 ] = "Arquirritualista Kelada";
		[ 70249 ] = "Olho Focado";
		[ 70276 ] = "No'kah Manda-procela";
		[ 70323 ] = "Krakkanon";
		[ 70430 ] = "Horror de Pedra";
		[ 70440 ] = "Monara";
		[ 70530 ] = "Ra'sha";
		[ 71864 ] = "Spelurk";
		[ 71919 ] = "Zhu-Gon, o Azedo";
		[ 72045 ] = "Chelon";
		[ 72048 ] = "Chiadeira";
		[ 72049 ] = "Mastigarça";
		[ 72193 ] = "Karkanos";
		[ 72245 ] = "Zesqua";
		[ 72769 ] = "Espírito de Flamejade";
		[ 72775 ] = "Bufo";
		[ 72808 ] = "Tsavo'ka";
		[ 72909 ] = "Gu'chi, o Arauto do Enxame";
		[ 72970 ] = "Golganarr";
		[ 73157 ] = "Musgo Rochoso";
		[ 73158 ] = "Ganso Esmeralda";
		[ 73160 ] = "Chifreaço Veloférreo";
		[ 73161 ] = "Grande Tartaruga Cascofúria";
		[ 73163 ] = "Píton Imperial";
		[ 73166 ] = "Garrespinha Monstruoso";
		[ 73167 ] = "Huolon";
		[ 73169 ] = "Jakur de Ordon";
		[ 73170 ] = "Vigia Osu";
		[ 73171 ] = "Campeão da Chama Negra";
		[ 73172 ] = "Gairan, o Senhor da Centelha";
		[ 73173 ] = "Urdur, o Cauterizador";
		[ 73174 ] = "Bispo das Chamas";
		[ 73175 ] = "Chuva de Cinzas";
		[ 73277 ] = "Remenda-folhas";
		[ 73279 ] = "Bocarra";
		[ 73281 ] = "Navio Fantasma Vazúvio";
		[ 73282 ] = "Garnia";
		[ 73293 ] = "Whizzig";
		[ 73666 ] = "Bispo das Chamas";
		[ 73704 ] = "Trança-fétida";

		[ 62346 ] = "Gailleon", -- Needs review
		[ 64403 ] = "Alani", -- Needs review
	}, { __index = Overlay.L.NPCs; } );

	CONFIG_ALPHA = "Alfa",
	CONFIG_DESC = "Controla qual mapas mostrarão sobreposição do caminho de unidades. A maioria dos addons que modifica mapas são controlados com a opção de Mapa Mundi.",
	CONFIG_SHOWALL = "Sempre mostrar todos os caminhos",
	CONFIG_SHOWALL_DESC = "Normalmente, quando uma unidade não está sendo buscada, seu caminho é tirado do mapa. Habilite esta opção para sempre mostrar todas as rotas conhecidas.",
	CONFIG_TITLE = "Sobreposição",
	CONFIG_TITLE_STANDALONE = "_|cffCCCC88NPCScan|r.Overlay (Sobreposição)",
	MODULE_ALPHAMAP3 = "AddOn AlphaMap3",
	MODULE_BATTLEFIELDMINIMAP = "Mapa de Batalha",
	MODULE_MINIMAP = "Mini Mapa",
	MODULE_RANGERING_DESC = "Nota: O anel de distância só aparece em zonas com buscas por unidades raras.",
	MODULE_RANGERING_FORMAT = "Mostrar anel de %d jardas para distância de detecção aproximada.",
	MODULE_WORLDMAP = "Mapa Mundi",
	MODULE_WORLDMAP_KEY_FORMAT = "• %s",
	MODULE_WORLDMAP_TOGGLE = "PNJs",
	MODULE_WORLDMAP_TOGGLE_DESC = "Habilita/Desabilita a sobreposição de caminhos do _|cffCCCC88NPCScan|r.Overlay para os PNJs procurados.",
}, { __index = Overlay.L; } );
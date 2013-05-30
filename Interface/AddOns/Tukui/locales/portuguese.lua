-- localization for enUS and enGB
local T, C, L, G = unpack(select(2, ...))

if T.client == "ptBR" then
	L.UI_Outdated = "A sua vers�o da Tukui est� desactualizada. Pode baixar a vers�o mais recente no site www.tukui.org"
	L.UI_Talent_Change_Bug = "A blizzard bug has occured which is preventing you from changing your talents, this happen when you've inspected someone. Unfortunatly there is nothing we can do in this WoW Patch to fix it, please reload your ui and try again."
	
	L.chat_INSTANCE_CHAT = "I"
	L.chat_INSTANCE_CHAT_LEADER = "IL"
	L.chat_BN_WHISPER_GET = "De"
	L.chat_GUILD_GET = "G"
	L.chat_OFFICER_GET = "O"
	L.chat_PARTY_GET = "P"
	L.chat_PARTY_GUIDE_GET = "P"
	L.chat_PARTY_LEADER_GET = "P"
	L.chat_RAID_GET = "R"
	L.chat_RAID_LEADER_GET = "R"
	L.chat_RAID_WARNING_GET = "W"
	L.chat_WHISPER_GET = "De"
	L.chat_FLAG_AFK = "[LDT]"
	L.chat_FLAG_DND = "[NP]"
	L.chat_FLAG_GM = "[GM]"
	L.chat_ERR_FRIEND_ONLINE_SS = "Est� agora |cff298F00online|r"
	L.chat_ERR_FRIEND_OFFLINE_S = "Est� agora |cffff0000offline|r"

	L.chat_general = "Geral"
	L.chat_trade = "Com�rcio"
	L.chat_defense = "DefesaLocal"
	L.chat_recrutment = "RecrutamentoDeGuilda"
	L.chat_lfg = "ProcurandoGrupo"

	L.disband = "Dissolvendo o grupo ?"

	L.datatext_notalents ="Sem Talentos"
	L.datatext_download = "Download: "
	L.datatext_bandwidth = "Largura de Banda: "
	L.datatext_guild = "Guilda"
	L.datatext_noguild = "Sem Guilda"
	L.datatext_bags = "Sacos: "
	L.datatext_friends = "Amigos"
	L.datatext_online = "Online: "
	L.datatext_armor = "Armadura"
	L.datatext_earned = "Ganho:"
	L.datatext_spent = "Gasto:"
	L.datatext_deficit = "D�fice:"
	L.datatext_profit = "Lucro:"
	L.datatext_timeto = "Tempo para"
	L.datatext_friendlist = "Lista de Amigos:"
	L.datatext_playersp = "pm"
	L.datatext_playerap = "pa"
	L.datatext_playerhaste = "Acelera��o"
	L.datatext_dps = "dps"
	L.datatext_hps = "cps"
	L.datatext_playerarp = "arp"
	L.datatext_session = "Sess�o: "
	L.datatext_character = "Personagem: "
	L.datatext_server = "Servidor: "
	L.datatext_totalgold = "Total: "
	L.datatext_savedraid = "Raide(s) Salva(s)"
	L.datatext_currency = "Moeda de troca:"
	L.datatext_fps = " fps & "
	L.datatext_ms = " ms"
	L.datatext_playercrit = " cr�tico"
	L.datatext_playerheal = " Cura"
	L.datatext_avoidancebreakdown = "Evas�o Total"
	L.datatext_lvl = "lvl"
	L.datatext_boss = "Chefe"
	L.datatext_miss = "Falha"
	L.datatext_dodge = "Esquiva"
	L.datatext_block = "Bloqueio"
	L.datatext_parry = "Aparo"
	L.datatext_playeravd = "avd: "
	L.datatext_servertime = "Hora do Servidor: "
	L.datatext_localtime = "Hora Local: "
	L.datatext_mitigation = "Mitiga��o por N�vel: "
	L.datatext_healing = "Cura: "
	L.datatext_damage = "Dano: "
	L.datatext_honor = "Honra: "
	L.datatext_killingblows = "Golpes Fatais: "
	L.datatext_ttstatsfor = "Status para "
	L.datatext_ttkillingblows = "Golpes Fatais:"
	L.datatext_tthonorkills = "Mortes Honrosas:"
	L.datatext_ttdeaths = "Mortes:"
	L.datatext_tthonorgain = "Honra Ganha:"
	L.datatext_ttdmgdone = "Dano Causado:"
	L.datatext_tthealdone = "Cura Causada:"
	L.datatext_basesassaulted = "Bases Assaltadas:"
	L.datatext_basesdefended = "Bases Defendidas:"
	L.datatext_towersassaulted = "Torres Assaltadas:"
	L.datatext_towersdefended = "Torres Defendidas:"
	L.datatext_flagscaptured = "Bandeiras Capturadas:"
	L.datatext_flagsreturned = "Bandeiras Recuperadas:"
	L.datatext_graveyardsassaulted = "Cemit�rios Assaltados:"
	L.datatext_graveyardsdefended = "Cemit�rios Defendidos:"
	L.datatext_demolishersdestroyed = "Demolidores Destru�dos:"
	L.datatext_gatesdestroyed = "Port�es Destru�dos:"
	L.datatext_totalmemusage = "Mem�ria Total Usada:"
	L.datatext_control = "Controlado por:"
	L.datatext_cta_allunavailable = "N�o foi possivel obter informa��es acerca do Chamado �s armas."
	L.datatext_cta_nodungeons = "Nenhuma masmorra est� oferecendo um Chamado �s armas."
	L.datatext_carts_controlled = "Carrinhos Controlados:"
	L.datatext_victory_points = "Pontos de Vit�ria:"
	L.datatext_orb_possessions = "Posse de Orbes:"

	L.Slots = {
		[1] = {1, "Cabe�a", 1000},
		[2] = {3, "Ombros", 1000},
		[3] = {5, "Torso", 1000},
		[4] = {6, "Cintura", 1000},
		[5] = {9, "Pulsos", 1000},
		[6] = {10, "M�os", 1000},
		[7] = {7, "Pernas", 1000},
		[8] = {8, "P�s", 1000},
		[9] = {16, "M�o Principal", 1000},
		[10] = {17, "M�o Secund�ria", 1000},
		[11] = {18, "Longo Alcance", 1000}
	}

	L.popup_disableui = "A Tukui nao funciona nesta resolu��o, deseja desactivar a Tukui? (Cancele se quizer tentar outra resolu��o)."
	L.popup_install = "Primeira vez a correr a tukui V13 neste personagem. Deve recarregar a sua UI para defenir as Barras de Ac��o, Vari�veis e os Quadros de conversa��o."
	L.popup_reset = "Aviso! Isto vai redefinir tudo para a Tukui padr�o. Deseja proceder?" 
	L.popup_2raidactive = "2 layouts de raide est�o activos, por favor selecione um."
	L.popup_install_yes = "Yeah! (recomendado!)"
	L.popup_install_no = "N�o, n�o vale nada"
	L.popup_reset_yes = "Yeah b�b�!"
	L.popup_reset_no = "N�o, sen�o vou chorar para os forums!"
	L.popup_fix_ab = "Algo est� errado com a sua barra de ac��o. Deseja recarregar a UI para corrigir o problema?"

	L.merchant_repairnomoney = "N�o tem dinheiro suficiente para reparar!"
	L.merchant_repaircost = "Os seus itens foram reparados por"
	L.merchant_trashsell = "O seu lixo foi vendido e voce ganhou"

	L.goldabbrev = "|cffffd700g|r"
	L.silverabbrev = "|cffc7c7cfs|r"
	L.copperabbrev = "|cffeda55fc|r"

	L.error_noerror = "Nenhum erro ainda detectado."

	L.unitframes_ouf_offline = "Offline"
	L.unitframes_ouf_dead = "Morto"
	L.unitframes_ouf_ghost = "Fantasma"
	L.unitframes_ouf_lowmana = "Mana baixa"
	L.unitframes_ouf_threattext = "Amea�a no alvo actual:"
	L.unitframes_ouf_offlinedps = "Offline"
	L.unitframes_ouf_deaddps = "|cffff0000[MORTO]|r"
	L.unitframes_ouf_ghostheal = "FANTASMA"
	L.unitframes_ouf_deadheal = "MORTO"
	L.unitframes_ouf_gohawk = "VAI FALC�O"
	L.unitframes_ouf_goviper = "VAI V�BORA"
	L.unitframes_disconnected = "D/C"
	L.unitframes_ouf_wrathspell = "Ira"
	L.unitframes_ouf_starfirespell = "Estrela de Fogo"

	L.tooltip_count = "Contar"

	L.bags_noslots = "Impossivel comprar mais espa�os!"
	L.bags_costs = "Custa: %.2f gold"
	L.bags_buyslots = "Comprar novo espa�o com / compra de Sacos sim"
	L.bags_openbank = "Precisa de abrir o seu banco primeiro."
	L.bags_sort = "Organiza os seus sacos ou o seu banco, se aberto."
	L.bags_stack = "Enche as pilhas incompletas nos seus sacos ou banco, se aberto."
	L.bags_buybankslot = "Comprar espa�o no banco. (Precisa ter o banco aberto)"
	L.bags_search = "Procurar"
	L.bags_sortmenu = "Organizar"
	L.bags_sortspecial = "Organizar Especial"
	L.bags_stackmenu = "Empilhar"
	L.bags_stackspecial = "Empilhar Especial"
	L.bags_showbags = "Mostrar Sacos"
	L.bags_sortingbags = "Organiza��o acabada."
	L.bags_nothingsort= "Nada para Organizar."
	L.bags_bids = "Usando os Sacos: "
	L.bags_stackend = "Reempilhamento acabado."
	L.bags_rightclick_search = "Clique direito do rato para procurar."

	L.loot_fish = "Saque de Peixe"
	L.loot_empty = "Espa�o vazio"
	L.loot_randomplayer = "Random Player"
	L.loot_self = "Self Loot"

	L.chat_invalidtarget = "Alvo inv�lido"

	L.mount_wintergrasp = "Wintergrasp"

	L.core_autoinv_enable = "Convite autom�tico Ligado: Convidar"
	L.core_autoinv_enable_c = "Convite autom�tico Ligado: "
	L.core_autoinv_disable = "Convite autom�tico Desligado"
	L.core_wf_unlock = "Desbloquear o Quadro de Objectivos"
	L.core_wf_lock = "Bloquear o Quadro de Objectivos"
	L.core_welcome1 = "Bem vindo � vers�o |cffC495DDTukui|r,"
	L.core_welcome2 = "Escreva |cff00FFFF/uihelp|r para mais informa��o ou visite o site www.tukui.org"

	L.core_uihelp1 = "|cff00ff00Comandos Gerais Slash|r"
	L.core_uihelp2 = "|cffFF0000/moveui|r - Desbloqueia e permite mover os elementos pelo ecr�."
	L.core_uihelp3 = "|cffFF0000/rl|r - Recarrega a sua Interface."
	L.core_uihelp4 = "|cffFF0000/gm|r - Manda bilhete ao GM ou mostra a ajuda do WoW em jogo."
	L.core_uihelp5 = "|cffFF0000/frame|r - Detecta o nome do quadro no qual o seu rato se encontra (muito �til para editores de lua)"
	L.core_uihelp6 = "|cffFF0000/heal|r - Activa o layout de curandeiro na raide."
	L.core_uihelp7 = "|cffFF0000/dps|r - Activa o layout de Dps/Tank na raide."
	L.core_uihelp8 = "|cffFF0000/bags|r - Para organiza��o, compra de espa�o no banco ou empilhamento de itens nos seus sacos."
	L.core_uihelp9 = "|cffFF0000/resetui|r - Redefine para a Tukui padr�o."
	L.core_uihelp10 = "|cffFF0000/rd|r - Raide Dissolvida."
	L.core_uihelp11 = "|cffFF0000/ainv|r - Activa o convite autom�tico via palavra chave por sussurro. voce pode defenir a sua pr�pria palavra chave escrevendo `/ainv myword`"
	L.core_uihelp100 = "(Scroll para cima para mais comandos ...)"

	L.symbol_CLEAR = "Limpar"
	L.symbol_SKULL = "Caveira"
	L.symbol_CROSS = "Cruz"
	L.symbol_SQUARE = "Quadrado"
	L.symbol_MOON = "Lua"
	L.symbol_TRIANGLE = "Triangulo"
	L.symbol_DIAMOND = "Diamante"
	L.symbol_CIRCLE = "Circulo"
	L.symbol_STAR = "Estrela"

	L.bind_combat = "Voc� n�o pode fazer liga��es em combate"
	L.bind_saved = "Todas as Liga��es foram salvas."
	L.bind_discard = "Todas as novas Liga��es foram descartadas."
	L.bind_instruct = "Passe com o rato por qualquer bot�o de ac��o para fazer uma Liga��o. Pressione escape ou Clique Direito do rato para limpar os bot�es de ac��o correntes."
	L.bind_save = "Salvar Liga��es"
	L.bind_discardbind = "Descartar Liga��es"

	L.hunter_unhappy = "O seu ajudante est� triste!"
	L.hunter_content = "O seu ajudante est� contente!"
	L.hunter_happy = "O seu ajudante est� feliz!"

	L.move_tooltip = "Mover a Tooltip"
	L.move_minimap = "Mover o Minimapa"
	L.move_watchframe = "Mover as Miss�es"
	L.move_gmframe = "Mover o quadro do bilhete ao GM"
	L.move_buffs = "Mover os buffs do jogador"
	L.move_debuffs = "Mover os debuffs do jogador"
	L.move_shapeshift = "Mover a barra de Mudan�a de Forma/Totems"
	L.move_achievements = "Mover o quadro das Conquistas"
	L.move_roll = "Mover o quadro de Roll do Saque"
	L.move_vehicle = "Mover o quadro do Veiculo"
	L.move_extrabutton = "Bot�o Extra"

	-------------------------------------------------
	-- INSTALLATION
	-------------------------------------------------

	-- headers
	L.install_header_1 = "Bem Vindo"
	L.install_header_2 = "1. Essenciais"
	L.install_header_3 = "2. Quadros de Unidades"
	L.install_header_4 = "3. Op��es"
	L.install_header_5 = "4. Coisas que devia saber!"
	L.install_header_6 = "5. Comandos"
	L.install_header_7 = "6. Acabado"
	L.install_header_8 = "1. Defini��es essenciais"
	L.install_header_9 = "2. Social"
	L.install_header_10= "3. Quadros"
	L.install_header_11= "4. Sucesso!"

	-- install
	L.install_init_line_1 = "Obrigado por escolher a Tukui!"
	L.install_init_line_2 = "Voc� ser� guiado em passos simples pelo processo de instala��o. Em cada passo, voc� pode decidir se quer ou nao aplicar ou saltar as defini��es apresentadas."
	L.install_init_line_3 = "Tamb�m lhe � dada a possibilidade de ver um curto tutorial sobre algumas das op��es da Tukui."
	L.install_init_line_4 = "Pressione o bot�o 'Tutorial' para ser guiado atrav�s desta pequena introdu��o ou pressione 'Instalar' para saltar este passo."

	-- tutorial 1
	L.tutorial_step_1_line_1 = "Este r�pido tutorial mostrar� algumas das op��es da Tukui."
	L.tutorial_step_1_line_2 = "Primeiro, as coisas essenciais que voce deve saber antes de puder jogar com esta UI."
	L.tutorial_step_1_line_3 = "O instalador � parcialmente especifico para cada personagem. Enquando algumas das defini��es ser�o para toda a conta, voc� precisa correr o instaldor para cada personagem novo que use a Tukui. O instalador aparece automaticamente em todos os personagens que logem pela primeira vez na Tukui. Tamb�m, a op��o pode ser encontrada em /Tukui/config/config.lua para utilizadores 'Power' ou escrevendo /tukui em jogo para utilizadores 'Friendly'."
	L.tutorial_step_1_line_4 = "Um utilizador 'Power' � um utilizador que tem a capacidade de usar op��es avan�adas (ex: editar Lua) que est�o al�m das capacidades de um utilizador normal. Um utilizador 'Friendly' � um utilizador normal e n�o tem necessariamente que ter a capacidade de programar. � ent�o recomendado que usem a nossa ferramenta de configura��o em jogo (/tukui) para defini��es que queiram ver mostradas na Tukui."

	-- tutorial 2
	L.tutorial_step_2_line_1 = "A Tukui inclui uma vers�o integrada do oUF (oUFTukui) criada pelo Haste. Isto trata de todos os quadros de unidades, buffs e debuffs, e dos elementos espec�ficos de cada class."
	L.tutorial_step_2_line_2 = "Voc� pode visitar o site wowinterface.com e procurar pelo oUF para obter mais informa��es acerca desta ferramenta."
	L.tutorial_step_2_line_3 = "Se voc� joga como curandeiro ou l�der de raide, poder� ser �til activar os quadros de unidades de curandeiros. Estes mostram mais informa��es acerca da sua raide (/heal). Um dps ou um tank dever� usar o nosso simples mostrador de raide (/dps). Se voc� n�o quiser usar nenhuma das duas op��es ou usar outro mostrador de raide, pode desactivar esta op��o no gestor de addons no ecr� da lista de personagens."  
	L.tutorial_step_2_line_4 = "Para mudar a posi��o do quadro de unidade facilmente, escreva /moveui."

	-- tutorial 3
	L.tutorial_step_3_line_1 = "A Tukui � simplesmente a UI da Blizzard redesenhada. Nada mais, nada menos. Quase todas as op��es que voc� v� na UI padr�o est�o dispon�veis atrav�s da Tukui. As �nicas op��es n�o dispon�veis atrav�s da UI padr�o s�o algumas op��es n�o vis�veis no ecr�, como por exemplo a venda autom�tica dos itens cinzentos quando visitando um vendedor ou, outro exemplo, a organiza��o autom�tica dos itens nos sacos."
	L.tutorial_step_3_line_2 = "Nem todos os utilizadores gostam de coisas como medidores de DPS, mods de Chefe, medidores de amea�a, etc, n�s julgamos que � a melhor coisa a se fazer. A Tukui foi feita para que trabalha-se para todas as classes, papeis, especializa��es, estilos de jogo, gosto dos utilizadores, etc. � por isso que a Tukui � uma das mais populares UIs do momento. Encaixa em todos os estilos de jogo e � extremamente edit�vel. Tamb�m � desenhada para ser um bom come�o para todos os que querem fazer a sua pr�pria UI sem depender de Addons. Desde 2009 muitos utilizadores come�aram a usar a Tukui como base das suas pr�prias UIs. D� uma olhadela aos Pacotes Editados no nosso Site!"
	L.tutorial_step_3_line_3 = "Os utilizadores podem querer visitar a nossa sec��o de 'mods externos' no nosso site ou visitando o site www.wowinterface.com para instalar op��es ou mods adicionais."
	L.tutorial_step_3_line_4 = ""

	-- tutorial 4
	L.tutorial_step_4_line_1 = "Para configurar quantas barras voc� quer, passe com o rato � esquerda ou � direita no fundo da barra inferior de ac��o. Fa�a o mesmo na da direita, de cima para baixo. Para copiar texto do quadro de conversa��o, clique no bot�o que aparece no canto direito do quadro de conversa��o quando passa com o rato por cima."
	L.tutorial_step_4_line_2 = "O rebordo do minimapa muda de cor. Fica verde quando voc� recebe correio novo, fica vermelho quando tem um novo convite no calend�rio e fica laranja quando tem os dois."
	L.tutorial_step_4_line_3 = "Voc� pode usar o Clique esquerdo do rato em 80% dos 'datatext' para mostrar v�rios pain�is da Blizzard. O 'datatext' dos Amigos e da Guilda possuem tamb�m op��es de Clique direito do rato."  
	L.tutorial_step_4_line_4 = "Existem alguns menus suspensos dispon�veis. Clicar no bot�o direito do rato no bot�o [X] (Fechar) do Saco abrir� um menu suspenso para mostrar os Sacos, Organizar itens, Organizar o Porta-Chaves, etc. Clicar no bot�o do centro do rato no minimapa mostrar� o micro menu."

	-- tutorial 5
	L.tutorial_step_5_line_1 = " Finalmente, a Tukui inclui comandos slash muito �teis. Em baixo est� uma lista." 
	L.tutorial_step_5_line_2 = "/moveui permite mover muitos quadros para qualquer sitio do ecr�. /enable e /disable s�o usados para rapidamente activar e desactivar addons. /rl recarrega a UI. /heal activa os quadros de raide para o modo curandeiro. /dps activa os quadros de raide para o modo dps/tank."
	L.tutorial_step_5_line_3 = "/tt permite sussurrar ao seu alvo. /rc inicia um 'verificador de prontid�o'. /rd dissolve um grupo ou uma raide. /bags mostra algumas op��es dispon�veis via linha de comandos. /ainv activa o autoinvite a quem o pedir via sussurro. (/ainv off) para desactivar."
	L.tutorial_step_5_line_4 = "/gm mostra/oculta o quadro de ajuda. /install, /resetui or /tutorial carrega este instalador. /frame mostra o nome do quadro por baixo do cursor com informa��o adicional."

	-- tutorial 6
	L.tutorial_step_6_line_1 = "O tutorial est� completo. Voc� pode escolher rev�-lo a qualquer altura escrevendo /tutorial." 
	L.tutorial_step_6_line_2 = "N�s sugerimos que voc� de uma olhada pelo config/config.lua ou escrevendo /tukui para configurar a UI �s suas necessidades."
	L.tutorial_step_6_line_3 = "Voc� pode agora continuar a instala��o da UI caso esta n�o esteja acabada ou se quiser restabelecer a UI padr�o!"
	L.tutorial_step_6_line_4 = ""

	-- install step 1
	L.install_step_1_line_1 = "Estes passos aplicar�o as defini��es corretas para a Tukui."
	L.install_step_1_line_2 = "O primeiro passo aplica as defini��es essenciais." 
	L.install_step_1_line_3 = "Isto � |cffff0000recomendado|r para qualquer utilizador, a n�o ser que queira aplicar apenas uma parte especifica das defini��es."
	L.install_step_1_line_4 = "Clique 'Continuar' para aplicar as defini��es, ou clique 'Saltar' se desejar saltar este passo."

	-- install step 2
	L.install_step_2_line_0 = "Foi encontrado outro addon de conversa��o. Vamos ignorar este passo. Por favor pressione Saltar para continuar a instala��o." 
	L.install_step_2_line_1 = "O segundo passo aplica as defini��es corretas de conversa��o."
	L.install_step_2_line_2 = "Se voc� � um novo utilizador, este passo � recomendado. Se voc� � um utilizador antigo, poder� querer saltar este passo."
	L.install_step_2_line_3 = " � normal que a fonte de Conversa��o apare�a muito grande ap�s aplicar estas defini��es. Voltar� ao normal quando acabar a instala��o."
	L.install_step_2_line_4 = "Clique 'Continuar' para aplicar as defini��es, ou clique 'Saltar' se desejar saltar este passo."

	-- install step 3
	L.install_step_3_line_1 = "O terceiro e passo final aplica as posi��es padr�o para os quadros." 
	L.install_step_3_line_2 = "Este passo � |cffff0000recomendado|r para qualquer novo utilizador."
	L.install_step_3_line_3 = ""
	L.install_step_3_line_4 = "Clique 'Continuar' para aplicar as defini��es, ou clique 'Saltar' se desejar saltar este passo." 

	-- install step 4
	L.install_step_4_line_1 = "Installation is complete. Instala��o Completada."
	L.install_step_4_line_2 = "Please click the 'Finish' button to reload the UI. Por favor clique 'Acabar' para recarregar a UI."
	L.install_step_4_line_3 = ""
	L.install_step_4_line_4 = "Desfrute da Tukui! Visite o nosso site www.tukui.org!"

	-- buttons
	L.install_button_tutorial = "Tutorial"
	L.install_button_install = "Instalar"
	L.install_button_next = "Seguinte"
	L.install_button_skip = "Saltar"
	L.install_button_continue = "Continuar"
	L.install_button_finish = "Acabar"
	L.install_button_close = "Fechar"
end
local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs: Plugins", "ptBR")
if not L then return end

-- These localization strings are translated on WoWAce: http://www.wowace.com/addons/big-wigs/localization/
L["abilityName"] = "Nome da habilidade"
L["abilityNameDesc"] = "Mostra/oculta o nome da habilidade em cima da janela."
L["Alarm"] = "Alarme"
L["Alert"] = "Alerta"
L["align"] = "Alinhação"
L["Attention"] = "Atenção"
L["background"] = "Fundo"
L["backgroundDesc"] = "Mostra/oculta o fundo"
L["bars"] = "Barras"
L["bestTimeBar"] = "Melhor tempo" -- Needs review
L["Beware"] = "Cuidado (Algalon)" -- Needs review
L["bigWigsBarStyleName_Default"] = "Padrão"
L["bossDefeatDurationPrint"] = "Derrotou '%s' após '%s'" -- Needs review
L["bossStatistics"] = "Estatísticas do chefe." -- Needs review
L["bossWipeDurationPrint"] = "Foi derrotado por '%s' após %s" -- Needs review
L["bwEmphasized"] = "Enfatizar" -- Needs review
L["center"] = "Centro"
L["chatMessages"] = "Conversas" -- Needs review
L["classColors"] = "Cores das classes"
L["clickableBars"] = "Barras clicaveis"
L["clickableBarsDesc"] = [=[As barras do Big Wigs são clicaveis por padrão. Desta forma você pode mirar em objetos e lançar feitiços AoE atrás deles, trocar o ângulo da câmera, e assim sucessivamente, sem precisar do cursor estar em cima das barras. |cffff4411Se habilitar as barras clicaveis, isto deixará de funcionar.|r as barras interceptarão qualquer clique do mouse que chegar a elas.
]=]
L["close"] = "Fechar"
L["closeButton"] = "Botão fechar"
L["closeButtonDesc"] = "Mostra/oculta o botão de fechar"
L["closeProximityDesc"] = [=[Fecha a janela de aproximação.

Para desativala completamente para um encontro, tem que ir nas opções deste encontro e desativar a opção de 'Aproximação'.]=]
L["colors"] = "Cores"
L["countDefeats"] = "Contador de vitórias " -- Needs review
L["countdown"] = "Contador"
L["countdownDesc"] = "Se um contador é relativamente maior que 5 segundos, uma conta vocal e visual será feita para os últimos 5 segundos. Imagine alguma contagem \"5... 4... 3... 2... 1... BOOM!\" e grandes números no meio da tela."
L["countWipes"] = "Contador de derrotas" -- Needs review
L["createTimeBar"] = "Mostrar barra do melhor tempo" -- Needs review
L["customRange"] = "Indicador de distância personalizado"
L["customSoundDesc"] = "Reproduzir um som personalizado ao invés do padrão" -- Needs review
L["defaultOnly"] = "Somente padrões"
L["Destruction"] = "Destruição (Kil'jaeden)" -- Needs review
L["disable"] = "Desativar"
L["disabled"] = "Desativado"
L["disableDesc"] = "Desativa permanentemente a habilidade de encontro para que não de opção de que reapareça esta barra"
L["doubleSize"] = "Tamanho dobrado"
L["doubleSizeDesc"] = "Dobra o tamanho das barras super enfatizadas e as mensagens"
L["emphasize"] = "Enfatizar"
L["emphasized"] = "Enfatizado"
L["emphasizedBars"] = "Barras enfatizadas"
L["emphasizedMessages"] = "Mensagens enfatizadas"
L["emphasizedSinkDescription"] = "Seguir o padrão de mensagens enfatizadas do Big Wigs. Isto suporta texto e cores, e só podem aparecer uma vez."
L["enable"] = "Habilitar"
L["enableStats"] = "Habilitar estatísticas" -- Needs review
L["fill"] = "Completar"
L["fillDesc"] = "Completa as barras ao envés de drenar."
L["FlagTaken"] = "Bandeira capturada (PvP)" -- Needs review
L["font"] = "Fonte"
L["fontSize"] = "Tamanho da fonte"
L["growUpwards"] = "Aumentar crescentemente"
L["growUpwardsDesc"] = "Alterna entre aumentar as barras crescentemente/decrescentemente des do encaixe."
L["icon"] = "Icono"
L["iconDesc"] = "Mostra ou oculta os icones das barras."
L["icons"] = "Icones"
L["Important"] = "Importante"
L["Info"] = "Info"
L["interceptMouseDesc"] = "Ativa as barras para receber cliques do mouse"
L["left"] = "Esquerda"
L["localTimer"] = "Local"
L["lock"] = "Bloquear"
L["lockDesc"] = "Trava a janela no lugar, previnindo que se mova e redimensione"
L["Long"] = "Longo"
L["messages"] = "Mensagens"
L["modifier"] = "Modificação"
L["modifierDesc"] = "Segure a tecla de modificação selecionada para ativar ações de cliques nas barras de tempo."
L["modifierKey"] = "Somente com uma tecla de modificação"
L["modifierKeyDesc"] = "Permite que as barras sejão clicaveis se estiver com a tecla de modificação pressionada, deste jeito as ações do mouse descritas abaixo estarão disponíveis."
L["monochrome"] = "Monocromo"
L["monochromeDesc"] = "Troca o indicador monocromo, removendo qualquer embelezamento das fontes." -- Needs review
L["move"] = "Mover"
L["Neutral"] = "Neutro" -- Needs review
L["newBestTime"] = "Novo recorde!" -- Needs review
L["none"] = "Nenhuma"
L["normalMessages"] = "Mensagens normais"
L["outline"] = "Contorno"
L["output"] = "Saida"
L["Personal"] = "Pessoal"
L["Positive"] = "Positivo"
L["primary"] = "Primário"
L["primaryDesc"] = "O primeiro objetivo da raide, este icone será usado"
L["printBestTimeOption"] = "Notificação de melhor tempo" -- Needs review
L["printDefeatOption"] = "Tempo de luta" -- Needs review
L["printWipeOption"] = "Tempo até ser derrotado" -- Needs review
L["proximity"] = "Visualizar aproximação"
L["proximity_desc"] = "Mostra a janela de aproximação quando for apropiada para este encontro, lista os jogadores que estão muito pertos de você."
L["proximityTitle"] = "%d yd / %d |4player:players;"
L["raidIconsDescription"] = [=[Elementos de tipo 'bomba' e similares em um jogador podem ser de interesse especial. Aqui você pode configurar como se deveria marcar com icones algunos personagens.

Só se usa um icone para cada encontro se usará o primario, nunca se usará o mesmo icone para 2 habilidades distintas, para isto esta o icone secundario.

|cffff4411Nota: Se um jogador foi marcado manualmente o Big Wigs nunca trocará seu icone.|r]=]
L["recordBestTime"] = "Gravar recorde" -- Needs review
L["regularBars"] = "Barras regulares"
L["remove"] = "Remover"
L["removeDesc"] = "Temporariamente fecha a barra e todas as mensagens associadas"
L["removeOther"] = "Remover outro"
L["removeOtherDesc"] = "Temporariamente fecha todas as barras (exceto esta) e as mensagens associadas."
L["report"] = "Reportar"
L["reset"] = "Reiniciar"
L["resetAll"] = "Reiniciar tudo"
L["resetAllDesc"] = "Se você personalizou as cores e os ajustes de alguns encontros de chefe, este botão reiniciará TUDO e usará as cores padrões."
L["resetDesc"] = "Reinicia as cores padrões"
L["restart"] = "Reiniciar"
L["restartDesc"] = "Reinicia as barras enfatizadas para que comecem desde o principio e conta desde 10."
L["right"] = "Direita"
L["RunAway"] = "Corra, garotinha! (Lobo Mau)" -- Needs review
L["scale"] = "Escala"
L["secondary"] = "Secundário"
L["secondaryDesc"] = "O segundo objetivo da raide, este icone será usado"
L["showHide"] = "Mostrar/ocultar"
L["sinkDescription"] = "Seguir o padrão do addon deixando as mensagens serem mostradas do jeito padrão do Big Wigs. Isto suporta icones, cores e podem mostrar até 4 mensagens na tela de uma vez. Após inserir as mensagens crescerão de tamanho e encolherão de novo rápidamente para notificar o usuario."
L["sound"] = "Som"
L["soundButton"] = "Botão de som"
L["soundButtonDesc"] = "Mostra/oculta o botão de som"
L["soundDefaultDescription"] = "Com esta opção habilitada, Big Wigs usará somente o som padrão da Blizzard para os alertas de raide e para mensagens que chegão com um alerta de som. Nota: Somente algumas mensagens dos scripts de encontros usarão alerta de som."
L["soundDelay"] = "Atraso de som"
L["soundDelayDesc"] = "Especifique o tempo que Big Wigs deverá esperar entre cada repetição de som quando alguem está muito perto de você."
L["Sounds"] = "Sons"
L["style"] = "Estilo"
L["superEmphasize"] = "Super Enfatizar"
L["superEmphasizeDesc"] = [=[Da um aviso muito mais facil de se ver as mensagens ou barras relacionadas com uma habilidade de um encontro.

Aquí você configura exatamente o que deverá ocurrer quando trocar para ativado a opção de Super Enfatizar na sessão avançada para uma habilidade de um encontro de um chefe.

|cffff4411Nota: Super Enfatizar está desabilitado por padrão para todas as habilidades.|r
]=]
L["tempEmphasize"] = "Temporariamente Super Enfatiza a barra e as mensagens associadas para a duração."
L["text"] = "Texto"
L["texture"] = "Textura"
L["thick"] = "Grosso"
L["thin"] = "Fino"
L["time"] = "Tempo"
L["timeDesc"] = "Oculta ou mostra o tempo restante nas barras."
L["timerFinished"] = "%s: Contador [%s] terminado."
L["title"] = "Título"
L["titleDesc"] = "Mostra/oculta o título"
L["toggleSound"] = "Trocar som"
L["toggleSoundDesc"] = "Ativada ou não a janela de aproximação, deverá emitir um beep se estiver perto de outro jogador."
L["tooltip"] = "Tooltip"
L["tooltipDesc"] = "Mostra/oculta o tooltip do feitiço se a janela de aproximação estiver empatada com uma habilidade de chefe."
L["uppercase"] = "MAIÚSCULAS"
L["uppercaseDesc"] = "Maiúsculas emm todas as mensagens relacionadas com a opção super enfatizada."
L["Urgent"] = "Urgente"
L["useColors"] = "Usar cores"
L["useColorsDesc"] = "Mensagens somente de cor branca, ignorando as cores."
L["useIcons"] = "Usar icones"
L["Victory"] = "Vitória"
L["Warning"] = "Avisos" -- Needs review


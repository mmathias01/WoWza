local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs: Plugins", "ptBR")
if not L then return end

-----------------------------------------------------------------------
-- Bars.lua
--

L["Style"] = "Estilo"
L.bigWigsBarStyleName_Default = "Padrão"

L["Clickable Bars"] = "Barras clicaveis"
L.clickableBarsDesc = "As barras do Big Wigs são clicaveis por padrão. Desta forma você pode mirar em objetos e lançar feitiços AoE atrás deles, trocar o ângulo da câmera, e assim sucessivamente, sem precisar do cursor estar em cima das barras. |cffff4411Se habilitar as barras clicaveis, isto deixará de funcionar.|r as barras interceptarão qualquer clique do mouse que chegar a elas.\n"
L["Enables bars to receive mouse clicks."] = "Ativa as barras para receber cliques do mouse"
L["Modifier"] = "Modificação"
L["Hold down the selected modifier key to enable click actions on the timer bars."] = "Segure a tecla de modificação selecionada para ativar ações de cliques nas barras de tempo."
L["Only with modifier key"] = "Somente com uma tecla de modificação"
L["Allows bars to be click-through unless the specified modifier key is held down, at which point the mouse actions described below will be available."] = "Permite que as barras sejão clicaveis se estiver com a tecla de modificação pressionada, deste jeito as ações do mouse descritas abaixo estarão disponíveis."

L["Temporarily Super Emphasizes the bar and any messages associated with it for the duration."] = "Temporariamente Super Enfatiza a barra e as mensagens associadas para a duração."
L["Report"] = "Reportar"
--L["Reports the current bars status to the active group chat; either instance chat, raid, party or say, as appropriate."] = "Reports the current bars status to the active group chat; either instance chat, raid, party or say, as appropriate."
L["Remove"] = "Remover"
L["Temporarily removes the bar and all associated messages."] = "Temporariamente fecha a barra e todas as mensagens associadas"
L["Remove other"] = "Remover outro"
L["Temporarily removes all other bars (except this one) and associated messages."] = "Temporariamente fecha todas as barras (exceto esta) e as mensagens associadas."
L.disable = "Desativar"
L["Permanently disables the boss encounter ability option that spawned this bar."] = "Desativa permanentemente a habilidade de encontro para que não de opção de que reapareça esta barra"

--L["Emphasize at... (seconds)"] = "Emphasize at... (seconds)"
L["Scale"] = "Escala"
L["Grow upwards"] = "Aumentar crescentemente"
L["Toggle bars grow upwards/downwards from anchor."] = "Alterna entre aumentar as barras crescentemente/decrescentemente des do encaixe."
L["Texture"] = "Textura"
L["Emphasize"] = "Enfatizar"
L["Enable"] = "Habilitar"
L["Move"] = "Mover"
--L.moveDesc = "Moves emphasized bars to the Emphasize anchor. If this option is off, emphasized bars will simply change scale and color."
L["Regular bars"] = "Barras regulares"
L["Emphasized bars"] = "Barras enfatizadas"
L["Align"] = "Alinhação"
L["Left"] = "Esquerda"
L["Center"] = "Centro"
L["Right"] = "Direita"
L["Time"] = "Tempo"
L["Whether to show or hide the time left on the bars."] = "Oculta ou mostra o tempo restante nas barras."
L["Icon"] = "Icono"
L["Shows or hides the bar icons."] = "Mostra ou oculta os icones das barras."
L.font = "Fonte"
L["Restart"] = "Reiniciar"
L["Restarts emphasized bars so they start from the beginning and count from 10."] = "Reinicia as barras enfatizadas para que comecem desde o principio e conta desde 10."
L["Fill"] = "Completar"
L["Fills the bars up instead of draining them."] = "Completa as barras ao envés de drenar."

L["Local"] = "Local"
L["%s: Timer [%s] finished."] = "%s: Contador [%s] terminado."



-- These localization strings are translated on WoWAce: http://www.wowace.com/addons/big-wigs/localization/
L["abilityName"] = "Nome da habilidade"
L["abilityNameDesc"] = "Mostra/oculta o nome da habilidade em cima da janela."
L["Alarm"] = "Alarme"
L["Alert"] = "Alerta"
L["Attention"] = "Atenção"
L["background"] = "Fundo"
L["backgroundDesc"] = "Mostra/oculta o fundo"
L["bars"] = "Barras"
L["classColors"] = "Cores das classes"
L["close"] = "Fechar"
L["closeButton"] = "Botão fechar"
L["closeButtonDesc"] = "Mostra/oculta o botão de fechar"
L["closeProximityDesc"] = [=[Fecha a janela de aproximação.

Para desativala completamente para um encontro, tem que ir nas opções deste encontro e desativar a opção de 'Aproximação'.]=]
L["colors"] = "Cores"
L["countdown"] = "Contador"
L["countdownDesc"] = "Se um contador é relativamente maior que 5 segundos, uma conta vocal e visual será feita para os últimos 5 segundos. Imagine alguma contagem \"5... 4... 3... 2... 1... BOOM!\" e grandes números no meio da tela."
L["customRange"] = "Indicador de distância personalizado"
L["defaultOnly"] = "Somente padrões"
L["disabled"] = "Desativado"
L["disabledDesc"] = "Desativa a janela de aproximação em todos os módulos que a use."
L["doubleSize"] = "Tamanho dobrado"
L["doubleSizeDesc"] = "Dobra o tamanho das barras super enfatizadas e as mensagens"
L["emphasized"] = "Enfatizado"
L["emphasizedMessages"] = "Mensagens enfatizadas"
L["emphasizedSinkDescription"] = "Seguir o padrão de mensagens enfatizadas do Big Wigs. Isto suporta texto e cores, e só podem aparecer uma vez."
L["fontSize"] = "Tamanho da fonte"
L["icons"] = "Icones"
L["Important"] = "Importante"
L["Info"] = "Info"
L["lock"] = "Bloquear"
L["lockDesc"] = "Trava a janela no lugar, previnindo que se mova e redimensione"
L["Long"] = "Longo"
L["messages"] = "Mensagens"
L["monochrome"] = "Monocromo"
L["monochromeDesc"] = "Troca o indicador monocromo de todas as mensagens, removendo qualquer embelezamento das fontes."
L["none"] = "Nenhuma"
L["normalMessages"] = "Mensagens normais"
L["outline"] = "Contorno"
L["output"] = "Saida"
L["Personal"] = "Pessoal"
L["Positive"] = "Positivo"
L["primary"] = "Primário"
L["primaryDesc"] = "O primeiro objetivo da raide, este icone será usado"
L["proximity"] = "Visualizar aproximação"
L["proximity_desc"] = "Mostra a janela de aproximação quando for apropiada para este encontro, lista os jogadores que estão muito pertos de você."
L["proximityTitle"] = "%d yd / %d |4player:players;"
L["raidIconsDescription"] = [=[Elementos de tipo 'bomba' e similares em um jogador podem ser de interesse especial. Aqui você pode configurar como se deveria marcar com icones algunos personagens.

Só se usa um icone para cada encontro se usará o primario, nunca se usará o mesmo icone para 2 habilidades distintas, para isto esta o icone secundario.

|cffff4411Nota: Se um jogador foi marcado manualmente o Big Wigs nunca trocará seu icone.|r]=]
L["reset"] = "Reiniciar"
L["resetAll"] = "Reiniciar tudo"
L["resetAllDesc"] = "Se você personalizou as cores e os ajustes de alguns encontros de chefe, este botão reiniciará TUDO e usará as cores padrões."
L["resetDesc"] = "Reinicia as cores padrões"
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
L["superEmphasize"] = "Super Enfatizar"
L["superEmphasizeDesc"] = [=[Da um aviso muito mais facil de se ver as mensagens ou barras relacionadas com uma habilidade de um encontro.

Aquí você configura exatamente o que deverá ocurrer quando trocar para ativado a opção de Super Enfatizar na sessão avançada para uma habilidade de um encontro de um chefe.

|cffff4411Nota: Super Enfatizar está desabilitado por padrão para todas as habilidades.|r
]=]
L["text"] = "Texto"
L["thick"] = "Grosso"
L["thin"] = "Fino"
L["title"] = "Título"
L["titleDesc"] = "Mostra/oculta o título"
L["toggleProximityPrint"] = "A janela de aproximação aparecerá na próxima vez. Para desativala completamente neste encontro, você deve apagala das opções de encontros."
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



local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs: Plugins", "itIT")
if not L then return end

-- These localization strings are translated on WoWAce: http://www.wowace.com/addons/big-wigs/localization/
L["abilityName"] = "Nome dell'Abilità"
L["abilityNameDesc"] = "Visualizza o nasconde il nome dell'abilità sopra la finestra"
L["Alarm"] = "Allarme"
L["Alert"] = "Avvertimento"
L["align"] = "Allineamento"
L["Attention"] = "Attenzione"
L["background"] = "Sfondo"
L["backgroundDesc"] = "Visualizza o nasconde il titolo"
L["bars"] = "Barre"
L["bestTimeBar"] = "Migliore"
L["Beware"] = "Attenti! (Algalon)"
L["bigWigsBarStyleName_Default"] = "Predefinito"
L["bossDefeatDurationPrint"] = "Sconfitto '%s' dopo %s."
L["bossStatistics"] = "Statistiche del Boss"
L["bossStatsDescription"] = "Tiene il conto di varie statistiche relative ad ogni singolo boss, tipo il numero di volte che è stato sconfitto, il numero di tentativi falliti(wipes), quanto è durato il combattimento, o l'uccisione più veloce. Queste statistiche possono essere viste nella finestra di configurazione di ogni singolo boss, ma saranno nascoste per quei boss di cui non c'é nessuna informazione statistica."
L["bossWipeDurationPrint"] = "Tentativo fallito su '%s' dopo %s."
L["bwEmphasized"] = "Big Wigs Enfatizzato"
L["center"] = "Centro"
L["chatMessages"] = "Messaggi Chat"
L["classColors"] = "Colore delle Classi"
L["classColorsDesc"] = "Colora i nomi dei giocatori in base alla loro classe."
L["clickableBars"] = "Barre Cliccabili"
L["clickableBarsDesc"] = [=[Le barre di Big Wigs non sono cliccabili di default. In questo modo puoi selezionare o lanciare le abilità anche dietro le barre, cambiare l'angolo della telecamera, e così via, mentre il cursore è su una barra.|cffff4411Se abiliti le Barre Cliccabili, questo non funzionerà più.|r Le barre intercetteranno i click del mouse.
]=]
L["close"] = "Chiudi"
L["closeButton"] = "Pulsante di Chiusura"
L["closeButtonDesc"] = "Visualizza o nasconde il pulsante di Chiusura"
L["closeProximityDesc"] = [=[Chiude il Monitor di Prossimità.

Per disabilitarlo completamente per tutti gli incontri, devi andare nelle impostazioni dei singoli combattimenti e disabilitare l'opzione 'Prossimità]=]
L["colors"] = "Colori"
L["countDefeats"] = "Numero Uccisioni"
L["countdown"] = "Conto alla Rovescia"
L["countdownDesc"] = "Se un timer è maggiore di 5 secondi, un avviso vocale e un conto alla rovescia verrranno aggiunti negli ultimi 5 secondi. Immagina qualcuno che conta '5... 4... 3... 2... 1... ABILITÀ!' e dei grandi numeri in mezzo al tuo schermo."
L["countWipes"] = "Numero Fallimenti:"
L["createTimeBar"] = "Mostra la barra 'Miglior Tempo'"
L["customBarStarted"] = "Barra personalizzata '%s' creata da utente %s - %s."
L["customRange"] = "Indicatore di Distanza Personalizzato"
L["customSoundDesc"] = "Riproduci il suono personalizzato scelto invece che quelli proposti dal modulo"
L["defaultOnly"] = "Solo Suoni Predefiniti"
L["Destruction"] = "Distruzione (Kil'jaeden)"
L["disable"] = "Disabilita"
L["disabled"] = "Disabilitato"
L["disabledDesc"] = "Disabilita il monitor di prossimità per tutti i moduli che lo usano."
L["disableDesc"] = "Disabilita in modo permanente l'abilità del boss che ha generato questa barra."
L["displayTime"] = "Tempo di Visualizzazione"
L["displayTimeDesc"] = "Per quanto tempo deve essere visualizzato il messaggio, in secondi"
L["doubleSize"] = "Raddoppia la Dimensione"
L["doubleSizeDesc"] = "Raddoppa la dimensione della barra e del messaggio"
L["emphasize"] = "Enfatizza"
L["emphasizeAt"] = "Enfatizza a... (secondi)"
L["emphasized"] = "Enfatizzato"
L["emphasizedBars"] = "Barre Enfatizzate"
L["emphasizedCountdown"] = "Recupero Messaggi Enfatizzati"
L["emphasizedCountdownSinkDescription"] = "Indirizza l'uscita da questo addon verso la visualizzazione del Recupero Messaggi Enfatizzati. Questa visualizzazione supporta testi e colori, e può visualizzare solo un messaggio alla volta."
L["emphasizedMessages"] = "Messaggi Enfatizzati"
L["emphasizedSinkDescription"] = "Indirizza l'uscita dei messaggi attraverso il visualizzatore di Messaggi ENFATIZZATI di Big Wigs. Questo metodo supporta testi, colori e può visualizzare un solo messaggio per volta."
L["enable"] = "Attiva"
L["enableStats"] = "Abilita Statistiche"
L["encounterRestricted"] = "Questa funzione non può essere usata durante uno scontro con un boss."
L["fadeTime"] = "Tempo di Scomparsa"
L["fadeTimeDesc"] = "Dopo quanti secondi il messaggio deve scomparire, in secondi"
L["fill"] = "Riempi"
L["fillDesc"] = "Riempi le barre invece di svuotarle man mano che passano i secondi."
L["FlagTaken"] = "Cattura Bandiera (PvP)"
L["flash"] = "Lampeggio"
L["font"] = "Carattere"
L["fontColor"] = "Colore carattere"
L["fontSize"] = "Dimensione Carattere"
L["growUpwards"] = "Cresci verso l'altro"
L["growUpwardsDesc"] = "Alterna la crescita delle barre verso l'alto o verso il basso a partire dall'ancora."
L["icon"] = "Icona"
L["iconDesc"] = "Visualizza o nasconde le icone delle Barre."
L["icons"] = "Icone"
L["Important"] = "Importante"
L["Info"] = "Informazioni"
L["interceptMouseDesc"] = "Abilita le barre ad intercettare i Click del Mouse"
L["left"] = "Sinistra"
L["localTimer"] = "Locale"
L["lock"] = "Blocca"
L["lockDesc"] = "Blocca il Monitor, impedendo che venga spostato e ridimensionato."
L["Long"] = "Lungo"
L["messages"] = "Messaggi"
L["modifier"] = "Modificatore"
L["modifierDesc"] = "Premi il modificatore selezionato per abilitare i click sulle barre dei timer."
L["modifierKey"] = "Solo con il tasto modificatore"
L["modifierKeyDesc"] = "Lascia le barre non cliccabili a meno che non sia premuto il tasto modificatore, a questo punto l'azione descritta sotto sarà disponibile."
L["monochrome"] = "Monocromatico"
L["monochromeDesc"] = "Abilita il flag monocromatico, rimuovendo ogni effetto di smussatura degli angoli dei caratteri."
L["move"] = "Muovi"
L["moveDesc"] = "Muovi le Barre Enfatizzate all'Ancoraggio di Enfatizzazione. Se questa opzione non è abilitata. le barre enfatizzate cambieranno semplicemente scalatura e colore."
L["Neutral"] = "Neutrale"
L["newBestTime"] = "Nuovo record!"
L["none"] = "Nessuno"
L["normal"] = "Normale"
L["normalMessages"] = "Messaggi Normali"
L["outline"] = "Sottolineato"
L["output"] = "Uscita"
L["Personal"] = "Personale"
L["Positive"] = "Positivo"
L["primary"] = "Primario"
L["primaryDesc"] = "Il primo Simbolo che l'automazione del combattimento dovrebbe usare."
L["printBestTimeOption"] = "Notifica Miglior Tempo"
L["printDefeatOption"] = "Tempo Uccisione"
L["printWipeOption"] = "Tempo Fallimento"
L["proximity"] = "Monitor di Prossimità"
L["proximity_desc"] = "Visualizza il monitor di prossimità al momento opportuno durante il combattimento, con i giocatori che stanno troppo vicino a te."
L["proximityTitle"] = "%d m / %d |4giocatore:giocatori;"
L["pull"] = "Ingaggio"
L["pullIn"] = "Ingaggio tra %d sec"
L["pulling"] = "Ingaggio!"
L["pullStarted"] = "Timer Ingaggio iniziato da utente %s - %s."
L["pullStopped"] = "Barra d'ingaggio cancellata da %s."
L["raidIconsDescription"] = "Alcuni combattimenti possono includere elementi come bombe su giocatori specifici, un giocatore inseguito da qualcosa, che interessano un giocatore. Qui puoi personalizzare quali Simboli devono essere applicati sui giocatori.|r"
L["recordBestTime"] = "Ricorda Miglior Tempo"
L["regularBars"] = "Barre Normali"
L["remove"] = "Rimuovi"
L["removeDesc"] = "Rimuove temporaneamente la barra e tutti i messaggi ad essa associati."
L["removeOther"] = "Rimuovi le Altre"
L["removeOtherDesc"] = "Rimuove temporaneamente tutte le altre barra (tranne questa) e i messaggi ad esse associati."
L["report"] = "Riporta"
L["reportDesc"] = "Riporta lo status della barra attuale nella finestra attiva di chat; che sia la chat dell'incursione, dell'istanza, del gruppo o del canale Parla, il più appropriato."
L["requiresLeadOrAssist"] = "Questa funzione richiede Capo Incursione o Assistente Incursione."
L["reset"] = "Reimposta"
L["resetAll"] = "Reimposta tutto"
L["resetAllCustomSound"] = "Se hai personalizzzato i suoni per qualsiasi boss, questo pulsante reimposterà TUTTI i suoni predefiniti e quindi verranno usati i suoni definiti qui."
L["resetAllDesc"] = "Se hai modificato qualsiasi parametro dei combattimenti, questo pulsante riporterà TUTTO alle impostazioni originali."
L["resetDesc"] = "Reimposta i colori qui sopra ai parametri originali."
L["restart"] = "Riavvia"
L["restartDesc"] = "Riavvia le barre Enfatizzate in modo che partano dall'inizio e contino fino a 10."
L["right"] = "Destra"
L["RunAway"] = "Scappa ragazzina, scappa!!! (Big Bad Wolf)"
L["scale"] = "Scala"
L["secondary"] = "Secondario"
L["secondaryDesc"] = "Il secondo Simbolo che l'automazione del combattimento dovrebbe usare."
L["sendCustomBar"] = "Invio barra personalizzata '%s' agli utenti di Big Wigs e DBM."
L["sendPull"] = "Invio di un timer di Ingaggio agli utenti di Big Wigs e DBM."
L["showHide"] = "Visulizza/Nascondi"
L["sinkDescription"] = "Indirizza l'uscita dei messaggi sul visualizzatore di Messaggi Normali di Big Wigs. Questa visualizzazione supporta icone, colori e può visualizzare fino a 4 messaggi sullo schermo. I messaggi più recenti cresceranno in dimensioni per avvertire l'utente."
L["sound"] = "Suono"
L["soundButton"] = "Pulsante del Suono"
L["soundButtonDesc"] = "Visualizza o nasconde il pulsante del Suono"
L["soundDefaultDescription"] = "Con questa opzione, Big Wigs userà solo i suoni predefiniti Blizzard che indicano un avviso. Ricorda che solo alcuni messaggi utilizzeranno i suoni durante un combattimento."
L["soundDelay"] = "Ritardo del Suono"
L["soundDelayDesc"] = "Specifica per quanto tempo Big Wigs dovrebbe aspettare per ripetere il suono quando qualcuno è vicino a te."
L["Sounds"] = "Suoni"
L["style"] = "Stile"
L["superEmphasize"] = "SUPER ENFATIZZAZIONE"
L["superEmphasizeDesc"] = [=[Aumenta la visualizzazione di un messaggio o di un timer di un'abilità speciale di un boss..

 Qui puoi configurare esattamente cosa deve accadere quando abiliti la SUPER ENFATIZZAZIONE nelle opzioni di un'abilità di un boss.

|cffff4411Attenzione: la SUPER ENFATIZZAZIONE è disattivata di default per tutte le abilità.|r
]=]
L["tempEmphasize"] = "SUPER ENFATIZZA temporaneamente la barra ed ogni messaggio associato alla sua durata."
L["text"] = "Testo"
L["textShadow"] = "Ombra Testo"
L["texture"] = "Texture"
L["thick"] = "Spesso"
L["thin"] = "Fine"
L["time"] = "Tempo Rimasto"
L["timeDesc"] = "Visualizza o nasconde il tempo rimasto sulle barre."
L["timerFinished"] = "%s: Timer [%s] Terminato."
L["title"] = "Titolo"
L["titleDesc"] = "Visualizza o nasconde il titolo"
L["toggleProximityPrint"] = "Il monitor di prossimità verrà visualizzzato la prossima volta. Per disabilitarlo completamente per questo combattimento, devi disabilitarlo nelle opzioni del combattimento."
L["toggleSound"] = "Abilita Suono"
L["toggleSoundDesc"] = "Abilita quando il monitor di prossimità deve emettere un suono se sei troppo vicino ad altri giocatori."
L["tooltip"] = "ToolTip"
L["tooltipDesc"] = "Visualizza o nasconde il tooltip dell'abilità nel display di prossimità ed è strettamente legato all'abilità del boss."
L["uppercase"] = "TUTTO MAIUSCOLO"
L["uppercaseDesc"] = "Converte in Maiuscolo tutto il messaggio"
L["Urgent"] = "Urgente"
L["useColors"] = "Usa Colori"
L["useColorsDesc"] = "Abilita solo messaggi bianchi ignorando i colori"
L["useIcons"] = "Usa Icone"
L["useIconsDesc"] = "Mostra le icone accanto ai messaggi."
L["Victory"] = "Vittoria"
L["Warning"] = "Avviso"
L["wrongCustomBarFormat"] = "Formato non corretto. Un'esempio corretto è: /raidbar 20 testo"
L["wrongPullFormat"] = "Deve essere tra 1 e 60. Un'esempio corretto è: /pull 5"
L["wrongTime"] = "Specificato tempo non valido. <time> può essere sia un numero in secondi, una coppia M:S , o Mm. Per esempio 5, 1:20 or 2m."


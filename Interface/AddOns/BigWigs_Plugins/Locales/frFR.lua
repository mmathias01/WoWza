local L = LibStub("AceLocale-3.0"):NewLocale("Big Wigs: Plugins", "frFR")
if not L then return end
-----------------------------------------------------------------------
-- Bars.lua
--

L["Style"] = "Style"
L.bigWigsBarStyleName_Default = "Défaut"

L["Clickable Bars"] = "Barres cliquables"
L.clickableBarsDesc = "Par défaut, les barres de Big Wigs ignorent la souris. Vous pouvez ainsi cibler ou lancer des sorts de zone derrière elles, changer l'angle de la caméra, ... tandis que votre curseur survole les barres. |cffff4411Si vous activez ceci, tout cela ne sera plus d'application.|r Les barres intercepteront tout clic que vous effectuez sur elles.\n"
L["Enables bars to receive mouse clicks."] = "Permet aux barres de recevoir les clics de la souris."
L["Modifier"] = "Modificateur"
L["Hold down the selected modifier key to enable click actions on the timer bars."] = "Maintenez enfoncée la touche modificatrice sélectionnée pour activer les actions des clics sur les barres."
L["Only with modifier key"] = "Seul. avec touche mod."
L["Allows bars to be click-through unless the specified modifier key is held down, at which point the mouse actions described below will be available."] = "Permet aux barres de ne pas réagir aux clics de la souris à moins que la touche modificatrice sélectionnée ne soit maintenue enfoncée, cas dans lequel les actions de la souris décrites ci-dessous seront disponibles."

L["Temporarily Super Emphasizes the bar and any messages associated with it for the duration."] = "Met temporairement en super mise en évidence la barre et ses messages associés pendant sa durée."
L["Report"] = "Rapport"
L["Reports the current bars status to the active group chat; either instance chat, raid, party or say, as appropriate."] = "Rapporte le statut des barres actuelles dans la discussion de groupe active : la discussion d'instance, de raid, de groupe ou juste le dire, selon ce qui est le plus approprié."
L["Remove"] = "Enlever"
L["Temporarily removes the bar and all associated messages."] = "Enlève temporairement la barre et les messages qui y sont associés."
L["Remove other"] = "Enlever les autres"
L["Temporarily removes all other bars (except this one) and associated messages."] = "Enlève temporairement toutes les autres barres et leurs messages associés."
L.disable = "Désactiver"
L["Permanently disables the boss encounter ability option that spawned this bar."] = "Désactive l'option de la rencontre de boss qui a fait apparaître cette barre."

L["Emphasize at... (seconds)"] = "Mettre en évidence à... (secondes)"
L["Scale"] = "Échelle"
L["Grow upwards"] = "Ajouter vers le haut"
L["Toggle bars grow upwards/downwards from anchor."] = "Ajoute les nouvelles barres soit en haut de l'ancre, soit en bas de l'ancre."
L["Texture"] = "Texture"
L["Emphasize"] = "Mise en évidence"
L["Enable"] = "Activer"
L["Move"] = "Déplacer"
L.moveDesc = "Déplace les barres mises en évidence vers l'ancre de mise en évidence. Si cette option est désactivée, les barres mises en évidence changeront simplement d'échelle et de couleur."
L["Regular bars"] = "Barres normales"
L["Emphasized bars"] = "Barres en évidence"
L["Align"] = "Alignement"
L["Left"] = "Gauche"
L["Center"] = "Centre"
L["Right"] = "Droite"
L["Time"] = "Temps"
L["Whether to show or hide the time left on the bars."] = "Affiche ou non le temps restant sur les barres."
L["Icon"] = "Icône"
L["Shows or hides the bar icons."] = "Affiche ou non les icônes des barres."
L.font = "Police d'écriture"
L["Restart"] = "Relancer"
L["Restarts emphasized bars so they start from the beginning and count from 10."] = "Relance les barres mises en évidence afin qu'elles commencent du début."
L["Fill"] = "Remplir"
L["Fills the bars up instead of draining them."] = "Remplit les barres au lieu de les vider."

L["Local"] = "Local"
L["%s: Timer [%s] finished."] = "%s : Minuteur [%s] terminé."
L["Custom bar '%s' started by %s user %s."] = "Barre perso '%s' lancée par l'utilisateur de %s %s."

L["Pull"] = "Pull"
L["Pulling!"] = "Pull !"
L["Pull timer started by %s user %s."] = "Délai de pull lancé par l'utilisateur de %s %s."
L["Pull in %d sec"] = "Pull dans %d sec."
L["Sending a pull timer to Big Wigs and DBM users."] = "Envoi d'un délai de pull aux utilisateurs de Big Wigs et DBM."
L["Sending custom bar '%s' to Big Wigs and DBM users."] = "Envoi d'une barre perso '%s' aux utilisateurs de Big Wigs et DBM."
L["This function requires raid leader or raid assist."] = "Cette fonction nécessite d'être le chef du raid ou un de ses assistants."
L["Must be between 1 and 60. A correct example is: /pull 5"] = "Doit être compris entre 1 et 60. Un exemple correct est le suivant : /pull 5"
L["Incorrect format. A correct example is: /raidbar 20 text"] = "Format incorrect. Un exemple correct est le suivant : /raidbar 20 texte"
L["Invalid time specified. <time> can be either a number in seconds, a M:S pair, or Mm. For example 5, 1:20 or 2m."] = "Durée spécifiée incorrecte. <durée> peut être exprimée soit avec un nombre en secondes, avec une paire M:S ou avec Mm. Par exemple 5, 1:20 ou 2m."
L["This function can't be used during an encounter."] = "Cette fonction ne peut pas être utilisée pendant une rencontre."
L["Pull timer cancelled by %s."] = "Délai de pull annulé par %s."



-- These localization strings are translated on WoWAce: http://www.wowace.com/addons/big-wigs/localization/
L["abilityName"] = "Nom de la technique"
L["abilityNameDesc"] = "Affiche ou non le nom de la technique au dessus de la fenêtre."
L["Alarm"] = "Alarme"
L["Alert"] = "Alerte"
L["Attention"] = "Attention"
L["background"] = "Arrière-plan"
L["backgroundDesc"] = "Affiche ou non l'arrière-plan."
L["bars"] = "Barres"
L["bestTimeBar"] = "Meilleur temps"
L["Beware"] = "Attention (Algalon)"
L["bossDefeatDurationPrint"] = "Défaite de '%s' au bout de %s."
L["bossStatistics"] = "Statistiques des boss"
L["bossStatsDescription"] = "Enregistrement de diverses statitistiques relatives aux boss telles que le nombre de fois qu'un boss a été vaincu, le nombre de wipes, la durée totale du combat ou la victoire la plus rapide. Ces statistiques peuvent être visionnées sur l'écran de configuration de chaque boss, mais seront cachées pour les boss qui n'ont pas encore de statistiques enregistrées."
L["bossWipeDurationPrint"] = "Wipe sur '%s' au bout de %s."
L["bwEmphasized"] = "Big Wigs en évidence"
L["chatMessages"] = "Messages de la fenêtre de discussion"
L["classColors"] = "Couleurs de classe"
L["classColorsDesc"] = "Colore les noms des joueurs selon leur classe."
L["close"] = "Fermer"
L["closeButton"] = "Bouton de fermeture"
L["closeButtonDesc"] = "Affiche ou non le bouton de fermeture."
L["closeProximityDesc"] = [=[Ferme l'affichage de proximité.
Pour le désactiver complètement, rendez-vous dans les options du boss et décochez "Proximité".]=]
L["colors"] = "Couleurs"
L["countDefeats"] = "Compter les victoires"
L["countdown"] = "Compte à rebours"
L["countdownDesc"] = "Si un minuteur relatif à une option à mettre fortement en évidence est plus long que 5 secondes, un compte à rebours visuel et vocal sera ajouté pour les 5 dernières secondes. Imaginez quelqu'un décompter \"5... 4... 3... 2... 1... COUNTDOWN!\" et de gros chiffres au milieu de votre écran."
L["countWipes"] = "Compter les échecs"
L["createTimeBar"] = "Afficher la barre 'Meilleur temps'"
L["customRange"] = "Indicateur perso. de portée"
L["customSoundDesc"] = "Joue le son personnalisé sélectionné au lieu de celui fourni par le module"
L["defaultOnly"] = "Son par défaut uniquement"
L["Destruction"] = "Destruction (Kil'jaeden)"
L["disabled"] = "Désactivé"
L["disabledDesc"] = "Désactive l'affichage de proximité pour tous les modules l'utilisant."
L["displayTime"] = "Durée d'affichage"
L["displayTimeDesc"] = "Définit pendant combien de temps un message doit rester affiché (en secondes)."
L["doubleSize"] = "Taille double"
L["doubleSizeDesc"] = "Double la taille des barres et messages relatifs à une option à mettre fortement en évidence."
L["emphasized"] = "En évidence"
L["emphasizedCountdown"] = "Compte à rebours en évidence"
L["emphasizedCountdownSinkDescription"] = "Dirige la sortie de cet addon vers l'affichage des messages de compte à rebours de Big Wigs. Cet affichage supporte le texte et les couleurs, et peut uniquement afficher un message à la fois."
L["emphasizedMessages"] = "Messages en évidence"
L["emphasizedSinkDescription"] = "Transmet la sortie de cet addon via l'affichage des messages mis en évidence de Big Wigs. Cet affichage supporte le texte et les couleurs, et ne peut afficher qu'un message à la fois."
L["enableStats"] = "Activer les statistiques"
L["fadeTime"] = "Durée d'estompe"
L["fadeTimeDesc"] = "Définit pendant combien de temps un message doit s'estomper (en secondes)."
L["FlagTaken"] = "Drapeau pris (JcJ)"
L["flash"] = "Flash"
L["fontColor"] = "Couleur de police"
L["fontSize"] = "Taille de la police"
L["icons"] = "Icônes"
L["Important"] = "Important"
L["Info"] = "Info"
L["lock"] = "Verrouiller"
L["lockDesc"] = "Verrouille l'affichage à sa place actuelle, empêchant tout déplacement ou redimensionnement."
L["Long"] = "Long"
L["messages"] = "Messages"
L["monochrome"] = "Monochrome"
L["monochromeDesc"] = "Active ou non le marqueur monochrome sur tous les messages, enlevant tout lissage des bords de la police d'écriture."
L["Neutral"] = "Neutre"
L["newBestTime"] = "Nouveau record !"
L["none"] = "Aucun"
L["normal"] = "Normal"
L["normalMessages"] = "Messages normaux"
L["outline"] = "Contour"
L["output"] = "Sortie"
L["Personal"] = "Personnel"
L["Positive"] = "Positif"
L["primary"] = "Primaire"
L["primaryDesc"] = "La première icône de cible de raid qu'un script de rencontre doit utiliser."
L["printBestTimeOption"] = "Notif. de nv record"
L["printDefeatOption"] = "Durée (victoire)"
L["printWipeOption"] = "Durée (échec)"
L["proximity"] = "Affichage de proximité"
L["proximity_desc"] = "Affiche la fenêtre de proximité quand cela est approprié pour cette rencontre, indiquant la liste des joueurs qui se trouvent trop près de vous."
L["proximityTitle"] = "%d m / %d |4joueur:joueurs;"
L["raidIconsDescription"] = [=[Certaines rencontres peuvent comporter des éléments tels que les techniques de type 'bombe' qui affectent un joueur spécifique, un joueur poursuivi ou bien encore un joueur spécifique important pour d'autres raisons. Vous pouvez personnaliser ici les icônes de raid qui seront utilisées pour marquer ces joueurs.

Si une rencontre ne comporte qu'une technique qui requiert de marquer quelqu'un, seule l'icône primaire sera utilisée. Une icône ne sera jamais utilisée pour deux techniques différentes de la même rencontre, et chaque technique utilisera toujours la même icône la prochaine fois qu'elle se produira.

|cffff4411Notez que si un joueur a déjà été marqué manuellement, Big Wigs ne changera jamais son icône.|r]=]
L["recordBestTime"] = "Se souvenir des meilleurs temps"
L["reset"] = "Réinit."
L["resetAll"] = "Tt réinit."
L["resetAllCustomSound"] = "Si vous avez des sons personnalisés pour certains paramètres des rencontres de boss, ce bouton les réinitialisera TOUS afin que les sons par défaut soient utilisés à la place."
L["resetAllDesc"] = "Si vous avez des couleurs personnalisées dans les paramètres des rencontres de boss, ce bouton les réinitialisera TOUTES et les couleurs définies ici seront utilisées à la place."
L["resetDesc"] = "Réinitialise les couleurs ci-dessus à leurs valeurs par défaut."
L["RunAway"] = "Cours petite fille, cours (Le Grand Méchant Loup)"
L["secondary"] = "Secondaire"
L["secondaryDesc"] = "La seconde icône de cible de raid qu'un script de rencontre doit utiliser."
L["showHide"] = "Afficher/cacher"
L["sinkDescription"] = "Transmet la sortie de cet addon via l'affichage des messages de Big Wigs. Cet affichage supporte les icônes, les couleurs et peut afficher jusqu'à 4 messages à l'écran en même temps. Les messages récemment insérés grandiront et reviendront rapidement à leur taille initiale afin de bien capter l'attention du joueur."
L["sound"] = "Son"
L["soundButton"] = "Bouton du son"
L["soundButtonDesc"] = "Affiche ou non le bouton du son."
L["soundDefaultDescription"] = "Si ceci est coché, Big Wigs utilisera uniquement le son de l'Avertissement raid de Blizzard pour les messages accompagnés d'un son. Notez que seuls certains messages des scripts de rencontre déclencheront une alerte sonore."
L["soundDelay"] = "Délai du son"
L["soundDelayDesc"] = "Spécifie combien de temps Big Wigs doit attendre entre chaque répétition du son indiquant qu'au moins une personne est trop proche de vous."
L["Sounds"] = "Sons"
L["superEmphasize"] = "Super mise en évidence"
L["superEmphasizeDesc"] = [=[Ce module met fortement en évidence les barres ou messages relatifs à une technique de rencontre de boss.

Vous pouvez définir ici exactement ce qui doit arriver quand vous cochez une option de super mise en évidence dans la section avancée d'une technique de rencontre de boss.

|cffff4411Notez que la super mise en évidence est désactivée par défaut pour toutes les techniques.|r
]=]
L["text"] = "Texte"
L["textShadow"] = "Ombre du texte"
L["thick"] = "Mince"
L["thin"] = "Épais"
L["title"] = "Titre"
L["titleDesc"] = "Affiche ou non le titre."
L["toggleProximityPrint"] = "L'affichage de proximité sera affiché la prochaine fois. Pour le désactiver complètement, rendez-vous dans les options du boss et décochez \"Proximité\"."
L["toggleSound"] = "Son"
L["toggleSoundDesc"] = "Fait ou non bipper la fenêtre de proximité quand vous êtes trop près d'un autre joueur."
L["tooltip"] = "Bulle d'aide"
L["tooltipDesc"] = "Affiche ou non la bulle d'aide du sort si l'affichage de proximité est actuellement directement lié avec une technique de rencontre de boss."
L["uppercase"] = "MAJUSCULE"
L["uppercaseDesc"] = "Met entièrement en majuscules tous les messages relatifs à une option à mettre fortement en évidence."
L["Urgent"] = "Urgent"
L["useColors"] = "Utiliser des couleurs"
L["useColorsDesc"] = "Utilise ou non des couleurs dans les messages à la place du blanc unique."
L["useIcons"] = "Utiliser les icônes"
L["useIconsDesc"] = "Affiche les icônes à côté des messages."
L["Victory"] = "Victoire"
L["Warning"] = "Avertissement"



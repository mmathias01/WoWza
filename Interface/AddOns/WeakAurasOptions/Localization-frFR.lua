if not(GetLocale() == "frFR") then
    return;
end

local L = WeakAuras.L

-- Options translation
L["1 Match"] = "1 Correspondance" -- Needs review
L["Actions"] = "Actions"
L["Activate when the given aura(s) |cFFFF0000can't|r be found"] = "Activer quand l'aura |cFFFF0000ne peut|r être trouvée" -- Needs review
L["Add a new display"] = "Ajouter un nouveau graphique"
L["Add Dynamic Text"] = "Ajouter du texte dynamique"
L["Addon"] = "Addon" -- Needs review
L["Addons"] = "Addons" -- Needs review
L["Add to group %s"] = "Ajouter au groupe %s"
L["Add to new Dynamic Group"] = "Ajouter à un nouveau groupe dynamique" -- Needs review
L["Add to new Group"] = "Ajouter à un nouveau groupe" -- Needs review
L["Add Trigger"] = "Ajouter un déclencheur"
L["A group that dynamically controls the positioning of its children"] = "Un groupe qui contrôle dynamiquement le positionnement de ses enfants"
L["Align"] = "Aligner"
L["Allow Full Rotation"] = "Permettre une rotation complète" -- Needs review
L["Alpha"] = "Alpha"
L["Anchor"] = "Ancrage"
L["Anchor Point"] = "Point d'ancrage"
L["Angle"] = "Angle"
L["Animate"] = "Animer" -- Needs review
L["Animated Expand and Collapse"] = "Expansion et réduction animés" -- Needs review
L["Animation relative duration description"] = [=[
La durée de l'animation par rapport à la durée du graphique, exprimée en fraction (1/2), pourcentage (50%), ou décimal (0.5).
|cFFFF0000Note :|r si un graphique n'a pas de progression (déclencheur d'événement sans durée définie, aura sans durée, etc), l'animation ne jouera pas.

|cFF4444FFPar exemple :|r
Si la durée de l'animation est définie à |cFF00CC0010%|r, et le déclencheur du graphique est une amélioration qui dure 20 secondes, l'animation de début jouera pendant 2 secondes.
Si la durée de l'animation est définie à |cFF00CC0010%|r, et le déclencheur du graphique n'a pas de durée définie, aucune d'animation de début ne jouera (mais elle jouerait si vous aviez spécifié une durée en secondes).
]=] -- Needs review
L["Animations"] = "Animations"
L["Animation Sequence"] = "Séquence d'animation" -- Needs review
L["Aquatic"] = "Aquatique"
L["Aura (Paladin)"] = "Aura (Paladin)"
L["Aura(s)"] = "Aura(s)"
L["Auto"] = "Auto"
L["Auto-cloning enabled"] = "Auto-clonage activé" -- Needs review
L["Automatic Icon"] = "Icône automatique" -- Needs review
L["Backdrop Color"] = "Couleur de Fond" -- Needs review
L["Backdrop Style"] = "Style de Fond" -- Needs review
L["Background"] = "Arrière-plan" -- Needs review
L["Background Color"] = "Couleur de fond"
L["Background Inset"] = "Encart d'arrière-plan" -- Needs review
L["Background Offset"] = "Décalage du Fond " -- Needs review
L["Background Texture"] = "Texture du Fond" -- Needs review
L["Bar Alpha"] = "Alpha de la Barre" -- Needs review
L["Bar Color"] = "Couleur de barre" -- Needs review
L["Bar Color Settings"] = "Réglages Couleur de Barre" -- Needs review
L["Bar in Front"] = "Barre devant" -- Needs review
L["Bar Texture"] = "Texture de barre" -- Needs review
L["Battle"] = "Combat" -- Needs review
L["Bear"] = "Ours" -- Needs review
L["Berserker"] = "Berserker" -- Needs review
L["Blend Mode"] = "Mode du fusion" -- Needs review
L["Blood"] = "Sang"
L["Border"] = "Bordure" -- Needs review
L["Border Color"] = "Couleur de Bordure" -- Needs review
L["Border Inset"] = "Encart Fond" -- Needs review
L["Border Offset"] = "Décalage Bordure" -- Needs review
L["Border Settings"] = "Réglages de Bordure" -- Needs review
L["Border Size"] = "Taille de Bordure" -- Needs review
L["Border Style"] = "Style de Bordure" -- Needs review
L["Bottom Text"] = "Texte du bas" -- Needs review
L["Button Glow"] = "Bouton allumé" -- Needs review
L["Can be a name or a UID (e.g., party1). Only works on friendly players in your group."] = "Peut être un nom ou un UID (par ex. party1). Fonctionne uniquement pour les joueurs amicaux de votre groupe." -- Needs review
L["Cancel"] = "Annuler" -- Needs review
L["Cat"] = "Chat"
L["Change the name of this display"] = "Changer le nom de ce graphique" -- Needs review
L["Channel Number"] = "Numéro de canal" -- Needs review
L["Check On..."] = "Vérifier sur..." -- Needs review
L["Choose"] = "Choisir" -- Needs review
L["Choose Trigger"] = "Choisir un déclencheur" -- Needs review
L["Choose whether the displayed icon is automatic or defined manually"] = "Choisir si l'icône affichée est automatique ou définie manuellement"
L["Clone option enabled dialog"] = [=[
Vous avez activé une option qui utilise l'|cFFFF0000Auto-clonage|r.

L'|cFFFF0000Auto-clonage|r permet à un graphique d'être automatiquement dupliqué pour afficher plusieurs sources d'information.
A moins que vous mettiez ce graphique dans un |cFF22AA22Groupe Dynamique|r, tous les clones seront affichés en tas l'un sur l'autre.

Souhaitez-vous que ce graphiques soit placé dans un nouveau |cFF22AA22Groupe Dynamique|r ?]=] -- Needs review
L["Close"] = "Fermer" -- Needs review
L["Collapse"] = "Réduire" -- Needs review
L["Collapse all loaded displays"] = "Réduire tous les graphiques chargés"
L["Collapse all non-loaded displays"] = "Réduire tous les graphiques non-chargés" -- Needs review
L["Color"] = "Couleur" -- Needs review
L["Compress"] = "Compresser" -- Needs review
L["Concentration"] = "Concentration" -- Needs review
L["Constant Factor"] = "Facteur constant" -- Needs review
L["Control-click to select multiple displays"] = "Contrôle-Clic pour sélectionner plusieurs graphiques" -- Needs review
L["Controls the positioning and configuration of multiple displays at the same time"] = "Contrôle la position et la configuration de plusieurs graphiques en même temps" -- Needs review
L["Convert to..."] = "Convertir en..." -- Needs review
L["Cooldown"] = "Recharge" -- Needs review
L["Copy"] = "Copier" -- Needs review
L["Copy settings from..."] = "Copier les réglages de..." -- Needs review
L["Copy settings from another display"] = "Copier les réglages d'un autre graphique" -- Needs review
L["Copy settings from %s"] = "Copier les réglages de %s" -- Needs review
L["Count"] = "Compte"
L["Creating buttons: "] = "Création de boutons :" -- Needs review
L["Creating options: "] = "Création d'options :" -- Needs review
L["Crop X"] = "Couper X" -- Needs review
L["Crop Y"] = "Couper Y" -- Needs review
L["Crusader"] = "Croisé" -- Needs review
L["Custom Code"] = "Code personnalisé" -- Needs review
L["Custom Trigger"] = "Déclencheur personnalisé" -- Needs review
L["Custom trigger event tooltip"] = [=[
Choisissez quels évènements peuvent activer le déclencheur.
Plusieurs évènements peuvent être spécifiés avec des virgules ou des espaces.

|cFF4444FFPar exemple:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=] -- Needs review
L["Custom trigger status tooltip"] = [=[
Choisissez quels évènements peuvent activer le déclencheur.
Comme c'est un déclencheur de type statut, les évènements spécifiés peuvent être appelés par WeakAuras sans les arguments attendus.
Plusieurs évènements peuvent être spécifiés avec des virgules ou des espaces.

|cFF4444FFPar exemple:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=] -- Needs review
L["Custom Untrigger"] = "Désactivation personnalisée" -- Needs review
L["Custom untrigger event tooltip"] = [=[
Choisissez quels évènements peuvent causer la désactivation.
Cela peut être des évènements différents de ceux du déclencheur.
Plusieurs évènements peuvent être spécifiés avec des virgules ou des espaces.

|cFF4444FFPar exemple:|r
UNIT_POWER, UNIT_AURA PLAYER_TARGET_CHANGED
]=] -- Needs review
L["Death"] = "Mort" -- Needs review
L["Death Rune"] = "Rune de Mort" -- Needs review
L["Debuff Type"] = "Type d'affaiblissement" -- Needs review
L["Defensive"] = "Défensif" -- Needs review
L["Delete"] = "Supprimer" -- Needs review
L["Delete all"] = "Supprimer tout" -- Needs review
L["Delete children and group"] = "Supprimer enfants et groupe" -- Needs review
L["Deletes this display - |cFF8080FFShift|r must be held down while clicking"] = "Supprime ce graphique - |cFF8080FFMaj|r doit être maintenu en cliquant" -- Needs review
L["Delete Trigger"] = "Supprimer le déclencheur" -- Needs review
L["Desaturate"] = "Dé-saturer" -- Needs review
L["Devotion"] = "Dévotion" -- Needs review
L["Disabled"] = "Désactivé" -- Needs review
L["Discrete Rotation"] = "Rotation individuelle" -- Needs review
L["Display"] = "Graphique" -- Needs review
L["Display Icon"] = "Icône du graphique" -- Needs review
L["Display Text"] = "Texte du graphique" -- Needs review
L["Distribute Horizontally"] = "Distribuer horizontalement" -- Needs review
L["Distribute Vertically"] = "Distribuer verticalement" -- Needs review
L["Do not copy any settings"] = "Ne copier aucun réglage" -- Needs review
L["Do not group this display"] = "Ne pas grouper ce graphique" -- Needs review
L["Duplicate"] = "Dupliquer" -- Needs review
L["Duration Info"] = "Info de durée" -- Needs review
L["Duration (s)"] = "Durée (s)" -- Needs review
L["Dynamic Group"] = "Groupe Dynamique" -- Needs review
L["Dynamic text tooltip"] = [=[
Il y a plusieurs codes spéciaux disponibles pour rendre ce texte dynamique :

|cFFFF0000%p|r - Progression - Le temps restant sur un compteur, ou une valeur autre
|cFFFF0000%t|r - Total - La durée maximum d'un compteur, ou le maximum d'une valeur autre
|cFFFF0000%n|r - Nom - Le nom du graphique (souvent le nom d'une aura), ou l'ID du graphique s'il n'y a pas de nom dynamique
|cFFFF0000%i|r - Icône - L'icône associée à l'affichage
|cFFFF0000%s|r - Pile - La taille de la pile d'une aura (généralement)
|cFFFF0000%c|r - Personnalisé - Vous permet de définir une fonction Lua personnalisée qui donne un texte à afficher]=] -- Needs review
L["Enabled"] = "Activé" -- Needs review
L["Enter an aura name, partial aura name, or spell id"] = "Entrez un nom d'aura, nom d'aura partiel ou ID de sort" -- Needs review
L["Event Type"] = "Type d'évènement" -- Needs review
L["Expand"] = "Agrandir" -- Needs review
L["Expand all loaded displays"] = "Agrandir tous graphiques chargés" -- Needs review
L["Expand all non-loaded displays"] = "Agrandir tous graphiques non-chargés" -- Needs review
L["Expand Text Editor"] = "Agrandir éditeur de texte" -- Needs review
L["Expansion is disabled because this group has no children"] = "Agrandissement désactivé car ce groupe n'a pas d'enfants" -- Needs review
L["Export"] = "Exporter" -- Needs review
L["Export to Lua table..."] = "Exporter une table Lua..." -- Needs review
L["Export to string..."] = "Exporter en texte..." -- Needs review
L["Fade"] = "Fondu" -- Needs review
L["Finish"] = "Finir" -- Needs review
L["Fire Resistance"] = "Résistance au Feu" -- Needs review
L["Flight(Non-Feral)"] = "Vol(non-Féral)" -- Needs review
L["Font"] = "Police" -- Needs review
L["Font Flags"] = "Style de Police" -- Needs review
L["Font Size"] = "Taille de Police" -- Needs review
L["Font Type"] = "Type de police" -- Needs review
L["Foreground Color"] = "Couleur premier-plan" -- Needs review
L["Foreground Texture"] = "Texture premier-plan" -- Needs review
L["Form (Druid)"] = "Forme (Druide)" -- Needs review
L["Form (Priest)"] = "Forme (Prêtre)" -- Needs review
L["Form (Shaman)"] = "Forme (Chaman)" -- Needs review
L["Form (Warlock)"] = "Forme (Démoniste)" -- Needs review
L["Frame"] = "Cadre" -- Needs review
L["Frame Strata"] = "Strate du cadre" -- Needs review
L["Frost"] = "Givre" -- Needs review
L["Frost Resistance"] = "Résistance au Givre" -- Needs review
L["Full Scan"] = "Scan Complet" -- Needs review
L["Ghost Wolf"] = "Loup fantôme" -- Needs review
L["Glow Action"] = "Action de l'éclat" -- Needs review
L["Group aura count description"] = [=[Le nombre de membres du %s qui doivent être affectés par une ou plus des auras désignées pour que le graphique soit déclenché.
Si le nombre entré est un entier (par ex. 5), le nombre de membres du raid affectés sera comparé au nombre entré.
Si le nombre entré est decimal (par ex. 0.5), une fraction (par ex. 1/2), ou un pourcentage (par ex. 50%%), alors cette fraction du %s doit être affecté.

|cFF4444FFPar exemple :|r
|cFF00CC00> 0|r le déclenchera quand n'importe qui du %s est affecté
|cFF00CC00= 100%%|r le déclenchera quand tout le monde dans le %s est affecté
|cFF00CC00!= 2|r le déclenchera quand le nombre de membres du %s affectés est différent de 2
|cFF00CC00<= 0.8|r le déclenchera quand quand moins de 80%% du %s est affecté (4 sur 5 membres du groupe, 8 sur 10 ou 20 sur 25 du raid )
|cFF00CC00> 1/2|r le déclenchera quand plus de la moitié du %s est affecté
|cFF00CC00>= 0|r le déclenchera toujours, quoi qu'il arrive
]=] -- Needs review
L["Group Member Count"] = "Nombre de membres du groupe"
L["Group (verb)"] = "Grouper" -- Needs review
L["Height"] = "Hauteur" -- Needs review
L["Hide this group's children"] = "Cacher les enfants de ce groupe" -- Needs review
L["Hide When Not In Group"] = "Cacher hors d'un groupe" -- Needs review
L["Horizontal Align"] = "Aligner horizontalement" -- Needs review
L["Icon Info"] = "Info d'icône" -- Needs review
L["Ignored"] = "Ignoré" -- Needs review
L["Ignore GCD"] = "Ignorer Recharge Globale" -- Needs review
L["%i Matches"] = "%i Correspondances" -- Needs review
L["Import"] = "Importer" -- Needs review
L["Import a display from an encoded string"] = "Importer un graphique d'un texte encodé" -- Needs review
L["Justify"] = "Justification" -- Needs review
L["Left Text"] = "Texte de gauche" -- Needs review
L["Load"] = "Charger" -- Needs review
L["Loaded"] = "Chargé" -- Needs review
L["Main"] = "Principal" -- Needs review
L["Main Trigger"] = "Déclencheur principal" -- Needs review
L["Mana (%)"] = "Mana (%)" -- Needs review
L["Manage displays defined by Addons"] = "Gérer graphiques définis par addons" -- Needs review
L["Message Prefix"] = "Préfixe du message" -- Needs review
L["Message Suffix"] = "Suffixe du message" -- Needs review
L["Metamorphosis"] = "Métamorphose" -- Needs review
L["Mirror"] = "Miroir" -- Needs review
L["Model"] = "Modèle" -- Needs review
L["Moonkin/Tree/Flight(Feral)"] = "Sélénien/Arbre/Vol(Farouche)" -- Needs review
L["Move Down"] = "Descendre" -- Needs review
L["Move this display down in its group's order"] = "Descend ce graphique dans l'ordre de son groupe" -- Needs review
L["Move this display up in its group's order"] = "Monte ce graphique dans l'ordre de son groupe" -- Needs review
L["Move Up"] = "Monter" -- Needs review
L["Multiple Displays"] = "Graphiques multiples" -- Needs review
L["Multiple Triggers"] = "Déclencheur multiples" -- Needs review
L["Multiselect ignored tooltip"] = [=[
|cFFFF0000Ignoré|r - |cFF777777Unique|r - |cFF777777Multiple|r
Cette option ne sera pas utilisée pour déterminer quand ce graphique doit être chargé]=]
L["Multiselect multiple tooltip"] = [=[
|cFF777777Ignoré|r - |cFF777777Unique|r - |cFF00FF00Multiple|r
Plusieurs valeurs peuvent être choisies]=]
L["Multiselect single tooltip"] = [=[
|cFF777777Ignoré|r - |cFF00FF00Unique|r - |cFF777777Multiple|r
Seule une unique valeur peut être choisie]=]
L["Must be spelled correctly!"] = "Doit être épelé correctement !"
L["Name Info"] = "Info du nom"
L["Negator"] = "Pas" -- Needs review
L["New"] = "Nouveau"
L["Next"] = "Suivant"
L["No"] = "Non"
L["No Children"] = "Pas d'enfant"
L["Not all children have the same value for this option"] = "Tous les enfants n'ont pas la même valeur pour cette option" -- Needs review
L["Not Loaded"] = "Non chargé" -- Needs review
L["No tooltip text"] = "Pas d'infobulle" -- Needs review
L["% of Progress"] = "% de progression"
L["Okay"] = "Okay" -- Needs review
L["On Hide"] = "Au masquage" -- Needs review
L["Only match auras cast by people other than the player"] = "Ne considérer que les auras lancées par d'autres que le joueur" -- Needs review
L["Only match auras cast by the player"] = "Ne considérer que les auras lancées par le joueur" -- Needs review
L["On Show"] = "A l'affichage" -- Needs review
L["Operator"] = "Opérateur" -- Needs review
L["or"] = "ou" -- Needs review
L["Orientation"] = "Orientation" -- Needs review
L["Other"] = "Autre" -- Needs review
L["Outline"] = "Contour" -- Needs review
L["Own Only"] = "Le mien uniquement" -- Needs review
L["Player Character"] = "Personnage Joueur" -- Needs review
L["Play Sound"] = "Jouer un son" -- Needs review
L["Presence (DK)"] = "Présence" -- Needs review
L["Presence (Rogue)"] = "Présence" -- Needs review
L["Prevents duration information from decreasing when an aura refreshes. May cause problems if used with multiple auras with different durations."] = "Empêche l'info de durée de décroitre quand une aura est rafraichie. Peut causer des problèmes si utilisé avec plusieurs auras de différentes durées." -- Needs review
L["Primary"] = "Primaire" -- Needs review
L["Progress Bar"] = "Barre de progression" -- Needs review
L["Progress Texture"] = "Texture de progression" -- Needs review
L["Put this display in a group"] = "Mettre ce graphique dans un groupe" -- Needs review
L["Ready For Use"] = "Prêt à l'emploi" -- Needs review
L["Re-center X"] = "Recentrer X" -- Needs review
L["Re-center Y"] = "Recentrer Y" -- Needs review
L["Remaining Time Precision"] = "Précision du temps restant" -- Needs review
L["Remove this display from its group"] = "Retirer ce graphique de son groupe" -- Needs review
L["Rename"] = "Renommer" -- Needs review
L["Requesting display information"] = "Demande d'info de graphique à %s..." -- Needs review
L["Required For Activation"] = "Requis pour l'activation" -- Needs review
L["Retribution"] = "Vindicte" -- Needs review
L["Right-click for more options"] = "Clic-droit pour plus d'options" -- Needs review
L["Right Text"] = "Texte de droite" -- Needs review
L["Rotate"] = "Tourner" -- Needs review
L["Rotate In"] = "Rotation entrante" -- Needs review
L["Rotate Out"] = "Rotation sortante" -- Needs review
L["Rotate Text"] = "Tourner le texte" -- Needs review
L["Rotation"] = "Rotation" -- Needs review
L["Same"] = "Le même" -- Needs review
L["Search"] = "Chrecher" -- Needs review
L["Secondary"] = "Secondaire" -- Needs review
L["Send To"] = "Envoyer vers" -- Needs review
L["Set tooltip description"] = "Définir description d'infobulle" -- Needs review
L["Shadow Dance"] = "Danse de l'ombre" -- Needs review
L["Shadowform"] = "Forme d'Ombre" -- Needs review
L["Shadow Resistance"] = "Résistance à l'Ombre" -- Needs review
L["Shift-click to create chat link"] = "Maj-Clic pour créer un |cFF8800FF[Lien]" -- Needs review
L["Show all matches (Auto-clone)"] = "Montrer toutes correspondances (Auto-Clone)" -- Needs review
L["Show players that are |cFFFF0000not affected"] = "Montrer les joueurs |cFFFF0000non-affectés" -- Needs review
L["Shows a 3D model from the game files"] = "Montre un modèle 3D tiré du jeu" -- Needs review
L["Shows a custom texture"] = "Montre une texture personnalisée" -- Needs review
L["Shows a progress bar with name, timer, and icon"] = "Affiche une barre de progression avec nom, temps, icône" -- Needs review
L["Shows a spell icon with an optional a cooldown overlay"] = "Affiche une icône de sort avec optionnellement la recharge sur-imprimée" -- Needs review
L["Shows a texture that changes based on duration"] = "Affiche une texture qui change selon la durée" -- Needs review
L["Shows one or more lines of text, which can include dynamic information such as progress or stacks"] = "Affiche une ligne de texte ou plus, qui peut inclure des infos dynamiques telles que progression ou piles." -- Needs review
L["Shows the remaining or expended time for an aura or timed event"] = "Affiche le temps restant ou étendu d'une aura ou évènement" -- Needs review
L["Show this group's children"] = "Montrer les enfants de ce groupe" -- Needs review
L["Size"] = "Taille" -- Needs review
L["Slide"] = "Glisser" -- Needs review
L["Slide In"] = "Glisser entrant" -- Needs review
L["Slide Out"] = "Glisser sortant" -- Needs review
L["Sort"] = "Trier" -- Needs review
L["Sound"] = "Son"
L["Sound Channel"] = "Canal sonore" -- Needs review
L["Sound File Path"] = "Chemin fichier son" -- Needs review
L["Space"] = "Espacer" -- Needs review
L["Space Horizontally"] = "Espacer horizontalement" -- Needs review
L["Space Vertically"] = "Espacer verticalement" -- Needs review
L["Spell ID"] = "ID de sort" -- Needs review
L["Spell ID dialog"] = [=[
vous avez spécifié une aura par |cFFFF0000ID de sort|r.

Par défaut, |cFF8800FFWeakAuras|r ne peut distinguer entre des auras de même nom mais d'|cFFFF0000ID de sort|r différents.
Cependant, si l'option Scan Complet est activée, |cFF8800FFWeakAuras|r peut chercher des |cFFFF0000ID de sorts|r.

Voulez-vous activer le Scan Complet pour chercher cet |cFFFF0000ID de sort|r ?]=] -- Needs review
L["Stack Count"] = "Nombre de Piles"
L["Stack Count Position"] = "Position Nombre de Piles"
L["Stack Info"] = "Info de Piles" -- Needs review
L["Stacks Settings"] = "Réglages de Piles" -- Needs review
L["Stagger"] = "Report" -- Needs review
L["Stance (Warrior)"] = "Posture" -- Needs review
L["Start"] = "Début" -- Needs review
L["Stealable"] = "Volable" -- Needs review
L["Stealthed"] = "Furtif" -- Needs review
L["Sticky Duration"] = "Durée épinglée" -- Needs review
L["Temporary Group"] = "Groupe temporaire" -- Needs review
L["Text"] = "Texte" -- Needs review
L["Text Color"] = "Couleur Texte" -- Needs review
L["Text Position"] = "Position Texte" -- Needs review
L["Text Settings"] = "Réglages de Texte" -- Needs review
L["Texture"] = "Texture" -- Needs review
L["The children of this group have different display types, so their display options cannot be set as a group."] = "Les enfants de ce groupe ont différent types de graphiques, leurs options de graphique ne peuvent donc pas être changées en groupe." -- Needs review
L["The duration of the animation in seconds."] = "La durée de l'animation en secondes." -- Needs review
L["The type of trigger"] = "Le type de déclencheur" -- Needs review
L["This condition will not be tested"] = "Cette condition ne sera pas évaluée" -- Needs review
L["This display is currently loaded"] = "Ce graphique est actuellement chargé" -- Needs review
L["This display is not currently loaded"] = "Ce graphique n'est pas actuellement chargé" -- Needs review
L["This display will only show when |cFF00FF00%s"] = "Ce graphique ne s'affichera que quand |cFF00FF00%s" -- Needs review
L["This display will only show when |cFFFF0000 Not %s"] = "Ce graphique ne s'affichera que quand |cFFFF0000 Pas %s" -- Needs review
L["This region of type \"%s\" has no configuration options."] = "Cette région de type \"%s\" n'a pas d'options de configuration." -- Needs review
L["Time in"] = "Temps entrant" -- Needs review
L["Timer"] = "Chrono" -- Needs review
L["Timer Settings"] = "Réglages de Chrono" -- Needs review
L["Toggle the visibility of all loaded displays"] = "Change la visibilité de tous les graphiques chargés" -- Needs review
L["Toggle the visibility of all non-loaded displays"] = "Change la visibilité de tous les graphiques non-chargés" -- Needs review
L["Toggle the visibility of this display"] = "Change la visibilité de ce graphique" -- Needs review
L["to group's"] = "au groupe..." -- Needs review
L["Tooltip"] = "Infobulle" -- Needs review
L["Tooltip on Mouseover"] = "Infobulle à la souris" -- Needs review
L["Top Text"] = "Texte du Haut" -- Needs review
L["to screen's"] = "à l'écran..." -- Needs review
L["Total Time Precision"] = "Précision Temps total" -- Needs review
L["Tracking"] = "Suivi" -- Needs review
L["Travel"] = "Voyage"
L["Trigger"] = "Déclencheur" -- Needs review
L["Trigger %d"] = "Déclencheur %d" -- Needs review
L["Triggers"] = "Déclencheurs" -- Needs review
L["Type"] = "Type" -- Needs review
L["Ungroup"] = "Dégrouper" -- Needs review
L["Unholy"] = "Impie"
L["Unit Exists"] = "L'unité existe" -- Needs review
L["Unlike the start or finish animations, the main animation will loop over and over until the display is hidden."] = "Contrairement aux animations de début et de fin, l'animation principale bouclera tant que le graphique est visible." -- Needs review
L["Unstealthed"] = "Fin de furtivité" -- Needs review
L["Update Custom Text On..."] = "Mettre à jour Texte Perso sur..." -- Needs review
L["Use Full Scan (High CPU)"] = "Utiliser Scan Complet (CPU élevé)"
L["Use tooltip \"size\" instead of stacks"] = "Utiliser la \"taille\" de l'infobulle plutôt que la pile" -- Needs review
L["Vertical Align"] = "Aligner verticalement" -- Needs review
L["View"] = "Vue" -- Needs review
L["Width"] = "Largeur" -- Needs review
L["X Offset"] = "Décalage X" -- Needs review
L["X Scale"] = "Echelle X" -- Needs review
L["Yes"] = "Oui" -- Needs review
L["Y Offset"] = "Décalage Y" -- Needs review
L["Y Scale"] = "Echelle Y" -- Needs review
L["Z Offset"] = "Décalage Z" -- Needs review
L["Zoom"] = "Zoom" -- Needs review
L["Zoom In"] = "Zoom entrant" -- Needs review
L["Zoom Out"] = "Zoom sortant" -- Needs review




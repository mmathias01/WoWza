if not(GetLocale() == "frFR") then
    return;
end

local L = WeakAuras.L

-- Options translation
L["Actions and Animations: 1/7"] = "Actions et Animations: 1/7" -- Needs review
L["Actions and Animations: 2/7"] = "Actions et Animations: 2/7" -- Needs review
L["Actions and Animations: 3/7"] = "Actions et Animations: 3/7" -- Needs review
L["Actions and Animations: 4/7"] = "Actions et Animations: 4/7" -- Needs review
L["Actions and Animations: 5/7"] = "Actions et Animations: 5/7" -- Needs review
L["Actions and Animations: 6/7"] = "Actions et Animations: 6/7" -- Needs review
L["Actions and Animations: 7/7"] = "Actions et Animations: 7/7" -- Needs review
L["Actions and Animations Text"] = [=[Pour tester votre animation, vous devrez cacher votre graphique et l'afficher à nouveau. Cela peut être fait avec le bouton Vue du graphique sur la barre latérale.

Cliquez le quelques fois pour voir votre animation de début.]=] -- Needs review
L["Activation Settings: 1/5"] = "Réglages d'activation : 1/5" -- Needs review
L["Activation Settings: 2/5"] = "Réglages d'activation : 2/5"
L["Activation Settings: 3/5"] = "Réglages d'activation : 3/5"
L["Activation Settings: 4/5"] = "Réglages d'activation : 4/5"
L["Activation Settings: 5/5"] = "Réglages d'activation : 5/5"
L["Activation Settings Text"] = "Comme vous êtes un %s, vous pouvez activer l'option de Classe du Joueur et choisir %s." -- Needs review
L["Auto-cloning: 1/10"] = "Auto-clonage : 1/10"
L["Auto-cloning 1/10 Text"] = [=[La plus grande nouveauté de la version |cFF8800FF1.4|r est l'|cFFFF0000auto-clonage|r. L'|cFFFF0000auto-clonage|r permet à vos graphiques de se dupliquer automatiquement pour montrer plusieurs sources d'information. Placés dans un Groupe Dynamique, cela vous permet de créer de grands ensembles d'information dynamiques.

Il y a trois types de déclencheurs qui supportent l'|cFFFF0000auto-clonage|r : Auras Scan Complet, Auras de Groupe, et Auras Multi-cibles.]=] -- Needs review
L["Beginners Finished Text"] = [=[C'est tout pour le Guide du Débutant. Cependant, vous avez à peine touché la surface de la puissance de |cFF8800FFWeakAuras|r.

Dans le futur, |cFFFFFF00Plus de|r |cFFFF7F00Didactitiels|r |cFFFF0000Avancés|r seront publiés pour vous guider plus profondément dans les possibilités sans fin de |cFF8800FFWeakAuras|r.]=]
L["Beginners Guide Desc"] = "Guide du Débutant"
L["Beginners Guide Desc Text"] = "Un guide détaillant les options de configuration basiques de WeakAuras"
L["Create a Display: 1/5"] = "Créer un Graphique : 1/5" -- Needs review
L["Create a Display: 2/5"] = "Créer un Graphique : 2/5" -- Needs review
L["Create a Display: 3/5"] = "Créer un Graphique : 3/5" -- Needs review
L["Create a Display: 4/5"] = "Créer un Graphique : 4/5" -- Needs review
L["Create a Display: 5/5"] = "Créer un Graphique : 5/5" -- Needs review
L["Create a Display Text"] = [=[Bien que l'onglet Graphique ait des curseurs pour contrôler Largeur, Hauteur, et position X et Y, il y a une façon plus simple de positionner et dimensionner votre graphique.

Vous pouvez simplement cliquer sur le graphique pour le déplacer n'importe où à l'écran, et tirer sur les coins pour changer sa taille.

Vous pouvez aussi maintenir Maj pour cacher le cadre de déplacement/dimensionnement, pour un placement plus précis.]=]
L["Display Options: 1/4"] = "Options de Graphique : 1/4" -- Needs review
L["Display Options 1/4 Text"] = "Maintenant, sélectionnez un graphique type Barre de progression (ou créez un nouveau)." -- Needs review
L["Display Options: 2/4"] = "Options de Graphique : 2/4" -- Needs review
L["Display Options 2/4 Text"] = [=[Les graphiques |cFFFFFFFFBarre de progression|r et |cFFFFFFFFIcône|r ont désormais une option pour afficher une infobulle au passage de la souris.

Cette option est uniquement disponible si votre graphique est déclenché par une aura, un objet, ou un sort.]=] -- Needs review
L["Display Options: 4/4"] = "Options de Graphique : 4/4" -- Needs review
L["Display Options 4/4 Text"] = "Finalement, un nouveau type de graphique, |cFFFFFFFFModèle|r, permet d'utiliser n'importe quel modèle 3D tiré du jeu." -- Needs review
L["Dynamic Group Options: 2/4"] = "Options de Groupe Dynamique : 2/4"
L["Dynamic Group Options 2/4 Text"] = [=[La plus grande amélioration des |cFFFFFFFFGroupes Dynamiques|rs est une nouvelle option pour la Croissance.

Sélectionnez \"Circulaire\" pour le voir en action.]=] -- Needs review
L["Dynamic Group Options: 3/4"] = "Options de Groupe Dynamique : 3/4"
L["Dynamic Group Options 3/4 Text"] = [=[L'option Facteur Constant vous permet de contrôler comment votre groupe circulaire grandi.

Un groupe circulaire avec un espacement constant grandit en rayon quand des graphiques sont ajoutés, tandis qu'avec un rayon constant vos graphiques se rapprocheront quand on en ajoute.]=] -- Needs review
L["Dynamic Group Options: 4/4"] = "Options de Groupe Dynamique : 4/4"
L["Dynamic Group Options 4/4 Text"] = [=[Les Groupes Dynamiques peuvent désormais automatiquement trier leurs enfants selon leur temps restant.

Les graphiques n'ayant pas de temps restant sont placés en haut ou en bas, selon si vous choisissez \"Croissant\" ou \"Décroissant\".]=] -- Needs review
L["Finished"] = "Terminé" -- Needs review
L["Full-scan Auras: 2/10"] = "Auras en Scan Complet : 2/10"
L["Full-scan Auras 2/10 Text"] = "Tout d'abord, activez l'option Scan Complet."
L["Full-scan Auras: 3/10"] = "Auras en Scan Complet : 3/10"
L["Full-scan Auras 3/10 Text"] = [=[L'|cFFFF0000auto-clonage|r peut maintenant être activé avec l'option "%s".

Cela cause la création d'un nouveau graphique pour chaque aura qui correspond aux paramètres donnés.]=] -- Needs review
L["Full-scan Auras: 4/10"] = "Auras en Scan Complet : 4/10"
L["Full-scan Auras 4/10 Text"] = [=[Un popup doit apparaître, vous informant que les graphiques |cFFFF0000auto-clonés|r devraient généralement être utilisés dans des Groupes Dynamiques.

Cliquez "Oui" pour permettre à |cFF8800FFWeakAuras|r de mettre automatiquement vos graphiques dans un Groupe Dynamique.]=] -- Needs review
L["Full-scan Auras: 5/10"] = "Auras en Scan Complet : 5/10"
L["Full-scan Auras 5/10 Text"] = "Désactivez l'option Scan Complet pour ré-activer les autres options d'unité."
L["Group Auras 6/10"] = "Auras de groupe : 6/10"
L["Group Auras 6/10 Text"] = "Maintenant, Sélectionnez \"Groupe\" dans l'option Unité." -- Needs review
L["Group Auras: 7/10"] = "Auras de groupe : 7/10" -- Needs review
L["Group Auras 7/10 Text"] = [=[L'|cFFFF0000auto-clonage|r est, à nouveau, activé en utilisant l'option \"%s\".

Un nouveau graphique sera créé pour chaque membre du groupe affecté par l'aura spécifiée.]=] -- Needs review
L["Group Auras: 8/10"] = "Auras de groupe : 8/10" -- Needs review
L["Group Auras 8/10 Text"] = "Activer l'option %s pour une aura de groupe avec |cFFFF0000auto-clonage|r activé causera un nouveau graphique pour chaque membre du groupe qui |cFFFFFFFFn'est pas|r affecté par l'aura spécifiée." -- Needs review
L["Home"] = "Accueil" -- Needs review
L["Multi-target Auras: 10/10"] = "Auras multi-cibles : 10/10" -- Needs review
L["Multi-target Auras 10/10 Text"] = [=[Les auras multi-cibles ont l'|cFFFF0000auto-clonage|r par défaut.

Les déclencheurs d'aura multi-cibles sont différents des déclencheurs d'aura normaux car ils sont basés sur des évènements du Journal de Combat, ce qui signifie qu'ils suivront les auras sur des monstres que personne ne cible (bien que certaines informations dynamiques ne sont pas disponibles sans que quelqu'un du groupe cible l'unité).

Cela fait des auras multi-cibles un bon choix pour suivre des DoTs sur plusieurs ennemis.]=] -- Needs review
L["Multi-target Auras: 9/10"] = "Auras multi-cibles : 9/10" -- Needs review
L["Multi-target Auras 9/10 Text"] = "Enfin, sélectionnez \"Multi-cibles\" comme option d'unité." -- Needs review
L["New in 1.4:"] = "Nouveau dans la 1.4 :" -- Needs review
L["New in 1.4 Desc:"] = "Nouveau dans la 1.4" -- Needs review
L["New in 1.4 Desc Text"] = "Découvrez les nouvelles fonctions de WeakAuras 1.4" -- Needs review
L["New in 1.4 Finnished Text"] = [=[Bien sûr, il y a plus de nouvelles fonctions dans |cFF8800FFWeakAuras 1.4|r qu'on ne peut discuter en une fois, sans parler des nombreuses corrections de bugs et optimisations.

Nous espérons que ce Didacticiel vous a au moins guidé vers les principales nouvelles possibilités qui vous sont offertes.

Merci d'utiliser |cFF8800FFWeakAuras|r !]=] -- Needs review
L["New in 1.4 Text1"] = [=[La version 1.4 de |cFF8800FFWeakAuras|r introduit plusieurs nouvelles fonctions puissantes.

Ce didacticiel fournit un aperçu des principales nouvelles possibilités, et comment les utiliser.]=] -- Needs review
L["New in 1.4 Text2"] = "D'abord, créez un nouveau graphique pour la démonstration." -- Needs review
L["Previous"] = "Précédant" -- Needs review
L["Trigger Options: 1/4"] = "Options de Déclencheur : 1/4" -- Needs review
L["Trigger Options 1/4 Text"] = [=[En plus de \"Multi-cibles\" il y a un autre nouveau réglage pour l'option Unité : Unité Spécifique.

Choisissez-le pour faire apparaître un nouveau champ de texte.]=] -- Needs review
L["Trigger Options: 2/4"] = "Options de Déclencheur : 2/4" -- Needs review
L["Trigger Options 2/4 Text"] = [=[Dans ce champ, vous pouvez spécifier le nom de n'importe quel joueur de votre groupe, ou un ID d'unité personnalisé. Les ID d'unités tels que \"boss1\" \"boss2\" etc. sont particulièrement utilises pour les rencontres de raid.

Tous les déclencheurs qui permettent de spécifier une unité (pas seulement les déclencheurs Aura) supportent maintenant l'option Unité Spécifique.]=] -- Needs review
L["Trigger Options: 3/4"] = "Options de Déclencheur : 3/4" -- Needs review
L["Trigger Options 3/4 Text"] = [=[|cFF8800FFWeakAuras 1.4|r ajoute aussi de nouveaux types de déclencheurs.

Sélectionnez la catégorie Statut pour y jeter un œil.]=] -- Needs review
L["Trigger Options: 4/4"] = "Options de Déclencheur : 4/4" -- Needs review
L["Trigger Options 4/4 Text"] = [=[Le déclencheur |cFFFFFFFFCaractéristique d'unité|r permet de tester le nom d'une unité, sa classe, son hostilité, et si c'est un Joueur ou un Personnage non-Joueur.

Les déclencheurs |cFFFFFFFFRecharge Globale|r et |cFFFFFFFFVitesse d'attaque|r s'ajoutent au déclencheur Incantation.]=] -- Needs review
L["WeakAuras Tutorials"] = "Didacticiels WeakAuras" -- Needs review
L["Welcome"] = "Bienvenue" -- Needs review
L["Welcome Text"] = [=[Bienvenue au Guide du Débutant de |cFF8800FFWeakAuras|r.

Ce guide vous montrera comment utiliser WeakAuras, et explique les options de configuration de base.]=] -- Needs review




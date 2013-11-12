local L = BigWigs:NewBossLocale("Immerseus", "frFR")
if not L then return end
if L then
L["win_yell"] = "Ah, vous avez réussi !"

end

L = BigWigs:NewBossLocale("The Fallen Protectors", "frFR")
if L then
L["defile_you"] = "Sol profané en dessous de vous" -- Needs review
L["defile_you_desc"] = "Prévient quand vous vous trouvez dans le Sol profané." -- Needs review
L["inferno_self"] = "Frappe du feu d'enfer sur vous" -- Needs review
L["inferno_self_bar"] = "Vous explosez !" -- Needs review
L["inferno_self_desc"] = "Compte à rebours spécial quand la Frappe du feu d'enfer est sur vous." -- Needs review
L["intermission_desc"] = "Prévient quand l'un des boss est sur le point d'utiliser ses Mesures désespérées." -- Needs review
L["no_meditative_field"] = "Vous n'êtes pas dans la bulle !" -- Needs review


	L.custom_off_bane_marks = "Marquage Mot de l'ombre : Plaie"
	L.custom_off_bane_marks_desc = "Afin d'aider à l'attribution des dissipations, marque les personnes initialement touchées par Mot de l'ombre : Plaie avec {rt1}{rt2}{rt3}{rt4}{rt5} (dans cet ordre, il se peut que toutes les marques ne soient pas utilisées). Nécessite d'être assistant ou chef de raid."
end

L = BigWigs:NewBossLocale("Norushen", "frFR")
if L then
L["big_add"] = "Manifestation de la corruption (%d)"
L["big_add_killed"] = "Manifestation de la corruption tuée (%d)"
L["big_adds"] = "Manifestations de la corruption"
L["big_adds_desc"] = "Alertes quand les gros adds apparaissent et sont tués." -- Needs review
L["warmup_trigger"] = "Très bien, je vais créer un champ de force qui contiendra votre corruption."

end

L = BigWigs:NewBossLocale("Sha of Pride", "frFR")
if L then
L["projection_explosion"] = "Explosion de la projection"
L["projection_message"] = "Allez sur la flèche |cFF00FF00VERTE|r !"
L["titan_pride"] = "Titan+Orgueil : %s"


	L.custom_off_titan_mark = "Marquage Don des titans"
	L.custom_off_titan_mark_desc = "Marque les joueurs sous l'effet de Don des titans avec {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}{rt8}. Nécessite d'être assistant ou chef de raid.\n|cFFFF0000Seule 1 personne du raid doit activer ceci afin d'éviter les conflits de marquage.|r"
end

L = BigWigs:NewBossLocale("Galakras", "frFR")
if L then
	L.demolisher = "Démolisseur"
	L.demolisher_desc = "Délais avant que les Démolisseurs kor’kron ne se joignent au combat."

	L.towers = "Tours"
	L.towers_desc = "Alertes quand les portes des tours sont détruites."
	L.south_tower_trigger = "La porte qui barrait l’accès à la tour sud a été détruite !"
	L.south_tower = "Tour sud"
	L.north_tower_trigger = "La porte qui barrait l’accès à la tour nord a été détruite !"
	L.north_tower = "Tour nord"
	L.tower_defender = "Défenseur de la tour"

	L.adds_desc = "Barres de délai indiquant quand un nouveau groupe d'ennemi se joint au combat."
	L.adds_trigger1 = "Descendez-la, que je puisse serrer mes mains autour de son cou."
	L.adds_trigger2 = "Les voilà !"
	L.adds_trigger3 = "Gueules-de-dragon, avancez !"
	L.adds_trigger4 = "Pour Hurlenfer !"
	L.adds_trigger5 = "Escouade suivante, en avant !"

	--L.drakes = "Proto-Drakes"

	L.custom_off_shaman_marker = "Marquage Chaman des marées"
	L.custom_off_shaman_marker_desc = "Afin d'aider à l'attribution des interruptions, marque les Chamans des marées gueule-de-dragon avec {rt1}{rt2}{rt3}{rt4}{rt5}. Nécessite d'être assistant ou chef de raid.\n|cFFFF0000Seule 1 personne du raid doit activer ceci afin d'éviter les conflits de marquage.|r\n|cFFADFF2ASTUCE : si le raid a décidé que c'est vous qui devez l'activer, survoler rapidement tous les chamans est le moyen le plus rapide de les marquer.|r"
end

L = BigWigs:NewBossLocale("Iron Juggernaut", "frFR")
if L then
	L.custom_off_mine_marks = "Marquage Mine rampante"
	L.custom_off_mine_marks_desc = "Afin d'aider à l'attribution des soaking, marque les Mines rampantes avec {rt1}{rt2}{rt3}. Nécessite d'être assistant ou chef de raid.\n|cFFFF0000Seule 1 personne du raid doit activer ceci afin d'éviter les conflits de marquage.|r\n|cFFADFF2FASTUCE : si le raid a décidé que c'est vous qui devez l'activer, survoler rapidement toutes les mines est le moyen le plus rapide de les marquer.|r"
end

L = BigWigs:NewBossLocale("Kor'kron Dark Shaman", "frFR")
if L then
	L.blobs = "Gelées"

	L.custom_off_mist_marks = "Marquage Brume toxique"
	L.custom_off_mist_marks_desc = "Afin d'aider à l'attribution des soins, marque les joueurs subissant Brume toxique avec {rt1}{rt2}{rt3}{rt4}{rt5}. Nécessite d'être assistant ou chef de raid.\n|cFFFF0000Seule 1 personne du raid doit activer ceci afin d'éviter les conflits de marquage.|r"
end

L = BigWigs:NewBossLocale("General Nazgrim", "frFR")
if L then
	L.custom_off_bonecracker_marks = "Marquage Brise-os"
	L.custom_off_bonecracker_marks_desc = "Afin d'aider à l'attribution des soins, marque les joueurs subissant Brise-os avec {rt1}{rt2}{rt3}{rt4}{rt5}. Nécessite d'être assistant ou chef de raid.\n|cFFFF0000Seule 1 personne du raid doit activer ceci afin d'éviter les conflits de marquage.|r"

	L.stance_bar = "%s(ACTUELLE : %s)"
	L.battle = "Combat"
	L.berserker = "Berserker"
	L.defensive = "Défensive"

	L.adds_trigger1 = "Défendez les portes !"
	L.adds_trigger2 = "Ralliez les troupes !"
	L.adds_trigger3 = "Escouade suivante, au front !"
	L.adds_trigger4 = "Guerriers, au pas de course !"
	L.adds_trigger5 = "Kor’krons, avec moi !"
	L.adds_trigger_extra_wave = "Tous les Kor’krons sous mon commandement, tuez-les, maintenant !"
	L.extra_adds = "Renforts supplémentaires"

	L.chain_heal_message = "Votre focalisation est en train d'incanter Salve de guérison !"

	L.arcane_shock_message = "Votre focalisation est en train d'incanter Horion des Arcanes !"

	L.focus_only = "|cffff0000Alertes de la cible de focalisation uniquement.|r "
end

L = BigWigs:NewBossLocale("Malkorok", "frFR")
if L then
	L.custom_off_energy_marks = "Marquage Énergie déplacée"
	L.custom_off_energy_marks_desc = "Afin d'aider à l'attribution des dissipations, marque les joueurs subissant Énergie déplacée avec {rt1}{rt2}{rt3}{rt4}. Nécessite d'être assistant ou chef de raid.\n|cFFFF0000Seule 1 personne du raid doit activer ceci afin d'éviter les conflits de marquage.|r"
end

L = BigWigs:NewBossLocale("Spoils of Pandaria", "frFR")
if L then
	L.win_trigger = "Système en cours de réinitialisation. Veuillez ne pas le débrancher, ou il pourrait vous sauter à la figure." -- to check

	L.enable_zone = "Entrepôt de l’Artéfact"
	L.matter_scramble_explosion = "Explosion Brouillage de la matière" -- shorten maybe?
end

L = BigWigs:NewBossLocale("Thok the Bloodthirsty", "frFR")
if L then
L["adds_desc"] = "Alertes indiquant quand le Yéti ou les Chauve-souris se joignent au combat." -- Needs review
L["cage_opened"] = "Cage ouverte"
L["npc_akolik"] = "Akolik"
L["npc_waterspeaker_gorai"] = "Eauracle Goraï"

end

L = BigWigs:NewBossLocale("Siegecrafter Blackfuse", "frFR")
if L then
	L.overcharged_crawler_mine = "Mine rampante surchargée"
	L.custom_off_mine_marker = "Marquage Mine"
	L.custom_off_mine_marker_desc = "Afin d'aider à l'attribution des étourdissements, marque les mines avec toutes les marques disponibles."

	L.saw_blade_near_you = "Lame de scie près de vous (pas sur vous)"
	L.saw_blade_near_you_desc = "Vous devriez désactiver ceci pour éviter d'être spammé si votre raid est regroupé dans votre stratégie."

	L.disabled = "Désactivé"

	L.shredder_engage_trigger = "Un déchiqueteur automatisé approche !"
	L.laser_on_you = "Laser sur vous PIOU PIOU !"
	L.laser_say = "Laser PIOU PIOU"

	L.assembly_line_trigger = "Des armes non terminées commencent à avancer sur la chaîne d’assemblage."
	L.assembly_line_message = "Armes non terminées (%d)"
	L.assembly_line_items = "Objets (%d) : %s"
	L.item_missile = "Missile"
	L.item_mines = "Mines"
	L.item_laser = "Laser"
	L.item_magnet = "Aimant"

	L.shockwave_missile_trigger = "Presenting... the beautiful new ST-03 Shockwave missile turret!" -- to translate
end

L = BigWigs:NewBossLocale("Paragons of the Klaxxi", "frFR")
if L then
	L.catalyst_match = "Catalyseur : |c%sVOUS CORRESPOND|r" -- might not be best for colorblind?
	L.you_ate = "Vous avez mangé un parasite (il en reste %d)"
	L.other_ate = "%s a mangé un %sparasite (il en reste %d)"
	L.parasites_up = "%d |4Parasite actif:Parasites actifs;"
	L.dance = "Danse"
	L.prey_message = "Utilisez Prendre pour proie sur le parasite"
	L.injection_over_soon = "Injection bientôt terminée (%s) !"

	L.one = "Iyyokuk sélectionne : Un !"
	L.two = "Iyyokuk sélectionne : Deux !"
	L.three = "Iyyokuk sélectionne : Trois !"
	L.four = "Iyyokuk sélectionne : Quatre !"
	L.five = "Iyyokuk sélectionne : Cinq !"

	L.custom_off_edge_marks = "Marquage Tranchant enflammé"
	L.custom_off_edge_marks_desc = "Marque les joueurs qui seront les sommets des Tranchants enflammés avec {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}{rt8}. Nécessite d'être assistant ou chef de raid.\n|cFFFF0000Seule 1 personne du raid doit activer ceci afin d'éviter les conflits de marquage.|r"
	L.edge_message = "Vous êtes un sommet"

	L.custom_off_parasite_marks = "Marquage Parasite"
	L.custom_off_parasite_marks_desc = "Afin d'aider à l'attribution des contrôles de foule et des Prendre pour proie, marque les parasites avec {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}. Nécessite d'être assistant ou chef de raid.\n|cFFFF0000Seule 1 personne du raid doit activer ceci afin d'éviter les conflits de marquage.|r"

	L.injection_tank = "Incantation d'Injection"
	L.injection_tank_desc = "Barre de délai indiquant quand Injection est incanté sur son tank actuel."
end

L = BigWigs:NewBossLocale("Garrosh Hellscream", "frFR")
if L then
	L.manifest_rage = "Manifestation de la rage"
	L.manifest_rage_desc = "Quand Garrosh atteint 100 d'énergie, il incante Manifestation de la rage pendant 2 secondes, puis canalise ce dernier. Durant la canalisation, des adds apparaissent. Amenez l'étoile de fer sur Garrosh pour l'étourdir et interrompre son incantation."

	L.phase_3_end_trigger = "Vous croyez avoir GAGNÉ ? Vous êtes AVEUGLE. JE VAIS VOUS OUVRIR LES YEUX." -- to check

	L.clump_check_desc = "Vérifie toutes les 3 secondes durant les bombardements les joueurs regroupés. Si un regroupement est trouvé, une étoile de fer Kor'kron apparaîtra."
	L.clump_check_warning = "Regroupement détecté, arrivée d'une étoile"

	L.bombardment = "Bombardement"
	L.bombardment_desc = "Bombarde Hurlevent et laisse des gerbes de feu sur le sol. Les étoiles de fer Kor'kron n'apparaissent que durant les bombardements."

	L.intermission = "Intervalle"
	L.mind_control = "Contrôle mental"
	L.empowered_message = "%s est maintenant surpuissant !"

	L.ironstar_impact_desc = "Une barre de délai indiquant quand l'Étoile de fer touchera le mur d'en face."
	L.ironstar_rolling = "L'Étoile de fer roule !"

	L.chain_heal_desc = "Rend 40% de ses points de vie maximum à une cible alliée et se propage aux cibles alliées à proximité."
	L.chain_heal_message = "Votre focalisation est en train d'incanter Salve de guérison !"
	L.chain_heal_bar = "Focalisation : Salve de guérison"

	L.farseer_trigger = "Long-voyants, soignez nos blessures !"

	L.custom_off_shaman_marker = "Marquage Chevaucheur de loup long-voyant"
	L.custom_off_shaman_marker_desc = "Afin d'aider à l'attribution des interruptions, marque les Chevaucheurs de loup long-voyant avec {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} (dans cet ordre)(il se peut que toutes les marques ne soient pas utilisées). Nécessite d'être assistant ou chef de raid."

	L.custom_off_minion_marker = "Marquage Sbires"
	L.custom_off_minion_marker_desc = "Afin d'aider à la séparation des sbires, marque ces derniers avec {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}{rt8}. Nécessite d'être assistant ou chef de raid."

	L.focus_only = "|cffff0000Alertes de la cible de focalisation uniquement.|r "
end


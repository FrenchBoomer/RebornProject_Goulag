local Touches = {

        ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
        ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
        ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
        ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
        ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
        ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
        ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
        ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
        ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118

    }

ToucheClavier = Touches["F6"] -- Touche d'ouverture du menu
Langue = "fr" -- Choix de la langue (Français = fr, Anglais = en, Espagnol = es)
Administration = true -- Choix de l'activation ou non du mode administration
ActivationBlip = true -- Activer / Desactiver les blips

BlipID = 238 -- Choix du blip
BlipTaille = 1.0 -- Choix de la taille du blip
BlipCouleur = 27 -- Choix de la couleur du blip
BlipClignotant = true -- Option pour faire clignoter le blip
Coordonnees = {      -- Coordonnees du blip pour le Goulag

        {x = -900.535, y = -444.549, z = 171.814}

    }

ListeBlanche = { -- whiteliste
    {steam= "steam:00000000000000000000000"},
    {steam= "steam:00000000000000000000000"},
    {steam= "steam:00000000000000000000000"},
    {steam= "steam:00000000000000000000000"},

}

Locales = {
    ['fr'] = {
        ['gestionjoueurs'] = "Gestion des joueurs ban",
        ['kikjoueurs'] = "Kick le citoyen",
        ['saisiemessage'] = "Saisir le message",
        ['envoyergoulag'] = "Envoyer le citoyen au Goulag",
        ['bancitoyengoulag'] = "Ban le citoyen",
        ['datemenugoulag'] = "Date : ",
        ['heuremenugoulag'] = "Heure : ",
        ['definitifmenugoulag'] = "Definitif : ",
        ['debanmenugoulag'] = "Deban",
        ['interlignegoulag'] = "----------------------------",
        ['enfermergoulag'] = "~r~Vous etes enfermer au Goulag~s~ Vous ne pouvez plus profiter de la ville",
        ['titrenotifimage'] = "GOULAG",
        ['textenotifbandef'] = "⛔️ Vous etes bannis definitivement de cette ville ⛔️ Cordialement la direction ✡️",
        ['notifenvoigoulag'] = "~g~Vous avez envoyer le citoyen au Goulag~s~",
        ['notifnonenvoigoulag'] = "~r~Ce citoyen est deja au Goulag~s~",
        ['notifbangoulag'] = "~g~Vous avez ban le citoyen~s~",
        ['notifdebangoulag'] = "Vous avez debannis le citoyen : ",
        ['notifechapgoulag'] = "~r~N'essaye pas de t'echapper c'est impossible imbecile !! xD ",
        ['notifwhiteliste'] = "~r~Vous ne faites pas parti de la whiteliste~s~",
    },

    ['en'] ={
        ['gestionjoueurs'] = "Management of players ban",
        ['kikjoueurs'] = "Kick the citizen",
        ['saisiemessage'] = "Enter the message",
        ['envoyergoulag'] = "Send the citizen to Gulag",
        ['bancitoyengoulag'] = "Ban the citizen",
        ['datemenugoulag'] = "Dated : ",
        ['heuremenugoulag'] = "Hours : ",
        ['definitifmenugoulag'] = "Final : ",
        ['debanmenugoulag'] = "Deban",
        ['interlignegoulag'] = "----------------------------",
        ['enfermergoulag'] = "~r~You're locked up in the Gulag~s~ You can not enjoy the city anymore",
        ['titrenotifimage'] = "GULAG",
        ['textenotifbandef'] = "⛔️ You are definitely banished from this city ⛔️ Regards management ✡️",
        ['notifenvoigoulag'] = "~g~You have sent the citizen to Goulag~s~",
        ['notifnonenvoigoulag'] = "~r~This citizen is already in Gulag ~ s ~",
        ['notifbangoulag'] = "~g~You ban the citizen~s~",
        ['notifdebangoulag'] = "You have debannis the citizen : ",
        ['notifechapgoulag'] = "~r~Do not try to escape it is impossible idiot! xD",
        ['notifwhiteliste'] = "~r~You are not part of the whitelist~s~",
    },

    ['es'] ={
        ['gestionjoueurs'] = "Gestión de prohibición de jugadores",
        ['kikjoueurs'] = "Patear al ciudadano",
        ['saisiemessage'] = "Ingrese el mensaje",
        ['envoyergoulag'] = "Envía al ciudadano al Gulag",
        ['bancitoyengoulag'] = "Prohibir al ciudadano",
        ['datemenugoulag'] = "Fecha : ",
        ['heuremenugoulag'] = "Hora : ",
        ['definitifmenugoulag'] = "Definitivo : ",
        ['debanmenugoulag'] = "Deban",
        ['interlignegoulag'] = "----------------------------",
        ['enfermergoulag'] = "~r~Estás encerrado en el Gulag~s~ Ya no puedes disfrutar de la ciudad",
        ['titrenotifimage'] = "GULAG",
        ['textenotifbandef'] = "⛔️ Eres expulsado permanentemente de esta ciudad ⛔️ Gestión de saludos ✡️",
        ['notifenvoigoulag'] = "~g~Has enviado al ciudadano a Goulag~s~",
        ['notifnonenvoigoulag'] = "~r~Este ciudadano ya está en Gulag~s~",
        ['notifbangoulag'] = "~g~Usted prohíbe al ciudadano~s~",
        ['notifdebangoulag'] = "Tienes abannis el ciudadano : ",
        ['notifechapgoulag'] = "~r~No intentes escapar es imposible imbécil ! xD",
        ['notifwhiteliste'] = "~r~No eres parte de la lista blanca~s~",
    },
}
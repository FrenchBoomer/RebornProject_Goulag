local Goulag = false
JOUEURSBANNIS = {}

if Langue == "fr" then
    LangueChoisie = Locales.fr
elseif Langue == "en" then
    LangueChoisie = Locales.en
elseif Langue == "es" then
    LangueChoisie = Locales.es
end

AddEventHandler("playerSpawned", function()
    Wait(8000)
    TriggerServerEvent("RebornProject:SpawnDesBansAuGoulag_Serveur")
end)

RegisterNetEvent("RebornProject:EnvoisDeLaListeDesJoueursBannis")
AddEventHandler('RebornProject:EnvoisDeLaListeDesJoueursBannis', function(THEJOUEURSBANNIS)
    JOUEURSBANNIS = {}
    JOUEURSBANNIS = THEJOUEURSBANNIS
end)

RegisterNetEvent("RebornProject:RecuperationSteamID_Client")
AddEventHandler('RebornProject:RecuperationSteamID_Client', function(SteamID)
    IDENTIFIANTDUJOUEUR = SteamID
end)

function VerificationWhiteListe()
    for k, v in ipairs(ListeBlanche) do
        if IDENTIFIANTDUJOUEUR == v.steam then
            return true
        end     
    end
end

RegisterNetEvent('RebornProject:NotificationImage')
AddEventHandler("RebornProject:NotificationImage", function(image, type, envoi, titre, texte)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(texte)
    SetNotificationMessage(image, image, true, type, envoi, titre, texte)
    DrawNotification(false, true)
end)

RegisterNetEvent('RebornProject:VerificationDuStatutBanDuJoueur')
AddEventHandler('RebornProject:VerificationDuStatutBanDuJoueur', function()
    TriggerServerEvent("RebornProject:SpawnDesBansAuGoulag_Serveur")
end)

RegisterNetEvent('RebornProject:SpawnDesBansAuGoulag_Client')
AddEventHandler('RebornProject:SpawnDesBansAuGoulag_Client', function()
    Goulag = true
    SetPlayerInvincible(GetPlayerPed(-1), true)
    SetEntityInvincible(GetPlayerPed(-1), true)
    DoScreenFadeOut(2000)
    while IsScreenFadingOut() do Wait(0) end
    NetworkFadeOutEntity(GetPlayerPed(-1), true, false)
    Wait(2000)
    SetEntityCoords(GetPlayerPed(-1), -900.535, -444.549, 171.814)
    SetEntityHeading(GetPlayerPed(-1), 238.530)
    NetworkFadeInEntity(GetPlayerPed(-1), 0)
    Wait(2000)
    SimulatePlayerInputGait(PlayerId(), 10.0, 50, 5.0, 1, 0)
    DoScreenFadeIn(2000)
    while IsScreenFadingIn() do Wait(0) end
end)

function DrawMissionText2(m_text)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(m_text)
    DrawSubtitleTimed(1000, 1)
end

Citizen.CreateThread(function()

    WarMenu.CreateMenu('ListeJoueursConnecter', '')
    WarMenu.CreateSubMenu('GestionJoueursConnecter', 'ListeJoueursConnecter')
    WarMenu.CreateSubMenu('GestionDesJoueursBannis', 'ListeJoueursConnecter')
    WarMenu.CreateSubMenu('ActionsJoueursBannis', 'GestionDesJoueursBannis')
    WarMenu.SetTitleBackgroundSprite("ListeJoueursConnecter", "Goulag", "Gulag")
    WarMenu.SetTitleBackgroundSprite("GestionJoueursConnecter", "Goulag", "Gulag")
    WarMenu.SetTitleBackgroundSprite("GestionDesJoueursBannis", "Goulag", "Gulag")
    WarMenu.SetTitleBackgroundSprite("ActionsJoueursBannis", "Goulag", "Gulag")
    WarMenu.SetMenuButtonPressedSound('ListeJoueursConnecter', "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET")
    WarMenu.SetMenuButtonPressedSound('GestionJoueursConnecter', "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET")
    WarMenu.SetMenuButtonPressedSound('GestionDesJoueursBannis', "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET")
    WarMenu.SetMenuButtonPressedSound('ActionsJoueursBannis', "CONFIRM_BEEP", "HUD_MINI_GAME_SOUNDSET")
    WarMenu.SetTitleBackgroundColor('ListeJoueursConnecter', 255, 255, 255, 255)
    WarMenu.SetTitleBackgroundColor('GestionJoueursConnecter', 255, 255, 255, 255)
    WarMenu.SetTitleBackgroundColor('GestionDesJoueursBannis', 255, 255, 255, 255)
    WarMenu.SetTitleBackgroundColor('ActionsJoueursBannis', 255, 255, 255, 255)
    WarMenu.SetMenuX('ListeJoueursConnecter', 0.02)
    WarMenu.SetMenuY('ListeJoueursConnecter', 0.05)
    WarMenu.SetMenuX('GestionJoueursConnecter', 0.02)
    WarMenu.SetMenuY('GestionJoueursConnecter', 0.05)
    WarMenu.SetMenuX('GestionDesJoueursBannis', 0.02)
    WarMenu.SetMenuY('GestionDesJoueursBannis', 0.05)
    WarMenu.SetMenuX('GestionDesJoueursBannis', 0.02)
    WarMenu.SetMenuY('GestionDesJoueursBannis', 0.05)

    while true do
        if WarMenu.IsMenuOpened('ListeJoueursConnecter') then
          if WarMenu.MenuButton(LangueChoisie.gestionjoueurs, "GestionDesJoueursBannis", "→") then
          end
            players = {}
            local localplayers = {}
            for i = 0, 256 do
                if NetworkIsPlayerActive( i ) then
                    table.insert( localplayers, GetPlayerServerId(i) )
                end
            end
                table.sort(localplayers)
            for i,thePlayer in ipairs(localplayers) do
                table.insert(players,GetPlayerFromServerId(thePlayer))
            end

            for i,thePlayer in ipairs(players) do
                if WarMenu.MenuButton(GetPlayerName(thePlayer).." ~b~ ["..GetPlayerServerId(thePlayer).."]~s~", "GestionJoueursConnecter") then
                    ChoixDuJoueurMenuAdmin = thePlayer
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('GestionJoueursConnecter') then
            if WarMenu.Button(LangueChoisie.kikjoueurs) then
              AddTextEntry('FMMC_KEY_TIPS', LangueChoisie.saisiemessage)
              DisplayOnscreenKeyboard(1, "FMMC_KEY_TIPS", "", "", "", "", "", 45)
              while (UpdateOnscreenKeyboard() == 0) do
              DisableAllControlActions(0)
              Wait(0)
              end
              if (GetOnscreenKeyboardResult()) then
                local MessageAuJoueur = tostring(GetOnscreenKeyboardResult())  
                TriggerServerEvent("RebornProject:KickDuCitoyen", GetPlayerServerId(ChoixDuJoueurMenuAdmin), MessageAuJoueur)
              end
              WarMenu.Display()
            elseif WarMenu.Button(LangueChoisie.envoyergoulag) then
              AddTextEntry('FMMC_KEY_TIPS', LangueChoisie.saisiemessage)
              DisplayOnscreenKeyboard(1, "FMMC_KEY_TIPS", "", "", "", "", "", 45)
              while (UpdateOnscreenKeyboard() == 0) do
              DisableAllControlActions(0)
              Wait(0)
              end
              if (GetOnscreenKeyboardResult()) then
                local MessageAuJoueur = tostring(GetOnscreenKeyboardResult())  
                local nomdujoueurban = GetPlayerName(ChoixDuJoueurMenuAdmin)
                TriggerServerEvent("RebornProject:BanDuCitoyen", GetPlayerServerId(ChoixDuJoueurMenuAdmin), MessageAuJoueur, nomdujoueurban)
              end
            elseif WarMenu.Button(LangueChoisie.bancitoyengoulag) then
              local nomdujoueurban = GetPlayerName(ChoixDuJoueurMenuAdmin)
              TriggerServerEvent("RebornProject:BanDefLeCitoyenDuGoulag", GetPlayerServerId(ChoixDuJoueurMenuAdmin), nomdujoueurban)
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('GestionDesJoueursBannis') then
            for k, value in pairs(JOUEURSBANNIS) do
                if WarMenu.MenuButton(value.nom, "ActionsJoueursBannis", "→") then
                    IdentifierJoueurGoulag = value.identifier
                    NomJoueurBannis = value.nom
                    DateJoueurBannis = value.date
                    HeureJoueurBannis = value.heure
                    BanDefJoueur = value.bandef
                    RaisonJoueurBannis = value.raison
                end
            end
            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('ActionsJoueursBannis') then
            if WarMenu.Button(LangueChoisie.datemenugoulag..DateJoueurBannis) then
            elseif WarMenu.Button(LangueChoisie.heuremenugoulag..HeureJoueurBannis) then
            elseif WarMenu.Button(LangueChoisie.definitifmenugoulag..BanDefJoueur) then
            elseif WarMenu.Button(RaisonJoueurBannis) then
            elseif WarMenu.Button(LangueChoisie.interlignegoulag) then
            elseif WarMenu.Button(LangueChoisie.debanmenugoulag) then
                TriggerServerEvent("RebornProject:DebanLesBannisAuGoulag", IdentifierJoueurGoulag, NomJoueurBannis)
                WarMenu.CloseMenu()
            end
            WarMenu.Display()
        end
          if IsControlJustPressed(1, ToucheClavier) then
              TriggerServerEvent("RebornProject:RecuperationSteamID_Serveur")
              TriggerServerEvent("RebornProject:RecuperationDesJoueursBannisPourLeMenu")
              Wait(100)
            if Administration == true then
                local VerifWL = VerificationWhiteListe()
                Wait(100)
                if VerifWL == true then
                    WarMenu.OpenMenu("ListeJoueursConnecter")
                else
                    PlaySound(GetPlayerServerId(GetPlayerPed(-1)), "CHECKPOINT_MISSED", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
                    TriggerEvent("RebornProject:NotificationImage", "CHAR_SASQUATCH", 7, LangueChoisie.titrenotifimage, false, LangueChoisie.notifwhiteliste)
                end
            else
                WarMenu.OpenMenu("ListeJoueursConnecter")
            end
          end
        if WarMenu.IsMenuAboutToBeClosed("ListeJoueursConnecter") then
            -- ICI METTRE LES APPELS NECESSAIRES LORS DE LA FERMETURE DU MENU
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if Goulag == true then
            local pL = GetEntityCoords(GetPlayerPed(-1), true)
            local D = Vdist(-900.535, -444.549, 171.814, pL['x'], pL['y'], pL['z'])
            if D > 13 then
                TriggerEvent("RebornProject:NotificationImage", "CHAR_SASQUATCH", 7, LangueChoisie.titrenotifimage, false, LangueChoisie.notifechapgoulag)
                SetEntityCoords(GetPlayerPed(-1), -900.535, -444.549, 171.814)
                SetEntityHeading(GetPlayerPed(-1), 277.030)
            end
            DrawMissionText2(LangueChoisie.enfermergoulag)
            Wait(0)
        end
    end
end)

Citizen.CreateThread(function()
  while true do
    if Goulag then
      local ply = GetPlayerPed(-1)
      DisableControlAction(1, 24, true)
      DisableControlAction(1, 19, true)
      DisableControlAction(1, 22, true)
      DisableControlAction(1, 167, true)
      DisablePlayerFiring(ply, true)
      DisableControlAction(1, 142, true)
      DisableControlAction(1, 106, true)
      DisableControlAction(1, 38, true)
      DisableControlAction(1, 18, true)
      DisableControlAction(1, 69, true)
      DisableControlAction(1, 92, true)
      DisableControlAction(1, 106, true)
      DisableControlAction(1, 122, true)
      DisableControlAction(1, 135, true)
      DisableControlAction(1, 142, true)
      DisableControlAction(1, 144, true)
      DisableControlAction(1, 176, true)
      DisableControlAction(1, 222, true)
      DisableControlAction(1, 229, true)
      DisableControlAction(1, 237, true)
      DisableControlAction(1, 257, true)
      DisableControlAction(1, 329, true)
      DisableControlAction(1, 346, true)

      DisableControlAction(1, 45, true)
      DisableControlAction(1, 57, true)
      DisableControlAction(1, 80, true)
      DisableControlAction(1, 170, true)
      DisableControlAction(1, 177, true)
      DisableControlAction(1, 194, true)
      DisableControlAction(1, 202, true)
      DisableControlAction(1, 225, true)
      DisableControlAction(1, 257, true)
      DisableControlAction(1, 263, true)
      DisableControlAction(1, 264, true)
      DisableControlAction(1, 24, true)
      DisableControlAction(1, 257, true)
      DisableControlAction(1, 140, true)
      DisableControlAction(1, 141, true)
      DisableControlAction(1, 142, true)
    end
    Wait(0)
  end
end)

Citizen.CreateThread(function()
    if ActivationBlip == true then
        for _, item in pairs(Coordonnees) do
            item.blip = AddBlipForCoord(item.x, item.y, item.z)
            SetBlipSprite(item.blip, BlipID)
            SetBlipColour(item.blip, BlipCouleur)
            SetBlipScale(item.blip, BlipTaille)
            SetBlipDisplay(item.blip, 2)
            SetBlipFlashes(item.blip, BlipClignotant)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(item.nom)
            EndTextCommandSetBlipName(item.blip)
        end
    end
end)
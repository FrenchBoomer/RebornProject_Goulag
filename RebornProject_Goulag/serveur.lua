if Langue == "fr" then
    LangueChoisie = Locales.fr
elseif Langue == "en" then
    LangueChoisie = Locales.en
elseif Langue == "es" then
    LangueChoisie = Locales.es
end

function VerifPresenceBDD(identifier) 
  return MySQL.Sync.fetchScalar("SELECT identifier FROM joueurs_bans WHERE identifier=@identifier",{['@identifier'] = identifier})
end

RegisterServerEvent("RebornProject:RecuperationSteamID_Serveur")
AddEventHandler("RebornProject:RecuperationSteamID_Serveur", function()
  local source = source
  local SteamID = GetPlayerIdentifiers(source)[1]
    TriggerClientEvent("RebornProject:RecuperationSteamID_Client", source, SteamID)
end)

RegisterServerEvent("RebornProject:SpawnDesBansAuGoulag_Serveur")
AddEventHandler("RebornProject:SpawnDesBansAuGoulag_Serveur", function()
	local source = source
    local joueur = GetPlayerIdentifiers(source)[1]
    MySQL.Async.fetchAll("SELECT * FROM joueurs_bans WHERE identifier = @identifier",{['@identifier'] = joueur}, function (result)
        if(result)then
            for k,v in ipairs(result) do
                BannisTotal = v.bandef
                if BannisTotal == "Non" then
                    TriggerClientEvent("RebornProject:SpawnDesBansAuGoulag_Client", source)
                else
                    DropPlayer(source, LangueChoisie.textenotifbandef)
                end
            end
        end
    end)
end)

RegisterServerEvent("RebornProject:BanDefLeCitoyenDuGoulag")
AddEventHandler("RebornProject:BanDefLeCitoyenDuGoulag", function(netID, nomdujoueurban)
    local source = source
        local joueur = GetPlayerIdentifiers(netID)[1]
        local VerifPresence = VerifPresenceBDD(joueur)
        local nomdujoueur = nomdujoueurban
        local HeureDuServeur = os.date('%H:%M:%S', os.time())
        local DateDuServeur = os.date("%d/%m/%Y")
        local bandef = "Oui"
        local message = "Ban definitif"
        if VerifPresence == nil then
            MySQL.Sync.execute('INSERT INTO joueurs_bans (identifier,nom,date,heure,bandef,raison) VALUES (@identifier,@nom,@date,@heure,@bandef,@raison)', {['@identifier'] = joueur, ['@nom'] = nomdujoueur, ['@date'] = DateDuServeur, ['@heure'] = HeureDuServeur, ['@bandef'] = bandef, ['@raison'] = message})
            DropPlayer(netID, LangueChoisie.textenotifbandef)
            TriggerClientEvent("RebornProject:NotificationImage", source, "CHAR_SASQUATCH", 7, LangueChoisie.titrenotifimage, false, LangueChoisie.notifbangoulag)
        else
            MySQL.Sync.execute("UPDATE joueurs_bans SET identifier=@identifier, nom=@nom, date=@date, heure=@heure, bandef=@bandef, raison=@raison WHERE identifier=@identifier",{['@identifier'] = joueur, ['@nom'] = nomdujoueur, ['@date'] = DateDuServeur, ['@heure'] = HeureDuServeur, ['@bandef'] = bandef, ['@raison'] = message})
            DropPlayer(netID, LangueChoisie.textenotifbandef)
            TriggerClientEvent("RebornProject:NotificationImage", source, "CHAR_SASQUATCH", 7, LangueChoisie.titrenotifimage, false, LangueChoisie.notifbangoulag)
        end  
end)

RegisterServerEvent("RebornProject:RecuperationDesJoueursBannisPourLeMenu")
    AddEventHandler('RebornProject:RecuperationDesJoueursBannisPourLeMenu', function()
    local source = source
    joueursbannis = {}
    MySQL.Async.fetchAll("SELECT * FROM joueurs_bans WHERE verif=@verif",{['@verif'] = "oui"}, function(result)
    for _, v in ipairs(result) do
    joueursbannis[tonumber(v.id)] = {["id"] = v.id, ["identifier"] = v.identifier, ["nom"] = v.nom, ["date"] = v.date, ["bandef"] = v.bandef, ["heure"] = v.heure, ["raison"] = v.raison}
    end
        TriggerClientEvent("RebornProject:EnvoisDeLaListeDesJoueursBannis", source, joueursbannis) 
    end)
end)

RegisterServerEvent("RebornProject:DebanLesBannisAuGoulag")
AddEventHandler("RebornProject:DebanLesBannisAuGoulag", function(identifier, NomJoueurBannis)
    local source = source
    MySQL.Sync.execute("DELETE FROM joueurs_bans WHERE identifier=@identifier",{['@identifier'] = identifier})
    TriggerClientEvent("RebornProject:NotificationImage", source, "CHAR_SASQUATCH", 7, LangueChoisie.titrenotifimage, false, LangueChoisie.notifdebangoulag..""..NomJoueurBannis)
end)

RegisterServerEvent("RebornProject:KickDuCitoyen")
AddEventHandler('RebornProject:KickDuCitoyen', function(playerId, message)
    DropPlayer(playerId, message)
end)

RegisterServerEvent("RebornProject:BanDuCitoyen")
AddEventHandler('RebornProject:BanDuCitoyen', function(playerId, message, nomdujoueurban)
    local source = source
    local joueur = GetPlayerIdentifiers(playerId)[1]
    local VerifPresence = VerifPresenceBDD(joueur)
    local nomdujoueur = nomdujoueurban
    local HeureDuServeur = os.date('%H:%M:%S', os.time())
    local DateDuServeur = os.date("%d/%m/%Y")
    if VerifPresence == nil then
        MySQL.Sync.execute('INSERT INTO joueurs_bans (identifier,nom,date,heure,raison) VALUES (@identifier,@nom,@date,@heure,@raison)', {['@identifier'] = joueur, ['@nom'] = nomdujoueur, ['@date'] = DateDuServeur, ['@heure'] = HeureDuServeur, ['@raison'] = message})
        TriggerClientEvent("RebornProject:NotificationImage", source, "CHAR_SASQUATCH", 7, LangueChoisie.titrenotifimage, false, LangueChoisie.notifenvoigoulag)
        TriggerClientEvent("RebornProject:VerificationDuStatutBanDuJoueur", playerId)
    else
        TriggerClientEvent("RebornProject:NotificationImage", source, "CHAR_SASQUATCH", 7, LangueChoisie.titrenotifimage, false, LangueChoisie.notifnonenvoigoulag)
    end
end)



-- NE PAS TOUCHER !!!

local CurrentVersion = '1.0.0'
local GithubResourceName = GetCurrentResourceName()
local Name = 'Walter White'

PerformHttpRequest('https://raw.githubusercontent.com/WalterWhite84/'.. GithubResourceName .. '/master/Version', function(Error, NewestVersion, Header)
    print('\n')
    print('\n')
    print('#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#')
    print("## Nom de la ressource : "..GithubResourceName)
    print('## Production: ' .. Name)
    print('## Derniere version : ' .. NewestVersion)
    print('## Version en cours : ' .. CurrentVersion)
    print('Lien de telechargement de telechargement du script : https://github.com/WalterWhite84/RebornProject_Goulag')
    print('#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#')
    print('\n')
    print('\n')
end)

-- FIN
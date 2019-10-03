# AutoIT_TopdeskHotKeys

Topdesk Hotkeys

Installatie:
De bestanden kunnen geplaatst in elke willekeurige map, leesrechten voor gebruikers zouden  voldoende moeten zijn.

Gebruik
Gemaakt in: Autoit http://www.autoitscript.com


Word gebruikt door: Support
Bestanden:  Check.exe, Topdesk_Hotkeys.exe
Het programma start met Check.exe
Deze controleert op dubbele instanties en of er op het moment van starten updates bezig zijn.
Als bovenstaande criteria niet bestaan dan word NHL_Hotkeys.exe gestart

Gebruikers kunnen de toets F3 gebruiken om verschillende functies uit te voeren.
F3: http requests naar Topdesk sturen.
bron: HTTP_requests.au3
Verschillende includes komen uit het library van Autoit

Updates
Door een nieuw bestand genaamd “kill.txt” aan te maken in de dir van het script, dan word Topdesk_Hotkeys.exe en kan dan geupdate worden. Door kill.txt te hernoemen, word NHL_Hotkeys.exe weer gestart.
 
Ini files

Incidents.ini  
Zodra een gebruiker F3 gebruikt, zal dit bestand gebruikt worden om het menu op te bouwen.
Om hier een knop aan toe te voegen, kan je onderstaande code aanpassen en plakken in het ini bestand. Wat tussen de [] staat word als knop aangemaakt.
[Wachtwoord reset]
$omschrijving = Wachtwoord reset
$verzoek = Ik heb geen beschikking over mijn wachtwoord, kunt u deze resetten?
$actie = Na het controleren van zijn/haar identiteit. Heb ik het wachtwoord gereset en meegegeven.

$soortmeldingid = Informatie verzoek
$soortbinnenkomstid = $dienst
$impactid = Individuele gebruiker
$UrgencyID = U1:Gebruiker kan niet werken

$incident_domeinid = Gebruikers diensten
$incident_specid = Account
$ObjectID = NVT
$operatorgroupid = Support Centre

$status = Afgemeld
$trtimetaken = 5
$afgemeld = 1 

majorincidents.ini
de data in dit bestand bouwt het menu voor major incidents op, gebruikt hier dezelfde opbouw als in incidents.ini. Gebruik het incidentnummer van het major incident tussen de [].

Settings.ini
Dit bestand word gebruikt om de locatie van de server in te vullen. Dit moet als volgt ingevuld worden. 
Server = http://<URL>/tas/secure/incident?action=new&status=1

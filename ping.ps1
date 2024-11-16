<<<<<<< HEAD
# D�finir la politique d'ex�cution pour autoriser le script, uniquement pour cette session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Choix du mode d'arr�t : dur�e ou touche
$choice = Read-Host "Choisissez le mode d'arr�t : '1' pour Limite de Temps, '2' pour Interruption par Touche"

# Demander l'adresse IP ou le nom d'h�te cible
$targetHost = Read-Host "Entrez l'adresse IP ou le nom d'h�te � ping"
$logFile = "$PSScriptRoot\ping_log.txt"  # Utilise le dossier du script pour le fichier log

# Initialiser le fichier de log
Out-File -FilePath $logFile -Encoding utf8 -Force
$successfulPings = 0
$failedPings = 0

# Configuration en fonction du choix
if ($choice -eq '1') {
    # Mode Limite de Temps : Demande la dur�e en minutes
    $durationMinutes = [int](Read-Host "Entrez la dur�e maximale en minutes")
    $startTime = Get-Date
    Write-Output "Mode Limite de Temps activ� pour $durationMinutes minutes."
} elseif ($choice -eq '2') {
    # Mode Interruption par Touche : Ajout d'un type pour d�tecter une touche (Q par d�faut)
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class KeyPress {
        [DllImport("user32.dll")]
        public static extern short GetAsyncKeyState(int vKey);
    }
"@
    Write-Output "Mode Interruption par Touche activ�. Appuyez sur 'Q' pour arr�ter le script."
} else {
    Write-Output "Choix invalide. Le script va s'arr�ter."
    exit
}

# Lancer la boucle de ping
if (![string]::IsNullOrWhiteSpace($targetHost)) {
    try {
        while ($true) {
            # V�rification de la limite de temps
            if ($choice -eq '1') {
                $elapsedTime = (Get-Date) - $startTime
                if ($elapsedTime.TotalMinutes -ge $durationMinutes) {
                    Write-Output "Dur�e maximale atteinte, le script va s'arr�ter."
                    break
                }
            }

            # V�rification de la touche "Q" si l'option 2 est s�lectionn�e
            if ($choice -eq '2' -and [KeyPress]::GetAsyncKeyState(0x51) -ne 0) { # 0x51 est le code de la touche "Q"
                Write-Output "Interruption par l'utilisateur, le script va s'arr�ter."
                break
            }

            # Ex�cution du ping
            $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            try {
                $pingResult = Test-Connection -ComputerName $targetHost -Count 1 -ErrorAction Stop
                $successfulPings++
                Write-Output "$timeStamp - $targetHost est accessible (Total r�ussis : $successfulPings)"
            } catch {
                $failedPings++
                $errorMessage = "$timeStamp - $targetHost n'est pas accessible"
                Write-Output $errorMessage
                
                # Enregistrement des pings �chou�s dans le log
                Add-Content -Path $logFile -Value $errorMessage
            }
            
            # Pause de 1 seconde avant le prochain ping
            Start-Sleep -Seconds 1
        }
    } finally {
        # R�sum� des r�sultats dans le fichier de log
        $finalMessage = @(
            "R�sum� des pings vers $targetHost :",
            "Total des pings r�ussis : $successfulPings",
            "Total des pings �chou�s : $failedPings"
        )
        $finalMessage | Out-File -FilePath $logFile -Append -Encoding utf8
        Write-Output "R�sum� enregistr� dans $logFile"
    }
} else {
    Write-Output "Aucune adresse IP ou nom d'h�te fourni. Le script s'arr�te."
}

#          & & %@@*/*/
#        % @.  %@@@@*@*@&@
#     ,#/@@%@@@%@@  *,*/&/@@
#    ,,#/  %   @@@  /,**&  @@
#   /,,#/@@%   @@@,*/(**&  @@
#   //,*#/,*%   @(@  /(**& @@
#   / ,%,@@&  *@@@  /(@*&.@@@
#   @@/@@@(%,*/ @@  .@@/@@@&@
#  @,@@#@@@%% Neiryx *@@*@@@&@@
# @(,@/    (#  /(@@  *@(   .&@@
#  @.&     ,#  /*#&@@.@     *@@#
#  @.@@#*%%@@  /@@@  *@@%.(%@@@#
#    @#*@%@@ *@@@@  *@@%(@%@@
#     #(@@(@ @@%&&  *@@%(@&
#     #/(@(@ @@@@@& *@@%@/
#     #,(@/# @/@@.% *@@%@/
#     #,&@,/ @.,&@ .*@@%@(
#      .@   @@ &,%.*# %@
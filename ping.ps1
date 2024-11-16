<<<<<<< HEAD
# Dï¿½finir la politique d'exï¿½cution pour autoriser le script, uniquement pour cette session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Choix du mode d'arrï¿½t : durï¿½e ou touche
$choice = Read-Host "Choisissez le mode d'arrï¿½t : '1' pour Limite de Temps, '2' pour Interruption par Touche"

# Demander l'adresse IP ou le nom d'hï¿½te cible
$targetHost = Read-Host "Entrez l'adresse IP ou le nom d'hï¿½te ï¿½ ping"
$logFile = "$PSScriptRoot\ping_log.txt"  # Utilise le dossier du script pour le fichier log

# Initialiser le fichier de log
Out-File -FilePath $logFile -Encoding utf8 -Force
$successfulPings = 0
$failedPings = 0

# Configuration en fonction du choix
if ($choice -eq '1') {
    # Mode Limite de Temps : Demande la durï¿½e en minutes
    $durationMinutes = [int](Read-Host "Entrez la durï¿½e maximale en minutes")
    $startTime = Get-Date
    Write-Output "Mode Limite de Temps activï¿½ pour $durationMinutes minutes."
} elseif ($choice -eq '2') {
    # Mode Interruption par Touche : Ajout d'un type pour dï¿½tecter une touche (Q par dï¿½faut)
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class KeyPress {
        [DllImport("user32.dll")]
        public static extern short GetAsyncKeyState(int vKey);
    }
"@
    Write-Output "Mode Interruption par Touche activï¿½. Appuyez sur 'Q' pour arrï¿½ter le script."
} else {
    Write-Output "Choix invalide. Le script va s'arrï¿½ter."
    exit
}

# Lancer la boucle de ping
if (![string]::IsNullOrWhiteSpace($targetHost)) {
    try {
        while ($true) {
            # Vï¿½rification de la limite de temps
            if ($choice -eq '1') {
                $elapsedTime = (Get-Date) - $startTime
                if ($elapsedTime.TotalMinutes -ge $durationMinutes) {
                    Write-Output "Durï¿½e maximale atteinte, le script va s'arrï¿½ter."
                    break
                }
            }

            # Vï¿½rification de la touche "Q" si l'option 2 est sï¿½lectionnï¿½e
            if ($choice -eq '2' -and [KeyPress]::GetAsyncKeyState(0x51) -ne 0) { # 0x51 est le code de la touche "Q"
                Write-Output "Interruption par l'utilisateur, le script va s'arrï¿½ter."
                break
            }

            # Exï¿½cution du ping
            $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            try {
                $pingResult = Test-Connection -ComputerName $targetHost -Count 1 -ErrorAction Stop
                $successfulPings++
                Write-Output "$timeStamp - $targetHost est accessible (Total rï¿½ussis : $successfulPings)"
            } catch {
                $failedPings++
                $errorMessage = "$timeStamp - $targetHost n'est pas accessible"
                Write-Output $errorMessage
                
                # Enregistrement des pings ï¿½chouï¿½s dans le log
                Add-Content -Path $logFile -Value $errorMessage
            }
            
            # Pause de 1 seconde avant le prochain ping
            Start-Sleep -Seconds 1
        }
    } finally {
        # Rï¿½sumï¿½ des rï¿½sultats dans le fichier de log
        $finalMessage = @(
            "Rï¿½sumï¿½ des pings vers $targetHost :",
            "Total des pings rï¿½ussis : $successfulPings",
            "Total des pings ï¿½chouï¿½s : $failedPings"
        )
        $finalMessage | Out-File -FilePath $logFile -Append -Encoding utf8
        Write-Output "Rï¿½sumï¿½ enregistrï¿½ dans $logFile"
    }
} else {
    Write-Output "Aucune adresse IP ou nom d'hï¿½te fourni. Le script s'arrï¿½te."
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
=======
# Définir la politique d'exécution pour autoriser le script, uniquement pour cette session
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Choix du mode d'arrêt : durée ou touche
$choice = Read-Host "Choisissez le mode d'arrêt : '1' pour Limite de Temps, '2' pour Interruption par Touche"

# Demander l'adresse IP ou le nom d'hôte cible
$targetHost = Read-Host "Entrez l'adresse IP ou le nom d'hôte à ping"
$logFile = "$PSScriptRoot\ping_log.txt"  # Utilise le dossier du script pour le fichier log

# Initialiser le fichier de log
Out-File -FilePath $logFile -Encoding utf8 -Force
$successfulPings = 0
$failedPings = 0

# Configuration en fonction du choix
if ($choice -eq '1') {
    # Mode Limite de Temps : Demande la durée en minutes
    $durationMinutes = [int](Read-Host "Entrez la durée maximale en minutes")
    $startTime = Get-Date
    Write-Output "Mode Limite de Temps activé pour $durationMinutes minutes."
} elseif ($choice -eq '2') {
    # Mode Interruption par Touche : Ajout d'un type pour détecter une touche (Q par défaut)
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class KeyPress {
        [DllImport("user32.dll")]
        public static extern short GetAsyncKeyState(int vKey);
    }
"@
    Write-Output "Mode Interruption par Touche activé. Appuyez sur 'Q' pour arrêter le script."
} else {
    Write-Output "Choix invalide. Le script va s'arrêter."
    exit
}

# Lancer la boucle de ping
if (![string]::IsNullOrWhiteSpace($targetHost)) {
    try {
        while ($true) {
            # Vérification de la limite de temps
            if ($choice -eq '1') {
                $elapsedTime = (Get-Date) - $startTime
                if ($elapsedTime.TotalMinutes -ge $durationMinutes) {
                    Write-Output "Durée maximale atteinte, le script va s'arrêter."
                    break
                }
            }

            # Vérification de la touche "Q" si l'option 2 est sélectionnée
            if ($choice -eq '2' -and [KeyPress]::GetAsyncKeyState(0x51) -ne 0) { # 0x51 est le code de la touche "Q"
                Write-Output "Interruption par l'utilisateur, le script va s'arrêter."
                break
            }

            # Exécution du ping
            $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            try {
                $pingResult = Test-Connection -ComputerName $targetHost -Count 1 -ErrorAction Stop
                $successfulPings++
                Write-Output "$timeStamp - $targetHost est accessible (Total réussis : $successfulPings)"
            } catch {
                $failedPings++
                $errorMessage = "$timeStamp - $targetHost n'est pas accessible"
                Write-Output $errorMessage
                
                # Enregistrement des pings échoués dans le log
                Add-Content -Path $logFile -Value $errorMessage
            }
            
            # Pause de 1 seconde avant le prochain ping
            Start-Sleep -Seconds 1
        }
    } finally {
        # Résumé des résultats dans le fichier de log
        $finalMessage = @(
            "Résumé des pings vers $targetHost :",
            "Total des pings réussis : $successfulPings",
            "Total des pings échoués : $failedPings"
        )
        $finalMessage | Out-File -FilePath $logFile -Append -Encoding utf8
        Write-Output "Résumé enregistré dans $logFile"
    }
} else {
    Write-Output "Aucune adresse IP ou nom d'hôte fourni. Le script s'arrête."
}
>>>>>>> 4cebe9a16af3f0cfe77a008d3260547534154bf1

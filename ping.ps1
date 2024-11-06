# Définir la politique d'exécution en mode "Unrestricted" pour la session actuelle
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process -Force

$targetHost = Read-Host "Entrez l'adresse IP ou le nom d'hôte à ping"
$logFile = "$PSScriptRoot\ping_log.txt"  # Utilise le dossier du script pour le fichier log

# Initialiser le fichier de log
Out-File -FilePath $logFile -Encoding utf8 -Force

# Initialiser les compteurs
$successfulPings = 0
$failedPings = 0

if (![string]::IsNullOrWhiteSpace($targetHost)) {
    try {
        while ($true) {
            $timeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            try {
                $pingResult = Test-Connection -ComputerName $targetHost -Count 1 -ErrorAction Stop
                $successfulPings++
                Write-Output "$timeStamp - $targetHost est accessible (Total réussis : $successfulPings)"
            } catch {
                $failedPings++
                $errorMessage = "$timeStamp - $targetHost n'est pas accessible"
                Write-Output $errorMessage
                
                # Enregistrer uniquement les pings échoués dans le log
                Add-Content -Path $logFile -Value $errorMessage
            }
            
            # Pause de 1 seconde avant le prochain ping
            Start-Sleep -Seconds 1
        }
    } finally {
        # Écrire le comptage final dans le fichier de log
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

param (
    [string]$TargetIP,  
    [int]$Timeout = 100 # Timeout in milliseconds
)

# Common TCP ports
$topPorts = @(21, 22, 23, 25, 53, 80, 81, 88,110, 111, 135, 139, 143, 389, 443, 445, 464, 593, 636, 465, 993, 995,
    1024, 1080, 1110, 1433, 1434, 1723, 1900, 2000, 2001, 2049, 2375, 2376, 3128, 3268, 3269,
    3306, 3389, 3690, 4000, 4444, 5000, 5001, 5060, 5061, 5357, 5358,5432, 5800, 5900, 5984,
    5985, 5986, 6000, 6379, 6666, 6667, 7000, 7001, 7070, 7474, 8000, 8008, 8009,
    8080, 8081, 8086, 8181, 8222, 8443, 8500, 8600, 8888, 9000, 9001, 9042, 9090,
    9200, 9300, 9389, 9443, 9999, 10000, 11211, 12000, 12345, 13720, 13721, 16080, 18080,
    27017, 27018, 28017, 30000, 30718, 32768, 32769, 49152, 49153, 49154, 49155,
    49156, 49157, 50000, 50030, 50060, 54321, 55555)

Write-Host "Scanning $TargetIP for open common ports..."

foreach ($port in $topPorts) {
    $tcpClient = New-Object System.Net.Sockets.TcpClient
    $async = $tcpClient.BeginConnect($TargetIP, $port, $null, $null)
    $wait = $async.AsyncWaitHandle.WaitOne($Timeout, $false)

    if ($wait -and $tcpClient.Connected) {
        Write-Host "[+] Open: $TargetIP`:$port"
        $tcpClient.Close()
    } else {
        $tcpClient.Close()
    }
}

Write-Host "Scan complete."

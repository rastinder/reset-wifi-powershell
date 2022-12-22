# Sleep for 30 seconds
Start-Sleep -Seconds 30

# Set the target to ping and the timeout value in seconds
$target = "google.com"
$timeout = 5

# Get the WiFi adapter object
$adapter = Get-NetAdapter | Where-Object { $_.InterfaceDescription -like "*Wi-Fi*" }

# If a WiFi adapter was found, get its name
if ($adapter) {
  $adapterName = $adapter.Name
}
else {
  Write-Output "WiFi adapter not found."
  return
}



# Ping the target and store the result in a variable
$result = ping $target -n 1 -w 1000

# If the ping failed, reset the network adapter
if ($result.StatusCode -ne 0) {
  Write-Output "Resetting network adapter $adapterName..."
  Disable-NetAdapter -Name $adapterName
  Enable-NetAdapter -Name $adapterName
}

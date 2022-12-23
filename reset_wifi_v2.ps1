# Connect to the wireless network with the SSID "Fear"
Connect-NetAdapter -Name "Wi-Fi" -NetworkName "Fear"

# Continuously check the connection status
while ($true) {
  # Check if we can ping Google
  $result = Test-NetConnection google.com -ErrorAction SilentlyContinue
  if ($result.PingSucceeded) {
    # If the connection is working, wait for a while before checking again
    Start-Sleep -Seconds 60
  } else {
    # If the connection is not working, disconnect from the wireless network and try connecting again
    Disconnect-NetAdapter -Name "Wi-Fi"
    Connect-NetAdapter -Name "Wi-Fi" -NetworkName "Fear"
  }
}

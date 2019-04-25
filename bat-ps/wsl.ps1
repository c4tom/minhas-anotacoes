function HabilitarWSL() {
  Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
}

function ListarFeatures() {
  Get-WindowsOptionalFeature -Online
}
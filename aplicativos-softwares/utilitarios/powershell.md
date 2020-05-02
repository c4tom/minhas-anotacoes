# PowerShell

## Modulos
- [Galeria de Scripts](https://www.powershellgallery.com/)
- [Backup-SqlDatabase](https://docs.microsoft.com/en-us/powershell/module/sqlps/?view=sqlserver-ps) 


## Windows
### Comandos Comuns
- Pesquisar Modulos: `Find-Script -Filter <palavra>`
- Instalar Módulos: `Install-Module Show-DatabasesOnServer`


Permitir instalação de scripts (execute como administrador)
https://technet.microsoft.com/pt-BR/library/hh847748.aspx

PS> Set-ExecutionPolicy ALLSIGNED



## Tips
Adicionando variaveis de ambiente:
`[Environment]::SetEnvironmentVariable("Path", $env:Path + ";C:\minishift", [EnvironmentVariableTarget]`


## Microsoft Store

http://woshub.com/how-to-uninstall-modern-apps-in-windows-10/

- Get-AppxPackage -AllUsers
- Get-AppxPackage -User \<user\>
- Remove-AppxPackage \<PackageFullName\>

To uninstall all Modern apps in the system account, run the following command: `Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online`

To uninstall all Modern apps for the current user: `Get-AppXPackage | Remove-AppxPackage`

If you need to uninstall the preinstalled apps for another user: `Get-AppXPackage -User test_user | Remove-AppxPackage`

uninstall all apps for all Windows 10 users, run this command: `Get-AppxPackage -AllUsers | Remove-AppxPackage`
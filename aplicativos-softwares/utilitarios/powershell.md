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



# GUI
- https://poshgui.com/ - Online GUI Designer

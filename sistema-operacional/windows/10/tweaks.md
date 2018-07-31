
# Tweaks


## Group Police Editor - Home Edition
https://www.itechtics.com/easily-enable-group-policy-editor-gpedit-msc-in-windows-10-home-edition/

## Segurança de Rede Wifi (publico, privado)
https://www.itechtics.com/change-network-type-windows-10/
Executar `secpol.msc` como administrador, e acessar > Configuração de Segurança > Políticas do Gerenciador de Listas de Rede


## Drivers
- Salvar backup dos drivers do windows 10. Execute na prompt como administrador
`dism /online /export-driver /destination:E:\ExportDrivers`


## Context Menu
Para adicionar um comando ao clicar com botão direito no windows Explorer
https://stackoverflow.com/questions/20449316/how-add-context-menu-item-to-windows-explorer-for-folders

```reg
# Para cliques sobre Pastas (Lados Esquerdo e Direito)
# Como administrador
HKEY_CLASSES_ROOT\Directory\shell

# Como usuario
HKEY_CURRENT_USER\Software\Classes\directory\shell


# Exemplo:
HKEY_CURRENT_USER\Software\Classes\directory\shell\Bash\command 
No valor padrão: D:\desenv\Git\git-bash.exe --cd="%1"

# Para clique fundo (background) do lado direito
HKEY_CURRENT_USER\Software\Classes\directory\Background\shell\Bash\command

Exemplo:
No valor padrão: cmd /c (start /b "%cd%" "D:\desenv\Git\git-bash.exe") && exit

```
Crie um arquivo bash.reg e adicione o conteúdo
```
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\Classes\directory]

[HKEY_CURRENT_USER\Software\Classes\directory\Background]

[HKEY_CURRENT_USER\Software\Classes\directory\Background\shell]

[HKEY_CURRENT_USER\Software\Classes\directory\Background\shell\Bash]

[HKEY_CURRENT_USER\Software\Classes\directory\Background\shell\Bash\command]
@="cmd /c (start /b \"%cd%\" \"D:\\desenv\\Git\\git-bash.exe\") && exit"

[HKEY_CURRENT_USER\Software\Classes\directory\shell]

[HKEY_CURRENT_USER\Software\Classes\directory\shell\Bash]
@="Bash"
"Icon"="D:\\desenv\\Git\\git-bash.exe"

[HKEY_CURRENT_USER\Software\Classes\directory\shell\Bash\command]
@="D:\\desenv\\Git\\git-bash.exe --cd=\"%1\""
```

## Performance

```reg
# http://sourcedaddy.com/windows-7/advanced-ntfs-settings.html

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem
NtfsDisable8dot3NameCreation =3 
NtfsMftZoneReservation = 4
```
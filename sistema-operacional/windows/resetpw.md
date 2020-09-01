#Reset Password 

Resetar a senha de usuários do windows (valido até win7)

usando um linux, instale `chntpw`


# Trocar senha de rede

`net user /domain USERNAME NEWPASS`
ou com powershell

`Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$newPass" -Force)`

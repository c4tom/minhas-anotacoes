# bindfs

## Permissions

https://bindfs.org/docs/bindfs.1.html#sect13

bindfs --create-for-group=developer -gdeveloper --create-with-perms=u+rw,g+rw,o+r -p ud+rwx,gd+rwx,od+rx,uf+rw,ug+rw,uf+r /home/projetos /home/projetos/

This ensures that:
- All files will be created with group: "local-users"
- All files will effectively have group "local-users" (regardless of what they actually have on disk)
- Newly created files will be read/write for the creator and group (similar to umask)
- All existing files will be editable and readable by user and group local-users while others can only read


Exemplos:
```bash
bindfs --create-for-group=www-data -gwww-data /win/desenv/__desenv_zips /var/www/html/__desenv

bindfs --create-for-user=www-data -uwww-data --create-for-group=www-data -gwww-data /win/Projetos/php /webphp

bindfs --create-for-user=www-data -uwww-data --create-for-group=www-data -gwww-data -p od+rx,of+r /projetos /www-data
```

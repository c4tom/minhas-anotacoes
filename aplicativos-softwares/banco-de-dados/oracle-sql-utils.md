

```sql
-- https://dataedo.com/kb/query/oracle/list-all-indexes-in-the-database
-- (A) all indexes, along with their columns, on objects accessible to the current user in Oracle database

select ind.index_name,
       ind_col.column_name,
       ind.index_type,
       ind.uniqueness,
       ind.table_owner as schema_name,
       ind.table_name as object_name,
       ind.table_type as object_type       
from sys.all_indexes ind
inner join sys.all_ind_columns ind_col on ind.owner = ind_col.index_owner
                                    and ind.index_name = ind_col.index_name
-- excluding some Oracle maintained schemas
where ind.owner not in ('ANONYMOUS','CTXSYS','DBSNMP','EXFSYS', 'LBACSYS', 
   'MDSYS', 'MGMT_VIEW','OLAPSYS','OWBSYS','ORDPLUGINS', 'ORDSYS','OUTLN', 
   'SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM', 'TSMSYS','WK_TEST',
   'WKPROXY','WMSYS','XDB','APEX_040000', 'APEX_PUBLIC_USER','DIP', 'WKSYS',
   'FLOWS_30000','FLOWS_FILES','MDDATA', 'ORACLE_OCM', 'XS$NULL',
   'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'PUBLIC')
order by ind.table_owner,
         ind.table_name,
         ind.index_name,
         ind_col.column_position;


-- (B) all indexes, along with their columns, on objects in Oracle database / If you have privilege on dba_indexes and dba_ind_columns
select ind.index_name,
       ind_col.column_name,
       ind.index_type,
       ind.uniqueness,
       ind.table_owner as schema_name,
       ind.table_name as object_name,
       ind.table_type as object_type       
from sys.dba_indexes ind
inner join sys.dba_ind_columns ind_col on ind.owner = ind_col.index_owner
                                    and ind.index_name = ind_col.index_name
-- excluding some Oracle maintained schemas
where ind.owner not in ('ANONYMOUS','CTXSYS','DBSNMP','EXFSYS', 'LBACSYS',
   'MDSYS', 'MGMT_VIEW','OLAPSYS','OWBSYS','ORDPLUGINS', 'ORDSYS','OUTLN',
   'SI_INFORMTN_SCHEMA','SYS','SYSMAN','SYSTEM', 'TSMSYS','WK_TEST',
   'WKPROXY','WMSYS','XDB','APEX_040000', 'APEX_PUBLIC_USER','DIP', 'WKSYS',
   'FLOWS_30000','FLOWS_FILES','MDDATA', 'ORACLE_OCM', 'XS$NULL',
   'SPATIAL_CSW_ADMIN_USR', 'SPATIAL_WFS_ADMIN_USR', 'PUBLIC')
order by ind.table_owner,
         ind.table_name,
         ind.index_name,
         ind_col.column_position;


--- Drop All Tables With Cascate Constraints
select 'DROP TABLE ' || TABLE_NAME || ' cascade constraints;' FROM USER_TABLES;

```


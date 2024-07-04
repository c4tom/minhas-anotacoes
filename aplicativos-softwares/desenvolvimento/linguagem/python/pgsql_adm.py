SELECT 
    n.nspname as schema_name,
    c.relname as table_name,
    t.tgname as trigger_name,
    pg_get_triggerdef(t.oid) as definition
FROM pg_trigger t
JOIN pg_class c ON c.oid = t.tgrelid
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE t.tgenabled = 'O'  -- 'O' significa que a trigger está habilitada
AND NOT t.tgisinternal  -- Exclui triggers internas criadas pelo sistema
ORDER BY schema_name, table_name, trigger_name;
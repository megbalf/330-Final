
select * from artists ;

select * from tracks ;

create table genres as
-- pulls the right columns for new table 
with x(genres, firstone, rest) as 
(select id, substr(genres, 1, instr(genres, ',')-1) 
    as firstone, substr(genres, instr(genres, ',')+1) 
    as rest 
    from artists where genres like "%,%"
-- This is grabbing all of the information from the original table
union all
     select id, substr(rest, 1, instr(rest, ',')-1) 
     as firstone, substr(rest, instr(rest, ',')+1) 
     as rest from x 
     where rest like "%,%"
     )
select id, 
    replace(replace(replace(firstone, '[',''), ']', ''),'''', '') 
    from x union all select 
    id, replace(replace(replace(rest, '[',''), ']', ''),'''', '') 
    from x where rest not like "%,%" 
order by id;




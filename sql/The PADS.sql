/* Matches de output but with two queries, script mode. */
select name || '(' || substr(occupation, 1, 1) || ')' as name
from occupations
order by name;
select 'There are a total of ' || count(occupation) || ' ' || lower(occupation) || 's.' as name
from occupations
group by occupation
order by count(occupation), occupation
;

/* Single resultset output. */
select name
from (select name || '(' || substr(occupation, 1, 1) || ')' as name
      from occupations
      order by name)
union all
select name
from (select 'There are a total of ' || count(occupation) || ' ' || lower(occupation) || 's.' as name
      from occupations
      group by occupation
      order by count(occupation), occupation)
;

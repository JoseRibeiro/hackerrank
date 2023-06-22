select *
from (select salary * months as totalsalary, count(employee_id) as earners
      from employee
      group by salary * months
      order by totalsalary desc)
where rownum = 1;
/*
   Explanation: you have a projection of 2 tables to sum, view_stats and submission_stats, so you can't join and group
   both at the same time because you`ll project view_stats X submission_stats, consequently the sum will be wrong.
   So, project contests, colleges, challenges and view_states first, then project the resultant (t1) to submission_stats
   and use a function like min or max to get just one result of total_view and total_unique_views (the sum is already
   done).
*/
select t1.contest_id,
       hacker_id,
       name,
       sum(total_submissions)          as stotal_submissions,
       sum(total_accepted_submissions) as stotal_accepted_submissions,
       max(stotal_views), /* min() works too. */
       max(stotal_unique_views) /* min() works too. */
from (select con.contest_id          as contest_id,
             hacker_id,
             name,
             sum(total_views)        as stotal_views,
             sum(total_unique_views) as stotal_unique_views
      from contests con,
           colleges col,
           challenges cha,
           view_stats v
      where 1 = 1
        and con.contest_id = col.contest_id
        and col.college_id = cha.college_id
        and cha.challenge_id = v.challenge_id
      group by con.contest_id,
               hacker_id,
               name) t1,
     colleges col,
     challenges cha,
     submission_stats s
where 1 = 1
  and t1.contest_id = col.contest_id
  and col.college_id = cha.college_id
  and cha.challenge_id = s.challenge_id
group by t1.contest_id,
         hacker_id,
         name
order by t1.contest_id
;
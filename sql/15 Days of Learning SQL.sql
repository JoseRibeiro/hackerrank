/*
 The first queries ranked_submissions, submissions_each_day and total_submissions_by_day are just to get the total
 submissions by each hacker, until that day.
 The top_submitter query gets the hacker_id that submitted most times that day.
 */
with ranked_submissions as (select distinct submission_date,
                                            hacker_id,
                                            dense_rank() over (partition by hacker_id order by submission_date) as dense_rank
                            from submissions),
     submissions_each_day as (select *
                              from ranked_submissions
                              where ((submission_date - to_date('2016-03-01')) + 1) = dense_rank),
     total_submissions_by_day as (select submission_date, count(hacker_id) as total_submissions
                                  from submissions_each_day
                                  group by submission_date),
     top_submitter as (select submission_date,
                              hacker_id,
                              count(hacker_id),
                              row_number() over (partition by submission_date order by count(hacker_id) desc, hacker_id) as row_number
                       from submissions
                       group by submission_date, hacker_id)
select total_submissions_by_day.submission_date,
       total_submissions_by_day.total_submissions,
       top_submitter.hacker_id,
       h.name
from hackers h,
     top_submitter,
     total_submissions_by_day
where top_submitter.hacker_id = h.hacker_id
  and total_submissions_by_day.submission_date = top_submitter.submission_date
  and top_submitter.row_number = 1
order by top_submitter.submission_date;
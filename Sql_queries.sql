create database P501;
use p501;
select * from finance_1;
select * from finance_2;

-- KPI 1--
select year(issue_d) as year_,sum(loan_amnt) as loan_amount from finance_1
group by year(issue_d)
order by year(issue_d);

-- KPI 2--
select grade,sub_grade,sum(revol_bal) as revol_balance
from
finance_1 f1 join
finance_2 f2 
on f1.id=f2.id
group by f1.grade,f1.sub_grade
order by f1.grade,f1.sub_grade;

-- KPI 3 --
select verification_status,round(sum(total_pymnt)) as total_payment
from
finance_1 f1 join finance_2 f2
on f1.id=f2.id
group by f1.verification_status;

-- KPI 3 with verified & source_verified merged --
select 
case 
when f1.verification_status="verified" or f1.verification_status="source verified"
then "verified"
else "not verified"
end as verification_stat,
round(sum(f2.total_pymnt)) as total_payment
from finance_1 f1 join finance_2 f2
on f1.id=f2.id
group by verification_stat;

-- KPI 4 --
select 
f1.addr_state as State,
year(f2.last_pymnt_d) as year_,
monthname(f2.last_pymnt_d) as month_,
f1.loan_status, count(f1.loan_status) as count_
from
finance_1 f1 join finance_2 f2
on f1.id=f2.id
group by state, year_,month_,loan_status
order by state,year_ asc,month_ asc;

-- KPI 5 --
select f1.home_ownership, year(last_pymnt_d) as year_of_last_pymnt,count(f2.last_pymnt_d) as count_of_last_payments
from finance_1 f1 join finance_2 f2
on f1.id=f2.id
group by home_ownership, year(last_pymnt_d)
order by home_ownership; 

/*문제1.
담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)*/
select first_name
		,manager_id
        ,commission_pct
        ,salary
from employees
where salary > 3000
and manager_id is not null
and commission_pct is null;

/*문제2. 
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name), 월급
(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하
세요
-조건절비교 방법으로 작성하세요
-월급의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)*/

-- 부서별 최고 월급받는 사원
select 	department_id
		,max(salary)
from employees
group by department_id;

-- 사원의 직원번호, 이름,월급,입사일(2001-01-13 토요일), 전화번호(515-123-4567), 부서번호 조회, 월급 내림차순.
select 	employee_id
		,first_name
        ,salary
        ,hire_date
        ,phone_number
        ,department_id
from employees
order by salary desc;

-- 합치기(조건절 비교)
select 	employee_id
		,first_name
        ,salary
        ,hire_date
        ,replace(phone_number,'.','-') 'phone_number'
        ,department_id
from employees
where (department_id , salary) in (select 	department_id
											,max(salary)
									from employees
									group by department_id) 
order by salary desc;

select * 
from employees;

/*문제3 
매니저별 담당직원들의 평균월급 최소월급 최대월급을 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균월급이 5000이상만 출력합니다.
-매니저별 평균월급의 내림차순으로 출력합니다.
-매니저별 평균월급은 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균월급, 매니저별최소월급, 매
니저별최대월급 입니다.
(9건)*/
select 	e.manager_id
		,m.first_name
		,round(avg(m.salary),0) aSalary
        ,max(m.salary)
        ,min(m.salary)
from employees e , employees m
where e.manager_id = m.employee_id
and m.hire_date >='2005/01/01'
group by e.manager_id
having aSalary>=5000
order by aSalary desc;

/*문제4.
각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)*/

-- d null 포함 . m null값 생략, e nullx
select	e.employee_id
		,e.first_name
        ,d.department_name
        ,m.first_name manager_name
from employees e left join departments d
				on e.department_id = d.department_id
                inner join employees m
                on e.manager_id = m.employee_id ;


/*문제5.
2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 월급, 입사일을 입사일 순서로 출력하세요*/
select employee_id
		,first_name
        ,salary
        ,hire_date
from employees
where hire_date >= '2005/01/01'
order by hire_date asc
limit 11,10;

/*문제6. 
가장 늦게 입사한 직원의 이름(first_name last_name)과 월급(salary)과 근무하는 부서 이름
(department_name)은?*/

-- 가장 늦게 입사한 날짜
select 	max(hire_date)
from employees;

-- 가장 늦게 입사한 직원의 이름, 월급, 부서 틀
select concat(e.first_name ,' ', e.last_name) 'first_name last_name'
		,e.salary
        ,d.department_name
from employees e, departments d
where hire_date in (가장늦게입사한 날짜)
and e.department_id = d.department_id;

-- 합치기
select concat(e.first_name ,' ', e.last_name) 'first_name last_name'
		,e.salary
        ,d.department_name
from employees e, departments d
where hire_date in (select 	max(hire_date)
					from employees)
and e.department_id = d.department_id;

/*문제7.
평균월급(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
(last_name)과 업무(job_title), 월급(salary)을 조회하시오.*/

-- 평균월급이 가장 높은 부서
select department_id
		-- ,avg(salary)
from employees
group by department_id
order by avg(salary) desc
limit 1;

-- 틀
select e.employee_id
		,first_name
        ,last_name
        ,job_title
        ,salary
        ,(최고 평균월급)
from employees e left join jobs j
				 on e.employee_id = j.employee_id
where department_id = (평균월급이 가장 높은 부서);

-- 합치기                             
select 	e.employee_id 사번
		,first_name 성
        ,last_name 이름
        ,job_title 업무명
        ,salary 월급
        ,(select avg(salary)
			from employees
			group by department_id
			order by avg(salary) desc
			limit 1) 부서평균월급
		,department_id '부서 아이디'
from employees e left join jobs j
				on e.job_id = j.job_id
where department_id  = (select department_id
						from employees
						group by department_id
						order by avg(salary) desc
						limit 1);

/*문제8. ??
평균 월급(salary)이 가장 높은 부서명과 월급은? (limt사용하지 말고 그룹함수 사용할 것)*/

-- 부서별 평균월급
select avg(salary) aSalary
from employees
group by department_id;

-- 평균월급중 최고 월급
select 	max(aSalary) mSalary
from (select department_id
			,avg(salary) aSalary
	  from employees
	  group by department_id) a;

-- 평균월급중 최고 월급인 부서
-- 틀
select	department_id
from employees 
where 평균월급 = (평균월급중 최고월급);

-- 합치기
select	department_id
		,avg(salary) aSalary
from employees
where aSalary = ()
group by department_id;

-- 합치기
select 	department_name
		,avgSalary
from departments d , (select 	a.department_id
								,max(aSalary) avgSalary
					 from (select department_id
									,avg(salary) aSalary
									from employees
									group by department_id) a
                                    group by department_id) s
where d.department_id = s.department_id;


/*문제9.
평균 월급(salary)이 가장 높은 지역과 평균월급은?*/
-- 평균월급이 가장 높은 부서--- 가 아닌가?
-- select 	department_id
-- 		,avg(salary) aSalary
-- from employees
-- group by department_id
-- order by avg(salary) desc;
-- limit 1;

-- 평균월급이 가장 높은 부서의 지역
-- select 	avg(salary) aSalary
-- 		,r.region_name
-- from employees e join departments d
-- 				on e.department_id = d.department_id
-- 				join locations l
--                 on d.location_id = l.location_id
--                 join countries c
--                 on l.country_id = c.country_id
--                 join regions r
--                 on c.region_id = r.region_id
-- where department_id = (평균월급이 가장 높은 부서); 

-- 합치기
select 	avg(e.salary) 
		,r.region_name
from employees e join departments d
				on e.department_id = d.department_id
				join locations l
                on d.location_id = l.location_id
                join countries c
                on l.country_id = c.country_id
                join regions r
                on c.region_id = r.region_id
group by r.region_name
order by avg(salary) desc
limit 1;


/*문제10. ??
평균 월급(salary)이 가장 높은 업무와 평균월급은? (limt사용하지 말고 그룹함수 사용할 것)*/
-- 평균 월급
select avg(salary)
from employees;

-- 평균월급중 가장 높은 업무와 평균 월급
select * 
from employees;


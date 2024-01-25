/*문제1.
평균 월급보다 적은 월급을 받는 직원은 몇명인지 구하시요.
(56건)*/

-- 평균 월급 구하기
select avg(salary) 
from employees;

-- 평균월급보다 적은 월급 받는 직원 몇명인지 뼈대
select count(*) 
from employees
where salary < (평균월급);

-- 합치기
select count(*) 
from employees
where salary < (select avg(salary) 
				from employees);


/*문제2. 
평균월급 이상, 최대월급 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 월급(salary), 평균월급, 최대월급을 월급의 오름차
순으로 정렬하여 출력하세요
(51건)*/

-- 평균월급, 최대 월급
select avg(salary) -- 6461.831776
		,max(salary) -- 24000.000
from employees;

-- 뼈대  
select employee_id
		,first_name
        ,salary
        ,avg(salary) aSalary
        ,max(salary) mSalary
from employees
where salary (평균월급 이상, 최대월급 이하를 받음)
group by aSalary
order by salary asc ;

-- 합치기
select employee_id
		,first_name
        ,salary
        ,(select avg(salary)from employees) as '평균 월급'
        ,(select max(salary)from employees) as '최대 월급'
from employees
where salary >= (select avg(salary)from employees) 
and salary <= (select max(salary)from employees)
group by employee_id
order by salary asc ;

/*문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
(state_province), 나라아이디(country_id) 를 출력하세요
(1건)*/

-- steven이 소속된 부서
select department_id -- 90
from employees
where first_name = 'Steven'
and last_name = 'king';

-- 부서가 있는 곳의 주소-locations를 출력하는 뼈대
select l.location_id
		,street_address
        ,postal_code
        ,city
        ,state_province
        ,country_id
from locations l right outer join departments d
				on l.location_id = d.location_id
where department_id = (스티븐 킹의 소속 부서);

-- 합치기
select 	l.location_id
		,street_address
        ,postal_code
        ,city
        ,state_province
        ,country_id
from locations l right outer join departments d
				on l.location_id = d.location_id
where department_id = (select department_id
						from employees
						where first_name = 'Steven'
						and last_name = 'king');

/*문제4.
job_id 가 'ST_MAN' 인 직원의 월급보다 작은 직원의 사번,이름,월급을 월급의 내림차순으로
출력하세요 -ANY연산자 사용
(74건)*/

-- job_id 가 'ST_MAN' 인 직원의 월급
select salary
from employees
where job_id = 'ST_MAN'; -- 값이 여러개(8000,8200,7900,6500,5800)

-- st_man인 직원의 월급보다 작은 직원의 사번,이름,월급을 월급의 내림차순으로 출력 
select employee_id
		,first_name
        ,salary
from employees
where salary < any(job_id 가 'ST_MAN' 인 직원의 월급)
order by salary desc;

-- 합치기(any)
select employee_id
		,first_name
        ,salary
from employees
where salary < any(select salary
				from employees
				where job_id = 'ST_MAN')
order by salary desc;

/*문제5. 
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name)과 월급
(salary) 부서번호(department_id)를 조회하세요
단 조회결과는 월급의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)*/
-- 각 부서별 최고의 월급
select 	department_id
		,max(salary) 
from employees
group by department_id;

-- 각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name)과 월급(salary) 부서번호(department_id) 출력, 월급의 내림차순으로 정렬
select  employee_id
		,first_name
        ,salary
        ,department_id
from employees
where salary in (각 부서별 최고의 월급)
order by salary desc;

-- 조건절 비교 
select  employee_id
		,first_name
        ,salary
        ,department_id
from employees
where (department_id , salary) in (select department_id
									,max(salary)
									from employees
									group by department_id)
order by salary desc;

-- 테이블 조인
select  e.employee_id
		,e.first_name
        ,e.salary
        ,e.department_id
from employees e,(select department_id
					,max(salary) maxSalary
					from employees
					group by department_id) m
where e.department_id = m.department_id
and e.salary = m.maxSalary
order by salary desc;

/*문제6.
각 업무(job) 별로 월급(salary)의 총합을 구하고자 합니다. 
월급 총합이 가장 높은 업무부터 업무명(job_title)과 월급 총합을 조회하시오
(19건)*/

-- 각 업무(job) 별로 월급(salary)의 총합
select 	job_id
		,sum(salary)
from employees
group by job_id;

-- 월급 총합이 가장 높은 업무부터 업무명(job_title)과 월급 총합을 조회
select j.job_title
		,(월급총합)
from jobs j left outer join employees e
			on j.job_id = e.job_id
order by 월급총합 desc;

-- 합치기
select j.job_title
		,s.sSalary
from jobs j ,(select job_id
					,sum(salary) sSalary
					from employees
					group by job_id) s
where j.job_id = s.job_id
order by sSalary desc;


/*문제7.
자신의 부서 평균 월급보다 월급(salary)이 많은 직원의 직원번호(employee_id), 이름
(first_name)과 월급(salary)을 조회하세요
(38건)*/
-- 자신의 부서 평균 월급
select department_id
		,avg(salary)
from employees
group by department_id;

-- 자신의 부서 평균 월급보다 월급(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 월급(salary) 조회
select employee_id
		,first_name
        ,salary
from employees
where salary > (자기 부서 평균 월급);

-- 합치기
select employee_id
		,first_name
        ,salary
from employees e , (select department_id
				,avg(salary) aSalary
				from employees
				group by department_id) a
where e.department_id = a.department_id
and e.salary > a.aSalary;

/*문제8.
직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 월급, 입사일을 입사일 순서로 출력
하세요*/
select employee_id
		,first_name
        ,salary
        ,hire_date
from employees
order by hire_date
limit 10,5 ;
/*************************************************************************
*  03일차 수업
*************************************************************************/
-- 단일행 함수
select first_name
		,salary
        ,round(salary ,2) 
from employees;

-- 그룹함수
-- 오류발생
select first_name
		,salary
        ,sum(salary)  -- 다른 함수 round()같은거 쓰면 됨. 그룹함수라고해서 특수한 애라 안된다. 같이 표현할 수 없는 이유는 다른애들은 값이 107개인데, sum()는 1개라 같이 표현하기가 어렵다. 
        -- 구별할 수 있는 방법: 하나하나 처리할 수 있는 단일행 함수, 대표값인 그룹함수로 구별함.(결과가 사각형으로 나오게 할 수 있는 모양인지 생각해보기)
from employees;

select sum(salary)
from employees;

-- -------------------------------------------------
# count()
-- -------------------------------------------------
select *
from employees;

select count(*) -- 다 합치는게 아닌 그중에서 제일 큰 값을 선택해줌. 
from employees;

select count(first_name)
from employees;

select count(manager_id) -- null값이 있으면 갯수가 -1되어서 106나옴. 칼럼명을 잘 선택해야한다. 0의 값이 있었으면 107개로 나옴. 
from employees;

select	count(*)
		,count(commission_pct) -- 얘는 값 1개씩해서 사각형으로 값이 나오기 때문에 여러개 써도된다.(사각형 유지)
from employees;

-- 월급이 16000 초과 되는 직원의 수는?
select count(*)
from employees
where salary > 16000;

-- -------------------------------------------------
# sum()
-- -------------------------------------------------
select sum(salary)
		,count(*) -- 얘까지는 나옴. 하나 값만 나와서
        ,first_name  -- 얘는 107개 나와서 사각형모양이 안나옴.
from employees;

-- -------------------------------------------------
# avg() - null 포함여부 주의 : NULL이 있으면 계산이 안됨. 명수에서 빠짐.
-- -------------------------------------------------
select count(*) 
		,sum(salary)
        ,avg(salary)
from employees;

-- -------------------------------------------------
# max() / min()
-- -------------------------------------------------

select count(*)
		,max(salary)
        ,min(salary)
from employees;

select max(salary) , first_name -- 을 쓰면 갯수가 1개 107개라 안나옴. 최대 salary를 받는 사람 이름은 나중 방법으로 같이 구할 수 있음. 
from employees;

-- -------------------------------------------------
# GROUP BY절  null도 한 그룹으로 잡힌다. 그룹으로 묶이면 그룹함수는 보통 쓸수있음. 그룹으로 묶은 기준은 select로 조회 가능. 다른 값들은 (ex first_name 같은건) 쓰기 어렵다. 
-- -------------------------------------------------
select department_id
		,sum(salary)
        ,count(salary)
from employees
group by department_id;

select  department_id
		,job_id
		,count(*)
from employees
group by department_id , job_id;

# 월급(salary)의 합계가 20000 이상인 부서의 부서 번호와 , 인원수, 월급합계를 출력하세요
select  department_id
		,count(*)
        ,sum(salary)
from	employees
-- where sum(salary) >= 20000  -- 여기에 쓰면 실행 안됨. 순서 : from -> where -> group by -> having ->select -> order by순이다.  
-- 순서보기 어려우면 외워. where절에는 그룹함수를 쓸 수 없다. 3교시 11:45 - 그럼 아예 20000이 넘는다는 못쓰냐? ㄴㄴ  having 절이 존재
group by department_id;

-- -------------------------------------------------
# HAVING절  12:00
-- ------------------------------------------------- 
select  department_id
		,count(*)
        ,sum(salary)
from employees
group by department_id
having sum(salary) >= 20000
and department_id = 100;

-- -------------------------------------------------
# if~else문 
-- -------------------------------------------------
select first_name
		,commission_pct
        ,if(commission_pct is null,0 ,1) as state
from employees;

-- -------------------------------------------------
# case~end문 
-- -------------------------------------------------
/* 직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
 실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1,
'SA_REP' 월급+월급*0.2,
'ST_CLERK' 면 월급+월급*0.3
그외에는 월급으로 계산하세요 */

select employee_id
		,salary
        ,job_id
        ,case   when job_id = 'AC_ACCOUNT' then  salary+salary*0.1
				when job_id = 'SA_REP' then  salary+salary*0.2
                when job_id = 'ST_CLERK' then  salary+salary*0.3 
				else salary
		end as realSalary
        -- ,salary as realSalary
from employees;

/*직원의 이름, 부서번호, 팀을 출력하세요
팀은 코드로 결정하며 부서코드가
10~50 이면 'A-TEAM'
60~100이면 'B-TEAM' 
110~150이면 'C-TEAM' 
나머지는 '팀없음' 으로
출력하세요.*/

select first_name
		,department_id
        ,case   when department_id between 10 and 50 then 'A-TEAM'
				-- when department_id >= 10 and department_id <= 50 then 'A-TEAM' 로 쓸수도있다.
				when department_id between 60 and 100 then 'B-TEAM'
                when department_id between 110 and 150 then 'C-TEAM'
                else '팀없음'
		end as 팀
from employees;

-- -------------------------------------------------
# join 
-- -------------------------------------------------
-- 사원이름, 부서번호 107개
select first_name
		,department_id
from employees;

-- 부서명 27개
select *
from departments;

-- join 그냥 불러오면 107*27  =2889개
select first_name
		,department_name
        ,department_id -- 테이블이 employees인지, departments인지 모름. 둘다 들어와있으니까... 다른건 알아서 찾아오는데 중복되어있는건 둘중 뭔지 몰라서 못가져옴
from employees , departments;

select first_name
		,department_name
        ,employees.department_id -- 어떤 테이블인지 알려주기
        ,departments.department_id
from employees , departments;

-- 테이블 별명정하기
-- 겹치지 않는 컬럼명은 테이블 별명 안써도됨. 겹치는건 컬럼명 꼭 쓰기
-- 조건절 사용한 equi join
select e.first_name
		,d.department_name
        ,e.department_id 
        ,d.department_id
from employees e, departments d
where e.department_id = d.department_id;

-- inner join 사용한 equi join
select * 
from employees e 
inner join departments d
on e.department_id = d.department_id;

#모든 직원이름, 부서이름, 업무명 을 출력하세요 *3개의 테이블

select e.first_name
		,d.department_name
		,j.job_title
        ,j.job_id
from employees e
inner join departments d
	on e.department_id = d.department_id
inner join jobs j
	on e.job_id= j.job_id;

select e.first_name
		,d.department_name
        ,j.job_title
        ,j.job_id
from employees e, departments d, jobs j
where e.department_id = d.department_id 
and e.job_id = j.job_id ;

-- 이름, 부서번호, 부서명, 업무아이디, 업무명, 도시아이디, 도시명
-- 직원(이름, 부서번호, 업무아이디)
-- 부서(부서번호, 부서명)
-- 업무(업무아이디, 업무명, 도시 아이디)
-- 도시(도시아이디, 도시명)

select e.first_name
	,e.department_id -- 같이 매칭시켜서 어차피 같은거임. 둘중에 하나만 써줘도 된다.
    ,d.department_name -- 같이 매칭시켜서 어차피 같은거임. 둘중에 하나만 써줘도 된다.
    ,e.job_id
    ,j.job_title
    ,d.location_id
    ,l.location_id
    ,l.city
from employees e, departments d, locations l, jobs j 
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.job_id = j.job_id;


select  e.first_name
	,e.department_id 
    ,d.department_name
    ,e.job_id
    ,j.job_title
    ,d.location_id
    ,l.location_id
    ,l.city
from employees e
inner join departments d on e.department_id = d.department_id
inner join jobs j on e.job_id = j.job_id
inner join locations l on d.location_id = l.location_id;


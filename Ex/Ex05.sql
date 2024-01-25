/********************************
* 05일차 수업 SubQuery
*********************************/


/* 'Den' 보다 월급을 많은 사람의 이름과 월급은?

1. 'Den'의 월급을 구한다. ex) 5000
2. 직원테이블에서 Den월급(ex 5000)보다 많은 사람을 구한다.
3. 질문을 합친다.
*/

-- 1.
select salary
from employees
where first_name = 'Den';

-- 2.
select * 
from employees
where salary > 11000;

-- 합치기
select first_name
		,salary
from employees
where salary > (select salary
				from employees
				where first_name = 'Den');
                
                
/* 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
	1. 직원테이블에서 우러급 1000원을 받는 사람을 구한다.
    2. 1000 <-- 직원테이블에서의 최소 월급(이라 가정)
    3. 두개를 합친다.(= 질문을 하나로)
*/

select min(salary) 
from employees;

select first_name
		,salary
        ,employee_id
from employees
where salary =(select min(salary) 
				from employees);
                
/* 평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요?
	1. 직원테이블에서 평균월급을 구한다 avg()이용-->10000
	2. 직원테이블에서 월급<10000 인 직원을 구한다
	3. 질문을 1개로 합친다
*/

select avg(salary)
from employees;

select first_name
		,salary
from employees
where salary<(select avg(salary)
				from employees);
              
              

-- -----------------------------------
# SubQuery   In
-- -----------------------------------

/*부서번호가 110인 직원의 급여와 같은 월급을 받는 모든 직원의 사번, 이름, 급여를 출력하세요
	1. 전체: 직원테이블에서 월급이 10000인 직원 구하기
	2. 부서번호가 110인 직원의 월급 구하기  --> 10000
	3. 합치기
*/

select *
from employees
where salary = (10000  -- > 부서번호가 110인 직원의 월급);

select salary
from employees
where department_id = 110; -- 값이 하나가 와야하는데 2개가 존재함. 그리고 사람이 들어오고 나감에 따라 값이 5개일수도, 1개일수도 있음.

select employee_id
		,first_name
        ,salary
from employees
where salary in (select salary
				from employees
				where department_id = 110);
                
-- 또는

select * 
from employees
where salary in (12008.00 , 8300.00);

select employee_id
		,first_name
        ,salary
from employees
where salary = 12008
or salary = 8300;

/* 각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요
	1. 각부서별 최고월급을 구한다 --> 1이상  100부서는 10000,   200번부서는 20000)
	2. 직원테이블에서 월급이 10000 또는 20000인 구한다
	3. 합친다
*/
-- 값이 이상하게 나옴(departmet_id가 하나만 나와야하는데 여러개 나옴)
select first_name
		,salary
        ,department_id
from employees
where salary in(select max(salary) 
				from employees
				group by department_id);

-- 부서별 최고 월급
select 	department_id
		,max(salary) 
from employees
group by department_id;

-- 급여 + 아이디도 같이 비교해야함. 안그럼 다른 부서의 급여가 같은 사람들도 자꾸 값이 불러와짐 ->  where절에서 겹치지않게 기준을 하나 추가해주고, 뒤에 비교할 값도 추가함(부서번호와 우러급이 동시에 만족하는 직원만 결과에 포함되어야함)
-- in 문법 확장 / 여러가지 칼럼을 동시에 비교가능. 컬럼의 갯수와 데이터의 갯수가 일치해야함.
select first_name
		,salary
        ,department_id
from employees
where (department_id,salary) in( (10,4400), (20,13000), (30,11000)); -- (아이디, 월급이 쌍을 이뤄야함) 이 부서에 이 월급인 애를 데려온다.

-- 최종 합치기
select first_name
		,salary
        ,department_id
from employees
where (department_id, salary) in (select department_id, max(salary) 
									from employees
									group by department_id);
                                    
/*
가장 적게 월급을 받는 직원의 이름, 월급은?*/

select min(salary)
from employees;

select salary
		,first_name
        ,hire_date
        ,phone_number
        ,email
from employees
where salary =(select min(salary)
				from employees);
                
                
/*부서별 최고 월급, 이름  --> in --> in확장*/

-- -----------------------------------
# Sub Query    Any(or연산)
-- -----------------------------------

/*부서번호가 110인 직원의 급여보다 큰 모든 직원의 이름, 급여를 출력하세요(or연산 --> 8300보다 큰)*/

-- 월급이 15000보다 큰 직원의 이름, 급여를 출력하세요
select first_name
		,salary
from employees
where salary > 15000;

-- 부서번호가 110인 직원의 월급
select salary
from employees
where department_id = 110;

select first_name
		,salary
from employees
where salary > any (select salary -- in은 같아만 된다. 포함 안되는건 안됨
					from employees
					where department_id = 110);
                
-- -----------------------------------
# Sub Query    All
-- -----------------------------------
/* 부서번호가 110인 직원의 급여 보다 큰 모든 직원의 이름, 급여를 출력하세요.(and연산--> 12008보다 큰) */
select salary
from employees
where salary > 15000;

select first_name
		,salary
from employees
where salary >ALL(select salary -- in은 같아만 된다. 포함 안되는건 안됨
				from employees
                where department_id = 110);
              
-- 조건절 조인

/*각 부서별로 최고급여를 받는 사원을 출력하세요*/

-- 부서별 최고급여를 구한다.
select department_id
		,max(salary)
from employees
group by department_id;

-- 직원테이블에서 (부서번호, 최고월급)이 동시에 만족하는 직원만 구한다.
select employee_id
from employees
where (department_id, salary) in (select department_id
								,max(salary) 
								from employees
								group by department_id);

select * 
from employees e,(select department_id -- 이런 테이블 있다고 가정하듯이 씀 (join)
					,max(salary) maxSalary -- 이름을 붙여줘서 max(salary)를 쉽게 비교해줌
					from employees
					group by department_id) s 
where e.department_id = s.department_id -- 여길 해주면서 같은 값만 쓸 수 있도록 안쓰는 애들은 제거해줌
and e.salary = s.maxSalary ;                                


-- -----------------------------------
# limit    문장의 맨끝에 들어감. (order by보다도 더 뒤에)
-- -----------------------------------
select *
from employees
order by employee_id asc
limit 0,5; -- 1부터 5개

select employee_id
		,first_name
        ,salary
from employees
order by employee_id asc
limit 5 offset 0; -- 1부터 5개

select * 
from employees
order by employee_id asc
limit 4; -- 처음부터 4개


/*07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은"*/
select  first_name
		,salary
		,hire_date
from employees 
where hire_date >= '07/01/01'
and hire_date < '08/01/01'
order by salary desc
limit 2,5;

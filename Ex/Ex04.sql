-- -------------------------------------------------
# left outer join 
-- -------------------------------------------------
select department_id, -- 106(null : 1)
		first_name  -- 107
from employees;

select 	department_id -- 27
		,department_name -- 27
from departments; -- 27

select e.department_id -- 106
		,e.first_name -- 107
        ,d.department_name -- 106
from employees e left outer join departments d -- 'outer'는 생략 가능
	on e.department_id = d.department_id; -- 107 ( employee에 있는 null값 1개도 포함되어 나옴)

-- -------------------------------------------------
# right outer join 
-- -------------------------------------------------    
select *
from departments; -- null인 값들도 나올 수 있게 해줘야함. ex)학원 5조를 만들었는데 1조는 다 중탈함. 그래도 행정상 빠지면 안되서 값이 나오긴해야함. 


select * 
from employees e  -- 122
right outer join departments d  -- 27
	on e.department_id = d.department_id;

select first_name  -- 16개값 null
		,d.department_id
        ,d.department_name
from employees e
right outer join departments d
	on e.department_id =  d.department_id;

-- outer join (right <-> left ) : 아래 두가지는 같다. 
select * 
from employees e
right outer join departments d
	on e.department_id = d.department_id;

select * 
from departments d
left outer join employees e
	on e.department_id = d.department_id;

-- --------------------------------------------

select first_name
		,e.department_id
        ,d.department_name
from departments d 
left outer join employees e
	on e.department_id =  d.department_id;
    
-- 킴벌리를 보여주고싶어
select 	e.department_id	
		,e.first_name
        ,d.department_name
from employees e
left outer join departments d
	on e.department_id  = d.department_id; -- 107개
    
-- 왼쪽을 기준을
select e.department_id	
		,e.first_name
        ,d.department_name
from employees e
right outer join departments d -- 27개의 부서를 다 보여달라
    on e.department_id = d.department_id; -- 122개
    
    
-- -------------------
(select e.employee_id
		,e.department_id	
		,e.first_name
        ,d.department_name
from employees e left outer join departments d
	on e.department_id  = d.department_id)
union
(select  e.employee_id
		,e.department_id	
		,e.first_name
        ,d.department_name
from employees e right outer join departments d -- 27개의 부서를 다 보여달라
    on e.department_id = d.department_id)
;

-- self join

select employee_id
		,first_name
        ,manager_id -- 자기 정보를 자기가 가지고 있다. 데이비드는 알렉산더 메니저다. 103번. 왜 따로 안만듦? 정보 변경되었을때 두군데서 바꿔야한다. 실수가 생길 수 있음
        ,department_id
        ,job_id
from employees;

select * 
from departments;

-- 메니저라는 테이블이 없어서 안나옴 - 오류
select * 
from employees e 
	, manager m
where e.manager_id = m.employee_id;

-- 직원, 부서
-- 직원이름, 부서이름 , 부서번호, 직원번호
select  e.first_name
		,d.department_name
from employees e 
	, departments d
where e.manager_id = d.department_id;


select e.employee_id
		,e.first_name
        ,m.first_name  manager_name-- 가상의 메니저 테이블에서 가져왔다고 생각, 그래서 m에서 불러와야햔다.
from employees e 
, employees m  -- 가상으로 테이블 2번 불러올 수 있다. 이때는 별명 설정이 필수. 가상으로 메모리에 올리는것. (원본을 터치하는것 아님)
where e.manager_id = m.manager_id;

select  salary
		,salary
from employees; -- 같은 값도 2번 불러올 수 있는것처럼 위에도 가능하다. 


-- 잘못된 조인
-- salary와 location의 값이 같은게 있지만 서로 연관성이 없다! 주의하기
select e.first_name
		,e.salary
        ,l.location_id
        ,l.street_address
        ,l.city
from employees e, locations l
where e.salary = l.location_id;

-- subQuery 질문을 2번하는걸 1번으로 줄여서 쓰는것. 쿼리문안에 있는 subQuery
-- 'Den' 보다 월급을 많은 사람의 이름과 월급은?
-- Den의 월급을 구한다. 
select first_name
		,salary
from employees
where first_name = 'Den'; -- 딘 월급 : 11000

-- 전체
select first_name	
		,salary
from employees
where salary >= 11000;

-- 합치기
select first_name	
		,salary
from employees
where salary >= (select salary
					from employees
					where first_name = 'Den');
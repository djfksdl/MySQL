/***************************************************************************
* 복습
****************************************************************************/

select *
from employees;

select first_name, 
	   salary,
       salary*12
from employees;

#기본 구조
select concat(first_name,'-',last_name) as name,
	   salary,
       salary*12
from employees;

# 현재시간 보고싶은데 107개를 같은 결과를 굳이 볼 필요 없음. 문장 구조때문에 가상의 더미 테이블(dual)을 써서 하면 됨
select now()
from dual;

#다른 데이터베이스에서는 위에 같은 구조가 기본구조인 경우도 있어서 알고있기. 여기서는 최소가 밑에 쓰면 됨. MYSQL은 두개 다 지원함
select now();

#이건 말이 안됨. 테이블 안에 있는 명이라서 테이블 불러와줘야함. 위에 now()는 현재 시간이라서 테이블 상관없음
select frist_name;

select first_name, '남' as gender  #꼭 컬럼 명 아니라 이렇게 써도됨. 실제는 데이터가 없음. ex)군대 성별 남.추가  / as는 생략 가능.
from employees;

-- where절
select first_name, salary
from employees
where salary != 17000; -- 자바랑 다르게 = 은 ==이 아니라 그냥 =으로 쓰면 됨!

-- 비교 연산자, 조건이 여러개일때, between, insert
-- --------------------------------------------------------------------------------

select * 
from employees
where binary first_name = 'JoHn'; #안에 대소문자 구별x. binary 쓰면 대소문자 구별됨

-- like 연산자
select first_name, 
		last_name,
		salary
from employees
where first_name like 'L%';

#이름에 am 을 포함한 사원의 이름과 월급을 출력하세요
select first_name,
		salary
from employees
where first_name like '%am%';

#이름의 두번째 글자가 a 인 사원의 이름과 월급을 출력하세요
select first_name,
		salary
from employees
where first_name like '_a%'; -- 자리수 명확할때는 _를 써준다. 모를때는 %를 써줘야함.

#이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name, salary
from employees
#where first_name like '___a'; -- 뒤에 %가 안붙으면 전체 글자수가 4자리임을 나타냄
where first_name like '___a%';

#이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '_a__';

-- null
select  first_name, 
		salary,
		commission_pct,
        salary*commission_pct
from employees
where salary between 13000 and 15000;

-- is null, is not null

select * 
from employees
where commission_pct is null ;
#주의 where commision_pct = null 



#커미션비율이 있는 사원의 이름과 월급 커미션비율을 출력하세요
select first_name
		,salary
		,commission_pct
from employees
where commission_pct is not null ;

#담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요
select first_name,
		manager_id,
        commission_pct
from employees
where manager_id is null
and  commission_pct is null;

#부서가 없는 직원의 이름과 월급을 출력하세요
select first_name,
		salary
from employees
where department_id is null ;

-- ORDER BY
select first_name,salary
from employees
where salary >= 10000
order by salary desc ;  -- desc 내림차순 / asc는 오름차순

select * 
from employees
order by employee_id asc;

select first_name, salary
from employees
order by first_name asc;

select first_name, hire_date,salary
from employees
order by hire_date desc;

-- 1.최근 입사한 순, 2.입사일이 같으면 월급이 많은 사람부터
select first_name, hire_date
from employees
order by hire_date desc, salary desc;

#부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select department_id,
		salary,
        first_name
from employees
order by department_id asc;

#월급이 10000 이상인 직원의 이름 월급을 월급이 큰직원부터 출력하세요
select first_name,
		salary
from employees
where salary >= 10000
order by salary desc;

#부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터 부서번호 월급 이름을 출력하세요
select department_id, salary, first_name 
from employees
order by department_id asc,salary desc;

#직원의 이름, 급여, 입사일을 이름의 알파벳 올림차순으로 출력하세요
select first_name,
		salary,
		hire_date
from employees
order by first_name asc;

#직원의 이름, 급여, 입사일을 입사일이 빠른 사람 부터 출력하세요
select first_name,
		salary,
        hire_date
from employees
order by hire_date asc;


#data라고 별명으로 쓴건 식에 못쓴다. 작동하는 순서가 from->where-> select -> order by이라 date로 주면 위에 hire_date가 만들어지기 전이라 별명으로 쓰기 어렵다. 
select first_name,
        hire_date date,
        department_id
from employees
where hire_date >= '2007-01-01'
order by date asc; -- 얘는 select문 다음으로 작동되기 때문에 여기선 쓸 수 있다.

/********************************************************************
* 2일차 수업
*********************************************************************/

-- 단일행 함수
-- 단일행 함수 > 숫자함수

-- round() : 반올림
select  round(123.123 ,2)
		,round(123.126 ,2)
        ,round(234.567 ,0)
        ,round(123.456 ,0)
        ,round(123.456)
        ,round(123.126 ,-1)
        ,round(125.126 ,-1)
        ,round(123.126 ,-2)
from dual;

-- ceil(숫자):올림
select ceil(123.456)
		,ceil(123.789)
		,ceil(123.7892313)
		,ceil(987.1234);
        
-- floor(숫자):내림
select floor(123.456)
		,floor(123.789)
		,floor(123.7892313)
		,floor(987.1234);
        
-- truncate(숫자,m):버림
select truncate(1234.34567, 2)
		,truncate(1234.34567, 3)
		,truncate(1234.34567, 0)
		,truncate(1235.34567, -2);
        
select first_name
		,salary
        ,ceil(salary/30) as 일당
from employees
order by salary desc;   

-- Power(숫자, n),  Pow(숫자, n):숫자의 n승
select pow(12,2), power(12,2);

-- Sqrt(숫자): 숫자의 제곱근
select sqrt(144);

-- sign(숫자): 숫자가 음수이면 -1, 0이면 0, 양수이면 1
select sign(123)
		,sign(0)
		,sign(-123);

-- ABS(숫자) :절댓값
select  abs(123)
		,abs(0)
        ,abs(-123);
        
-- greatest(x,y,z,...) : 괄호안의 값중 가장 큰 값
select greatest(2,0,-2)
		,greatest(4 ,3.2, 5.25)
        ,greatest('B','A','C','c'); -- 아마 대문자 다음 소문자라 코드값이 c가 더 크지않을까싶음 A1 B2 C3 ...Z26 a27 b28..
# from dual 은 생략가능

select employee_id
		,manager_id
        ,department_id
		,greatest(employee_id, manager_id, department_id) -- 한줄마다 결과가 나야하니까 107개가 나옴. 3값중에서 제일 큰 값
from employees;

select least(2 ,0,-2)
		,least(4,3.2,5.25)
        ,least('B','A','C','c')
from dual;

-- 단일행 함수 > 문자함수
-- CONCAT(str1, str2, ..., strn): str1, str2, ..., strn을 연결
select concat('안녕','하세요')
	from dual;
    
select concat('안녕',' ' ,'하세요') -- 쌍따옴표도 가능. 안에 기호 넣을때 "''"해야 작은 따옴표를 인식 가능. '""'는 알아서 인식가능. 바꿔쓰거나 섞어쓸때도 있다. 
from dual;

select concat(first_name, last_name)
from employees;

-- CONCAT_WS(s, str1, str2 ,,,strn): str1, str2, ..., strn을 연결 중간에 끼워넣어짐
select concat_ws('-','abc','123','가나다') 
from dual;

select concat_ws('-',first_name, last_name, salary)
from employees;

-- - LCASE(str) 또는 LOWER(str): str의 모든 대문자를 소문자로 변환
select first_name
		,lcase(first_name)
        ,lower(first_name)
        ,lower('ABCabc!@#$^')
from employees;

-- UCASE(str) 또는 UPPER(str): str의 모든 소문자를 대문자로 변환
select first_name
		,ucase(first_name)
        ,upper(first_name)
        ,upper('ABCabc!@#$^')
         ,upper('가나다라마바사')
from employees;

-- 문자개수
select 	first_name,
		length(first_name),
        char_length(first_name),
        character_length(first_name)
from employees;

select 	length('a')
        ,char_length('a')
        ,character_length('a')
from dual;


select 	length('가') -- 값이 다르게 나옴. 바이트를 나타냄. 영어만 쓰는 문화권이면 상관없지만 우리는 섞어쓰기때문에 글자 길이 나타내려면 밑에 2개를 쓰는게 낫다.
        ,char_length('가')
        ,character_length('가')
from dual;

-- SUBSTRING(str, pos, len) 또는 SUBSTR(str, pos, len):
select first_name,
		substr(first_name, 1, 3)
        ,substr(first_name, 2, 2)
        ,substr(first_name, -3, 2)
from employees
where department_id = 100;

select 	substr('901112-1234567', 8, 1),     -- 성별  
 	    substr('901112-1234567', -7, 1),    -- 성별 뒤에서 계산
        substr('901112-1234567', 1, 2),     -- 년도
        substr('901112-1234567', 3, 2),     -- 월  
        substr('901112-1234567', 5, 2)      -- 일
from dual;

-- LPAD(str, len, padstr): PRAD(str,len,padstr) 왼쪽에 빈 공간을 *로 채우기 글자수맞춰서
select first_name 
		,lpad(first_name, 10, '*')
        ,rpad(first_name, 10, '*')
from employees;

-- Trim(str)
select concat('|','           안녕하세요      ','|')
		,concat('|', trim('           안녕하세요      '),'|')
        ,concat('|', ltrim('          안녕하세요         '),'|')
        ,concat('|', rtrim('          안녕하세요         '),'|')
from dual;

--  REPLACE(str, from_str, to_str): str에서 from_str을 to_str로 변경 /  글자수에 구애받지 않고 그냥 대체해버림
select  first_name
		,replace(first_name, 'a', '*')
        ,replace(first_name, substr(first_name, 2,3), '***') 
from employees
where department_id = 100;

-- 단일행 함수 > 날짜 함수
select current_date(), curdate();
select current_time(), curtime();
select current_timestamp(), now();

-- 시간은 숫자로 저장이 되어서 계산이 됨. 

-- 날짜 시간 계산 함수
select adddate('2021-06-20 00:00:00', INTERVAL 1 YEAR), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 MONTH), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 WEEK), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 DAY), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 HOUR), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 MINUTE), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 SECOND)
;

select subdate('2021-06-20 00:00:00', INTERVAL 1 YEAR), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 MONTH), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 WEEK), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 DAY), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 HOUR), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 MINUTE), 
		adddate('2021-06-20 00:00:00', INTERVAL 1 SECOND)
; 

-- DATEDIFF(): TIMEDIFF():  두 날짜시간 간 시간차
select	datediff('2021-06-21 01:05:05', '2021-06-21 01:00:00'),	
		timediff('2021-06-21 01:05:05', '2021-06-19 01:00:00')
from dual;
select 	first_name,
		hire_date,
        round(datediff(now(), hire_date)/365, 1) workday
from employees
order by workday desc;

-- 변환함수
--  DATE_FORMAT(date, format): date를 format형식으로 변환
select 	now(),
		date_format(now(), '%y-%m-%d %H:%i:%s' ),
        date_format(now(), '%Y-%m-%d(%a) %H:%i:%s %p')
from dual;


-- STR_TO_DATE(str, format) : str을 format형식으로 변환
-- 날짜 모양의 문잘열을 날짜형으로 인식하지 못해 -가 계산되지 않는다
select datediff('2021-June-04' , '2021-6-01'); -- 형식이 달라서 계산이 인됨

-- '2021-Jun-04'을 '%Y-%b-%d' 형식으로 해석해서 올바른 날짜형으로 반환
select str_to_date('2021-Jun-04', '%Y-%b-%d')
from dual;

-- '2021-06-01', '%Y-%m-%d' 형식으로 해석해서 올바른 날짜형으로 반환
select str_to_date('2021-06-01', '%Y-%m-%d')
from dual;

-- 각각의 문자열을 날짜형으로 변환시켜서 계산함
select datediff(str_to_date('2021-Jun-04', '%Y-%b-%d'), str_to_date('2021-06-01', '%Y-%m-%d')) 
from dual;

-- 상식선의 날짜표시인 경우 그냥 계산된다
select datediff('2021-06-04', '2021/06/01')
from dual;

-- FORMAT(숫자, p): 숫자에 콤마(,) 를 추가, 소수점 p자리까지 출력
select  format(1234567.89, 2),
		format(1234567.89, 0),
        format(1234567.89, -5) -- 0이랑 똑같음.
from dual;

-- ifnull() 값이 null일때 기본값 세팅
select first_name, ifnull(commission_pct, 0) -- ifnull(commission_pct, '없음') 없음은 별로 좋지 않음. 하나는 숫자고, 하나는 글자가 되어버리기 때문에 나중에 자바에서 값을 담을때 혼란
from employees;





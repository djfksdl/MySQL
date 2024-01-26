-- 작가 테이블 만들기 -- 이거부터 만들어야지 밑에 foreign key로 연결할때 찾을 수 있다. 테이블 만드는데도 순서가 있다. 

create table author (
	author_id int primary key
    ,author_name varchar(100) NOT NULL
    ,author_desc varchar(500) 
);

-- book 테이블 만들기(작가 테이블이랑 연결)

create table book (
	book_id int primary key -- not null + unique
    ,title varchar(100) not null
    ,pubs varchar(100)
    ,pub_date datetime
    ,author_id int -- 연결하는건 다음 턴(줄)에서 설정한다. 여기서 테이블 컬럼 설정이 끝난거!
    ,constraint book_fk foreign key(author_id) -- 이름이 서로 같아야만 연결되는거 아님! ()안에 넣은 것들이 서로 연결되는것이다. / 본인테이블 정보 하나
    references author(author_id) -- 연결하는 정보 하나
);

-- 작가등록
-- 묵시적 방법 - 테이블 생성시 정의한 순서대로 들어가는 중
insert into author values(1,'박경리','토지작가'); 

-- 명시적 방법 - 지정되지 않은 컬럼은 null자동 입력
insert into author(author_id , author_name)
values(2,'이문열');

insert into author(author_name, author_id)
values('황일영', 3);

insert into author(author_id, author_name) -- 2번이라는 pk가 겹쳐서 안됨. (unique가 걸림) -> 4로 변경하면 값 들어감
values(4, '정우성');

insert into author(author_name) 
values('박명수');

insert into author
values(5, '김종국' , null);

-- 작가 수정
update author 
set author_name = '기안84' 
	,author_desc = '웹툰작가'
where author_id = 3;

update author
set author_name = '정우성'
	,author_desc = '영화배우' -- 이렇게 하면 정우성을 정우성으로 바꾸는것이다. 
 ;   
 
update author
set author_desc = '영화배우' -- 이렇게만 하면 desc를 다 영화배우로 바꾸는것이다. 밑에 where절을 추가해서 4번이라고 명시해줘야함. 
where author_id= 4; -- 예전에는 빼먹으면 그냥 추가가 되었는데 요즘버전은 막아놔서 경고문 뜸! 
 
 -- 작가 삭제
 delete from author
 where author_id = 5; -- 보통 key값으로 많이 지운다. / where절 안써주면 전체 값들이 사라진다.

 delete from author
 where author_name = '이문열'; -- 셋팅값 바꾸면 쓸수있긴함. 이 버전은 안됨!
    
select * from author;

select * from book;
insert into book
values(1,'우리들의 일그러진 영웅','다림','1998-02-22' ,2);
insert into book
values(2,'삼국지','민음사','2002-03-01', 2);
insert into book
values(3,'토지','마로니에북스','2012-08-15', 1);
insert into book
values(4,'오직두사람','문학동네','2017-05-04', null); -- 만약 null값에 없는 6번을 넣으면 있는지 뒤져보고 없으니 경고뜸. 

select 	b.book_id
		,b.title
		,b.pubs
        ,b.pub_date
        ,a.author_name
        ,a.author_desc
from book b, author a
where b.author_id = a.author_id;


drop table book; -- 이거먼저 안지우면 작가 테이블과 연결된게 있어서 작가가 안지워짐.
drop table author; -- 작가는 아무도 사용하지 않으면 지울 수 있다. author_id가 연결되어있고, 그걸 쓰려고 쓴거라 얘 먼저 지우면 안지워짐

-- 작가테이블 auto_increment
create table author(
	author_id int auto_increment primary key
    ,author_name varchar(100) not null
    ,author_desc varchar(500)
);

insert into author(author_name, author_desc)
values('이문열','경북 영양');
insert into author(author_name, author_desc)
values('박경림','경남 통영');

insert into author
values(null ,'유시민','17대 국회원');

select * from author;

select last_insert_id() ;
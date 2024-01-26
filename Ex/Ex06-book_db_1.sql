-- 데이터 베이스(스키마) 접속
use book_db; -- 하나밖에 없어서 굳이 안써도되지만 확실하게 하기 위해서 한번 써줌. root에서는 이 데이터베이스 쓰려면 꼭 써줘야하긴함

-- book테이블 생성
create table book(
	book_id int 
    ,title varchar(50) 
    ,author varchar(50) 
    ,pub_date datetime
);

show tables;

-- 컬럼추가(add)
alter table book add pubs varchar(50);

-- 컬럼 수정(modify, rename)
alter table book modify title varchar(100);
alter table book rename column title to subject;

-- 컬럼 삭제
alter table book drop author; 

-- 테이블 명 수정
rename table book to article;

-- 테이블 삭제
drop table article;

select * from book;


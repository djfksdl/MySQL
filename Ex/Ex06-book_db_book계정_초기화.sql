use hrdb;  -- hrdb데이타베이스 사용(접속)

-- root에서 만들어야함./ 계정을 생성할 수 있는 권한을 가지고 있음. 

-- 데이터베이스 만들기(create)
create user 'webdb'@'%' identified by '1234';  

-- 비밀번호 수정(alter)
alter user 'webdb'@'%' identified by 'webdb'; 

-- 권한 부여(grant) / privileges:모든 권한 부여
grant all privileges on web_db.* to 'webdb'@'%'; 

-- 계정 삭제
drop user 'webdb'@'%';

-- 데이터베이스 생성
create database web_db
	default character set utf8mb4 -- 이모티콘 사용 케릭터셋
    collate utf8mb4_general_ci -- 정렬규칙
    default encryption='n'; -- 암호화 no(기본값이라 생략가능. 굳이 안써도됨야)

show databases;

-- 데이터베이스 삭제
drop database web_db;

-- 데이터베이스 조회   
show databases;

-- --------------------------------------------------------
# book_db 데이터베이스, book계정, book계정 권한 초기화 세팅 스트립트

-- 1.계정이 있다면 삭제
drop user if exists 'book'@'%';

-- 2.계정 만들기(id:book/pw:book/권한:모든곳)
create user 'book'@'%' identified by'book';

-- 3.권한 부여(book계정, book_db데이터 베이스에 모든 권한 부여)
grant all privileges on book_db.*to 'book'@'%';

-- 4.데이터 베이스가 있다면 삭제
drop database if exists book_db;

-- 5.데이터베이스 생성
create database book_db
	default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption='n';

-- 6.즉시 변경 내용 반영
flush privileges;

-- 데이터베이스 생성 및 지정
create database IF NOT EXISTS hotel_booking;
use hotel_booking;
alter database hotel_booking default character set utf8mb4;

set foreign_key_checks = 0;    			-- 외래키 체크하지 않는 것으로 설정
drop table IF EXISTS hotel cascade;   				-- 기존 hotel 테이블 제거
drop table IF EXISTS hotelier cascade;   			-- 기존 hotelier 테이블 제거
drop table IF EXISTS hotel_room cascade;   			-- 기존 hotel_room 테이블 제거
drop table IF EXISTS customer cascade;   			-- 기존 customer 테이블 제거
drop table IF EXISTS booking cascade;   			-- 기존 booking 테이블 제거 
drop table IF EXISTS stay_information cascade; 		-- 기존 stay_information 테이블 제거 
drop view IF EXISTS hongik_hotel_customers cascade; -- 기존 hongik_hotel_customers 뷰 제거
set foreign_key_checks = 1;   			-- 외래키 체크하는 것으로 설정

-- (1)  테이블 생성 
create table hotel (
   hid char(4) NOT NULL, 
   호텔이름 varchar(20) NOT NULL, 
   호텔주소 varchar(20), 
   호텔전화번호 varchar(20),
   primary key (hid));
    
create table hotelier (
   hlid char(5) NOT NULL, 
   호텔리어이름 varchar(20) NOT NULL, 
   hid char(4),
   FOREIGN KEY (hid) REFERENCES hotel (hid) on delete cascade,
   primary key (hlid));

create table hotel_room(
	hid char(4) NOT NULL,
	호실 char(2),
	가격 int,
	FOREIGN KEY (hid) REFERENCES hotel (hid) on delete cascade,
    primary key (hid, 호실)
);

create table customer (
   cid char(4) NOT NULL, 
   고객이름 varchar(20) NOT NULL, 
   고객전화번호 varchar(20),
   primary key (cid));

create table booking(
	cid char(4) NOT NULL,
	hid char(4) NOT NULL,
	호실 char(2),
	예약체크인날짜 date,
	예약체크아웃날짜 date,
	FOREIGN KEY (cid) REFERENCES customer (cid) on delete cascade,
	FOREIGN KEY (hid,호실) REFERENCES hotel_room (hid,호실) on delete cascade,
	primary key (cid,hid,호실)
);

create table stay_information(
	cid char(4) NOT NULL,
	hid char(4) NOT NULL,
	호실 char(2),
	체크인날짜 date,
	체크아웃날짜 date,
	FOREIGN KEY (cid) REFERENCES customer (cid) on delete cascade,
	FOREIGN KEY (hid,호실) REFERENCES hotel_room (hid,호실) on delete cascade,
	primary key (cid,hid,호실,체크인날짜)
);

-- (2)  데이터 삽입
insert into hotel 
values('H001','홍익호텔','마포구 상수동', '02-320-1234');
insert into hotel 
values('H002','중앙호텔','동작구 흑석동', '02-850-1234');
insert into hotel 
values('H003','건국호텔','광진구 자양동', '02-415-1234');

insert into hotelier
values('HL001','KMS','H001');
insert into hotelier
values('HL002','LED','H001');
insert into hotelier
values('HL003','YHD','H002');
insert into hotelier
values('HL004','KKT','H002');
insert into hotelier
values('HL005','CPC','H003');
insert into hotelier
values('HL006','LSY','H003');

insert into hotel_room
values('H001','01',1400);
insert into hotel_room
values('H001','02',1200);
insert into hotel_room
values('H001','03',700);
insert into hotel_room
values('H002','01',1900);
insert into hotel_room
values('H002','02',1000);
insert into hotel_room
values('H002','03',1300);
insert into hotel_room
values('H002','04',1600);
insert into hotel_room
values('H003','01',900);
insert into hotel_room
values('H003','02',1100);

insert into customer
values('C001','PDN','010-3304-6302');
insert into customer
values('C002','KYS','010-7323-3789');
insert into customer
values('C003','YDJ','010-2628-7436');
insert into customer
values('C004','KSM','010-2299-7827');
insert into customer
values('C005','PJH','010-3157-2501');
insert into customer
values('C006','HBC','010-2936-5427');
insert into customer
values('C007','KCY','010-7119-6732');
insert into customer
values('C008','PYS','010-2523-9738');

insert into booking
values('C001','H001','01','2023-07-16','2023-07-28');
insert into booking
values('C002','H001','02','2023-07-21','2023-07-22');
insert into booking
values('C001','H002','01','2023-08-16','2023-08-18');
insert into booking
values('C005','H002','01','2023-09-06','2023-09-09');
insert into booking
values('C005','H002','02','2023-09-10','2023-09-18');
insert into booking
values('C003','H002','02','2023-09-14','2023-10-17');
insert into booking
values('C002','H002','03','2023-10-16','2023-10-18');
insert into booking
values('C008','H003','01','2023-10-22','2023-10-26');
insert into booking
values('C004','H003','01','2023-10-28','2023-11-02');
insert into booking
values('C003','H003','02','2023-10-29','2023-11-03');

insert into stay_information
values('C002','H002','01','2021-07-16','2021-07-20');
insert into stay_information
values('C001','H003','02','2021-07-21','2021-07-25');
insert into stay_information
values('C001','H001','01','2021-08-16','2021-08-28');
insert into stay_information
values('C004','H002','02','2021-09-06','2021-09-18');
insert into stay_information
values('C001','H002','02','2021-09-10','2021-09-17');
insert into stay_information
values('C003','H002','02','2021-09-14','2021-09-21');
insert into stay_information
values('C002','H001','03','2022-10-15','2022-10-24');
insert into stay_information
values('C005','H003','01','2022-10-19','2022-10-26');
insert into stay_information
values('C004','H002','01','2022-10-22','2022-10-26');
insert into stay_information
values('C005','H003','02','2022-10-29','2022-11-01');

select *
from hotel;

select *
from hotelier;

select *
from hotel_room;

 select *
 from customer;
 
 select*
 from booking;
 
 select *
 from stay_information;
 
-- (3) 1)
select "1)";       -- 문제 번호 출력하기--(1)에서 생성한 각 테이블의 모든 레코드를 검색하시오.
select *
from hotel;

select *
from hotelier;

select *
from hotel_room;

 select *
 from customer;
 
 select*
 from booking;
 
 select *
 from stay_information;

select "2)";       -- 문제 번호 출력하기--ID가 ‘H001’인 호텔에서 근무하는 호텔리어의 ID와 이름을 검색하시오.
select hlid,호텔리어이름
from hotelier
where hid='H001';

select "3)";       -- 문제 번호 출력하기 --고객별로 자신이 투숙했던 모든 호텔별로 투숙 일(night) 수의 합을 검색하시오.
select cid,hid,sum(datediff(체크아웃날짜,체크인날짜)) as '투숙 일(night)수의 합'
from stay_information
group by cid,hid;

select "4)";       -- 문제 번호 출력하기 --호텔 예약 중 예약한 일(night) 수가 4일 미만인 예약 정보에 대해 고객 이름과 호텔 이름을 검색하시오.
select 고객이름,호텔이름
from booking,customer,hotel
where datediff(예약체크아웃날짜,예약체크인날짜)<4 and booking.cid=customer.cid and booking.hid=hotel.hid;

select "5)";       -- 문제 번호 출력하기 -- ID가 ‘C001’인 고객들이 투숙한 총 일(night) 수를 검색하시오
select sum(datediff(체크아웃날짜,체크인날짜)) as 'C001이 투숙한 총 일(night) 수'
from stay_information
where cid='C001';

select "6)";       -- 문제 번호 출력하기 -- 가격이 1300원 이상인 호텔방을 호텔ID에 대해 내림차순으로 호실에 대해 오름차순으로 검색하시오.
select hid,호실
from hotel_room
where 가격>=1300
order by hid desc,호실 asc;

select "7)";       -- 문제 번호 출력하기 --  가장 오래전의 투숙 정보를 보유 중인 호텔의 이름과 전화번호를 검색하시오.
select 호텔이름,호텔전화번호
from hotel,stay_information
where 체크인날짜=(select min(체크인날짜)
               from stay_information) and hotel.hid=stay_information.hid;


select "8)";       -- 문제 번호 출력하기 --ID가 ‘H003’인 호텔이 보유하고 있는 호텔방을 예약한 적이 있는 고객의 이름을 검색하시오.
select 고객이름
from customer
where cid in ( select cid
			   from booking
		       where hid='H003');

 select "9)";       -- 문제 번호 출력하기 --체크인 날짜가 2021년인 투숙 정보를 2개 이상 보유 중인 호텔의 이름을 검색하시오--해결
select 호텔이름
from hotel,stay_information
where 체크인날짜<'2022-01-01' and 체크인날짜>'2020-12-31' and hotel.hid=stay_information.hid
group by 호텔이름 having count(*)>=2;
               
select "10)";       -- 문제 번호 출력하기 -- 2022년 8월 30일 이전에 체크인해서 투숙했던 정보 중에서 주소가 ‘흑석동’인 호텔을 예약했던 고객의 이름과 전화번호를 검색하시오. -해결
select 고객이름,고객전화번호
from customer,booking
where hid=(select hid
           from hotel
		   where 호텔주소 like '%흑석동%') and booking.cid in (select cid
                                                           from stay_information
														   where 체크인날짜<'2022-08-30') and customer.cid=booking.cid;


select "11)";       -- 문제 번호 출력하기 -- ID가 ‘H001’과 ‘H002’인 호텔을 모두 예약한 적이 있는 고객의 이름을 검색하시오.
select 고객이름
from customer
where cid in (select cid
              from booking
			  where hid='H001') and cid in (select cid
                                            from booking
			                                where hid='H002');
              
select "12)";       -- 문제 번호 출력하기 -- 호텔별로 총 예약 수와 투숙 수를 검색하시오.
select hid,count(*) as '총 예약 수'
from booking
group by hid;

select hid,count(*) as '총 투숙 수'
from stay_information
group by hid;

select "13)";       -- 문제 번호 출력하기 --  ID가 ‘C002’인 고객이 예약한 호텔방의 가격을 모두 100원씩 증가하시오. 마지막에 ‘호텔방’ 테이블의 모든 레코드를 검색하는 select 문을 추가하시오. --해결
update hotel_room,booking
set 가격=가격+100
where cid in (select cid
			  from booking
			  where cid='C002') and hotel_room.hid=booking.hid and hotel_room.호실=booking.호실;
select *
from hotel_room;

select "14)";       -- 문제 번호 출력하기 --‘중앙호텔’에 근무하는 모든 호텔리어들을 삭제하시오. 마지막에 ‘호텔리어’ 테이블의 모든 레코드를 검색하는 select 문을 추가하시오.
delete 
from hotelier
where hid in (select hid
              from hotel
              where 호텔이름='중앙호텔');
              
select *
from hotelier;

select "15)";       -- 문제 번호 출력하기--‘홍익호텔’에 투숙한 경험이 있는 모든 고객들의 ID, 이름 및 전화번호 정보로 “hongik_hotel_customers”이라는 이름의 뷰를 생성하여 구성하시오. 마지막에 해당 뷰의 모든 레코드를 검색하는 select 문을 추가하시오. 
create view hongik_hotel_customers(cid,고객이름,고객전화번호)
as select cid,고객이름,고객전화번호
   from customer
   where cid in (select cid
                   from stay_information,hotel
                   where 호텔이름='홍익호텔' and hotel.hid=stay_information.hid)
with check option;

select *
from hongik_hotel_customers;





set foreign_key_checks = 0;    			-- 외래키 체크하지 않는 것으로 설정
drop table IF EXISTS hotel cascade;   				-- 기존 hotel 테이블 제거
drop table IF EXISTS hotelier cascade;   			-- 기존 hotelier 테이블 제거
drop table IF EXISTS hotel_room cascade;   			-- 기존 hotel_room 테이블 제거
drop table IF EXISTS customer cascade;   			-- 기존 customer 테이블 제거
drop table IF EXISTS booking cascade;   			-- 기존 booking 테이블 제거 
drop table IF EXISTS stay_information cascade; 		-- 기존 stay_information 테이블 제거 
drop view IF EXISTS hongik_hotel_customers cascade; -- 기존 hongik_hotel_customers 뷰 제거
set foreign_key_checks = 1;   			-- 외래키 체크하는 것으로 설정
CREATE TABLE seat_users(
	name varchar2(100) not null,
	email varchar2(100) primary key,
	pwd varchar2(100) not null,
	phoneNumber varchar(20) not null,
	profile clob,
	tag clob,
	regdate date
);

create table store(
	num number primary key,
	owner varchar2(100) not null,
	storeName varchar2(100) not null,
	storeAddr clob not null,
	storePhone varchar2(100) not null,
	storeTag clob,
	openingTime clob,
	image_logo clob,
	image_1 clob,
	image_2 clob,
	image_3 clob,
	image_4 clob,
	storeOpen varchar2(10) not null,
	category clob,
	avgStar number,
	reviewCount number,
	regdate date
);

create sequence store_seq;

CREATE TABLE storeMenu(
	num number primary key,
	storeNum number,
	menuImage clob,
	menuName varchar2(100) not null,
	content clob,
	price number not null,
	best varchar2(10),
	category varchar2(100)
);

create sequence storeMenu_seq;

CREATE TABLE storeReview(
	num NUMBER PRIMARY KEY,
	storeNum number,
	storeName VARCHAR2(100) NOT NULL,
	writer VARCHAR2(100) NOT NULL,
	content VARCHAR2(100) NOT NULL,
	star NUMBER,
	targetNum number,
	groupNum number,
	orderNum number,
	imagePath clob,
	regdate DATE
);

CREATE SEQUENCE storeReview_seq;

CREATE TABLE order_(
	orderNum VARCHAR2(100),
	email VARCHAR2(100) not null,
	storeName VARCHAR2(100) not null,
	storeLogo VARCHAR2(100),
	num VARCHAR2(100),
	tableNum NUMBER,
	menu VARCHAR2(100),
	menuCount NUMBER,
	price NUMBER,
	amount NUMBER,
	reviewExist VARCHAR2(20),
	cancel VARCHAR2(20), --> default: 'NO' -> 'YES'(client) -> 'COMPLETE' or 'REJECT' (owner)
	confirm VARCHAR2(20), --> default: 'NO' -> 'YES'(owner)
	regdate VARCHAR2(100),
	orderdate VARCHAR2(100)
);

alter session set NLS_DATE_FORMAT='YYYY/MM/DD/HH24:MI:SS';

CREATE TABLE storeSeat(
	num VARCHAR2(100) NOT NULL,
	seatImage CLOB,
	seatContent CLOB,
	totalSeat CLOB,
	emptySeat CLOB,
	notEmptySeat CLOB,
	notUse CLOB
);

CREATE TABLE info(
	num,
	writer,
	title,
	content,
	viewCount,
	regdate,
	rowNum
);

CREATE TABLE infoComment(
	
);
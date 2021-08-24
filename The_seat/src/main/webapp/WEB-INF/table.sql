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
	storeTag clob,
	openingTime clob,
	image_logo clob,
	image_1 clob,
	image_2 clob,
	image_3 clob,
	image_4 clob,
	storeOpen varchar2(10) not null,
	regdate date
);

create sequence store_seq;

CREATE TABLE storeMenu(
	num,
	storeName,
	item,
	content,
	price,
	best
);

CREATE TABLE storeReview(
	num,
	storeName,
	writer,
	content,
	star,
	targetNum,
	regdate
);

CREATE TABLE storeSeat(
	
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
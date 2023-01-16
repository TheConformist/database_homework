DROP DATABASE IF EXISTS Train_Booking;
CREATE DATABASE IF NOT EXISTS Train_Booking
DEFAULT CHARACTER SET utf8mb4	
DEFAULT COLLATE utf8mb4_unicode_ci;

Use Train_Booking;

CREATE TABLE IF NOT EXISTS station(
stationno	char(5)	PRIMARY KEY,
stationname varchar(100)	not null
);

CREATE TABLE IF NOT EXISTS vehicle_shift(
trainno  char(6) PRIMARY KEY,
dept_station  char(10)	not null,
arv_station  char(10)  not null,  
FOREIGN KEY (dept_station) REFERENCES station (stationno)
	ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (arv_station) REFERENCES station (stationno)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS infotable(
trainno  char(6),
deptdate  date not null,
depttime  char(10) not null,
arvtime  char(10) not null,
seats_total int(5) not null,
seats_current int(5) not null,
price float,
FOREIGN KEY (trainno) REFERENCES vehicle_shift (trainno)
	ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(deptdate,trainno)
);

CREATE TABLE IF NOT EXISTS passenger(
id varchar(50) PRIMARY KEY,
nationality	varchar(10) not null,
tel	bigint(11),
sex varchar(5),
age int(5)
);

CREATE TABLE IF NOT EXISTS chinese(
id varchar(50) PRIMARY KEY,
cnname	varchar(20),
FOREIGN KEY (id) REFERENCES passenger (id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS foreigner(
id varchar(50) PRIMARY KEY,
frname varchar(20),
passportno varchar(50),
FOREIGN KEY (id) REFERENCES passenger (id)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ticket(
trainno varchar(6),
deptdate  date not null,
seatno int(5) not null,
id varchar(50) not null,
PRIMARY KEY (trainno,deptdate,id),

FOREIGN KEY (id) REFERENCES passenger (id)
	ON DELETE NO ACTION ON UPDATE CASCADE,
FOREIGN KEY (trainno) REFERENCES infotable (trainno)
	ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (deptdate) REFERENCES infotable (deptdate)
	ON DELETE CASCADE ON UPDATE CASCADE
);
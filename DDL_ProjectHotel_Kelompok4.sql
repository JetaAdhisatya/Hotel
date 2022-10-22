CREATE DATABASE HotelKel4LF01
USE HotelKel4LF01
DROP DATABASE HotelKel4LF01
--List Anggota Kelompok:
--KevinBryan 2440038490
--Ryanto 2440046965
--JetaAdhisatya 2440044070

CREATE TABLE Customer(
	CustomerID char(5) primary key check( CustomerID like 'CU[0-9][0-9][0-9]') not null,
	CustomerName varchar(255) not null
)

INSERT INTO Customer VALUES
('CU001','Thomas Brian'),
('CU002','Robert Parkinson'),
('CU003','Bobby Shaun'),
('CU004','Amanda Curry'),
('CU005','Misty Turner'),
('CU006','Nanda taulani'),
('CU007','Nadia Omara'),
('CU008','Budhi Sorwono'),
('CU009','Hadiman Khanta'),
('CU010','Anastasia')


CREATE TABLE EmployeePosition(
	EmployeePositionID char(5) primary key check( EmployeePositionID like 'EP[0-9][0-9][0-9]') not null,
	EmployeePositionName varchar(255) not null
)

INSERT INTO EmployeePosition VALUES
('EP001','Reservation Staff'),
('EP002','Chef'),
('EP003','Security'),
('EP004','Waiter'),
('EP005', 'Building Manager')

CREATE TABLE Employee(
	EmployeeID char(5) primary key check( EmployeeID like 'EM[0-9][0-9][0-9]') not null,
	EmployeeName varchar(255) not null,
	EmployeePositionID char(5) foreign key (EmployeePositionID) references EmployeePosition(EmployeePositionID) on update cascade on delete no action,
	EmployeePhone varchar(12) not null check (EmployeePhone like '08%'),
	EmployeeEmail varchar(50) not null check (EmployeeEmail like '%@%'),
	EmployeeDOB date not null,
	EmployeeAddress varchar(255) not null,
	AbsentCount int default 0 not null,
	Salary int not null default 4000000
)

INSERT INTO Employee VALUES
('EM001','David Rawler','EP001','085663305877','davidrawler@yahoo.com','1995-10-10','Little St 797',0,6000000),--Reservation Staff
('EM002','Gabriel Janice','EP002','081344858402','gabrieljanice@gmail.com','1996-04-29','Arch St 205',0,800000),--Chef
('EM003','George Burns','EP003','088742406498','georgeburns@yahoo.com','1998-02-13','Ronker St 410',0,500000),--Security
('EM004','Isabelle','EP001','088425516802','isabelle@yahoo.com','1997-07-15','Trinity St 109',2,6000000),--Reservation Staff
('EM005','Edward Kenney','EP004','089751667801','edwardkenney@gmail.com','1996-12-21','Lorney St 941',1,700000),--Waiter
('EM006','Eudora Garcia','EP004','084621840051','eudoragarica@gmail.com','1994-09-10','Prime St 684',1,700000),--Waiter
('EM007','Garfield','EP005','082299113230','garfield@yahoo.com','1990-01-10','Timah St 789',0,1000000),--Building manager
('EM008','Watson','EP002','085234131892','watson01@gmail.com','1997-11-11','Stusy St 123',2,500000)--chef

CREATE TABLE Menu(
	FoodID char(5) primary key check( FoodID like 'FO[0-9][0-9][0-9]') not null,
	FoodName varchar(255) not null,
	FoodPrice int not null default 10000,
	FoodQuantity int not null default 0
)

INSERT INTO Menu VALUES
('FO001','Pepperoni Pizza',80000,20),
('FO002','Beef Rendang',44000,10),
('FO003','Tartaglia Pasta',27000,15),
('FO004','Shumai',25000,10),
('FO005','Crème Brûlée',16000,30),
('FO006','French Fries',15000,40),
('FO007','Chicken Nugget',11000,30),
('FO008','Nasi Goreng',20000,40)

CREATE TABLE Wifi(
	WifiID char(5) primary key check( WifiID like 'WI[0-9][0-9][0-9]') not null,
	WifiPassword varchar(10) not null default 'Password0',
	WifiStatus varchar (3) not null default 'OFF' --[OFF or ON]
)

INSERT INTO Wifi VALUES
('WI109','Pass109','ON'),
('WI214','Pass214','ON'),
('WI306','Pass306','OFF'),
('WI112','Pass112','ON'),
('WI202','Pass202','OFF'),
('WI302','Pass302','ON'),
('WI114','Pass114','ON'),
('WI111','Pass111','ON'),
('WI330','Pass330','ON'),
('WI201','Pass201','ON')

CREATE TABLE Room(
	RoomNumber int not null primary key,
	RoomType varchar(255) not null,
	RoomPrice int not null default 500000,
	RoomStatus varchar (10) default 'AVAILABLE', -- AVAILABLE OR BOOKED
	WifiID char(5) foreign key (WifiID) references Wifi(WifiID) on update cascade on delete no action
)

INSERT INTO Room VALUES
(109,'Single',250000,'AVAILABLE','WI109'),
(214,'Double',400000,'AVAILABLE','WI214'),
(306,'Queen',600000,'BOOKED','WI306'),
(112,'Double',400000,'AVAILABLE','WI112'),
(202,'Single',250000,'BOOKED','WI202'),
(302,'Single',250000,'AVAILABLE','WI302'),
(114,'Single',250000,'AVAILABLE','WI114'),
(111,'Double',400000,'AVAIBLE','WI111'),
(330,'Single',250000,'AVAIBLE','WI330'),
(201,'Double',400000,'AVAIBLE','WI201')

CREATE TABLE [Service](
	ServiceID char(5) primary key check( ServiceID like 'SE[0-9][0-9][0-9]') not null,
	ServiceName varchar (255) not null,
	ServicePrice int not null default 50000,
	ServiceStock int not null default 0
)

INSERT INTO [Service] VALUES
('SE001','Extra Pillow',40000,20),
('SE002','Extra Blanket',50000,25),
('SE003','Cleaning',100000,5)

CREATE TABLE RoomServiceDetail(
	RoomNumber int foreign key (RoomNumber) references Room(RoomNumber) on update cascade on delete no action,
	ServiceID char(5) foreign key (ServiceID) references Service(ServiceID) on update cascade on delete no action,
	ServiceQuantity int not null,
	IncludeBreakfeast varchar (5) default 'FALSE' -- FALSE or TRUE
)

INSERT INTO RoomServiceDetail VALUES
(109,'SE001',2,'TRUE'),
(214,'SE002',1,'TRUE'),
(112,'SE003',1,'FALSE'),
(302,'SE001',1,'TRUE'),
(114,'SE002',1,'FALSE'),
(111,'SE001',3,'TRUE'),
(330,'SE001',1,'TRUE'),
(201,'SE001',2,'TRUE')

CREATE TABLE RestaurantBill(
	RestoReceiptID char(5) primary key check( RestoReceiptID like 'RR[0-9][0-9][0-9]') not null,
	TableNumber int not null,
	EmployeeID char (5) foreign key (EmployeeID) references Employee(EmployeeID) on update cascade on delete no action,
	RestoPaymentDate date not null
)

INSERT INTO RestaurantBill VALUES
('RR001',1,'EM005','2021-12-05'),
('RR002',2,'EM006','2021-12-05'),
('RR003',4,'EM005','2021-12-06'),
('RR004',1,'EM006','2021-12-08'),
('RR005',7,'EM005','2021-12-06')

CREATE TABLE RestaurantBillDetail(
	RestoReceiptID char(5) foreign key (RestoReceiptID) references RestaurantBill(RestoReceiptID) on update cascade on delete no action,
	FoodID char(5) foreign key (FoodID) references Menu(FoodID) on update cascade on delete no action,
	FoodQuantity int not null
)

INSERT INTO RestaurantBillDetail VALUES
('RR001','FO003',2),
('RR002','FO001',1),
('RR003','FO005',3),
('RR004','FO004',4),
('RR005','FO003',1)

CREATE TABLE Reservation(
	TransactionID char(5) primary key check( TransactionID like 'TR[0-9][0-9][0-9]') not null,
	CustomerID char(5) foreign key (CustomerID) references Customer(CustomerID) on update cascade on delete no action,
	EmployeeID char (5) foreign key (EmployeeID) references Employee(EmployeeID) on update cascade on delete no action,
	CheckInDate date not null,
	ChackOutDate date not null,
	PaymentDate date not null
)

INSERT INTO Reservation VALUES
('TR001','CU001','EM001','2021-12-5','2021-12-10','2021-12-05'),
('TR002','CU002','EM004','2021-12-4','2021-12-07','2021-12-04'),
('TR003','CU003','EM001','2021-12-5','2021-12-08','2021-12-05'),
('TR004','CU004','EM004','2021-12-3','2021-12-08','2021-12-03'),
('TR005','CU005','EM001','2021-12-4','2021-12-08','2021-12-04'),
('TR006','CU006','EM001','2021-12-7','2021-12-09','2021-12-06'),
('TR006','CU007','EM004','2021-12-7','2021-12-08','2021-12-01'),
('TR006','CU008','EM001','2021-12-10','2021-12-12','2021-12-09')

CREATE TABLE ReservationDetail(
	TransactionID char(5) foreign key (TransactionID) references Reservation(TransactionID) on update cascade on delete no action,
	RoomNumber int foreign key (RoomNumber) references Room(RoomNumber) on update cascade on delete no action
)

INSERT INTO ReservationDetail VALUES
('TR001',109),
('TR002',214),
('TR003',112),
('TR004',302),
('TR005',114),
('TR006',111),
('TR007',330),
('TR008',201)



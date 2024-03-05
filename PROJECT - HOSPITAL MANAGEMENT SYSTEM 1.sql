
-- PROJECT -- HOSPITAL MANAGEMENT SYSTEM
-- DOMAIN  -- HEALTHCARE

CREATE TABLE PATIENT_INFO(
PATIENT_ID INT CONSTRAINT PK_PID PRIMARY KEY IDENTITY(1,1),
PATIENT_FULL_NAME VARCHAR(100),
DOB DATE,
P_GENDER VARCHAR(1) CONSTRAINT CK_PGEN CHECK(P_GENDER IN ('M','F')),
MOBILE NUMERIC(13),
P_ADDRESS VARCHAR(500)
);

CREATE TABLE DOCTOR_INFO(
DOCTOR_ID INT CONSTRAINT PK_DID PRIMARY KEY IDENTITY(1,1),
DOCTOR_FULL_NAME VARCHAR(100),
D_GENDER VARCHAR(1) CONSTRAINT CK_DGEN CHECK(D_GENDER IN ('M','F')),
MOBILE NUMERIC(13)
);

CREATE TABLE APPOINTMENT(
APPOINTMENT_ID INT CONSTRAINT PK_APPOINTMENT_ID PRIMARY KEY IDENTITY(1,1),
APPOINTMENT_DATE DATE ,
APPOINTMENT_TIME TIME ,
PATIENT_ID INT CONSTRAINT FK_APNTMNT_PID FOREIGN KEY(PATIENT_ID) REFERENCES PATIENT_INFO(PATIENT_ID) ON DELETE CASCADE,
DOCTOR_ID INT CONSTRAINT FK_DID FOREIGN KEY(DOCTOR_ID) REFERENCES DOCTOR_INFO(DOCTOR_ID) ON DELETE CASCADE,
);

CREATE TABLE TEST_REPORTS(
TEST_ID INT CONSTRAINT PK_TEST_ID PRIMARY KEY IDENTITY(1,1),
TEST_DATE DATE,
PATIENT_ID INT CONSTRAINT FK_TST_PID FOREIGN KEY(PATIENT_ID) REFERENCES PATIENT_INFO(PATIENT_ID) ON DELETE CASCADE,
TEST_RESULT VARCHAR(20) CONSTRAINT CK_TST_RSLT CHECK(TEST_RESULT IN ('POSITIVE', 'NEGATIVE'))
);

CREATE TABLE ADMISSION(
ADMISSION_ID INT PRIMARY KEY IDENTITY(1,1),
PATIENT_ID INT CONSTRAINT FK_ADMSN_PID FOREIGN KEY(PATIENT_ID) REFERENCES PATIENT_INFO(PATIENT_ID) ON DELETE CASCADE,
ADMISSION_DATE DATE,
ROOM_NO INT,
DISCHARGE_DATE DATE
);

CREATE TABLE BILL(
BILL_ID INT CONSTRAINT PK_BID PRIMARY KEY IDENTITY(1,1),
PATIENT_ID INT CONSTRAINT FK_BL_PID FOREIGN KEY(PATIENT_ID) REFERENCES PATIENT_INFO(PATIENT_ID) ON DELETE CASCADE,
BILL_AMOUNT MONEY,
PAYMENT_MODE VARCHAR(50),
PAYMENT_STATUS NVARCHAR(50)
);

CREATE TABLE MEDICINE_PRESCRIPTION(
PRESCRIPTION_ID INT PRIMARY KEY IDENTITY(1,1),
PATIENT_ID INT CONSTRAINT FK_PRSRPN_PID FOREIGN KEY(PATIENT_ID) REFERENCES PATIENT_INFO(PATIENT_ID) ON DELETE CASCADE,
PRESCRIPTION_DATE DATE,
MEDICINE_NAME NVARCHAR(MAX)
);

CREATE TABLE EMPLOYEES(
EMP_ID INT PRIMARY KEY IDENTITY(11,1),
EMP_NAME VARCHAR(100), 
E_GENDER VARCHAR(1),
DESIGNATION VARCHAR(100),
MOBILE NUMERIC,
EMP_ADDRESS NVARCHAR(500)
);
--ALTER TABLE EMPLOYEES ALTER COLUMN MOBILE NUMERIC;


INSERT INTO PATIENT_INFO 
(PATIENT_FULL_NAME,DOB,P_GENDER,MOBILE,P_ADDRESS) VALUES
('RAM SHYAM PATIL', '1999-10-25','M',1223456789,'MUMBAI'), 
('NISHANT VIJAY MALGE','1989-08-11','M',8855919263,'THANE'),
('ASHWINI GASE','1993-10-25','F',8855919266,'NAGPUR'),
('RAVINA RAKESH YADAV','1998-11-28','F',2583691470,'KALYAN');

INSERT INTO DOCTOR_INFO (DOCTOR_FULL_NAME,D_GENDER,MOBILE) values
('V.R.AGRAWAL','M',1478523698),
('N.D.DESHMUKH','M',2587413698),
('R.S.PATIL','F',7896541236),
('J.S.DAS','F',3654789215);

INSERT INTO APPOINTMENT (APPOINTMENT_DATE,APPOINTMENT_TIME,PATIENT_ID,DOCTOR_ID) VALUES
('2023-05-12','14:30',1,2),
('2021-07-30','16:15',2,1),
('2020-09-11','19:15',3,4),
('2022-01-17','12:15',4,3);

INSERT INTO TEST_REPORTS (TEST_DATE,PATIENT_ID,TEST_RESULT) VALUES
('2023-05-12',1,'NEGATIVE'),
('2021-07-30',2,'POSITIVE'),
('2020-09-11',3,'POSITIVE'),
('2022-01-17',4,'POSITIVE');

INSERT INTO ADMISSION (PATIENT_ID,ADMISSION_DATE,ROOM_NO,DISCHARGE_DATE) VALUES
(2,'2021-08-01',101,'2021-08-5'),
(3,'2020-09-11',102,'2022-09-18'),
(4,'2023-08-11',103,'2023-08-18');

INSERT INTO BILL (BILL_ID,PATIENT_ID,BILL_AMOUNT,PAYMENT_MODE,PAYMENT_STATUS) VALUES
(1,2,20000,'ONLINE','COMPLETED'),
(2,3,35000,'ONLINE','COMPLETED'),
(3,4,30000,'CASH','COMPLETED');

INSERT INTO MEDICINE_PRESCRIPTION (PATIENT_ID,PRESCRIPTION_DATE,MEDICINE_NAME) VALUES
(1,'2023-05-12','Acetaminophen,Adderall,Amitriptyline,Amlodipine'),
(2,'2021-07-30','Amoxicillin,Ativan,Atorvastatin,Azithromycin'),
(3,'2020-09-11','Adderall,Amitriptyline,Amlodipine,Amoxicillin'),
(4,'2022-01-17','Acetaminophen,Amoxicillin,Amitriptyline,Amlodipine');

INSERT INTO EMPLOYEES (EMP_NAME,E_GENDER,DESIGNATION,MOBILE,EMP_ADDRESS) VALUES
('SHAM P RATHOD','M','WARDBOY',8469871236,'NAGPUR'),
('HARI S SHAHA','M','WARDBOY',5507971236,'BADLAPUR'),
('ANKITA P RANE','F','NURSE',5969871236,'THANE'),
('KAJAL G RATHI','F','NURSE',6463771256,'NANDURA'),
('SHITAL H. KANE','F','SWEEPER',9469871236,'BHIWANDI');

-----------------------------------------------------------------------------------------------------------------------
SELECT * FROM PATIENT_INFO;
SELECT * FROM DOCTOR_INFO;
SELECT * FROM APPOINTMENT;
SELECT * FROM TEST_REPORTS;
SELECT * FROM ADMISSION;
SELECT * FROM BILL;
SELECT * FROM MEDICINE_PRESCRIPTION;
SELECT * FROM EMPLOYEES;

--drop table PATIENT_INFO;
--drop table DOCTOR_INFO;
--drop table APPOINTMENT;
--drop table TEST_REPORTS;
--drop table ADMISSION;
--drop table BILL;
--drop table MEDICINE_PRESCRIPTION;
--drop table EMPLOYEES;
------------------------------------------------------------------------------------------------------------------

--procedure to insert values from 1 table to another automatically using scope_identity() function --- 

create or alter procedure proc_insrt(
@patient_full_name varchar(50),
@dob date,
@p_gender varchar(1),
@mobile numeric,
@p_address varchar(500),
@APPOINTMENT_DATE date,

@DOCTOR_FULL_NAME varchar(50),
@D_GENDER  varchar(1),
@MOB  numeric
)
as
begin

insert into PATIENT_INFO (PATIENT_FULL_NAME,DOB,P_GENDER,MOBILE,P_ADDRESS)values(@patient_full_name,@dob,@p_gender,@mobile,@p_address)
declare @patient_id int;
select @patient_id = scope_identity();

select  @patient_id;
insert into DOCTOR_INFO (DOCTOR_FULL_NAME,D_GENDER,MOBILE)values(@DOCTOR_FULL_NAME,@D_GENDER,@MOB)
declare @DOCTOR_id int;
select @DOCTOR_id = scope_identity();

insert into APPOINTMENT (APPOINTMENT_DATE,PATIENT_Id,DOCTOR_id) values (@APPOINTMENT_DATE,@patient_id,@DOCTOR_id);
select @DOCTOR_id;
end ;

exec proc_insrt @patient_full_name='abc',@dob='1993-10-25',@p_gender='F',@mobile=8855919266,@p_address='NA',@DOCTOR_FULL_NAME ='dr.abc',
@D_GENDER='m',@MOB = 546879735, @APPOINTMENT_DATE='2023-08-08';

----------------------------------------------------------
--store procedure to insert unique records only 

create or alter procedure proc_unique_insert(
@PATIENT_FULL_NAME varchar(100),
@DOB date,
@P_GENDER varchar(1),
@MOBILE numeric,
@P_ADDRESS varchar(500),
@DOCTOR_FULL_NAME varchar(100),
@D_GENDER  varchar(1),
@MOB  numeric,
@appointment_date date
) as
begin
declare @pid int ;
declare @did int;
-- check if the patient already exist 
if not exists( select 1 from PATIENT_INFO where PATIENT_FULL_NAME =@PATIENT_FULL_NAME and DOB = @DOB and P_ADDRESS =@P_ADDRESS)
begin
insert into PATIENT_INFO (PATIENT_FULL_NAME,DOB,P_GENDER,MOBILE,P_ADDRESS) values (@PATIENT_FULL_NAME,@DOB,@P_GENDER,@MOBILE,@P_ADDRESS);
select @pid = scope_identity();
print('PATIENT RECORD INSERETED')
end ;
-- Patient already exists then get the existing ID
else
begin
select  @pid = PATIENT_ID from PATIENT_INFO where PATIENT_FULL_NAME =@PATIENT_FULL_NAME and DOB = @DOB and P_ADDRESS =@P_ADDRESS
print('patient data already exists');
end;

-- check if doctor already exist 
if not exists (select 1 from DOCTOR_INFO where DOCTOR_FULL_NAME = @DOCTOR_FULL_NAME and MOBILE = @mob)
begin
insert into DOCTOR_INFO (DOCTOR_FULL_NAME,D_GENDER,MOBILE) values(@DOCTOR_FULL_NAME,@D_GENDER,@MOB)
select @did = scope_identity()
print('DOCTORS RECORD INSERETED')
end;
-- if doctor already exists then get the existing ID
else
begin
select @did = DOCTOR_ID from DOCTOR_INFO  where DOCTOR_FULL_NAME = @DOCTOR_FULL_NAME and MOBILE = @mob
print('dr already exist')
end;

insert into APPOINTMENT (APPOINTMENT_DATE,PATIENT_ID,DOCTOR_ID) values (@appointment_date,@pid,@did);
end;

exec proc_unique_insert @PATIENT_FULL_NAME = 'abc',@DOB = '11-08-1989',@P_GENDER= 'm',@MOBILE=8855919263,@P_ADDRESS = 'nandura',
                        @DOCTOR_FULL_NAME = 'xyz',@D_GENDER = 'm',@MOB =5588749621 , @appointment_date ='2023-10-18';


---------------------------------------------------------------------------------------------------------------------
-- procedure to update isdeleted (bit-column) automatically according to status (cancelled / booked )

create or alter procedure proc_appointment_status(
@appointment_id int,
 @appointment_status varchar(20)
)as 
begin

if @appointment_status = 'cancelled' 
begin
update APPOINTMENT set isdeleted = 1 where appointment_id = @appointment_id
end;

else
begin
update APPOINTMENT set isdeleted = 0 where appointment_id = @appointment_id
end;

end;

exec  proc_appointment_status @appointment_id= 1, @appointment_status = 'cancelled';

---------------------------------------------------------------------------------------------------------------------------------------------
-- STORE PROCEDURE TO FETCH PATIENT'S DATA ALONG WITH DR.'S NAME AND TEST DETAILS using patient id / name(partial name also allowed)

create or alter procedure proc_patient_details(
@pid int = null,
@pname varchar(100) = null 
) as 
begin
select p.PATIENT_FULL_NAME,p.MOBILE,p.P_ADDRESS ,d.DOCTOR_FULL_NAME,d.MOBILE ,t.TEST_DATE,t.TEST_RESULT from PATIENT_INFO p inner join TEST_REPORTS t
on p.PATIENT_ID = t.PATIENT_ID inner join APPOINTMENT a on a.PATIENT_ID = p.PATIENT_ID inner join DOCTOR_INFO d on a.DOCTOR_ID=d.DOCTOR_ID 
where (p.PATIENT_ID is not null and p.PATIENT_ID = @pid  ) or (PATIENT_FULL_NAME is not null and PATIENT_FULL_NAME like '%'+@pname + '%');
end ;

exec proc_patient_details  @pid = 3,
       @pname = 'ASHWINI';

---------------------------------------------------------------------------------------------------------------------------------------------

-- CRETATE A PROCEDURE TO INSERT PATIENT'S ID AUTOMATICALLY INTO BILL TABLE AND CREATE ANOTHER PROCEDURE TO UPDATE BILL USING PATIENTS ID

create or alter procedure proc_pid_insert(

@PATIENT_FULL_NAME  varchar(100),
@P_GENDER   varchar(1),
@MOBILE   numeric,
@P_ADDRESS  varchar(500),
@DOB date
) as

begin
declare @pid int;
if not exists (select 1 from PATIENT_INFO where PATIENT_FULL_NAME = @PATIENT_FULL_NAME and MOBILE = @MOBILE )
begin
insert into PATIENT_INFO (PATIENT_FULL_NAME,DOB,P_GENDER,MOBILE,P_ADDRESS)values(@patient_full_name,@dob,@p_gender,@mobile,@p_address)
select @pid = scope_identity();
end;
else 
begin
select @pid = PATIENT_ID from PATIENT_INFO where PATIENT_FULL_NAME = @PATIENT_FULL_NAME and MOBILE = @MOBILE
end;

insert into bill (PATIENT_ID) values (@pid);
end;

exec proc_pid_insert @PATIENT_FULL_NAME ='ASHWINI' ,@dob = '1993-10-25' ,@p_gender ='f',@mobile = 8855919266 ,@p_address='NAGPUR';

------------------------------------------------------------------------------------------------------------------------------------------------------

-- procedure to update bill after inserting value from above procedure

create or alter procedure proc_update_bill(
@pid int,
@BILL_AMOUNT  money,
@PAYMENT_MODE varchar(100),
@PAYMENT_STATUS  nvarchar(100)
) as
begin
update bill set BILL_AMOUNT = @BILL_AMOUNT , PAYMENT_MODE=@PAYMENT_MODE , PAYMENT_STATUS=@PAYMENT_STATUS where PATIENT_ID = @pid;
end ;

exec proc_update_bill @BILL_AMOUNT= 500.00 , @PAYMENT_MODE= ' online', @PAYMENT_STATUS='successfull', @pid = 3;

------------------------------------------------------------------------------------------------------------------------------------------------------

-- CREATE TRIGGER TO TAKE BACKUP FOR PATIENT INFORMATION --

-- CREATING BACKUP TABLE  

CREATE TABLE PATIENT_INFO_BACKUP(
PATIENT_ID INT,
PATIENT_FULL_NAME VARCHAR(100),
DOB DATE,
P_GENDER VARCHAR(1),
MOBILE NUMERIC(13),
P_ADDRESS VARCHAR(500),
USERNAME  NVARCHAR(MAX),
DATE_TIME  DATE
);

-- CREATING TRIGGER --

CREATE OR ALTER TRIGGER TR_PATIENT_INFO_BACKUP ON PATIENT_INFO AFTER DELETE
AS
BEGIN
INSERT INTO PATIENT_INFO_BACKUP(PATIENT_ID,PATIENT_FULL_NAME,DOB,P_GENDER,MOBILE,P_ADDRESS,USERNAME,DATE_TIME)
SELECT D.PATIENT_ID,D.PATIENT_FULL_NAME,D.DOB,D.P_GENDER,D.MOBILE,D.P_ADDRESS,USER_NAME(),GETDATE() FROM DELETED D

PRINT(' YOUR DELETED DATA GETS STORED INTO BACKUP TABLE ')
END;

BEGIN TRAN
DELETE PATIENT_INFO WHERE PATIENT_FULL_NAME = 'RAM';
ROLLBACK;

------------------------------------------------------------------------------------------------------------------------------------------------------

-- TRIGGER TO INSERT PATIENT_ID INTO BILL TABLE 

CREATE OR ALTER TRIGGER TR_INSERT_PATIEND_ID_TO_BILL ON PATIENT_INFO AFTER INSERT
AS
BEGIN
INSERT INTO BILL (PATIENT_ID) 
SELECT I.PATIENT_ID FROM INSERTED I 

PRINT(' PATIENT_ID GETS INSERTED INTO BILL TABLE ')
END;

INSERT INTO PATIENT_INFO VALUES('JAY RATHOD','1989-05-02','M',6545678,'KHAMGAON')

------------------------------------------------------------------------------------------------------------------------------------------------------

-- CREATE TRIGGER FOR UPDATING BILL AFTER BILL DISCOUNT  
-- CREATING BILL_DISCOUNT TABLE 

CREATE TABLE BILL_DISCOUNT(
ID INT IDENTITY(1,1) ,
BILL_ID INT  FOREIGN KEY(BILL_ID) REFERENCES BILL(BILL_ID),
ACTUAL_BILL_AMOUNT INT,
DISCOUNTED_BILL_AMOUNT INT
);

-- CREATING TRIGGER 

CREATE OR ALTER TRIGGER TR_BILL_DISCOUNT ON BILL INSTEAD OF UPDATE
AS
BEGIN
INSERT INTO BILL_DISCOUNT (BILL_ID,ACTUAL_BILL_AMOUNT,DISCOUNTED_BILL_AMOUNT)
SELECT I.BILL_ID,D.BILL_AMOUNT, I.BILL_AMOUNT FROM DELETED D INNER JOIN INSERTED I ON D.BILL_ID=I.BILL_ID
PRINT (' DISCOUNTED AND ACTUAL BILL GETS STORED SUCCESSFULLY ')
END;

BEGIN TRAN
UPDATE BILL SET BILL_AMOUNT = BILL_AMOUNT - 0.10 * BILL_AMOUNT WHERE PATIENT_ID = 3;

------------------------------------------------------------------------------------------------------------------------------------------------------

-- CREATE FUNCTION TO RETURN TOTAL DISCOUNTED AMOUNT 

CREATE OR ALTER FUNCTION FUN_DISCOUNTED_AMOUNT(@PID1 NVARCHAR(MAX)) RETURNS NVARCHAR(MAX)
AS
BEGIN
DECLARE @BID NVARCHAR(MAX)
SELECT @BID = (B.ACTUAL_BILL_AMOUNT - B.DISCOUNTED_BILL_AMOUNT)
FROM BILL_DISCOUNT B INNER JOIN BILL BL ON B.BILL_ID=BL.BILL_ID WHERE PATIENT_ID =  @PID1

RETURN (' BILL DISCOUNT FOR PATIENT_ID = '+@PID1 +' IS '+@BID)
END

SELECT DBO.FUN_DISCOUNTED_AMOUNT (3)

------------------------------------------------------------------------------------------------------------------------------------------------------

-- FIND PATIENTS INFO ALONG WITH TEST DETAILS USING - CTE--

WITH CTE_APTIENT_DETAILS AS (
SELECT P.*,T.TEST_DATE,T.TEST_RESULT,T.TEST_ID FROM PATIENT_INFO P INNER JOIN TEST_REPORTS T ON P.PATIENT_ID = T.PATIENT_ID )
SELECT * FROM CTE_APTIENT_DETAILS

------------------------------------------------------------------------------------------------------------------------------------------------------

--DISPLAY ONLY LAST 4 DIGITS OF DOCTOR'S MOBILE NUMBER

SELECT STUFF(MOBILE,1,6,REPLICATE('*',6))MOBILE FROM DOCTOR_INFO;

------------------------------------------------------------------------------------------------------------------------------------------------------











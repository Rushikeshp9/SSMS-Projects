
-- PROJECT -- RETAIL APP DATA MANAGEMENT SYSTEM
-- DOMAIN  -- E-COMMERCE

CREATE TABLE CUSTOMER(
CUSTOMER_ID   INT PRIMARY KEY IDENTITY(1,1),
CUSTOMER_NAME VARCHAR(500),
AGE    INT,
GENDER VARCHAR(1) CHECK (GENDER IN('M','F')),
MOBILE   NUMERIC,
ADDRESS  VARCHAR(500));

INSERT INTO CUSTOMER  VALUES('RAM',35,'M',123456789,'MUMBAI'),
('SHYAM',45,'M',123789456,'THANE'),
('RAVI',55,'M',147258369,'KALYAN'),
('AASHU',30,'F',369258147,'NANDURA'),
('JAYA',29,'F',987456321,'AKOLA')
--------------------------------------------------------------------------------------------------------------
CREATE TABLE PRODUCTS(
PRODUCTS_ID  INT PRIMARY KEY IDENTITY(1,1),
PRODUCTS_NAME VARCHAR(100),
CATEGORY    VARCHAR(100),
);

INSERT INTO PRODUCTS (PRODUCTS_NAME, CATEGORY) VALUES
    ('Product 1', 'Category A'),
    ('Product 2', 'Category B'),
    ('Product 3', 'Category A'),
    ('Product 4', 'Category C'),
    ('Product 5', 'Category B');

--------------------------------------------------------------------------------------------------------------
CREATE TABLE REVIEW(
REVIEW_ID  INT PRIMARY KEY IDENTITY(1,1),
PRODUCTS_ID INT FOREIGN KEY(PRODUCTS_ID) REFERENCES PRODUCTS(PRODUCTS_ID),
REVIEW_DATE  DATE,
CUSTOMER_ID INT FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
RATING   NVARCHAR(5),
COMMENT  VARCHAR(1000)
);

---- INSERT FOLLOWING RECORDS THROUGH PROCEDURE -- PROC_INSERT_RATING_TO_PRODUCTS
--INSERT INTO REVIEW (REVIEW_DATE, CUSTOMER_ID, RATING, COMMENT)
--VALUES
--    ('2023-10-15', 1, 4.5, 'Great service and friendly staff.'),
--    ('2023-10-16', 2, 5.0, 'Excellent experience. Highly recommended.'),
--    ('2023-10-17', 3, 3.5, 'Service was decent, but theres room for improvement.'),
--    ('2023-10-18', 4, 4.0, 'Overall, a good experience. Will come again.'),
--    ('2023-10-19', 5, 2.5, 'Not satisfied with the service. Needs improvement.');

--------------------------------------------------------------------------------------------------------------
CREATE TABLE ORDERS(
ORDER_ID    INT PRIMARY KEY IDENTITY(1,1),
ORDER_DATE  DATE,
CUSTOMER_ID  INT FOREIGN KEY(CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID),
COUPONS_ID INT FOREIGN KEY(COUPONS_ID) REFERENCES COUPONS(COUPONS_ID));


INSERT INTO ORDERS (ORDER_DATE, CUSTOMER_ID) VALUES
('2023-10-01', 1),
('2023-10-02', 2),
('2023-10-03', 1),
('2023-10-04', 3),
('2023-10-05', 4);


--------------------------------------------------------------------------------------------------------------
CREATE TABLE Shipping_Delivery(
Shipping_ID      INT PRIMARY KEY IDENTITY(1,1),
ORDER_ID  INT   FOREIGN KEY( ORDER_ID ) REFERENCES ORDERS ( ORDER_ID ),
Shipping_ADDRESS    VARCHAR(2000),
ESTIMATED_DELIVERY_DATE   DATE,
TRACKING_ID     INT);


INSERT INTO Shipping_Delivery (ORDER_ID, Shipping_ADDRESS, ESTIMATED_DELIVERY_DATE, TRACKING_ID)
VALUES
    (1, '123 Main St, City A, 12345', '2023-11-05', 1001),
    (2, '456 Elm St, City B, 67890', '2023-11-08', 1002),
    (3, '789 Oak St, City C, 54321', '2023-11-10', 1003),
    (4, '101 Pine St, City D, 98765', '2023-11-12', 1004),
    (5, '202 Maple St, City E, 13579', '2023-11-15', 1005);


--------------------------------------------------------------------------------------------------------------
CREATE TABLE ORDER_DETAILS(
ORDER_DETAILS_ID      INT PRIMARY KEY IDENTITY(1,1),
PRODUCTS_ID   INT  FOREIGN KEY ( PRODUCTS_ID )REFERENCES  PRODUCTS(PRODUCTS_ID),
QUANTITY_OR_UNITS  INT,
UNIT_PRICE   MONEY,
TOTAL_AMOUNT   MONEY );

-- INSERT RECORDS THROUGH PROCEDURE -- PROC_PRICE_INSERT_TO_ORDER_DETAILS
--DROP TABLE ORDER_DETAILS
-- IN ORDER_DETAILS UNIT_PRICE & TOTAL_AMOUNT GETS AUTOMATICALLY INSERTED FROM PRICE AS WE INSERT PRODUCTS_ID & QUANTITY_OR_UNITS 
--------------------------------------------------------------------------------------------------------------

CREATE TABLE PRICE(
PRICE_ID  INT PRIMARY KEY IDENTITY(1,1),
PRODUCTS_ID   INT  FOREIGN KEY ( PRODUCTS_ID )REFERENCES  PRODUCTS(PRODUCTS_ID),
UNIT_PRICE   MONEY);

INSERT INTO PRICE (PRODUCTS_ID, UNIT_PRICE) VALUES
(1, 10),
(2, 19),
(3, 5),
(4, 15),
(5, 7);
--------------------------------------------------------------------------------------------------------------
CREATE TABLE BILLS(
BILL_ID      INT PRIMARY KEY IDENTITY(1,1),
ORDER_ID  INT   FOREIGN KEY( ORDER_ID ) REFERENCES ORDERS ( ORDER_ID ),
PAYMENT_METHOD   VARCHAR(50),
PAYMENT_STATUS  VARCHAR(100),
PAYMENT_DATE    DATE   );

INSERT INTO BILLS (ORDER_ID, PAYMENT_METHOD, PAYMENT_STATUS, PAYMENT_DATE)
VALUES
    (1, 'Credit Card', 'Paid', '2023-10-15'),
    (2, 'Cash', 'Pending', '2023-10-16'),
    (3, 'Debit Card', 'Paid', '2023-10-17'),
    (4, 'PayPal', 'Paid', '2023-10-18'),
    (5, 'Cheque', 'Pending', '2023-10-19');

--------------------------------------------------------------------------------------------------------------
CREATE TABLE COUPONS(
COUPONS_ID   INT PRIMARY KEY IDENTITY(1,1),
COUPON_DETAILS   VARCHAR(1000),
START_DATE   DATE,
END_DATE  DATE,
DISCOUNT_TYPE  NVARCHAR(MAX) );

-- DISCOUNT_TYPE=(% / FIXED AMOUNT/SPECIAL OFFER)

INSERT INTO COUPONS (COUPON_DETAILS, START_DATE, END_DATE, DISCOUNT_TYPE) VALUES
    ('25% off on all medicines', '2023-11-01', '2023-11-30', N'Percentage'),
    ('Buy one, get one free on select items', '2023-11-05', '2023-11-15', N'Free Item'),
    ('$10 discount on your next appointment', '2023-11-10', '2023-12-10', N'Fixed Amount'),
    ('15% off on diagnostic tests', '2023-11-15', '2023-11-25', N'Percentage'),
    ('20% off for senior citizens', '2023-11-20', '2023-11-30', N'Percentage');

--------------------------------------------------------------------------------------------------------------
CREATE TABLE INVENTORY(
INVENTORY_ID  INT PRIMARY KEY IDENTITY(1,1),
PRODUCTS_ID   INT  FOREIGN KEY ( PRODUCTS_ID )REFERENCES  PRODUCTS(PRODUCTS_ID),
STOCK_REQUIRED  INT,
STOCK_AVAILABLE INT); 
--DROP TABLE INVENTORY
INSERT INTO INVENTORY (PRODUCTS_ID,STOCK_REQUIRED) VALUES
    (1,100),
    (3,10),
    (4,200),
    (2,50),
    (5,75);

--------------------------------------------------------------------------------------------------------------

CREATE TABLE INVENTORY_REFILL(
REFILL_ID INT PRIMARY KEY IDENTITY(1,1),
PRODUCTS_ID INT UNIQUE FOREIGN KEY(PRODUCTS_ID) REFERENCES PRODUCTS(PRODUCTS_ID),
QUANTITY  NVARCHAR(MAX));

INSERT INTO INVENTORY_REFILL (PRODUCTS_ID, QUANTITY)
VALUES (1, '10'),
       (2, '15'),
       (3, '20'),
       (4, '25'),
       (5, '30');
--------------------------------------------------------------------------------------------------------------
-- TO FIND ALL TABLES FROM DATABASE --

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

--------------------------------------------------------------------------------------------------------------
SELECT * FROM CUSTOMER
SELECT * FROM REVIEW
SELECT * FROM ORDERS
SELECT * FROM Shipping_Delivery
SELECT * FROM COUPONS
SELECT * FROM BILLS
SELECT * FROM ORDER_DETAILS
SELECT * FROM INVENTORY
SELECT * FROM INVENTORY_REFILL
SELECT * FROM PRODUCTS
SELECT * FROM PRICE
--------------------------------------------------------------------------------------------------------------

-- CREATE PROCEDURE TO INSERT UNIT PRICE INTO ORDERS FROM PRICE TABLE & TO UPDATE AVAILABLE STOCK IN INVENTORY BASED ON ORDER_DETAILS & INVENTORY_REFILL TABLES

CREATE OR ALTER PROCEDURE PROC_PRICE_INSERT_TO_ORDER_DETAILS (
@PRODUCTS_ID	INT,
@QUANTITY_OR_UNITS	int )
AS
BEGIN
DECLARE @UNIT_PRICE	 int;

SELECT @UNIT_PRICE = P.UNIT_PRICE FROM PRICE P WHERE P.PRODUCTS_ID =@PRODUCTS_ID

INSERT INTO ORDER_DETAILS (PRODUCTS_ID, QUANTITY_OR_UNITS, UNIT_PRICE, TOTAL_AMOUNT)   -- PROC TO INSERT INTO ORDER_DETAILS
VALUES(@PRODUCTS_ID,@QUANTITY_OR_UNITS,@UNIT_PRICE, @QUANTITY_OR_UNITS * @UNIT_PRICE)

 -- PROC TO INSERT INTO INVENTORY

 declare @A1 int;
 select @A1= QUANTITY from INVENTORY_REFILL WHERE PRODUCTS_ID = @PRODUCTS_ID 

UPDATE INVENTORY SET STOCK_AVAILABLE = (SELECT(I.STOCK_REQUIRED - SUM(OD.QUANTITY_OR_UNITS)+@A1)AS CONSUMPTION FROM INVENTORY I JOIN ORDER_DETAILS OD ON
I.PRODUCTS_ID = OD.PRODUCTS_ID GROUP BY OD.PRODUCTS_ID,I.STOCK_REQUIRED
HAVING OD.PRODUCTS_ID = @PRODUCTS_ID) WHERE PRODUCTS_ID = @PRODUCTS_ID

-- CREATING ALERT FOR INVENTORY IF STOCK_AVAILABLE<25% OF STOCK_REQUIRED

declare @v1 int, @v2 int
select @v1= (I.STOCK_REQUIRED/4) from inventory I WHERE I.PRODUCTS_ID = @PRODUCTS_ID
select @v2= STOCK_AVAILABLE from inventory WHERE PRODUCTS_ID = @PRODUCTS_ID
if @v2<@v1
begin
print  ' YOUR STOCK IS BELLOW 25% OF REQUIRED_STOCK '
end
else 
print  ' YOUR STOCK IS ABOVE 25% OF REQUIRED_STOCK '
END

EXEC PROC_PRICE_INSERT_TO_ORDER_DETAILS @PRODUCTS_ID= 7 ,@QUANTITY_OR_UNITS =50
----@PRODUCTS_ID= 2 ,@QUANTITY_OR_UNITS =5
----@PRODUCTS_ID= 3 ,@QUANTITY_OR_UNITS =2
----@PRODUCTS_ID= 4 ,@QUANTITY_OR_UNITS =3
----@PRODUCTS_ID= 5 ,@QUANTITY_OR_UNITS =15


--------------------------------------------------------------------------------------------------------------

-- CREATE PROCEDURE TO INSERT COUPON_ID FROM COUPONS INTO ORDERS RANDOMLY

CREATE OR ALTER PROCEDURE PROC_INSERT_RANDOM_COUPON_TO_ORDER(@OID INT)
AS
BEGIN
UPDATE ORDERS SET COUPONS_ID = (
SELECT NULLIF(CAST((RAND() * (SELECT MAX(COUPONS_ID)FROM COUPONS) +  (SELECT MIN(COUPONS_ID)FROM COUPONS)) AS INT),1))
WHERE ORDER_ID = @OID;
END;                          

EXEC PROC_INSERT_RANDOM_COUPON_TO_ORDER @OID = 2
SELECT * FROM ORDERS

/* 
(RAND() * (SELECT MAX(COUPONS_ID) FROM COUPONS)): This part generates a random floating-point number between 0 and the maximum 
value of COUPONS_ID - 1  found in the COUPONS table. It does this by multiplying the result of RAND() by the maximum COUPONS_ID.
SO MAX(COUPON_ID) = 5 SO 5-1=4 & MIN(COUPON_ID) = 1 SO 4+1 = 5 / 3+1 = 4/ 1+1 =2 / 0
+ (SELECT MIN(COUPONS_ID) FROM COUPONS): After generating the random number within the range defined by the minimum and
maximum COUPONS_ID, this part shifts the generated value by adding the minimum COUPONS_ID. This ensures that the generated 
value falls within the range defined by the COUPONS_ID values in the COUPONS table.
*/

----------------------------------------

SELECT CAST((RAND() * 10) + 1 AS int)   -- HERE 10 MEANS RANDOM DIGIT FROM 0 TO 10 I.E 0 -9 & THEN ADD 1 INTO EVERY RANDOMLY GENERATED DIGIT

SELECT CAST((RAND() * 5) AS INT);       -- HERE GENERATE VALUE FROM 0 - 4 I.E. 5-DIGITS FROM 0 

SELECT CAST((RAND() *6) +5 AS INT)      -- TO PRINT RANDOM NO FROM 5 - 10 

SELECT nullif(CAST((RAND() * 10) AS INT),3);   -- PRINT 0-9 AND IF VALUE = 3 THEN NULL
--------------------------------------------------------------------------------------------------------------

-- DROP COLUMN REVIEW_ID FROM PRODUCTS TABLE & ADD RATING COLUMN

ALTER TABLE PRODUCTS 
DROP CONSTRAINT FK__PRODUCTS__REVIEW__2F2FFC0C

ALTER TABLE PRODUCTS
DROP COLUMN REVIEW_ID 

ALTER TABLE PRODUCTS 
ADD RATING NVARCHAR(50)

ALTER TABLE PRODUCTS 
ADD COMMENT NVARCHAR(500)
--------------------------------------------------------------------------------------------------------------

-- CREATE PROCEDURE TO INSERT RATING & COMMENTS INTO PRODUCTS TABLE FROM REVIEW AS RECORD INSERTED INTO REVIEW TABLE

CREATE OR ALTER PROCEDURE PROC_INSERT_RATING_TO_PRODUCTS(
@PRODUCTS_ID INT ,
@REVIEW_DATE  DATE,
@CUSTOMER_ID INT ,
@RATING   NVARCHAR(5),
@COMMENT  VARCHAR(1000),
@V_PRODUCT_ID INT
)
AS
BEGIN
DECLARE @V_RATING NVARCHAR(20) , @V_COMMENT VARCHAR(1000)

INSERT INTO REVIEW VALUES(@PRODUCTS_ID,@REVIEW_DATE ,@CUSTOMER_ID,@RATING,@COMMENT)

SELECT @V_RATING = (SELECT RATING FROM REVIEW WHERE PRODUCTS_ID = @V_PRODUCT_ID)
SELECT @V_COMMENT = (SELECT COMMENT FROM REVIEW WHERE PRODUCTS_ID = @V_PRODUCT_ID )

UPDATE PRODUCTS SET RATING = @V_RATING , COMMENT = @V_COMMENT WHERE  PRODUCTS_ID = @V_PRODUCT_ID 
END

EXEC PROC_INSERT_RATING_TO_PRODUCTS 1,'2023-10-15', 1, 4.5, 'Great service and friendly staff', 1

--    (1,'2023-10-15', 1, 4.5, 'Great service and friendly staff.'),
--    (2,'2023-10-16', 2, 5.0, 'Excellent experience. Highly recommended.'),
--    (3,'2023-10-17', 3, 3.5, 'Service was decent, but theres room for improvement.'),
--    (4,'2023-10-18', 4, 4.0, 'Overall, a good experience. Will come again.'),
--    (5,'2023-10-19', 5, 2.5, 'Not satisfied with the service. Needs improvement.');

--------------------------------------------------------------------------------------------------------------

-- DYNAMIC PIVOT WITH WITHIN GROUP FUNCTION TO CONVERT PRODUCT_ID INTO INDIVIDUAL COLUMN

DECLARE @V1  NVARCHAR(MAX); DECLARE @V2  NVARCHAR(MAX) ; DECLARE @V_MAX NVARCHAR(MAX)

SELECT @V1 = STRING_AGG(QUOTENAME(PRODUCTS_ID),', ') WITHIN GROUP(ORDER BY PRODUCTS_ID DESC) FROM 
             (SELECT DISTINCT(PRODUCTS_ID) FROM PRICE)T1
--PRINT @V1

SELECT @V2 = 'SELECT PRICE_ID,'+@V1+'FROM (SELECT * FROM PRICE)SOURCE_TABLE
PIVOT
(MAX(UNIT_PRICE) FOR PRODUCTS_ID in ('+@V1+'))pivot_table;'
--PRINT @V2
exec (@V2)

-------------------------------------------------------------------------------------------------------

--CREATE PROCEDURE TO RETURNS PRODUCTS DETAILS FOR MULTIPLE ID'S -- USE STRING_SPLIT() FUNCTION

CREATE OR ALTER PROCEDURE PROC_GET_PRODUCTS_DETAILS(
@PID  NVARCHAR(MAX)
)
AS
BEGIN
SELECT * FROM PRODUCTS WHERE PRODUCTS_ID IN (SELECT * FROM STRING_SPLIT(@PID ,',')) OR @PID = '0' 
END

EXEC PROC_GET_PRODUCTS_DETAILS '1,2,3'

------------------------------------------------------------------------------------------------------

-- CREATE PROCEDURE TO ADD NEW PRODUCTS INTO PRODUCTS AND UPDATE THE PRICE , INVENTORY & INVENTORY_REFILL TABLE ACCORDING TO IT 

CREATE OR ALTER PROCEDURE PROC_INSERT_NEW_PRODUCTS(
@ProductName nvarchar(500),@Category nvarchar(500), @UnitPrice money,@STOCK_REQUIRED int, @RefillQuantity nvarchar(max)
)AS
BEGIN
declare @Products_Id nvarchar(max)

INSERT INTO PRODUCTS (PRODUCTS_NAME,CATEGORY) VALUES (@ProductName,@Category)
set @Products_Id = scope_identity()

insert into PRICE(PRODUCTS_ID,UNIT_PRICE) values (@Products_Id,@UnitPrice)

insert into INVENTORY (PRODUCTS_ID,STOCK_REQUIRED) values (@Products_Id,@STOCK_REQUIRED)

insert into INVENTORY_REFILL (PRODUCTS_ID,QUANTITY)values (@Products_Id,@RefillQuantity)

end;

exec PROC_INSERT_NEW_PRODUCTS @ProductName = 'Product 6' ,@Category= 'Category D', @UnitPrice = 50,@STOCK_REQUIRED =50 , @RefillQuantity= 20

EXEC PROC_PRICE_INSERT_TO_ORDER_DETAILS @PRODUCTS_ID= 7 ,@QUANTITY_OR_UNITS =50

--------------------------------------------------------------------------------------------------------------

-- CREATE PROCEDURE TO FIND TOP 3 SELLING PRODUCTS

CREATE OR ALTER PROCEDURE PROC_TOP_3_PRODUCTS
As
Begin
select * from (select P.Products_Id,P.Products_Name,SUM(O.QUANTITY_OR_UNITS)as TotalQuantity , DENSE_RANK() over(order by P.Products_Id)Rank
from PRODUCTS P join ORDER_DETAILS O on P.PRODUCTS_ID = O.PRODUCTS_ID group by P.Products_Id,P.Products_Name)as Temp where Temp.RN <=3
end

exec PROC_TOP_3_PRODUCTS

--------------------------------------------------------------------------------------------------------------









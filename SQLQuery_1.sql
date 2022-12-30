IF EXISTS  (SELECT * FROM sys.databases WHERE Name='Example5')
     DROP DATABASE Example5
GO
-- CRUD; CREAT, READ, UPDATE, DELETE DATABASE
CREATE DATABASE Example5
GO
USE Example5
GO
-- Gọi dữ liệu ra
SELECT create_date FROM sys.databases WHERE name='Example5'

-- check database
-- sp: Store procedure 
EXEC sp_databases

-- DROP DATABASES (xoá)
USE master
GO
DROP DATABASE IF EXISTS  Example5 
-- (khi đang trong Ẽample5 k thể drop nó mà phải USE master -> GO)


/* Tạo bảng : CREATE TABLE [database_name].[shema_name]. table_name(
    pk_column data_type PRIMARY KEY,
    column_1 data_type NOT NULL,( k đc để trống)
    ....
    table_constraints (RÀng buộc các bảng)
)
*/
CREATE TABLE StudentInfo(
    [SID] INT PRIMARY KEY,
    S_Name VARCHAR (50),
    GPA FLOAT
)
EXEC sp_help StudentInfo

CREATE TABLE CourseInfo(
    CID INT PRIMARY KEY,
    C_NAME VARCHAR (50) NOT NULL
)
-- Student_Course
CREATE TABLE CourseGrade(
    GID INT PRIMARY KEY,
    Grade VARCHAR (5) NOT NULL,
    CID INT NOT NULL,
    SID INT NOT NULL,
    CONSTRAINT CG_SID_FK FOREIGN KEY (SID) REFERENCES StudentInfo(SID), 
    CONSTRAINT CG_CID_FK FOREIGN KEY (CID) REFERENCES CourseInfo(CID), 
    --                           Khoá ngoại               Khoá chính

)

-- Tao bang lop hoc
CREATE TABLE LopHoc(
    MaLopHoc INT PRIMARY KEY IDENTITY,
    TenLopHoc VARCHAR (10)
)
GO
-- Tao bang Sinh vien co khoa ngoai la cot MaLopHoc, noi voi bang LopHoc
CREATE TABLE SinhVien (
    MaSV int PRIMARY KEY,
    TenSV varchar (40),
    MaLopHoc int,
    CONSTRAINT fk FOREIGN KEY (MaLopHoc) REFERENCES LopHoc (MaLopHoc)
)
GO
--Tạo bảng SanPham với một cột NULL, một cột NOT NULL
CREATE TABLE SanPham (
    MaSP int NOT NULL,
    TenSP varchar(40) NULL
)
GO
--Tạo bảng với thuộc tính default cho cột Price
CREATE TABLE StoreProduct(
ProductID int NOT NULL,
Name varchar(40) NOT NULL,
Price money NOT NULL DEFAULT (100)
)
--Thử kiểm tra xem giá trị default có được sử dụng hay không
INSERT INTO StoreProduct (ProductID, Name) VALUES (111, 'Rivets')
GO
--Tạo bảng ContactPhone với thuộc tính IDENTITY
CREATE TABLE ContactPhone (
Person_ID int IDENTITY(500,1) NOT NULL,
MobileNumber bigint NOT NULL
)
GO
--Tạo cột nhận dạng duy nhất tổng thể
CREATE TABLE CellularPhone1(
Person_ID uniqueidentifier DEFAULT NEWID() NOT NULL,
PersonName varchar(60) NOT NULL
)
--Chèn một record vào
INSERT INTO CellularPhone1 (PersonName) VALUES('William Smith')
GO
--Kiểm tra giá trị của cột Person_ID tự động sinh
SELECT * FROM CellularPhone1
GO
--Tạo bảng ContactPhone với cột MobileNumber có thuộc tính UNIQUE
CREATE TABLE ContactPhone1 (
Person_ID int PRIMARY KEY,
MobileNumber bigint UNIQUE,
ServiceProvider varchar(30),
LandlineNumber bigint UNIQUE
)
--Chèn 2 bản ghi có giá trị giống nhau ở cột MobileNumber vàLanlieNumber để quan sát lỗi
INSERT INTO ContactPhone1 values (101, 983345674, 'Hutch', NULL)
INSERT INTO ContactPhone1 values (102, 983345674, 'Alex', NULL)
GO
--Tạo bảng PhoneExpenses có một CHECT ở cột Amount
CREATE TABLE PhoneExpenses (
Expense_ID int PRIMARY KEY,
MobileNumber bigint FOREIGN KEY REFERENCES ContactPhone1
(MobileNumber),
Amount bigint CHECK (Amount >0)
)
GO
--Chỉnh sửa cột trong bảng
ALTER TABLE ContactPhone1
ALTER COLUMN ServiceProvider varchar(45)
GO
--Xóa cột trong bảng
ALTER TABLE ContactPhone1
DROP COLUMN ServiceProvider
GO
---Them một ràng buộc vào bảng
ALTER TABLE ContactPhone1 ADD CONSTRAINT CHK_RC CHECK('RentalCharges' >0)
GO
--Xóa một ràng buộc
ALTER TABLE Person.ContactPhone
DROP CONSTRAINT CHK_RC
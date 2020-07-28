CREATE DATABASE QLKTX1
USE QLKTX1
CREATE TABLE TONGIAO
(
	MATONGIAO	INT		NOT NULL PRIMARY KEY,
	TENTONGIAO	NVARCHAR(30)	NOT NULL
)
CREATE TABLE DANTOC(
	MADANTOC 	INT NOT NULL PRIMARY KEY,
	TENDANTOC	NVARCHAR(30) NOT NULL
)
CREATE TABLE QUOCTICH(MAQUOCTICH	INT NOT NULL  PRIMARY KEY,TENQUOCTICH	NVARCHAR(30))
CREATE TABLE SINHVIEN(MAKTX 		VARCHAR(7) NOT NULL PRIMARY KEY,NAMSINH		DATETIME,HOTEN		NVARCHAR(30) NOT NULL,CMND		VARCHAR(9),DIENTHOAI	VARCHAR(10),MSSV		VARCHAR(9),GIOITINH	BIT,DIACHI		NVARCHAR(100),MAQT		INT,MADT		INT,MATG		INT,DOANVIEN	BIT,DANGVIEN	BIT,CAMTINHDANG	BIT,NGAYVAOKTX	DATETIME,NGAYRAKTX	DATETIME,HINH		NTEXT,CONSTRAINT FK_SINHVIEN_QT	FOREIGN KEY(MAQT)	REFERENCES QUOCTICH(MAQUOCTICH),CONSTRAINT FK_SINHVIEN_TG	FOREIGN KEY(MATG)	REFERENCES TONGIAO(MATONGIAO),CONSTRAINT FK_SINHVIEN_DT	FOREIGN KEY(MADT)	REFERENCES DANTOC(MADANTOC))
CREATE TABLE CANBO(MACBQL		INT NOT NULL  PRIMARY KEY,TENCBQL 	NVARCHAR(30) NOT NULL,DIACHI		NVARCHAR(100))
CREATE TABLE CAP(MACAP 		INT NOT NULL  PRIMARY KEY,	TENCAP 		NVARCHAR(30) NOT NULL)
CREATE TABLE KTX(KTX		VARCHAR(4) NOT NULL PRIMARY KEY,TENKTX		NVARCHAR(30),SOLUONGDAY	INT)
CREATE TABLE NAMHOC(MANAMHOC	VARCHAR(5) NOT NULL PRIMARY KEY,TENNAMHOC	NVARCHAR(20) NOT NULL,NGAYBATDAU	DATETIME,NGAYKETTHUC	DATETIME)
CREATE TABLE HOCKI(MAHOCKI		INT	NOT NULL PRIMARY KEY,	TENHOCKI	NVARCHAR(30) NOT NULL,	MANAM		VARCHAR(5) NOT NULL,	CONSTRAINT FK_HOCKI  	   	FOREIGN KEY(MANAM)	REFERENCES NAMHOC(MANAMHOC))
CREATE TABLE CBQL_KTX(KTX		VARCHAR(4) NOT NULL,MACBQL 		INT NOT NULL,MANAMHOC	VARCHAR(5) NOT NULL,NGAYBATDAU	DATETIME,NGAYKETTHUC	DATETIME,CONSTRAINT  pkCBQL_KTX PRIMARY KEY(KTX, MACBQL,MANAMHOC),CONSTRAINT FK_CBQL_CB FOREIGN KEY(MACBQL) REFERENCES CANBO(MACBQL),CONSTRAINT FK_CBQL_KTX FOREIGN KEY(KTX)	REFERENCES KTX(KTX),CONSTRAINT FK_CBQL_NAMHOC FOREIGN KEY(MANAMHOC) REFERENCES NAMHOC(MANAMHOC))
CREATE TABLE DANHGIA(MADANHGIA	INT NOT NULL PRIMARY KEY,TENDANHGIA	NVARCHAR(30) NOT NULL)
CREATE TABLE TRANGTHAIPHONG(MATRANGTHAI		INT	NOT NULL PRIMARY KEY,TENTRANGTHAI		NVARCHAR(30)	NOT NULL)
CREATE TABLE [DAY](MADAY VARCHAR(4) NOT NULL PRIMARY KEY, TENDAY		NVARCHAR(30) NOT NULL,SOLUONGPHG	INT,KTX		VARCHAR(4),MACODO		VARCHAR(7),CONSTRAINT FK_DAY1	FOREIGN KEY(KTX)	REFERENCES KTX(KTX),CONSTRAINT FK_DAY2 FOREIGN KEY(MACODO) REFERENCES SINHVIEN(MAKTX))
CREATE TABLE PHONG(MAPHG		VARCHAR(4)	NOT NULL PRIMARY KEY,TENPHG		NVARCHAR(30)	NOT NULL,MADAY		VARCHAR(4)	NOT NULL,SOLUONG		INT,SOLUONGTOIDA	INT,TRANGTHAI	INT,PHONGNAM	BIT,CONSTRAINT FK_PHONG	FOREIGN KEY(MADAY) REFERENCES [DAY](MADAY),CONSTRAINT FK_PHONG_TRANGTHAI FOREIGN KEY(TRANGTHAI) REFERENCES TRANGTHAIPHONG(MATRANGTHAI))
CREATE TABLE DIEMDANH(MAKTX		VARCHAR(7) NOT NULL,MAPHG		VARCHAR(4) NOT NULL,NGAYVANG	SMALLDATETIME,COPHEP		BIT,CONSTRAINT  pkDIEMDANH PRIMARY KEY(MAKTX, MAPHG, NGAYVANG))
CREATE TABLE DANHGIAPHONG(MAPHG		VARCHAR(4) NOT NULL,THANG		DATETIME NOT NULL,MANAMHOC	VARCHAR(5) NOT NULL,MAXEPLOAI 	INT,DIEM		DECIMAL(2,1),GHICHU		NTEXT,CONSTRAINT  pkDANHGIAPHONG PRIMARY KEY(MAPHG, THANG, MANAMHOC),CONSTRAINT FK_DANHGIAPHONG_1 FOREIGN KEY(MAPHG) REFERENCES PHONG(MAPHG),CONSTRAINT FK_DANHGIAPHONG_2 FOREIGN KEY(MANAMHOC)	REFERENCES NAMHOC(MANAMHOC))
CREATE TABLE DANHGIASV(MAKTX		VARCHAR(7) NOT NULL,MAHOCKI		INT NOT NULL,MADANHGIA	INT,TICHCUC		NTEXT,TIEUCUC		NTEXT,GHICHU		NTEXT,CONSTRAINT  pkDANHGIASV PRIMARY KEY(MAKTX, MAHOCKI,MADANHGIA),CONSTRAINT FK_DANHGIASV_SINHVIEN FOREIGN KEY(MAKTX) REFERENCES SINHVIEN(MAKTX),CONSTRAINT FK_DANHGIASV_HOCKI FOREIGN KEY(MAHOCKI) REFERENCES HOCKI(MAHOCKI), CONSTRAINT FK_DANHGIASV_DANHGIA FOREIGN KEY(MADANHGIA) REFERENCES DANHGIA(MADANHGIA))
---------------------------------------
CREATE TABLE DSSINHVIEN_PHONG(	MAKTX		VARCHAR(7) NOT NULL,	MAPHG		VARCHAR(4) NOT NULL,	NGAYVAO		DATETIME,	NGAYRA		DATETIME,	GHICHU		NTEXT,	CONSTRAINT  pkDSSINHVIEN_PHONG PRIMARY KEY(MAKTX, MAPHG, NGAYVAO),	CONSTRAINT FK_DSSINHVIEN_PHONG_KTX   	   	FOREIGN KEY(MAKTX)    			REFERENCES SINHVIEN(MAKTX),	CONSTRAINT FK_DSSINHVIEN_PHONG_PHONG   	   	FOREIGN KEY(MAPHG)    			REFERENCES PHONG(MAPHG))
CREATE TABLE HOATDONG(	MAHOATDONG	INT NOT NULL PRIMARY KEY,	TENHOATDONG	NVARCHAR(30) NOT NULL)
CREATE TABLE HOATDONGSV(	MAHOATDONG	INT NOT NULL,	MAKTX		VARCHAR(7) NOT NULL,	NGAY		DATETIME,	GHICHU		NVARCHAR(100),	CONSTRAINT  pkHOATDONG_SV PRIMARY KEY (MAHOATDONG, MAKTX),	CONSTRAINT FK_HOATDONG_SV_SV  	   	FOREIGN KEY(MAKTX)    			REFERENCES SINHVIEN(MAKTX),	CONSTRAINT FK_HOATDONG_SV_HD   	   	FOREIGN KEY(MAHOATDONG)    			REFERENCES HOATDONG(MAHOATDONG)	)
CREATE TABLE KHENTHUONG(	MAKHENTHUONG	INT NOT NULL PRIMARY KEY,	TENKHENTHUONG	NVARCHAR(30) NOT NULL)
CREATE TABLE KHENTHUONGSV(	MAKTX		VARCHAR(7) NOT NULL,	MAKHENTHUONG	INT NOT NULL,	LYDO		NTEXT,	MACAP		INT NOT NULL,	MACBQL		INT NOT NULL,	NGAY		DATETIME,	QDSO		VARCHAR(20),	GHICHU		NTEXT,	CONSTRAINT  pkKHENTHUONG_SV PRIMARY KEY (MAKTX,MAKHENTHUONG,NGAY),	CONSTRAINT FK_KHENTHUONG_SV_SV   	   	FOREIGN KEY(MAKTX)    			REFERENCES SINHVIEN(MAKTX),	CONSTRAINT FK_KHENTHUONG_SV_KT   	   	FOREIGN KEY(MAKHENTHUONG )    			REFERENCES KHENTHUONG(MAKHENTHUONG))
CREATE TABLE KYLUAT(	MAKYLUAT	INT NOT NULL PRIMARY KEY,	TENKYLUAT	NVARCHAR(30) NOT NULL)
CREATE TABLE KYLUATSV(	MAKTX		VARCHAR(7) NOT NULL,	MAKYLUAT	INT NOT NULL,	LYDO		NVARCHAR(100),	MACAP		INT NOT NULL,	MACBQL		INT NOT NULL,	NGAY		DATETIME  NOT NULL,	QDSO		VARCHAR(20),	CONSTRAINT  pk_KYLUATSV PRIMARY KEY(MAKTX,MAKYLUAT,NGAY),	CONSTRAINT FK_KYLUAT_SV_SV   	   	FOREIGN KEY(MAKTX)    			REFERENCES SINHVIEN(MAKTX),	CONSTRAINT FK_KHENTHUONG_SV_KL   	   	FOREIGN KEY(MAKYLUAT ) CONSTRAINT FK_KYLUAT_SV_CAP  	FOREIGN KEY(MACAP)CONSTRAINT FK_KHENTHUONG_SV_CBQL FOREIGN KEY(MACBQL)	REFERENCES CANBO(MACBQL))
CREATE TABLE NGUOIDUNG(	MA	INT	NOT NULL primary key,	HOTEN	NVARCHAR(30) 	NOT NULL,	[USER]	VARCHAR(32) 	NOT NULL,	[PASS]	VARCHAR(32) 	NOT NULL,	QUYEN 	CHAR(1)		NOT NULL)
CREATE TABLE QUANHE(	MAQUANHE	INT NOT NULL PRIMARY KEY,	TENQUANHE	NVARCHAR(30))
CREATE TABLE NGHENGHIEP(	MANGHENGHIEP	INT NOT NULL PRIMARY KEY,	TENNGHENGHIEP	NVARCHAR(30))
CREATE TABLE THANNHAN(	MATHANNHAN	INT NOT NULL,	MAKTX		NVARCHAR(7)	NOT NULL,	HOTEN		NVARCHAR(30)	NOT NULL,	NGHENGHIEP	INT,	QUANHE		INT,	CONSTRAINT  pkTHANNHAN PRIMARY KEY(MAKTX, MATHANNHAN))
CREATE TABLE TIENDIEN(	MAPHG		NVARCHAR(7)	NOT NULL,	THANG		DATETIME	NOT NULL,	SOKW		NVARCHAR(30),	THANHTIEN	INT,	NGAYTHU 	DATETIME,	NGUOITHU	INT,	GHICHU		NTEXT,	DONGIA		INT NOT NULL)
CREATE TABLE TIENPHONG(	MAPHG		NVARCHAR(7)	NOT NULL,	THANG		DATETIME	NOT NULL,	SOTHANHTIEN	INT,	NGAYTHU 	DATETIME,	NGUOITHU	INT,	GHICHU		NTEXT)
CREATE TABLE XEPLOAI(	MAXEPLOAI	INT		NOT NULL,	TENXEPLOAI	NVARCHAR(30)	NOT NULL,	DIEMCANTREN	DECIMAL(4,2),	DIEMCANDUOI	DECIMAL(4,2),check (DIEMCANTREN<=10),check (DIEMCANDUOI<=10))
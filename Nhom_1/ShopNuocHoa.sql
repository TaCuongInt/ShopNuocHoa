CREATE DATABASE ShopNuochoa

CREATE TABLE Quyen
(
	MaQuyen INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	TenQuyen NVARCHAR(50),
)

CREATE TABLE TaiKhoan
(
	Ma_TK INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Ten_TK VARCHAR(20),
	MatKhau_TK VARCHAR(10),
	HoTen_TK NVARCHAR(50),
	Tuoi_TK INT,
	DiaChi_TK NVARCHAR(150),
	DienThoai_TK VARCHAR(15),
	Email_TK VARCHAR(30),
	Anh_TK VARCHAR(100),
	TrangThai_TK INT,
	MaQuyen INT NOT NULL,
	CONSTRAINT FK_TaiKhoan FOREIGN KEY (MaQuyen) REFERENCES Quyen(MaQuyen),
)

CREATE TABLE DanhMucSP
(
	Ma_DM INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Ten_DM NVARCHAR(30),
	Icon VARCHAR(500),
	Anh VARCHAR(500),
)

CREATE TABLE SanPham
(
	Ma_SP INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Ten_SP NVARCHAR(200),
	Ma_DM INT NOT NULL,
	ThuongHieu_SP NVARCHAR(50),
	MuiHuong_SP NVARCHAR(50),
	MucDich_SP NVARCHAR(50),
	SoLuong_SP INT,
	NongDo_SP NVARCHAR(30),
	DungTich_SP INT,
	GiaBan_SP INT,
	MoTa_SP NVARCHAR(4000),
	CONSTRAINT FK_SanPham FOREIGN KEY (Ma_DM) REFERENCES DanhMucSP(Ma_DM),
)

CREATE TABLE Anh
(
	Ma_Anh INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Ma_SP INT NOT NULL,
	DuongDanAnh VARCHAR(500),
	CONSTRAINT FK_Anh FOREIGN KEY (Ma_SP) REFERENCES SanPham(Ma_SP),
)

CREATE TABLE GioHang
(
	Ma_GH INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Ma_TK INT NOT NULL,
	Ma_SP INT NOT NULL,
	SoLuong_GH INT,
	CONSTRAINT FK_GioHang1 FOREIGN KEY (Ma_TK) REFERENCES TaiKhoan(Ma_TK),
	CONSTRAINT FK_GioHang2 FOREIGN KEY (Ma_SP) REFERENCES SanPham(Ma_SP),
)

CREATE TABLE DonHang
(
	Ma_DH INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Ma_TK INT NOT NULL,
	NgayDat_DH DATETIME,
	TrangThai_DH INT,
	DienThoai_DH VARCHAR(15),
	HoTen_DH NVARCHAR(50),
	Email_DH VARCHAR(30),
	DiaChi_DH NVARCHAR(150),
	GhiChu_DH NVARCHAR(500),
	CONSTRAINT FK_DonHang FOREIGN KEY (Ma_TK) REFERENCES TaiKhoan(Ma_TK),
)

CREATE TABLE ChiTietDH
(
	Ma_CT INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Ma_DH INT NOT NULL,
	Ma_SP INT NOT NULL,
	SoLuong_CT INT,
	CONSTRAINT FK_ChiTietDH1 FOREIGN KEY (Ma_DH) REFERENCES DonHang(Ma_DH),
	CONSTRAINT FK_ChiTietDH2 FOREIGN KEY (Ma_SP) REFERENCES SanPham(Ma_SP),
)


INSERT INTO Quyen(TenQuyen) OUTPUT INSERTED.MaQuyen VALUES(N'Quản trị viên')
INSERT INTO Quyen(TenQuyen) OUTPUT INSERTED.MaQuyen VALUES(N'Thành viên')
INSERT INTO Quyen(TenQuyen) OUTPUT INSERTED.MaQuyen VALUES(N'Quản lý sản phẩm')
INSERT INTO Quyen(TenQuyen) OUTPUT INSERTED.MaQuyen VALUES(N'Quản lý đơn hàng')

INSERT INTO TaiKhoan(Ten_TK, MatKhau_TK, HoTen_TK, Tuoi_TK, DiaChi_TK, DienThoai_TK, Email_TK, Anh_TK, TrangThai_TK, MaQuyen) OUTPUT INSERTED.Ma_TK VALUES('TaCuong', '123456', N'Vương Tá Cường', 21, N'Hà Nội', '0123456789', 'cuongvt@gmail.com', 'TaCuong.jpg', 1, 1)
INSERT INTO TaiKhoan(Ten_TK, MatKhau_TK, HoTen_TK, Tuoi_TK, DiaChi_TK, DienThoai_TK, Email_TK, Anh_TK, TrangThai_TK, MaQuyen) OUTPUT INSERTED.Ma_TK VALUES('ThanhDat', '123456', N'Nguyễn Thành Đạt', 21, N'Hà Nội', '0123456789', 'datnt@gmail.com', 'HaUI.png', 1, 2)
INSERT INTO TaiKhoan(Ten_TK, MatKhau_TK, HoTen_TK, Tuoi_TK, DiaChi_TK, DienThoai_TK, Email_TK, Anh_TK, TrangThai_TK, MaQuyen) OUTPUT INSERTED.Ma_TK VALUES('QuangHuy', '123456', N'Đặng Quang Huy', 23, N'Hà Nội', '0123456789', 'huydq@gmail.com', 'HaUI.png', 1, 3)
INSERT INTO TaiKhoan(Ten_TK, MatKhau_TK, HoTen_TK, Tuoi_TK, DiaChi_TK, DienThoai_TK, Email_TK, Anh_TK, TrangThai_TK, MaQuyen) OUTPUT INSERTED.Ma_TK VALUES('Sihalath', '123456', N'SIHALATH Souksavanh', 24, N'Hà Nội', '0123456789', 'shihalaths@gmail.com', 'Shihalath.jpg', 1, 4)

INSERT INTO DanhMucSP(Ten_DM, Icon, Anh) OUTPUT INSERTED.Ma_DM VALUES(N'Nước hoa nam', 'nuoc-hoa-nam-1592132591595.jpg', 'nuoc-hoa-nam-1595134302-e58293.jpg')
INSERT INTO DanhMucSP(Ten_DM, Icon, Anh) OUTPUT INSERTED.Ma_DM VALUES(N'Nước hoa nữ', 'nuoc-hoa-nu-1592132613823.jpg', 'nuoc-hoa-nu-1595134321-f0fb6f.jpg')
INSERT INTO DanhMucSP(Ten_DM, Icon, Anh) OUTPUT INSERTED.Ma_DM VALUES(N'Nước hoa unisex', 'xit-toan-than-1592132631767.jpg', 'nuoc-hoa-unisex-1595134333-611c87.jpg')
INSERT INTO DanhMucSP(Ten_DM, Icon, Anh) OUTPUT INSERTED.Ma_DM VALUES(N'Nước hoa mini - vial', 'nuoc-hoa-mini-vial-1592446298773.png', 'nuoc-hoa-mini--vial-1595134351-ee6311.jpg')
INSERT INTO DanhMucSP(Ten_DM, Icon, Anh) OUTPUT INSERTED.Ma_DM VALUES(N'Nước hoa tester', 'duong-am-1592132657816.jpg', 'nuoc-hoa-tester-1595134378-00b002.jpg')
INSERT INTO DanhMucSP(Ten_DM, Icon, Anh) OUTPUT INSERTED.Ma_DM VALUES(N'Set nước hoa', 'set-nuoc-hoa-1592533576490.png', 'set-nuoc-hoa-1595134410-a36575.jpg')

INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Givenchy Gentleman Cologne EDT', 1, N'Givenchy', N'Hương gỗ thơm', N'Dự tiệc', 10, N'EDT (Eau De Toilette)', 100, 2190000, N'Mô tả nước hoa Givenchy Gentleman Cologne EDT')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Jo Malone Midnight Musk & Amber Limited Cologne', 1, N'Jo Malone', N'Hương cam chanh', N'Nam', 20, N'Cologne', 100, 2950000, N'Mô tả nước hoa Jo Malone Midnight Musk & Amber Limited Cologne')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Louis Vuitton Apogee EDP', 1, N'Louis Vuitton', N'Hương hoa cỏ', N'Dạo phố', 15, N'EDP (Eau De Parfum)', 100, 8700000, N'Mô tả nước hoa Louis Vuitton Apogee EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Montblanc Legend Spirit EDT', 1, N'Montblanc', N'Hương gỗ thơm', N'Mùa hè', 30, N'EDT (Eau De Toilette)', 200, 2190000, N'Mô tả nước hoa Nước hoa Montblanc Legend Spirit EDT')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Tom Ford Oud Wood', 1, N'Tom Ford', N'Hương gỗ phương đông', N'Mùa đông', 25,'EDP (Eau De Parfum)', 50, 5290000, N'Mô tả nước hoa Tom Ford Oud Wood')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Aura Mugler EDP', 2, N'Thierry Mugler', N'Hương phương đông', N'Sử dụng hàng ngày', 15, N'EDP (Eau De Parfum)', 90, 2290000, N'Mô tả nước hoa Aura Mugler EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Christian Louboutin Loubicroc EDP', 2, N'Christian Louboutin', N'Hương hoa cỏ phương đông', N'Đi chơi', 25, N'EDP (Eau De Parfum)', 90, 6890000, N'Mô tả nước hoa Christian Louboutin Loubicroc EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Elie Saab Le Parfum EDP', 2, N'Elie Saab', N'Hương hoa Nhài', N'Nữ', 10, N'EDP (Eau De Parfum)', 30, 1390000, N'Mô tả nước hoa Elie Saab Le Parfum EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Giorgio Armani My Way EDP', 2, N'Giorgio Armani', N'Hương hoa cỏ', N'Đi chơi', 10, N'EDT (Eau De Parfum)', 100, 2490000, N'Mô tả nước hoa Giorgio Armani My Way EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Lancome La Vie est Belle Leclat EDP', 2, N'Tom Ford', N'Hương gỗ phương đông', N'Văn phòng', 20, N'EDP (Eau De Parfum)', 75, 2390000, N'Mô tả nước hoa Lancome La Vie est Belle Leclat EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Al Haramain Perfumes Amber Oud Gold Edition', 3, N'Al Haramain Perfumes', N'Hương phương đông', N'Unisex', 10, N'EDP (Eau De Parfum)', 60, 1750000, N'Mô tả nước hoa Al Haramain Perfumes Amber Oud Gold Edition')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Atelier Des Ors Rose Omeyyade Eau De Parfum', 3, N'Atelier Des Ors', N'Hương hoa cỏ phương đông', N'Dự tiệc', 20, N'EDP (Eau De Parfum)', 100, 6500000, N'Mô tả nước hoa Atelier Des Ors Rose Omeyyade Eau De Parfum')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Le Labo Rose', 3, N'Le labo', N'Hương gỗ hoa cỏ Xạ Hương', N'Nam', 30, N'EDP (Eau De Parfum)', 50, 4500000, N'Mô tả nước hoa Le Labo Rose')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Louis Vuitton California Dream EDP', 3, N'Louis Vuitton', N'Hương hoa cỏ trái cây', N'Dạo phố', 40, N'EDT (Eau De Parfum)', 100, 8700000, N'Mô tả nước hoa Louis Vuitton California Dream EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa MCM Eau De Parfum', 3, N'Tom Ford', N'Hương gỗ phương đông', N'Mùa hè', 50, N'EDP (Eau De Parfum)', 75, 2550000, N'Mô tả nước hoa MCM Eau De Parfum')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa mini ACQUA DI GIO EDT', 4, N'Giorgio Armani', N'Hương hoa cỏ trái cây', N'Mùa đông', 25, N'EDP (Eau De Parfum)', 5, 2190000, N'Mô tả nước hoa mini ACQUA DI GIO EDT')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa mini Dior MISS Dior EDP', 4, N'Dior', N'Hương hoa cỏ Chypre', N'Sử dụng hàng ngày', 15, N'EDP (Eau De Parfum)', 5, 2950000, N'Mô tả nước hoa mini Dior MISS Dior EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa mini Kenzo FLOWER EDP', 4, N'Kenzo', N'Hương hoa cỏ phương đông', N'Đi chơi', 20, N'EDP (Eau De Parfum)', 5, 8700000, N'Mô tả nước hoa mini Kenzo FLOWER EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Vial nước hoa Hermes TERRE DHermes EDT', 4, N'Hermes', N'Hương gỗ cay nồng', N'Nữ', 25, N'EDT (Eau De Toilette)', 2, 2190000, N'Mô tả Vial nước hoa Hermes TERRE DHermes EDT')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Vial nước hoa Montblanc EMBLEM EDT', 4, N'Montblanc', N'Hương gỗ cay nồng', N'Đi chơi', 30, N'EDP (Eau De Toilette)', 2, 5290000, N'Mô tả Vial nước hoa Montblanc EMBLEM EDT')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Armani CODE ABSOLU EDP', 5, N'Giorgio Armani', N'Hương thơm cay nồng', N'Văn phòng', 10, N'EDP (Eau De Parfum)', 60, 1590000, N'Mô tả nước hoa Armani CODE ABSOLU EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Calvin Klein One Shock Men EDT', 5, N'Calvin Klein', N'Hương hoa cỏ phương đông', N'Unisex', 20, N'EDT (Eau De Toilette)', 200, 1390000, N'Mô tả nước hoa Calvin Klein One Shock Men EDT')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Davidoff Cool Water Man', 5, N'Davidoff', N'Hương thơm biển', N'Dự tiệc', 10, N'EDT (Eau De Toilette)', 120, 760000, N'Mô tả nước hoa Davidoff Cool Water Man')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Jimmy Choo LEAU EDT TESTER FULL SEAL', 5, N'Jimmy Choo', N'Hương hoa cỏ trái cây', N'Nam', 25, N'EDT (Eau De Toilette)', 90, 1750000, N'Mô tả nước hoa Jimmy Choo LEAU EDT TESTER FULL SEAL')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Versace BRIGHT CRYSTAL EDT', 5, N'Versace', N'Hương hoa cỏ trái cây', N'Dạo phố', 25, N'EDT (Eau De Toilette)', 90, 1490000, N'Mô tả nước hoa Versace BRIGHT CRYSTAL EDT')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Gift set nước hoa Hermes Terre dHermes Pure Perfume 3pcs', 6, N'Hermes', N'Hương phương đông', N'Mùa hè', 20, N'Parfum', 120, 2590000, N'Mô tả Gift set nước hoa Hermes Terre dHermes Pure Perfume 3pcs')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set 1 chai nước hoa Bvlgari AQUA EDT 100ML+ ASB 100ml + TÚI', 6, N'Bvlgari', N'Hương thơm biển', N'Mùa đông', 25, N'EDT (Eau De Toilette)', 100, 1770000, N'Mô tả set 1 chai nước hoa Bvlgari AQUA EDT 100ML+ ASB 100ml + TÚI')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set nước hoa Armani IN LOVE WITH YOU EDP 100ml +1 Dưỡng Ẩm 50ml + 1 chai nước hoa mini 15ml', 6, N'Giorgio Armani', N'Hương hoa cỏ trái cây', N'Sử dụng hàng ngày', 10, N'EDP (Eau De Parfum)', 100, 1810000, N'Mô tả set nước hoa Armani IN LOVE WITH YOU EDP 100ml +1 Dưỡng Ẩm 50ml + 1 chai nước hoa mini 15ml')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set nước hoa Armani SI PASSIONE EDP 100ml + 1 Chai Lotion 75ml + 1 Chai MINI 15ml', 6, N'Giorgio Armani', N'Hương hoa cỏ trái cây', N'Đi chơi', 20, N'EDT (Eau De Parfum)', 100, 2930000, N'Mô tả set nước hoa Armani SI PASSIONE EDP 100ml + 1 Chai Lotion 75ml + 1 Chai MINI 15ml')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set nước hoa Armani SI EDP 50ml + MASCARA + SON', 6, N'Giorgio Armani', N'Hương hoa cỏ Síp', N'Văn phòng', 15, N'EDP (Eau De Parfum)', 50, 2190000, N'Mô tả set nước hoa Armani SI EDP 50ml + MASCARA + SON')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Tom Ford Neroli Portofino Eau de Parfum', 1, N'Tom Ford', N'Hương cam chanh', N'Dạo phố', 15, N'EDP (Eau De Parfum)', 50, 4490000, N'Mô tả nước hoa Louis Vuitton Apogee EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Tom Ford Lost Cherry Eau de Parfum', 1, N'Tom Ford', N'Hương phương đông', N'Mùa hè', 30, N'EDT (Eau De Parfum)', 50, 6090000, N'Mô tả nước hoa Nước hoa Montblanc Legend Spirit EDT')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Tom Ford Ombre Leather EDP', 1, N'Tom Ford', N'Hương da thuộc', N'Mùa đông', 25,'EDP (Eau De Parfum)', 50, 2750000, N'Mô tả nước hoa Tom Ford Oud Wood')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Dior POISON NEW', 2, N'Dior', N'Hương hoa cỏ', N'Nữ', 10, N'EDP (Eau De Toilette)', 100, 2590000, N'Mô tả nước hoa Dior POISON NEW')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Bvlgari GOLDEA EDP', 2, N'Bvlgari', N'Hương hoa cỏ phương đông', N'Đi chơi', 10, N'EDT (Eau De Parfum)', 90, 1890000, N'Mô tả nước hoa Bvlgari GOLDEA EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Dior JADORE EDP', 2, N'Dior', N'Hương hoa cỏ trái cây', N'Văn phòng', 20, N'EDP (Eau De Parfum)', 50, 1990000, N'Mô tả nước hoa Dior JADORE EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Memo Paris SHAMS OUD EDP', 3, N'Memo Paris', N'Hương phương đông', N'Nam', 30, N'EDP (Eau De Parfum)', 75, 4160000, N'Mô tả nước hoa Le Labo Rose 31')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Mancera WILD LEATHER EDP', 3, N'Mancera', N'Hương da thuộc', N'Dạo phố', 40, N'EDT (Eau De Parfum)', 120, 2390000, N'Mô tả nước hoa Louis Vuitton California Dream EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Mancera ROSES GREEDY EDP', 3, N'Mancera', N'Hương hoa cỏ trái cây thực phẩm', N'Mùa hè', 50, N'EDP (Eau De Parfum)', 120, 2390000, N'Mô tả nước hoa MCM Eau De Parfum')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa mini PARIS HILTON SIREN ROLL ON EDP', 4, N'Hermes', N'Hương hoa cỏ phương đông', N'Nữ', 25, N'EDT (Eau De Parfum)', 10, 2490000, N'Mô tả nước hoa mini PARIS HILTON SIREN ROLL ON EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa mini PARIS HILTON HEIRESS ROLL ON EDP', 4, N'Montblanc', N'Hương hoa cỏ trái cây', N'Đi chơi', 30, N'EDP (Eau De Parfum)', 10, 2490000, N'Mô tả nước hoa mini PARIS HILTON HEIRESS ROLL ON EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa mini GIORGIO BEVERLY HILLS EDT', 4, N'Giorgio Armani', N'Hương hoa cỏ phương đông', N'Đi chơi', 20, N'EDP (Eau De Toilette)', 10, 249000, N'Mô tả nước hoa mini GIORGIO BEVERLY HILLS EDT')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Hermes TERRE EAU INTENSE VETIVER EDP TESTER', 5, N'Hermes', N'Hương gỗ thơm', N'Dự tiệc', 10, N'EDT (Eau De Toilette)', 100, 2190000, N'Mô tả nước hoa Hermes TERRE EAU INTENSE VETIVER EDP TESTER')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Hermes TWILLY EDP TESTER', 5, N'Hermes', N'Hương hoa cỏ', N'Nam', 25, N'EDT (Eau De Toilette)', 85, 2190000, N'Mô tả nước hoa Hermes TWILLY EDP TESTER')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Hermes TWILLY EAU POIVREE EDP TESTER', 5, N'Hermes', N'Hương hoa cỏ', N'Dạo phố', 25, N'EDT (Eau De Toilette)', 50, 1750000, N'Mô tả nước hoa Hermes TWILLY EAU POIVREE EDP TESTER')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set nước hoa Cacharel AMOR AMOR EDT 100ml + 1 Cacharel AMOR AMOR EDT 30ml', 6, N'Cacharel', N'Hương hoa cỏ trái cây', N'Sử dụng hàng ngày', 10, N'EDP (Eau De Parfum)', 100, 1570000, N'Mô tả set nước hoa Armani IN LOVE WITH YOU EDP 100ml +1 Dưỡng Ẩm 50ml + 1 chai nước hoa mini 15ml')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set 1 chai nước hoa MY BURBERRY BLUSH EDP 90ml + B/L 74ml + MINI 7.4ml', 6, N'Burberry', N'Hương hoa cỏ', N'Đi chơi', 20, N'EDT (Eau De Parfum)', 90, 1850000, N'Mô tả set nước hoa Armani SI PASSIONE EDP 100ml + 1 Chai Lotion 75ml + 1 Chai MINI 15ml')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set nước hoa CAROLINA HERRERA 212 VIP MEN EDT 100ml + 1 Sữa Tắm Shower Gel 100ml', 6, N'Carolina Herrera', N'Hương Vani phương đông', N'Văn phòng', 15, N'EDP (Eau De Parfum)', 100, 1720000, N'Mô tả set nước hoa Armani SI EDP 50ml + MASCARA + SON')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Maison Margiela Replica Sailing Day', 1, N'Maison Margiela', N'Hương hoa cỏ biển', N'Văn phòng', 15, N'EDP (Eau De Toilette)', 100, 3190000, N'Nước hoa Unisex Maison Margiela Replica Sailing Day được ra mắt năm 2017 với một màu sắc xanh đầu sức sống, hương thơm tươi mới vô cùng thu hút.')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Maison Margiela Replica Springtime In A Park', 1, N'Maison Margiela', N'Hương hoa cỏ trái cây', N'Đi chơi', 25, N'EDP (Eau De Toilette)', 100, 3190000, N'Được ra đời vào năm 2019, Replica Springtime in the park là dòng nước hoa hiện đại, đẹp tựa một câu chuyện cổ tích ngày Xuân được thuật lại bằng lời thì thầm của mùi hương. Những làn hương đã khéo léo ngưng đọng sự chuyển dịch của thời gian, để khoảnh khắc rộn ràng, xinh đẹp và tràn ngập hạnh phúc thản nhiên bao bọc trên dàn da của những cô Nàng.')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Marc Jacobs Daisy Dream EDT SP Women', 2, N'Marc Jacobs', N'Hương hoa cỏ trái cây', N'Mùa hè', 20, N'EDP (Eau De Toilette)', 100, 1590000, N'Mô tả nước hoa Marc Jacobs Daisy Dream EDT Sp Women')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set dầu thơm Gucci BLOOM EDP + XỊT DƯỠNG TÓC ', 2, N'Gucci', N'Hương hoa cỏ', N'Mùa đông', 20, N'EDP (Eau De Parfum)', 100, 2850000, N'Mô tả set dầu thơm Gucci BLOOM EDP 100ML + XỊT DƯỠNG TÓC 30ML')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Valentino VALENTINA WOMEN EDP', 2, N'Valentino', N'Hương hoa cỏ phương đông', N'Dạo phố', 10, N'EDP (Eau De Parfum)', 30, 1100000, N'Mô tả nước hoa Valentino VALENTINA WOMEN EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Louis Vuitton Nuit de Feu EDP', 3, N'Louis Vuitton', N'Hương hoa cỏ gỗ Xạ Hương', N'Nam', 30, N'EDP (Eau De Parfum)', 100, 8700000, N'Nước hoa Louis Vuitton Nuit de Feu EDP của nhà Louis Vuitton đã bày tỏ lòng tôn kính đối với văn hóa Trung đông nên đã cho ra mắt sản phẩm mới Nuit de Feu đầu tháng 7 năm 2020. Đây là một tác phẩm mê hoặc xung quanh những nốt hương vĩnh cửu của hương thơm da thuộc và gỗ.')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Vial nước hoa Braccialini DECO EDP', 4, N'Braccialini', N'Hương phương đông', N'Nữ', 15, N'EDP (Eau De Parfum)', 2, 100000, N'Mô tả Vial nước hoa Braccialini DECO EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Nước hoa Gucci BLOOM AMBROSIA DI FIORI EDP TESTER', 5, N'Gucci', N'Hương hoa cỏ', N'Dạo phố', 25, N'EDP (Eau De Parfum)', 100, 2550000, N'Mô tả nước hoa Gucci BLOOM AMBROSIA DI FIORI EDP TESTER')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Dầu thơm Gucci BLOOM NETTARE DI FIORI INTENSE EDP TESTER', 5, N'Gucci', N'Hương hoa cỏ', N'Sử dụng hàng ngày', 30, N'EDP (Eau De Parfum)', 100, 2250000, N'Mô tả dầu thơm Gucci BLOOM NETTARE DI FIORI INTENSE EDP TESTER')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set nước hoa nữ Christian Louboutin Loubiworld', 6, N'Christian Louboutin', N'Hương hoa cỏ Xạ Hương', N'Nam', 10, N'EDP (Eau De Parfum)', 100, 6500000, N'Set nước hoa nữ Christian Louboutin Loubiworld ngọt ngào say đắm quên lối về với hoa lan, tonka, vani... quyến rũ - sexy và ngất ngây, lôi cuốn đến ma mị.')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set nước hoa Bvlgari MAN WOOD ESSENCE EDP', 6, N'Bvlgari', N'Hương gỗ', N'Mùa hè', 15, N'EDP (Eau De Parfum)', 100, 2290000, N'Mô tả set nước hoa Bvlgari MAN WOOD ESSENCE EDP')
INSERT INTO SanPham(Ten_SP, Ma_DM, ThuongHieu_SP, MuiHuong_SP, MucDich_SP, SoLuong_SP, NongDo_SP, DungTich_SP, GiaBan_SP, MoTa_SP) OUTPUT INSERTED.Ma_SP VALUES(N'Set nước hoa Bvlgari AQVA POUR HOMME', 6, N'Bvlgari', N'Hương thơm biển', N'Sử dụng hàng ngày', 20, N'EDP (Eau De Toilette)', 100, 1750000, N'Mô tả set nước hoa Bvlgari AQVA POUR HOMME')

INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(1, 'nuoc-hoa-givenchy-gentleman-cologne-edt-1625538744-300394.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(1, 'nuoc-hoa-givenchy-gentleman-cologne-edt-1625538744-537828.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(1, 'nuoc-hoa-givenchy-gentleman-cologne-edt-1625538745-512289.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(2, 'nuoc-hoa-jo-Malone-midnight-musk-1625558678-1412e4.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(2, 'nuoc-hoa-jo-Malone-midnight-musk-1625558678-acca57.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(2, 'nuoc-hoa-jo-Malone-midnight-musk-1625558679-93c2fe.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(3, 'nuoc-hoa-louis-vuitton-apogee-edp-1625132208-eb3f8b.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(3, 'nuoc-hoa-louis-vuitton-apogee-edp-1625132209-60ebcb.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(3, 'nuoc-hoa-louis-vuitton-apogee-edp-1625132209-c45ce0.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(4, 'nuoc-hoa-Montblanc-legend-spirit-edt-1625624395-28b05a.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(4, 'nuoc-hoa-Montblanc-legend-spirit-edt-1625624393-8f15ed.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(4, 'nuoc-hoa-Montblanc-legend-spirit-edt-1625624394-c9e10e.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(5, 'nuoc-hoa-tom-ford-oud-wood-1625623516-72bb18.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(5, 'nuoc-hoa-tom-ford-oud-wood-1625623517-8d9869.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(5, 'nuoc-hoa-tom-ford-oud-wood-1625623517-5066ef.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(6, 'nuoc-hoa-aura-mugler-edp-1625553161-7c1be9.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(6, 'nuoc-hoa-aura-mugler-edp-1625553161-d5d219.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(6, 'nuoc-hoa-aura-mugler-edp-1625553162-575658.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(7, 'nuoc-hoa-christian-louboutin-loubicroc-edp-1625630180-2e6564.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(7, 'nuoc-hoa-christian-louboutin-loubicroc-edp-1625630181-48cce2.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(7, 'nuoc-hoa-christian-louboutin-loubicroc-edp-1625630182-717b18.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(8, 'nuoc-hoa-elie-saab-le-parfum-edp-1625543408-013ac5.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(8, 'nuoc-hoa-elie-saab-le-parfum-edp-1625543755-98f5bd.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(8, 'nuoc-hoa-elie-saab-le-parfum-edp-1625543756-e44e7c.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(9, 'nuoc-hoa-giorgio-Armani-my-way-edp-1625539514-c371af.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(9, 'nuoc-hoa-giorgio-Armani-my-way-edp-1625539514-f5e069.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(9, 'nuoc-hoa-giorgio-Armani-my-way-edp-1625539515-65a721.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(10, 'nuoc-hoa-lancome-la-vie-est-belle-leclat-edp-1625541129-b112c6.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(10, 'nuoc-hoa-lancome-la-vie-est-belle-leclat-edp-1625541130-3ad78b.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(10, 'nuoc-hoa-lancome-la-vie-est-belle-leclat-edp-1625541131-94e390.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(11, 'nuoc-hoa-al-haramain-perfumes-amber-oud-gold-edition-1618375359-14e7ea.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(11, 'nuoc-hoa-al-haramain-perfumes-amber-oud-gold-edition-1618375359-d5ff90.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(11, 'nuoc-hoa-al-haramain-perfumes-amber-oud-gold-edition-1618375360-32e07d.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(12, 'nuoc-hoa-atelier-des-ors-rose-omeyyade-eau-de-parfum-1623492938-2fc6ed.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(12, 'nuoc-hoa-atelier-des-ors-rose-omeyyade-eau-de-parfum-1623492940-c3b826.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(12, 'nuoc-hoa-atelier-des-ors-rose-omeyyade-eau-de-parfum-1623492942-47a44b.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(13, 'nuoc-hoa-le-labo-rose-31-1623400835-5e4e4f.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(13, 'nuoc-hoa-le-labo-rose-31-1623400835-67d96d.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(13, 'nuoc-hoa-le-labo-rose-31-1623400836-477cd7.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(14, 'nuoc-hoa-louis-vuitton-california-dream-1625128027-1bfc9d.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(14, 'nuoc-hoa-louis-vuitton-california-dream-1625128038-3bbf5b.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(14, 'nuoc-hoa-louis-vuitton-california-dream-1625128038-b8f757.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(15, 'nuoc-hoa-mcm-eau-de-parfum-1622792829-2ac912.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(15, 'nuoc-hoa-mcm-eau-de-parfum-1622792830-5bc903.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(15, 'nuoc-hoa-mcm-eau-de-parfum-1622792831-acf124.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(16, 'nuoc-hoa-mini-acqua-di-gio-edt-5ml-1598343139-b88b15.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(17, 'nuoc-hoa-mini-Dior-miss-Dior-edp-5ml-1598346594-b7243b.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(18, 'nuoc-hoa-mini-Kenzo-flower-edp-5ml-1598345775-89ddbe.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(19, 'vial-nuoc-hoa-Hermes-terre-dHermes-edt-2ml-1601106868-95a8da.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(20, 'vial-nuoc-hoa-Montblanc-emblem-edt-12ml-1601105864-e67386.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(21, 'nuoc-hoa-Armani-code-absolu-edp-60ml-tester-1597114279-872ed9.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(22, 'nuoc-hoa-calvin-klein-one-shock-men-edt-tester-200ml-1597113299-a94ceb.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(23, 'nuoc-hoa-Davidoff-cool-water-man-120ml-edt-tester-1597114164-8a32b3.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(24, 'nuoc-hoa-jimmy-choo-leau-edt-tester-full-seal-90ml-1597891683-1450aa.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(25, 'nuoc-hoa-Versace-bright-crystal-edt-tester-90ml-1597116601-0f0149.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(25, 'nuoc-hoa-Versace-bright-crystal-edt-tester-90ml-1597116601-8ad5c8.jpg.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(26, 'gift-set-nuoc-hoa-Hermes-terre-dHermes-pure-perfume-3pcs-1623472056-669d7a.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(26, 'gift-set-nuoc-hoa-Hermes-terre-dHermes-pure-perfume-3pcs-1623472057-11bbae.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(26, 'gift-set-nuoc-hoa-Hermes-terre-dHermes-pure-perfume-3pcs-1623472062-16ba3d.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(27, 'set-1-chai-nuoc-hoa-Bvlgari-aqua-edt-100ml--asb-100ml---tui-1592884392-ab2f9b.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(28, 'set-1-nuoc-hoa-Armani-in-love-with-you-edp-100ml--1-duong-am-50ml---1-chai-nuoc-hoa-mini-15ml-1592884150-c9e10e.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(29, 'set-1-nuoc-hoa-Armani-si-passione-edp-100ml---1-chai-lotion-75ml---1-chai-mini-15ml-1592886524-2c8295.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(30, 'set-nuoc-hoa-Armani-si-edp-50ml---mascara---son-1592884603-cad213.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(31, 'nuoc-hoa-tom-ford-neroli-portofino-eau-de-parfum-1617769133-e57789.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(32, 'nuoc-hoa-tom-ford-lost-cherry-eau-de-parfum-1617767764-57c2e0.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(32, 'nuoc-hoa-tom-ford-lost-cherry-eau-de-parfum-1617767765-4a68c4.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(32, 'nuoc-hoa-tom-ford-lost-cherry-eau-de-parfum-1617767765-8f2340.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(33, 'nuoc-hoa-tom-ford-ombre-leather-edp-1617767226-ba2142.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(33, 'nuoc-hoa-tom-ford-ombre-leather-edp-1617767231-2739b1.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(34, 'nuoc-hoa-poison-new-100ml-edt-sp-1603351359-d4df43.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(35, 'nuoc-hoa-Bvlgari-goldea-90ml-1603350781-d1e729.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(36, 'nuoc-hoa-Dior-jadore-edp-50ml-1601452917-44ecb1.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(37, 'nuoc-hoa-memo-paris-shams-oud-edp-75ml-1592901095-5191c4.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(38, 'nuoc-hoa-Mancera-wild-leather-edp-120ml-1592899814-b4acb2.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(39, 'nuoc-hoa-Mancera-roses-greedy-edp-120ml-1592899582-b5fc2c.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(40, 'nuoc-hoa-mini-paris-hilton-siren-roll-on-edp-10ml-1595664639-edc973.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(41, 'nuoc-hoa-mini-paris-hilton-heiress-roll-on-edp-10ml-1595663746-ae1538.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(42, 'nuoc-hoa-mini-giorgio-beverly-hills-red-edt-10ml-1595662900-18675a.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(43, 'nuoc-hoa-Hermes-terre-eau-intense-vetiver-edp-tester-100ml-1592974282-a006f0.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(43, 'nuoc-hoa-Hermes-terre-eau-intense-vetiver-edp-tester-100ml-1592974290-d96409.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(43, 'nuoc-hoa-Hermes-terre-eau-intense-vetiver-edp-tester-100ml-1592974297-7bacb6.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(44, 'nuoc-hoa-Hermes-twilly-edp-tester-85ml-1592973783-54f3f3.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(44, 'nuoc-hoa-Hermes-twilly-edp-tester-85ml-1592973789-5994f6.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(45, 'nuoc-hoa-Hermes-twilly-eau-poivree-edp-tester--50ml-1592973469-a8bdc5.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(45, 'nuoc-hoa-Hermes-twilly-eau-poivree-edp-tester--50ml-1592973509-e58a21.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(46, 'set-1-nuoc-hoa-amor-amor-Cacharel-100ml---1-nuoc-hoa-amor-amor-Cacharel-30ml-1592883537-883d27.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(47, 'set-1-chai-nuoc-hoa-my-burberry-blush-edp-90ml---b-l-74ml---mini-74ml-1592883076-15fa3c.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(48, 'set-1-nuoc-hoa-carolina-herrera-212-vip-men-edt-100ml---1-sua-tam-1592882616-f619f9.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(49, 'nuoc-hoa-maison-margiela-replica-sailing-day-1623644099-4a6e70.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(49, 'nuoc-hoa-maison-margiela-replica-sailing-day-1623644099-9b70e8.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(49, 'nuoc-hoa-maison-margiela-replica-sailing-day-1623644100-6d4281.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(50, 'nuoc-hoa-maison-margiela-replica-springtime-in-a-park-1623642929-cbc87e.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(50, 'nuoc-hoa-maison-margiela-replica-springtime-in-a-park-1623642930-c3cf77.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(50, 'nuoc-hoa-maison-margiela-replica-springtime-in-a-park-1623642931-bb17a4.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(51, 'nuoc-hoa-marc-jacobs-daisy-dream-edt-sp-women-100ml-1601088420-9bbe35.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(52, 'set-dau-thom-Gucci-bloom-edp-100ml---xit-duong-toc-30ml-1598670504-e67386.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(53, 'nuoc-hoa-Valentino-valentina-women-edp-30ml-1598331468-80f860.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(54, 'nuoc-hoa-louis-vuitton-nuit-de-feu-edp-1625129936-b4c517.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(54, 'nuoc-hoa-louis-vuitton-nuit-de-feu-edp-1625129936-bbe070.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(54, 'nuoc-hoa-louis-vuitton-nuit-de-feu-edp-1625129948-c8d47d.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(55, 'vial-nuoc-hoa-Braccialini-deco-edp-17ml-1596616449-33ab37.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(56, 'nuoc-hoa-Gucci-bloom-ambrosia-di-fiori-edp-tester-100ml-1592985555-15fed5.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(56, 'nuoc-hoa-Gucci-bloom-ambrosia-di-fiori-edp-tester-100ml-1592985563-46f0cc.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(57, 'dau-thom-Gucci-bloom-nettare-di-fiori-intense-edp-tester-100ml-1592985309-79b400.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(57, 'dau-thom-Gucci-bloom-nettare-di-fiori-intense-edp-tester-100ml-1592985336-30febd.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(58, 'set-nuoc-hoa-nu-christian-louboutin-loubiworld-1625545659-868d13.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(58, 'set-nuoc-hoa-nu-christian-louboutin-loubiworld-1625545660-c2a9c9.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(58, 'set-nuoc-hoa-nu-christian-louboutin-loubiworld-1625545666-72e584.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(59, 'set-nuoc-hoa-Bvlgari-man-wood-essence-edp-100ml---15ml-1598846371-5b7909.jpg')
INSERT INTO Anh(Ma_SP, DuongDanAnh) OUTPUT INSERTED.Ma_Anh VALUES(60, 'set-nuoc-hoa-Bvlgari-aqva-pour-homme-100ml---100ml-lb-1599104259-35c64c.jpg')


INSERT INTO GioHang(Ma_TK, Ma_SP, SoLuong_GH) OUTPUT INSERTED.Ma_GH VALUES(1, 1, 2)
INSERT INTO GioHang(Ma_TK, Ma_SP, SoLuong_GH) OUTPUT INSERTED.Ma_GH VALUES(1, 2, 1)
INSERT INTO GioHang(Ma_TK, Ma_SP, SoLuong_GH) OUTPUT INSERTED.Ma_GH VALUES(1, 4, 3)
INSERT INTO GioHang(Ma_TK, Ma_SP, SoLuong_GH) OUTPUT INSERTED.Ma_GH VALUES(2, 2, 2)
INSERT INTO GioHang(Ma_TK, Ma_SP, SoLuong_GH) OUTPUT INSERTED.Ma_GH VALUES(2, 8, 4)

INSERT INTO DonHang(Ma_TK, NgayDat_DH, TrangThai_DH, DienThoai_DH, HoTen_DH, Email_DH, DiaChi_DH, GhiChu_DH) OUTPUT INSERTED.Ma_DH VALUES(1, '2021/07/21 10:00:25', 1, '0123456789', N'Vương Tá Cường', 'cuongvt@gmail.com', N'Hà Nôi', N'Hàng dễ vỡ')
INSERT INTO DonHang(Ma_TK, NgayDat_DH, TrangThai_DH, DienThoai_DH, HoTen_DH, Email_DH, DiaChi_DH, GhiChu_DH) OUTPUT INSERTED.Ma_DH VALUES(2, '2021/07/21 15:30:00', 0, '0123456789', N'Nguyễn Thành Đạt', 'datnt@gmail.com', N'Hà Nôi', N'Hàng dễ vỡ')
INSERT INTO DonHang(Ma_TK, NgayDat_DH, TrangThai_DH, DienThoai_DH, HoTen_DH, Email_DH, DiaChi_DH, GhiChu_DH) OUTPUT INSERTED.Ma_DH VALUES(3, '2021/07/21 19:25:06', 1, '0123456789', N'Đặng Quang Huy', 'huydq@gmail.com', N'Hà Nôi', N'Hàng dễ vỡ')
INSERT INTO DonHang(Ma_TK, NgayDat_DH, TrangThai_DH, DienThoai_DH, HoTen_DH, Email_DH, DiaChi_DH, GhiChu_DH) OUTPUT INSERTED.Ma_DH VALUES(4, '2021/07/21 08:17:32', 1, '0123456789', N'SIHALATH Souksavanh', 'shihalaths@gmail.com', N'Hà Nôi', N'Hàng dễ vỡ')

INSERT INTO ChiTietDH(Ma_DH, Ma_SP, SoLuong_CT) OUTPUT INSERTED.Ma_CT VALUES(1, 1, 1)
INSERT INTO ChiTietDH(Ma_DH, Ma_SP, SoLuong_CT) OUTPUT INSERTED.Ma_CT VALUES(1, 2, 1)
INSERT INTO ChiTietDH(Ma_DH, Ma_SP, SoLuong_CT) OUTPUT INSERTED.Ma_CT VALUES(2, 6, 3)
INSERT INTO ChiTietDH(Ma_DH, Ma_SP, SoLuong_CT) OUTPUT INSERTED.Ma_CT VALUES(2, 7, 5)
INSERT INTO ChiTietDH(Ma_DH, Ma_SP, SoLuong_CT) OUTPUT INSERTED.Ma_CT VALUES(3, 11, 2)
INSERT INTO ChiTietDH(Ma_DH, Ma_SP, SoLuong_CT) OUTPUT INSERTED.Ma_CT VALUES(4, 16, 5)


SELECT * FROM Quyen
SELECT * FROM TaiKhoan
SELECT * FROM DanhMucSP
SELECT * FROM SanPham
SELECT * FROM Anh
SELECT * FROM GioHang
SELECT * FROM DonHang
SELECT * FROM ChiTietDH

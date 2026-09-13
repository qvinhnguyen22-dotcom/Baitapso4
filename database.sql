-- =======================================================
-- SCRIPT TẠO CƠ SỞ DỮ LIỆU VÀ DỮ LIỆU MẪU CHO DỰ ÁN JPA
-- HỆ QUẢN TRỊ CƠ SỞ DỮ LIỆU: MICROSOFT SQL SERVER
-- DATABASE: JPA_DB
-- =======================================================

USE master;
GO

-- 1. Tạo Database nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'JPA_DB')
BEGIN
    CREATE DATABASE JPA_DB;
END
GO

USE JPA_DB;
GO

-- 2. Xóa các bảng cũ nếu đã tồn tại để tránh xung đột khóa ngoại
IF OBJECT_ID('dbo.products', 'U') IS NOT NULL DROP TABLE dbo.products;
IF OBJECT_ID('dbo.videos', 'U') IS NOT NULL DROP TABLE dbo.videos;
IF OBJECT_ID('dbo.categories', 'U') IS NOT NULL DROP TABLE dbo.categories;
IF OBJECT_ID('dbo.users', 'U') IS NOT NULL DROP TABLE dbo.users;
GO

-- 3. Tạo bảng categories (Danh mục)
CREATE TABLE dbo.categories (
    CategoryId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CategoryName NVARCHAR(255) NOT NULL,
    Images NVARCHAR(500) NULL,
    Status INT NOT NULL DEFAULT 1 -- 1: Hoạt động, 0: Đang khóa
);
GO

-- 4. Tạo bảng products (Sản phẩm - Mối quan hệ 1-N với categories)
CREATE TABLE dbo.products (
    productId INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    productName NVARCHAR(200) NOT NULL,
    price FLOAT NOT NULL DEFAULT 0,
    description NVARCHAR(MAX) NULL,
    images NVARCHAR(500) NULL,
    categoryId INT NULL,
    CONSTRAINT FK_Product_Category FOREIGN KEY (categoryId) 
        REFERENCES dbo.categories(CategoryId)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
GO

-- 5. Tạo bảng users (Người dùng)
CREATE TABLE dbo.users (
    id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    fullname NVARCHAR(200) NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(200) NOT NULL,
    phone NVARCHAR(10) NULL,
    avatar NVARCHAR(500) NULL,
    images NVARCHAR(500) NULL,
    status BIT NOT NULL DEFAULT 0, -- 0: Chưa kích hoạt, 1: Đã kích hoạt OTP
    code NVARCHAR(10) NULL         -- Mã OTP kích hoạt hoặc quên mật khẩu
);
GO

-- 6. Tạo bảng videos (Bổ sung theo Entity Video của dự án)
CREATE TABLE dbo.videos (
    videoId NVARCHAR(50) NOT NULL PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    poster NVARCHAR(500) NULL,
    views INT NOT NULL DEFAULT 0,
    description NVARCHAR(MAX) NULL,
    active BIT NOT NULL DEFAULT 1,
    categoryId INT NULL,
    CONSTRAINT FK_Video_Category FOREIGN KEY (categoryId) 
        REFERENCES dbo.categories(CategoryId)
        ON DELETE CASCADE
);
GO

-- =======================================================
-- 7. CHÈN DỮ LIỆU MẪU (SEED DATA)
-- =======================================================

-- 7.1. Chèn Danh mục
SET IDENTITY_INSERT dbo.categories ON;
INSERT INTO dbo.categories (CategoryId, CategoryName, Images, Status) VALUES
(1, N'Điện thoại & Tablet', N'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=600&auto=format&fit=crop&q=80', 1),
(2, N'Laptop & Máy tính', N'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600&auto=format&fit=crop&q=80', 1),
(3, N'Âm thanh & Phụ kiện', N'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&auto=format&fit=crop&q=80', 1),
(4, N'Đồng hồ thông minh', N'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&auto=format&fit=crop&q=80', 1);
SET IDENTITY_INSERT dbo.categories OFF;
GO

-- 7.2. Chèn 12 Sản phẩm mẫu (Để kiểm thử phân trang 6sp/trang và 10sp mới nhất)
SET IDENTITY_INSERT dbo.products ON;
INSERT INTO dbo.products (productId, productName, price, description, images, categoryId) VALUES
(1, N'iPhone 15 Pro Max 256GB', 29990000, N'Khung titan chuẩn hàng không vũ trụ, chip A17 Pro mạnh mẽ, camera tiềm vọng zoom 5x cực đỉnh.', N'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=600&auto=format&fit=crop&q=80', 1),
(2, N'Samsung Galaxy S24 Ultra', 27490000, N'Tích hợp Galaxy AI thông minh, bút S-Pen đa năng, camera 200MP siêu nét và màn hình phẳng cao cấp.', N'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&auto=format&fit=crop&q=80', 1),
(3, N'MacBook Pro 14 M3 Pro', 49990000, N'Hiệu năng đột phá với chip Apple M3 Pro, màn hình Liquid Retina XDR 120Hz sắc nét, pin dùng đến 18 giờ.', N'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&auto=format&fit=crop&q=80', 2),
(4, N'Dell XPS 13 Plus 9320', 38500000, N'Thiết kế tương lai với hàng phím cảm ứng điện dung, màn hình OLED 3.5K viền siêu mỏng ấn tượng.', N'https://images.unsplash.com/photo-1593642632823-8f785ba67e45?w=600&auto=format&fit=crop&q=80', 2),
(5, N'Tai nghe Sony WH-1000XM5', 7990000, N'Công nghệ chống ồn chủ động hàng đầu thế giới, âm thanh Hi-Res Audio chuẩn mực, thời lượng pin 30h.', N'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=600&auto=format&fit=crop&q=80', 3),
(6, N'Loa Bluetooth Marshall Stanmore III', 9490000, N'Âm thanh đậm chất Rock cổ điển, dải âm trường rộng, kết nối Bluetooth 5.2 hiện đại và cổng 3.5mm.', N'https://images.unsplash.com/photo-1545454675-3531b543be5d?w=600&auto=format&fit=crop&q=80', 3),
(7, N'Apple Watch Ultra 2 GPS + Cellular', 21490000, N'Vỏ titan 49mm siêu bền bỉ, màn hình sáng 3000 nits thách thức nắng gắt, pin tới 72 giờ ở chế độ tiết kiệm.', N'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=600&auto=format&fit=crop&q=80', 4),
(8, N'iPad Pro 11 inch M4', 28990000, N'Độ mỏng kinh ngạc, màn hình Ultra Retina XDR OLED kép siêu sáng, hỗ trợ Apple Pencil Pro thế hệ mới.', N'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600&auto=format&fit=crop&q=80', 1),
(9, N'Tai nghe AirPods Pro Gen 2 USB-C', 5490000, N'Khử tiếng ồn chủ động gấp 2 lần, tính năng âm thanh thích ứng tự động, cổng sạc USB-C đồng bộ tiện lợi.', N'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600&auto=format&fit=crop&q=80', 3),
(10, N'Laptop Gaming ASUS ROG Zephyrus G14', 45990000, N'Cỗ máy chiến game mỏng nhẹ, trang bị AMD Ryzen 9 cùng đồ họa RTX 4070, màn hình OLED ROG Nebula 120Hz.', N'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=600&auto=format&fit=crop&q=80', 2),
(11, N'Đồng hồ Samsung Galaxy Watch 6 Classic', 6890000, N'Viền bezel xoay vật lý trứ danh, theo dõi sức khỏe và giấc ngủ toàn diện, đo điện tâm đồ ECG chính xác.', N'https://images.unsplash.com/photo-1510017803434-a899398421b3?w=600&auto=format&fit=crop&q=80', 4),
(12, N'Bàn phím cơ Keychron Q1 Pro Wireless', 4200000, N'Vỏ nhôm CNC nguyên khối, kết nối không dây Bluetooth 5.1 và có dây Type-C, switch mượt mà có hotswap.', N'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=600&auto=format&fit=crop&q=80', 3);
SET IDENTITY_INSERT dbo.products OFF;
GO

-- 7.3. Chèn Người dùng mẫu
-- Mật khẩu mặc định: 123456
SET IDENTITY_INSERT dbo.users ON;
INSERT INTO dbo.users (id, fullname, email, username, password, phone, avatar, images, status, code) VALUES
(1, N'Nguyễn Quang Vinh (Admin)', N'admin@quangvinh.vn', N'admin', N'123456', N'0912345678', NULL, NULL, 1, NULL),
(2, N'Nguyễn Văn A (User)', N'user@quangvinh.vn', N'user01', N'123456', N'0987654321', NULL, NULL, 1, NULL),
(3, N'Trần Thị B (Chưa kích hoạt)', N'pending@quangvinh.vn', N'pending01', N'123456', N'0901234567', NULL, NULL, 0, N'654321');
SET IDENTITY_INSERT dbo.users OFF;
GO

PRINT N'=== KHỞI TẠO DATABASE JPA_DB VÀ DỮ LIỆU MẪU THÀNH CÔNG! ===';
GO

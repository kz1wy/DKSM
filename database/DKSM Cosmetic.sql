DROP DATABASE IF EXISTS dksm_cosmetic;
CREATE DATABASE dksm_cosmetic;

USE dksm_cosmetic;
SET QUOTED_IDENTIFIER OFF
SET ANSI_NULLS ON

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    password VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    address nVARCHAR(300),
    phone VARCHAR(10),
    role ENUM('user', 'admin') NOT NULL DEFAULT 'user'
);

CREATE TABLE categories (
    category_id VARCHAR(3) PRIMARY KEY,
    category_name nVARCHAR(30) NOT NULL
);

CREATE TABLE products (
    product_id VARCHAR(6) PRIMARY KEY,
    category_id VARCHAR(3) NOT NULL,
    product_name nVARCHAR(100) NOT NULL,
    brand_name VARCHAR(50) NOT NULL,
    description nVARCHAR(2500),
    price DECIMAL(10, 3) NOT NULL,
    size VARCHAR(10) NOT NULL,
    image_url VARCHAR(150) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE cart_items (
    cart_item_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id VARCHAR(6) NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    shipping_address VARCHAR(500) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id VARCHAR(6) NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 3) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

USE dksm_cosmetic;


INSERT INTO categories (category_id, category_name)
VALUES
('SRM', N'Sữa rửa mặt'),
('TDC', N'Tẩy da chết'),
('KCN', N'Kem chống nắng'),
('NTT', N'Nước tẩy trang'),
('SER', N'Serum'),
('KDD', N'Kem dưỡng'),
('LOT', N'Lotion');


INSERT INTO products (product_id, category_id, product_name, brand_name, description, price, size, image_url)
VALUES
('SRM001', 'SRM', N'Sữa rửa mặt tạo bọt Cerave Foaming Facial Cleanser 355ml', 'Cerave', N'SỮA RỬA MẶT TẠO BỌT CERAVE
Sữa rửa mặt tạo bọt Cerave là sản phẩm lý tưởng để loại bỏ dầu thừa, bụi bẩn và lớp trang điểm. Sữa rửa mặt Cerave Foaming Facial Cleanser có ceramides, axit hyaluronic và niacinamide giúp khôi phục hàng rào bảo vệ da và làm dịu da.
Sữa rửa mặt CeraVe Foaming Facial Cleanser được phát triển với các chuyên gia da liễu để làm sạch sâu, loại bỏ dầu thừa và làm tươi mới làn da mà không làm da bị bong tróc hoặc để lại cảm giác khô rít. Với ceramide thiết yếu, axit hyaluronic và niacinamide, sữa rửa mặt tạo bọt dạng gel không gây kích ứng giúp làm sạch và chăm sóc làn da thường đến da dầu của bạn.

THÀNH PHẦN SỮA RỬA MẶT CERAVE :
AQUA / WATER / EAU, COCAMIDOPROPYL HYDROXYSULTAINE, GLYCERIN, SODIUM LAUROYL SARCOSINATE, PEG-150 PENTAERYTHRITYL TETRASTEARATE, NIACINAMIDE, PEG-6 CAPRYLIC / CAPRIC GLYCERIDES, SODIUM METHYL COCOYL TAURATE, PROPYLENE GLYCOL, CERAMIDE NP, CERAMIDE AP, CERAMIDE EOP, CARBOMER METHYLPARABEN, SODIUM CHLORIDE, SODIUM LAUROYL LACTYLATE, CHOLESTEROL, DISODIUM EDTA, PROPYLPARABEN, CITRIC ACID, TETRASODIUM EDTA, HYDROLYZED HYALURONIC ACID, PHYTOSPHINGOSINE, XANTHAN GUM.

HƯỚNG DẪN SỬ DỤNG 
Làm ướt da bằng nước
Mát xa sữa rửa mặt Cerave vào da theo chuyển động tròn, nhẹ nhàng
Rửa sạch lại với nước', 470.000, '355ml', '1.jpg'),

('KDD001', 'KDD', N'Kem dưỡng ẩm Cerave Moisturizing Cream', 'Cerave', N'KEM DƯỠNG ẨM PHỤC HỒI DA CERAVE MOISTURIZING CREAM :
CeraVe Moisturizing Cream bao gồm ba loại ceramide thiết yếu và axit hyaluronic giúp cấp ẩm hiệu quả cho da và khôi phục hàng rào bảo vệ của da. Được phát triển bởi các bác sĩ da liễu và thích hợp cho da khô và rất khô trên da mặt và da cơ thể, kem dưỡng ẩm CeraVe Moisturizing Cream giàu dưỡng chất, không nhờn, thẩm thấu nhanh. Với công nghệ MVE đã được cấp bằng sáng chế giúp giải phóng một lượng thành phần dưỡng ẩm ổn định suốt cả ngày và đêm. CeraVe Moisturizing Cream không có mùi thơm.

THÀNH PHẦN :
AQUA / WATER / EAU, GLYCERIN, CETEARYL ALCOHOL, CAPRYLIC / CAPRIC TRIGLYCERIDE, CETYL ALCOHOL, CETEARETH-20, PETROLATUM , POTASSIUM PHOSPHATE, CERAMIDE NP, CERAMIDE AP, CERAMIDE EOP, CARBOMER, DIMETHICONE , BEHENTRIMONIUM METHOSULFATE, SODIUM LAUROYL LACTYLATE, SODIUM HYALURONATE , CHOLESTEROL, PHENOXYETHANOL, DISODIUM EDTA, DIPOTASSIUM PHOSPHATE, TOCOPHEROL, PHYTOSPHINGOSINE, XANTHAN GUM, ETHYLHEXYLGLYCERIN

HƯỚNG DẪN SỬ DỤNG :
Sử dụng ngày 2 lần sáng và tối.', 980.000, '539g', '2.jpg'),

('KCN001', 'KCN', N'Kem chống nắng Cerave Hydrating Mineral Sunscreen SPF 50', 'Cerave', N'KEM CHỐNG NẮNG DƯỠNG ẨM CERAVE HYADRATING MINERAL SPF 50:
Kem chống nắng Cerave giúp bảo vệ da khỏi ánh nắng mặt trời, giúp cấp ẩm và dưỡng da mặt dịu nhẹ hiệu quả. CeraVe Hydrating Sunscreen Face SPF 50 là loại kem chống nắng 100% không chứa dầu với Titan Dioxide & Kẽm Oxit tạo thành một hàng rào bảo vệ trên bề mặt da giúp chống lại tia UVA và UVB mà không gây kích ứng da.
Công thức với ba loại Ceramides cần thiết giúp phục hồi hàng rào bảo vệ da và cấp ẩm lâu dài. Niacinamide giúp làm dịu da – một sản phẩm chống nắng nhẹ nhàng nhưng hiệu quả đã được Hiệp hội bệnh chàm và Tổ chức nghiên cứu Ung thư da dán nhãn An toàn để sử dụng hàng ngày.

THÀNH PHẦN:
THÀNH PHẦN HOẠT TÍNH : TITANIUM DIOXIDE (9%), ZINC OXIDE (7%)
THÀNH PHẦN KHÔNG HOẠT ĐỘNG : NƯỚC, GLYCERIN, C12-15 ALKYL BENZOATE, DIMETHICONE, ISODODECANE, STYRENE / ACRYLATES COPOLYMER, GLYCERYL STEARATE, BUTYLOCTYL SALICYLATE, DICAPRYLYL CARBONATE, PROPANEDIOL, STEARIC ACID, ALUMINIUM HYDROXIDE, PEG-100 STEARATE, SORBITAN STEARATE, NIACINAMIDE, PEG-8 LAURATE, CERAMIDE NP, CERAMIDE AP ISOSTEARATE, CARBOMER, CETEARYL ALCOHOL, CETEARETH-20, TRIETHOXYCAPRYLYLSILANE, DIMETHICONOL, SODIUM CITRATE, SODIUM LAUROYL LACTYLATE, SODIUM DODECYLBENZENESULFONATE, MYRISTIC ACID, SODIUM HYALURONATE, CHOLESTEROL, PALMITIC ACID, PHENOXYLDETHANOL, CHLORPHENESLY HYDROXYT NATRI, TOCOPHEROLLDIME METHYL CAPRYLYL GLYCOL, AXIT XITRIC, PANTHENOL, KẸO CAO SU XANTHAN, PHYTOSPHINGOSINE, AXIT POLYHYDROXYSTEARIC, POLYSORBATE 60, ETHYLHEXYLGLYCERIN

HƯỚNG DẪN SỬ DỤNG:
Dùng 15 phút trước khi ra nắng. Sử dụng lại một lần nữa nếu ra mồ hôi, hoặc sau khi bơi 40 phút để kem đạt hiệu quả tốt nhất.', 420.000, '70ml', '3.jpg'),


('SRM002', 'SRM', N'Sửa rửa mặt tẩy tế bào chết Cerave Renewing SA Cleanser 237ml', 'Cerave', N'Sữa rửa mặt Cerave Renewing SA Clenaser chứa Salicylic Axit giúp loại bỏ tế bào chết, làm mềm làn da thô ráp giúp cho làn da trở nên mịn màng, đồng thời loại bỏ dầu và bụi bẩn hiệu quả mà không để lại cảm giác khô da. Sử dụng cho da mặt và cơ thể bị mụn trứng cá.

THÀNH PHẦN:
AQUA / WATER / EAU, COCAMIDOPROPYL HYDROXYSULTAINE, GLYCERIN, SODIUM LAUROYL SARCOSINATE, NIACINAMIDE, GLUCONOLACTONE, PEG-150 PENTAERYTHRITYL TETRASTEARATE, SODIUM METHYL COCOYL TAURATE, ZEA MAYS OIL / CORN OIL, CERAMIDE NP, CERAMIDE AP, CERAMIDE EOP, CARBOMER , NATRI CLORUA, AXIT SALICYLIC, NATRI BENZOAT, NATRI LAUROYL LACTYLAT, CHOLECALCIFEROL, CHOLESTEROL, PHENOXYETHANOL, DISODIUM EDTA, TETRASODIUM EDTA, AXIT HYALURONIC THỦY PHÂN, PHYTOSPHINGOSINE, XANTHAN GUM, ETHYLHEXYLGLYCERIN

HƯỚNG DẪN SỬ DỤNG:
Làm ướt da bằng nước ấm
Mát xa sữa rửa mặt vào da theo chuyển động tròn một cách nhẹ nhàng
Rửa sạch lại với nước', 360.000, '237ml', '4.jpg'),


('SER001', 'SER', N'Serum cấp nước, cấp ẩm, phục hồi da Hydrating Hyaluronic Acid Serum', 'Cerave', N'SERUM DƯỠNG ẨM HYDRATING HYALURONIC SERUM
Hyaluronic là một thành phần dưỡng ẩm mạnh mẽ được tìm thấy tự nhiên trong da của bạn. Tuy nhiên, khi bạn già đi, nó trở nên cạn kiệt, đó là lý do tại sao bạn cần bổ sung để ngăn ngừa khô da và lão hóa. CeraVe Hydrating Hyaluronic Acid Serum giúp liên kết độ ẩm trên bề mặt da của bạn, làm mềm mịn và cung cấp độ ẩm lên đến 24 giờ. Với Vitamin B5 và ba ceramide thiết yếu hoạt động cùng nhau để khóa độ ẩm cho da và giúp khôi phục hàng rào bảo vệ da của bạn. CeraVe Hydrating Hyaluronic Acid Serum cung cấp cho làn da của bạn độ ẩm cần thiết và giúp da chống lão hóa hiệu quả.
Công nghệ MVE đã được cấp bằng sáng chế của chúng tôi bao bọc ceramides để đảm bảo phân phối hiệu quả trong hàng rào bảo vệ da rất lâu sau khi bạn thoa xong. Ngay sau khi sử dụng, 90% người tiêu dùng được thử nghiệm cho biết làn da của họ cảm thấy được cấp nước mạnh mẽ, và 98% người tiêu dùng được thử nghiệm cho biết làn da của họ mịn màng hơn chỉ sau bốn tuần sử dụng.

THÀNH PHẦN:
AQUA / WATER, GLYCERIN, CETEARLYL ETHYLHEXANOATE, AMMONIUM POLYACRYLOYLDIMETHYL, PANTHENOL, CERAMIDE AP, CERAMIDE AP, CERAMIDE EOP, CAREBOMER, CETEARLIMONIUM, NATRI HYDROXIT, NATRI LAUROYL LACTYLATE, CHOLESTEROL, PHENOXYETHANOL, DISODIUM EDTA , ISOPROPYL MYRISTATE, CAPRYLYL GLYCOL, CITRIC ACID, XANTHAN GUM, PHYTOSPHINGOSINE, ETHYLHEXYLGLYCERIN

HƯỚNG DẪN SỬ DỤNG:
Thoa đều lên mặt và cổ ngày 2 lần sáng tối', 320.000, '5.jpg'),


('SRM003', 'SRM', N'Gel Rửa Mặt La Roche-Posay Dành Cho Da Dầu, Nhạy Cảm 400ml', 'La Roche-Posay', N'Gel Rửa Mặt La Roche-Posay Dành Cho Da Dầu
Là dòng sản phẩm sữa rửa mặt chuyên biệt dành cho làn da dầu, mụn, nhạy cảm đến từ thương hiệu dược mỹ phẩm La Roche-Posay nổi tiếng của Pháp, với kết cấu dạng gel tạo bọt nhẹ nhàng giúp loại bỏ bụi bẩn, tạp chất và bã nhờn dư thừa trên da hiệu quả, mang đến làn da sạch mịn, thoáng nhẹ và tươi mát. Công thức sản phẩm an toàn, lành tính, giảm thiểu tình trạng kích ứng đối với làn da nhạy cảm.
Thành phần
Aqua / Water, Sodium Laureth Sulfate, Peg-8, Coco-Betaine, Hexylene Glycol, Sodium Chloride, Peg-120 Methyl Glucose Dioleate, Zinc Pca, Sodium Hydroxide, Citric Acid, Sodium Benzoate, Phenoxyethanol, Caprylyl Glycol, Parfum / Fragrance
Hướng dẫn sử dụng
Làm ẩm da với nước ấm, cho một lượng vừa đủ sản phẩm ra tay, tạo bọt, thoa sản phẩm lên mặt, tránh vùng da quanh mắt.
Massage nhẹ nhàng, sau đó rửa sạch lại với nước và thấm khô da.
Sử dụng hằng ngày vào buổi sáng và tối.', 476.000, '400ml', '6.jpg'),


('SER002', 'SER', N'Serum La Roche-Posay Giúp Tái Tạo & Phục Hồi Da 30ml', 'La Roche-Posay', N'Hyalu B5 Serum là dòng serum chuyên biệt của thương hiệu La Roche-Posay, 
Với hoạt chất Hyaluronic Acid Duo giúp dưỡng ẩm chuyên sâu, cho da căng mịn; Vitamin B5 làm dịu & bảo vệ da; Madecassoside cải thiện làn da hư tổn nhanh chóng Kết cấu serum cực nhẹ, thẩm thấu nhanh vào da và không hề gây nhờn rít. Chỉ sau một thời gian sử dụng, da sẽ trở nên mịn màng, ẩm mượt và rạng rỡ hơn.
Thành phần
Aqua / Water, Glycerin, Alcohol Denat, Propylene Glycol, Panthenol, Pentylene Glycol, Dimethicone, Peg-6 Caprylic/Capric Glycerides, Ppg-6-Decyltetradeceth-30, Glyceryl Isostearate, Madecassoside, Sodium Hyaluronate, Ammonium Polyacryloyldimethyl Taurate, Disodium Edta, Hydrolyzed Hyaluronic Acid, Caprylyl Glycol, Citric Acid, Xanthan Gum, Butylene Glycol, Tocopherol, Phenoxyethanol, Parfum /Fragrance.
Hướng dẫn sử dụng
Sử dụng vào buổi sáng & tối sau bước làm sạch.
Vào ban ngày, nên sử dụng kèm kem chống nắng SPF 50+ & chống được tia UVA.
Tránh thoa vùng da quanh mắt.', 960.000, '30ml', '7.jpg'),


('NTT001', 'NTT', N'Nước Tẩy Trang La Roche-Posay Dành Cho Da Nhạy Cảm 400ml', 'La Roche-Posay', N'Nước Tẩy Trang La Roche-Posay Dành Cho Da Nhạy Cảm 400ml
Là dòng sản phẩm tẩy trang dành cho da mặt, vùng mắt và môi, ứng dụng công nghệ Glyco Micellar giúp làm sạch sâu lớp trang điểm và bụi bẩn, bã nhờn trên da vượt trội mà vẫn êm dịu, không gây căng rát hay kích ứng da; đồng thời cung cấp độ ẩm, mang đến làn da mềm mại & thoáng nhẹ sau khi sử dụng.
Thành phần
Aqua / Water, Peg-7 Caprylic/Capric Glycerides, Poloxamer 124, Poloxamer 184, Peg-6 Caprylic/Capric Glycerides, Glycerin, Polysorbate 80, Disodium Edta, Bht, Myrtrimonium Bromide, Parfum / Fragrance.
Hướng dẫn sử dụng
Cho nước tẩy trang La Roche-Posay Micellar Water Ultra Sensitive Skin ra bông cotton.
Đầu tiên tẩy trang cho môi, sau đó đến mắt rồi đến phần còn lại của khuôn mặt.
Để đạt hiệu quả cao hơn và hạn chế chà xát, hãy giữ miếng bông trên da trong vài giây trước khi lau đi.
Lặp lại cho đến khi thấy miếng bông đã sạch hoàn toàn, không còn cặn bẩn.
Không cần rửa lại với nước.
Được khuyên dùng để làm sạch và tẩy trang nhẹ nhàng, an toàn cho mọi loại da.', 396.000, '400ml', '8.jpg'),


('KCN002', 'KCN', N'Kem Chống Nắng La Roche-Posay Kiểm Soát Dầu SPF50+ 50ml', 'La Roche-Posay', N'Kem Chống Nắng La Roche-Posay Kiểm Soát Dầu SPF50+ 50ml
Là sản phẩm kem chống nắng dành cho làn da dầu mụn, sở hữu công nghệ cải tiến XL-Protect cùng kết cấu kem gel dịu nhẹ & không nhờn rít, giúp ngăn ngừa tia UVA/UVB + tia hồng ngoại + tác hại từ ô nhiễm, bảo vệ toàn diện cho làn da luôn khỏe mạnh.
Thành phần
Aqua / Water, Homosalate, Silica, Octocrylene, Ethylhexyl Salicylate, Butyl Methoxydibenzoylmethane, Ethylhexyl Triazone, Bis-Ethylhexyloxyphenol Methoxyphenyl Triazine, Drometrizole Trisiloxane, Aluminum Starch Octenylsuccinate, Glycerin, Pentylene Glycol, Styrene/Acrylates Copolymer, Potassium Cetyl Phosphate, Dimethicone, Perlite, Propylene Glycol, Acrylates/C10-30 Alkyl Acrylate Crosspolymer, Aluminum Hydroxide, P-Anisic Acid, Caprylyl Glycol, Disodium Edta, Inulin Lauryl Carbamate, Isopropyl Lauroyl Sarcosinate, Peg-8 Laurate, Phenoxyethanol, Scutellaria Baicalensis Extract / Scutellaria Baicalensis Root Extract, Silica Silylate, Stearic Acid, Stearyl Alcohol, Terephthalylidene Dicamphor Sulfonic Acid, Titanium Dioxide, Tocopherol, Triethanolamine, Xanthan Gum, Zinc Gluconate.
Hướng dẫn sử dụng
Thoa kem chống nắng vào bước cuối cùng trong quy trình chăm sóc da của bạn.
Thoa kem chống nắng ngay trước khi tiếp xúc với ánh nắng (thoa trước khoảng 20 phút).
Thoa lại thường xuyên và nhiều lần để duy trì lớp kem bảo vệ da; đặc biệt là sau khi bơi, đổ mồ hôi nhiều.
Lấy một lượng sản phẩm vừa đủ và chấm 5 điểm trên mặt (trán, mũi, cằm và hai bên má) sau đó thoa sản phẩm theo chiều từ trong ra ngoài và trên xuống dưới.
', 428.000, '50ml', '9.jpg'),


('KDD002', 'KDD', N'Kem Dưỡng La Roche-Posay Làm Dịu, Hỗ Trợ Phục Hồi Da 100ml', 'La Roche-Posay', N'Kem Dưỡng La Roche-Posay Làm Dịu, Hỗ Trợ Phục Hồi Da 100ml
Là sản phẩm kem dưỡng dành cho da nhạy cảm đến từ thương hiệu La Roche-Posay, giúp dưỡng ẩm và làm dịu tình trạng da kích ứng, tổn thương, hỗ trợ phục hồi làn da. Sản phẩm được khuyên dùng sau các liệu trình điều trị thẩm mỹ & kích ứng da nhẹ ở người lớn, trẻ em và trẻ sơ sinh.
Thành phần
Aqua/Water, Hydrogenated Polyisobutene, Dimethicone, Glycerin, Butyrospermum Parkii Butter/Shea Butter, Panthenol, Butylene Glycol, Aluminum Starch Octenylsuccinate, Propanediol, Cetyl Pef/PPG-10/1 Dimethicone, Tristearin, Zinc Gluconate, Madecassoside, Manganese Gluconate, Magnesium Sulfate, Disodium Edta, Copper Gluconate, Acetylated Glycol Stearate, Polyglyceryl-4 Isostearate, Sodium Benzonate, Phenoxyethanol, Chlorhexidine Digluconate, CI 77891 / Titanium Dioxide.
Hướng dẫn sử dụng
Đầu tiên, hạn chế sử dụng sản phẩm nếu bạn sở hữu làn da dầu.
Thoa một lượng vừa đủ, nhẹ nhàng mát-xa để kem thấm sâu. Tránh thoa lên vùng mắt.
Dùng 2-3 lần/ ngày trên vùng da cần được phục hồi, sau khi đã được làm sạch và làm dịu với Nước khoáng Thermal Spring Water.
Tuỳ vào tình trạng da, tần suất sử dụng sản phẩm sẽ tương ứng:
Da bị kích ứng và da khô: 2 lần một ngày
Da bị nứt nẻ: 3 lần một ngày.
Đối với các vấn đề da khác: 2 lần một ngày.', 508.000, '100ml', '10.jpg'),


('LOT001', 'LOT', N'Lotion La Roche-Posay Giàu Khoáng Cho Da Dầu 200ml', 'La Roche-Posay', N'Lotion La Roche-Posay Giàu Khoáng Cho Da Dầu 200ml
Là Toner thuộc dòng Effaclar của thương hiệu dược mỹ phẩm La Roche-Posay được phát triển chuyên dành cho làn da dầu mụn cần được chăm sóc một cách đặc biệt. Với thành phần giàu nước khoáng thiên nhiên, sản phẩm giúp làm dịu da, bảo vệ và chống oxy hóa; đồng thời làm sạch sâu, kiểm soát dầu thừa & hỗ trợ thu nhỏ lỗ chân lông với BHA & LHA, mang lại làn da thông thoáng.
Thành phần
Aqua/Water, Alcohol Denat, Glycerin, Sodium Citrate, Propylene Glycol, Peg-60 Hydrogenated Castor Oil, Disodium Edta, Capryloyl Salicylic Acid, Citric Acid, Parfum/Fragrance.
Hướng dẫn sử dụng
Sau khi làm sạch da bằng sữa rửa mặt, lấy một lượng vừa đủ ra bông tẩy trang và lau đều khắp mặt.
Dùng tay vỗ nhẹ để tinh chất thấm sâu vào da. Sử dụng mỗi ngày 2 lần sáng và tối', 348.000, '200ml', '11.jpg'),

('SRM004', 'SRM', N'Sữa rửa mặt sạch sâu chứa Mandelic acid và PHA 150ml', 'Sheaghana', N'MÔ TẢ SỮA RỬA MẶT SẠCH SÂU
Sữa rửa mặt Purifying Facial Cleanser Mandelic Acid làm sạch sâu nhưng vẫn thân thiện với lớp hàng rào bảo vệ da, loại bỏ hiệu quả bã nhờn, bụi bẩn, mỹ phẩm tồn dư trả lại làn da sạch tối ưu hóa chế độ dưỡng da phía sau. Gluconolactone (PHA) tẩy da chết nhẹ nhàng, duy trì độ ẩm mượt của một làn da khỏe mạnh. Mandelic acid được sử dụng trong sữa rửa mặt này với vai trò kháng khuẩn giúp chăm sóc cho những làn da gặp vấn đề về mụn sưng viêm, mụn do vi nấm, demodex, mụn trứng cá đỏ.

THÀNH PHẦN SỮA RỬA MẶT SẠCH SÂU
Aqua, Disodium Cocoamphodiacetate, Cocamidopropyl Betaine, Decyl Glucoside, Propanediol, Sodium Cocoyl Apple Amino Acids, Aloe Barbadensis Leaf Water, Disodium Laureth Sulfosuccinate , Polysorbate 20, Glycerin, Gluconolactone, Mandelic Acid, Cetyl Alcohol, PEG-150 Distearate, Citric Acid, Phenethyl Alcohol , Caprylhydroxamic Acid, Boswellia Carterii Oil, Enzymes , Maltodextrin, Nelumbo Nucifera Flower Extract, Sodium Phytate.

HƯỚNG DẪN SỬ DỤNG
Làm ướt mặt, lấy lượng sữa rửa mặt vừa phải, tạo bọt mịn và massage trên da trong vòng 1 phút. Rửa sạch với nước, chú ý các đường viền chân tóc và vùng dưới cằm.', 370.000, '150ml', '12.jpg'),

('SRM005', 'SRM', N'Gel rửa mặt dịu nhẹ chiết xuất rau má – Centella Deep Moisturizing Facial Cleanser', 'Sheaghana', N'MÔ TẢ GEL RỬA MẶT
Centella Deeep Moisturizing Facial Cleanser là một sản phẩm rửa mặt cao cấp với kết cấu dạng gel. Sản phẩm vận dụng hệ chất hoạt động bề động bề mặt thiện nhiên dịu dang với làn da nhưng có khả năng tạo bọt tốt, chất bọt mềm, xốp mịn làm sạch da hiệu quả. Chiết xuất rau má được ghi nhận về khả năng làm dịu tổn thương và giảm biểu hiện của mụn viêm, giúp những làn da đang bị kích động bởi các tác nhân gây tổn thương cả thấy dễ chịu hơn. Sự góp mặt của các loại tinh dầu thiên nhiên là liệu pháp an toàn giúp kháng viêm, ngăn ngừa mụn.

THÀNH PHẦN GEL RỬA MẶT
Aqua/Water, Disodium Cocoamphodiacetate, Sodium Methyl Cocoyl Taurate, Decyl Glucoside, Disodium Laureth Sulfosuccinate, Lauryl Glucoside, Disodium Cocoyl Glutamate, Propanediol, Polysorbate 20, PEG-150 Distearate, Calophyllum Inophyllum Seed Oil, Psidium Guajava Fruit Extract, Camellia Sinensis Leaf Extract, Rosa Centifolia Flower Extract, Nelumbo Nucifera Leaf Extract, Enzymes, Maltodextrin, Melaleuca Alternifolia (Tea Tree) oil, Centella Asiatica Extract, Betain Salicylate, Pelargonium Graveolens Flower Oil, Cymbopogon Martini Oil, Citric acid, Sodium Gluconate, Phenoxyethanol, Ethylhexylglycerin.

HƯỚNG DẪN SỬ DỤNG
Làm ướt mặt, lấy lượng sữa rửa mặt vừa phải, tạo bọt mịn và massage trên da trong vòng 1 phút. Rửa sạch với nước, chú ý các đường viền chân tóc và vùng dưới cằm.', 450.000, '150ml', '13.jpg'),


('KDD003', 'KDD', N'Kem Retinol 0.5% chống lão hóa - Retinol Cream 0.5%', 'Sheaghana', N'MÔ TẢ RETINOL CREAM 0.5%
Kem dưỡng chứa 0,5% retinol nguyên chất tái tạo những làn da mỏng yếu trở nên dày khỏe, căng mịn hơn. Chất kem xốp mềm giàu dưỡng chất với Bio Placenta – hoạt chất nhau thai sinh học mang theo những nhân tố tăng trưởng nuôi dưỡng các tế bào da mới tái sinh khỏe mạnh, tầng collagen săn chắc, vùng thượng bì dày dặn hơn rõ rệt.

THÀNH PHẦN RETINOL CREAM 0.5%
Aqua, Polysorbate 20, Simmondsia Chinensis Seed Oil, Propanediol, Cetearyl Alcohol, Rubus Idaeus Seed Oil Hydroxyethyl Acrylate/Sodium Acryloyldimethyl Taurate Copolymer, Hydrogenated Polydecene, Polysorbate 80, Retinol, Lecithin, Glyceryl Stearate, Ceteareth-20, Ceteareth-12, Cetyl Palmitate, Phenoxyethanol, Acetyl Glucosamine, Polyacrylate Crosspolymer-6, Phenethyl Alcohol, Glycerin, Caprylhydroxamic Acid, Hydrolyzed Hyaluronic Acid, Acetyl Glutamine, Sh-Oligopeptide-1, Sh-Oligopeptide-2, Sh-Polypeptide-1, Sh-Polypeptide-9, Sh-Polypeptide-11, Bacillus/Soybean Ferment Extract, Sodium Hyaluronate, Sodium Phytate, Ethylhexylglycerin, BHT, BHA, Caprylyl Glycol, Butylene Glycol, 1,2-Hexanediol.

HƯỚNG DẪN SỬ DỤNG
BÔI ĐỆM: Nếu da của bạn mỏng yếu, nhạy cảm hoặc chưa dùng các loại treatment bao giờ, sau khi tẩy trang rửa mặt, dùng một hoặc một vài bước dưỡng da cơ bản, đợi các lớp này thẩm thấu hoàn toàn vào da rồi bôi đến retinol cream.
BÔI TRẦN: Nếu da của bạn khỏe, sau khi tẩy trang rửa mặt, lau nước cân bằng da rồi đợi da khô ráo và bôi kem retinol với lượng thích hợp với nhau cầu da của bạn. Vỗ nhẹ cho tới khi kem thẩm thấu hết.', 720.000, '30ml', '14.jpg'),


('KDD004', 'KDD', N'Tinh chất mờ thâm nám làm đều màu da – Spot Out Beauty Concentrate', 'Sheaghana', N'MÔ TẢ SẢN PHẨM SPOT OUT
SPOT OUT BEAUTY CONCENTRATE – TINH CHẤT MỜ THÂM NÁM chứa các hoạt chất có phân tử cực nhỏ, thẩm thấu sâu và giải quyết triệt để vấn đề nám, chống tái nám trở lại: Phức hợp 5 loại dầu chứng nhận Organic, Mật ông lên men, hoạt chất cao cấp Diglucosyl Gallic Acid (THBG).Nên dùng trong liệu trình tối thiếu 80 ngày và hoàn toàn có thể sử dụng lâu dài mà không lo ngại bất cứ tác dụng phụ nào.

THÀNH PHẦN SẢN PHẨM SPOT OUT
Aqua, Propanediol, Ribes Nigrum Seed Oil, Octyldodecanol, Nigella Sativa Seed Oil, Rosa Canina Seed Extract, Momordica Cochinchinensis Seed Aril Oil, Diglucosyl Gallic Acid, Gluconobacter/Honey Ferment Filtrate, Octyldodecyl Oleate, Octyldodecyl Stearoyl Stearate, Psidium Guajava Fruit Extract, Camellia Sinensis Leaf Extract, Rose Extract, Nelumbo Nucifera Leaf Extract, Opuntia Ficus-Indica Seed Oil, Paeonia Suffruticosa Root Extract, Acetyl Glucosamine, Sodium Acrylates Copolymer, Lecithin, Glycerin, Rosmarinus Officinalis Leaf Oil, Melia Azadirachta Seed Oil, Daucus carota Sativa Seed Oil, Phenethyl Alcohol, Caprylhydroxamic Acid, Acacia Senegal Gum, Xanthan Gum, Tocopheryl Acetate, Rosmarinus Officinalis Leaf Extract, Solidago Virgaurea Extract, Sodium Phytate.

HƯỚNG DẪN SỬ DỤNG
Thoa lên da sau bước serum vào buổi tối hằng ngày. Vỗ nhẹ để tinh chất thẩm thấu hoàn toàn rồi mới dùng tới các sản phẩm tiếp theo.', 530.000, '30ml', '15.jpg'),


('KDD005', 'KDD', N'Intensive Care 72h Face Cream – Kem dưỡng ẩm chuyên sâu 72h', 'Sheaghana', N'MÔ TẢ SẢN PHẨM KEM DƯỠNG ẨM
Kem dưỡng ẩm chuyên sâu 72h – INTENSIVE CARE 72H FACE CREAM là giải pháp đột phá mà SheaGhana muốn mang đến cho bạn để tìm lại làn da mượt mà như da em bé. Bởi vì trong một hũ kem dưỡng này là tập hợp của những “siêu thành phần” phải kể đến Pentavitin – ngay khi ra đời đã được giới điều chế mỹ phẩm đặt cho tên gọi “hoạt chất dưỡng ẩm thần kỳ” vì nó có khả năng tạo ngậm nước cho da ngay khi sử dụng và kéo dài hiệu quả đến 72h. Hoạt chất này có thể làm được điều đó là nhờ cấu tạo hoá học tương tự với các acid amin của yếu tố giữ ẩm tự nhiên NMF của da.

THÀNH PHẦN SẢN PHẨM KEM DƯỠNG ẨM
Aqua/Water, Snail Secretion Filtrate, Rubus Idaeus (Raspberry) Seed Oil, Cetearyl Alcohol, Pyrus Malus (Apple) Seed Oil, Propanediol, Hydroxy Ethyl Acrylate/ Sodium Acryloyldimethyltaurate Copolymer, Saccharide Isomerate, Pyrus Malus (Apple) Juice, Prunus Persica (Peach) Juice, Triticum Vulgare (Wheat) Seed Extract, Hordeum Vulgare Seed Extract, Panax Ginseng Root Extract, Cichorium Intybus (Chicory) Root Oligosaccharides, Glycerin, Caesalpinia Spinosa Gum, Sodium Hyaluronate, Ethoxydiglycol, Allantoin, Tocopheryl Acetate, Hyaluronic Acid / Hydrolyzed Hyaluronic Acid, Hydrogenated Polydecene, Polysorbate 80, Fragrance, Citric Acid, Calcium Gluconate, Diazolidinyl Urea, Iodopropynyl Butylcarbamate, Polyquaternium-10, Sodium Citrate, Glyceryl Caprylate, Glyceryl Undecylenate, Sodium Benzoate, Gluconolactone.

HƯỚNG DẪN SỬ DỤNG
Sau khi vệ sinh da mặt và sử dụng các bước serum chuyên dụng, lấy một lượng sản phẩm vừa đủ, bôi nhẹ nhàng đều khắp da mặt, vỗ nhẹ cho kem nhanh thấm vào da.', 350.000, '30ml', '16.jpg'),


('SRM007', 'SRM', N'Sữa rửa mặt dịu nhẹ Defense Hydrating Gel-To-Cream Cleaser', 'Paula''s Choice', N'Sản phẩm Defense Hydrating Gel-To-Cream Cleanser có khả năng loại bỏ bụi bẩn, dầu thừa và cặn makeup một cách tối ưu đồng thời giúp tăng cường bảo vệ da trước những yếu tố có ảnh hưởng xấu từ môi trường.

THÀNH PHẦN SẢN PHẨM:
Water, Sodium Cocoyl Glycinate (cleansing agent), Cocamidopropyl Hydroxysultaine (cleansing agent), Sodium Lauroamphoacetate (cleansing agent), Cocamidopropyl Betaine (cleansing/lather agent), Glycerin (skin-replenishing), Sorbeth-230 Tetraoleate (texture enhancer/emulsifier), Decyl Glucoside (cleansing agent), Pentylene Glycol (hydration), Sodium Chloride (stabilizer/texture enhancer), Disodium Cocoyl Glutamate (cleansing agent), Lauric Acid (cleansing agent), Lactic Acid (hydration), Sodium Lauroyl Oat Amino Acids (skin-soothing), Sorbitan Laurate (cleansing agent/emulsifier), Sodium Cocoyl Glutamate (cleansing agent), Disodium EDTA (chelating agent), Aloe Barbadensis Leaf Juice (hydration), Caprylic/Capric Triglyceride (skin-replenishing), Cocoyl Proline (hydration), Sodium Citrate (pH adjuster), Camellia Sinensis Leaf Extract (antioxidant), Glycyrrhiza Glabra (Licorice) Root Extract (skin-soothing), Sodium PCA (skin-replenishing), Sodium Lactate (hydration), Arginine (amino acid/hydration), Glycine Soja (Soybean) Sterols (antioxidant/hydration), Linoleic Acid (skin-restoring), Phospholipids (skin-restoring), Aspartic Acid, PCA, Glycine, Alanine, Serine, Valine, Isoleucine, Proline, Threonine (amino acids/hydration), Potassium Citrate (chelating agent), Lactoperoxidase (hydration), Histidine, Phenylalanine (amino acids/hydration), Glucose Oxidase (hydration), Citric Acid (pH adjuster), Phenoxyethanol, Ethylhexylglycerin, Potassium Sorbate, Sodium Benzoate (preservatives).

KHẮC PHỤC VẤN ĐỀ:
Da lão hóa sớm
Da chịu tổn thương bởi môi trường
Da nhạy cảm, kích ứng', 629.000, '198ml', '17.jpg'),


('KCN003', 'KCN', N'Kem chống nắng dạng sữa cho da mụn Clear Ultra-Light Daily Hydrating Fluid SPF 30 60ML', 'Paula''s Choice', N'Kem dưỡng chống nắng với kết cấu dạng lỏng không gây bóng nhờn có khả năng giảm thiểu sự xuất hiện của lỗ chân lông và giúp bảo vệ da khỏi tác hại của ánh nắng mặt trời để duy trì vẻ ngoài đẹp, khỏe mạnh và cho phép làn da thực sự cải thiện.
Giảm thiểu tình trạng lỗ chân lông to
Chống nắng phổ rộng tuyệt vời để đẩy lùi các dấu hiệu lão hóa
Khi thoa lên da tạo cảm giác mềm mại, nhẹ nhàng trên da và không làm tắc nghẽn lỗ chân lông
Công thức dưỡng ẩm nhẹ làm giảm khô và bong tróc da
Sử dụng như bước cuối cùng trong quy trình chăm sóc da buổi sáng của bạn.

THÀNH PHẨM SẢN PHẨM:
Water⁠, Octinoxate⁠, Glycerin⁠, Octisalate⁠, Silica⁠, Octocrylene⁠, Avobenzone⁠, Dimethicone⁠, Tocopherol⁠, Chamomilla Recutita (Matricaria) Flower Extract ⁠, Vitis Vinifera (Grape) Seed Extract⁠, Camellia Sinensis Leaf Extract⁠, Camellia Oleifera (Green Tea) Leaf Extract⁠, Peucedanum Graveolens (Dill) Extract⁠, Sambucus Nigra Fruit Extract⁠, Oat Bran Extract⁠, Punica Granatum Fruit Extract⁠, Lycium Barbarum Fruit Extract⁠, Hydrogenated Lecithin⁠, Titanium Dioxide⁠, Dimethicone/Vinyl Dimethicone Crosspolymer⁠, Diethylhexyl Syringylidenemalonate⁠, Hydroxyethyl Acrylate/Sodium Acryloyldimethyl Taurate Copolymer⁠, Xanthan Gum⁠, Sodium Carbomer⁠, Benzyl Alcohol⁠, Sodium Benzoate⁠, Potassium Sorbate⁠, Phenoxyethanol.', 849.000, '60ml', '18.jpg'),


('KCN004', 'KCN', N'Kem chống nắng chống lão hóa Resist Skin Restoring Moisturizer Broad Spectrum SPF 50 15ml', 'Paula''s Choice', N'Kem dưỡng chống nắng chống lão hoá Resist Skin Restoring Moisturizer Broad Spectrum SPF 50 bảo vệ da khỏi tác hại của tia cực tím đồng thời cung cấp lượng ẩm dồi dào và khả năng bảo vệ da mạnh mẽ với các thành phần tuyệt vời như Niacinamide, bơ hạt mỡ và cam thảo cho làn da trẻ trung và mịn màng không tì vết.
Giảm thiểu sự xuất hiện của các dấu hiệu lão hoá
Tăng cường chống oxy hoá
Duy trì độ ẩm mịn trên da trong suốt thời gian dài.

THÀNH PHẦN SẢN PHẨM:
Active Ingredients: Avobenzone 3%; Homosalate 5%; Octinoxate 7.50%; Octisalate 5%; Oxybenzone 5% (sunscreen actives). Inactive Ingredients: Water (Aqua), Silica (opacifier and texture enhancer), Glycerin (hydration), Cetearyl Alcohol (texture enhancer), Dimethicone (hydration), Butylene Glycol, Pentylene Glycol (hydration), Potassium Cetyl Phosphate (emulsifier), Cyclopentasiloxane (hydration), Pyrus Malus (Apple) Fruit Extract (skin-restoring), VP/Eicosene Copolymer (texture enhancer), Butyrospermum Parkii (Shea) Butter (emollient), 
Allantoin (skin soothing), Niacinamide (skin-restoring), Tocopherol (vitamin E/antioxidant), Glycyrrhiza Glabra (Licorice) Root Extract (skin soothing), Aloe Barbadensis Leaf Juice (hydration, soothing), Atractylodes Macrocephala Root Powder (antioxidant), Avena Sativa (Oat) Kernel Extract (skin soothing), Coffea Arabica (Coffee) Seed Extract, Portulaca Oleracea Extract, Mahonia Aquifolium Root Extract, Diethylhexyl Syringylidenemalonate (antioxidants), Sarcosine, Capryloyl Glycine, Maltooligosyl Glucoside, Cetearyl Glucoside (skin softeners), Dimethiconol (texture enhancer), Acrylates/C10-30 Alkyl Acrylate Crosspolymer (stabilizer), Hydrogenated Starch Hydrolysate (hydration), Hexylene Glycol (texture enhancer), 4-T-Butylcyclohexanol (emollient), Glyceryl Stearate, PEG-100 Stearate (texture enhancers), Sodium Hydroxide (pH adjuster), Xanthan Gum (stabilizer), Disodium EDTA (chelating agent), Phenoxyethanol, Caprylyl Glycol (preservatives), Ethylhexylglycerin (skin softening).', 339.000, '15ml', '19.jpg');



INSERT INTO users (user_id, password, email, first_name, last_name, address, phone, role)
VALUES
(1, 'E10ADC3949BA59ABBE56E057F20F883E', 'khoa123@gmail.com', 'Nguyen', 'Khoa', N'123 Nguyễn Văn Linh, TP Hồ Chí Minh', '0123456789', 'admin'),
(2, 'E10ADC3949BA59ABBE56E057F20F883E', 'dat456@gmail.com', 'Tran', 'Dat', N'123 Nguyễn Văn Linh, TP Hồ Chí Minh', '0373456798', 'user');

INSERT INTO cart_items (cart_item_id, user_id, product_id, quantity)
VALUES
(1, 1, 'SRM001', 2),
(2, 1, 'KDD001', 1),
(3, 2, 'KCN001', 1),
(4, 2, 'LOT001', 1);

INSERT INTO orders (order_id, user_id, order_date, total_amount, status, shipping_address)
VALUES
(1, 1, '2023-01-15 10:30:00', 944.000, 'Shipped', N'123 Nguyễn Văn Linh, TP Hồ Chí Minh'),
(2, 2, '2023-03-20 15:48:00', 360.000, 'Shipped', N'123 Nguyễn Văn Linh, TP Hồ Chí Minh');

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price)
VALUES
(1, 1, 'SRM001', 2, 470.000),
(2, 1, 'SRM002', 1, 360.000),
(3, 2, 'SER002', 1, 960.000),
(4, 2, 'NTT001', 1, 396.000);



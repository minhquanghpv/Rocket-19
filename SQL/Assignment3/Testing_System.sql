/* Lenh xoa Database */
DROP DATABASE IF EXISTS `Testing_System_1`;
/* Lenh tao Database */
CREATE DATABASE IF NOT EXISTS `Testing_System_1`;
/* Lenh su dung Database */
USE `Testing_System_1`;


/*------------------- Create table ----------------------- */

/* Lenh xoa bang */
DROP TABLE IF EXISTS `Department`;
/* Len tao bang va cac cot du lieu cua bang--*/
CREATE TABLE `Department`
(   
    `DepartmentID`   TINYINT PRIMARY KEY AUTO_INCREMENT,
    `DepartmentName` VARCHAR(50)
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE IF NOT EXISTS `Position` (
    `PositionID` TINYINT UNSIGNED AUTO_INCREMENT,
    `PositionName` ENUM('Dev1', 'Dev2', 'Test', 'Scrum Master', 'PM'),
    CONSTRAINT pk_p PRIMARY KEY (`PositionID`)
);

## ALTER TABLE `position` CHANGE COLUMN `PositionName` `PositionName` VARCHAR(50);
## ALTER TABLE `position` MODIFY `PositionName` VARCHAR(50);

/* ALTER TABLE `position` DROP COLUMN `PositionName`,
	ADD COLUMN `PositionName` VARCHAR(50); */

DROP TABLE IF EXISTS `Account`;
CREATE TABLE IF NOT EXISTS `Account`
(
    `AccountID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Email`        VARCHAR(100) UNIQUE,
    `Username`     VARCHAR(50) NOT NULL,
    `Fullname`     VARCHAR(50),
    `DepartmentID` TINYINT UNSIGNED DEFAULT 0,
    `PositionID`  TINYINT UNSIGNED,
    `CreateDate`   DATETIME 
    -- CONSTRAINT fk_dp_id FOREIGN KEY (`DepartmentID`) REFERENCES `Department` (`DepartmentID`) ON DELETE SET NULL ON UPDATE CASCADE,
    -- CONSTRAINT fk_ps_id FOREIGN KEY (`PositionID`) REFERENCES `Position` (`PositionID`) ON DELETE SET NULL ON UPDATE CASCADE
);

DROP TABLE IF EXISTS `Group`;
CREATE TABLE IF NOT EXISTS `Group`
(
    `GroupID`    MEDIUMINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `GroupName`  VARCHAR(50) NOT NULL,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME
);

DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE IF NOT EXISTS `GroupAccount`
(
    `GroupID`   MEDIUMINT,
    `AccountID` MEDIUMINT,
    `JoinDate`  DATETIME DEFAULT NOW()
);

DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE IF NOT EXISTS `TypeQuestion`
(
    `TypeID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `TypeName` VARCHAR(50)
);

DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE IF NOT EXISTS `CategoryQuestion`
(
    `CategoryID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')
);

DROP TABLE IF EXISTS `Question`;
CREATE TABLE IF NOT EXISTS `Question`
(
    `QuestionID` TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `CategoryID` TINYINT UNSIGNED,
    `TypeID`     TINYINT UNSIGNED,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME 
    -- CONSTRAINT fk_q1 FOREIGN KEY (`CreatorID`) REFERENCES `Account` (`AccountID`) ON UPDATE CASCADE ON DELETE SET NULL,
    -- CONSTRAINT fk_q2 FOREIGN KEY (`CategoryID`) REFERENCES `CategoryQuestion` (`CategoryID`) ON UPDATE CASCADE ON DELETE SET NULL,
    -- CONSTRAINT fk_q3 FOREIGN KEY (`TypeID`) REFERENCES `TypeQuestion` (`TypeID`) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `Answer`;
CREATE TABLE IF NOT EXISTS `Answer`
(
    `AnswerID`   TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Content`    VARCHAR(50),
    `QuestionID` TINYINT UNSIGNED,
    `isCorrect`  BIT
	-- CONSTRAINT fk_qid FOREIGN KEY (`QuestionID`) REFERENCES `Question` (`QuestionID`) ON UPDATE CASCADE ON DELETE SET NULL
);

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE IF NOT EXISTS `Exam`
(
    `ExamID`     TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    `Code`       VARCHAR(20) NOT NULL,
    `Title`      VARCHAR(50) NOT NULL,
    `CategoryID` TINYINT UNSIGNED,
    `Duration`   TINYINT,
    `CreatorID`  MEDIUMINT UNSIGNED,
    `CreateDate` DATETIME 
	-- CONSTRAINT fk_ex_1 FOREIGN KEY (CreatorID) REFERENCES Account (AccountID) ON UPDATE CASCADE ON DELETE NO ACTION,
    -- CONSTRAINT fk_ex_2 FOREIGN KEY (CategoryID) REFERENCES CategoryQuestion (CategoryID) ON UPDATE CASCADE ON DELETE SET NULL
);


DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE IF NOT EXISTS `ExamQuestion`
(
    `ExamID`     TINYINT UNSIGNED,
    `QuestionID` TINYINT UNSIGNED
   --  CONSTRAINT fk_eq1 FOREIGN KEY (ExamID) REFERENCES Exam (ExamID),
   --  CONSTRAINT fk_eq2 FOREIGN KEY (QuestionID) REFERENCES Question (QuestionID)
);


/* ---------------------- INSERT DATA ---------------------------- */
/* INSERT DATA bang Department */
INSERT INTO `Department`(`DepartmentName`)
VALUES ('Phong Ky Thuat 1'),
       ('Phong Ky Thuat 2'),
       ('Phong Dev 1'),
       ('Phong Dev 2'),
       ('Phong Sale'),
       ('Phong Marketing'),
       ('Phong Giam Doc'),
       ('Phong Tai Chinh');

/* Lenh sua bang `Position` sua kieu du lieu cot `PositionName` */
ALTER TABLE `Position`
    MODIFY COLUMN `PositionName` ENUM ('Dev1', 'Dev2', 'PM', 'Leader', 'Scrum Master' , 'Test');
/* INSERT DATA bang Position */
INSERT INTO `Position`(`PositionName`)
VALUES ('Dev1'),
       ('Dev2'),
       ('Test'),
       ('PM'),
       ('Leader'),
       ('Scrum Master');

/* lenh sua bang xoa khoa ngoai foreign key*/
-- ALTER TABLE `Account`
--     DROP CONSTRAINT `fk_dp_id`,
--     DROP CONSTRAINT `fk_ps_id`;
/* INSERT DATA bang Account */
INSERT INTO `Account`(`Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`)
VALUES ('vti_account1@vtiacademy.com', 'vti1', 'Nguyen Van Tinh', 1, 1, '2019-12-01'),
       ('vti_account2@vtiacademy.com', 'vti2', 'Trinh Hoai Linh', 1, 2, '2020-12-01'),
       ('vti_account3@vtiacademy.com', 'vti3', 'Nguyen Van Test', 1, 1, '2020-07-01'),
       ('vti_account4@vtiacademy.com', 'vti4', 'Tran Van Tinh', 1, 2, '2019-09-01'),
       ('vti_account5@vtiacademy.com', 'account5', 'Ho Van Tinh', 3, 2, '2021-07-01'),
       ('vti_account6@vtiacademy.com', 'account_vti6', 'Cao Thai Son', 3, 1, NOW()),
       ('vti_7@vtiacademy.com', 'account_vti7', 'Tam Thất Tùng', 3, 3, '2020-10-01'),
       ('vti_8@vtiacademy.com', 'account_vti8', 'Nguyen Quynh Thu', 3, 4, '2019-04-01'),
       ('vti_9@vtiacademy.com', 'account_vti9', 'Tran Kim Tuyen', 2, 1, NOW()),
       ('vti_account10@vtiacademy.com', 'account_vti10', 'Nguyen Ba Dao', 1, 5, '2019-10-01'),
       ('vti_account11@vtiacademy.com', 'account_vti11', 'Nguyen Van Binh', 1, 3, '2020-12-01');

/* INSERT DATA bang Group */
INSERT INTO `Group`(`GroupName`, `CreatorID`, CreateDate)
VALUES ('Nhom 1', '3', '2021-04-03'),
       ('Nhom 2', '3', '2019-01-03'),
       ('Nhom 3', '2', '2020-04-03'),
       ('Nhom 4', '1', NOW()),
       ('Nhom 5', '3', '2021-06-03'),
       ('Nhom 6', '1', '2020-04-03'),
       ('Nhom 7', '5', '2021-04-03'),
       ('Nhom 8', '5', '2019-05-03'),
       ('Nhom 9', '3', '2019-01-03'),
       ('Nhom 10', '1', NOW());

/* INSERT DATA bang GroupAccount */
INSERT INTO `GroupAccount`(`GroupID`, `AccountID`, `JoinDate`)
VALUES ('1', '1', '2021-06-01'),
       ('1', '3', '2020-01-01'),
       ('1', '2', NOW()),
       ('1', '4', '2021-06-01'),
       ('2', '1', '2021-06-01'),
       ('2', '10', '2019-05-01'),
       ('5', '1', '2021-06-01'),
       ('5', '3', '2020-01-01'),
       ('5', '4', '2021-07-01'),
       ('3', '1', '2021-06-01'),
       ('9', '2', '2021-06-01'),
       ('10', '1', NOW());

/* INSERT DATA bang TypeQuestion */
INSERT INTO `TypeQuestion`(`TypeName`)
VALUES ('Trac nghiem'),
       ('Tu Luan');

/* INSERT DATA bang CategoryQuestion */
/*`CategoryName` ENUM ('Java', 'SQL', '.NET', 'Ruby', 'Python', 'NodeJS' , 'HTML', 'CSS', 'JavaScript')*/
INSERT INTO `CategoryQuestion` (`CategoryName`)
VALUES ('Java'),
       ('SQL'),
       ('HTML'),
       ('CSS '),
       ('.NET'),
       ('Python'),
       ('Ruby'),
       ('JavaScript');

/* Lenh sua bang `Question` Xoa rang buoc khoa ngoai Foreign Key */
-- ALTER TABLE `Question`
--     DROP CONSTRAINT `fk_q1`,
--     DROP CONSTRAINT `fk_q2`,
--     DROP CONSTRAINT `fk_q3`;
/* INSERT DATA bang Question */
INSERT INTO `Question`(`Content`, CategoryID, TypeID, CreatorID, CreateDate)
VALUES ('Câu hỏi SQL 1', 2, 2, 1, '2021-04-01'),
       ('Câu hỏi SQL 2', 2, 2, 2, '2020-01-01'),
       ('Câu hỏi JAVA 1', 1, 1, 10, '2021-07-01'),
       ('Câu hỏi JAVA 2', 1, 2, 5, '2021-06-01'),
       ('Câu hỏi HTML 1', 3, 1, 2, NOW()),
       ('Câu hỏi HTML 2', 3, 2, 2, NOW());

/* lenh sua bang xoa khoa ngoai foreign key*/
-- ALTER TABLE `Answer`
--     DROP CONSTRAINT `fk_qid`;
/* INSERT DATA bang Answer */
INSERT INTO `Answer` (`Content`, `QuestionID`, `isCorrect`)
VALUES ('Câu trả lời 1 - question SQL 1', 1, 1),
       ('Câu trả lời 2 - question SQL 1', 1, 0),
       ('Câu trả lời 3 - question SQL 1', 1, 0),
       ('Câu trả lời 4 - question SQL 1', 1, 1),
       ('Câu trả lời 1 - question SQL 2', 2, 0),
       ('Câu trả lời 2 - question SQL 2', 2, 0),
       ('Câu trả lời 3 - question SQL 2', 2, 0),
       ('Câu trả lời 4 - question SQL 2', 2, 1),
       ('Câu trả lời 1 - question JAVA 1', 3, 0),
       ('Câu trả lời 2 - question JAVA 1', 3, 1),
       ('Câu trả lời 1 - question JAVA 2', 4, 0),
       ('Câu trả lời 2 - question JAVA 2', 4, 0),
       ('Câu trả lời 3 - question JAVA 2', 4, 0),
       ('Câu trả lời 4 - question JAVA 2', 4, 1),
       ('Câu trả lời 1 - question HTML 1', 5, 1),
       ('Câu trả lời 2 - question HTML 2', 5, 0);

/* lenh sua bang xoa khoa ngoai foreign key*/
-- ALTER TABLE `Exam`
--     DROP CONSTRAINT `fk_ex_1`;
-- ALTER TABLE `Exam`
--     DROP CONSTRAINT `fk_ex_2`;
/* INSERT DATA bang Exam */
INSERT INTO `Exam`(`Code`, `Title`, `CategoryID`, `Duration`, `CreatorID`, `CreateDate`)
VALUES ('MS_01', 'De thi 01', 1, 90, 1, NOW()),
       ('MS_02', 'De thi 02', 1, 60, 5, NOW()),
       ('MS_03', 'De thi 03', 2, 60, 9, NOW()),
       ('MS_04', 'De thi 04', 2, 90, 1, NOW()),
       ('MS_05', 'De thi 05', 1, 60, 2, NOW()),
       ('MS_06', 'De thi 06', 2, 90, 2, NOW()),
       ('MS_07', 'De thi 07', 1, 60, 1, NOW());

/* lenh sua bang xoa khoa ngoai foreign key*/
-- ALTER TABLE `ExamQuestion`
--     DROP CONSTRAINT `fk_eq1`,
--     DROP CONSTRAINT `fk_eq2`;
/* INSERT DATA bang Examquestion */
INSERT INTO `ExamQuestion`
VALUES (1, 1),
       (2, 1),
       (3, 1),
       (4, 1),
       (5, 2),
       (6, 2),
       (7, 2),
       (8, 2),
       (9, 3),
       (10, 3),
       (11, 4),
       (12, 4),
       (13, 4),
       (14, 4),
       (15, 5),
       (16, 5);
/*
Question 1: Thêm ít nhất 10 record vào mỗi table
Question 2: lấy ra tất cả các phòng ban
Question 3: lấy ra id của phòng ban "Sale"
Question 4: lấy ra thông tin account có full name dài nhất
Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id
= 3
Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
Question 7: Lấy ra ID của question có >= 4 câu trả lời
Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày
20/12/2019
Question 9: Lấy ra 5 group được tạo gần đây nhất
Question 10: Đếm số nhân viên thuộc department có id = 2
Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
Question 12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi"
Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và
email thành loc.nguyenba@vti.com.vn
Question 15: update account có id = 5 sẽ thuộc group có id = 4
*/
/*Question 1*/
Insert into `Department`(`DepartmentName`)
Values  ('Vu'),
		('Quang'),
        ('Minh'),
        ('Ronaldo'),
        ('Messi'),
        ('Neymar'),
        ('Pogba'),
        ('Malphite'),
        ('Lord'),
        ('King');

/*Dev1', 'Dev2', 'Test', 'Scrum Master', 'PM'*/
Insert into `Position`(`PositionName`)
Values  ('Dev1'),
		('PM'),
        ('Scrum Master'),
        ('Test'),
        ('Dev2'),
        ('Dev1'),
        ('PM'),
        ('Scrum Master'),
        ('Dev1'),
        ('Test');
        
Select * from `Position`;		

Insert into `Account`(`Email`, `Username`, `Fullname`, `DepartmentID`, `PositionID`, `CreateDate`)
Values  ('minhkwang123@gmail.com', 'Quang', 'Vu Minh Quang', '2', '2', Now()),
		('minhkwang12@gmail.com', 'Quan', 'Vu Minh Quan', '1', '2', '2021-12-1'),
        ('minhkwang1@gmail.com', 'Huan', 'Vu Minh Quynh', '3', '2', '2020-10-3'),
        ('minhkwan123@gmail.com', 'Hi', 'Vu Van Quang', '2', '2', '2022-12-13'),
        ('minhkwang@gmail.com', 'Pii', 'Vu Duc Quang', '1', '2', '2002-09-29'),
        ('helloworld@gmail.com', 'Hieu', 'Pham Xuan Hieu', '1', '1', Now()),
        ('mynameisquang@gmail.com', 'Kien', 'Dinh Huy Kien', '2', '2', 2001-09-07),
        ('mydickisbig@gmail.com', 'Huy', 'Ngo Kien Huy', '1', '2', Now()),
        ('ronaldo@gmail.com', 'Ronaldo', 'Cristiano Ronaldo', '2','2', '1999-09-09'),
        ('messi@gmail.com', 'Messi', 'Lionel Messi', '2', '1', Now());
        
INSERT INTO `Group`(`GroupName`, `CreatorID`, CreateDate)
VALUES ('Nhom 3', '1', '2028-04-03'),
       ('Nhom 2', '2', '2022-01-03'),
       ('Nhom 3', '2', '2023-04-03'),
       ('Nhom 1', '1', NOW()),
       ('Nhom 5', '3', '2021-07-03'),
       ('Nhom 6', '1', '2020-09-03'),
       ('Nhom 9', '5', '2021-04-03'),
       ('Nhom 8', '5', '2002-05-03'),
       ('Nhom 9', '1', '2019-01-03'),
       ('Nhom 8', '1', NOW());
       
       
INSERT INTO `GroupAccount`(`GroupID`, `AccountID`, `JoinDate`)
VALUES ('2', '1', '2022-06-01'),
       ('1', '10', '2021-02-01'),
       ('3', '2', NOW()),
       ('2', '4', '2021-08-09'),
       ('2', '2', '2022-06-01'),
       ('2', '8', '2013-01-01'),
       ('5', '1', '2022-06-01'),
       ('5', '4', '2029-01-01'),
       ('5', '3', '2021-07-03'),
       ('3', '2', '2021-06-29'),
       ('9', '5', '2022-06-01'),
       ('8', '3', NOW());
       
INSERT INTO `TypeQuestion`(`TypeName`)
VALUES ('Trac nghiem'),
       ('Tu Luan'),
	   ('Trac nghiem'),
       ('Tu Luan'),
       ('Tu Luan'),
	   ('Trac nghiem'),
	   ('Trac nghiem'),
       ('Tu Luan'),
       ('Trac nghiem'),
       ('Trac nghiem');

INSERT INTO `CategoryQuestion` (`CategoryName`)
VALUES ('HTML'),
       ('SQL'),
       ('Java'),
       ('CSS'),
       ('.NET'),
       ('.NET'),
       ('Ruby'),
       ('SQL'),
       ('HTML'),
       ('Javascript');
       
INSERT INTO `Question`(`Content`, CategoryID, TypeID, CreatorID, CreateDate)
VALUES ('Câu hỏi JAVA 3', 2, 2, 1, '2022-05-01'),
       ('Câu hỏi SQL 4', 2, 1, 2, '2020-01-01'),
       ('Câu hỏi JAVA 4', 2, 3, 10, '2023-07-01'),
       ('Câu hỏi JAVA 5', 1, 2, 8, '2026-06-01'),
       ('Câu hỏi HTML 6', 2, 3, 2, NOW()),
       ('Câu hỏi SQL 5', 3, 3, 10, NOW()),
       ('Câu hỏi .NET', 3, 3, 3, '2002-08-29'),
       ('Câu hỏi HTML 7', 2, 9, 2, '2010-09-07'),
       ('Câu hỏi Javascript 7', 3, 1, 3,'2019-09-21'),
       ('Câu hỏi SQL 6', 2, 6, 8, NOW());
       
INSERT INTO `Answer` (`Content`, `QuestionID`, `isCorrect`)
VALUES ('Câu trả lời 2 - question SQL 3', 2, 1),
       ('Câu trả lời 4 - question SQL 4', 1, 1),
       ('Câu trả lời 3 - question SQL 2', 1, 3),
       ('Câu trả lời 4 - question SQL 5', 1, 0),
       ('Câu trả lời 5 - question SQL 2', 2, 0),
       ('Câu trả lời 4 - question SQL 2', 2, 0),
       ('Câu trả lời 11 - question SQL 2', 2, 0),
       ('Câu trả lời 31 - question SQL 2', 2, 1),
       ('Câu trả lời 12 - question JAVA 1', 3, 0),
       ('Câu trả lời 12 - question JAVA 7', 3, 1);

INSERT INTO `Exam`(`Code`, `Title`, `CategoryID`, `Duration`, `CreatorID`, `CreateDate`)
VALUES ('MS_08', 'De thi 01', 1, 90, 1, NOW()),
       ('MS_09', 'De thi 04', 1, 60, 5, NOW()),
       ('MS_10', 'De thi 02', 1, 60, 9, NOW()),
       ('MS_11', 'De thi 01', 2, 60, 1, NOW()),
       ('MS_12', 'De thi 05', 2, 60, 9, NOW()),
       ('MS_12', 'De thi 06', 2, 90, 3, NOW()),
       ('MS_13', 'De thi 01', 1, 90, 1, NOW()),
	   ('MS_14', 'De thi 06', 2, 90, 10, NOW()),
       ('MS_15', 'De thi 07', 2, 60, 4, NOW()),
       ('MS_16', 'De thi 02', 2, 60, 1, NOW());
       
INSERT INTO `ExamQuestion`
VALUES (17, 2),
       (18, 1),
       (19, 1),
       (20, 1),
       (21, 3),
       (22, 1),
       (23, 1),
       (24, 2),
       (25, 3),
       (26, 2);
       
/*Question 2*/
Select DepartmentName From `Department`; 

/*Question 3*/
Select 'AccountID' From `Account` Where `DepartmentID` = 5;

/*Question 4*/
Select * From `Account`
Where character_length(Fullname) = (Select character_length(Fullname) AS 'length' From `Account` Order by length Desc limit 1); 
 
/*Question 5*/
Select * From `Account`
Where character_length(Fullname) = (Select character_length(Fullname) AS 'length' From `Account` Order by length Desc limit 1) and 'DepartmentID' = 3; 

/*Question 6*/
Select `GroupName` From `Group` where CreateDate <  '2019-12-20';

/*Question 7*/

SELECT QuestionID, COUNT(QuestionID) AS SoLuong
FROM answer
GROUP BY QuestionID
HAVING SoLuong >=4;

/*Question 8*/
Select `ExamID` 
From `Exam`
Where `Duration` >= 60 And  `CreateDate` < '2019-12-20';

/*Question 9*/
Select * From `Group` 
ORder by CreateDate Desc limit 5;

/*Question 10*/
Select Count(DepartmentID) AS SoLuong
From account
where DepartmentID = 2;

/*Question 11*/
Select `FullName` From `Account`
Where (SUBSTRING_INDEX(FullName, ' ', -1)) Like 'D%o';

/*Question 12*/
SET SQL_SAFE_UPDATES = 0;
DELETE FROM exam
WHERE CreateDate < '2019-12-20';

/*Question 13*/
SET SQL_SAFE_UPDATES = 0;
Delete From Question
Where Content LIKE 'Câu hỏi%';

/*Question 14*/
SET SQL_SAFE_UPDATES = 0;
UPDATE account
SET FullName = "Nguyễn Bá Lộc", Email= "loc.nguyenba@vti.com.vn"
WHERE AccountID = 5;

/*Question 15*/
SET SQL_SAFE_UPDATES = 0;
UPDATE groupaccount
SET GroupID = 4
WHERE AccountID = 5;
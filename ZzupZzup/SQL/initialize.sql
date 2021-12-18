-- 테이블 초기화
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `MEMBER`;
DROP TABLE IF EXISTS `ACTIVITY_SCORE`;
DROP TABLE IF EXISTS `RATING`;
DROP TABLE IF EXISTS `RESTAURANT_TIME`;
DROP TABLE IF EXISTS `NOTICE`;
DROP TABLE IF EXISTS `MENU`;
DROP TABLE IF EXISTS `COMMUNITY`;
DROP TABLE IF EXISTS `RESTAURANT`;
DROP TABLE IF EXISTS `HASHTAG`;
DROP TABLE IF EXISTS `REVIEW`;
DROP TABLE IF EXISTS `CHAT`;
DROP TABLE IF EXISTS `CHAT_MEMBER`;
DROP TABLE IF EXISTS `RESERVATION`;
DROP TABLE IF EXISTS `RESERVATION_ORDER`;
DROP TABLE IF EXISTS `CHAT_LOG`;
DROP TABLE IF EXISTS `REPORT`;
DROP TABLE IF EXISTS `HASHTAG_LOG`;
DROP TABLE IF EXISTS `MARK`;
DROP TABLE IF EXISTS `ALARM`;
DROP TABLE IF EXISTS `IMAGE`;
SET FOREIGN_KEY_CHECKS = 1;


-- 테이블 생성
CREATE TABLE `MEMBER` (
    `MEMBER_ID` VARCHAR(50) NOT NULL,
    `MEMBER_ROLE` VARCHAR(5) NOT NULL,
    `PASSWORD` VARCHAR(15),
    `MEMBER_NAME` VARCHAR(10) NOT NULL,
    `MEMBER_PHONE` VARCHAR(13) NOT NULL,
    `LOGIN_TYPE` INT NOT NULL,
    `REG_DATE` DATETIME NOT NULL DEFAULT NOW(),
    `AGE_RANGE` VARCHAR(6),
    `BIRTH_YEAR` INT,
    `GENDER` VARCHAR(6),
    `PROFILE_IMAGE` VARCHAR(50) NOT NULL DEFAULT 'defaultImage.jpg',
    `NICKNAME` VARCHAR(10),
    `STATUS_MESSAGE` VARCHAR(100) DEFAULT '',
    `ACTIVITY_SCORE` INT NOT NULL DEFAULT 0,
    `MANNER_SCORE` INT NOT NULL DEFAULT 0,
    `DELETE_DATE` DATETIME,
    `DELETE_TYPE` INT,
    `DELETE_DETAIL` VARCHAR(100),
    `BLACKLIST_REG_DATE` DATETIME,
    PRIMARY KEY (`MEMBER_ID`)
);

CREATE TABLE `ACTIVITY_SCORE` (
    `ACTIVITY_NO` INT NOT NULL AUTO_INCREMENT,
    `MEMBER_ID` VARCHAR(50) NOT NULL,
    `ACCUMULATE_DATE` DATETIME NOT NULL DEFAULT NOW(),
    `ACCUMULATE_TYPE` INT NOT NULL,
    `ACCUMULATE_SCORE` INT NOT NULL,
    PRIMARY KEY (`ACTIVITY_NO`),
    FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`)
);

CREATE TABLE `RESTAURANT` (
    `RESTAURANT_NO` INT NOT NULL AUTO_INCREMENT,
    `MEMBER_ID` VARCHAR(50) NOT NULL,
    `OWNER_NAME` VARCHAR(10) NOT NULL,
    `OWNER_IMAGE` VARCHAR(50) NOT NULL,
    `RESTAURANT_TEXT` VARCHAR(100) NOT NULL,
    `RESERVATION_STATUS` BOOLEAN NOT NULL DEFAULT 1,
    `PARKABLE` BOOLEAN,
    `REQUEST_DATE` DATE,
    `JUDGE_STATUS` BOOLEAN,
    `JUDGE_DATE` DATE,
    `RESTAURANT_NAME` VARCHAR(50) NOT NULL,
    `RESTAURANT_TEL` VARCHAR(15) NOT NULL,
    `STREET_ADDRESS` VARCHAR(50) NOT NULL,
    `AREA_ADDRESS` VARCHAR(50) NOT NULL,
    `REST_ADDRESS` VARCHAR(20),
    `MENU_TYPE` INT NOT NULL,
    PRIMARY KEY (`RESTAURANT_NO`),
    FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`)
);

CREATE TABLE `MENU` (
    `MENU_NO` INT NOT NULL AUTO_INCREMENT,
    `RESTAURANT_NO` INT NOT NULL,
    `MENU_TITLE` VARCHAR(20) NOT NULL,
    `MENU_PRICE` INT NOT NULL,
    `MAIN_MENU_STATUS` BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (`MENU_NO`),
    FOREIGN KEY (`RESTAURANT_NO`) REFERENCES `RESTAURANT`(`RESTAURANT_NO`)
);

CREATE TABLE `COMMUNITY` (
    `POST_NO` INT NOT NULL AUTO_INCREMENT,
    `MEMBER_ID` VARCHAR(50) NOT NULL,
    `POST_TITLE` VARCHAR(100) NOT NULL,
    `POST_TEXT` VARCHAR(1000) NOT NULL,
    `RECEIPT_IMAGE` VARCHAR(50),
    `POST_REG_DATE` DATETIME NOT NULL DEFAULT NOW(),
    `POST_SHOW_STATUS` BOOLEAN NOT NULL DEFAULT 1,
    `RESTAURANT_NAME` VARCHAR(50) NOT NULL,
    `RESTAURANT_TEL` VARCHAR(15) NOT NULL,
    `STREET_ADDRESS` VARCHAR(50) NOT NULL,
    `AREA_ADDRESS` VARCHAR(50) NOT NULL,
    `REST_ADDRESS` VARCHAR(20),
    `MENU_TYPE` INT NOT NULL,
    `MAIN_MENU_TITLE` VARCHAR(20) NOT NULL,
    `MAIN_MENU_PRICE` INT NOT NULL,
    `OFFICIAL_DATE` DATETIME DEFAULT NOW(),
    PRIMARY KEY (`POST_NO`),
    FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`)
);

CREATE TABLE `RESTAURANT_TIME` (
    `RESTAURANT_TIME_NO` INT NOT NULL AUTO_INCREMENT,
    `POST_NO` INT,
    `RESTAURANT_NO` INT,
    `RESTAURANT_DAY` INT,
    `RESTAURANT_OPEN` VARCHAR(10),
    `RESTAURANT_CLOSE` VARCHAR(10),
    `RESTAURANT_BREAK` VARCHAR(10),
    `RESTAURANT_LAST` VARCHAR(10),
    `RESTAURANT_DAY_OFF` BOOLEAN DEFAULT 0,
    PRIMARY KEY (`RESTAURANT_TIME_NO`),
    FOREIGN KEY (`POST_NO`) REFERENCES `COMMUNITY`(`POST_NO`),
    FOREIGN KEY (`RESTAURANT_NO`) REFERENCES `RESTAURANT`(`RESTAURANT_NO`)
);

CREATE TABLE `CHAT` (
    `CHAT_NO` INT NOT NULL AUTO_INCREMENT,
    `CHAT_LEADER_ID` VARCHAR(50) NOT NULL,
    `RESTAURANT_NO` INT NOT NULL,
    `CHAT_TITLE` VARCHAR(100) NOT NULL,
    `CHAT_IMAGE` VARCHAR(50) NOT NULL DEFAULT 'chatimg.jpg',
    `CHAT_TEXT` VARCHAR(100),
    `CHAT_REG_DATE` DATETIME NOT NULL DEFAULT NOW(),
    `CHAT_GENDER` INT NOT NULL,
    `CHAT_MEMBER_COUNT` INT NOT NULL,
    `CHAT_STATE` INT NOT NULL DEFAULT 1,
    `CHAT_SHOW_STATUS` BOOLEAN NOT NULL DEFAULT 1,
    `AGE_TYPE` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`CHAT_NO`),
    FOREIGN KEY (`RESTAURANT_NO`) REFERENCES `RESTAURANT`(`RESTAURANT_NO`),
    FOREIGN KEY (`CHAT_LEADER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`)
);

CREATE TABLE `CHAT_MEMBER` (
    `CHAT_MEMBER_NO` INT NOT NULL AUTO_INCREMENT,
    `CHAT_NO` INT NOT NULL,
    `CHAT_MEMBER_ID` VARCHAR(50) NOT NULL,
    `READY_CHECK` BOOLEAN NOT NULL DEFAULT 0,
    `CHAT_LEADER_CHECK` BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (`CHAT_MEMBER_NO`),
    FOREIGN KEY (`CHAT_MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`),
    FOREIGN KEY (`CHAT_NO`) REFERENCES `CHAT`(`CHAT_NO`)
);

CREATE TABLE `CHAT_LOG` (
    `CHAT_LOG_NO` INT NOT NULL AUTO_INCREMENT,
    `CHAT_NO` INT NOT NULL,
    `CHAT_CONTENTS` VARCHAR(400) NOT NULL,
    `CHAT_TIME` DATE NOT NULL,
    PRIMARY KEY (`CHAT_LOG_NO`),
    FOREIGN KEY (`CHAT_NO`) REFERENCES `CHAT`(`CHAT_NO`)
);

CREATE TABLE `RATING` (
    `RATING_NO` INT NOT NULL AUTO_INCREMENT,
    `CHAT_NO` INT NOT NULL,
    `RATING_TO_ID` VARCHAR(50) NOT NULL,
    `RATING_FROM_ID` VARCHAR(50) NOT NULL,
    `RATING_SCORE` INT NOT NULL,
    `RATING_TYPE` INT NOT NULL,
    `RATING_REG_DATE` DATETIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (`RATING_NO`),
    FOREIGN KEY (`RATING_TO_ID`) REFERENCES `MEMBER`(`MEMBER_ID`),
    FOREIGN KEY (`CHAT_NO`) REFERENCES `CHAT`(`CHAT_NO`),
    FOREIGN KEY (`RATING_FROM_ID`) REFERENCES `MEMBER`(`MEMBER_ID`)
);

CREATE TABLE `RESERVATION` (
    `RESERVATION_NO` VARCHAR(24) NOT NULL,
    `RESTAURANT_NO` INT NOT NULL,
    `CHAT_NO` INT NOT NULL,
    `BOOKER_ID` VARCHAR(50) NOT NULL,
    `PLAN_DATE` DATETIME NOT NULL,
    `FIXED_DATE` DATETIME,
    `MEMBER_COUNT` INT NOT NULL,
    `RESERVATION_STATUS` INT NOT NULL,
    `FIXED_STATUS` BOOLEAN NOT NULL,
    `RESERVATION_DATE` DATE NOT NULL,
    `TOTAL_PRICE` INT NOT NULL,
    `PAY_OPTION` INT NOT NULL,
    `PAY_METHOD` INT,
    `CANCEL_DATE` DATETIME,
    `RESERVATION_CANCEL_TYPE` INT,
    `RESERVATION_CANCEL_DETAIL` VARCHAR(100),
    `REFUND_STATUS` BOOLEAN,
    PRIMARY KEY (`RESERVATION_NO`),
    FOREIGN KEY (`CHAT_NO`) REFERENCES `CHAT`(`CHAT_NO`),
    FOREIGN KEY (`RESTAURANT_NO`) REFERENCES `RESTAURANT`(`RESTAURANT_NO`),
    FOREIGN KEY (`BOOKER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`)
);

CREATE TABLE `RESERVATION_ORDER` (
    `ORDER_NO` INT NOT NULL AUTO_INCREMENT,
    `RESERVATION_NO` VARCHAR(24) NOT NULL,
    `MENU_TITLE` VARCHAR(50) NOT NULL,
    `ORDER_COUNT` INT NOT NULL,
    `MENU_PRICE` INT NOT NULL,
    PRIMARY KEY (`ORDER_NO`),
    FOREIGN KEY (`RESERVATION_NO`) REFERENCES `RESERVATION`(`RESERVATION_NO`)
);

CREATE TABLE `NOTICE` (
    `POST_NO` INT NOT NULL AUTO_INCREMENT,
    `MEMBER_ID` VARCHAR(50) NOT NULL,
    `POST_TITLE` VARCHAR(50) NOT NULL,
    `POST_TEXT` VARCHAR(1000) NOT NULL,
    `POST_REG_DATE` DATETIME NOT NULL DEFAULT NOW(),
    `POST_CATEGORY` INT NOT NULL,
    `POST_MEMBER_ROLE` VARCHAR(5) NOT NULL DEFAULT 'user',
    PRIMARY KEY (`POST_NO`),
    FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`)
);

CREATE TABLE `REVIEW` (
    `REVIEW_NO` INT NOT NULL AUTO_INCREMENT,
    `MEMBER_ID` VARCHAR(50) NOT NULL,
    `RESERVATION_NO` VARCHAR(24) NOT NULL,
    `REVIEW_DETAIL` VARCHAR(100),
    `REVIEW_REG_DATE` DATETIME NOT NULL DEFAULT NOW(),
    `REVIEW_SHOW_STATUS` BOOLEAN NOT NULL DEFAULT 1,
    `SCOPE_TASTE` INT NOT NULL,
    `SCOPE_KIND` INT NOT NULL,
    `SCOPE_CLEAN` INT NOT NULL,
    `AVG_SCOPE` DECIMAL NOT NULL,
    PRIMARY KEY (`REVIEW_NO`),
    FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`),
    FOREIGN KEY (`RESERVATION_NO`) REFERENCES `RESERVATION`(`RESERVATION_NO`)
);

CREATE TABLE `HASHTAG` (
    `HASHTAG_NO` INT NOT NULL AUTO_INCREMENT,
    `HASHTAG` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`HASHTAG_NO`)
);

CREATE TABLE `HASHTAG_LOG` (
    `HASHTAG_LOG_NO` INT NOT NULL AUTO_INCREMENT,
    `REVIEW_NO` INT NOT NULL,
    `HASHTAG_NO` INT NOT NULL,
    PRIMARY KEY (`HASHTAG_LOG_NO`),
    FOREIGN KEY (`HASHTAG_NO`) REFERENCES `HASHTAG`(`HASHTAG_NO`),
    FOREIGN KEY (`REVIEW_NO`) REFERENCES `REVIEW`(`REVIEW_NO`)
);

CREATE TABLE `REPORT` (
    `REPORT_NO` INT NOT NULL AUTO_INCREMENT,
    `MEMBER_ID` VARCHAR(50) NOT NULL,
    `CHAT_NO` INT,
    `CHAT_MEMBER_ID` VARCHAR(50),
    `REVIEW_NO` INT,
    `POST_NO` INT,
    `RESTAURANT_NO` INT,
    `REPORT_REG_DATE` DATETIME NOT NULL DEFAULT NOW(),
    `REPORT_TYPE` INT NOT NULL,
    `REPORT_DETAIL` VARCHAR(100),
    `REPORT_CHECK` BOOLEAN NOT NULL,
    `REPORT_CATEGORY` INT NOT NULL,
    PRIMARY KEY (`REPORT_NO`),
    FOREIGN KEY (`POST_NO`) REFERENCES `COMMUNITY`(`POST_NO`),
    FOREIGN KEY (`RESTAURANT_NO`) REFERENCES `RESTAURANT`(`RESTAURANT_NO`),
    FOREIGN KEY (`REVIEW_NO`) REFERENCES `REVIEW`(`REVIEW_NO`),
    FOREIGN KEY (`CHAT_NO`) REFERENCES `CHAT`(`CHAT_NO`),
    FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`),
    FOREIGN KEY (`CHAT_MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`)
);

CREATE TABLE `MARK` (
    `MARK_NO` INT NOT NULL AUTO_INCREMENT,
    `MEMBER_ID` VARCHAR(50) NOT NULL,
    `POST_NO` INT,
    `REVIEW_NO` INT,
    `RESTAURANT_NO` INT,
    PRIMARY KEY (`MARK_NO`),
    FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`),
    FOREIGN KEY (`POST_NO`) REFERENCES `COMMUNITY`(`POST_NO`),
    FOREIGN KEY (`RESTAURANT_NO`) REFERENCES `RESTAURANT`(`RESTAURANT_NO`),
    FOREIGN KEY (`REVIEW_NO`) REFERENCES `REVIEW`(`REVIEW_NO`)
);

CREATE TABLE `ALARM` (
    `ALARM_NO` INT NOT NULL AUTO_INCREMENT,
    `MEMBER_ID` VARCHAR(50) NOT NULL,
    `ALARM_TYPE` INT NOT NULL,
    `ALARM_CONTENTS` VARCHAR(50) NOT NULL,
    `ALARM_CHECK` BOOLEAN NOT NULL DEFAULT 0,
    `ALARM_REG_DATE` DATETIME NOT NULL DEFAULT NOW(),
    `POST_NO` INT NOT NULL,
    `CHAT_NO` INT NOT NULL,
    `RESERVATION_NO` VARCHAR(24) NOT NULL,
    `REVIEW_NO` INT NOT NULL,
    PRIMARY KEY (`ALARM_NO`),
    FOREIGN KEY (`MEMBER_ID`) REFERENCES `MEMBER`(`MEMBER_ID`),
    FOREIGN KEY (`POST_NO`) REFERENCES `COMMUNITY`(`POST_NO`),
    FOREIGN KEY (`REVIEW_NO`) REFERENCES `REVIEW`(`REVIEW_NO`),
    FOREIGN KEY (`CHAT_NO`) REFERENCES `CHAT`(`CHAT_NO`),
    FOREIGN KEY (`RESERVATION_NO`) REFERENCES `RESERVATION`(`RESERVATION_NO`)
);

CREATE TABLE `IMAGE` (
    `IMAGE_NO` INT NOT NULL AUTO_INCREMENT,
    `POST_NO` INT,
    `RESTAURANT_NO` INT,
    `REVIEW_NO` INT,
    `IMAGE` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`IMAGE_NO`),
    FOREIGN KEY (`REVIEW_NO`) REFERENCES `REVIEW`(`REVIEW_NO`),
    FOREIGN KEY (`POST_NO`) REFERENCES `COMMUNITY`(`POST_NO`),
    FOREIGN KEY (`RESTAURANT_NO`) REFERENCES `RESTAURANT`(`RESTAURANT_NO`)
);

-- 테이블 자료 입력
-- MEMBER
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE) VALUES ('admin@admin.com', 'admin', '관리자', '010-1111-0000','1', '20대', 'female', 'admin', '-', '0', '0');
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE) VALUES ('user01@zzupzzup.com', 'user', 'user01', '010-0000-0001','1', '20대', 'male', 'user01', '-', '0', '0');
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE) VALUES ('user02@zzupzzup.com', 'user', 'user02', '010-0000-0002','1', '30대', 'male', 'user02', '-', '0', '0');
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE) VALUES ('owner01@zzupzzup.com', 'owner', 'owner01', '010-0000-0003','1', '30대', 'male', 'user02', '-', '0', '0');
INSERT INTO MEMBER(MEMBER_ID, MEMBER_ROLE, MEMBER_NAME, MEMBER_PHONE, LOGIN_TYPE, AGE_RANGE, GENDER, NICKNAME, STATUS_MESSAGE, ACTIVITY_SCORE, MANNER_SCORE) VALUES ('hihi@a.com', 'user', '조영주', '010-0000-0000','1', '20대', 'female', 'czro', '-', '0', '0');
-- RESTAURANT
INSERT INTO RESTAURANT(MEMBER_ID, OWNER_NAME,
OWNER_IMAGE, RESTAURANT_TEXT, PARKABLE, RESTAURANT_NAME, 
RESTAURANT_TEL, STREET_ADDRESS, AREA_ADDRESS, MENU_TYPE)
VALUES('hihi@a.com', '홍진호', 'zzazang.jpg', '짜파게티보다 맛있는집', '0', '거구장',
'010-1234-5678', '서울시 종로구 인사동3길 29', '서울시 종로구 인사동 215-1', '1');
INSERT INTO RESTAURANT(MEMBER_ID, OWNER_NAME,
OWNER_IMAGE, RESTAURANT_TEXT, RESTAURANT_NAME, 
RESTAURANT_TEL, STREET_ADDRESS, AREA_ADDRESS, MENU_TYPE)
VALUES('hihi@a.com', '유희주', 'bab.jpg', '도시락보다 맛있는집', '김가네',
'010-1111-2222', '서울시 종로구 종로 65', '서울시 종로구 종로2가 8-4', '1');
-- MENU
INSERT INTO MENU(RESTAURANT_NO, MENU_TITLE, MENU_PRICE, MAIN_MENU_STATUS)
VALUES('1', '짜장면', '3500', '0');
-- CHAT
INSERT INTO CHAT (CHAT_LEADER_ID, RESTAURANT_NO, CHAT_TITLE, CHAT_TEXT, CHAT_GENDER , CHAT_MEMBER_COUNT, AGE_TYPE) VALUES ('hihi@a.com',1,'쩝쩝친구 구해유','소개한다',
1,1,'1,2,3');
-- CHAT_MEMBER
INSERT INTO CHAT_MEMBER (CHAT_NO, CHAT_MEMBER_ID) VALUES (1,'hihi@a.com');
-- CHAT_LOG
INSERT INTO CHAT_LOG (CHAT_NO, CHAT_CONTENTS, CHAT_TIME) VALUES (1,'하이하이','2021-01-01');
-- RATING
INSERT INTO RATING (CHAT_NO, RATING_TO_ID, RATING_FROM_ID, RATING_SCORE, RATING_TYPE) VALUES (1,'hihi@a.com', 'user01@zzupzzup.com', 1, 1);
-- RESERVATION
INSERT INTO RESERVATION(RESERVATION_NO, RESTAURANT_NO, CHAT_NO, BOOKER_ID, PLAN_DATE, FIXED_DATE,
MEMBER_COUNT, RESERVATION_STATUS, FIXED_STATUS, RESERVATION_DATE, TOTAL_PRICE, PAY_OPTION, PAY_METHOD, 
CANCEL_DATE, RESERVATION_CANCEL_TYPE, RESERVATION_CANCEL_DETAIL, REFUND_STATUS)
VALUES(CONCAT(DATE_FORMAT(NOW(), "%Y%m%e%H%i%S"),'_',FLOOR(RAND()*1000000000)),'1','1','hihi@a.com', NOW(), NOW(),'3','1', '0', NOW(), '30000','2','1', NOW(), '1', '재고없음~~~','0');
-- RESERVATION_ORDER ** RESERVATION_NO 값은 랜덤으로 생성된 값으로 변경하여 입력
INSERT INTO RESERVATION_ORDER(RESERVATION_NO, MENU_TITLE, ORDER_COUNT, MENU_PRICE)
VALUES('20211217101340_675116330', '짜장면', '3', '3500');
-- NOTICE
INSERT INTO NOTICE(MEMBER_ID, POST_TITLE, POST_TEXT,POST_CATEGORY, POST_MEMBER_ROLE) VALUES 
('hihi@a.com','배고픈데 cu','cu에서 닭가슴살 투플러스원!!!', '1', 'user');

commit;

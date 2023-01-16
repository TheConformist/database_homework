/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80028
 Source Host           : localhost:3306
 Source Schema         : train_booking

 Target Server Type    : MySQL
 Target Server Version : 80028
 File Encoding         : 65001

 Date: 19/05/2022 11:30:53
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chinese
-- ----------------------------
DROP TABLE IF EXISTS `chinese`;
CREATE TABLE `chinese`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cnname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `chinese_ibfk_1` FOREIGN KEY (`id`) REFERENCES `passenger` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chinese
-- ----------------------------
INSERT INTO `chinese` VALUES ('123', '张三');
INSERT INTO `chinese` VALUES ('1231211344', '李四');
INSERT INTO `chinese` VALUES ('1515151515', '丁真珍珠');
INSERT INTO `chinese` VALUES ('234567', '王五');
INSERT INTO `chinese` VALUES ('8888', '李赣');

-- ----------------------------
-- Table structure for foreigner
-- ----------------------------
DROP TABLE IF EXISTS `foreigner`;
CREATE TABLE `foreigner`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `frname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `passportno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  CONSTRAINT `foreigner_ibfk_1` FOREIGN KEY (`id`) REFERENCES `passenger` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of foreigner
-- ----------------------------
INSERT INTO `foreigner` VALUES ('11112222', 'tony', '12324');
INSERT INTO `foreigner` VALUES ('1234325', 'Eileen Gu', '111111');
INSERT INTO `foreigner` VALUES ('520520520', 'Anna Shcherbakova', '520520520');

-- ----------------------------
-- Table structure for infotable
-- ----------------------------
DROP TABLE IF EXISTS `infotable`;
CREATE TABLE `infotable`  (
  `trainno` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deptdate` date NOT NULL,
  `depttime` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `arvtime` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `seats_total` int(0) NOT NULL,
  `seats_current` int(0) NOT NULL,
  `price` float NULL DEFAULT NULL,
  PRIMARY KEY (`deptdate`, `trainno`) USING BTREE,
  INDEX `trainno`(`trainno`) USING BTREE,
  INDEX `deptdate`(`deptdate`) USING BTREE,
  CONSTRAINT `infotable_ibfk_1` FOREIGN KEY (`trainno`) REFERENCES `vehicle_shift` (`trainno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of infotable
-- ----------------------------
INSERT INTO `infotable` VALUES ('K8811', '2022-05-04', '09:06:32', '14:06:35', 200, 200, 100);
INSERT INTO `infotable` VALUES ('C1111', '2022-05-20', '18:20:20', '20:20:30', 1000, 2, 200);
INSERT INTO `infotable` VALUES ('C2030', '2022-05-20', '08:00:00', '08:30:30', 500, 99, 200);
INSERT INTO `infotable` VALUES ('C2222', '2022-05-20', '01:23:23', '3:23:32', 200, 100, 100);
INSERT INTO `infotable` VALUES ('C8848', '2022-05-20', '08:45:30', '15:00:56', 100, 0, 150);
INSERT INTO `infotable` VALUES ('K1064', '2022-05-20', '00:22:36', '05:43:47', 200, 99, 50);
INSERT INTO `infotable` VALUES ('test1', '2022-05-20', '13:12:34', '15:23:55', 200, 200, 20);
INSERT INTO `infotable` VALUES ('G325', '2022-05-22', '14:40:40', '17:23:49', 400, 400, 300);

-- ----------------------------
-- Table structure for passenger
-- ----------------------------
DROP TABLE IF EXISTS `passenger`;
CREATE TABLE `passenger`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nationality` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tel` bigint(0) NULL DEFAULT NULL,
  `sex` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `age` int(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of passenger
-- ----------------------------
INSERT INTO `passenger` VALUES ('11112222', '美国', 1234, '男', 1);
INSERT INTO `passenger` VALUES ('123', '中国', 1234, '男', 1);
INSERT INTO `passenger` VALUES ('1231211344', '中国', 123, '男', 2);
INSERT INTO `passenger` VALUES ('1234325', '美国', 123123, '女', 18);
INSERT INTO `passenger` VALUES ('1515151515', '中国', 123123213, '男', 21);
INSERT INTO `passenger` VALUES ('234567', '中国', 12313, '男', 23);
INSERT INTO `passenger` VALUES ('520520520', '俄罗斯', 520520520, '女', 18);
INSERT INTO `passenger` VALUES ('8888', '中国', 11112222, '男', 30);

-- ----------------------------
-- Table structure for station
-- ----------------------------
DROP TABLE IF EXISTS `station`;
CREATE TABLE `station`  (
  `stationno` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stationname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`stationno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of station
-- ----------------------------
INSERT INTO `station` VALUES ('00000', '上海虹桥');
INSERT INTO `station` VALUES ('10001', '北京');
INSERT INTO `station` VALUES ('10157', '天津');
INSERT INTO `station` VALUES ('10319', '秦皇岛');
INSERT INTO `station` VALUES ('16010', '天津西');
INSERT INTO `station` VALUES ('16295', '济南');
INSERT INTO `station` VALUES ('21152', '北京西');
INSERT INTO `station` VALUES ('23693', '广州');
INSERT INTO `station` VALUES ('24815', '聊城');
INSERT INTO `station` VALUES ('30671', '上海');

-- ----------------------------
-- Table structure for ticket
-- ----------------------------
DROP TABLE IF EXISTS `ticket`;
CREATE TABLE `ticket`  (
  `trainno` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `deptdate` date NOT NULL,
  `seatno` int(0) NOT NULL,
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`trainno`, `deptdate`, `id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `deptdate`(`deptdate`) USING BTREE,
  CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`id`) REFERENCES `passenger` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`trainno`) REFERENCES `infotable` (`trainno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ticket_ibfk_3` FOREIGN KEY (`deptdate`) REFERENCES `infotable` (`deptdate`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ticket
-- ----------------------------
INSERT INTO `ticket` VALUES ('C2030', '2022-05-20', 100, '8888');
INSERT INTO `ticket` VALUES ('K1064', '2022-05-20', 100, '123');

-- ----------------------------
-- Table structure for vehicle_shift
-- ----------------------------
DROP TABLE IF EXISTS `vehicle_shift`;
CREATE TABLE `vehicle_shift`  (
  `trainno` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dept_station` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `arv_station` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`trainno`) USING BTREE,
  INDEX `dept_station`(`dept_station`) USING BTREE,
  INDEX `arv_station`(`arv_station`) USING BTREE,
  CONSTRAINT `vehicle_shift_ibfk_1` FOREIGN KEY (`dept_station`) REFERENCES `station` (`stationno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `vehicle_shift_ibfk_2` FOREIGN KEY (`arv_station`) REFERENCES `station` (`stationno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vehicle_shift
-- ----------------------------
INSERT INTO `vehicle_shift` VALUES ('C1111', '24815', '16010');
INSERT INTO `vehicle_shift` VALUES ('C2030', '10001', '10157');
INSERT INTO `vehicle_shift` VALUES ('C2222', '24815', '16010');
INSERT INTO `vehicle_shift` VALUES ('C8848', '21152', '30671');
INSERT INTO `vehicle_shift` VALUES ('G325', '10001', '30671');
INSERT INTO `vehicle_shift` VALUES ('K1064', '24815', '10157');
INSERT INTO `vehicle_shift` VALUES ('K8811', '00000', '10001');
INSERT INTO `vehicle_shift` VALUES ('test1', '16295', '24815');

-- ----------------------------
-- View structure for tickets_search
-- ----------------------------
DROP VIEW IF EXISTS `tickets_search`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `tickets_search` AS select `infotable`.`trainno` AS `trainno`,`infotable`.`deptdate` AS `deptdate`,`infotable`.`depttime` AS `depttime`,`infotable`.`arvtime` AS `arvtime`,`infotable`.`seats_current` AS `seats_current`,`infotable`.`price` AS `price`,`s1`.`stationname` AS `dept`,`s2`.`stationname` AS `arv` from (((`infotable` join `vehicle_shift` on((`infotable`.`trainno` = `vehicle_shift`.`trainno`))) join `station` `s1`) join `station` `s2`) where ((`vehicle_shift`.`dept_station` = `s1`.`stationno`) and (`vehicle_shift`.`arv_station` = `s2`.`stationno`));

-- ----------------------------
-- Procedure structure for delete_tickets
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_tickets`;
delimiter ;;
CREATE PROCEDURE `delete_tickets`(trainno_ char(6),id_ varchar(50))
begin
        if EXISTS(select * from ticket where trainno=trainno_ and id=id_) then
						UPDATE infotable
						set seats_current=seats_current+1  where trainno=trainno_;
						delete from ticket where trainno=trainno_ and id=id_;    
            else signal sqlstate 'HY000' set message_text='你并没有购买本车次的车票';
				end if;
    end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for delete_train
-- ----------------------------
DROP PROCEDURE IF EXISTS `delete_train`;
delimiter ;;
CREATE PROCEDURE `delete_train`(trainno_ char(6))
begin
        if EXISTS(select * from ticket where trainno=trainno_) then
            signal sqlstate 'HY000' set message_text='请先退回车票';
            else delete from vehicle_shift where trainno=trainno_;
				end if;
    end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for information_updating_cn
-- ----------------------------
DROP PROCEDURE IF EXISTS `information_updating_cn`;
delimiter ;;
CREATE PROCEDURE `information_updating_cn`(new_id varchar(50),new_nationality varchar(10),
                                        telephone bigint(11),new_sex varchar(5),
                                        new_age int(5),new_cnname varchar(20))
begin
        if new_nationality<>'中国' then
            signal sqlstate 'HY000' set message_text='外国人请自觉移步到外国人信息填写板块填写个人信息';    
        end if;
        if exists (select * from passenger where id=new_id) then
            update passenger set tel=telephone where id=new_id;
            update passenger set nationality=new_nationality where id=new_id;
            update passenger set sex=new_sex where id=new_id;
            update passenger set age=new_age where id=new_id;
        else insert into passenger(id,nationality,tel,sex,age)
            values (new_id,new_nationality,telephone,new_sex,new_age);    
        end if;

        if exists (select * from chinese where id=new_id) then
            update chinese set cnname=new_cnname where id=new_id;
        else insert into chinese(id,cnname) values (new_id,new_cnname);
        end if;
    end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for information_updating_fr
-- ----------------------------
DROP PROCEDURE IF EXISTS `information_updating_fr`;
delimiter ;;
CREATE PROCEDURE `information_updating_fr`(new_id varchar(50),new_nationality varchar(10),
                                        telephone bigint(11),new_sex varchar(5),
                                        new_age int(5),new_frname varchar(20),new_passport varchar(50))
begin
        if new_nationality='中国' then
            signal sqlstate 'HY000' set message_text='中国人民请到中国人信息填写板块填写个人信息';    
        end if;
        if exists (select * from passenger where id=new_id) then
            update passenger set tel=telephone where id=new_id;
            update passenger set nationality=new_nationality where id=new_id;
            update passenger set sex=new_sex where id=new_id;
            update passenger set age=new_age where id=new_id;
        else insert into passenger(id,nationality,tel,sex,age)
            values (new_id,new_nationality,telephone,new_sex,new_age);    
        end if;

        if exists (select * from foreigner where id=new_id) then
            update foreigner set frname=new_frname where id=new_id;
            update foreigner set passportno=new_passport where id=new_id;
        else insert into foreigner(id,frname,passportno) values (new_id,new_frname,new_passport);
        end if;
    end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for tickets_buy
-- ----------------------------
DROP PROCEDURE IF EXISTS `tickets_buy`;
delimiter ;;
CREATE PROCEDURE `tickets_buy`(trainno_ char(6),deptdate_ date,id varchar(50))
begin
        declare seat int(5);
        set seat=(select seats_current from infotable
                where trainno=trainno_ and deptdate=deptdate_);
        insert into ticket(trainno,deptdate,seatno,id)
            values(trainno_,deptdate_,seat,id);
        update infotable
        set seats_current=seats_current-1
        where trainno=trainno_ and deptdate =deptdate_;
    end
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table ticket
-- ----------------------------
DROP TRIGGER IF EXISTS `trigger_buy`;
delimiter ;;
CREATE TRIGGER `trigger_buy` BEFORE INSERT ON `ticket` FOR EACH ROW begin
    declare seat int(5);
    set seat=(select seats_current from infotable
        where trainno=new.trainno and deptdate=new.deptdate);
    if seat<1 then
        signal sqlstate 'HY000' set message_text='此班次车票已售罄';
    end if;
    if new.id not in (select id from passenger where id=new.id) then
        signal sqlstate 'HY000' set message_text='请先填写个人信息';
    end if;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;

# 创建数据库
CREATE DATABASE IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `mydb`;

# user 用户表
CREATE TABLE `user` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `Name` VARCHAR(20) NULL COMMENT '姓名',
  `Password` VARCHAR(45) NULL COMMENT '密码',
  `Phone` VARCHAR(20) NOT NULL COMMENT '手机号',
  `TimeCoin` DOUBLE NOT NULL COMMENT '时间币余额',
  `TimeVol` DOUBLE NOT NULL COMMENT '志愿者时间余额',
  `RegisterDate` DATE NULL COMMENT '注册时间',
  `IDCard` VARCHAR(20) NULL COMMENT '身份证号码',
  `Sex` VARCHAR(10) NULL COMMENT '性别',
  `Birth` DATE NULL COMMENT '出生年月日',
  `QRCode` VARCHAR(20) NULL COMMENT '二维码',
  `img1` VARCHAR(50) NULL COMMENT '正面照片文件名',
  `img2` VARCHAR(50) NULL COMMENT '背面照片文件名',
  `IsVerify` INT NULL COMMENT '是否已实名认证',
  `OpenID` VARCHAR(50) NULL COMMENT '微信用户OpenID',
  `HeadImgUrl` VARCHAR(255) NULL COMMENT '用户头像',
  `Country` VARCHAR(50) NULL COMMENT '国家',
  `Province` VARCHAR(50) NULL COMMENT '省份',
  `City` VARCHAR(50) NULL COMMENT '城市',
  `Remark` VARCHAR(100) NULL COMMENT '个性签名',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='用户表';
ALTER TABLE `user`
  ADD UNIQUE KEY `Phone` (`Phone`);

# userAuth 后台管理用户权限表
CREATE TABLE `userAuth` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Name` VARCHAR(20) NOT NULL COMMENT '姓名',
  `Phone` VARCHAR(20) NOT NULL COMMENT '手机号',
  `Password` VARCHAR(45) NOT NULL COMMENT '密码',
  `Authority` VARCHAR(500) NOT NULL COMMENT '用户所拥有的权限', #用一个JSONArray字符串表示，例如["ROLE_1","ROLE_2",...]
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='后台管理用户权限表';
ALTER TABLE `userAuth`
  ADD UNIQUE KEY `Phone` (`Phone`);

# service 服务种类表
CREATE TABLE `service` (
  `ID` BIGINT(20) NOT NULL COMMENT '服务种类编号',
  `Type` VARCHAR(45) NOT NULL COMMENT '服务类型',
  `Name` VARCHAR(45)  NOT NULL COMMENT '服务名称',
  `Price` DOUBLE NOT NULL COMMENT '服务的参考价（时间元）',
  `UpdateTime` DATETIME NULL COMMENT '价格更新表时间',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='服务种类表';

# timeaccount 时间元表
CREATE TABLE `timeaccount` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `UserID` BIGINT(20) NOT NULL COMMENT '用户ID',
  `ServiceID` BIGINT(20) NOT NULL COMMENT '服务种类ID',
  `TimeAccount` DOUBLE NOT NULL COMMENT '服务对应的时间元',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='时间元表';
ALTER TABLE `timeaccount`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ServiceID` (`ServiceID`);
ALTER TABLE `timeaccount`
  ADD CONSTRAINT `timeaccount_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `timeaccount_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`);

# publish 发布服务表
CREATE TABLE `publish` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `UserID` bigint(20) NOT NULL COMMENT '发布者ID',
  `ServiceID` bigint(20) NOT NULL COMMENT '服务种类ID',
  `Description` varchar(400) DEFAULT NULL COMMENT '发布描述',
  `Price` double NOT NULL COMMENT '发布的价格',
  `Address` varchar(100) NOT NULL COMMENT '服务地点（JSONARRAY，省，市，区/县）',
  `BeginDate` datetime NOT NULL COMMENT '服务起始日期',
  `EndDate` datetime NOT NULL COMMENT '服务结束日期',
  `Extra` varchar(50) DEFAULT NULL COMMENT '其它保留字段',
  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '服务发布时间',
  PRIMARY KEY (`ID`),
  KEY `UserID` (`UserID`),
  KEY `ServiceID` (`ServiceID`),
  CONSTRAINT `publish_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  CONSTRAINT `publish_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='发布服务表';

# VolunteerPublish 志愿者服务发布表
CREATE TABLE `VolunteerPublish` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `UserID` BIGINT(20) NOT NULL COMMENT '发布者ID',
  `ServiceID` BIGINT(20) NOT NULL COMMENT '服务种类ID',
  `Description` VARCHAR(300) NULL COMMENT '发布描述',
  `Price` DECIMAL(12,2) NOT NULL COMMENT '发布的价格',
  `Address` VARCHAR(300) NOT NULL COMMENT '服务地点（JSONARRAY，省，市，区/县）',
  `BeginTime` DATETIME NOT NULL COMMENT '服务起始时间',
  `EndTime` DATETIME NOT NULL COMMENT '服务结束时间',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='志愿者服务发布表';
ALTER TABLE `VolunteerPublish`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ServiceID` (`ServiceID`);
ALTER TABLE `VolunteerPublish`
  ADD CONSTRAINT `VolunteerPublish_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `VolunteerPublish_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`);

# CooperationPublish 互助服务发布表
CREATE TABLE `CooperationPublish` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `UserID` BIGINT(20) NOT NULL COMMENT '发布者ID',
  `ServiceID` BIGINT(20) NOT NULL COMMENT '服务种类ID',
  `Description` VARCHAR(300) NULL COMMENT '发布描述',
  `Price` DECIMAL(12,2) NOT NULL COMMENT '发布的价格',
  `Address` VARCHAR(300) NOT NULL COMMENT '服务地点（JSONARRAY，省，市，区/县）',
  `BeginTime` DATETIME NOT NULL COMMENT '服务起始时间',
  `EndTime` DATETIME NOT NULL COMMENT '服务结束时间',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='互助服务发布表';
ALTER TABLE `CooperationPublish`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ServiceID` (`ServiceID`);
ALTER TABLE `CooperationPublish`
  ADD CONSTRAINT `CooperationPublish_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `CooperationPublish_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`);

# ProfessionPublish 专业服务发布表
CREATE TABLE `ProfessionPublish` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `UserID` BIGINT(20) NOT NULL COMMENT '发布者ID',
  `ServiceID` BIGINT(20) NOT NULL COMMENT '服务种类ID',
  `Description` VARCHAR(300) NULL COMMENT '发布描述',
  `Price` DECIMAL(12,2) NOT NULL COMMENT '发布的价格',
  `Address` VARCHAR(300) NOT NULL COMMENT '服务地点（JSONARRAY，省，市，区/县）',
  `BeginTime` DATETIME NOT NULL COMMENT '服务起始时间',
  `EndTime` DATETIME NOT NULL COMMENT '服务结束时间',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='专业服务发布表';
ALTER TABLE `ProfessionPublish`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ServiceID` (`ServiceID`);
ALTER TABLE `ProfessionPublish`
  ADD CONSTRAINT `ProfessionPublish_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `ProfessionPublish_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`);

# VolunteerMatch 志愿者服务申请订单表
CREATE TABLE `VolunteerMatch` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ApplyUserID` BIGINT(20) NOT NULL COMMENT '申请者ID',
  `ServiceUserID` BIGINT(20) NOT NULL COMMENT '服务者ID',
  `PublishID` BIGINT(20) NOT NULL COMMENT '发布服务ID',
  `ApplyAddress` VARCHAR(100) NOT NULL COMMENT '上门服务地址',
  `ApplyUserName` VARCHAR(20) NOT NULL COMMENT '申请者姓名',
  `ApplyUserPhone` VARCHAR(20) NOT NULL COMMENT '申请者手机号',
  `PayWay` INT NOT NULL COMMENT '支付方式',
  `BeginTime` DATETIME NULL COMMENT '开始时间',
  `EndTime` DATETIME NULL COMMENT '结束时间',
  `ActualBeginTime` DATETIME NULL COMMENT '实际开始时间',
  `ActualEndTime` DATETIME NULL COMMENT '实际结束时间',
  `PayMoney` DECIMAL(12,2) NULL COMMENT '实际支付金额',
  `Rate` INT NULL COMMENT '服务满意度评分',
  `Comment` VARCHAR(100) NULL COMMENT '服务评价',
  `Status` VARCHAR(50) NOT NULL COMMENT '订单状态',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='志愿者服务申请订单表';
ALTER TABLE `VolunteerMatch`
  ADD KEY `ApplyUserID` (`ApplyUserID`),
  ADD KEY `ServiceUserID` (`ServiceUserID`),
  ADD KEY `PublishID` (`PublishID`);
ALTER TABLE `VolunteerMatch`
  ADD CONSTRAINT `VolunteerMatch_ibfk_1` FOREIGN KEY (`ApplyUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `VolunteerMatch_ibfk_2` FOREIGN KEY (`ServiceUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `VolunteerMatch_ibfk_3` FOREIGN KEY (`PublishID`) REFERENCES `VolunteerPublish` (`ID`);

# CooperationMatch 互助服务申请订单表
CREATE TABLE `CooperationMatch` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ApplyUserID` BIGINT(20) NOT NULL COMMENT '申请者ID',
  `ServiceUserID` BIGINT(20) NOT NULL COMMENT '服务者ID',
  `PublishID` BIGINT(20) NOT NULL COMMENT '发布服务ID',
  `ApplyAddress` VARCHAR(100) NOT NULL COMMENT '上门服务地址',
  `ApplyUserName` VARCHAR(20) NOT NULL COMMENT '申请者姓名',
  `ApplyUserPhone` VARCHAR(20) NOT NULL COMMENT '申请者手机号',
  `PayWay` INT NOT NULL COMMENT '支付方式',
  `BeginTime` DATETIME NULL COMMENT '开始时间',
  `EndTime` DATETIME NULL COMMENT '结束时间',
  `ActualBeginTime` DATETIME NULL COMMENT '实际开始时间',
  `ActualEndTime` DATETIME NULL COMMENT '实际结束时间',
  `PayMoney` DECIMAL(12,2) NULL COMMENT '实际支付金额',
  `Rate` INT NULL COMMENT '服务满意度评分',
  `Comment` VARCHAR(100) NULL COMMENT '服务评价',
  `Status` VARCHAR(50) NOT NULL COMMENT '订单状态',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='互助服务申请订单表';
ALTER TABLE `CooperationMatch`
  ADD KEY `ApplyUserID` (`ApplyUserID`),
  ADD KEY `ServiceUserID` (`ServiceUserID`),
  ADD KEY `PublishID` (`PublishID`);
ALTER TABLE `CooperationMatch`
  ADD CONSTRAINT `CooperationMatch_ibfk_1` FOREIGN KEY (`ApplyUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `CooperationMatch_ibfk_2` FOREIGN KEY (`ServiceUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `CooperationMatch_ibfk_3` FOREIGN KEY (`PublishID`) REFERENCES `CooperationPublish` (`ID`);

# ProfessionMatch 专业服务申请订单表
CREATE TABLE `ProfessionMatch` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ApplyUserID` BIGINT(20) NOT NULL COMMENT '申请者ID',
  `ServiceUserID` BIGINT(20) NOT NULL COMMENT '服务者ID',
  `PublishID` BIGINT(20) NOT NULL COMMENT '发布服务ID',
  `ApplyAddress` VARCHAR(100) NOT NULL COMMENT '上门服务地址',
  `ApplyUserName` VARCHAR(20) NOT NULL COMMENT '申请者姓名',
  `ApplyUserPhone` VARCHAR(20) NOT NULL COMMENT '申请者手机号',
  `PayWay` INT NOT NULL COMMENT '支付方式',
  `BeginTime` DATETIME NULL COMMENT '开始时间',
  `EndTime` DATETIME NULL COMMENT '结束时间',
  `ActualBeginTime` DATETIME NULL COMMENT '实际开始时间',
  `ActualEndTime` DATETIME NULL COMMENT '实际结束时间',
  `PayMoney` DECIMAL(12,2) NULL COMMENT '实际支付金额',
  `Rate` INT NULL COMMENT '服务满意度评分',
  `Comment` VARCHAR(100) NULL COMMENT '服务评价',
  `Status` VARCHAR(50) NOT NULL COMMENT '订单状态',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='专业服务申请订单表';
ALTER TABLE `ProfessionMatch`
  ADD KEY `ApplyUserID` (`ApplyUserID`),
  ADD KEY `ServiceUserID` (`ServiceUserID`),
  ADD KEY `PublishID` (`PublishID`);
ALTER TABLE `ProfessionMatch`
  ADD CONSTRAINT `ProfessionMatch_ibfk_1` FOREIGN KEY (`ApplyUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `ProfessionMatch_ibfk_2` FOREIGN KEY (`ServiceUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `ProfessionMatch_ibfk_3` FOREIGN KEY (`PublishID`) REFERENCES `ProfessionPublish` (`ID`);

# publish_order 申请订单表
CREATE TABLE `publish_order` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ApplyUserID` bigint(20) NOT NULL COMMENT '申请者ID',
  `ServiceUserID` bigint(20) NOT NULL COMMENT '服务者ID',
  `PublishID` bigint(20) NOT NULL COMMENT '发布服务ID',
  `ApplyAddress` varchar(100) NOT NULL COMMENT '上门服务地址',
  `ApplyUserName` varchar(20) NOT NULL COMMENT '申请者姓名',
  `ApplyUserPhone` varchar(20) NOT NULL COMMENT '申请者手机号',
  `PayWay` int(11) NOT NULL COMMENT '支付方式',
  `BeginTime` datetime DEFAULT NULL COMMENT '开始时间',
  `EndTime` datetime DEFAULT NULL COMMENT '结束时间',
  `ActualBeginTime` datetime DEFAULT NULL COMMENT '实际开始时间',
  `ActualEndTime` datetime DEFAULT NULL COMMENT '实际结束时间',
  `PayMoney` double DEFAULT NULL COMMENT '实际支付金额',
  `Rating` int(11) DEFAULT NULL COMMENT '服务满意度评分',
  `Comment` varchar(400) DEFAULT NULL COMMENT '服务评价',
  `Status` varchar(50) NOT NULL COMMENT '订单状态',
  `Extra` varchar(50) DEFAULT NULL COMMENT '其它保留字段',
  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '服务申请时间',
  PRIMARY KEY (`ID`),
  KEY `ApplyUserID` (`ApplyUserID`),
  KEY `ServiceUserID` (`ServiceUserID`),
  KEY `PublishID` (`PublishID`),
  CONSTRAINT `publish_order_ibfk_1` FOREIGN KEY (`ApplyUserID`) REFERENCES `user` (`ID`),
  CONSTRAINT `publish_order_ibfk_2` FOREIGN KEY (`ServiceUserID`) REFERENCES `user` (`ID`),
  CONSTRAINT `publish_order_ibfk_3` FOREIGN KEY (`PublishID`) REFERENCES `publish` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COMMENT='申请订单表';


# team 志愿者团体表
CREATE TABLE `team` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Name` VARCHAR(40) NOT NULL COMMENT '团体名称',
  `CreatorID` BIGINT(20) NOT NULL COMMENT '团体创建者ID',
  `Description` VARCHAR(200) NULL COMMENT '团体简介',
  `CreateDate` DATE NOT NULL COMMENT '创建日期',
  `IsDeleted` BOOL NOT NULL COMMENT '是否已经被删除',
  `HeadImg` VARCHAR(100) NULL COMMENT '团队头像',
  `Address` VARCHAR(100) NULL COMMENT '团队地址',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='志愿者团体表';
ALTER TABLE `team`
  ADD KEY `CreatorID` (`CreatorID`);
ALTER TABLE `team`
  ADD CONSTRAINT `team_ibfk_1` FOREIGN KEY (`CreatorID`) REFERENCES `user` (`ID`);

# teamuser 志愿者所属团体表
CREATE TABLE `teamUser` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `TeamID` BIGINT(20) NOT NULL COMMENT '志愿者团体编号',
  `UserID` BIGINT(20) NOT NULL COMMENT '用户编号',
  #`IsLocked` BOOL NOT NULL COMMENT '用户是否已经被锁定', #被锁定了的用户不能申请参加活动
  #`IsDeleted` BOOL NOT NULL COMMENT '用户是否退出团体',
  `Status` VARCHAR(50) NOT NULL COMMENT '团队成员状态',
  `IsManager` BOOL NOT NULL COMMENT '用户是否是团队管理者',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='志愿者所属团体表';
ALTER TABLE `teamUser`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `TeamID` (`TeamID`);
ALTER TABLE `teamUser`
  ADD CONSTRAINT `teamuser_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `teamuser_ibfk_2` FOREIGN KEY (`TeamID`) REFERENCES `team` (`ID`);

# activityPublish 团体活动表
CREATE TABLE `activityPublish` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `TeamID` BIGINT(20) NOT NULL COMMENT '志愿者团体编号',
  `Name` VARCHAR(40) NOT NULL COMMENT '活动名称',
  `Type` VARCHAR(50) NOT NULL COMMENT '活动类型',
  `HeadImg` VARCHAR(100) NULL COMMENT '活动头像',
  `BeginTime` DATETIME NOT NULL COMMENT '活动开始时间',
  `EndTime` DATETIME NULL COMMENT '活动结束时间',
  `Address` VARCHAR(50) NOT NULL COMMENT '活动地点',
  `Count` INT NOT NULL COMMENT '活动人数',
  `ApplyEndTime` DATETIME NOT NULL COMMENT '申请截止时间',
  `Description` VARCHAR(200) NULL COMMENT '活动简介',
  `Status` VARCHAR(50) NOT NULL COMMENT '活动状态',
  `IsPublic` BOOL NOT NULL COMMENT '是否公开',
  `IsDeleted` BOOL NOT NULL COMMENT '是否已经被删除',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='团体活动表';
ALTER TABLE `activityPublish`
  ADD KEY `TeamID` (`TeamID`);
ALTER TABLE `activityPublish`
  ADD CONSTRAINT `activityPublish_ibfk_1` FOREIGN KEY (`TeamID`) REFERENCES `team` (`ID`);

# 用户加入活动表
CREATE TABLE `userActivity` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ActivityID` BIGINT(20) NOT NULL COMMENT '活动编号',
  `UserID` BIGINT(20) NOT NULL COMMENT '用户编号',
  `IsAllow` BOOL NOT NULL COMMENT '用户是否已经通过审核',
  `IsPresent` BOOL NOT NULL COMMENT '用户是否出席活动',
  `ManagerRating` DOUBLE NULL COMMENT '活动管理者为参与者打分',
  `ManagerComment` VARCHAR(100) NULL COMMENT '活动管理者评价参与者',
  `UserRating` DOUBLE NULL COMMENT '参与者为活动打分',
  `UserComment` VARCHAR(100) NULL COMMENT '参与者评价活动',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='用户加入活动表';
ALTER TABLE `userActivity`
  ADD KEY `ActivityID` (`ActivityID`),
  ADD KEY `UserID` (`UserID`);
ALTER TABLE `userActivity`
  ADD CONSTRAINT `userActivity_ibfk_1` FOREIGN KEY (`ActivityID`) REFERENCES `activityPublish` (`ID`),
  ADD CONSTRAINT `userActivity_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`);

# recharge 用户充值表
CREATE TABLE `recharge` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '充值编号',
  `UserID` BIGINT(20) NOT NULL COMMENT '用户编号',
  `TotalAmount` DOUBLE NOT NULL COMMENT '充值金额',
  `RechargeDate` DATETIME NULL COMMENT '充值时间',
  `RechargeStatus` VARCHAR(20) NULL COMMENT '充值状态',  #3种状态：1-submit,2-success,3-failed
  `UUID` VARCHAR(50) NULL COMMENT '用户充值的uuid', #在一定的范围内（从特定的名字空间到全球）唯一的机器生成的标识符
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段', #充值结果标识：“no”表示未到账，“yes”表示到账
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='用户充值表';
ALTER TABLE `recharge`
  ADD KEY `UserID` (`UserID`);
ALTER TABLE `recharge`
  ADD CONSTRAINT `recharge_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`);

# 专业技能认证表
CREATE TABLE `technicAuth` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `UserID` BIGINT(20) COMMENT '用户编号',
  `AuthID` BIGINT(20) NOT NULL COMMENT '验证者编号',
  `TechName` VARCHAR(40) NOT NULL COMMENT '专业技能证书名称',
  `TechLevel` VARCHAR(40) NOT NULL COMMENT '专业技能等级',
  `TechID` VARCHAR(40) NOT NULL COMMENT '专业技能证书编号',
  `TechPhoto1` VARCHAR(40) COMMENT '专业技能证书照片1',
  `TechPhoto2` VARCHAR(40) COMMENT '专业技能证书照片2',
  `TechPhoto3` VARCHAR(40) COMMENT '专业技能证书照片3',
  `IsVerified` BOOL NOT NULL COMMENT '是否验证',
  `IsDeleted` BOOL NOT NULL COMMENT '是否被用户自己删除',
  `ValidBeginDate` TIMESTAMP NULL COMMENT '专业证书有效期起始时间',
  `ValidEndDate` TIMESTAMP NULL COMMENT '专业证书有效期结束时间',
  `OutDated` BOOL NOT NULL COMMENT '是否过期',
  `UploadDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT '上传时间',
  `AuthDate` TIMESTAMP NULL COMMENT '验证日期',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='专业技能认证表';
ALTER TABLE `technicAuth`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `AuthID` (`AuthID`);
ALTER TABLE `technicAuth`
  ADD CONSTRAINT `technicAuth_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `technicAuth_ibfk_2` FOREIGN KEY (`AuthID`) REFERENCES `userAuth` (`ID`);

#发布需求表
CREATE TABLE `request` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `UserID` bigint(20) NOT NULL COMMENT '发布者ID',
  `ServiceID` bigint(20) NOT NULL COMMENT '服务种类ID',
  `Description` varchar(400) NOT NULL COMMENT '发布描述',
  `Payway` int(11) NOT NULL COMMENT '支付方式',
  `Price` decimal(12,2) DEFAULT NULL COMMENT '发布价格',
  `RequesterName` varchar(20) NOT NULL COMMENT '需求者姓名',
  `RequesterPhone` varchar(20) NOT NULL COMMENT '需求者手机号',
  `Address` varchar(300) NOT NULL COMMENT '服务地点（JSONARRAY，省，市，区/县）',
  `BeginTime` datetime NOT NULL COMMENT '服务起始时间',
  `EndTime` datetime NOT NULL COMMENT '服务结束时间',
  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IsComplete` tinyint(1) DEFAULT '0',
  `Extra` varchar(50) DEFAULT NULL COMMENT '其他保留字段',
  PRIMARY KEY (`ID`),
  KEY `volunteerRequest_ID_index` (`ID`),
  KEY `volunteerRequest_ibfk_1` (`UserID`),
  KEY `volunteerRequest_ibfk_2` (`ServiceID`),
  CONSTRAINT `request_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  CONSTRAINT `request_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='发布需求表';

#需求申请订单表
CREATE TABLE `requestOrder` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ApplyUserID` bigint(20) NOT NULL COMMENT '申请者ID',
  `RequestUserID` bigint(20) NOT NULL COMMENT '服务者ID',
  `RequestID` bigint(20) NOT NULL COMMENT '发布服务ID',
  `BeginTime` datetime DEFAULT NULL COMMENT '开始时间',
  `EndTime` datetime DEFAULT NULL COMMENT '结束时间',
  `CreateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ActualBeginTime` datetime DEFAULT NULL COMMENT '实际开始时间',
  `ActualEndTime` datetime DEFAULT NULL COMMENT '实际结束时间',
  `PayMoney` decimal(12,2) DEFAULT NULL COMMENT '实际支付金额',
  `Rate` int(11) DEFAULT NULL COMMENT '服务满意度评分',
  `Comment` varchar(400) DEFAULT NULL COMMENT '服务评价',
  `Status` varchar(50) NOT NULL COMMENT '订单状态',
  `Extra` varchar(50) DEFAULT NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`),
  KEY `ApplyUserID` (`ApplyUserID`),
  KEY `RequestUserID` (`RequestUserID`),
  KEY `RequestID` (`RequestID`),
  CONSTRAINT `requestOrder_ibfk_1` FOREIGN KEY (`ApplyUserID`) REFERENCES `user` (`ID`),
  CONSTRAINT `requestOrder_ibfk_2` FOREIGN KEY (`RequestUserID`) REFERENCES `user` (`ID`),
  CONSTRAINT `requestOrder_ibfk_3` FOREIGN KEY (`RequestID`) REFERENCES `request` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='需求申请订单表';

# 显示志愿者团体活动详细的信息视图
CREATE VIEW view_activity_publish_detail
  AS
    SELECT
      activityPublish.ID                AS ID,            #编号
      activityPublish.TeamID            AS TeamID,        #志愿者团体编号
      activityPublish.Name              AS Name,          #活动名称
      activityPublish.Type              AS Type,          #活动类型
      activityPublish.BeginTime         AS BeginTime,     #活动开始时间
      activityPublish.EndTime           AS EndTime,       #活动结束时间
      activityPublish.Address           AS Address,       #活动地点
      activityPublish.Count             AS Count,         #活动人数
      activityPublish.ApplyEndTime      AS ApplyEndTime,  #申请截止时间
      activityPublish.Description       AS Description,   #活动简介
      activityPublish.Status            AS Status,         #活动状态
      activityPublish.IsPublic          AS IsPublic,      #是否公开
      activityPublish.IsDeleted         AS IsDeleted,     #是否已经被删除
      team.Name                         AS teamName,       #团体名称
      team.CreatorID                    AS CreatorID      #团体创建者编号
    FROM activityPublish, team
    WHERE activityPublish.TeamID = team.ID;

# 显示志愿者所属团体详细信息视图
CREATE VIEW view_team_user_detail
  AS
    SELECT
      teamUser.ID          AS ID,             #编号
      teamUser.TeamID      AS TeamID,         #志愿者团体编号
      teamUser.UserID      AS UserID,         #用户编号
      teamUser.Status      AS Status,         #用户状态
      teamUser.IsManager   AS IsManager,      #用户是否是管理者
      team.CreatorID      AS CreatorID,       #团体创建者编号
      team.Name            AS TeamName,       #团体名称
      user.Name            AS UserName,       #用户姓名
      user.Phone           AS UserPhone,      #用户手机号
      user.Sex             AS UserSex,        #用户性别
      user.Birth           AS UserBirth       #用户出生年月
    FROM teamUser, team, user
    WHERE teamUser.TeamID = team.ID AND teamUser.UserID = user.ID;

# 显示用户申请加入活动的详细信息视图
CREATE VIEW view_user_activity_detail
  AS
    SELECT
      userActivity.ID               AS ID,             #编号
      userActivity.ActivityID      AS ActivityID,     #活动编号
      userActivity.UserID           AS UserID,        #用户编号
      user.Name                     AS UserName,        #用户名
      user.Phone                    AS UserPhone,       #用户手机号
      userActivity.IsAllow          AS IsAllow,       #审核是否通过
      userActivity.IsPresent        AS IsPresent,       #是否参加活动
      userActivity.ManagerRating    AS ManagerRating,     #管理者对参与者评分
      userActivity.ManagerComment   AS ManagerComment,    #管理者评价参与者
      userActivity.UserRating       AS UserRating,      #参与者对活动评分
      userActivity.UserComment     AS UserComment,      #参与者评价活动
      activityPublish.TeamID        AS TeamID,          #活动团队编队
      activityPublish.Name              AS Name,          #活动名称
      activityPublish.BeginTime         AS BeginTime,     #活动开始时间
      activityPublish.EndTime           AS EndTime,       #活动结束时间
      activityPublish.Address           AS Address,       #活动地点
      activityPublish.Count             AS Count,         #活动人数
      activityPublish.ApplyEndTime      AS ApplyEndTime,  #申请截止时间
      activityPublish.Description       AS Description,   #活动简介
      activityPublish.Status        AS Status,          #活动状态
      team.Name                     AS TeamName,         #团队名称
      team.CreatorID                AS CreatorID        #团队创建者编号
    FROM userActivity, activityPublish ,team ,user
    WHERE userActivity.ActivityID = activityPublish.ID AND activityPublish.TeamID = team.ID AND userActivity.UserID = user.ID;

# 显示已发布的服务详细信息视图
CREATE VIEW view_publish_detail AS
  SELECT
    `mydb`.`publish`.`ID`          AS `ID`,
    `mydb`.`publish`.`ServiceID`   AS `ServiceID`,
    `mydb`.`user`.`ID`             AS `UserID`,
    `mydb`.`publish`.`Price`       AS `Price`,
    `mydb`.`publish`.`Description` AS `Description`,
    `mydb`.`publish`.`Address`     AS `Address`,
    `mydb`.`publish`.`BeginDate`   AS `BeginDate`,
    `mydb`.`publish`.`EndDate`     AS `EndDate`,
    `mydb`.`publish`.`CreateTime`  AS `CreateTime`,
    `mydb`.`service`.`Type`        AS `ServiceType`,
    `mydb`.`service`.`Name`        AS `ServiceName`,
    `mydb`.`user`.`Name`           AS `UserName`,
    `mydb`.`user`.`Sex`            AS `Sex`,
    `mydb`.`user`.`Phone`          AS `UserPhone`,
    `mydb`.`user`.`HeadImgUrl`     AS `HeadImgUrl`
  FROM ((`mydb`.`publish`
    JOIN `mydb`.`user`) JOIN `mydb`.`service`)
  WHERE ((`mydb`.`publish`.`UserID` = `mydb`.`user`.`ID`) AND (`mydb`.`publish`.`ServiceID` = `mydb`.`service`.`ID`));


# 显示已生成的publish_order的详细信息
CREATE VIEW view_publish_order_detail AS
  SELECT
    `mydb`.`publish_order`.`ID`              AS `ID`,
    `mydb`.`publish_order`.`ApplyUserID`     AS `ApplyUserID`,
    `mydb`.`publish_order`.`ApplyUserName`   AS `ApplyUserName`,
    `mydb`.`publish_order`.`ApplyUserPhone`  AS `ApplyUserPhone`,
    `mydb`.`publish_order`.`ApplyAddress`    AS `Address`,
    `mydb`.`publish_order`.`BeginTime`       AS `BeginTime`,
    `mydb`.`publish_order`.`EndTime`         AS `EndTime`,
    `mydb`.`publish_order`.`ActualBeginTime` AS `ActualBeginTime`,
    `mydb`.`publish_order`.`ActualEndTime`   AS `ActualEndTime`,
    `mydb`.`publish_order`.`PayWay`          AS `PayWay`,
    `mydb`.`publish_order`.`PayMoney`        AS `PayMoney`,
    `mydb`.`publish_order`.`Status`          AS `Status`,
    `mydb`.`publish_order`.`PublishID`       AS `PublishID`,
    `mydb`.`publish_order`.`CreateTime`      AS `CreateTime`,
    `mydb`.`publish`.`Price`                 AS `PublishPrice`,
    `mydb`.`publish`.`ServiceID`             AS `ServiceID`,
    `mydb`.`service`.`Type`                  AS `ServiceType`,
    `mydb`.`service`.`Name`                  AS `ServiceName`,
    `mydb`.`publish_order`.`ServiceUserID`   AS `ServiceUserID`,
    `serviceuser`.`Name`                     AS `ServiceUserName`,
    `serviceuser`.`Phone`                    AS `ServiceUserPhone`,
    `mydb`.`publish_order`.`Rating`          AS `Rating`,
    `mydb`.`publish_order`.`Comment`         AS `Comment`
  FROM (((`mydb`.`publish_order`
    JOIN `mydb`.`user` `serviceuser`) JOIN `mydb`.`publish`) JOIN `mydb`.`service`)
  WHERE ((`mydb`.`publish_order`.`PublishID` = `mydb`.`publish`.`ID`) AND
         (`mydb`.`publish`.`ServiceID` = `mydb`.`service`.`ID`) AND
         (`mydb`.`publish_order`.`ServiceUserID` = `serviceuser`.`ID`));


# 显示志愿者团体表的详细信息视图
CREATE VIEW view_team_detail
  AS
    SELECT
      team.ID              AS ID,
      team.Name            AS Name,
      team.CreatorID      AS CreatorID,
      user.Name            AS CreatorUserName,
      user.Phone           AS CreatorUserPhone,
      team.CreateDate      AS CreateDate,
      team.Description     AS Description,
      team.IsDeleted       AS IsDeleted,
      team.HeadImg          AS HeadImg,
      team.Address          AS Address
    FROM team, user
    WHERE team.CreatorID = user.ID;

#显示发布需求详细视图
CREATE VIEW `mydb`.`view_request_detail` AS
  SELECT
    `mydb`.`request`.`ID` AS `ID`,
    `mydb`.`request`.`ServiceID` AS `ServiceID`,
    `mydb`.`user`.`ID` AS `UserID`,
    `mydb`.`request`.`Price` AS `Price`,
    `mydb`.`request`.`Description` AS `Description`,
    `mydb`.`request`.`Address` AS `Address`,
    `mydb`.`request`.`BeginTime` AS `BeginTime`,
    `mydb`.`request`.`EndTime` AS `EndTime`,
    `mydb`.`request`.`CreateTime` AS `CreateTime`,
    `mydb`.`request`.`IsComplete` AS `IsComplete`,
    (CASE
     WHEN
       ((100 <= `mydb`.`request`.`ServiceID`)
        AND (`mydb`.`request`.`ServiceID` < 200))
       THEN
         'volunteer'
     WHEN
       ((200 <= `mydb`.`request`.`ServiceID`)
        AND (`mydb`.`request`.`ServiceID` < 300))
       THEN
         'technic'
     WHEN
       ((300 <= `mydb`.`request`.`ServiceID`)
        AND (`mydb`.`request`.`ServiceID` < 400))
       THEN
         'mutualAid'
     END) AS `ServiceType`,
    `mydb`.`service`.`Name` AS `ServiceName`,
    `mydb`.`user`.`Name` AS `UserName`,
    `mydb`.`user`.`Sex` AS `Sex`,
    `mydb`.`user`.`Phone` AS `UserPhone`,
    `mydb`.`user`.`HeadImgUrl` AS `HeadImgUrl`
  FROM
    ((`mydb`.`request`
      JOIN `mydb`.`user`)
      JOIN `mydb`.`service`)
  WHERE
    ((`mydb`.`request`.`UserID` = `mydb`.`user`.`ID`)
     AND (`mydb`.`request`.`ServiceID` = `mydb`.`service`.`ID`));

#显示需求申请详细视图
CREATE VIEW `mydb`.`view_request_order_detail` AS
  SELECT
    `mydb`.`requestorder`.`ID` AS `ID`,
    `mydb`.`requestorder`.`ApplyUserID` AS `ApplyUserID`,
    `applyUser`.`Name` AS `ApplyUserName`,
    `applyUser`.`Phone` AS `ApplyUserPhone`,
    `mydb`.`request`.`Address` AS `Address`,
    `mydb`.`requestorder`.`BeginTime` AS `BeginTime`,
    `mydb`.`requestorder`.`EndTime` AS `EndTime`,
    `mydb`.`requestorder`.`CreateTime` AS `CreateTime`,
    `mydb`.`requestorder`.`ActualBeginTime` AS `ActualBeginTime`,
    `mydb`.`requestorder`.`ActualEndTime` AS `ActualEndTime`,
    `mydb`.`request`.`Payway` AS `PayWay`,
    `mydb`.`requestorder`.`PayMoney` AS `PayMoney`,
    `mydb`.`requestorder`.`Status` AS `Status`,
    `mydb`.`requestorder`.`RequestID` AS `RequestID`,
    `mydb`.`request`.`Price` AS `RequestPrice`,
    `mydb`.`request`.`ServiceID` AS `ServiceID`,
    `mydb`.`request`.`IsComplete` AS `IsComplete`,
    (CASE
     WHEN
       ((100 <= `mydb`.`request`.`ServiceID`)
        AND (`mydb`.`request`.`ServiceID` < 200))
       THEN
         'volunteer'
     WHEN
       ((200 <= `mydb`.`request`.`ServiceID`)
        AND (`mydb`.`request`.`ServiceID` < 300))
       THEN
         'technic'
     WHEN
       ((300 <= `mydb`.`request`.`ServiceID`)
        AND (`mydb`.`request`.`ServiceID` < 400))
       THEN
         'mutualAid'
     END) AS `ServiceType`,
    `mydb`.`service`.`Name` AS `ServiceName`,
    `mydb`.`requestorder`.`RequestUserID` AS `RequestUserID`,
    `requestUser`.`Name` AS `RequestUserName`,
    `requestUser`.`Phone` AS `RequestUserPhone`,
    `mydb`.`requestorder`.`Rate` AS `Rate`,
    `mydb`.`requestorder`.`Comment` AS `Comment`
  FROM
    ((((`mydb`.`requestorder`
      JOIN `mydb`.`user` `requestUser`)
      JOIN `mydb`.`user` `applyUser`)
      JOIN `mydb`.`request`)
      JOIN `mydb`.`service`)
  WHERE
    ((`mydb`.`requestorder`.`RequestID` = `mydb`.`request`.`ID`)
     AND (`mydb`.`request`.`ServiceID` = `mydb`.`service`.`ID`)
     AND (`mydb`.`requestorder`.`RequestUserID` = `requestUser`.`ID`)
     AND (`mydb`.`requestorder`.`ApplyUserID` = `applyUser`.`ID`));
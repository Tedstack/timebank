# User 用户表
CREATE TABLE `user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `Name` varchar(20) NULL COMMENT '姓名',
  `Password` varchar(45) NULL COMMENT '密码',
  `Phone` varchar(20) NOT NULL COMMENT '手机号',
  `TimeCoin` double NOT NULL COMMENT '时间币余额',
  `TimeVol` double NOT NULL COMMENT '志愿者时间余额',
  `RegisterDate` date NULL COMMENT '注册时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户表';
ALTER TABLE `user`
  ADD UNIQUE KEY `Phone` (`Phone`);

# ServiceController 服务种类表
CREATE TABLE `service` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '服务种类编号',
  `Type` varchar(45) NOT NULL COMMENT '服务类型',
  `Name` varchar(45)  NOT NULL COMMENT '服务名称',
  `Price` double NOT NULL COMMENT '服务的参考价（时间元）',
  `UpdateTime` datetime NULL COMMENT '价格更新表时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务种类表';


# TimeAccount 时间元表
CREATE TABLE `timeaccount` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `UserID` bigint(20) NOT NULL COMMENT '用户ID',
  `ServiceID` bigint(20) NOT NULL COMMENT '服务种类ID',
  `TimeAccount` double NOT NULL COMMENT '服务对应的时间元',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='时间元表';
ALTER TABLE `timeaccount`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ServiceID` (`ServiceID`);
ALTER TABLE `timeaccount`
  ADD CONSTRAINT `timeaccount_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `timeaccount_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`);

# Publish 发布服务表
CREATE TABLE `publish` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `UserID` bigint(20) NOT NULL COMMENT '发布者ID',
  `ServiceID` bigint(20) NOT NULL COMMENT '服务种类ID',
  `Description` varchar(100) NULL COMMENT '发布描述',
  `Price` double NOT NULL COMMENT '发布的价格',
  `Address` varchar(100) NOT NULL COMMENT '服务地点（JSONARRAY，省，市，区/县）',
  `BeginDate` datetime NOT NULL COMMENT '服务起始日期',
  `EndDate` datetime NOT NULL COMMENT '服务结束日期',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='发布服务表';
ALTER TABLE `publish`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ServiceID` (`ServiceID`);
ALTER TABLE `publish`
  ADD CONSTRAINT `publish_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `publish_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`);

# record 申请订单表
CREATE TABLE `record` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `ApplyUserID` bigint(20) NOT NULL COMMENT '申请者ID',
  `ServiceUserID` bigint(20) NOT NULL COMMENT '服务者ID',
  `PublishID` bigint(20) NOT NULL COMMENT '发布服务ID',
  `Address` varchar(100) NOT NULL COMMENT '上门地址',
  `ApplyUserName` varchar(20) NOT NULL COMMENT '申请者姓名',
  `Phone` varchar(20) NOT NULL COMMENT '手机号手机号',
  `PayWay` int NOT NULL COMMENT '支付方式',
  `BeginTime` datetime NULL COMMENT '开始时间',
  `EndTime` datetime NULL COMMENT '结束时间',
  `ActualBeginTime` datetime NULL COMMENT '实际开始时间',
  `ActualEndTime` datetime NULL COMMENT '实际结束时间',
  `PayMoney` double NULL COMMENT '实际支付金额',
  `Status` varchar(50) NOT NULL COMMENT '订单状态',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='申请订单表';
ALTER TABLE `order`
  ADD KEY `ApplyUserID` (`ApplyUserID`),
  ADD KEY `ServiceUserID` (`ServiceUserID`),
  ADD KEY `PublishID` (`PublishID`);
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`ApplyUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `order_ibfk_2` FOREIGN KEY (`ServiceUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `order_ibfk_3` FOREIGN KEY (`PublishID`) REFERENCES `publish` (`ID`);


# 显示已发布的服务信息视图
CREATE VIEW view_publish_detail
  as select publish.ID AS ID, publish.ServiceID as ServiceID, user.ID AS UserID,
            publish.Price AS Price, publish.Description AS Description,
            publish.Address AS Address, publish.BeginDate AS BeginDate, publish.EndDate AS EndDate,
            Service.Type as ServiceType, Service.Name AS ServiceName, user.Name AS UserName
     FROM publish,user,service
     WHERE publish.UserID =user.ID and publish.ServiceID=service.ID;

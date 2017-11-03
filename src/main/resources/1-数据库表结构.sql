# User 用户表
CREATE TABLE `user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户编号',
  `Name` varchar(20) NULL COMMENT '姓名',
  `Password` varchar(45) NULL COMMENT '密码',
  `Phone` varchar(20) NOT NULL COMMENT '手机号',
  `TimeCoin` double NOT NULL COMMENT '时间币余额',
  `TimeVol` double NOT NULL COMMENT '志愿者时间余额',
  `RegisterDate` date NULL COMMENT '注册时间',
  `IDCard` varchar(20) NULL COMMENT '身份证号码',
  `Sex` VARCHAR(10) NULL COMMENT '性别',
  `Birth` DATE NULL COMMENT '出生年月日',
  `QRCode` VARCHAR(20) NULL COMMENT '二维码',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
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
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务种类表';


# TimeAccount 时间元表
CREATE TABLE `timeaccount` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '记录编号',
  `UserID` bigint(20) NOT NULL COMMENT '用户ID',
  `ServiceID` bigint(20) NOT NULL COMMENT '服务种类ID',
  `TimeAccount` double NOT NULL COMMENT '服务对应的时间元',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
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
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
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
  `ApplyAddress` varchar(100) NOT NULL COMMENT '上门服务地址',
  `ApplyUserName` varchar(20) NOT NULL COMMENT '申请者姓名',
  `ApplyUserPhone` varchar(20) NOT NULL COMMENT '申请者手机号',
  `PayWay` int NOT NULL COMMENT '支付方式',
  `BeginTime` datetime NULL COMMENT '开始时间',
  `EndTime` datetime NULL COMMENT '结束时间',
  `ActualBeginTime` datetime NULL COMMENT '实际开始时间',
  `ActualEndTime` datetime NULL COMMENT '实际结束时间',
  `PayMoney` double NULL COMMENT '实际支付金额',
  `Status` varchar(50) NOT NULL COMMENT '订单状态',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='申请订单表';
ALTER TABLE `record`
  ADD KEY `ApplyUserID` (`ApplyUserID`),
  ADD KEY `ServiceUserID` (`ServiceUserID`),
  ADD KEY `PublishID` (`PublishID`);
ALTER TABLE `record`
  ADD CONSTRAINT `record_ibfk_1` FOREIGN KEY (`ApplyUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `record_ibfk_2` FOREIGN KEY (`ServiceUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `record_ibfk_3` FOREIGN KEY (`PublishID`) REFERENCES `publish` (`ID`);


# 显示已发布的服务详细信息视图
CREATE VIEW view_publish_detail
  AS
    SELECT
      publish.ID          AS ID,
      publish.ServiceID   AS ServiceID,
      user.ID             AS UserID,
      publish.Price       AS Price,
      publish.Description AS Description,
      publish.Address     AS Address,
      publish.BeginDate   AS BeginDate,
      publish.EndDate     AS EndDate,
      Service.Type        AS ServiceType,
      Service.Name        AS ServiceName,
      user.Name           AS UserName,
      user.Phone          AS UserPhone
    FROM publish, user, service
    WHERE publish.UserID = user.ID AND publish.ServiceID = service.ID;

# 显示已生成的RECORD的详细信息
CREATE VIEW view_record_detail
  AS
    SELECT
      record.ID              AS ID,               #订单编号
      record.ApplyUserID     AS ApplyUserID,      #预约服务的用户ID
      record.ApplyUserName   AS ApplyUserName,    #预约联系的姓名
      record.ApplyUserPhone  AS ApplyUserPhone,   #预约联系的手机号
      record.ApplyAddress    AS Address,          #预约上门服务的地址
      record.BeginTime       AS BeginTime,        #预约开始服务的时间
      record.EndTime         AS EndTime,          #预约结束服务的时间
      record.ActualBeginTime AS ActualBeginTime,  #实际开始服务的时间
      record.ActualEndTime   AS ActualEndTime,    #实际结束服务的时间
      record.PayWay          AS PayWay,           #订单的付款方式
      record.PayMoney        AS PayMoney,         #订单的实际付款金额
      record.Status          AS Status,           #订单的状态
      record.PublishID       AS PublishID,        #发布的编号
      publish.Price          AS PublishPrice,     #发布的价格
      publish.ServiceID      AS ServiceID,        #服务种类编号
      service.Type           AS ServiceType,      #服务类型
      service.Name           AS ServiceName,      #服务名称
      record.ServiceUserID   AS ServiceUserID,    #服务者编号
      serviceUser.Name       AS ServiceUserName,  #服务者姓名
      serviceUser.Phone      AS ServiceUserPhone  #服务者手机号
  FROM record, user AS serviceUser, publish, service
  WHERE record.PublishID = publish.ID AND publish.ServiceID = service.ID AND record.ServiceUserID = serviceUser.ID
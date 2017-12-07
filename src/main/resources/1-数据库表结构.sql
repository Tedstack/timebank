# 创建数据库
CREATE DATABASE IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `mydb`;

# User 用户表
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
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='用户表';
ALTER TABLE `user`
  ADD UNIQUE KEY `Phone` (`Phone`);

# ServiceController 服务种类表
CREATE TABLE `service` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '服务种类编号',
  `Type` VARCHAR(45) NOT NULL COMMENT '服务类型',
  `Name` VARCHAR(45)  NOT NULL COMMENT '服务名称',
  `Price` DOUBLE NOT NULL COMMENT '服务的参考价（时间元）',
  `UpdateTime` DATETIME NULL COMMENT '价格更新表时间',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='服务种类表';


# TimeAccount 时间元表
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

# Publish 发布服务表
CREATE TABLE `publish` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `UserID` BIGINT(20) NOT NULL COMMENT '发布者ID',
  `ServiceID` BIGINT(20) NOT NULL COMMENT '服务种类ID',
  `Description` VARCHAR(100) NULL COMMENT '发布描述',
  `Price` DOUBLE NOT NULL COMMENT '发布的价格',
  `Address` VARCHAR(100) NOT NULL COMMENT '服务地点（JSONARRAY，省，市，区/县）',
  `BeginDate` DATETIME NOT NULL COMMENT '服务起始日期',
  `EndDate` DATETIME NOT NULL COMMENT '服务结束日期',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='发布服务表';
ALTER TABLE `publish`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ServiceID` (`ServiceID`);
ALTER TABLE `publish`
  ADD CONSTRAINT `publish_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `publish_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`);

# record 申请订单表
CREATE TABLE `record` (
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
  `PayMoney` DOUBLE NULL COMMENT '实际支付金额',
  `Rating` DOUBLE NULL COMMENT '服务满意度评分',
  `Comment` VARCHAR(100) NULL COMMENT '服务评价',
  `Status` VARCHAR(50) NOT NULL COMMENT '订单状态',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='申请订单表';
ALTER TABLE `record`
  ADD KEY `ApplyUserID` (`ApplyUserID`),
  ADD KEY `ServiceUserID` (`ServiceUserID`),
  ADD KEY `PublishID` (`PublishID`);
ALTER TABLE `record`
  ADD CONSTRAINT `record_ibfk_1` FOREIGN KEY (`ApplyUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `record_ibfk_2` FOREIGN KEY (`ServiceUserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `record_ibfk_3` FOREIGN KEY (`PublishID`) REFERENCES `publish` (`ID`);

# team 志愿者团体表
CREATE TABLE `team` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Name` VARCHAR(40) NOT NULL COMMENT '团体名称',
  `ManagerUserID` BIGINT(20) NOT NULL COMMENT '团体管理者ID',
  `Description` VARCHAR(200) NULL COMMENT '团体简介',
  `CreateDate` DATE NOT NULL COMMENT '创建日期',
  `IsDeleted` BOOL NOT NULL COMMENT '是否已经被删除',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='志愿者团体表';
ALTER TABLE `team`
  ADD KEY `ManagerUserID` (`ManagerUserID`);
ALTER TABLE `team`
  ADD CONSTRAINT `team_ibfk_1` FOREIGN KEY (`ManagerUserID`) REFERENCES `user` (`ID`);

# teamuser 志愿者所属团体表
CREATE TABLE `teamUser` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `TeamID` BIGINT(20) NOT NULL COMMENT '志愿者团体编号',
  `UserID` BIGINT(20) NOT NULL COMMENT '用户编号',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='志愿者所属团体表';
ALTER TABLE `teamUser`
  ADD KEY `UserID` (`UserID`),
  ADD KEY `TeamID` (`TeamID`);
ALTER TABLE `teamUser`
  ADD CONSTRAINT `teamuser_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `teamuser_ibfk_2` FOREIGN KEY (`TeamID`) REFERENCES `team` (`ID`);

# activity 团体活动表
CREATE TABLE `activityPublish` (
  `ID` BIGINT(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `Name` VARCHAR(40) NOT NULL COMMENT '活动名称',
  `BeginTime` DATETIME NOT NULL COMMENT '活动开始时间',
  `EndTime` DATETIME NULL COMMENT '活动结束时间',
  `Address` VARCHAR(50) NOT NULL COMMENT '活动地点',
  `Count` INT NOT NULL COMMENT '活动人数',
  `ApplyEndTime` DATETIME NOT NULL COMMENT '申请截止时间',
  `Description` VARCHAR(200) NULL COMMENT '活动简介',
  `IsPublic` BOOL NOT NULL COMMENT '是否公开',
  `IsDeleted` BOOL NOT NULL COMMENT '是否已经被删除',
  `Extra` VARCHAR(50) NULL COMMENT '其它保留字段',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci COMMENT='志愿者团体表';


# 显示志愿者所属团体详细信息视图
CREATE VIEW view_team_user_detail
  AS
    SELECT
      teamUser.ID          AS ID,             #编号
      teamUser.TeamID      AS TeamID,         #志愿者团体编号
      teamUser.UserID      AS UserID,         #用户编号
      team.ManagerUserID   AS ManagerUserID,  #团体管理者编号
      team.Name            AS TeamName,       #团体名称
      user.Name            AS UserName,       #用户姓名
      user.Phone           AS UserPhone,      #用户手机号
      user.Sex             AS UserSex,        #用户性别
      user.Birth           AS UserBirth       #用户出生年月
    FROM teamUser, team, user
    WHERE teamUser.TeamID = team.ID AND teamUser.UserID = user.ID;

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
      service.Type        AS ServiceType,
      service.Name        AS ServiceName,
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
  WHERE record.PublishID = publish.ID AND publish.ServiceID = service.ID AND record.ServiceUserID = serviceUser.ID;

# 显示志愿者团体表的详细信息视图
CREATE VIEW view_team_detail
  AS
    SELECT
      team.ID              AS ID,
      team.Name            AS Name,
      team.ManagerUserID   AS ManagerUserID,
      user.Name            AS ManagerUserName,
      user.Phone           AS ManagerUserPhone,
      team.CreateDate      AS CreateDate,
      team.Description     AS Description,
      team.IsDeleted       AS IsDeleted
    FROM team, user
    WHERE team.ManagerUserID = user.ID;

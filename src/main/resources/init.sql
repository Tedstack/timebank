# User 用户表
CREATE TABLE `user` (
  `ID` bigint(20) NOT NULL COMMENT '用户编号',
  `Name` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '姓名',
  `Password` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '密码',
  `Phone` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `TimeCoin` double NOT NULL COMMENT '时间币余额',
  `TimeVol` double NOT NULL COMMENT '志愿者时间余额',
  `RegisterDate` date DEFAULT NULL COMMENT '注册时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户表';
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Phone` (`Phone`);

# Service 服务种类表
CREATE TABLE `service` (
  `ID` bigint(20) NOT NULL COMMENT '服务种类编号',
  `Type` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '服务类型',
  `Name` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '服务名称',
  `Price` double NOT NULL COMMENT '服务的参考价（时间元）',
  `UpdateTime` datetime DEFAULT NULL COMMENT '价格更新表时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务种类表';
ALTER TABLE `service`
  ADD PRIMARY KEY (`ID`);

# TimeAccount 时间元表
CREATE TABLE `timeaccount` (
  `ID` bigint(20) NOT NULL COMMENT '记录编号',
  `UserID` bigint(20) NOT NULL COMMENT '用户ID',
  `ServiceID` bigint(20) NOT NULL COMMENT '服务种类ID',
  `TimeAccount` double NOT NULL COMMENT '服务对应的时间元'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='时间元表';
ALTER TABLE `timeaccount`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `UserID` (`UserID`),
  ADD KEY `ServiceID` (`ServiceID`);
ALTER TABLE `timeaccount`
  ADD CONSTRAINT `timeaccount_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `user` (`ID`),
  ADD CONSTRAINT `timeaccount_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service` (`ID`);




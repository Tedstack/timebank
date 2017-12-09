微信端的手机页面首页地址：localhost:8080/index

后台管理的首页地址：localhost:8080/admin/index


开发原则：
1. 数据库表凡是被外键约束的数据，不能直接进行删除操作，需要通过添加一个是否被删除的字段来标识；反之，没有被外键约束的表，可以直接进行删除操作。
2. 


一些参考资料：
1. 如何搭建远程访问的Mysql服务器：https://www.cnblogs.com/thinkingandworkinghard/p/7813504.html
2.  
# 启动与连接
1. 启动
~~~
    .\mongod --dbpath=F:\mongodb\data\db --logpath=F:\mongodb\log\mongodb.log --logappend
~~~
2. 连接
~~~
    mongo
~~~
3. 添加用户
~~~
db.createUser({user: "myuser",pwd: "mypwd",roles: [ { role: "root", db: "admin" } ]})
db.auth("myuser","mypwd")
db.dropUser("myuser")
~~~

# 常用命令
1. 创建数据库
~~~js
    use haha
~~~
2. 查看数据库
~~~js
    show dbs
~~~
3. 进入指定数据库
~~~js
    use haha
~~~
4. 查看所有表
~~~js
    show tables
~~~
5. 新建表(集合)
* 方法1：直接执行插入命令，对应的表(集合)就会变建立
~~~js
    db.col.insert({"title":"oneTitle"})
~~~
* 方法2：使用db.createCollection(name, options)
    * name: 要创建的集合名称
    * options: 可选参数, 指定有关内存大小及索引的选项

| 字段	| 类型	| 描述 |
| ------ | ------ | ------ |
| capped	| 布尔	|（可选）如果为 true，则创建固定集合。固定集合是指有着固定大小的集合，当达到最大值时，它会自动覆盖最早的文档。当该值为 true 时，必须指定 size 参数。|
| autoIndexId	| 布尔	| （可选）如为 true，自动在 _id 字段创建索引。默认为 false。|
| size	| 数值	| （可选）为固定集合指定一个最大值，以千字节计（KB）如果 capped 为 true，也需要指定该字段。|
| max	| 数值	| （可选）指定固定集合中包含文档的最大数量。
~~~js
    db.createCollection(name, options)
~~~
6. 删除数据库
~~~js
    //进入指定数据库
    use hehe
    //执行删除命令
    db.dropDatabase()
~~~
7. 删除表(集合)
~~~js
    db.col.drop()
~~~
8. 插入文档
* insert()
~~~js
db.col.insert({title: 'MongoDB 教程', 
    description: 'MongoDB 是一个 Nosql 数据库',
    by: '菜鸟教程',
    url: 'http://www.runoob.com',
    tags: ['mongodb', 'database', 'NoSQL'],
    likes: 100
})
~~~
* insertOne()
~~~js
db.col.insertOne({"title":"title99"})
~~~
* insertMany({"title":"title"+i})
~~~js
var array=[]
for(var i=0;i<10;i++){
    array.push({"title":"title"+i})
}
db.col.insertMany(array)
~~~
9. 更新文档
~~~js
db.collection.update(
   <query>,
   <update>,
   {
     upsert: <boolean>,
     multi: <boolean>,
     writeConcern: <document>
   }
)
~~~
* 参数说明
    * query : update的查询条件，类似sql update查询内where后面的。
    * update : update的对象和一些更新的操作符（如$,$inc...）等，也可以理解为sql update查询内set后面的   
    * upsert : 可选，这个参数的意思是，如果不存在update的记录，是否插入objNew,true为插入，默认是false，不插入。
    * multi : 可选，mongodb 默认是false,只更新找到的第一条记录，如果这个参数为true,就把按条件查出来多条记录全部更新。
    * writeConcern :可选，抛出异常的级别。




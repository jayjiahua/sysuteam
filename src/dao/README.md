此处存放与数据库交互的方法

交互方法参照user

多语句查询(没有开)：
由于安全原因，如果要用需要这样创建连接：
var connection = mysql.createConnection({multipleStatements: true});

connection.query('SELECT 1; SELECT 2', function(err, results) {
  if (err) throw err;

  // `results` is an array with one element for every statement in the query:
  console.log(results[0]); // [{1: 1}]
  console.log(results[1]); // [{2: 2}]
});

据说根据这种写法会安全：
sql = 'SELECT * FROM Users WHERE id = ' + conn.escape(id)
或者
sql = "UPDATE ?? SET ? WHERE ?? = ?"
inserts = ['Users', updatainfor, 'id', id]
sql = conn.format sql, inserts


无脑翻译：
## 建立连接

建立连接的一种推荐方法:

```js
var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'example.org',
  user     : 'bob',
  password : 'secret'
});

connection.connect(function(err) {
  if (err) {
    console.error('error connecting: ' + err.stack);
    return;
  }

  console.log('connected as id ' + connection.threadId);
});
```
然而，连接可以在查询中隐式地建立:

```js
var mysql      = require('mysql');
var connection = mysql.createConnection(...);

connection.query('SELECT 1', function(err, rows) {
  // connected! (unless `err` is set)
});
```

## 连接选项(Connection options)

在建立一个连接时，可以使用以下选项:

host：主机地址 （默认：localhost）

user：用户名

password：密码

port：端口号 （默认：3306）

database：数据库名

charset：连接字符集（默认：'UTF8_GENERAL_CI'，注意字符集的字母都要大写）

localAddress：此IP用于TCP连接（可选）

socketPath：连接到unix域路径，当使用 host 和 port 时会被忽略

timezone：时区（默认：'local'）

connectTimeout：连接超时（默认：不限制；单位：毫秒）

stringifyObjects：是否序列化对象（默认：'false' ；与安全相关https://github.com/felixge/node-mysql/issues/501）

typeCast：是否将列值转化为本地JavaScript类型值 （默认：true）

queryFormat：自定义query语句格式化方法 https://github.com/felixge/node-mysql#custom-format

supportBigNumbers：数据库支持bigint或decimal类型列时，需要设此option为true （默认：false）

bigNumberStrings：supportBigNumbers和bigNumberStrings启用 强制bigint或decimal列以JavaScript字符串类型返回（默认：false）

dateStrings：强制timestamp,datetime,data类型以字符串类型返回，而不是JavaScript Date类型（默认：false）

debug：开启调试（默认：false）

multipleStatements：是否许一个query中有多个MySQL语句 （默认：false）

flags：用于修改连接标志，更多详情：https://github.com/felixge/node-mysql#connection-flags

ssl：使用ssl参数（与crypto.createCredenitals参数格式一至）或一个包含ssl配置文件名称的字符串，目前只捆绑Amazon RDS的配置文件

　　其它：

　　可以使用URL形式的加接字符串，不多介绍了，不太喜欢那种格式，觉得可读性差，也易出错，想了解的可以去主页上看。

## 关闭连接

可以通过两种方式关闭数据库连接。

通过 `end()` 方法按照正常状态关闭已经完成的数据库连接：
```js
connection.end(function(err) {
  // The connection is terminated now
});
```


另外一种可选的方法是通过 `destroy()` 方法
这种方法会即刻执行，不管queries是否完成！
```js
connection.destroy();
```

与 `end()` 不同的是， `destroy()` 方法不接受callback


## 查询

建立一个查询的最基本的方法是在一个连接实例(像`Connection`, `Pool`, `PoolNamespace` 或其他相似的对象)上调用 `.query()` 方法


`query()` 最简单的形式是 `.query(sqlString, callback)`, 第一个参数是SQL语句，第二个参数是回调函数：

```js
connection.query('SELECT * FROM `books` WHERE `author` = "David"', function (error, results, fields) {
  // error will be an Error if one occurred during the query
  // results will contain the results of the query
  // fields will contain information about the returned results fields (if any)
});
```

第二种形式 `.query(sqlString, values, callback)` 使用了占位符：

```js
connection.query('SELECT * FROM `books` WHERE `author` = ?', ['David'], function (error, results, fields) {
  // error will be an Error if one occurred during the query
  // results will contain the results of the query
  // fields will contain information about the returned results fields (if any)
});
```

第三种形式 `.query(options, callback)` 是在查询中使用多种选项参数, 如 escaping query values，joins with overlapping column names,timeouts, 和type casting：

```js
connection.query({
  sql: 'SELECT * FROM `books` WHERE `author` = ?',
  timeout: 40000, // 40s
  values: ['David']
}, function (error, results, fields) {
  // error will be an Error if one occurred during the query
  // results will contain the results of the query
  // fields will contain information about the returned results fields (if any)
});
```
注意当占位符作为参数传递而不是对象时，第二跟第三种形式可以结合来使用。

 `values` 参数会覆盖掉选项对象中的 `values` 

```js
connection.query({
    sql: 'SELECT * FROM `books` WHERE `author` = ?',
    timeout: 40000, // 40s
  },
  ['David'],
  function (error, results, fields) {
    // error will be an Error if one occurred during the query
    // results will contain the results of the query
    // fields will contain information about the returned results fields (if any)
  }
);
```

## 编码查询值

为了防止SQL注入, 你在对用户提供的数据插入查询语句前应该总是对其进行编码 。
你可以这样做：
`mysql.escape()`, `connection.escape()` 或者`pool.escape()` 方法:

```js
var userId = 'some user provided value';
var sql    = 'SELECT * FROM users WHERE id = ' + connection.escape(userId);
connection.query(sql, function(err, results) {
  // ...
});
```

你可以使用 `?` 作为占位符给你想要编码的值，如下： 

```js
connection.query('SELECT * FROM users WHERE id = ?', [userId], function(err, results) {
  // ...
});
```

这里本质上其实使用了同样的 `connection.escape()` 方法 


如果你留意的话, 你可能会注意到这可以使得你的语句变得简洁:

```js
var post  = {id: 1, title: 'Hello MySQL'};
var query = connection.query('INSERT INTO posts SET ?', post, function(err, result) {
  // Neat!
});
console.log(query.sql); // INSERT INTO posts SET `id` = 1, `title` = 'Hello MySQL'

```

如果你想自己进行编码,你也可以直接使用 escaping 函数:

```js
var query = "SELECT * FROM posts WHERE title=" + mysql.escape("Hello MySQL");

console.log(query); // SELECT * FROM posts WHERE title='Hello MySQL'
```

## 编码查询标志符

如果你不相信用户提供的查询标志符 (database / table / column name) , 你可以使用 `mysql.escapeId(identifier)`,
`connection.escapeId(identifier)` 或`pool.escapeId(identifier)` 对其进行编码:

```js
var sorter = 'date';
var sql    = 'SELECT * FROM posts ORDER BY ' + connection.escapeId(sorter);
connection.query(sql, function(err, results) {
  // ...
});
```
也可以加入合适的标识符，这都会编码.

```js
var sorter = 'date';
var sql    = 'SELECT * FROM posts ORDER BY ' + connection.escapeId('posts.' + sorter);
connection.query(sql, function(err, results) {
  // ...
});
```

此外, 你可以使用 `??` 字符 作为占位符给你想要编码的标志符如下:

```js
var userId = 1;
var columns = ['username', 'email'];
var query = connection.query('SELECT ?? FROM ?? WHERE id = ?', [columns, 'users', userId], function(err, results) {
  // ...
});

console.log(query.sql); // SELECT `username`, `email` FROM `users` WHERE id = 1
```
你可以传递一个对象给 `.escape()` or `.query()`, `.escapeId()` 来避免SQL注入。

### 创建查询语句

你可以使用 mysql.format 来创建一个多插入点的查询语句，对id和值适当的编码 。一个简单的例子:

```js
var sql = "SELECT * FROM ?? WHERE ?? = ?";
var inserts = ['users', 'id', userId];
sql = mysql.format(sql, inserts);
```

这样你可以获得一个有效并且安全的查询语句

### 自定义格式
如果你喜欢另外一个查询编码格式, 有一个连接选项可以让你定义一个自定义的格式。
一个实现自定义格式的例子:

```js
connection.config.queryFormat = function (query, values) {
  if (!values) return query;
  return query.replace(/\:(\w+)/g, function (txt, key) {
    if (values.hasOwnProperty(key)) {
      return this.escape(values[key]);
    }
    return txt;
  }.bind(this));
};

connection.query("UPDATE posts SET title = :title", { title: "Hello MySQL" });
```

## 获取插入行的id

如果你把一行插入有自增主键的表，可以这样获得插入的ID：
```js
connection.query('INSERT INTO posts SET ?', {title: 'test'}, function(err, result) {
  if (err) throw err;

  console.log(result.insertId);
});
```
当处理大数字（在JavaScript数精度上），你应该考虑启用` supportbignumbers `选项把ID作为字符串读取插入，否则将会抛出错误。
在从数据库取大数时也要启用这个选项

## 获取受影响的行数

你可以获得从插入，更新或删除语句受影响的行数。
```js
connection.query('DELETE FROM posts WHERE title = "wrong"', function (err, result) {
  if (err) throw err;

  console.log('deleted ' + result.affectedRows + ' rows');
})
```

## 获取被改变的行数
你可以获得更新语句被改变的行数。

"changedRows"不同于 "affectedRows" 在于他不算没有被改变的值

```js
connection.query('UPDATE posts SET ...', function (err, result) {
  if (err) throw err;

  console.log('changed ' + result.changedRows + ' rows');
})
```

## 获得连接ID

你可以使用`threadId`属性获取MySQL连接ID（“thread ID”）。
```js
connection.connect(function(err) {
  if (err) throw err;
  console.log('connected as id ' + connection.threadId);
});
```


## 多语句查询

由于安全原因，默认是关闭的.
如果要用需要这样创建连接:

```js
var connection = mysql.createConnection({multipleStatements: true});
```

打开之后，你可以执行多语句查询如下:

```js
connection.query('SELECT 1; SELECT 2', function(err, results) {
  if (err) throw err;

  // `results` is an array with one element for every statement in the query:
  console.log(results[0]); // [{1: 1}]
  console.log(results[1]); // [{2: 2}]
});
```

此外，你还可以这样:

```js
var query = connection.query('SELECT 1; SELECT 2');

query
  .on('fields', function(fields, index) {
    // the fields for the result rows that follow
  })
  .on('result', function(row, index) {
    // index refers to the statement this result belongs to (starts at 0)
  });
```
如果你的一个查询语句导致错误，由此产生 Error
 `err.index` 属性就是你第几条语句出错 
当发生错误时MySQL也将停止执行其余的语句。


## 错误处理


该模块自带了错误处理，为了写出健壮的应用，你应该仔细看。

通过本模块创建的所有错误是JavaScript的Error对象实例
。他们有两个属性:

* `err.code`:  MySQL 错误码 (e.g.`'ER_ACCESS_DENIED_ERROR'`), node.js错误 (e.g. `'ECONNREFUSED'`) 或者内部错误 (e.g.  `'PROTOCOL_CONNECTION_LOST'`).*
*  `err.fatal`: 布尔值, 指出这个错误是否是终端连接对象。

Error: https://developer.mozilla.org/en/JavaScript/Reference/Global_Objects/Error
MySQL server error: http://dev.mysql.com/doc/refman/5.5/en/error-messages-server.html

致命错误会挂起所有的回调。在下面的例子中，试图连接到一个无效端口时触发致命的错误。因此，错误传递到回调：
```js
var connection = require('mysql').createConnection({
  port: 84943, // WRONG PORT
});

connection.connect(function(err) {
  console.log(err.code); // 'ECONNREFUSED'
  console.log(err.fatal); // true
});

connection.query('SELECT 1', function(err) {
  console.log(err.code); // 'ECONNREFUSED'
  console.log(err.fatal); // true
});
```
正常错误只返回给属于他们回调函数。所以在下面的例子中，只有第一个回调会接收错误，第二个查询的会出错：

```js
connection.query('USE name_of_db_that_does_not_exist', function(err, rows) {
  console.log(err.code); // 'ER_BAD_DB_ERROR'
});

connection.query('SELECT 1', function(err, rows) {
  console.log(err); // null
  console.log(rows.length); // 1
});
```
如果一个致命的错误产生，没有一个待定的回调，或者当一个正常的错误产生而没有属于他的回调，错误会向连接对象发出`error`事件。下面的例子说明：

```js
connection.on('error', function(err) {
  console.log(err.code); // 'ER_BAD_DB_ERROR'
});

connection.query('USE name_of_db_that_does_not_exist');
```
注：`error`事件在 node中很特殊。如果他们出现而没有绑定侦听器，会打印堆栈跟踪并且杀死你的进程。





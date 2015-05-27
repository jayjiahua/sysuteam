此处存放与数据库交互的方法

交互方法参照user

多语句查询：
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
# conf/db.js
# MySQL数据库联接配置
require! []

mysql = require 'mysql'

config = {
    host: 'localhost', 
    user: 'root',
    password: 'root', #这是我的密码啊- -你们测试要改
    database:'web_course',
    port: 3306
}

connection = mysql.createConnection config
connection.connect!


module.exports = {
    conn: connection
}

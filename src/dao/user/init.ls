require! []

conn = require('../../conf/db').conn

module.exports = {
    get-user-by-id: (id, callback) ->
        # 据说这样的写法可以防注入呢
        sql = "SELECT * FROM ?? WHERE id = ?"
        inserts = ['Users', conn.escape(id)]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result, fields) ->
            callback err, result

    login: (username, password, callback) ->
        # 据说这样的写法可以防注入呢
        sql = "SELECT * FROM ?? WHERE username = ?"
        inserts = ['Users', username]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result, fields) ->
            callback err, result            

    add-user: (user-infor, callback) ->
        # userinfor = {username: 'bbb', password: 'ccc'}
        sql = "INSERT INTO ?? SET ?"
        inserts = ['Users', user-infor]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result) ->
            callback err, result

    update-user-by-id: (id, update-infor, callback) ->
        # id = 6
        # updatainfor = {password:'xxxx', qq: 'xxxxx', weixin: 'xxxxx'}

        sql = "UPDATE ?? SET ? WHERE ?? = ?"
        inserts = ['Users', update-infor, 'id', id]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result) ->
            callback err, result
            

}
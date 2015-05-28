require! []

conn = require('../../conf/db').conn

module.exports = {
    get_user_by_id: (id, callback) ->
        # 据说这样的写法可以防注入呢
        sql = "SELECT * FROM ?? WHERE id = ?"
        inserts = ['Users', conn.escape(id)]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result, fields) ->
            if err
                throw err
            console.log '用户信息: ', result[0]

    add_user: (userinfor, callback) ->
        # userinfor = {username: 'bbb', password: 'ccc'}

        sql = "INSERT INTO ?? SET ?"
        inserts = ['Users', userinfor]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result) ->
            if err
                throw err
            console.log '成功添加用户'
            console.log 'Id为：' result.insertId

    update_user_by_id: (id, updatainfor, callback) ->
        # id = 6
        # updatainfor = {password:'xxxx', qq: 'xxxxx', weixin: 'xxxxx'}

        sql = "UPDATE ?? SET ? WHERE ?? = ?"
        inserts = ['Users', updatainfor, 'id', id]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result) ->
            if err
                throw err
            console.log '成功修改用户信息'
            console.log '影响了'+result.affectedRows+'行' #这里应该为1因为是用by id
            console.log '改变了'+result.changedRows+'行'

}
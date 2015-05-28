require! []

user = require('../../dao/user/init')

module.exports = {
    # 注册 成功后设置username，    返回值 0//成功 1//失败
    creat-user: (req, res, user-infor) ->
        user.add-user user-infor, (err, result)->
            msg = '成功添加用户 Id为：'+result.insertId
            console.log  msg
            if err
                res.send '1'
            else
                res.cookie 'username', user-infor.username, { maxAge: 900000}
                res.send '0'

    # 登陆 成功后设置username，    返回值 0//成功 1//失败
    login: (req, res, username, password) ->
        user.login username, password, (err, result)->
            if result.length is not 0
                res.cookie 'username', result[0].username, { maxAge: 900000}
                res.send '0'
            else
                res.send '1'

    query-user : (req, res, id) ->
        user.get-user-by-id id, (err, result)->
            msg = '用户信息:' + result[0]
            console.log msg
            if err
                res.render 'test', ret:msg
            else
                res.render 'test', ret:result[0]['username']

    update-user : (req, res, id, update-infor) ->
        user.update-user-by-id id, update-infor, (err, result)->
            #这里应该为1因为是用by id
            msg = '成功修改用户信息\n'+'影响了'+result.affectedRows+'行\n'+'改变了'+result.changedRows+'行'
            console.log msg
            if err
                res.render 'test', ret:msg
            else
                res.render 'test', ret:msg
}
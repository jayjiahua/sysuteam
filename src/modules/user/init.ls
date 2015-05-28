require! []

user = require('../../dao/user/init')

module.exports = {
    creat-user: (req, res, user-infor) ->
        user.add-user user-infor, (err, result)->
            msg = '成功添加用户 Id为：'+result.insertId
            console.log  msg
            if err
                res.render 'test', ret:msg
            else
                res.render 'test', ret:msg 

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
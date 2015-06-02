require! ['crypto']

user = require('../../dao/user/init')

get-hash-password = (raw-password) ->
  # 加密
  sha256 = crypto.createHash 'sha256'
  key = Math.random().toString().slice(11)
  sha256.update key+raw-password
  hash = sha256.digest 'hex'
  enc-password = key + '$' + hash
  return enc-password

check-password = (raw-password, enc-password) ->
  # 解密
  key = (enc-password.split '$')[0]
  hash = (enc-password.split '$')[1]
  sha256 = crypto.createHash 'sha256'
  sha256.update key+raw-password
  new-hash = sha256.digest 'hex'
  console.log '存在数据库中的：',hash
  console.log '解出的：',new-hash
  return hash == new-hash

module.exports = {
    # 注册 成功后设置username，    返回值 0//成功 1//失败
    creat-user: (req, res, user-infor) ->
        user.add-user user-infor, (err, result)->
            msg = '成功添加用户 Id为：'+result.insertId
            console.log  msg
            if err
                res.send '1'
            else
                res.cookie 'user', user-infor, { maxAge: 900000}
                res.send '0'

    # 登陆 成功后设置username，    返回值 0//成功 1//失败
    login: (req, res, username, password) ->
        user.login username, password, (err, result)->
            console.log password
            console.log result[0].password
            if result.length is not 0 and check-password(password,result[0].password)
                res.cookie 'user', result[0], { maxAge: 900000}
                console.log res.cookie!
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
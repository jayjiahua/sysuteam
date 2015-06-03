# 这是start页面和register页面（登陆）共用的js文件
$ '#register_btn' .click !->
  name = $ '#username' .val!
  pw = $ '#password' .val!
  email = $ '#email' .val!
  skill = $ '#skill' .val!
  if name is "" or pw is "" or email is ""
    alert "用户名/密码/邮箱不能为空哦"
  else
    $.ajax {
      url:'/register'
      data:
        username: name
        password: pw
        mailbox: email
        me_info: skill
      type: 'post'
      success: (data)->
        if data == "0"
          alert "注册成功！"
          window.location.href = '/'
        else  
          alert "注册失败！"
      error: (textStatus) !->
        alert "异常！" + textStatus
    }
  
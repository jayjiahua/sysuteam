# 这是start页面和register页面（登陆）共用的js文件
window.onload = ->
  $ '#register_btn' .click !->
    name = $ '#register-name' .val!
    pw = $ '#register-pass-sure' .val!
    check-pw = $ '#register-pass' .val!
    email = $ '#register-email' .val!
    skill = $ '#register-skill' .val!
    if pw is not check-pw
      alert "两次密码不一致哦"
      return
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

  
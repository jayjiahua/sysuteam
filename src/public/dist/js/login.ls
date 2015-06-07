window.onload = ->
    $ '#login_btn' .click ->
      name = $ '#username' .val!
      pw = $ '#password' .val!
      if name is "" or pw is ""
        alert "用户名/密码不能为空哦"
      else
        $.ajax {
          url:'/login'
          data:
            username : name
            password : pw
          type: 'post'
          success: (data)->
            if data == "0"
              alert "登陆成功！"
              window.location.href = '/'
            else  
              alert "登陆失败！"
          error: (textStatus) !->
            alert "异常！" + textStatus
        }

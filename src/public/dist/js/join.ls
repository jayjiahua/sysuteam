window.onload = ->
    $ '#join' .click (e)->
      e.preventDefault!
      $.ajax {
        url: ($ '#join').attr 'href'
        type: 'get'
        success: (data)->
          if data == "0"
            alert "加入成功！"
            location.reload!
          else  
            alert "加入失败！"
        error: (textStatus) !->
          alert "异常！" + textStatus
      }

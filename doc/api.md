按照我的理解写了下。。。
**如无特殊说明，提交和返回的对象名与数据库表中字段名一样**

`GET /`

    后端给出 Users对象信息+首页对应的队伍数组 渲染index.html
    （如果没有user信息，渲染start.html）
___
`GET /login`

    渲染login.html

`AJAX`
`POST /login`

    input:
    username
    password
    output:
    0//成功
    1//失败 停留在login。成功则跳转到index

___
`GET /register`

    渲染register.html

`AJAX`
`POST /register`

    input:
    username
    password
    output:
    0//成功
    1//失败
___
    获取用户信息
`GET /userinfo`

    input:
    userid
    output:
    后端给出 Users对象信息+对应的Teamer对象信息 渲染userinfo.html
___
    获取队伍列表,`Ajax`实现分页
`GET/teamlist/num`

    num为页号
    返回json格式的对应页号的队伍数组对象（后台分页）
___
    获取队伍详细信息
`GET /team/teamid`

    返回teamid对应Teamer对象 用来渲染personal_team_detail.html

    申请加入队伍 `ajax`
`POST /team/teamid`

    output:
    0//成功
    1//失败
___
`GET /creatteam`

    渲染personal_team_create.html

`POST /creatteam`

    input:
    name
    info
    output:
    成功跳转/team/teamid


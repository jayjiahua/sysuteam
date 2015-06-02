require! ['express', 'crypto']
router = express.Router! 

is-authenticated = (req, res, next)-> 
  if req.cookies.user then next! else res.redirect '/login'

get-hash-password = (raw-password) ->
  # 加密
  sha256 = crypto.createHash 'sha256'
  key = Math.random().toString().slice(11)
  sha256.update key+raw-password
  hash = sha256.digest 'hex'
  enc-password = key + '$' + hash
  return enc-password


module.exports = (user, team, activity)->

  router.get '/', (req, res)!-> 
    activity.get-all-activities req, res

  router.post '/createteam', is-authenticated, (req, res) !->
    activity.add-personal-activity req, res

  # 只是前端测试用，直接返回静态页面，最后路由的命名不是这样的
  router.get '/userinfo', (req, res)!->
    res.render 'userinfo'
  router.get '/createactivity', (req, res)!->
    res.render 'sponsor_activity_create'
  router.get '/activitydetail', (req, res)!->
    res.render 'activity_detail'
  
  router.get '/start', (req, res)!->
    res.render 'start'
  router.get '/createactivity', (req, res)!->
    res.render 'sponsor_activity_create'
  #####
  router.get '/team', (req, res)!->
    res.render 'index _teams'

  router.get '/team/:teamid', (req, res)!->
    console.log '查看队伍,teamid:', req.params.teamid
    res.render 'team_detail'
  
  router.get '/createteam', is-authenticated, (req, res)!->
    res.render 'person_team_create'


  router.get '/login', (req, res)!->
    if req.cookies.user then res.redirect '/' else res.render 'login'

  router.get '/logout', (req, res)!->
    res.clearCookie 'user'
    res.redirect '/'

  router.post '/login', (req, res)!->
    username = req.body.username
    password = req.body.password
    user.login req, res, username, password

  router.get '/register', (req, res)!->
    res.render 'register'

  router.post '/register', (req, res)!->
    user-infor = {
      username: req.body.username
      password: get-hash-password req.body.password
      mailbox: req.body.mailbox
      me_info: req.body.me_info
    }
    user.creat-user req, res, user-infor

  router.get '/queryuser', (req, res)!->
    id = 30
    user.query-user req, res, id
    
  router.get '/updateuser', (req, res)!->
    id = 30
    update-infor = {password:'hehe', qq: 'bitch', weixin: 'ass'}
    user.update-user req, res, id, update-infor

  router.get '/check', (req, res)!->
    res.render 'test', ret:req.cookies.user.username
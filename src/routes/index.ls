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
    if req.cookies.visit
      activity.get-all-personal-activities req, res
    else
      res.cookie 'visit', true
      #res.render 'start'
      res.redirect '/register'

  router.get '/createteam', is-authenticated, (req, res)!->
    res.render 'person_team_create', user: req.cookies.user

  router.post '/createteam', is-authenticated, (req, res) !->
    activity.add-personal-activity req, res

  router.get '/createteamInActivity/:activityid', is-authenticated, (req, res) !->
    res.render 'person_team_create', user: req.cookies.user

  router.post '/createteamInActivity/:activityid', is-authenticated, (req, res) !->
    team.add-team-in-activity req, res, req.params.activityid

  router.get '/userinfo', is-authenticated, (req, res)!->
    user.query-user req, res, req.cookies.user.id
    # res.render 'userinfo'
  
  router.get '/createactivity', is-authenticated, (req, res)!->
    res.render 'sponsor_activity_create'

  router.get '/activitydetail/:activityid', (req, res)!->
    activity.get-one-activity req, res, parse-int req.params.activityid
  
  # router.get '/start', (req, res)!->
  #   res.render 'start'
  router.get '/createactivity', (req, res)!->
    res.render 'sponsor_activity_create'

  router.post '/createactivity', (req, res) !->
    activity.add-activity req, res
  #####
  router.get '/team', (req, res)!->
    res.render 'index _teams'

  router.get '/team/:teamid', is-authenticated, (req, res)!->
    team.get-team-by-id req, res, parse-int req.params.teamid
    #console.log '查看队伍,teamid:', req.params.teamid

  router.get '/join/:teamid', is-authenticated, (req, res)!->
    info = {
      team_id: parse-int req.params.teamid
      user_id: req.cookies.user.id
      role: 2
    }
    console.log info
    team.add-teammate req, res, info
    
    
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
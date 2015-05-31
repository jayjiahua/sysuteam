require! ['express']
router = express.Router! 

module.exports = (user, team, activity)->

  router.get '/', (req, res)!-> res.render 'index', message: req.flash 'message'

  

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


  router.get '/login', (req, res)!->
    res.render 'login'

  router.post '/login', (req, res)!->
    username = req.body.username
    password = req.body.password
    user.login req, res, username, password

  router.get '/register', (req, res)!->
    res.render 'register'

  router.post '/register', (req, res)!->
    user-infor = {
      username: req.body.username
      password: req.body.password
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
    res.render 'test', ret:req.cookies.username
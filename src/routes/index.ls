require! ['express']
router = express.Router! 

module.exports = (user, team, activity)->

  router.get '/', (req, res)!-> res.render 'index', message: req.flash 'message'

  router.get '/userinfo', (req, res)!->
    res.render 'userinfo'

  router.get '/createactivity', (req, res)!->
    res.render 'sponsor_activity_create'
  # 应为POST
  router.get '/login', (req, res)!->
    username = 'test1'
    password = 'shit'
    user.login req, res, username, password

  # 应为POST
  router.get '/register', (req, res)!->
    user-infor = {username: 'bill', password: 'bill'}
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
require! ['express']
router = express.Router! 

module.exports = (user, team, activity)->

  router.get '/', (req, res)!-> res.render 'index', message: req.flash 'message'

  router.get '/queryuser', (req, res)!->
    id = 30
    user.query-user req, res, id

  router.get '/creatuser', (req, res)!->
    user-infor = {username: 'asda', password: 'asdasd'}
    user.creat-user req, res, user-infor
    
  router.get '/updateuser', (req, res)!->
    id = 30
    update-infor = {password:'hehe', qq: 'bitch', weixin: 'ass'}
    user.update-user req, res, id, update-infor
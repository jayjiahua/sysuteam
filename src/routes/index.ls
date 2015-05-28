require! ['express']
router = express.Router! 

module.exports = (user, team, activity)->

  router.get '/', (req, res)!-> res.render 'index', message: req.flash 'message'

  router.get '/testuser', (req, res)!->
    userinfor = {username: 'bbb', password: 'ccc'}
    id = 30
    updatainfor = {password:'hehe', qq: 'bitch', weixin: 'ass'}

    user.get-user-by-id 30
    user.add-user userinfor
    user.update-user-by-id id, updatainfor
    res.render 'test', ret:'hehe' 

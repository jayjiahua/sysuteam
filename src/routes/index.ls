require! ['express']
router = express.Router! 

module.exports = (user, team, activity)->

  router.get '/', (req, res)!-> res.render 'index', message: req.flash 'message'

  router.get '/testuser', (req, res)!->
    userinfor = {username: 'bbb', password: 'ccc'}
    id = 7
    updatainfor = {password:'hehe', qq: 'bitch', weixin: 'ass'}

    user.get_user_by_id 7
    user.add_user userinfor
    user.update_user_by_id id, updatainfor
    res.render 'test', ret:'hehe' 

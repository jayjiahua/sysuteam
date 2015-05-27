require! ['express']
router = express.Router! 

module.exports = (user, team, activity)->

  router.get '/', (req, res)!-> res.render 'index', message: req.flash 'message'

  router.get '/testuser', (req, res)!->
    user.fuck!
    res.render 'test', ret:'hehe' 

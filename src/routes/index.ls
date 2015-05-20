require! ['express']
require! {User: '../models/user'}
require! {Team: '../models/team'}
require! {Activity: '../models/activity'}
router = express.Router! 

module.exports = (user, team, activity)->

  router.get '/', (req, res)!-> res.render 'index', message: req.flash 'message'


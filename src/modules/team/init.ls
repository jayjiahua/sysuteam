require! []

activity = require('../../dao/activity/init')

is-authenticated = (req, res, next)-> 
	if req.cookie then next! else res.redirect '/login'

module.exports = {

}
require! []

activity = require('../../dao/activity/init')
team = require('../../dao/team/init')

module.exports = {
	get-team-by-id: (req, res, team-id) ->
		team.get-team-by-team-id team-id, (err, result) ->
			
			res.render 'team_detail', team: result[0], user: req.cookies.user
}
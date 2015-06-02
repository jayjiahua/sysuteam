require! []
	
activity = require('../../dao/activity/init')

module.exports = {
    get-all-activities: (req, res) ->
        activity.get-all-activities (err, result) ->
            if err
                console.log err
            else
                console.log result
                res.render 'index', message: req.flash('message'), activities: result
}

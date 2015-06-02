require! []
require! moment

activity = require('../../dao/activity/init')
team = require('../../dao/team/init')

module.exports = {
    get-all-activities: (req, res) ->
        activity.get-all-activities (err, result) ->
            if err
                console.log err
            else
                #console.log result
                res.render 'index', message: req.flash('message'), activities: result, user: req.cookies.user

    add-personal-activity: (req, res) ->
        team-info = {
            name: req.param 'name'
            create_time: (moment new Date()).format 'YYYY-MM-DD HH:mm'
            activity_id: 0
        }
        team.add-personal-team team-info, req.cookies.user.id, (err, result) ->
            if err
                console.log err
            else
                res.redirect '/'

}

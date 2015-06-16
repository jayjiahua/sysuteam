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

    get-all-personal-activities: (req, res) ->
        activity.get-all-personal-activities (err, result) ->
            if err
                console.log err
            else
                console.log result
                res.render 'index', message: req.flash('message'), activities: result, user: req.cookies.user

    add-personal-activity: (req, res) ->
        team-info = {
            name: req.param 'name'
            info: req.param 'info'
            create_time: (moment new Date()).format 'YYYY-MM-DD HH:mm'
            activity_id: 0
        }
        # console.log team-info
        team.add-personal-team team-info, req.cookies.user.id, (err, result) ->
            if err
                console.log err
            else
                res.redirect '/'

    add-activity: (req, res) ->
        activity-info = {
            sponsor_id: req.cookies.user.id
            name: req.param 'name'
            start_time: req.param 'start-time'
            end_time: req.param 'end-time'
        }
        console.log activity-info
        activity.add-activity activity-info, (err, result) ->
            if err 
                console.log err
            else 
                res.redirect "/activitydetail/#{result.insert-id}"

    get-one-activity: (req, res, activity-id) ->
        activity.get-activity-by-id activity-id, (err, result) ->
            if err
                console.log err
            else 
                #console.log result
                res.render 'activity_detail', activity: result[0], user: req.cookies.user
}

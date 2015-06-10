require! []
require! moment

activity = require('../../dao/activity/init')
team = require('../../dao/team/init')


module.exports = {
    get-team-by-id: (req, res, team-id) ->
        team.get-team-by-team-id team-id, (err, result) ->
            hasjoin = false
            for i in result
                if i['user_id'] == req.cookies.user.id
                    hasjoin = true
            console.log result
            res.render 'team_detail', team: result, user: req.cookies.user, hasjoined:hasjoin

    add-teammate: (req, res, info) ->
        team.add-teammate info, (err, result) ->
            if err
                res.send '1'
            else
                res.send '0'

    delete-teammate: (req, res, team-id) ->
        team.delete-teammate-by-id team-id, req.cookies.user.id, (err, result) ->
            if err
                console.log err
                res.send '1'
            else
                res.send '0'

    delete-team: (req, res, team-id) ->
        team.delete-team-by-id team-id, req.cookies.user.id, (err, result) ->
            if err
                console.log err
                res.send '1'
            else
                res.send '0'

    add-team-in-activity: (req, res, activity-id) ->
        team-info = {
            name: req.param 'name'
            info: req.param 'content'
            create_time: (moment new Date()).format 'YYYY-MM-DD HH:mm'
            activity_id: activity-id
        }
        console.log team-info
        team.add-team team-info, req.cookies.user.id, (err, result, insert-id) ->
            if err
                console.log err
            else
                res.redirect "/team/#{insert-id}"
}
require! []

activity = require('../../dao/activity/init')
team = require('../../dao/team/init')

module.exports = {
    get-team-by-id: (req, res, team-id) ->
        team.get-team-by-team-id team-id, (err, result) ->
            hasjoin = false
            for i in result
                if i['user_id'] == req.cookies.user.id
                    hasjoin = true
            res.render 'team_detail', team: result, user: req.cookies.user, hasjoined:hasjoin

    add-teammate: (req, res, info) ->
        team.add-teammate info, (err, result) ->
            if err
                res.send '1'
            else
                res.send '0'
}
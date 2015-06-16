require! []

conn = require('../../conf/db').conn

module.exports = {
    get-teams-by-activity-id: (activity-id, callback) ->
        sql = "SELECT * FROM ?? WHERE activity_id = ?"
        inserts = ['Teamer', conn.escape(activity-id)]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result, fields) ->
            callback err, result

    get-team-by-team-id: (team-id, callback) ->
        sql = "SELECT * FROM ?? t,?? u  WHERE t.id = ? and t.id = u.team_id"
        inserts = ['Teamer', 'Team_user_role', conn.escape(team-id)]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result, fields) ->
            console.log result
            callback err, result    



    add-team: (team-info, user-id, callback) ->
        sql = "INSERT INTO ?? SET ?"
        inserts = ['Teamer', team-info]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result, fields) ->
            insert-id = result.insert-id
            sql2 = "INSERT INTO Team_user_role(team_id, user_id, role) VALUES (#{result.insert-id}, #{user-id}, 1)"
            console.log "SQL语句："+sql2
            conn.query sql2, (err, result, fields) ->
                callback err, result, insert-id

    add-personal-team: (team-info, user-id, callback) ->
        sql = "INSERT INTO ?? SET ?"
        inserts = ['Teamer', team-info]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result, fields) ->
            sql2 = "INSERT INTO Team_user_role(team_id, user_id, role) VALUES (#{result.insert-id}, #{user-id}, 1)"
            console.log "SQL语句："+sql2
            conn.query sql2, (err, result, fields) ->
                callback err, result    

    update-team-by-id: (team-id, update-infor, callback) ->
        # update-info = {name: 'yoxi', info: 'come on'}
        sql = "UPDATE ?? SET ? WHERE ?? = ?"
        inserts = ['Teamer', update-infor, 'id', team-id]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result) ->
            callback err, result

    get-users-in-team: (team-id, callback) ->
        sql = "SELECT * FROM ?? as t, ?? as u WHERE t.team_id = ? AND t.user_id = u.id"
        inserts = ['Team_user_role', 'Users', conn.escape(team-id)]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result) ->
            callback err, result

    delete-team-by-id: (team-id, user-id, callback) ->
        sql = "DELETE t FROM Teamer t, Team_user_role tr WHERE t.id = ? AND tr.user_id = ? AND tr.team_id = ? AND tr.role = 1"
        inserts = [conn.escape(team-id), conn.escape(user-id), conn.escape(team-id)]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result) ->
            callback err, result

    delete-teammate-by-id: (team-id, user-id, callback) ->
        sql = "DELETE FROM ?? WHERE team_id = ? AND user_id = ?"
        inserts = ['Team_user_role', conn.escape(team-id), conn.escape(user-id)]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result) ->
            callback err, result

    add-teammate: (info, callback) ->
        sql = "INSERT INTO ?? SET ?"
        inserts = ['Team_user_role', info]
        sql = conn.format sql, inserts
        console.log "SQL语句："+sql
        conn.query sql, (err, result, fields) ->
            callback err, result    
}
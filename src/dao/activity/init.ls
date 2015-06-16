require! []

conn = require('../../conf/db').conn
team = require '../team/init'

module.exports = {
	add-activity: (activity-info, callback) ->
		# activity-info = {name: "yuepao", content: "eeeeeeeeeeeeeeee", start_time: "2015-06-01", end_time: "2015-06-02"}
		sql = "INSERT INTO ?? SET ?"
		inserts = ['Activities', activity-info]
		sql = conn.format sql, inserts
		console.log "SQL语句："+sql
		conn.query sql, (err, result, fields) ->
			callback err, result    

	#add-personal-activity: (activity-info, user-id, callback) ->
	#	sql = "INSERT INTO ?? SET ? ; SELECT last_insert_id();"
	#	inserts = ['Activities', activity-info]
	#	sql = conn.format sql, inserts
	#	console.log "SQL语句："+sql
	#	conn.query sql, (err, result, fields) ->
	#		console.log result
	#		add-team result.last_insert_id, activity-info, user-id, callback

	get-all-activities: (callback) ->
		sql = "SELECT * FROM ?? WHERE id != 0"
		inserts = ['Activities']
		sql = conn.format sql, inserts
		console.log "SQL语句："+sql
		conn.query sql, (err, result, fields) ->
			callback err, result

	get-all-personal-activities: (callback) ->
		#sql = "SELECT * FROM Teamer WHERE activity_id = 0"
		sql = "SELECT t.name, t.create_time, u.username, tr.team_id FROM Teamer as t, Users as u, Team_user_role as tr WHERE t.activity_id = 0 AND t.id = tr.team_id AND tr.user_id = u.id AND tr.role = 1"
		console.log "SQL语句："+sql
		conn.query sql, (err, result, fields) ->
			callback err, result

	get-activity-by-id: (activity-id, callback) ->
		sql = "SELECT * FROM Activities WHERE id = ?"
		inserts = [conn.escape(activity-id)]
		sql = conn.format sql, inserts
		console.log "SQL语句："+sql
		conn.query sql, (err, result, fields) ->
			callback err, result

	update-activity-by-id: (activity-id, update-info, callback) ->
		# update-info = {name: "sssss", content: "yoyoyo", start_time: "2015-06-02", end_time: "2015-06-03"}
		sql = "UPDATE ?? SET ? WHERE ?? = ?"
		inserts = ['Activities', update-info, 'id', activity-id]
		sql = conn.format sql, inserts
		console.log "SQL语句："+sql
		conn.query sql, (err, result) ->
			callback err, result

	delete-activity-by-id: (activity-id, callback) ->
		#
		sql = "DELETE FROM Activities WHERE activity_id = ?"
		inserts = [conn.escape(activity-id)]
		sql = conn.format sql, inserts
		console.log "SQL语句："+sql
		conn.query sql, (err, result) ->
			callback err, result
}
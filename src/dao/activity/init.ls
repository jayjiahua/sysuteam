require! []

conn = require('../../conf/db').conn

module.exports = {
	add-activity: (activity-info, callback) ->
		# activity-info = {name: "yuepao", content: "eeeeeeeeeeeeeeee", start_time: "2015-06-01", end_time: "2015-06-02"}
		sql = "INSERT INTO ?? SET ?"
		inserts = ['Activities', activity-info]
		sql = conn.format sql, inserts
		console.log "SQL语句："+sql
		conn.query sql, (err, result, fields) ->
			callback err, result    

	get-all-activities: (callback) ->
		sql = "SELECT * FROM ??"
		inserts = ['Activities']
		sql = conn.format sql, inserts
		console.log "SQL语句："+sql
		conn.query sql, (err, result, fields) ->
			callback err, result

	get-activity-by-id: (activity-id, callback) ->
		sql = "SELECT * FROM ?? WHRER id = ?"
		inserts = ['Activities', conn.escape(activity-id)]
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
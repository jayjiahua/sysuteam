(function(){
  var mongoose, Team;
  mongoose = require('mongoose');
  Team = require('./team');
  module.exports = mongoose.model('Activity', {
    theme: String,
    detail: String,
    deadline: String,
    min_member_num: Number,
    max_member_num: Number,
    teams: [{
      type: mongoose.Schema.ObjectId,
      ref: Team
    }],
    type: String
  });
}).call(this);

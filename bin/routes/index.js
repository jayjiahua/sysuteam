(function(){
  var express, User, Team, Activity, router;
  express = require('express');
  User = require('../models/user');
  Team = require('../models/team');
  Activity = require('../models/activity');
  router = express.Router();
  module.exports = function(user, team, activity){
    return router.get('/', function(req, res){
      res.render('index', {
        message: req.flash('message')
      });
    });
  };
}).call(this);

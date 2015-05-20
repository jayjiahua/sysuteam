(function(){
  var express, http, path, multer, cookieParser, bodyParser, mongoose, expressSession, db, logger, flash, favicon, app, server, user, team, activity, routes, exports;
  express = require('express');
  http = require('http');
  path = require('path');
  multer = require('multer');
  cookieParser = require('cookie-parser');
  bodyParser = require('body-parser');
  mongoose = require('mongoose');
  expressSession = require('express-session');
  db = require('./db');
  logger = require('morgan');
  flash = require('connect-flash');
  favicon = require('static-favicon');
  mongoose.connect(db.url);
  app = express();
  server = http.createServer(app);
  app.set('views', path.join(__dirname, 'views'));
  app.set('view engine', 'jade');
  app.use(favicon());
  app.use(logger('dev'));
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded());
  app.use(cookieParser());
  app.use(express['static'](path.join(__dirname, 'public')));
  app.use(expressSession({
    secret: 'mySecretKey'
  }));
  app.use(flash());
  user = require('./modules/user/init');
  team = require('./modules/team/init');
  activity = require('./modules/activity/init');
  routes = require('./routes/index')(user, team, activity);
  app.use('/', routes);
  app.use(function(req, res, next){
    var err;
    err = new Error('Not Found');
    err.status = 404;
    return next(err);
  });
  if (app.get('env') === 'development') {
    app.use(function(err, req, res, next){
      res.status(err.status || 500);
      return res.render('error', {
        message: err.message,
        error: err
      });
    });
  }
  exports = module.exports = server;
  exports.use = function(){
    return app.use.apply(app, arguments);
  };
}).call(this);

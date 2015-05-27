require! {express, http, path, multer, 'cookie-parser', 'body-parser', mongoose, 'express-session'}
logger = require 'morgan'
flash = require 'connect-flash'
favicon = require 'static-favicon'


app = express!
server = http.create-server app

app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'jade'

app.use favicon!
app.use logger 'dev'
app.use bodyParser.json!
app.use bodyParser.urlencoded!
app.use cookieParser!
app.use express.static path.join __dirname, 'public'
app.use expressSession {secret: 'mySecretKey'}
app.use flash!

user = require './modules/user/init'
team = require './modules/team/init'
activity = require './modules/activity/init'

routes = (require './routes/index') user, team, activity
app.use '/', routes

app.use (req, res, next) ->
  err = new Error 'Not Found'
  err.status = 404
  next err

if (app.get 'env') is 'development' then app.use (err, req, res, next) ->
  res.status err.status || 500
  res.render 'error', {
    err.message
    error: err
  }

exports = module.exports = server
exports.use = -> app.use.apply app, &  
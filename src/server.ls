require! {express, http, path, multer, 'cookie-parser', 'body-parser', mongoose, 'express-session'}
logger = require 'morgan'
flash = require 'connect-flash'
favicon = require 'static-favicon'
ueditor = require 'ueditor'

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

#Ueditor图片设置
app.use "/ueditor/ue", ueditor path.join(__dirname, 'public'), (req, res, next) ->
    # 发起上传图片请求
    if req.query.action is 'uploadimage'
        foo = req.ueditor
        imgname = req.ueditor.filename
        img_url = '/images/ueditor/' 
        #输入要保存的地址
        res.ue_up img_url

    # 客户端发起图片列表请求
    else if req.query.action is 'listimage'
        dir_url = '/images/ueditor/'
        # 客户端会列出 dir_url 目录下的所有图片
        res.ue_list dir_url 
    # 客户端发起其它请求
    else
        res.setHeader 'Content-Type', 'application/json'
        res.redirect '/ueditor/nodejs/config.json'

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
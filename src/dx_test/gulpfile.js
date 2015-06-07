var gulp = require('gulp');
var plugins = require('gulp-load-plugins')();
var path = require('path');

// Jade to html
gulp.task('jade', function() {
  return gulp.src('./jade/*.jade')
    .pipe(plugins.jade({
      pretty: true
    }))
    .pipe(gulp.dest('./dist'));
})

// Sass to CSS
gulp.task('sass', function() {
  gulp.src('./sass/*.scss')
    .pipe(plugins.sourcemaps.init())
      .pipe(plugins.sass().on('error', plugins.sass.logError))
    .pipe(plugins.sourcemaps.write())
    .pipe(gulp.dest('./dist/css'));
})


// livescript to javascript
gulp.task('livescript', function() {
  return gulp.src('./ls/*.ls')
    .pipe(plugins.livescript({bare: true}))
    .pipe(gulp.dest('./dist/js'));
})

// Static
gulp.task('public', function() {
  return gulp.src('./public/**/*', {
    base: 'public'
  })
    .pipe(gulp.dest('./dist/public/'));
});

gulp.task('watch', function() {
  gulp.watch(['./jade/**/*.jade'], ['jade']);
  gulp.watch('./sass/*.scss', ['sass']);
  gulp.watch('./ls/*.ls', ['livescript']);
});

gulp.task('clean', function() {
  gulp.src(['./dist/css/*', './dist/*.html'], {read:false})
    .pipe(plugins.clean());
})

gulp.task('build', ['jade', 'sass', 'livescript', 'public']);

gulp.task('default', ['clean', 'build', 'watch']);
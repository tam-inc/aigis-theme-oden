gulp             = require 'gulp'
plumber          = require 'gulp-plumber'
sass             = require 'gulp-sass'
sourcemaps       = require 'gulp-sourcemaps'
pleeease         = require 'gulp-pleeease'
aigis            = require 'gulp-aigis'
browserSync      = require 'browser-sync'


#
# stylesheet
#
gulp.task 'styles', ->
  gulp.src './tam-aigis-theme/styles/*.scss'
    .pipe plumber()
    .pipe sourcemaps.init()
    .pipe sass().on 'error', sass.logError
    .pipe pleeease()
    .pipe sourcemaps.write '.'
    .pipe gulp.dest './tam-aigis-theme/assets/'
    .on 'end', ->
      gulp.src 'aigis_config.yml'
        .pipe aigis()


#
# build assets
#
gulp.task 'build', ['styles']


#
# watch
#
gulp.task 'watch', ->
  gulp.watch './tam-aigis-theme/**/*.scss', ['styles']


#
# start BrowserSync / LiveReload
#
gulp.task 'serve', ['watch'], ->
  browserSync
    notify: false,
    port: 9000,
    server:
      baseDir: '.'

  gulp.watch [
    '**/!(._)*.php'
    '**/!(._)*.html'
    'assets/!(._)**/*.js'
    'assets/!(._)**/*.css'
  ]
  .on 'change', browserSync.reload


gulp.task 'default', ['build', 'serve']

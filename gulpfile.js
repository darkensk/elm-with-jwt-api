const gulp = require("gulp");
const elm = require("gulp-elm");
const gutil = require("gulp-util");
// var plumber = require("gulp-plumber");
const connect = require("gulp-connect");

// File paths
var paths = {
  dest: "dist",
  elm: "src/*.elm",
  static: "src/*.{html,css}",
};

// Compile Elm
function compileElm() {
  return gulp
    .src(paths.elm)
    .pipe(elm({ optimize: true }))
    .pipe(gulp.dest(paths.dest));
}
// gulp.task("elm", function () {
//   return (
//     gulp
//       .src(paths.elm)
//       // .pipe(plumber())
//       .pipe(elm({ optimize: true }))
//       .pipe(gulp.dest(paths.dest))
//   );
// });

// Move static assets to dist
function prepareStatic() {
  return gulp.src(paths.static).pipe(gulp.dest(paths.dest));
}
// gulp.task("static", function () {
//   return (
//     gulp
//       .src(paths.static)
//       .pipe(plumber())
//       //
//       .pipe(gulp.dest(paths.dest))
//   );
// });

// Watch for changes and compile
function watchFiles() {
  gulp.watch(paths.elm, compileElm);
  gulp.watch(paths.static, prepareStatic);
}
// gulp.task("watch", function () {
//   gulp.watch(paths.elm, ["elm"]);
//   gulp.watch(paths.static, ["static"]);
// });

// Local server
function connectServer() {
  return connect.server({ root: "dist", port: 3000 });
}
// gulp.task("connect", function () {
//   connect.server({
//     root: "dist",
//     port: 3000,
//   });
// });

// Main gulp tasks
// gulp.task("build", ["elm", "static"]);
// gulp.task("default", ["connect", "build", "watch"]);

// Define main gulp tasks
const buildElm = gulp.series(compileElm, prepareStatic);

const buildDefault = gulp.parallel(connectServer, buildElm, watchFiles);

// expose tasks to CLI
exports.build = buildElm;
exports.default = buildDefault;

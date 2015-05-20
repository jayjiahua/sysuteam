module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  path = require('path')
  pkg = grunt.file.readJSON("package.json")

  DEBUG = false # 添加测试所需代码，发布时应该为false

  grunt.initConfig 
    pkg: pkg
    meta:
      banner: "/**\n" + " * <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today(\"yyyy-mm-dd\") %>\n" + " * <%= pkg.homepage %>\n" + " *\n" + " * Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author %>\n" + " * Licensed <%= pkg.licenses.type %> <<%= pkg.licenses.url %>>\n" + " */\n"

    changelog:
      options:
        dest: "CHANGELOG.md"
        template: "changelog.tpl"

    bump:
      options:
        files: ["package.json", "bower.json"]
        commit: true
        commitMessage: "chore(release): v%VERSION%"
        commitFiles: ["-a"]
        createTag: true
        tagName: "v%VERSION%"
        tagMessage: "Version %VERSION%"
        push: true
        pushTo: "origin"

    clean: 
      bin:
        dot: true
        files:
          src: [
            "bin/*"
            ".temp"
          ]

    copy:
      appCode:
        files: [
          src: ["**/*.*", "!**/**.{ls,sass}"]
          dest: "bin/"
          cwd: "src/"
          expand: true
        ]

    concat:
      build_css:
        src: [
          "bin/**/*.css"
          "!bin/<%= pkg.name %>*.css"
          "!bin/vendor/**/*.css"
          "!bin/tests/**/*.css"
          "!bin/**/debug.css"
        ]
        dest: "bin/<%= pkg.name %>-<%= pkg.version %>.css"

    livescript:
      options:
        bare: false
      all:
        expand: true
        # flatten: true
        cwd: "src/"
        src: ['**/**.ls']
        dest: "bin/"
        ext: ".js"

    sass:
      options:
        includePaths: require('node-bourbon').with('src/common/sass')
      build:
        files: [
          src: ["**/*.sass"]
          dest: "bin/"
          cwd: "src/"
          expand: true
          ext: ".css"
        ]

    express:
      dev:
        options:
          server: path.resolve('bin/server.js')
          bases: [path.resolve('bin')]
          livereload: true
          serverreload: false
          port: 5000

    delta:
      options:
        livereload: false

      livescript:
        files: ["src/**/*.ls"]
        tasks: ["newer:livescript"]

      sass:
        files: ["src/**/*.sass"]
        tasks: ["newer:sass", "concat"]

      appCode:
        files: ["src/**/*.*", "!src/**/**.{ls,sass}"]
        tasks: ["newer:copy:appCode"]

      express:
        files: ["bin/**/*.*", "!bin/vendor/**/*"]
        tasks: []
        options:
          livereload: true

      grunt:
        files: ['Gruntfile.coffee']

 
  grunt.renameTask "watch", "delta"

  grunt.registerTask "watch", [
    "clean"
    "build"
    "express"
    "delta"
  ]

  grunt.registerTask "default", [
    "build"
  ]

  grunt.registerTask "build", [
    "livescript"
    "sass"
    "copy"
  ]
  
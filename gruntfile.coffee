module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    meta:      
      banner: """
      /*  
       *  <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("d/m/yyyy") %>
       *  
       *  Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>
       *  Released under the <%=pkg.license%> license
      */

      """
    src:
      coffee : [
        "src/js/*.coffee"] 
      stylus : [
        "src/css/*.styl"]
      jade   : [
        "src/html/app.jade"]
      jade_files : [
        "src/html/*.jade"]
      manifest: [
        "src/manifest.json"]

    dependencies :
      js : []              

    jade : 
      build:
        options:
          data:
            debug : true
          pretty: false
        files:
          "build/index.html" : "<%=src.jade%>"
    
    concat : 
      coffee : 
        files :
          ".tmp/coffee/tmp.coffee" : "<%=src.coffee%>"
      manifest :
        files : 
          "build/manifest.json" : "<%=src.manifest%>"

    coffee:
      build:
        files:          
          'build/js/<%=pkg.name%>.debug.js' : '.tmp/coffee/tmp.coffee'

    stylus:
      tmp:
        options: 
          compress: true
        files:
          'build/css/<%=pkg.name%>.css' : '<%=src.stylus%>'

    uglify:
      options:
        banner: '<%= meta.banner %>'
      build:
        files:          
          'build/js/<%=pkg.name%>.js' : ['build/js/<%=pkg.name%>.debug.js']

    watch :
      main : 
        files : ["gruntfile.coffee"] 
        tasks : ["default"]
      coffee :
        files : ["<%=src.coffee%>"]
        tasks : ["concat","coffee", "uglify"]
      stylus : 
        files : ["<%=src.stylus%>"] 
        tasks : ["stylus"]
      jade : 
        files : ["<%=src.jade%>","<%=src.jade_files%>"]
        tasks : ["jade"]
      manifest : 
        files : ["<%=src.manifest%>"]
        tasks : ["concat"]


  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-stylus"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-concat"
  grunt.loadNpmTasks "grunt-contrib-watch"

  grunt.registerTask "default", [ "stylus", "concat", "coffee", "uglify", "jade" ] #watch can be executed with "grunt watch"
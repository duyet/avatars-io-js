/*global module:false*/
module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  
  // Project configuration.
  grunt.initConfig({
    meta: {
      version: '0.1.2',
      banner: '/*! Avatars.io - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '* http://github.com/chute/avatars-io-js/\n' +
        '* Copyright (c) <%= grunt.template.today("yyyy") %> ' +
        'Chute; Licensed MIT */'
    },
    concat: {
      dist: {
        src: ['<banner:meta.banner>', 'lib/ajaxupload.js', 'lib/easyXDM.js', 'src/avatars.io.js'],
        dest: 'dist/avatars.io.js'
      }
    },
    uglify: {
      dist: {
        files: {
          'dist/avatars.io.min.js': ['dist/avatars.io.js']
        }
      }
    },
    watch: {
      files: ['lib/ajaxupload.js', 'lib/easyXDM.js', 'src/avatars.io.js'],
      tasks: ['concat', 'uglify']
    }
  });

  // Default task.
  grunt.registerTask('default', ['concat', 'uglify']);

};

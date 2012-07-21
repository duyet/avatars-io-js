/*global module:false*/
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    meta: {
      version: '0.1.0',
      banner: '/*! Avatars.io - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '* http://github.com/chute/avatars-io-js/\n' +
        '* Copyright (c) <%= grunt.template.today("yyyy") %> ' +
        'Vadim Demedes; Licensed MIT */'
    },
    concat: {
      dist: {
        src: ['<banner:meta.banner>', 'vendor/ajaxupload.js', 'vendor/easyXDM.js', '<file_strip_banner:src/avatars.io.js>'],
        dest: 'dist/avatars.io.js'
      }
    },
    min: {
      dist: {
        src: ['<banner:meta.banner>', '<config:concat.dist.dest>'],
        dest: 'dist/avatars.io.min.js'
      }
    },
    watch: {
      files: ['vendor/ajaxupload.js', 'vendor/easyXDM.js', 'src/avatars.io.js'],
      tasks: 'concat min'
    },
    uglify: {}
  });

  // Default task.
  grunt.registerTask('default', 'concat min');

};

/*global module:false*/
module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    meta: {
      version: '0.1.0',
      banner: '/*! AIOUploader - v<%= meta.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '* http://github.com/chute/avatars-io-js/\n' +
        '* Copyright (c) <%= grunt.template.today("yyyy") %> ' +
        'Vadim Demedes; Licensed MIT */'
    },
    concat: {
      dist: {
        src: ['<banner:meta.banner>', 'vendor/ajaxupload.js', '<file_strip_banner:src/aio.js>'],
        dest: 'dist/aio.js'
      }
    },
    min: {
      dist: {
        src: ['<banner:meta.banner>', '<config:concat.dist.dest>'],
        dest: 'dist/aio.min.js'
      }
    },
    watch: {
      files: ['vendor/ajaxupload.js', 'src/aio.js'],
      tasks: 'concat min'
    },
    uglify: {}
  });

  // Default task.
  grunt.registerTask('default', 'concat min');

};

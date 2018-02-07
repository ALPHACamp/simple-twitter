// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree 

//= require jquery
//= require bootstrap-sprockets

$(document).on('turbolinks:load', function() {

  $('button.following-state').hover(function(){
    $(this).css('background', 'red');
    $(this).text('Unfollow');
    }, function(){
    $(this).css('background', 'var(--mblue)');
    $(this).text('Following');
  }); // end following button hover

  $('.tweet-info .edit-tweet-btn').on('click', function(e) {
    e.preventDefault();
    $(this).parents('.show-area').css('display', 'none');
    $(this).parents('.tweet-info').children('.edit-tweet-form').css('display', 'block');
  
  });

  $('.edit-tweet-form .btn-danger').on('click', function(e) {
    e.preventDefault();
    $(this).parents('.tweet-info').children('.show-area').css('display', 'grid')
    $(this).parents('.edit-tweet-form').css('display', 'none');
  });

});
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'turbolinks:load', ->
  $('#post-labels').tagit
    fieldName: 'post[label_list]'
    singleField: true
  $('#post-labels').tagit()
  label_string = $("#label_hidden").val()
  try
    label_list = label_string.split(',')
    for tag in label_list
      $('#post-labels').tagit 'createTag', tag
  catch error
  hidden_music_type = $('input:hidden[name="post[hidden_music_type]"]').val();
  $('#post_music_type').val(hidden_music_type)
  hidden_genre = $('input:hidden[name="post[hidden_genre]"]').val();
  $('#post_genre').val(hidden_genre)

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@addCategory = () ->
  catId = $('select#categoryselect').val()
  catName = $('select#categoryselect  option:selected').text()
  $('select#categoryselect  option:selected').remove()
  $('div.categorylist').append('<span class="element"><span>'+catName+'</span><input type="hidden" value="'+catId+'" name="question[category_ids][]"></span>')

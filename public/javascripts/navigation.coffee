$(document).ready ->

  navigation = $('#navigation')
  navigation.append $('<div class="item">') for n in [1..25]
  navigation.children().first().addClass 'first'
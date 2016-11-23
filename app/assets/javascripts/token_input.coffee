#= require jquery-tokeninput/jquery.tokeninput.js

class @TagTokenField
  constructor: (form)->
    $(form).tokenInput '/users/skills.json',
    theme: 'custom'
    prePopulate: $(form).data('load')
    resultsFormatter: (skill) ->
      "<li>#{skill.name}(#{skill.taggings_count})</li>"

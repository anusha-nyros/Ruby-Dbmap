//= require jquery-ui
//= require jquery_ujs
//= require_tree .
//= require bootstrap-alert

#// require bootstrap-transition
#// require bootstrap-button
#// require bootstrap-carousel
#// require bootstrap-collapse
//= require bootstrap-dropdown
#// require bootstrap-modal
#// require bootstrap-scrollspy
//= require bootstrap-tab
//= require bootstrap-tooltip
//= require bootstrap-popover
#// require bootstrap-typeahead
//= require fancybox
//= require jquery_treeview

jQuery ->
  $('#notifications').delay(2500).slideUp('fast')
  $('#advance-search').live 'click', ->
    $('#advance-search-form').toggle()
    $('#simple-search-form').toggle()  



jQuery ->
  $('#pattern_user_tokens').tokenInput('/users.json', {
    crossDomain: false
    preventDuplicates: true
    })
  

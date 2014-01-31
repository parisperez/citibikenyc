  $(document).ready ->
  
  #Convert address tags to google map links - Copyright Michael Jasper 2011
  $("address").each ->
    link = "<a href='http://maps.google.com/maps?q=" + encodeURIComponent($(this).text()) + "' target='_blank'>" + $(this).text() + "</a>"
    $(this).html link

  $(".collapse").collapse()

  $(document).ready ->
  $(".dropdown-toggle").dropdown()


jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

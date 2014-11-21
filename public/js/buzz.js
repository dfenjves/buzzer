$( document ).ready(function() {
  console.log( "ready!" );
  $( "#buzz" ).click(function() {
      $.post("insert post url here", 
        { 
          args: "BUZZ"
      });
  });
});
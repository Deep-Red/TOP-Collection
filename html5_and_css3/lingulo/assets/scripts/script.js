$(document).ready {

$(function() {
  $('slides').slidesjs({
    height: 235,
    navigation: false,
    pagination: false,
    effect: {
      fade: {
        speed: 400
      }
    },callback:
    {
      start: function(number)
      {
        $("slider_content1,#slider_content2,#slider_content3").fadeOut(500);
      },
      complete: function(number)
      {
        $("#slider_content" + number).delay(500).fadeIn(1000);
      }
    },
    play:
    {
      active: false,
      auto: true,
      interval: 6000,
      pauseOnHover: false
    }
  });
});

$("#alternative_menu").change(function()
{
  $selected = $("#alternative_menu option:selected");
  window.location.href = "http://www.lingulo.com/" + $selected.val();
});

}

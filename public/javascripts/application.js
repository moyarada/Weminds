var post_on = {
    facebook : false,
    twitter : false
};
var sendQuestion = function(question) {  
       console.log(question, post_on);
   };
   
$(document).ready(function(){
    
    
    //$("#header ul").lavaLamp({speed: 300 });
    $(".lavaLamp").lavaLamp({speed: 200});
    //console.log($.cookie('fb_button_state'));
    
    if ($.cookie('fb_button_state') === 'true') {
    //    console.log('addClass');
        $('#fb_button').addClass('fdown');
        post_on.facebook = true;
    } else {
    //    console.log('removeClass');
        $('#fb_button').removeClass('fdown');
        post_on.facebook = false;
    }
    
    $('#fb_button').click(function(){
            $(this).toggleClass("fdown");
            if ($(this).hasClass('fdown')) {
                $.cookie('fb_button_state', 'true');
                post_on.facebook = true;
            } else {
                $.cookie('fb_button_state', 'false');
                post_on.facebook = false;
            }
    });
    
    if ($.cookie('tw_button_state') === 'true') {
      //     console.log('addClass');
           $('#tw_button').addClass('tdown');
           post_on.twitter = true;
       } else {
    //       console.log('removeClass');
           $('#tw_button').removeClass('tdown');
           post_on.twitter = false;
       }
    
    $('#tw_button').click(function(){
            $(this).toggleClass("tdown");
            if ($(this).hasClass('tdown')) {
                $.cookie('tw_button_state', 'true');
                post_on.twitter = true;
            } else {
                $.cookie('tw_button_state', 'false');
                post_on.twitter = false;
            }
    });
    
   
    
});
$(function(){
    // 언어선택 창에 해당 언어를 active 시칸다
    $(".languages").find('li').each(function(){
        var text = $(this).data('text');
        if(lang ==  $(this).data('language')){
            $(this).addClass('active');
            $(this).find('a').html( text + '<i class="fa fa-check"></i>' );
        }else{
            $(this).find('a').html( text );
        }
    })
    // 언어 태크마다 해당 언어를 변환시킨다.
    $('lang').each(function(){
       if($(this).data('text')){
           $(this).html(message.msg($(this).data('text')));
       }
    });
})

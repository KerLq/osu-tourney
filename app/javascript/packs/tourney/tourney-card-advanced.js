window.onload = function() {
    var clicked = false;
    $(".tourney-card-advanced").mouseover(function() {
        if (!clicked) {
            $(".tourney-card-advanced").css({"transition": "", "transform": ""});
            $(this).css({"transition": "transform 0.5s ease", "transform": "translateY(-10px)"});
        }
    }).mouseout(function() {
        if (!clicked) {
            $(".tourney-card-advanced").css({"transition": "", "transform": ""});
            $(this).css({"transition": "transform 0.5s ease", "transform": "translateY(0px)"});
        } 
    });
    $(".tourney-card-advanced").click(function() {
        if (clicked) {
            clicked = false;
            $(".tourney-card-advanced").css({"transition": "", "transform": ""});
            $(this).css({"transition": "transform 0.5s ease", "transform": "scale(1, 1) "});
        } else {
            clicked = true;
            $(".tourney-card-advanced").css({"transition": "", "transform": ""});
            $(this).css({"transition": "transform 0.5s ease", "transform": "scale(3, 3) translateY(30px)" });
        }
    });
};
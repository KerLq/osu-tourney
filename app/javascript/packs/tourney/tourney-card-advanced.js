$(document).ready(function() {
    var i = 0;
    var fullScreenHeight = $(window).height();
    var divHeight = 200;

    $('.tourney-card-advanced').each(function() {
        setPosition(this);
    });
    function setPosition(elem) {
        const rect = elem.getBoundingClientRect()
        $(elem).css({"top": rect.top, "left": rect.left })
        i++;
        console.log(rect);
    }
    function getPosition(elem){
        const rect = elem.getBoundingClientRect()
        return {
            top: rect.top,
            left: rect.left,
            width: rect.width,
            height: rect.height
        }
    }
    
    function toPx(val){
        return [val, 'px'].join('')
    }
    $(document).on("click", ".tourney-card-advanced", function() {
        if(this.classList.contains('fullScreen')){
            if ($(this).height() == fullScreenHeight) {
                this.classList.remove('fullScreen')
                this.classList.remove('tourney-card-advanced--active')
                setTimeout(e => this.style.position = 'static', 1000)
                $(this).css('height', '200px')
                //close
                //$(".tourney-card-advanced").css({"transition": "", "transform": ""});
                //$(this).css({"transition": "transform 0.5s ease", "transform": "scale(1, 1) "});
                console.log("Current Div: " + $(this).height())
            }

        } else {
            console.log("Clicked");
            //clicked = true;
            //$(".tourney-card-advanced").css({"transition": "", "transform": ""});
            //$(this).css({"transition": "transform 0.5s ease", "transform": "scale(3, 3) translate(50%, 50%)" });
            //$(this).toggleClass("fullScreen");
            if ($(this).height() == divHeight ) {

                let pos = getPosition(this)
                this.style.width = toPx(pos.width)
                this.style.height = toPx(pos.height)
                this.style.top = toPx(pos.top)
                this.style.left = toPx(pos.left)
                console.log(pos)
                this.classList.add('fullScreen')
                this.classList.add('tourney-card-advanced--active')
                this.style.position = 'fixed'
                console.log("Current Div: " + $(this).height())
            }
        }
    });
});
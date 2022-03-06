window.onload = function() {

    // const button = document.getElementsByClassName("navbar__hamburger")[0];
    // const div = document.getElementsByClassName("navbar__links")[0];
    
    // button.addEventListener("click", () => {
    //     div.classList.toggle("active");
    // });
    $header = $(".main-header");
    $burger = $(".main-navbar__burger-menu");
    $list = $(".main-navbar__list");
    $(".main-navbar__burger-menu").click(function() {
        $list.toggleClass("main-navbar__list--active");
        $header.toggleClass("main-header--active");
        if ($burger.hasClass("main-navbar__burger-menu--animation") && !$burger.hasClass("main-navbar__burger-menu--reverse-animation")) {
            $burger.toggleClass("main-navbar__burger-menu--animation");
            $burger.addClass("main-navbar__burger-menu--reverse-animation");
            return;
        } else if ($burger.hasClass("main-navbar__burger-menu--reverse-animation")) {
            $burger.toggleClass("main-navbar__burger-menu--reverse-animation");
            $burger.addClass("main-navbar__burger-menu--animation");

            return;
        }
        $burger.toggleClass("main-navbar__burger-menu--animation");

        
    });
}
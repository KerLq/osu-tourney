window.onload = function() {

    // const button = document.getElementsByClassName("navbar__hamburger")[0];
    // const div = document.getElementsByClassName("navbar__links")[0];
    
    // button.addEventListener("click", () => {
    //     div.classList.toggle("active");
    // });
    $burger = $(".navbar__hamburger");
    $links = $(".navbar__links");
    $(".navbar__hamburger").click(function() {
        $links.toggleClass("navbar__links--active");

        if ($burger.hasClass("navbar__hamburger--animation") && !$burger.hasClass("navbar__hamburger--reverse-animation")) {
            $burger.toggleClass("navbar__hamburger--animation");
            $burger.addClass("navbar__hamburger--reverse-animation");
            return;
        } else if ($burger.hasClass("navbar__hamburger--reverse-animation")) {
            $burger.toggleClass("navbar__hamburger--reverse-animation");
            $burger.addClass("navbar__hamburger--animation");

            return;
        }
        $burger.toggleClass("navbar__hamburger--animation");

        
    });
}
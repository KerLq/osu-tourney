window.onload = function() {

    // const button = document.getElementsByClassName("navbar__hamburger")[0];
    // const div = document.getElementsByClassName("navbar__links")[0];
    
    // button.addEventListener("click", () => {
    //     div.classList.toggle("active");
    // });

    $(".navbar__hamburger").click(function() {
        $(".navbar__links").toggleClass("navbar__links--active");
    });
}
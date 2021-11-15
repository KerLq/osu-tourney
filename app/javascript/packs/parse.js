window.onload = function() {
    $('.parse').click(function() {
        for (let x = 0; x < 60; x++) {
            if (x >= 10) {
                $.ajax({
                    url: "http://alloworigin.com/get?url=https://osu.ppy.sh/community/matches/8930" + x + "00&tor=1",
                    type: 'GET',
                    dataType: 'json', // added data type
                    success: function(res) {
                        console.log(res);
                    }
                });
            } else {
                $.ajax({
                    url: "http://alloworigin.com/get?url=https://osu.ppy.sh/community/matches/8930" + x + "000&tor=1",
                    type: 'GET',
                    dataType: 'json', // added data type
                    success: function(res) {
                        console.log(res);
                    }
                });
            }
        }
    
    });
}
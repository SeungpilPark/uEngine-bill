var ContactPage = function () {

    var contentInfo = '<strong>Addr:</strong> 서울시 강남구 논현로 722 4층(논현동 신한빌딩) 135-818<br>'
            + '<strong>E-mail:</strong> sppark@uengine.org<br>'
            + '<strong>Tel:</strong> <a href="tel:+827088063735">(+82) 2-567-8301~4</a><br>'
            + '<strong>Fax:</strong> <a href="fax:+8225563402">(+82) 2-567-8301~4</a><br>'
            + '<strong>HomePage:</strong> http://www.uengine.org<br>';

    return {

        //Basic Map
        initMap: function () {
            var map;
            $(document).ready(function () {
                map = new GMaps({
                    div: '#map',
                    scrollwheel: false,
                    lat: 37.516639,
                    lng: 127.029941,
                    enableNewStyle: true
                });

                var marker = map.addMarker({
                    lat: 37.516639,
                    lng: 127.029941,
                    title: 'Company, Inc.',
                    infoWindow: {
                        content: contentInfo
                    }
                });

                // 이벤트 먹이기 예제
                //google.maps.event.addListener(marker, 'click', function() {
                //    console.log(123123);
                //});

                setTimeout(function () {
                    google.maps.event.trigger(marker, 'click');
                }, 1000);
            });
        },

        //Panorama Map
        initPanorama: function () {
            var panorama;
            $(document).ready(function () {
                panorama = GMaps.createPanorama({
                    el: '#panorama',
                    lat: 37.516639,
                    lng: 127.029941,
                });
            });
        }

    };
}();
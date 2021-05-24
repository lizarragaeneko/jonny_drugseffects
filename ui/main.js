$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){

			var item = event.data;
			if (item !== undefined && item.type === "logo") {

				if (item.display === true) {
					$('#klaene-analgesicos-script').delay(100).fadeIn( "slow" );
				} else if (item.display === false) {
					$('#klaene-analgesicos-script').fadeOut( "slow" );
				}
			}
		});
	};
});

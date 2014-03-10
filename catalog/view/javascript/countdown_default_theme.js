function setCountDown () {
      
	  seconds--;
		  if (seconds < 0){
			  minutes--;
			  seconds = 59
		  }
		  if (minutes < 0){
			  hours--;
			  minutes = 59
		  }
		  if (hours < 0){
			  days--;
			  hours = 23
		  }
      document.getElementById("remain").innerHTML = days+" days, "+hours+" hours, "+minutes+" minutes, "+seconds+" seconds";
	  setTimeout ("setCountDown()", 1000 );
}
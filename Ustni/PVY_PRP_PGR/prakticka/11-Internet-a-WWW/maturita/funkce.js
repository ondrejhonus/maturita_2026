function odmocnina(x,y){
  if (x < 0) return "Chyba: není možná odmocnina ze záporného čísla!"
	if (y == 0) return "Výsledek = 1";
	var vysledek = Math.pow(x,1/y);
	return "Výsledek = " + vysledek;
}

vypocet.addEventListener('...', function() {
	vysledek.innerHTML = odmocnina(x.value, y.value);
})

odstavec.addEventListener('...', function() {
	this.style.backgroundColor = 'yellow';
})


odstavec.addEventListener('...', function() {
	this.style.backgroundColor = 'white';
})

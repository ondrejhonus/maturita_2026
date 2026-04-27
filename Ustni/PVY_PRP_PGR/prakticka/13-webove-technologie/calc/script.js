document.getElementById('vypocet').addEventListener('click', function() {
            
    let x = parseFloat(document.getElementById('x').value);
    let y = parseFloat(document.getElementById('y').value);
    
    let operator = document.querySelector('input[name="operator"]:checked').value;
    let vysledek;

    if (isNaN(x) || isNaN(y)) {
        document.getElementById('vysledek_text').innerHTML = "Chyba: Zadej obě čísla!";
        return; 
    }

    if (operator === '+') {
        vysledek = x + y;
    } else if (operator === '-') {
        vysledek = x - y;
    } else if (operator === '*') {
        vysledek = x * y;
    } else if (operator === '/') {
        if (y === 0) {
            document.getElementById('vysledek_text').innerHTML = "Chyba: Nulou nelze dělit!";
            return;
        }
        vysledek = x / y;
    }

    document.getElementById('vysledek_text').innerHTML = "Výsledek operace = <strong>" + vysledek + "</strong>";
});
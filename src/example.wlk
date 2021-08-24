

object vilma{
		
	var lucidez = 100
	
	method estaDesmayada() {
		return lucidez < 30
	}
	method perderLucidez() {
		lucidez = lucidez - 80	
	}
	
}


object fantasma {
	
	var dondeEsta = buffet
	
	method irA(unLugar){
		dondeEsta = unLugar
	}
	
	method asustar(){
//		dondeEsta.ocupante().perderLucidez()
		dondeEsta.seAsustanTodos()
		
	}
}


object aula {
	
	const ocupante = vilma
	
//	method ocupante() {
//		return ocupante
//	}
	method seAsustanTodos(){
		ocupante.perderlucidez()
	}
	
}

object buffet {
	
	var quienEsta
	var vendedor
	
//	method ocupante() {
//		return quienEsta
//	}
	
	method entra(alguien){
		quienEsta = alguien
	}
	method trabaja(alguien){
		vendedor = alguien
	}
	method seAsustanTodos(){
		quienEsta.perderLucidez()
		vendedor.reaccionar()
	}
}


object shaggy{
    method perderLucidez() {}
    
    method estaDesmayada() {
    	return false
    }
    method reaccionar() {}
}

object dafne {
	
}

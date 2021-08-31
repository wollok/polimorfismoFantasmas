import wollok.game.*



object pantalla {
	
	
	method iniciar() {
      game.height(10)
      game.width(20)
      game.title("fantasmas")
      game.addVisual(vilma)
      game.addVisual(fantasma)
      keyboard.left().onPressDo({vilma.moverseIzquierda() })
      keyboard.right().onPressDo({vilma.moverseDerecha() })
      keyboard.space().onPressDo({vilma.perderLucidez() })
      
      game.onCollideDo(fantasma,{algo => algo.perderLucidez()  })
      
      game.start()
      
	}
	
	
	
}







object vilma{
	
	
	var position = game.center()
	var lucidez = 100
	
	method estaDesmayada() {
		return lucidez < 30
	}
	method perderLucidez() {
		lucidez = lucidez - 80	
		10.times( {x =>	
			self.moverseDerecha()
			game.schedule( x*x*20, {self.moverseIzquierda()})
			})
	}
	
	method position(){
		return position
	}
	method image(){
		return "img/vilma.gif"
	} 
	
	method moverseDerecha(){
		position = position.right(1)
	}
	method moverseIzquierda(){
		position = position.left(1)
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
	
	method position() {
		return game.at(15,5)
	}
	
	method image() { return "img/fantasmaresized.png" }
	
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
	
	var aburrido = false
	
	method reaccionar() {
		aburrido = true
	}
	
}

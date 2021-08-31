import wollok.game.*



object pantalla {
	const ancho = 20
	const alto = 10
	
	method iniciar() {
      game.height(alto)
      game.width(ancho )
      game.title("fantasmas")
      game.addVisual(vilma)
      game.addVisual(fantasma)
      game.addVisual(shaggy)
      game.addVisual(dafne)
      game.addVisual(fred)
      game.boardGround("img/universidad.png")
      
      keyboard.left().onPressDo({vilma.moverseIzquierda() })
      keyboard.right().onPressDo({vilma.moverseDerecha() })
      keyboard.space().onPressDo({vilma.perderLucidez() })
      keyboard.s().onPressDo({shaggy.buscaFantasma()})
      
      game.onCollideDo(fantasma,{algo => algo.perderLucidez()  })
      
      game.schedule(5000,{fantasma.siNoAtrapasteANadieDesenmascarate()})
      game.onTick(1000, "movimientoFantasma",{fantasma.moverse()} )
      fred.animar()
      game.start()
      
      
      
	}
	
	method queNoSeSalga(posicion){
		var nuevaPos = posicion
		if(posicion.x() >= ancho) nuevaPos = game.at(ancho-1,nuevaPos.y())
		if(posicion.x() < 0) nuevaPos = game.at(0,nuevaPos.y())
		if(posicion.y() >= alto) nuevaPos = game.at(nuevaPos.x(),alto-1)
		if(posicion.y() < 0) nuevaPos = game.at(nuevaPos.x(),0)
		return nuevaPos
		
	}  
	// nuevaPos.x(posicion.x().min(ancho-1).max(0))
	// nuevaPos.y(posicion.y().min(alto-1).max(0))
	
	
	
	
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
	
	var position = game.origin()
	var dondeEsta = buffet
	var atrapo = false
	const identidadSecreta = [dafne,shaggy,vilma].anyOne()
	var image = "img/fantasmaresized.png"
	
	method irA(unLugar){
		dondeEsta = unLugar
	}
	
	method asustar(){
//		dondeEsta.ocupante().perderLucidez()
		dondeEsta.seAsustanTodos()
		
	}
	method atrapar() {
		atrapo = true
	}
	
	method position() {
		return position
	}
	
	method image() { return image }
	
	method moverse(){
		const vertical = (-5..5).anyOne()
		const horizontal = (-5..5).anyOne()
		position = pantalla.queNoSeSalga(position.right(horizontal).up(vertical))
		
	}
	method siNoAtrapasteANadieDesenmascarate() {
		if(!atrapo) self.desenmascarate()
	}
	method desenmascarate(){
		image = identidadSecreta.image()
		game.removeTickEvent("movimientoFantasma")
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
    var position = game.at(1,1)
    var asustado = false
    
    method perderLucidez() {
    	asustado = true
    	game.schedule(3000, {asustado= false})
    }
        
    method estaDesmayada() {
    	return false
    }
    method reaccionar() {}
    
    method image() {
    	return if(asustado)  "img/shaggyAsustado.jpg" else "img/shaggy.png"
    }
    
    method position() {
    	return position
    }
    method buscaFantasma() {
	    position = fantasma.position()
    }
}

object dafne {
	
	 method perderLucidez() {
    	game.removeVisual(self)
    }
    
    method position() = vilma.position().up(1)
    
    method image() = "img/dafne.jpg"
    
	
}


object fred {
	
	var nro = 1
	
	method position() = game.at(15,1)
	
	method image() = "img/fred"+ nro + ".png"
	
	
	method animar() {
		
		game.onTick(200,"fredSeMueve",{nro = (nro + 1) % 3 + 1})
	}
	
}

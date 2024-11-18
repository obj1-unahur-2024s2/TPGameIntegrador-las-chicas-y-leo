import niveles.*
import wollok.game.*
import configuracion.*
import clientes.*
import elementos.*

// este script contiene el modelo del MOZO, nuestro personaje principal

object mozo {

	var clientesPerdidos = 0

	var property image = "fantasmaFrenteSinCafe.png"

	var property tieneCafeEnMano = false

	method image(unaImagen) {
		image = unaImagen
	}

	/*method actualizarImagenMozo() {
		if (image.contains("DerechaConCafe"))
			image = "fantasmaDerechaSinCafe.png"
		if (image.contains("IzquierdaConCafe"))
			image = "fantasmaIzquierdaSinCafe.png"
		if (image.contains("EspaldaConCafe"))
			image = "fantasmaEspaldaSinCafe.png"
		if (image.contains("FrenteConCafe"))
			image = "fantasmaFrenteSinCafe.png"	
	}*/

	// replace(expression, replacement)
	method actualizarImagenMozoASinCafe() {
			image = image.replace("ConCafe.png", "SinCafe.png")
	}

	method actualizarImagenMozoAConCafe() {
		image = image.replace("SinCafe.png", "ConCafe.png")
	}


    var position = game.at(1,1) // posicion inicial que irá variando con el movimiento
	// var lastPosition = position // la posicion ANTERIOR a la actual en la que se encontraba el mozo (verificar si se usa)

	method position() = position // getter

	// method lastPosition() = position // getter

	method celdasLindantes() = [self.position().left(1),
							   self.position().right(1),
							   self.position().up(1),
							   self.position().down(1)]

    method crearPedidoEnBarra(unPedidoDeBarra) {
			unPedidoDeBarra.position(unPedidoDeBarra.encontrarLugarLibreEnBarra())
			game.addVisual(unPedidoDeBarra)
            //game.addVisual(new PedidoBarra(fantasmaAsignado=self))
        }
	
	method perderCliente() {
		clientesPerdidos += 1
		if (clientesPerdidos == 3)
			game.addVisual(pantallaDerrota)
	}

	//method image() = "mozoPrueba.png" // imagen de prueba

	method irA(nuevaPosicion) {

		if (not config.hayColision(nuevaPosicion)) {
			// se verifica que en la posición a moverse NO se genere una colisión entre el mozo y un elemento sólido

			// lastPosition = position // antes de moverse, se guarda la posición actual (que luego de moverse será la ANTERIOR)
			position = nuevaPosicion // se actualiza la posición
			
			}

		else {position = self.position()} // si hay una colisión, el mozo se queda en la posición actual
	}

	method hayFantasmaEnCeldaLindante() {

		return self.celdasLindantes().any({c => self.hayFantasma(c)})

	}

	method hayFantasma(unaPosicion) {

		return cliente.fantasmasVisibles().any({f=>f.position() == unaPosicion})

	}
	
	method hayPedidoEnBarraEnCeldaLindante() {

		return self.celdasLindantes().any({c => self.hayPedidoEnBarra(c)})

	}

	method hayPedidoEnBarra(unaPosicion) { //cambiar

		//return game.getObjectsIn(unaPosicion).size() == 1
		return barra.posiciones().any({p => p == unaPosicion and game.getObjectsIn(unaPosicion).size() == 1})

	}

	method hayPedidoEnBarraParaTomar() = self.hayPedidoEnBarraEnCeldaLindante() and not self.tieneCafeEnMano()

	method posicionDelFantasmaLindante() = self.celdasLindantes().find({c => self.hayFantasma(c)})

	method elFantasmaLindante() = game.getObjectsIn(self.posicionDelFantasmaLindante()).get(1)

	method hayFantasmaParaTomarPedido() = self.hayFantasmaEnCeldaLindante() and game.hasVisual(self.elFantasmaLindante().miPedido())

	method quitarPedido(){
		//if(self.hayFantasmaEnCeldaLindante()){
			//const hola = self.celdasLindantes().find({c => self.hayFantasma(c)}) // cambiar nombre
			//const hola2 = game.getObjectsIn(hola) // cambiar nombre
			//game.removeVisual(hola2.get(1).miPedido())
			//self.elFantasmaLindante().pedidoEnCurso(true)
			game.removeVisual(self.elFantasmaLindante().miPedido())
		//}
	} 

	/*method tomarPedido() {
		keyboard.x().onPressDo({ 

            if (self.hayFantasmaEnCeldaLindante() and game.hasVisual(self.elFantasmaLindante().miPedido())){
				self.quitarPedido()
				//crear pedido
				//actualizar fantasma
            }

        })	  
	}*/
	method mostrarImagenIzquierda() {
		return if (self.tieneCafeEnMano()) "fantasmaIzquierdaConCafe.png" else "fantasmaIzquierdaSinCafe.png"
	}

	method mostrarImagenDerecha() {
		return if (self.tieneCafeEnMano()) "fantasmaDerechaConCafe.png" else "fantasmaDerechaSinCafe.png"
	}

	method mostrarImagenFrente() {
		return if (self.tieneCafeEnMano()) "fantasmaFrenteConCafe.png" else "fantasmaFrenteSinCafe.png"
	}

	method mostrarImagenEspalda() {
		return if (self.tieneCafeEnMano()) "fantasmaEspaldaConCafe.png" else "fantasmaEspaldaSinCafe.png"
	}

	method borrarPedidoEnBarra() {
		game.removeVisual(self.elPedidoEnBarraLindante())
	}

	method elPedidoEnBarraLindante() {
		return game.getObjectsIn(self.posicionDelPedidoEnBarraLindante()).get(0)
	}

	method posicionDelPedidoEnBarraLindante() {
		return self.celdasLindantes().find({c => self.hayPedidoEnBarra(c)})
	}

	method puedeDejarPedido() = self.hayFantasmaEnCeldaLindante() and self.tieneCafeEnMano() and not game.hasVisual(self.elFantasmaLindante().miPedido())

	method ponerPedidoEnMesa() {
		//self.elFantasmaLindante().pedidoEnCurso(false)
		const laSilla = game.getObjectsIn(self.posicionDelFantasmaLindante()).get(0)
		if (laSilla.orientacion() == "derecha")
			game.addVisual(new TazaMesa(position=self.posicionDelFantasmaLindante().left(1)))
		else
			game.addVisual(new TazaMesa(position=self.posicionDelFantasmaLindante().right(1)))
	}

}

class TazaMesa {

    const property image = "tazaMesa.png"
    
    var property position

}
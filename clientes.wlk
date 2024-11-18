import wollok.game.*
import configuracion.*
import elementos.*
import mozo.*
import pedidos.*

// este script contiene el modelo de los CLIENTES que deberemos atender en el videojuego.

class Cliente {

    //var property estoyVisible
  
    var property position = game.origin()

    var property image = "f6.png"

    var property tienePedidoEnCurso = false

    const property animacionAparecer = animacionDesaparecer.reverse()
    const property animacionDesaparecer = ["clienteNORMAL.png", "clienteNORMAL1.png","clienteNORMAL2.png","clienteNORMAL3.png","clienteNORMAL4.png"]
    const property animacionDesaparecerEnojado = ["clienteENOJADO.png", "clienteENOJADO1.png","clienteENOJADO2.png","clienteENOJADO3.png","clienteENOJADO4.png"]

    const property miPedido = new PedidoFantasma(fantasmaAsignado=self) // globito

	method celdasALosLados() = [self.position().left(1), self.position().right(1)]
    
    var tiempo = 30

	method tiempo() = tiempo

	method reiniciar() {
		tiempo = 30
        image = "clienteNORMAL.png"
	}

    method recibirPedido() {
        game.removeTickEvent("tiempoCliente")
        image = "clienteNORMAL.png"
        game.schedule(6000, {self.desaparecer()})
    }

    method reiniciarYParar() {
        self.reiniciar()
        game.removeTickEvent("tiempoCliente")
    }


	method pasarSegundo() {
		tiempo -= 1
	}

	method correrTiempo() {
		game.onTick(1000, "tiempoCliente", {
		self.pasarSegundo()
		if (tiempo == 15)
			self.enojarse()
		if (tiempo == 0)
            self.desaparecerEnojado()
		})
	}

    method desaparecer() {
        config.reproducirAnimacion(self, animacionDesaparecer, "animacionDesaparecer")
        self.borrarPedidoEnMesa()
        game.schedule(3000,{game.removeVisual(self) cliente.fantasmasVisibles().remove(self)})
        mozo.sumarClienteAtendido()
        //cliente.fantasmasVisibles().remove(self) // volver a poner en schedule?
        //estoyVisible=false
        //game.schedule(5000, {cliente.todosLosFantasmas().find({f => not cliente.fantasmasVisibles().contains(f)})})
        //config.anadirDeAUnFantasma(config.tiempoAlAzar())
    }

    method desaparecerEnojado() {
        config.reproducirAnimacion(self, animacionDesaparecerEnojado, "animacionDesaparecerEnojado")
        game.schedule(3000,{game.removeVisual(self) cliente.fantasmasVisibles().remove(self)})
        mozo.perderCliente()
        //cliente.fantasmasVisibles().remove(self)
        //estoyVisible=false
        if (game.hasVisual(miPedido)) {
            game.removeVisual(miPedido)
        }
    }

    method aparecer() {
        position = self.encontrarSillaDesocupada()
        cliente.fantasmasVisibles().add(self)
        game.addVisual(self)
        config.reproducirAnimacion(self, animacionAparecer, "animacionAparecer")
        //estoyVisible=true // ver si se usa
        self.mostrarPedido()
        self.correrTiempo()
    }

    method encontrarSillaDesocupada() {

        const sillasDesocupadas = elementoSolido.todasLasSillas().filter({s => not s.estaOcupada()})
        return sillasDesocupadas.anyOne().position()
    }

    method mostrarPedido() {
        game.schedule(6000,{game.addVisual(miPedido)})
    }

    method comer() {}

    method enojarse() {
        image = "clienteENOJADO.png"
    }

    method desenojarse() {}

    method borrarPedido() {
        
    }
    
	method hayCafeEnMesa(unaPosicion) {
		return game.getObjectsIn(unaPosicion).size() == 2
	}

	method hayCafeEnLaLindanteAlFantasma() {
		return self.celdasALosLados().any({c => self.hayCafeEnMesa(c)})
	}

	method cafeEnLaLindante() {
		return game.getObjectsIn(self.posicionDelCafeLindante()).get(1)
	}

	method posicionDelCafeLindante() {
		return self.celdasALosLados().find({c => self.hayCafeEnMesa(c)})
	}

	method borrarPedidoEnMesa() {
		game.removeVisual(self.cafeEnLaLindante())
	}

}

object cliente {

    const property todosLosFantasmas = [unFantasma, otroFantasma] //, otroFantasma, yOtroFantasma, esteFantasma, cheFantasma]
    const property fantasmasVisibles = []

    const property unFantasma = new Cliente()
    const property otroFantasma = new Cliente()
    const property yOtroFantasma = new Cliente()
    const property esteFantasma = new Cliente()
    const property cheFantasma = new Cliente()

}
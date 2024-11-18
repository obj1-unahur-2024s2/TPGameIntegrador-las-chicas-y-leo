import wollok.game.*
import configuracion.*
import elementos.*
import mozo.*
import pedidos.*

// este script contiene el modelo de los CLIENTES que deberemos atender en el videojuego.

class Cliente {

    //var property estoyVisible
    const property nroFantasma
  
    var property position = game.origin()

    var property image = "f6.png"

    var property tienePedidoEnCurso = false

    const property animacionAparecer = animacionDesaparecer.reverse()
    const property animacionDesaparecer = ["clienteNORMAL.png", "clienteNORMAL1.png","clienteNORMAL2.png","clienteNORMAL3.png","clienteNORMAL4.png"]
    const property animacionDesaparecerEnojado = ["clienteENOJADO.png", "clienteENOJADO1.png","clienteENOJADO2.png","clienteENOJADO3.png","clienteENOJADO4.png"]

    var property miPedido = new PedidoFantasma(fantasmaAsignado=self) // globito

	method celdasALosLados() = [self.position().left(1), self.position().right(1)]
    
    var tiempo = 30

	method tiempo() = tiempo

	method reiniciar() {
		tiempo = 30
        image = "clienteNORMAL.png"
	}

    method recibirPedido() {
        self.tienePedidoEnCurso(false)
        self.reiniciarYParar("relojCliente"+nroFantasma.toString())
        image = "clienteNORMAL.png"
        game.schedule(6000, {self.desaparecer()})
    }

    method reiniciarYParar(nombreTick) {
        self.reiniciar()
        game.removeTickEvent(nombreTick)
    }


	method pasarSegundo() {
		tiempo -= 1
	}

	method correrTiempo(nombreTick) {
		game.onTick(1000, nombreTick, {
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
        //cliente.fantasmasVisibles().remove(self)
        mozo.sumarClienteAtendido()
        game.schedule(3000,{game.removeVisual(self)})
        self.aparecerNuevoFantasma()
        cliente.fantasmasVisibles().remove(self)
        
        //cliente.fantasmasVisibles().remove(self) // volver a poner en schedule?
        //estoyVisible=false
        //game.schedule(5000, {cliente.todosLosFantasmas().find({f => not cliente.fantasmasVisibles().contains(f)})})
        //game.schedule(3000, {config.anadirDeAUnFantasma(config.tiempoAlAzar())})
    }

    method desaparecerEnojado() {
        self.tienePedidoEnCurso(false)
        self.reiniciarYParar("relojCliente"+nroFantasma.toString())
        config.reproducirAnimacion(self, animacionDesaparecerEnojado, "animacionDesaparecerEnojado")
        //cliente.fantasmasVisibles().remove(self)
        mozo.perderCliente()
        if (game.hasVisual(miPedido)) {
            game.removeVisual(miPedido)
        }
        game.schedule(3000,{game.removeVisual(self)})
        self.aparecerNuevoFantasma()
        cliente.fantasmasVisibles().remove(self)
        //cliente.fantasmasVisibles().remove(self)
        //estoyVisible=false
        //game.schedule(3000, {config.anadirDeAUnFantasma(config.tiempoAlAzar())})
        
    }

    
    method aparecerNuevoFantasma() {
        game.schedule(7000, { cliente.todosLosFantasmas().find({f => not cliente.fantasmasVisibles().contains(f)}).aparecer() })
    }
    

    method aparecer() {
        position = self.encontrarSillaDesocupada()
        cliente.fantasmasVisibles().add(self)
        game.addVisual(self)
        config.reproducirAnimacion(self, animacionAparecer, "animacionAparecer")
        //estoyVisible=true // ver si se usa
        self.mostrarPedido()
        self.correrTiempo("relojCliente"+nroFantasma.toString())
    }

    method encontrarSillaDesocupada() {

        const sillasDesocupadas = elementoSolido.todasLasSillas().filter({s => not s.estaOcupada()})
        return sillasDesocupadas.anyOne().position()
    }

    method mostrarPedido() {
        self.miPedido().reiniciarPosicion()
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

    const property todosLosFantasmas = [fantasma1, fantasma2, fantasma3, fantasma4, fantasma5, fantasma6] //, otroFantasma, yOtroFantasma, esteFantasma, cheFantasma]
    const property fantasmasVisibles = []

    const property fantasma1 = new Cliente(nroFantasma="1")
    const property fantasma2 = new Cliente(nroFantasma="2")
    const property fantasma3 = new Cliente(nroFantasma="3")
    const property fantasma4 = new Cliente(nroFantasma="4")
    const property fantasma5 = new Cliente(nroFantasma="5")
    const property fantasma6 = new Cliente(nroFantasma="6")

}
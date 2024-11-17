import wollok.game.*
import configuracion.*
import elementos.*
import mozo.*

// este script contiene el modelo de los CLIENTES que deberemos atender en el videojuego.

class Cliente {
  
    var property position = game.origin()

    var property image = "f6.png"

    const property animacionAparecer = animacionDesaparecer.reverse()
    const property animacionDesaparecer = ["f1.png", "f2.png","f3.png","f4.png","f5.png"]

    const property miPedido = new Pedido(fantasmaAsignado=self)

    method desaparecer() {
        config.reproducirAnimacion(self, animacionDesaparecer, "animacionDesaparecer")
        game.schedule(3000,{game.removeVisual(self) cliente.fantasmasVisibles().remove(self)})
        if (game.hasVisual(miPedido)) {
            game.removeVisual(miPedido)
        }
    }

    method aparecer() {
        position = self.encontrarSillaDesocupada()
        cliente.fantasmasVisibles().add(self)
        game.addVisual(self)
        config.reproducirAnimacion(self, animacionAparecer, "animacionAparecer")
        self.mostrarPedido()
    }

    method encontrarSillaDesocupada() {

        const sillasDesocupadas = elementoSolido.todasLasSillas().filter({s => not s.estaOcupada()})
        return sillasDesocupadas.anyOne().position()
    }

    method mostrarPedido() {
        game.schedule(6000,{game.addVisual(miPedido)})
    }

    method comunicarPedido() {}

    method recibirPedido() {}

    // method rechazarPedidoIncorrecto() {}

    method comer() {}

    method enojarse() {}

    method desenojarse() {}

}

object cliente {

    const property todosLosFantasmas = [unFantasma, otroFantasma, yOtroFantasma]
    const property fantasmasVisibles = []

    const fantasmasAtendidosCorrectamente = 0
    const fantasmasNoAtendidos = 0

    const property unFantasma = new Cliente()
    const property otroFantasma = new Cliente()
    const property yOtroFantasma = new Cliente()

}

class Pedido {

    const property fantasmaAsignado

    const property image = "pedidoCafe.png"

    const property position = game.at(fantasmaAsignado.position().x()+1,fantasmaAsignado.position().y()+1)

}

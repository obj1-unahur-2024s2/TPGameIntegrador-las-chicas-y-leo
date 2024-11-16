import wollok.game.*
import mozo.*
import elementos.*
import clientes.*
import configuracion.*
import temporizador.*

// este script contiene los NIVELES y distintas escenas que contendrá nuestro videojuego.

object nivel1 {

    method iniciar() {

        game.addVisual(mozo)
        // añadimos al mozo a la escena, optamos por quitarle el "character" ya que
        // precisamos controlar las acciones del teclado para las colisiones y otras necesidades
        
        elementoSolido.todosLosElementosSolidos().forEach({elemento => game.addVisual(elemento)})
        // se añaden TODOS los elementos sólidos a la escena

        //fantasmasVisibles.forEach({fantasma => game.addVisual(fantasma)})

        config.configurarTeclas()
        // esta línea ejecuta la configuración de las TECLAS del nivel
        // config se encuentra en el archivo "configuracion"

        //todosLosFantasmas.forEach({f => f.aparecer()})

        config.anadirDeAUnFantasma(config.tiempoAlAzar())

        //game.schedule(300000, "finJornada")
        temporizador.correrTiempo()
        game.addVisual(temporizador)

    }

}

object nivel2 {

}

object menu {

    // empezar (nivel1 o nivel2), controles, salir del juego

}

object pantallaVictoria {

    // volver al menu, salir del juego

    method image() = "victoria.png"

    method position() = game.at(0, 0)

}

object pantallaDerrota {

    // reiniciar, volver al menu, salir del juego

    method image() = "derrota.png"

    method position() = game.at(0, 0)

}
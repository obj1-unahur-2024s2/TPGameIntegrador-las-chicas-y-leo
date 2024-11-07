import wollok.game.*
import mozo.*
import elementos.*
import clientes.*
import configuracion.*

// este script contiene los NIVELES y distintas escenas que contendrá nuestro videojuego.

object nivel1 {

    method iniciar() {

        game.addVisual(mozo)
        // añadimos al mozo a la escena, optamos por quitarle el "character" ya que
        // precisamos controlar las acciones del teclado para las colisiones y otras necesidades
        
        todosLosElementosSolidos.forEach({elemento => game.addVisual(elemento)})
        // se añaden TODOS los elementos sólidos a la escena

        fantasmasVisibles.forEach({fantasma => game.addVisual(fantasma)})

        config.configurarTeclas()
        // esta línea ejecuta la configuración de las TECLAS del nivel
        // config se encuentra en el archivo "configuracion"
    }

}
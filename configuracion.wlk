import wollok.game.*
import mozo.*

object config {

	method configurarTeclas() {
		keyboard.left().onPressDo({ mozo.irA(mozo.position().left(1)) })
		keyboard.right().onPressDo({ mozo.irA(mozo.position().right(1)) })
		keyboard.up().onPressDo({ mozo.irA(mozo.position().up(1))})
		keyboard.down().onPressDo({ mozo.irA(mozo.position().down(1)) })

    }
}
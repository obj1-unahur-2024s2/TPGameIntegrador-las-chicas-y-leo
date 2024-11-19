import temporizador.*
import mozo.*
import clientes.*

class TextoVisual {

    const property position
    const property text
    const property textColor

}

object visuales {
    
    const property todosLosStats = [stats, textoClientesAtendidos, textoClientesPerdidos, textoTeclaX, textoTeclaM, textoTeclaL]

    const property textoTeclaX = new TextoVisual(position = game.at(5,0), text="Atender pedido: X", textColor=paleta.blanco())
    const property textoTeclaM = new TextoVisual(position = game.at(8,0), text="Tomar café de la Barra: M", textColor=paleta.blanco())
    const property textoTeclaL = new TextoVisual(position = game.at(11,0), text="Entregar café: L", textColor=paleta.blanco())

}

object textoClientesAtendidos {

    method position() = game.at(14,10)
    method text() = "Clientes atendidos = " + mozo.clienteAtendido().toString()
    method textColor() = paleta.blanco()

}

object textoClientesPerdidos {

    method position() = game.at(14,9)
    method text() = "Clientes perdidos = " + mozo.clientesPerdidos().toString()
    method textColor() = paleta.blanco()

}

object stats {

    method position() = game.at(14,9)
    method image() = "cartelStats.png"

}

object paleta {
	const property blanco = "FFFFFFFF"
}

/*object textoFantasmasVisibles {

    // se utilizó para identificar bugs
    
    method position() = game.at(7,9)
    method text() = "lista de visibles = " + cliente.fantasmasVisibles().toString()

}*/
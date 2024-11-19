import temporizador.*
import mozo.*
import clientes.*

class TextoVisual {

    const property position
    const property text
    const property textColor

}

object visuales {
    
    const property todosLosStats = [stats, textoClientesAtendidos, textoClientesPerdidos, textoTeclaW, textoTeclaA, textoTeclaD]

    const property textoTeclaW = new TextoVisual(position = game.at(5,0), text="Atender pedido: W", textColor=paleta.blanco())
    const property textoTeclaA = new TextoVisual(position = game.at(8,0), text="Tomar café de la Barra: A", textColor=paleta.blanco())
    const property textoTeclaD = new TextoVisual(position = game.at(11,0), text="Entregar café: D", textColor=paleta.blanco())
    const property textoNivel1 = new TextoVisual(position = game.at(15,11), text="Nivel 1", textColor=paleta.blanco())
    const property textoNivel2 = new TextoVisual(position = game.at(15,11), text="Nivel 2", textColor=paleta.blanco())

}

object textoClientesAtendidos {

    method position() = game.at(15,10)
    method text() = "Clientes atendidos = " + mozo.clienteAtendido().toString()
    method textColor() = paleta.blanco()

}

object textoClientesPerdidos {

    method position() = game.at(15,9)
    method text() = "Clientes perdidos = " + mozo.clientesPerdidos().toString()
    method textColor() = paleta.blanco()

}

object stats {

    method position() = game.at(14,9)
    method image() = "cuadradoDeStats.png"

}

object paleta {
	const property blanco = "FFFFFFFF"
}

/*object textoFantasmasVisibles {

    // se utilizó para identificar bugs
    
    method position() = game.at(7,9)
    method text() = "lista de visibles = " + cliente.fantasmasVisibles().toString()

}*/
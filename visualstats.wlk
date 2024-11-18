import temporizador.*
import mozo.*
import clientes.*
object stats {

    method position() = game.at(14,9)

    method image() = "cartelStats.png"

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

object textoFantasmasVisibles {
    method position() = game.at(7,9)
    method text() = "lista de visibles = " + cliente.fantasmasVisibles().toString()
}
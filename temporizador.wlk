import wollok.game.*
import mozo.*
import elementos.*
import clientes.*
import configuracion.*
import niveles.*
object temporizador {

	var tiempo = 150

	method tiempo() = tiempo

	method text() = self.transformarTiempo()

	method textColor() = paleta.blanco()

	method position() = game.at(16,10)

	method reiniciar() {
		tiempo = 150
		game.removeTickEvent("tiempo")
	}

	method pasarSegundo() {
		tiempo -= 1
	}

	method correrTiempo() {
		game.onTick(1000, "tiempo", {
		self.pasarSegundo()
		if (tiempo == 0) {
			game.clear()
			game.addVisual(pantallaVictoria)
		}})
	}

	method transformarTiempo() {
		var minutos = (tiempo / 60.0).truncate(0)
		var segundosRestantes = tiempo % 60
		return self.formatoTiempo(minutos) + ":" + self.formatoTiempo(segundosRestantes)
	}

	method formatoTiempo(numero) {
        if (numero < 10) {
            return "0" + numero.toString()
        } else {
            return numero.toString()
        }
	}

}

object paleta {
	const property blanco = "FFFFFFFF"

}


object cartelReloj {
	method image() = "cartelReloj.png"
	method position() = game.at(16, 10)
}

object barrileteCosmico {
	const destinos = []
	const transportes = []
	
	method agregarTransporte(transporte){
		transportes.add(transporte)
	}
	
	method agregarDestino(destino){
		destinos.add(destino)
	}
	
	method destinosImportantes() = destinos.filter({unDestino => unDestino.destinoDestacado()})
	
	method aplicarDescuentoATodos(descuento) {
		destinos.forEach({unDestino => unDestino.aplicarDescuento(descuento) })
	}
	
	method empresaExtrema() = destinos.any({unDestino => unDestino.esPeligroso()})
	
	method cartaDeDestinos() = destinos.map({unDestino => unDestino.nombre()})
	
	method losDestinosMasPeligrosos() = destinos.filter({unDestino => unDestino.esPeligroso()})
	
	method armarViaje(usuario,localidad){
		const transporteAleatorio = transportes.anyOne()
		
	//	if (not(destinos.contains(localidad))){
	//		self.error("Barrilete Cosmico no posee ese destino")
	//	}

		
	   const viaje = new Viaje(origen = usuario.origen(),destino = localidad,transporte = transporteAleatorio)
	   
	   usuario.viajarA(viaje)
	   
	}
	
}

class Localidad{
	const property nombre
	const property equipajeImprecindible
	var property precio
	const property ubicacion
	
	method destinoDestacado() = precio > 2000
	
	method esPeligroso() = equipajeImprecindible.any({unEquipaje => unEquipaje.contains("Vacuna")})
	
	
	method aplicarDescuento(descuento){
		precio = precio - descuento*precio/100
		equipajeImprecindible.add("Certificado de descuento")
	}
	
	method distanciaDe(localidad) = (localidad.ubicacion() - ubicacion).abs()
	
}


class Usuario {
	const property usuario
	const property viajes
	var property saldo
	var property origen
	var property kilometrosRecorridos 
	const equipaje = []
	const property seguidos = []
	
	
	method viajarA(viaje){
		if (viaje.precio() > saldo){
			self.error("No se puede debitar debido a saldo insuficiente")
		}
		
		if (viaje.destino().esPeligroso() and not(equipaje.any({unEquipaje => unEquipaje.contains("Vacuna")}))){
			self.error("El usuario no posee alguna Vacuna")
		}
		
	    kilometrosRecorridos += viaje.kilometros()
		viajes.add(viaje.destino())		
		saldo = saldo - viaje.precio()	
		origen = viaje.destino()

	}
	
	
	method seguirUsuario(unUsuario){
		
		if (not(seguidos.contains(unUsuario))){
			seguidos.add(unUsuario)
		    unUsuario.seguirUsuario(self)
		}
		
	}
	

}

class Viaje {
	const origen
	const property destino
	const transporte
	
	method kilometros() = origen.distanciaDe(destino)
	method precioTraslado() = origen.distanciaDe(destino)*transporte.costoPorKilometro()
	method precioDestino() = destino.precio()
	method precio() = self.precioTraslado() + self.precioDestino()
}

class Transporte{
	const property tardanza
	const property costoPorKilometro
}

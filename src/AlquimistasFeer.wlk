object alquimista{
	var itemsDeCombate = []
	var itemsDeRecoleccion= []
	
	method agregarItemDeCombate(unItem)
	{
		itemsDeCombate.add(unItem)
	}
	
	method agregarItemDeRecoleccion(unItem)
	{
		itemsDeRecoleccion.add(unItem)
	}
//1	
	method tieneCriterio()
	{
		return self.itemsDeCombateEfectivos() >= (self.cantidadItemsDeCombate())/2	
	}
	
	method cantidadItemsDeCombate() 
	{
		return  itemsDeCombate.size()
	}
	
	method itemsDeCombateEfectivos() 
	{
		return self.sonEfectivos().size()
	}
	
	method sonEfectivos()
	{
		return itemsDeCombate.filter({
			unItem => unItem.esEfectivo()
		})
	}
//2) Saber si son buenos exploradores, esto si cumple si poseen al menos tres tipos diferentes de items de recoleccion
	method esBuenExplorador()
	{
		return self.cantidadItemsDeRecoleccionDiferentes() >= 3
	}
	
	method cantidadItemsDeRecoleccionDiferentes()
	{
		return itemsDeRecoleccion.asSet().size()	//deja una ocurrencia de cada elemento
	}
}

object bomba
{
	var danio = 15
	var materiales = []
	
	method agregarMaterial(unMaterial)
	{
		materiales.add(unMaterial)	
	}
	
	method danio(valor)
	{
		danio = valor	
	}
	
	method esEfectivo()
	{
		return danio >100
	}
	
	method capacidad()
	{
		return danio / 2
	}
	method calidad()
	{
		return materiales.min({
			unMaterial => unMaterial.calidad()
		})
	}
}

object pocion
{
	var nivelDeCuracion = 50
	var materiales = []
	
	method agregarMaterial(unMaterial)
	{
		materiales.add(unMaterial)	
	}
	
	method nivelDeCuracion(nivel)
	{
		nivelDeCuracion = nivel
	}
	method esEfectivo()
	{
		return nivelDeCuracion > 50 and self.tieneAlgunMaterialMistico()
	}
	
	method tieneAlgunMaterialMistico() 
	{
		return materiales.any({
			material => material.esMistico()
		}) 
	}
	
	method capacidad()
	{
		return nivelDeCuracion + 10*self.cantidadMaterialesMisticos()
	}
	
	method cantidadMaterialesMisticos()
	{
		return materiales.count({
			material=>material.esMistico()
		})
	}
	
	method calidad()
	{
		if(self.cantidadMaterialesMisticos() != 0)
		{
			return self.materialesMisticos().head()
		}
		else
			return materiales.head().calidad()	
	}
	
	method materialesMisticos()
	{
		return materiales.filter({
			unMaterial => unMaterial.esMistico()
		})
	}
	
}

object debilitador
{
	var potencia = 1
	var materiales=[]
	
	method agregarMaterial(unMaterial)
	{
		materiales.add(unMaterial)	
	}
	
	method potencia(valor)
	{
		potencia = valor
	}
	
	method esEfectivo()
	{
		return potencia>0 and (self.tieneAlgunMaterialMistico()).negate()
	}
	
	method tieneAlgunMaterialMistico() 
	{
		return materiales.any({
			material => material.esMistico()
		}) 
	}
	
	method capacidad()
	{
		if(self.tieneAlgunMaterialMistico())
			return 12*self.cantidadDeMateriales()
		else
			return 5
	}
	
	method cantidadDeMateriales()
	{
		return materiales.size()
	}
	
//	method calidad()
//	{
//		
//	}
}
//Materiales
object florRoja
{
	method esMistico()
	{
		return true
	}
	method calidad()
	{
		return 5
	}
}

object uni
{
	method esMistico()
	{
		return true
	}
	method calidad()
	{
		return 7
	}
}

object polvora
{
	method esMistico()
	{
		return false
	}
	method calidad()
	{
		return 5
	}
}

//Items de recoleccion
object caniaDePescar
{
	
}
object redAtrapaInsectos
{
	
}
object bolsaDeViento
{
	
}
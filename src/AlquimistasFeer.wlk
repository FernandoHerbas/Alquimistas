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
//3)	
	method capacidadOfensiva()
	{
		return itemsDeCombate.sum({
			unItem => unItem.capacidad()
			})
	}
//4)
	method esProfesional()
	{
		return self.calidadPromedioDeSusItems() > 50 and self.todosSusItemsDeCombateEfectivos() 
		and self.esBuenExplorador()
	}	
	
	method calidadPromedioDeSusItems()
	{
		return self.sumaDeLaCalidadDeTodosSusItems()/self.cantidadDeTodosSusItems()
	}
											  
	method sumaDeLaCalidadDeTodosSusItems()					
	{
		return self.calidadItemsDeCombate() + self.calidadItemsDeRecoleccion()
	}
	method calidadItemsDeCombate()
	{
		return itemsDeCombate.sum({
			unItem => unItem.calidad()
		})
	}
	method calidadItemsDeRecoleccion()
	{
		return itemsDeRecoleccion.sum({
			unItem => unItem.calidad()
		})
	}													 
	method cantidadDeTodosSusItems()
	{
		return self.cantidadItemsDeCombate() + itemsDeRecoleccion.size() 
	}
	
	method todosSusItemsDeCombateEfectivos()
	{
		return self.sonEfectivos().size() == self.cantidadItemsDeCombate()
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
		}).calidad()
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
		if(self.cantidadMaterialesMisticos()!=0)
		{
			return self.materialesMisticos().head().calidad()
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
	
	method calidad()
	{
		return self.sumaDeLosDosMaterialesDeMayorCalidad() / 2		
	}
	
	method sumaDeLosDosMaterialesDeMayorCalidad()
	{
		return self.materialDeMayorCalidad().calidad() + self.segundoMaterialDeMayorCalidad().calidad()
	}
	
	method materialDeMayorCalidad()
	{
		return materiales.max({
			unMaterial => unMaterial.calidad()
		})
	}
	method segundoMaterialDeMayorCalidad()
	{
		return self.materialesSinElDeMayorCalidad().max({
			unMaterial =>unMaterial.calidad()
		})
	}
	method materialesSinElDeMayorCalidad()
	{
	 return materiales.copyWithout(self.materialDeMayorCalidad()) //Para copyWithout si o si la lista debe tener 2 o mas objetos
	}															  //y ademas saca sus elementos repetidos. por lo que, no tan eficiente
}
//Materiales, donde se supone algunos materiales misticos y otros no, y todos retonan algun valor para el mensaje calidad()
object florRoja
{
	var calidad = 0
	method esMistico()
	{
		return true  
	}
	method calidad(valor)
	{
		calidad=valor
	}
	method calidad()
	{
		return calidad
	}
}

object uni
{
	var calidad=0
	method esMistico()
	{
		return true
	}
	method calidad(valor)
	{
		calidad=valor
	}
	method calidad()
	{
		return calidad
	}
}

object polvora
{
	var calidad=0
	method esMistico()
	{
		return false
	}
	method calidad(valor)
	{
		calidad=valor
	}
	method calidad()
	{
		return calidad
	}
}
object unMaterialNoMistico  // Creado para el test del punto 4
{
	var calidad = 0
	method esMistico()
	{
		return false  
	}
	method calidad(valor)
	{
		calidad=valor
	}
	method calidad()
	{
		return calidad
	}
}
//Items de recoleccion, entienden el mensaje calidad
object caniaDePescar
{
	method calidad()
	{
		return 30 + self.calidadDeMateriales()*0.1
	}
	method calidadDeMateriales(){
		return 10
		}
}
object redAtrapaInsectos
{
	method calidad()
	{
		return 30 + self.calidadDeMateriales()*0.1
	}
	method calidadDeMateriales()
	{
		return 5
	}
}
object bolsaDeViento
{
	method calidad()
	{
		return 30 + self.calidadDeMateriales()*0.1
	}	
	method calidadDeMateriales()
	{
		return 1
	}
}
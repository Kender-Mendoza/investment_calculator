# README

### Appreview link
https://calculator-investment-a4eedb29d129.herokuapp.com/

### Versiones usadas
- ruby "3.1.2"
- gem "rails", "~> 7.0.3"
  
### Instalación 
- Primero debes clonar el repositorio
  
  `git clone git@github.com:Kender-Mendoza/investment_calculator.git`
- Luego debes instalar las gemas 

  `bundle install`
- Para asegurarnos que los asests esten correctamente los precompilamos 

  ` rails assets:clobber; rails assets:precompile`
- Y para finalizar, inicias el servidor
  
  `rails s`

Al probar en local, muy probablemente se necesite el api-key de Messary, para utilizar la será necesario crear un archivo llamado `.env` en la raíz del proyecto
y agregar el api-key.

`MESSARI_API_KEY: Hg0v49hJlHMX1Ou5Xq6p0NML7Kymq7vhZ8VEYWXWF4oDDiOz`

> #### Nota!
> 
> Para agilizar el proceso no miro problemas en dejar la variable aquí. No es recomendado hacer si este no fuera el caso.
> 

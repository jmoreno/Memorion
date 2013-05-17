Hablando un día por Twitter, Miguel Díaz Rubio (aka [@migueldiazrubio](http://twitter.com/migueldiazrubio)) cometió la imprudencia de animarme a escribir algo en su blog: [www.migueldiazrubio.com](http://www.migueldiazrubio.com). Obviamente le dije que si, el blog de Miguel junto con el de [Objective-C.es](http://objective-c.es) son de lo mejorcito que hay ahora mismo en castellano para aprender Objective-C y Cocoa Touch, las herramientas necesarias para hacer aplicaciones iOS y una oportunidad para ayudar a estos *máquinas* no podía desperdiciarse. 

Hoy se ha publicado en el blog de Miguel mi primera colaboración (espero que me deje hacer alguna más), un tutorial sobre como hacer un juego de encontrar las parejas basado en un componente que se presento en iOS 6: UICollectionView. Este era un tutorial que tenía pensado colgar en este blog más pronto o más tarde pero estoy seguro que en el blog de Miguel podrá ser de utilidad a más gente.

No es un ejemplo que se me haya ocurrido sobre la marcha, llevo trabajando a ratos en una aplicación muy parecida a la del tutorial desde hace seis meses. Por esta razón me ha parecido oportuno escribir esta entrada que explica de donde me vino la inspiración.

En diciembre del año pasado mi hija estuvo ingresada un par de días en el hospital (un sustejo del que afortunadamente se recuperó perfectamente). Un par de días en los que jugamos a todos los juegos que había en el hospital más alguno que llevamos de casa. Su favorito era uno con piezas que había que poner boca abajo, e ir dando la vuelta de dos en dos hasta encontrar todas las parejas.    
Recordé que en la aplicación Phytonista había un ejemplo que consistía precisamente en un juego como este y que usaba los animales del teclado emoji como personajes del juego. 

> Merece mucho la pena ver el código para darse cuenta de la potencia de Python ya que con muy pocas líneas tienes el juego funcionando.  

El caso es que pensé en si sería mucho más complicado hacerlo en Objective-C, sobre todo el grid de tarjetas y en ese momento caí en la cuenta de que UICollectionView podría ser un buen candidato ya que se alimenta fácilmente con un array y permite definir el tamaño de las celdas,...

Una vez recuperados del susto, empece a probar si mi idea era cierto y en seguida vi que si, que UICollectionView era genial para hacer este juego. Desde entonces, a ratos, he ido metiéndole funcionalidad para hacer el juego algo más interesante y entretenido. La verdad es que mi hija se lo pone en el iPad sin que yo le diga nada, así que no debe estar muy mal hecho ;-)

Si alguien está interesado en probarlo y no tiene cuenta de desarrollador, que me lo diga, no me vendrá mal tener más beta-tester. 

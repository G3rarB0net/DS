import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        //Pide el número de bicicletas
        int numBicicletas;

        Scanner sc = new Scanner(System.in);
        System.out.print("Ingrese el numero de bicicletas: ");
        numBicicletas = sc.nextInt();


        //Creacion de las factorias de los dos tipos
        FactoriaCarreraBicicleta factoriaMontaña = new FactoriaMontaña();
        FactoriaCarreraBicicleta factoriaCarretera = new FactoriaCarretera();


        //Creo las carreras
        Carrera carreraMontaña= factoriaMontaña.crearCarrera(numBicicletas);
        Carrera carreraCarretera = factoriaCarretera.crearCarrera(numBicicletas);


        //Añado las bicicletas a la carrera
        for (int i = 0; i < numBicicletas; i++) {
            carreraMontaña.addBicicleta(factoriaMontaña.crearBicicleta(i));
            carreraCarretera.addBicicleta(factoriaCarretera.crearBicicleta(i));
        }


        //Inicio las carreras
        carreraMontaña.start();
        carreraCarretera.start();



    }
}

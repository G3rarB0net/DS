import java.util.ArrayList;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        //Pide el numero de bicicletas
        int numBicicletas;

        Scanner sc = new Scanner(System.in);
        System.out.print("Ingrese el numero de bicicletas: ");
        numBicicletas = sc.nextInt();


        //Creacion de las factorias de los dos tipos
        FactoriaCarreraBicicleta factoriaMontaña = new FactoriaMontaña();
        FactoriaCarreraBicicleta factoriaCarretera = new FactoriaCarretera();

        //Creaciond de los arrays de bicicletas
        ArrayList<Bicicleta> bicicletasMontaña = new ArrayList<>();
        ArrayList<Bicicleta> bicicletasCarretera = new ArrayList<>();

        //Creo las bicicletas y se los añado a los arrays
        for (int i = 0; i < numBicicletas; i++) {
            bicicletasMontaña.add(factoriaMontaña.crearBicicleta(i));
            bicicletasCarretera.add(factoriaCarretera.crearBicicleta(i));
        }

        //Creo las carreras
        Carrera carreraMontaña= factoriaMontaña.crearCarrera(bicicletasMontaña);
        Carrera carreraCarretera = factoriaCarretera.crearCarrera(bicicletasCarretera);


        //Inicio las carreras
        carreraMontaña.start();



    }
}

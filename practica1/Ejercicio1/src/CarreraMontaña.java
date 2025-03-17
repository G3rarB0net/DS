import java.util.ArrayList;
import java.util.Random;

public class CarreraMontaña extends Carrera {

    public CarreraMontaña(int n, double porcentaje) {
        super(n,porcentaje);

    }


    @Override
    public void iniciarCarrera() {
        System.out.println("Iniciando la carrera de Montaña");

        //Numero de bicicletas retiradas
        int numeroRetiradas = (int)(bicicletas.size() * porcentajeRetiro);
        System.out.println("Numero de bicicletas a retirar de la carrera de montaña: "+numeroRetiradas);

        //Contador de bicis retiradas
        int contadorRetiradas = 0;
        //Intervalo de tiempo de cada cuanto se retira una bici, si hay menos de 60 bicis a retirar cada 1 segundo
        int intervaloTiempo;
        if(numeroRetiradas > 60){
            intervaloTiempo = (int) (DURACION/numeroRetiradas)*1000;
        }
        else{
            intervaloTiempo = 1000;
        }


        //Guardo el instante de inicio
        long iniTime = System.currentTimeMillis();

        //Mido la diferencia de tiempo, lo divido por 1000 porque es en milisegundos
        while((System.currentTimeMillis()-iniTime)/1000<DURACION) {
            try{
                for (Bicicleta bici : bicicletas) {
                    bici.showString();
                }

                Thread.sleep(intervaloTiempo);

                if(contadorRetiradas < numeroRetiradas && !bicicletas.isEmpty()){
                    Random rand = new Random();
                    int indice = rand.nextInt(bicicletas.size());
                    System.out.println("Bicileta con el id " + bicicletas.get(indice).getId() + " se ha retirado de la carrera de Montaña");
                    bicicletas.remove(indice);
                    contadorRetiradas++;
                }

            }catch (InterruptedException e) {
                System.out.println("La carrera de montaña fue interrumpida");
                return;
            }

        }

        System.out.println("La carrera de montaña ha finalizado");
    }


}

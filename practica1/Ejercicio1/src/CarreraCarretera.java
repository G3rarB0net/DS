import java.util.ArrayList;

public class CarreraCarretera extends Carrera {
    private double porcentajeRetiro = 0.1;

    public CarreraCarretera(ArrayList<Bicicleta> bicicletas) {
        super(bicicletas);
    }


    @Override
    public void iniciarCarrera() {
        System.out.println("Iniciando carrera carretera...");
    }


}

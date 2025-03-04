import java.util.ArrayList;

public class CarreraMontaña extends Carrera {
    private double porcentajeRetiro = 0.2;

    public CarreraMontaña(ArrayList<Bicicleta> bicicletas) {
        super(bicicletas);
    }


    @Override
    public void iniciarCarrera() {
        System.out.println("Iniciando carrera montaña...");
    }


}

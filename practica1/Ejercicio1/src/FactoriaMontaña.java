import java.util.ArrayList;

public class FactoriaMontaña implements FactoriaCarreraBicicleta {
    @Override
    public Bicicleta crearBicicleta(int id) {
        return new BicicletaMontaña(id);
    }

    @Override
    public Carrera crearCarrera(ArrayList<Bicicleta> bicicletas){
        return new CarreraMontaña(bicicletas);
    }
}

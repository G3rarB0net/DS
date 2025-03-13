import java.util.ArrayList;

public class FactoriaCarretera implements FactoriaCarreraBicicleta{
    @Override
    public Bicicleta crearBicicleta(int id) {
        return new BicicletaCarretera(id);
    }

    @Override
    public Carrera crearCarrera(ArrayList<Bicicleta> bicicletas){
        return new CarreraCarretera(bicicletas);
    }
}

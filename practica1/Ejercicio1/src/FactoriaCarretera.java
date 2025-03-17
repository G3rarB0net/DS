import java.util.ArrayList;

public class FactoriaCarretera implements FactoriaCarreraBicicleta{
    @Override
    public BicicletaCarretera crearBicicleta(int id) {
        return new BicicletaCarretera(id);
    }

    @Override
    public CarreraCarretera crearCarrera(int n){
        return new CarreraCarretera(n);
    }
}

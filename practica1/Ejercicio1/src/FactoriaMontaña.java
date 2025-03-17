import java.util.ArrayList;

public class FactoriaMontaña implements FactoriaCarreraBicicleta {
    @Override
    public BicicletaMontaña crearBicicleta( int id ) {
        return new BicicletaMontaña(id);
    }

    @Override
    public CarreraMontaña crearCarrera(int n, double porcentaje){
        return new CarreraMontaña(n, porcentaje);
    }
}

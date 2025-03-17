import javax.swing.*;
import javax.swing.plaf.DimensionUIResource;
import java.util.ArrayList;

public abstract class Carrera extends Thread{
    /**
     * Lista de todas las bicicletas que participaran en la carrera
     */
    protected ArrayList<Bicicleta> bicicletas;

    /**
     * Duración de la carrera en segundos
     */
    protected final int DURACION = 60;

    /**
     * Porcentaje de retiro
     */
    protected double porcentajeRetiro;

    /**
     * Constructor
     */
    public Carrera(int n, double porcentaje) {
        bicicletas = new ArrayList<>(n);
        this.porcentajeRetiro = porcentaje;
    }

    public void addBicicleta(Bicicleta b) {
        bicicletas.add(b);
    }


    public abstract void iniciarCarrera();

    @Override
    public void run() {
        iniciarCarrera();
    }
}

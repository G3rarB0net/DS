import java.util.ArrayList;

public abstract class Bicicleta {
    protected int id;

    public Bicicleta(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public abstract void showString();

}

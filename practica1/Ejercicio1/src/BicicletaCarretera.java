public class BicicletaCarretera extends Bicicleta{
    public BicicletaCarretera(int id) {
        super(id);
    }

    @Override
    public void showString(){
        System.out.println(" Bicicleta de carretera con ID: "+id);
    }
}

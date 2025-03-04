public class BicicletaMontaña extends Bicicleta {
    public BicicletaMontaña( int id) {
        super(id);
    }

    @Override
    public void showString(){
        System.out.println(" SOy una bicicleta de montaña con ID: "+id);
    }
}

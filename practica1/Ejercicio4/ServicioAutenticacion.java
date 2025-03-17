import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

// Objetivo: el objetivo es que la autenticación pase los filtros, cumpla el objetivo y dé por exitosa la autenticación
class Objetivo {
    public void ejecutar(String correo, String contrasena) {
        System.out.println("Autenticación exitosa");
    }
}

// Filtro: interfaz para los filtros
interface Filtro {
    boolean ejecutar(String dato);
}

// Filtro: para validar el correo
class FiltroCorreo implements Filtro {
    @Override
    public boolean ejecutar(String correo) {
        if (correo == null || !correo.contains("@")) {
            System.out.println("Correo inválido: falta '@'");
            return false;
        }

        String[] partes = correo.split("@");
        if (partes[0].isEmpty()) {
            System.out.println("Correo inválido: falta texto antes de '@'");
            return false;
        }

        if (partes.length != 2){
            System.out.println("Correo inválido: falta texto después de '@'");
            return false;
        }
        else{
            String dominio = partes[1].toLowerCase();
            if (!dominio.equals("gmail.com") && !dominio.equals("hotmail.com")) {
                System.out.println("Correo inválido: dominio no permitido (solo gmail.com o hotmail.com)");
                return false;
            }
        }

        return true;
    }
}

// Filtro 1 para la contraseña: longitud mínima de 8 caracteres
class FiltroLongitud implements Filtro {
    @Override
    public boolean ejecutar(String contrasena) {
        if (contrasena.length() < 8) {
            System.out.println("Contraseña inválida: debe tener al menos 8 caracteres");
            return false;
        }
        return true;
    }
}

// Filtro 2 para la contraseña: debe contener al menos un número
class FiltroNumero implements Filtro {
    @Override
    public boolean ejecutar(String contrasena) {
        if (!contrasena.matches(".*\\d.*")) {  // . cualquier caracter; * cero o mas rep. del caracter anterior; \\d un digito numerico; 
            System.out.println("Contraseña inválida: debe contener al menos un número"); // .* cualquier cantidad de caracteres antes o despues del digito
            return false;
        }
        return true;
    }
}

// Filtro 3 para la contraseña: debe contener al menos una letra mayúscula
class FiltroMayuscula implements Filtro {
    @Override
    public boolean ejecutar(String contrasena) {
        if (!contrasena.matches(".*[A-Z].*")) {  // .* cualquier cantidad de caracteres antes o despues; [A-Z] cualquier letra mayusucla
            System.out.println("Contraseña inválida: debe contener al menos una letra mayúscula");  // .* cualquier cantidad de caracteres despues
            return false;
        }
        return true;
    }
}

// Cadena de filtros: lista con los filtros a aplicar
class CadenaFiltros {
    private final List<Filtro> filtros = new ArrayList<>();
    public void agregarFiltro(Filtro filtro) {
        filtros.add(filtro);
    }

    public boolean ejecutar(String dato) {
        for (Filtro filtro : filtros) {
            if (!filtro.ejecutar(dato)) {
                return false;
            }
        }
        return true;
    }
}

// GestorFiltros: gestiona la cadena de filtros y el objetivo
class GestorFiltros {
    private final CadenaFiltros cadenaFiltros = new CadenaFiltros();

    public void agregarFiltro(Filtro filtro) {
        cadenaFiltros.agregarFiltro(filtro);
    }

    public boolean peticionFiltros(String dato) {
        return cadenaFiltros.ejecutar(dato);
    }
}

// Cliente: solicita la validación
public class ServicioAutenticacion {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        GestorFiltros gestorCorreo = new GestorFiltros();
        GestorFiltros gestorContrasena = new GestorFiltros();
        Objetivo autenticacion = new Objetivo();

        // Agregar filtros a los gestores
        gestorCorreo.agregarFiltro(new FiltroCorreo());

        gestorContrasena.agregarFiltro(new FiltroLongitud());
        gestorContrasena.agregarFiltro(new FiltroNumero());
        gestorContrasena.agregarFiltro(new FiltroMayuscula());

        String correo, contrasena;

        // Validar el correo antes de pedir la contraseña
        do {
            System.out.print("Ingrese su correo: ");
            correo = scanner.nextLine();
        } while (!gestorCorreo.peticionFiltros(correo));

        // Validar la contraseña después de que el correo sea válido
        do {
            System.out.print("Ingrese su contraseña: ");
            contrasena = scanner.nextLine();
        } while (!gestorContrasena.peticionFiltros(contrasena));

        // Ejecutar el objetivo solo después de ambas validaciones
        autenticacion.ejecutar(correo, contrasena);

        scanner.close();
    }
}
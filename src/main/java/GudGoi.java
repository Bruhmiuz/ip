public class GudGoi {
    private static void printBanner() {
        System.out.println(
            "   ___           _   _      _     ___      _ \n"
            + "  / _ \\_   _  __| | | |_/\\_| |   / _ \\___ (_)\n"
            + " / /_\\/ | | |/ _` | | \\    / |  / /_\\/ _ \\| |\n"
            + "/ /_\\\\| |_| | (_| | | /_  _\\ | / /_\\\\ (_) | |\n"
            + "\\____/ \\__,_|\\__,_| |_| \\/ |_| \\____/\\___/|_|\n"
        );
    }

    private static void greet() {
        System.out.println(
            "Hello, I am the Gud Goi, your friendly neighbourhood pro-ISR bot.\n" 
            + "What's on the agenda today?\n"
        );
    }

    private static void valediction() {
        System.out.println(
            "Bhai bhai. Even from afar, I'm always watching.\n"
        );
    }

    public static void main(String[] args) {   
        printBanner();
        greet();

        String cmd;
        while (!(cmd = IO.readln()).equals("bye")) {
            System.err.println(cmd + "\n");
        }

        valediction();
    }
}

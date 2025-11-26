import com.wordalytica.wordset.WordSetFactory;
import com.wordalytica.wordset.core.WordSet;
import java.nio.file.*;
import java.util.*;

public class HelloWorld {
    public static void main(String[] args) throws Exception {
        System.out.println("Hello World!");
    }

    // Load the bundled 370K word dictionary
    public static WordSet<?> loadWords() throws Exception {
        List<String> lines = Files.readAllLines(Paths.get("/lib/words.all"));
        return WordSetFactory.build(lines, 2);
    }
}

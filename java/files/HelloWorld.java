import com.wordalytica.wordset.WordSetFactory;
import com.wordalytica.wordset.core.WordSet;
import java.nio.file.*;
import java.util.*;

public class HelloWorld {
    public static void main(String[] args) throws Exception {
        System.out.println("Hello World!");
    }

    // Load the bundled word dictionary
    public static WordSet<?> loadWords() throws Exception {
        List<String> lines = Files.readAllLines(Paths.get("/lib/words.all"));
        return WordSetFactory.build(lines, 2);
    }

    // Scrabble letter scores
    private static final int[] SCORES = new int[26];
    static {
        String[] groups = {"aeilnorstu", "dg", "bcmp", "fhvwy", "k", "", "", "jx", "", "qz"};
        int[] points = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
        for (int i = 0; i < groups.length; i++) {
            for (char c : groups[i].toCharArray()) SCORES[c - 'a'] = points[i];
        }
    }

    // Calculate Scrabble score for a word
    public static int wordScore(String word) {
        int score = 0;
        for (char c : word.toLowerCase().toCharArray()) {
            if (c >= 'a' && c <= 'z') score += SCORES[c - 'a'];
        }
        return score;
    }
}

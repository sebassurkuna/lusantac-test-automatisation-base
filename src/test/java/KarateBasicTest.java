import org.junit.jupiter.api.Order;

import com.intuit.karate.junit5.Karate;

class KarateBasicTest {
    static {
        System.setProperty("karate.ssl", "true");
    }
    
    @Karate.Test
    @Order(2)
    Karate testMarvelApi() {
        return Karate.run("classpath:features/marvel/marvelCharactersApi.feature");
    }

}

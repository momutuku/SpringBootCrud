package sai;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Objects;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

@SpringBootApplication
@ComponentScan
public class CRUDoperations {

	public static void main(String[] args)throws IOException {
        ClassLoader classLoader = CRUDoperations.class.getClassLoader();

        
            File file = new File(Objects
                    .requireNonNull(classLoader.getResource("service_account_pk.json")).getFile());
            FileInputStream service_account_pk;
            service_account_pk = new FileInputStream(file.getAbsolutePath());
            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(service_account_pk))
                    .build();

            FirebaseApp.initializeApp(options);
        

		SpringApplication.run(CRUDoperations.class, args);

	}

}

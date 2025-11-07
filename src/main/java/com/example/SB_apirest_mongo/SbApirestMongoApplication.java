package com.example.SB_apirest_mongo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SbApirestMongoApplication
	
	// 1. need this for war apps
	//extends SpringBootServletInitializer
{

	public static void main(String[] args) {
		SpringApplication.run(SbApirestMongoApplication.class, args);
	}
	
	
	// 2. war apps
	/*@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(SbApirestMongoApplication.class);
    }*/

}

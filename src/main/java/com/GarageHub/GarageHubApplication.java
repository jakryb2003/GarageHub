package com.GarageHub;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class GarageHubApplication {

	static void main(String[] args) {
		SpringApplication.run(GarageHubApplication.class, args);
	}

}

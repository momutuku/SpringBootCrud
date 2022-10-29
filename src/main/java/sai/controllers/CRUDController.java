package sai.controllers;

import org.springframework.web.bind.annotation.RestController;

import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;

import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
public class CRUDController {
	
	public CRUDService crudservice;
	
	public CRUDController(CRUDService crudservice) {
		this.crudservice =crudservice;
	}

	
	@GetMapping("/get")
	public  List<ImageUrl> getCRUD(@RequestParam String url)throws Exception{
		
		return crudservice.getCRUD(url);
	}
	
	
	@GetMapping("/test")
	public ResponseEntity<String> testGetEndpoint(){
		
		return ResponseEntity.ok("Test Successfull");
	}
	

	
}

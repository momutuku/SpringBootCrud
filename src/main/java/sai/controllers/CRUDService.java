package sai.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

import org.springframework.stereotype.Service;

import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentChange;
import com.google.cloud.firestore.DocumentReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.EventListener;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.FirestoreException;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.FirebaseException;
import com.google.firebase.cloud.FirestoreClient;

@Service
public class CRUDService {


	public List<ImageUrl> getCRUD(String url) throws InterruptedException, ExecutionException {
		// TODO Auto-generated method stub
		Firestore dbFire= FirestoreClient.getFirestore();


		ApiFuture<QuerySnapshot> future = dbFire.collection("imageURLs").get();
		// future.get() blocks on response
		List<QueryDocumentSnapshot> documents = future.get().getDocuments();
		 List<ImageUrl> list = new ArrayList<>();
		    
		for (QueryDocumentSnapshot document : documents) {
		  System.out.println(document.getId() + " => " + document.get("url"));
		  ImageUrl img = new ImageUrl(document.get("url").toString());
		  list.add(img);
		  
		}
		
		return list;
	}

}

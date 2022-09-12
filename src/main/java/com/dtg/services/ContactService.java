package com.dtg.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dtg.entities.Contact;
import com.dtg.repositories.ContactRepo;

@Service
public class ContactService {

	@Autowired
	private ContactRepo contactRepo;
	
	public Contact saveContact(Contact contact) {
		return contactRepo.save(contact);
	}
}

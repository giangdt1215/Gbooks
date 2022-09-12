package com.dtg.dto;

import java.io.Serializable;

public class AjaxResponse implements Serializable {

	private static final long serialVersionUID = -2659871180485618511L;

	private String message;
	private int statusCode;
	
	public AjaxResponse() {}

	public AjaxResponse(String message, int statusCode) {
		this.message = message;
		this.statusCode = statusCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getStatusCode() {
		return statusCode;
	}

	public void setStatusCode(int statusCode) {
		this.statusCode = statusCode;
	}

}

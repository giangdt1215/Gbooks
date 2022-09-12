package com.dtg.dto;

public class CartAjaxReponse extends AjaxResponse{

	private static final long serialVersionUID = 8715207025784167073L;
	
	private String itemCost;
	private int quantity;
	private String cost;
	private String shipFee;
	private String totalCost;
	private boolean empty;
	
	public CartAjaxReponse() {}
	
	public CartAjaxReponse(String message, int statusCode) {
		super(message, statusCode);
	}

	public String getItemCost() {
		return itemCost;
	}

	public void setItemCost(String itemCost) {
		this.itemCost = itemCost;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getCost() {
		return cost;
	}

	public void setCost(String cost) {
		this.cost = cost;
	}

	public String getShipFee() {
		return shipFee;
	}

	public void setShipFee(String shipFee) {
		this.shipFee = shipFee;
	}

	public String getTotalCost() {
		return totalCost;
	}

	public void setTotalCost(String totalCost) {
		this.totalCost = totalCost;
	}

	public boolean isEmpty() {
		return empty;
	}

	public void setEmpty(boolean empty) {
		this.empty = empty;
	}
	
	
}
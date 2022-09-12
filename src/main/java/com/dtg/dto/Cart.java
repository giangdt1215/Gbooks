package com.dtg.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.dtg.constants.IConstants;

public class Cart implements Serializable, IConstants{

	private static final long serialVersionUID = -1936922647177476705L;

	private List<CartItem> cartItems = new ArrayList<CartItem>();
	private BigDecimal cost;

	public List<CartItem> getCartItems() {
		return cartItems;
	}

	public void setCartItems(List<CartItem> cartItems) {
		this.cartItems = cartItems;
	}
	
	public int getTotalCartItemQuantity() {
		int total = 0;
		for (CartItem cartItem : cartItems) {
			total += cartItem.getQuantity();
		}
		return total;
	}
	
	public void setCost(BigDecimal cost) {
		this.cost = cost;
	}

	public BigDecimal getCost() {
		BigDecimal total = new BigDecimal(0);
		for (CartItem cartItem : cartItems) {
			total = total.add(cartItem.getProductPrice().multiply(BigDecimal.valueOf(cartItem.getQuantity())));
		}
		this.cost = total;
		return total;
	}
	
	public BigDecimal getTotalCost() {
		if(this.cost.compareTo(SHIP_CONDITION) < 0 ) {
			this.cost = this.cost.add(SHIP_FEE);
		}
		return this.cost;
	}

	public BigDecimal getShipFee() {
		return SHIP_FEE;
	}
	
	public BigDecimal getShipCondition() {
		return SHIP_CONDITION;
	}
}

package com.dtg.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class OrderDetailsId implements Serializable {

	private static final long serialVersionUID = -7566443499393912005L;

	@Column(name = "order_id", nullable = false)
	private Integer orderId;
	
	@Column(name = "product_id", nullable = false)
	private Integer productId;

	public Integer getOrderId() {
		return orderId;
	}

	public void setOrderId(Integer orderId) {
		this.orderId = orderId;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;

		OrderDetailsId compareObj = (OrderDetailsId) obj;

		if (!productId.equals(compareObj.getProductId()))
			return false;
		return orderId.equals(compareObj.getOrderId());
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((orderId == null) ? 0 : orderId.hashCode());
		result = prime * result + ((productId == null) ? 0 : productId.hashCode());
		return result;
	}
}

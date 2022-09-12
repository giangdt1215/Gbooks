package com.dtg.entities;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class ProductsAuthorId implements Serializable {

	private static final long serialVersionUID = -6251117288386885914L;

	@Column(name = "product_id", nullable = false)
	private Integer productId;
	
	@Column(name = "author_id", nullable = false)
	private Integer authorId;

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getAuthorId() {
		return authorId;
	}

	public void setAuthorId(Integer authorId) {
		this.authorId = authorId;
	}
	
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;

		ProductsAuthorId compareObj = (ProductsAuthorId) obj;

		if (!productId.equals(compareObj.getProductId()))
			return false;
		return authorId.equals(compareObj.getAuthorId());
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((productId == null) ? 0 : productId.hashCode());
		result = prime * result + ((authorId == null) ? 0 : authorId.hashCode());
		return result;
	}
}

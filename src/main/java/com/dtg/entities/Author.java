package com.dtg.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_author")
public class Author extends BaseEntity{

	private static final long serialVersionUID = -7493634919392631143L;

	@Column(name = "name", nullable = false)
	private String name;
	
	@OneToMany(cascade = CascadeType.MERGE, fetch = FetchType.LAZY, mappedBy = "author")
	private List<ProductsAuthor> productsAuthor = new ArrayList<ProductsAuthor>();

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<ProductsAuthor> getProductsAuthor() {
		return productsAuthor;
	}

	public void setProductsAuthor(List<ProductsAuthor> productsAuthor) {
		this.productsAuthor = productsAuthor;
	}
}

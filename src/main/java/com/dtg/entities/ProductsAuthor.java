package com.dtg.entities;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_products_author")
public class ProductsAuthor implements Serializable{

	private static final long serialVersionUID = -5037853618741740015L;

	@EmbeddedId
	private ProductsAuthorId productsAuthorId = new ProductsAuthorId();
	
	@Column(name = "created_date", nullable = false)
	private LocalDateTime createdDate;
	
	@Column(name = "updated_date", nullable = true)
	private LocalDateTime updatedDate;
	
	@Column(name = "created_by", nullable = true)
	private Integer createdBy;
	
	@Column(name = "updated_by", nullable = true)
	private Integer updatedBy;
	
	@Column(name = "status", nullable = true)
	private Boolean status = Boolean.FALSE;

	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@MapsId("product_id")
	@JoinColumn(name = "product_id")
	private Product product;
	
	@ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@MapsId("author_id")
	@JoinColumn(name = "author_id")
	private Author author;

	public ProductsAuthorId getProductsAuthorId() {
		return productsAuthorId;
	}

	public void setProductsAuthorId(ProductsAuthorId productsAuthorId) {
		this.productsAuthorId = productsAuthorId;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
		this.productsAuthorId.setProductId(product.getId());
	}

	public Author getAuthor() {
		return author;
	}

	public void setAuthor(Author author) {
		this.author = author;
		this.productsAuthorId.setAuthorId(author.getId());
	}

	public LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public LocalDateTime getUpdatedDate() {
		return updatedDate;
	}

	public void setUpdatedDate(LocalDateTime updatedDate) {
		this.updatedDate = updatedDate;
	}

	public Integer getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Integer createdBy) {
		this.createdBy = createdBy;
	}

	public Integer getUpdatedBy() {
		return updatedBy;
	}

	public void setUpdatedBy(Integer updatedBy) {
		this.updatedBy = updatedBy;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}
}

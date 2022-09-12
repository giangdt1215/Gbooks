package com.dtg.entities;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "tbl_products")
public class Product extends BaseEntity{

	private static final long serialVersionUID = -6264927438730916072L;

	@Column(name = "name", nullable = false)
	private String name;
	
	@Column(name = "price", nullable = false, precision = 13, scale = 2)
	private BigDecimal price;
	
	@Column(name = "short_description", nullable = false)
	private String shortDescription;
	
	@Column(name = "detail_description", nullable = false, columnDefinition = "TEXT")
	private String detailDescription;
	
	@Column(name = "avatar", nullable = false)
	private String avatar;
	
	@Column(name = "publishing", nullable = false)
	private String publishing;
	
	@Column(name = "release_date", nullable = false)
	@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	private LocalDateTime releaseDate;
	
	@Column(name = "dimension", nullable = true)
	private String dimension;
	
	@Column(name = "pages", nullable = false)
	private Integer pages;
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id")
	private Category category;
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "product")
	private List<ProductImages> images = new ArrayList<ProductImages>();
	
	@OneToMany(cascade = {CascadeType.PERSIST, CascadeType.DETACH, CascadeType.REFRESH, CascadeType.REMOVE},
			fetch = FetchType.LAZY, mappedBy = "product")
	private List<ProductsAuthor> productsAuthors = new ArrayList<ProductsAuthor>();
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "product")
	private List<OrderDetails> orderDetails = new ArrayList<OrderDetails>();
	
	public void addProductImage(ProductImages productImages) {
		this.images.add(productImages);
		productImages.setProduct(this);
	}
	
	public void removeProductImage(ProductImages productImages) {
		this.images.remove(productImages);
		productImages.setProduct(null);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getDetailDescription() {
		return detailDescription;
	}

	public void setDetailDescription(String detailDescription) {
		this.detailDescription = detailDescription;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getPublishing() {
		return publishing;
	}

	public void setPublishing(String publishing) {
		this.publishing = publishing;
	}

	public LocalDateTime getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(LocalDateTime releaseDate) {
		this.releaseDate = releaseDate;
	}

	public String getDimension() {
		return dimension;
	}

	public void setDimension(String dimension) {
		this.dimension = dimension;
	}

	public Integer getPages() {
		return pages;
	}

	public void setPages(Integer pages) {
		this.pages = pages;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public List<ProductImages> getImages() {
		return images;
	}

	public void setImages(List<ProductImages> images) {
		this.images = images;
	}

	public List<ProductsAuthor> getProductsAuthors() {
		return productsAuthors;
	}

	public void setProductsAuthors(List<ProductsAuthor> productsAuthors) {
		this.productsAuthors = productsAuthors;
	}

	public List<OrderDetails> getOrderDetails() {
		return orderDetails;
	}

	public void setOrderDetails(List<OrderDetails> orderDetails) {
		this.orderDetails = orderDetails;
	}
	
	public String getFormattedDate(LocalDateTime dateTime){
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy");
        return dateTime.format(formatter);
	}
	
	public String getDateFromDateTime(LocalDateTime dateTime) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
		return dateTime.format(formatter);
	}
}

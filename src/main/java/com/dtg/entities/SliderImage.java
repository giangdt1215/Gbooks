package com.dtg.entities;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_slider_images")
public class SliderImage extends BaseEntity {

	private static final long serialVersionUID = 1918647293179083761L;

	@Column(name = "path", length = 200, nullable = false)
	private String path;

	@Column(name = "description", length = 250, nullable = false)
	private String description;

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getFormattedDate(LocalDateTime dateTime) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm dd/MM/yyyy");
		return dateTime.format(formatter);
	}
}

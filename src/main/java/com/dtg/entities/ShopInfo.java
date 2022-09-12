package com.dtg.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_info")
public class ShopInfo extends BaseEntity {

	private static final long serialVersionUID = 8426165751825241416L;

	@Column(name = "gioi_thieu", nullable = true, columnDefinition = "TEXT")
	private String gioiThieu;

	@Column(name = "cs_van_chuyen", nullable = true, columnDefinition = "TEXT")
	private String csVanChuyen;

	@Column(name = "cs_bao_mat", nullable = true, columnDefinition = "TEXT")
	private String csBaoMat;

	@Column(name = "quy_dinh_su_dung", nullable = true, columnDefinition = "TEXT")
	private String qdSuDung;

	@Column(name = "cs_doi_tra_hoan_tien", nullable = true, columnDefinition = "TEXT")
	private String csDoiTraHoanTien;

	public String getGioiThieu() {
		return gioiThieu;
	}

	public void setGioiThieu(String gioiThieu) {
		this.gioiThieu = gioiThieu;
	}

	public String getCsVanChuyen() {
		return csVanChuyen;
	}

	public void setCsVanChuyen(String csVanChuyen) {
		this.csVanChuyen = csVanChuyen;
	}

	public String getCsBaoMat() {
		return csBaoMat;
	}

	public void setCsBaoMat(String csBaoMat) {
		this.csBaoMat = csBaoMat;
	}

	public String getQdSuDung() {
		return qdSuDung;
	}

	public void setQdSuDung(String qdSuDung) {
		this.qdSuDung = qdSuDung;
	}

	public String getCsDoiTraHoanTien() {
		return csDoiTraHoanTien;
	}

	public void setCsDoiTraHoanTien(String csDoiTraHoanTien) {
		this.csDoiTraHoanTien = csDoiTraHoanTien;
	}

}

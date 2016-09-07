package com.socialnet.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

import com.opensymphony.xwork2.validator.annotations.DateRangeFieldValidator;
import com.opensymphony.xwork2.validator.annotations.StringLengthFieldValidator;


@Entity(name="details")
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class Details {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="details_id")
	private long id;
	
	@Column
	private String occupation;
	
	@Column
	private String address;

	@Column
	private String description;
	
	@Temporal(TemporalType.DATE)
	private Date birthday;

	@StringLengthFieldValidator(maxLength="50", message="Occupation must be less than ${maxLength} characters",fieldName="description")
	public String getOccupation() {
		return occupation;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}

	@StringLengthFieldValidator(maxLength="50", message="Address must be less than ${maxLength} characters",fieldName="description")
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@DateRangeFieldValidator(min="01/01/1916",message="Birthday must be after ${min}",fieldName="birthday")
	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	@StringLengthFieldValidator(maxLength="250", message="Description must be less than ${maxLength} characters",fieldName="description")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
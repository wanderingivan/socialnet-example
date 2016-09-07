package com.socialnet.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity(name="images")
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class Image {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="image_id")
	private long id;
	
	@Column
	private String imagePath;
	
	@Column
	private String description;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date uploaded;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="user_id")
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	private User owner;

	public Image(){
		super();
	}
	public Image(String imagePath) {
		super();
		this.imagePath= imagePath;
	}

	public Image(String imagePath,String description){
		this(imagePath);
		this.description = description;
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getUploaded() {
		return uploaded;
	}

	public void setUploaded(Date uploaded) {
		this.uploaded = uploaded;
	}

	public User getOwner() {
		return owner;
	}

	public void setOwner(User owner) {
		this.owner = owner;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Image [imagePath=").append(imagePath)
				.append(", description=").append(description).append("]");
		return builder.toString();
	}
	

}
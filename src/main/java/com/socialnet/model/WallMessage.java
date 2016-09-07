package com.socialnet.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;

@Entity(name="wall_messages")
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class WallMessage {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="wall_message_id")
	private long id;
	
	@Column(nullable=false)
	private String message;
	
	@Column
	private String imagePath;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date sent;
	
	@ManyToOne
	@JoinColumn(name="wall_post_id")
	private WallPost wallPost;
	
	@OneToOne
	@JoinColumn(name="sender_id")
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	private User poster;

	public WallMessage(){
		super();
	}
	
	public WallMessage(String message, WallPost wallPost, User poster) {
		super();
		this.message = message;
		this.wallPost = wallPost;
		this.poster = poster;
	}

	public WallMessage(String message, WallPost wallPost,
			User poster, String imagePath) {
		this(message,wallPost,poster);
		this.imagePath = imagePath;
	}



	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Date getSent() {
		return sent;
	}

	public void setSent(Date sent) {
		this.sent = sent;
	}

	public WallPost getWallPost() {
		return wallPost;
	}

	public void setWallPost(WallPost wallPost) {
		this.wallPost = wallPost;
	}

	public User getPoster() {
		return poster;
	}

	public void setPoster(User poster) {
		this.poster = poster;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}



	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("WallMessage [id=").append(id).append(", message=")
				.append(message).append(", imagePath=").append(imagePath)
				.append(", poster=").append(poster).append("]");
		return builder.toString();
	}
	

	
}

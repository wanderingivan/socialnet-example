package com.socialnet.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.OrderBy;

@NamedNativeQueries({
	@NamedNativeQuery(name="addWallPost",
					  query="CALL addWallPost(:sender,:receiver,:message,:imagePath)"),
	@NamedNativeQuery(name="addWallMessage",
					  query="CALL addWallMessage(:sender,:wallPostId,:message)",
					  resultClass=WallMessage.class)
})
@Entity(name="wall_posts")
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class WallPost {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="wall_post_id")
	private long id;
	
	@OneToMany(mappedBy="wallPost",fetch=FetchType.LAZY)
	@OrderBy(clause="sent asc")
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	private List<WallMessage> messages;
	
	@OneToMany(mappedBy="wallPost",fetch=FetchType.LAZY)
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	private List<Like> likes;
	
	@ManyToOne
	@JoinColumn(name="owner_id")
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	private User owner;
	

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public List<WallMessage> getMessages() {
		return messages;
	}

	public void setMessages(List<WallMessage> messages) {
		this.messages = messages;
	}

	public void addMessage(WallMessage message){
		if(this.messages == null){
			
			messages = new ArrayList<>();
		}
		this.messages.add(message);
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
		builder.append("WallPost [id=").append(id).append(", messages=")
				.append(messages).append(", owner=").append(owner).append("]");
		return builder.toString();
	}

	public List<Like> getLikes() {
		return likes;
	}

	public void setLikes(List<Like> likes) {
		this.likes = likes;
	}

}

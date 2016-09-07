package com.socialnet.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;

@NamedNativeQueries({
	@NamedNativeQuery(name="addLike",
					  query="CALL addLike(:sender,:postId)"
	)
})
@Entity(name="likes")
public class Like {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="likes_id")
	private long id;
	
	@ManyToOne()
	@JoinColumn(name="wall_post_id")
	private WallPost wallPost;
	
	@ManyToOne()
	@JoinColumn(name="sender_id")
	private User user;
	
	public Like(){}

	public Like(WallPost wallPost, User user) {
		super();
		this.wallPost = wallPost;
		this.user = user;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public WallPost getWallPost() {
		return wallPost;
	}

	public void setWallPost(WallPost wallPost) {
		this.wallPost = wallPost;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
}

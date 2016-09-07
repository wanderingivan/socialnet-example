package com.socialnet.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeSet;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.OrderBy;
import org.hibernate.annotations.SortComparator;

import com.socialnet.util.ChatComparator;
import com.opensymphony.xwork2.validator.annotations.EmailValidator;
import com.opensymphony.xwork2.validator.annotations.RequiredStringValidator;
import com.opensymphony.xwork2.validator.annotations.StringLengthFieldValidator;

@Entity(name="users")
@Cache(usage=CacheConcurrencyStrategy.READ_WRITE)
public class User {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="user_id")
	private long id;
	
	@Column(nullable=false)
	private String username;

	@Column(nullable=false)
	private String email;
	
	@Column(nullable=false)
	private String password;
	
	@Column
	private boolean enabled;

	@Column
	private String profilePic;
	
	@Column
	private String coverImage;
	
	@Temporal(TemporalType.TIMESTAMP)
	private Date createdOn;
	
	@OneToOne(fetch=FetchType.LAZY, orphanRemoval=true)
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	@JoinColumn(name="details_id")
	private Details details;
	
	@OneToMany(mappedBy="owner",fetch=FetchType.LAZY, orphanRemoval=true)
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	private List<Image> gallery;
	
	@OneToMany(mappedBy="owner",fetch=FetchType.LAZY, orphanRemoval=true)
	@OrderBy(clause = "id desc")
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	private List<WallPost> wallPosts;
	
	@OneToMany(mappedBy="receiver",fetch=FetchType.LAZY, orphanRemoval=true)
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	private List<FriendRequest> friendRequests;
	
	@ManyToMany(fetch=FetchType.LAZY)
	@JoinTable(name="friendships",joinColumns={@JoinColumn(name="user1_id")}
	                             ,inverseJoinColumns={@JoinColumn(name="user2_id")})
	@Cache(usage=CacheConcurrencyStrategy.NONSTRICT_READ_WRITE)
	private Set<User> friends;
	
	@SortComparator(value=ChatComparator.class) // Necessary since order by tries to load latUpdate column from join table
	@ManyToMany(fetch=FetchType.LAZY,targetEntity=Chat.class)
	@JoinTable(name="chats_join_table",joinColumns={@JoinColumn(name="user_id")}
									  ,inverseJoinColumns={@JoinColumn(name="chat_id")})
	private SortedSet<Chat> chats = new TreeSet<>();

	public User(){
		super();
	}
	
	public User(String username,String email,String password){
		this.username = username;
		this.email = email;
		this.password = password;
	}
	
	public User(long userId) {
		this.id = userId;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	@RequiredStringValidator(message="Username is required",fieldName="username")
	@StringLengthFieldValidator(minLength="5",maxLength="50",
								message="Username length must be between ${minLength} and ${maxLength} chars",fieldName="username")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@RequiredStringValidator(message="Email is required",fieldName="email")
	@EmailValidator(message="A valid email is required",fieldName="email")
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	@RequiredStringValidator(message="Password is required",fieldName="password")
	@StringLengthFieldValidator(minLength="5",maxLength="50",
								message="Password length must be between ${minLength} and ${maxLength} characters",fieldName="password")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getProfilePic() {
		return profilePic;
	}

	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}

	public Details getDetails() {
		return details;
	}

	public void setDetails(Details details) {
		this.details = details;
	}

	public List<Image> getGallery() {
		return gallery;
	}

	public void setGallery(List<Image> gallery) {
		this.gallery = gallery;
	}

	public List<WallPost> getWallPosts() {
		return wallPosts;
	}

	public void setWallPosts(List<WallPost> wallPosts) {
		this.wallPosts = wallPosts;
	}

	public List<FriendRequest> getFriendRequests() {
		return friendRequests;
	}

	public void setFriendRequests(List<FriendRequest> friendRequests) {
		this.friendRequests = friendRequests;
	}


	public Set<User> getFriends() {
		if(friends ==null){setFriends(new HashSet<User>());}
		return friends;
	}

	public void setFriends(Set<User> friends) {
		this.friends = friends;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public SortedSet<Chat> getChats() {
		return  chats;
	}

	public void setChats(SortedSet<Chat> chats) {
		this.chats = chats;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public String getCoverImage() {
		return coverImage;
	}

	public void setCoverImage(String coverImage) {
		this.coverImage = coverImage;
	}

	public void addFriend(User user) {
		getFriends().add(user);
		
	}

	public void removeFriend(User user) {
		getFriends().remove(user);
	}

	public boolean isFriends(String username){
		if(username.equals(this.username)){return false;}
		User u = new User();
		u.setUsername(username);
		return friends.contains(u);
	}

	public void addImage(Image image){
		if(getGallery() == null){setGallery(new ArrayList<Image>());}
		getGallery().add(image);
	}
	
	public void removeFromGallery(Image image) {
		if(getGallery() != null){
			getGallery().remove(image);
		}
	}
	
	public void addPost(WallPost post) {
		if(getWallPosts() == null){setWallPosts(new ArrayList<WallPost>());}
		getWallPosts().add(post);
	}
	
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [id=").append(id).append(", username=")
				.append(username).append(", email=").append(email)
				.append(", enabled=").append(enabled).append("]");
		return builder.toString();
	}


	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((username == null) ? 0 : username.hashCode());
		return result;
	}


	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof User))
			return false;
		User other = (User) obj;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}
	
}
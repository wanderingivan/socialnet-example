package com.socialnet.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.FetchProfile;
import org.hibernate.annotations.OrderBy;


@Entity(name="chats")
@FetchProfile( name="full",fetchOverrides={@FetchProfile.FetchOverride(entity=Chat.class,association="users",mode=FetchMode.JOIN),
                                           @FetchProfile.FetchOverride(entity=Chat.class,association="messages",mode=FetchMode.JOIN)})
public class Chat implements Comparable<Chat> {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="chat_id")
	private long id;
	
	@ManyToMany()
	@JoinTable(name="chats_join_table", joinColumns={@JoinColumn(name="chat_id")}
									, inverseJoinColumns={@JoinColumn(name="user_id")})
	private List<User> users;
	
	@OneToMany(mappedBy="chat", fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@OrderBy(clause="sent desc")
	private List<Message> messages;

	@Temporal(TemporalType.TIMESTAMP)
	private Date lastUpdate;
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public List<Message> getMessages() {
		return messages;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}

	public Date getLastUpdate() {
		return lastUpdate;
	}
	
	public void setLastUpdate(Timestamp lastUpdate) {
		this.lastUpdate = lastUpdate;
	}
	
	public void addMessage(Message message){
		if(messages == null){
			messages = new ArrayList<>();
		}
		messages.add(message);
		setLastUpdate(new Timestamp(System.currentTimeMillis()));
	}
	
	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public void addUser(User user){
		if(users ==null){
			users = new ArrayList<User>();
		}
		users.add(user);
	}
	
	public User getOther(String username){
		for(User u : users){
			if(!(u.getUsername().equals(username))){
				return u;
				
			}
		}
		return null;
	}
	
	@Override
	public String toString() {
		return "Conversation [id=" + id + ", messages=" + messages
				+ ", lastUpdate=" + lastUpdate + "]";
	}

	@Override
	public int compareTo(Chat o) {
		return this.lastUpdate.compareTo(o.getLastUpdate());
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (id ^ (id >>> 32));
		result = prime * result
				+ ((lastUpdate == null) ? 0 : lastUpdate.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (!(obj instanceof Chat))
			return false;
		Chat other = (Chat) obj;
		if (id != other.id)
			return false;
		if (lastUpdate == null) {
			if (other.lastUpdate != null)
				return false;
		} else if (!lastUpdate.equals(other.lastUpdate))
			return false;
		return true;
	}
	
	
}

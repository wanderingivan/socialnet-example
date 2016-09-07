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



@NamedNativeQueries({@NamedNativeQuery(name="sendFriendRequest",
									   query="CALL sendFriendRequest(:sender,:receiver)")
					})
@Entity(name="friend_requests")
public class FriendRequest {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="friend_request_id")
	private long id;
	
	@Column
	private boolean accepted;
	
	@Column
	private boolean denied;
	
	@ManyToOne
	@JoinColumn(name="sender_id")
	private User sender;
	
	@ManyToOne
	@JoinColumn(name="receiver_id")
	private User receiver;

	public FriendRequest(){
		super();
	}
	
	public FriendRequest(User sender,
			User receiver) {
		super();
		this.sender = sender;
		this.receiver = receiver;
		
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public boolean isAccepted() {
		return accepted;
	}

	public void setAccepted(boolean accepted) {
		this.accepted = accepted;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public User getReceiver() {
		return receiver;
	}

	public void setReceiver(User receiver) {
		this.receiver = receiver;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("FriendRequest [id=").append(id).append(", accepted=")
				.append(accepted).append(", sender=").append(sender)
				.append(", receiver=").append(receiver).append("]");
		return builder.toString();
	}
}

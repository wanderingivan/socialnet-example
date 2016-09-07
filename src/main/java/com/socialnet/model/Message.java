package com.socialnet.model;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedNativeQueries;


@NamedNativeQueries({
	@NamedNativeQuery(
			name = "addMessageToChat",
			query = "CALL addMessage(:sender,:chatId,:message)",
			resultClass = Message.class
	),
	@NamedNativeQuery(
			name = "sendMessage",
			query = "CALL sendMessage(:msg,:sender,:receiver)"
    ),
	@NamedNativeQuery(
			name = "unread",
			query = "CALL unread(:username)",
			resultClass= Message.class
	)
})
@Entity(name="chat_messages")
public class Message {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="message_id")
	private long id;
	
	@Column(nullable=false)
	private String message;
	
	@Column
	private Timestamp sent;

	@ManyToOne
	@JoinColumn(name="sender_id")
	private User sender;
	
	@ManyToOne
	@JoinColumn(name="chat_id")
	private Chat chat;
	
	public Message(){
		super();
	}
	
	public Message(User sender, String message,Chat chat) {
		super();
		this.sender = sender;
		this.message = message;
		this.chat = chat;
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

	public Timestamp getSent() {
		return sent;
	}

	public void setSent(Timestamp sent) {
		this.sent = sent;
	}

	public User getSender() {
		return sender;
	}

	public void setSender(User sender) {
		this.sender = sender;
	}

	public Chat getChat() {
		return chat;
	}

	public void setChat(Chat chat) {
		this.chat = chat;
	}

	
	@Override
	public String toString() {
		return "Message [id=" + id + ", message=" + message + ", sent=" + sent
				+ ", sender=" + sender + ", chat=" + chat.getId() + "]";
	}

	
	
	
}

package com.socialnet.util;

import java.util.Comparator;

import com.socialnet.model.Chat;

public class ChatComparator implements Comparator<Chat> {

	@Override
	public int compare(Chat chat1, Chat chat2) {
		return chat2.getLastUpdate().compareTo(chat1.getLastUpdate());
	}

}

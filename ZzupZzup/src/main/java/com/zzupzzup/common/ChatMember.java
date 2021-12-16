package com.zzupzzup.common;

import com.zzupzzup.service.domain.Member;

public class ChatMember {
	
	///Field
	private int chatNo;
	private Member member;
	private boolean readyCheck;
	private boolean chatLeaderCheck;
	
	///Constructor
	public ChatMember() {
	}

	///Method
	public int getChatNo() {
		return chatNo;
	}


	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}


	public Member getMember() {
		return member;
	}


	public void setMember(Member member) {
		this.member = member;
	}


	public boolean isReadyCheck() {
		return readyCheck;
	}


	public void setReadyCheck(boolean readyCheck) {
		this.readyCheck = readyCheck;
	}


	public boolean isChatLeaderCheck() {
		return chatLeaderCheck;
	}


	public void setChatLeaderCheck(boolean chatLeaderCheck) {
		this.chatLeaderCheck = chatLeaderCheck;
	}
	
	
	@Override
	public String toString() {
		return "ChatMember : [chatNo] "+chatNo+" [member] "+member+" [readyCheck] "+readyCheck+" [chatLeaderCheck] "+ chatLeaderCheck;
	}
	

}

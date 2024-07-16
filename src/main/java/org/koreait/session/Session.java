package org.koreait.session;

import org.koreait.dto.Member;

public class Session {  //로그인 로그아웃 기능을 모아두는 장소로 활용
    public Member loginedMember;
    public int loginedMemberId;

    public Session() {
        loginedMember = null;
        loginedMemberId = -1;
    }

    public void login(Member member) {
        loginedMember = member;
        loginedMemberId = member.getId();
    }

    public void logout() {
        loginedMember = null;
        loginedMemberId = -1;
    }

    public boolean isLogined() {
        return loginedMemberId != -1;
    }
}

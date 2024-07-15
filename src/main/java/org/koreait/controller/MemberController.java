package org.koreait.controller;

import org.koreait.dto.Member;
import org.koreait.service.MemberService;
import org.koreait.util.DBUtil;
import org.koreait.util.SecSql;

import java.sql.Connection;
import java.util.Scanner;

public class MemberController {
    private Connection conn;
    private Scanner sc;

    private MemberService memberService;

    public MemberController(Scanner sc, Connection conn) {
        this.sc = sc;
        this.conn = conn;
        this.memberService = new MemberService(conn);
    }

    public void doJoin() {
        String loginId = null;
        String loginPw = null;
        String loginPwConfirm = null;
        String name = null;

        System.out.println("==회원가입==");
        while (true) {
            System.out.print("로그인 아이디 : ");
            loginId = sc.nextLine().trim();

            if (loginId.length() == 0 || loginId.contains(" ")) {
                System.out.println("아이디를 다시 입력해주세요");
                continue;
            }

            boolean isLoindIdDup = memberService.isLoginIdDup(conn, loginId);

            if (isLoindIdDup) {
                System.out.println(loginId + "는(은) 이미 사용중인 아이디 입니다");
                continue;
            }
            break;
        }
        while (true) {
            System.out.print("비밀번호 : ");
            loginPw = sc.nextLine().trim();

            if (loginPw.length() == 0 || loginPw.contains(" ")) {
                System.out.println("비밀번호를 다시 입력해주세요");
                continue;
            }

            boolean loginPwCheck = true;

            while (true) {
                System.out.print("비밀번호 확인 : ");
                loginPwConfirm = sc.nextLine().trim();

                if (loginPwConfirm.length() == 0 || loginPwConfirm.contains(" ")) {
                    System.out.println("비밀번호 확인을 다시 입력해주세요");
                    continue;
                }
                if (loginPw.equals(loginPwConfirm) == false) {
                    System.out.println("비밀번호가 일치하지 않습니다.");
                    loginPwCheck = false;
                }
                break;
            }
            if (loginPwCheck) {
                break;
            }
        }

        while (true) {
            System.out.print("이름 : ");
            name = sc.nextLine();

            if (name.length() == 0 || name.contains(" ")) {
                System.out.println("이름을 다시 입력해주세요");
                continue;
            }
            break;
        }

        SecSql sql = new SecSql();

        sql.append("INSERT INTO `member`");
        sql.append("SET regDate = NOW(),");
        sql.append("updateDate = NOW(),");
        sql.append("loginId = ?,", loginId);
        sql.append("loginPw= ?,", loginPw);
        sql.append("name = ?;", name);

        int id = DBUtil.insert(conn, sql);

        System.out.println(id + "번 회원이 생성되었습니다");

    }

    public void login() {
        String loginId = null;
        String loginPw = null;

        System.out.println("== 로그인 ==");

        while (true) {
            System.out.print("ID : ");
            loginId = sc.nextLine().trim();

            if (loginId.length() == 0 || loginId.contains(" ")) {
                System.out.println("ID를 입력해주세요.");
                continue;
            }

            boolean isLoginIdDup = memberService.isLoginIdDup(conn, loginId);   // ID 있는지 없는지 확인.

            if (isLoginIdDup == false) {
                System.out.println(loginId + "는(은) 없는 아이디 입니다.");
                continue;
            }
            break;
        }

        Member member = memberService.getMemberByLoginId(loginId);

        int tryMaxCount = 3;
        int tryCount = 0;

        while (true) {
            if(tryCount >= tryMaxCount) {
                System.out.println("비밀번호를 다시 확인하고 시도해주십시오.");
                break;
            }

            System.out.print("PW : ");
            loginPw = sc.nextLine().trim();

            if (loginPw.length() == 0 || loginPw.contains(" ")) {
                tryCount++;
                System.out.println("비밀번호를 입력하세요.");
                continue;
            }

            if(member.getLoginPw().equals(loginPw) == false) {
                tryCount++;
                System.out.println("비밀번호가 일치하지 않습니다.");
                continue;
            }

            System.out.println(loginId + "님 환영합니다!");
            break;
        }
    }
}

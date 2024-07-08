package org.koreait;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        System.out.println("== 프로그램 시작 ==");
        Scanner sc = new Scanner(System.in);

        int lastArticleId = 0;
        List<Article> articles = new ArrayList<>();

        while (true) {
            System.out.print("명령어> ");
            String cmd = sc.nextLine().trim();

            if (cmd.length() == 0) {
                System.out.println("명령어를 입력해주세요.");
                continue;
            }

            if (cmd.equals("article exit")) {
                System.out.println("프로그램 종료");
                break;
            }

            if (cmd.equals("article write")) {
                int id = lastArticleId + 1;
                System.out.println("== article write ==");
                System.out.print("title: ");
                String title = sc.nextLine();
                System.out.print("body: ");
                String body = sc.nextLine();
                System.out.println(id + "번 게시글이 작성되었습니다.");

                Article article = new Article(id, title, body);
                articles.add(article);

                System.out.println(article);

                lastArticleId++;

                // JDBC nsert 추가
                Connection conn = null;
                PreparedStatement pstmt = null;     //insert 하려면 이게 필요하다.

                try {
                    Class.forName("org.mariadb.jdbc.Driver");
                    String url = "jdbc:mariadb://127.0.0.1:3306/AM_JDBC_2024_07?useUnicode=true&characterEncoding=utf8&autoReconnect=true&serverTimezone=Asia/Seoul";
                    conn = DriverManager.getConnection(url, "root", "");
                    System.out.println("연결 성공!");

                    String sql = "INSERT INTO article ";
                    sql += "SET regDate = NOW(), ";
                    sql += "updateDate = NOW(), ";
                    sql += "title = '" + title + "', ";
                    sql += "`body` = '" + body + "';";

                    System.out.println(sql);

                    pstmt = conn.prepareStatement(sql);

                    int affectedRows = pstmt.executeUpdate();

                    System.out.println("affected rows: " + affectedRows);

                } catch (ClassNotFoundException e) {
                    System.out.println("드라이버 로딩 실패" + e);
                } catch (SQLException e) {
                    System.out.println("에러 : " + e);
                } finally {
                    try {
                        if (conn != null && !conn.isClosed()) {
                            conn.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                    try {
                        if (pstmt != null && !pstmt.isClosed()) {
                            pstmt.close();
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            } else if (cmd.equals("article list")) {
                System.out.println("== article list ==");
                if (articles.size() == 0) {
                    System.out.println("등록된 게시글이 없습니다.");
                    continue;
                }
                System.out.println("  id  //   title   //   body   ");
                for (int i = articles.size() - 1; i >= 0; i--) {
                    Article article = articles.get(i);
                    System.out.printf("  %d   //    %s    //   %s    \n", article.getId(), article.getTitle(), article.getBody());
                }

            }
        }

    }
}
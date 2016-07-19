<%--
  - 작성자: 부현경(boohk)
  - 일자: 2016.07.18
  - 저작권 표시: Copyright(c)2002 by 부현경
  - 설명: 데이터 삭제 처리 JSP
  --%>


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pay calculator</title>
</head>
<body>



	<%
		request.setCharacterEncoding("utf-8");
		Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		String url = "jdbc:mysql://localhost:3306/new_payment"; // 사용하려는 데이터베이스명을 포함한 URL 기술
		String userid = "root"; // 사용자 계정
		String userpw = "q1w2e3r4";
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = DriverManager.getConnection(url, userid, userpw);

		} catch (Exception e) {
			out.println("DB 연결 실패:" + e.toString());
		}

		String[] check = request.getParameterValues("check");
		for (int i = 0; i < check.length; i++) {

			try {
				String sql = "DELETE FROM june where id=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, check[i]);
				pstmt.executeUpdate();

			} catch (Exception e) {
				out.println("삭제 실패입니다:" + e);

			} finally {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			}
		}
	%>

	<script language=javascript>
		self.window.alert("Delete");
		location.href = "index.jsp";
	</script>

</body>

</html>
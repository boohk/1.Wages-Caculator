<%--
  - 작성자: 부현경(boohk)
  - 일자: 2016.07.18
  - 저작권 표시: Copyright(c)2002 by 부현경
  - 설명: 데이터 입력 처리 JSP
  --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>

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

		String date = request.getParameter("date");
		String startTime = request.getParameter("startTime");
		String endTime = request.getParameter("endTime");
		String hourpay = request.getParameter("hourpay");
		int hourwage = Integer.parseInt(hourpay); //String형의 hourpay를 int형으로 형변환

		try {
			conn = DriverManager.getConnection(url, userid, userpw);

			String sql = "INSERT INTO june(date,day,startTime,endTime,totalTime,dailywages,hourpay) VALUES(?,dayname(?),?,?,Timediff(?,?),Time_to_SEC(Timediff(?,?))/60/60*?,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, date); // 지정날짜
			pstmt.setString(2, date); // 요일
			pstmt.setString(3, startTime); // 출근시간
			pstmt.setString(4, endTime); // 퇴근시간
			pstmt.setString(5, endTime); // 
			pstmt.setString(6, startTime); //	총시간(퇴근시간-출근시간)
			pstmt.setString(7, endTime);
			pstmt.setString(8, startTime);
			pstmt.setInt(9, hourwage);
			pstmt.setInt(10, hourwage);
			pstmt.execute();
			pstmt.close();
			conn.close();

		} catch (SQLException e) {
			out.println(e.toString());
		}
	%>
	
	<script language=javascript>
		self.window.alert("OK");
		location.href = "index.jsp";
	</script>
</body>

</html>
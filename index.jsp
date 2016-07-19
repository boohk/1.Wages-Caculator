<%--
  - 작성자: 부현경(boohk)
  - 일자: 2016.07.18
  - 저작권 표시: Copyright(c)2002 by 부현경
  - 설명: 데이터 출력 JSP
  --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>

<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pay calculator</title>
<link rel="stylesheet" href="css/reset.css">
<link rel="stylesheet" href="css/style.css">
<link rel="stylesheet" href="css/setting.css">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet"
	href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.min.css">
<script src="js/prefixfree.min.js"></script>
<script
	src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

</head>

<body>
	<section>
		<!--for demo wrap-->
		<h1>PAYMENT</h1>
		<form name=writeform method=get action="delete.jsp">
			<div class="tbl-header">
				<table cellpadding="0" cellspacing="0" border="0">
					<thead>
						<tr>
							<th><button class="w3-btn w3-teal w3-small"
									onclick="deleteCheck()" value="삭제">
									Delete<i class="w3-margin-left fa fa-trash"></i>
								</button></th>

							<th>ID</th>
							<th>날짜</th>
							<th>요일</th>
							<th>출근시간</th>
							<th>퇴근시간</th>
							<th>일한시간</th>
							<th>하루급여</th>
						</tr>
					</thead>
				</table>
			</div>




			<div class="tbl-content">
				<table cellpadding="0" cellspacing="0" border="0">
					<tbody>

						<%
							Connection conn = null; // null로 초기화 한다.
							PreparedStatement ps1 = null;
							ResultSet rs1 = null;

							try {
								String url = "jdbc:mysql://localhost:3306/new_payment?characterEncoding=UTF-8&useSSL=false"; // 사용하려는 데이터베이스명을 포함한 URL 기술
								String userid = "root"; // 사용자 계정
								String userpw = "q1w2e3r4"; // 사용자 계정의 패스워드

								Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
								conn = DriverManager.getConnection(url, userid, userpw); // DriverManager 객체로부터 Connection 객체를 얻어온다.

								String sql = "select * from june "; // sql 쿼리
								ps1 = conn.prepareStatement(sql); // prepareStatement에서 해당 sql을 미리 컴파일한다.
								//ps1tmt.setString(1,"1");

								rs1 = ps1.executeQuery(); // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.

								while (rs1.next()) { // 결과를 한 행씩 돌아가면서 가져온다.

									String id = rs1.getString("id");
									java.util.Date date = rs1.getDate("date");
									String day = rs1.getString("day");
									Time startTime = rs1.getTime("startTime");
									Time endTime = rs1.getTime("endTime");
									Time totalTime = rs1.getTime("totalTime");
									int dailywages = rs1.getInt("dailywages");
						%>

						<tr>
							<td><input type="checkbox" name="check" value="<%=id%>"></td>
							<td><%=id%></td>
							<td><%=date%></td>
							<td><%=day%></td>
							<td><%=startTime%></td>
							<td><%=endTime%></td>
							<td><%=totalTime%></td>
							<td><%=dailywages%></td>
						</tr>



						<%
							}

							} catch (Exception e) { // 예외가 발생하면 예외 상황을 처리한다.
								e.printStackTrace();
								out.println("member 테이블 호출에 실패했습니다.");
							} finally { // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
								if (rs1 != null)
									try {
										rs1.close();
									} catch (SQLException sqle) {
									} // Resultset 객체 해제
								if (ps1 != null)
									try {
										ps1.close();
									} catch (SQLException sqle) {
									} // PreparedStatement 객체 해제
								if (conn != null)
									try {
										conn.close();
									} catch (SQLException sqle) {
									} // Connection 해제
							}
						%>


					</tbody>
				</table>
			</div>
		</form>
		<div class="tbl-footer">
			<table cellpadding="0" cellspacing="0" border="0">
				<tfoot>
					<%
						Connection connnection = null; // null로 초기화 한다.
						PreparedStatement ps2 = null;
						ResultSet rs2 = null;
						String total[] = new String[3];
						try {
							String url = "jdbc:mysql://localhost:3306/new_payment?useSSL=false"; // 사용하려는 데이터베이스명을 포함한 URL 기술
							String userid = "root"; // 사용자 계정
							String userpw = "q1w2e3r4"; // 사용자 계정의 패스워드

							Class.forName("com.mysql.jdbc.Driver"); // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
							connnection = DriverManager.getConnection(url, userid, userpw); // DriverManager 객체로부터 Connection 객체를 얻어온다.

							String sql1 = "SELECT Concat(\"\",COUNT(ID)) as sumDay FROM june";
							ps2 = connnection.prepareStatement(sql1); // prepareStatement에서 해당 sql을 미리 컴파일한다.
							rs2 = ps2.executeQuery();
							rs2.first();
							total[0] = rs2.getString("sumday");

							String sql2 = "SELECT Concat(\"\",SEC_TO_TIME(SUM(TIME_TO_SEC(totalTime)))) as sumTime from june";
							ps2 = connnection.prepareStatement(sql2); // prepareStatement에서 해당 sql을 미리 컴파일한다.
							rs2 = ps2.executeQuery();

							rs2.first();
							total[1] = rs2.getString("sumTime");

							String sql3 = "SELECT Concat(\"\",SUM(dailywages)) as sumPay FROM june";
							ps2 = connnection.prepareStatement(sql3); // prepareStatement에서 해당 sql을 미리 컴파일한다.
							rs2 = ps2.executeQuery();

							rs2.first();
							total[2] = rs2.getString("sumPay");
					%>
					<tr>

						<td style="float: right;">총 일수</td>
						<td><%=total[0]%></td>
						<td style="float: right;">총 일한 시간</td>
						<td><%=total[1]%></td>
						<td style="float: right;">총 급여</td>
						<td><%=total[2]%></td>

					</tr>
					<%
						} catch (Exception e) { // 예외가 발생하면 예외 상황을 처리한다.
							e.printStackTrace();
							out.println("member 테이블 호출에 실패했습니다.");

						} finally { // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)
							if (rs2 != null) {
								try {
									rs2.close();
								} catch (SQLException sqle) {
								} // Resultset 객체 해제
							}

							if (ps2 != null)
								try {
									ps2.close();
								} catch (SQLException sqle) {
								} // PreparedStatement 객체 해제
							if (connnection != null)
								try {
									connnection.close();
								} catch (SQLException sqle) {
								} // Connection 해제
						}
					%>



				</tfoot>
			</table>
		</div>
	</section>


	<form name=writeform method=get action="enterdata.jsp">
		<div class="row">
			<span><input class="balloon" id="state" type="text"
				placeholder="시급입력" name="hourpay" /><label for="per hour pay">시급</label>
			</span> <span> <input class="balloon" id="planet" type="date"
				name="date" /><label for="date">출근 날짜</label>
			</span> <span> <input class="balloon" id="galaxy" type="time"
				name="startTime" /><label for="time">출근 시간</label>
			</span> <span> <input class="balloon" id="galaxy" type="time"
				name="endTime" /><label for="phone">퇴근 시간</label>
			</span> <span>
				<button class="balloon" id="galaxy" type="submit" />INPUT
				</button>
			</span>
		</div>
	</form>

	<div class="made-with-love">
		by Hyun-Kyung <i>♥</i>
	</div>
</body>
</html>
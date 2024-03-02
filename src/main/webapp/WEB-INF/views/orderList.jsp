<%--
  Created by IntelliJ IDEA.
  User: SRKim
  Date: 2023-12-28
  Time: 오후 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>주문 목록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

    <style>
        h2 {
            text-align: center;
            margin-bottom: 20px; /* h2와 테이블 사이의 간격 조절 */
        }

        table {
            text-align: center;
        }

        th {
            background-color: #f2f2f2 !important;
        }

        .rounded-table {
            border-radius: 15px;
            overflow: auto; /* 스크롤바 추가 */
            max-height: 500px; /* 적절한 최대 높이 설정 */
        }

        .btn-container {
            display: flex;
            justify-content: center;
            margin: 20px 0;
        }

    </style>
</head>
<body>
<h2>주문 목록</h2>
주문 개수 : ${orders.size()} 개
<br><br>
<table class="table table-hover rounded-table">
    <tr>
        <th>주문 번호</th>
        <th>주문 날짜</th>
        <th>주문 삭제</th>
    <tr>
        <c:forEach items="${orders}" var="orders">
    <tr>
        <td><a href="orderDetail/${orders.orderId}">${orders.orderId}</a></td>
        <td>${orders.orderDate}</td>
        <td><a href="/deleteOrderDetail?orderId=${orders.orderId}">삭제</a></td>
    <tr>
        </c:forEach>
</table>
<div class="btn-container">
    <input class="btn btn-light" type="submit" value="종료" onclick="toMainPage()">
</div>
<script>
    function toMainPage() {
        window.location.href='/';
    }
</script>
</body>
</html>
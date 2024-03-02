<%--
  Created by IntelliJ IDEA.
  User: SRKim
  Date: 2024-01-07
  Time: 오후 5:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>음료 메뉴 제거</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        th {
            background-color: #f2f2f2 !important;
        }

        form {
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        div {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .rounded-table {
            border-radius: 15px; /* 적절한 값을 선택하여 조절할 수 있습니다. */
            overflow: hidden; /* 모서리 부분을 잘라내어 보여지도록 합니다. */
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

</head>
<body>
<h2>음료 메뉴 제거</h2>
<br>
<table class="table table-hover rounded-table">
    <tr>
        <th>번호</th>
        <th>이름</th>
    </tr>
    <!-- 데이터베이스에서 가져온 음료 정보를 반영 -->
    <c:forEach var="drink" items="${products}">
        <tr>
            <td><p>${drink.productId}</p></td>
            <td><p>${drink.productName}</p></td>
        </tr>
    </c:forEach>
</table>
<form action="/completeProductDeletion" method="POST">
    <table class="table table-hover rounded-table">
        <tr>
            <th><label for="productId">음료 번호</label></th>
            <th><label for="productName">음료 이름</label></th>
        </tr>
        <tr>
            <td><input type="number" id="productId" name="productId" required></td>
            <td><input type="text" id="productName" name="productName"></td>
        </tr>
        <tr>
            <td colspan="2">
                <input class="btn btn-light" type="submit" value="제거">
                <input class="btn btn-light" type="button" value="취소" onclick="location.href='/'">
            </td>
        </tr>
    </table>
</form>
</body>
</html>

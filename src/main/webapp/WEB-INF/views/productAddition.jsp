<%--
  Created by IntelliJ IDEA.
  User: SRKim
  Date: 2024-01-07
  Time: 오후 5:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>음료 메뉴 추가</title>
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
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

</head>
<body>
<h2>음료 메뉴 추가</h2>
<br>
<form action="/completeProductAddition" method="POST">
    <table class="table table-hover rounded-table">
        <tr>
            <th><label for="productName">음료 이름</label></th>
            <th><label for="productPrice">가격</label></th>
        </tr>
        <tr>
            <td><input type="text" id="productName" name="productName" required></td>
            <td><input type="number" id="productPrice" name="productPrice" required min="0"></td>
        </tr>
        <tr>
            <td colspan="2">
                <input class="btn btn-light" type="submit" value="추가">
                <input class="btn btn-light" type="button" value="취소" onclick="location.href='/'">
            </td>
        </tr>
    </table>
</form>
</body>
</html>

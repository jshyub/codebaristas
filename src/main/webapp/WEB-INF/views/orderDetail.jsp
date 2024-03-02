<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>주문 상세 화면</title>
    <style>
        body, html {
            height: 100%;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column; /* 콘텐츠를 세로로 정렬 */
        }

        h2 {
            text-align: center;
            margin-bottom: 20px; /* h2와 테이블 사이의 간격 조절 */
        }

        form {
            text-align: center;
        }

        th {
            background-color: #f2f2f2 !important;
        }

        .rounded-table {
            border-radius: 15px; /* 적절한 값을 선택하여 조절할 수 있습니다. */
            overflow: hidden; /* 모서리 부분을 잘라내어 보여지도록 합니다. */
        }
    </style>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>
<h2>주문 상세</h2>

<p style="margin: 0;">주문번호: ${orderDetail[0].orderId}</p>
<p style="margin: 0;">주문날짜: ${orderDetail[0].orderDate}</p>

<table class="table table-hover rounded-table">
    <tr>
        <th>제품명</th>
        <th>수량</th>
        <th>가격</th>
    </tr>
    <c:forEach var="item" items="${orderDetail}">
        <c:if test="${item.quantity > 0}">
            <tr>
                <td>${item.productName}</td>
                <td>${item.quantity}</td>
                <td>${item.totalPrice}</td>
            </tr>
        </c:if>
    </c:forEach>
    <tfoot>
    <tr>
        <td class="table-active">총합</td>
        <td>${totalQuantitySum}</td>
        <td>${totalPriceSum}</td>
    </tr>
    </tfoot>
</table>
</body>
</html>

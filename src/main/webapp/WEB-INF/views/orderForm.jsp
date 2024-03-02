<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>음료 주문</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
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

    input {
        width: 120px;
    }

    #cancellation {
        margin-top: 10px;
    }

    .tableBottom {
        background-color: #f2f2f2 !important;
        text-align: center;
        font-weight: bold;
        font-size: larger;
    }

    .rounded-table {
        border-radius: 15px; /* 적절한 값을 선택하여 조절할 수 있습니다. */
        overflow: hidden; /* 모서리 부분을 잘라내어 보여지도록 합니다. */
    }

</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<body>
<h2>음료 주문</h2>
<form action="/submitOrder" method="POST">
    <table class="table table-hover rounded-table">
        <tr>
            <th>음료</th>
            <th>가격</th>
            <th>수량</th>
            <th></th>
        </tr>
        <!-- 데이터베이스에서 가져온 음료 정보를 반영 -->
        <c:forEach var="drink" items="${products}">
            <tr>
                <td><p id="productName">${drink.productName}</p></td>
                <td><span id="productPrice" class="productPrice">${drink.productPrice}</span>원</td>
                <td><input type="number" name="quantity" value="0" min="0" oninput="calculateTotal()"></td>
                <td><input type="hidden" name="productId" value="${drink.productId}"></td>
            </tr>
        </c:forEach>
        <tr>
            <td colspan="4" class="tableBottom">
                <input type="hidden" id="hiddenTotalPrice" name="totalPrice">
                <!-- 총 가격 출력 -->
                <p>총 가격: <span id="displayTotalPrice" value="0"></span>원</p>
            </td>
        </tr>
    </table>
    <input class="btn btn-light" type="submit" value="주문">
</form>
<form id="modifyProduct" method="POST">
    <input class="btn btn-light" type="button" value="관리자 모드" onclick="administrator()" id="administration">
    <div id="passwordInput" style="display: none;">
        <input type="password" id="password" placeholder="비밀번호">
        <td colspan="2">
            <input class="btn btn-light" type="button" value="확인" onclick="verifyPassword()">
            <input class="btn btn-light" type="button" value="취소" onclick="toMainPage()">
        </td>
    </div>
    <div>
        <input class="btn btn-light" type="button" value="메뉴 추가" id="productAddition" onclick="toProductAddition()" style="display: none;">
        <input class="btn btn-light" type="button" value="메뉴 삭제" id="productDeletion" onclick="toProductDeletion()" style="display: none;">
        <input class="btn btn-light" type="button" value="주문 목록" id="orderList" onclick="toOrderList()" style="display: none;">
    </div>
    <div>
        <input class="btn btn-light" type="button" value="취소" id="cancellation" onclick="toMainPage()" style="display: none;">
    </div>
</form>
<script>
    // 총 가격 계산
    function calculateTotal() {
        let totalPrice = 0;

        // 모든 input을 가져다가 저장해서 계산
        document.querySelectorAll('input[type="number"]').forEach(function(input) {
            let quantity = parseInt(input.value);
            let price = parseFloat(input.closest('tr').querySelector('.productPrice').textContent);
            totalPrice += quantity * price;
        });

        // 총 가격 업데이트
        document.getElementById('displayTotalPrice').textContent = totalPrice;
        document.getElementById('hiddenTotalPrice').value = totalPrice;
    }

    document.querySelectorAll('input[type="number"]').forEach(function(input) {
        input.addEventListener('input', calculateTotal);
    });

    calculateTotal();

    function modifyProduct(actionType) {
        var form = document.getElementById('modifyProduct');
        if (actionType === 'add') {
            form.action = '/productAddition';
        } else if (actionType === 'delete') {
            form.action = '/productDeletion';
        }
        form.submit();
    }

    function administrator() {
        document.getElementById('passwordInput').style.display = 'block';
        document.getElementById('administration').style.display = 'none';
    }

    function verifyPassword() {
        $.ajax({
            type: "POST",
            url: "/modifyProduct",
            data: { password: $("#password").val() },
            success: function(response) {
                if (response.isAuthenticated) {
                    // 비밀번호 입력 칸과 확인 버튼 숨기기
                    $("#passwordInput").hide();
                    // 메뉴 추가 및 삭제 버튼 보이기
                    $("#productAddition").show();
                    $("#productDeletion").show();
                    $("#orderList").show();
                    $("#cancellation").show();
                } else {
                    // 인증 실패 시 메인페이지로 돌아감
                    window.location.href = "/";
                }
            }
        });
    }

    function toProductAddition() {
        window.location.href = "/productAddition";
    }

    function toProductDeletion() {
        window.location.href = "/productDeletion";
    }

    function toMainPage() {
        window.location.href='/';
    }

    function toOrderList() {
        window.location.href="/orderList";
    }

</script>
</body>
</html>

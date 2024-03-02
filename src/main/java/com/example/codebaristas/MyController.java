package com.example.codebaristas;

import com.example.codebaristas.dao.IOrderDao;
import com.example.codebaristas.dao.IOrderDetailDao;
import com.example.codebaristas.dao.IProductsDao;
import com.example.codebaristas.dto.OrderDetailDto;
import com.example.codebaristas.dto.OrderDto;
import com.example.codebaristas.dto.ProductsDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MyController {
    @Autowired
    private IOrderDao orderDao;

    @Autowired
    private IOrderDetailDao orderDetailDao;

    @Autowired
    private IProductsDao productsDao;

    @RequestMapping("/")
    public String orderForm(Model model) {
        List<ProductsDto> products = productsDao.getAllProducts();
        // 로그를 추가하여 데이터 확인
        for (ProductsDto product : products) {
            System.out.println("음료: " + product.getProductName() + ", 가격: " + product.getProductPrice());
        }
        model.addAttribute("products", products);
        return "orderForm";
    }

    @RequestMapping("/submitOrder")
    public String submitOrder(@ModelAttribute OrderDto orderDto,
                              @ModelAttribute OrderDetailDto orderDetailDto,
                              @RequestParam("productId") int[] productIds,
                              @RequestParam("quantity") int[] quantities) {
        // 주문 정보 생성
        orderDao.submitOrder(orderDto);
        // 생성된 orderId를 다시 읽어오기
        int orderId = orderDao.getLastInsertedOrderId();
        // 주문번호가 0 이상일 경우 주문 상세 화면으로 리다이렉트
        if (orderId > 0) {
            // 각 제품에 대한 주문 상세 정보를 생성하고 설정
            for (int i = 0; i < productIds.length; i++) {
                int productId = productIds[i];
                System.out.println("productId[" + i + "] = " + productId);
                int quantity = quantities[i];
                System.out.println("quantity[" + i + "] = " + quantity);

                OrderDetailDto orderDetail = createOrderDetail(orderId, productId, quantity);

                // 주문 상세 정보를 DB에 저장
                orderDetailDao.insertOrderDetail(orderDetail);
            }
            System.out.println("orderIdSubmitOrder = " + orderId);
            return "redirect:/orderDetail/" + orderId;
        } else {
            // 주문이 저장되지 않았을 때 처리
            return "orderNotSaved";
        }
    }

    private OrderDetailDto createOrderDetail(int orderId, int productId, int quantity) {
        OrderDetailDto orderDetail = new OrderDetailDto();
        orderDetail.setOrderId(orderId);
        orderDetail.setProductId(productId);
        orderDetail.setQuantity(quantity);
        orderDetail.setTotalPrice(calculateTotalPrice(productId, quantity));
        return orderDetail;
    }

    private int calculateTotalPrice(int productId, int quantity) {
        // 선택한 제품의 가격 정보를 DB에서 가져와서 계산
        System.out.println("productIdCalculateTotelPrice = " + productId);
        int productPrice = getProductPriceFromDatabase(productId);
        return productPrice * quantity;
    }

    private int getProductPriceFromDatabase(int productId) {
        // 데이터베이스에서 productId로 가격을 조회
        Integer price = productsDao.getProductPriceById(productId);
        System.out.println("price = " + price);
        return price != null ? price : 0;
    }

    @RequestMapping("/modifyProduct")
    @ResponseBody
    public Map<String, Boolean> modifyProduct(@RequestParam("password") String password, HttpSession session) {
        final String CORRECT_PASSWORD = "1234";
        Map<String, Boolean> response = new HashMap<>();

        if (password.equals(CORRECT_PASSWORD)) {
            session.setAttribute("isAuthenticated", true);
            response.put("isAuthenticated", true);
        } else {
            session.setAttribute("isAuthenticated", false);
            response.put("isAuthenticated", false);
        }
        return response;
    }

    @RequestMapping("/productAddition")
    public String productAddition() {

        return "productAddition";
    }

    @RequestMapping("/completeProductAddition")
    public String completeProductAddition(@ModelAttribute ProductsDto productsDto) {
        productsDao.completeProductAddition(productsDto);
        return "redirect:";
    }
//    @RequestMapping(value = "/completeProductAddition", method = RequestMethod.POST)
//    public String completeProductAddition(@ModelAttribute ProductsDto productsDto) {
//        productsDao.completeProductAddition(productsDto);
//        return "redirect:";
//    }

    @RequestMapping("/productDeletion")
    public String productDeletion(Model model) {
        List<ProductsDto> products = productsDao.showProducts();
        for (ProductsDto product : products) {
            System.out.println("번호: " + product.getProductId() + ", 이름: " + product.getProductName());
        }
        model.addAttribute("products", products);
        return "productDeletion";
    }

    @RequestMapping("/completeProductDeletion")
    public String completeProductDeletion(@ModelAttribute ProductsDto productsDto) {
        productsDao.completeProductDeletion(productsDto);
        return "redirect:productDeletion";
    }

    @RequestMapping("/orderList")
    public String orderList(Model model) {
        List<OrderDto> orders = orderDao.getAllOrders();
        model.addAttribute("orders", orders);
        return "orderList";
    }

    @RequestMapping("/orderDetail/{orderId}")
    public String orderDetail(@PathVariable("orderId") int orderId, Model model) {
        System.out.println("orderIdOrderDetail = " + orderId);
        List<OrderDetailDto> orderDetailDtos = orderDetailDao.getOrderDetailsByOrderId(orderId); // orderDetailDao를 통해 메서드 호출

        // quantity 총합을 계산
        int totalQuantitySum = 0;
        for (OrderDetailDto detail : orderDetailDtos) {
            totalQuantitySum += detail.getQuantity();
        }
        // totalPrice의 총합을 계산
        int totalPriceSum = 0;
        for (OrderDetailDto detail : orderDetailDtos) {
            totalPriceSum += detail.getTotalPrice();
        }

        // 모델에 orderDetail 리스트와 총합을 추가
        model.addAttribute("orderDetail", orderDetailDtos);
        model.addAttribute("totalQuantitySum", totalQuantitySum);
        model.addAttribute("totalPriceSum", totalPriceSum);
        return "orderDetail";
    }

    @RequestMapping("/deleteOrderDetail")
    public String deleteOrderDetail(@RequestParam("orderId") int orderId) {
        System.out.println("deleteORderDetailOrderId = " + orderId);
        orderDetailDao.deleteOrderDetail(orderId);
        return "redirect:/deleteOrder?orderId=" + orderId;
    }

    @RequestMapping("/deleteOrder")
    public String deleteOrder(@RequestParam("orderId") int orderId) {
        orderDao.deleteOrder(orderId);
        return "redirect:orderList";
    }
}
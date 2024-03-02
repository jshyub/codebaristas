package com.example.codebaristas.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class OrderDetailDto {
    private int orderDetailId;
    private int orderId;
    private LocalDate orderDate;
    private int productId;
    private String productName;
    private int quantity;
    private int totalPrice;
}

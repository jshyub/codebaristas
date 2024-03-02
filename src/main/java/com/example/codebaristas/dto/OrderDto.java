package com.example.codebaristas.dto;

import lombok.Data;

import java.time.LocalDate;
import java.util.List;

@Data
public class OrderDto {
    private int orderId;
    private LocalDate orderDate;
}
package com.example.codebaristas.dao;

import com.example.codebaristas.dto.OrderDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IOrderDao {
    void submitOrder(OrderDto orderDto);
    OrderDto orderDetailByOrderId(int orderId);
    Integer getLastInsertedOrderId();
    List<OrderDto> getAllOrders();

    void deleteOrder(int orderId);
}
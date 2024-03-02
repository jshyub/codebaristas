package com.example.codebaristas.dao;

import com.example.codebaristas.dto.OrderDetailDto;
import com.example.codebaristas.dto.OrderDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IOrderDetailDao {
    List<OrderDetailDto> getOrderDetailsByOrderId(int orderId);
    void insertOrderDetail(OrderDetailDto orderDetail);
    void deleteOrder(OrderDetailDto orderDetailDto);

    void deleteOrderDetail(int orderId);
}

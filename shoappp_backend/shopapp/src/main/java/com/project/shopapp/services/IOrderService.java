package com.project.shopapp.services;

import com.project.shopapp.dtos.OrderDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.Order;

import java.util.List;

public interface IOrderService {

    Order createOrder(OrderDTO orderDTO) throws Exception;

    Order getOrderById(Long orderId);

    Order updateOrder(Long orderId, OrderDTO orderDTO) throws DataNotFoundException;

    void deleteOrder(Long orderId);

    List<Order> getAllOrdersByUserId(Long userId);

}

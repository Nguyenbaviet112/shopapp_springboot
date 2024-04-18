package com.project.shopapp.services;

import com.project.shopapp.dtos.OrderDetailDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.models.OrderDetail;

import java.util.List;

public interface IOrderDetailService {

    OrderDetail createOrderDetail(OrderDetailDTO orderDetailDTO) throws Exception;
    OrderDetail updateOrderDetail(Long orderDetailId, OrderDetailDTO newOrderDetailDTO);
    OrderDetail getOrderDetailById(Long orderDetailId) throws DataNotFoundException;
    List<OrderDetail> getAllOrderDetailsByOrderId(Long orderId);
    void deleteOrderDetail(Long orderDetailId);

}

package com.project.shopapp.controllers;

import com.project.shopapp.models.Order;
import com.project.shopapp.services.IOrderService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import com.project.shopapp.dtos.*;

import java.util.List;

@RestController
@RequestMapping("${api.prefix}/orders")
@RequiredArgsConstructor
public class OrderController {

    private IOrderService orderService;
    @PostMapping("")
    public ResponseEntity<?> createOrder(@Valid @RequestBody OrderDTO orderDTO, BindingResult result)
    {
        try {

            if (result.hasErrors()) {
                List<String> errorMessages = result.getFieldErrors()
                        .stream()
                        .map(FieldError::getDefaultMessage)
                        .toList();
                return ResponseEntity.badRequest().body(errorMessages);
            }

            Order order = orderService.createOrder(orderDTO);
            return ResponseEntity.ok(order);
        }
        catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/user/{user_id}")
    public ResponseEntity<?> getOrdersByUserId(@Valid @PathVariable("user_id") long userId)
    {
        try {
            return ResponseEntity.status(HttpStatus.OK).body(String.format("Get list order by user_id = %d", userId));
        }
        catch (Exception e)
        {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getOrderById(@Valid @PathVariable("id") long orderId)
    {
        try {
            Order order = orderService.getOrderById(orderId);
            return ResponseEntity.status(HttpStatus.OK).body(order);
        }
        catch (Exception e)
        {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateOrder(@Valid @PathVariable("id") long id, @RequestBody OrderDTO orderDTO)
    {
        return ResponseEntity.ok().body(String.format("update order by id = %d, \n new order: ", id) + orderDTO );
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteOrder(@Valid @PathVariable("id") long id)
    {
        // Xoá mềm => Cập nhật trường active bằng false
        return ResponseEntity.ok("Order deleted successfully");
    }
}

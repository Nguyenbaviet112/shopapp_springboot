package com.project.shopapp.controllers;

import com.project.shopapp.dtos.OrderDetailDTO;
import com.project.shopapp.services.IOrderDetailService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("${api.prefix}/order_details")
@RequiredArgsConstructor
public class OrderDetailController {

    private final IOrderDetailService orderDetailService;

    @PostMapping("")
    public ResponseEntity<?> createOrderDetail( @RequestBody OrderDetailDTO orderDetailDTO )
    {

        return ResponseEntity.ok("Created order detail successfully");
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getOrderDetailById(@Valid @PathVariable("id") Long id)
    {
        return ResponseEntity.ok(String.format("this is order Detail with id = %d", id));
    }

    @GetMapping("/order/{order_id}")
    public ResponseEntity<?> getOrderDetailByOrderId(@Valid @PathVariable("order_id") Long orderId)
    {
        return ResponseEntity.ok("Get list order detail with order_id = " + orderId);
    }

    @GetMapping("")
    public ResponseEntity<?> getOrderDetailByOrderIdWithRequestParam(@Valid @RequestParam("order_id") Long orderId)
    {
        return ResponseEntity.ok("Get list order detail with order_id = " + orderId);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateOrderDetail(@Valid @PathVariable("id") Long id, @RequestBody OrderDetailDTO newOrderDetailDTO)
    {
        return ResponseEntity.ok("update order detail with id = " + id + "\n new order detail: " + newOrderDetailDTO);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteOrderDetail(@Valid @PathVariable("id") Long id)
    {
        return ResponseEntity.ok("Delete successfully order detail with id = " + id);
    }


}

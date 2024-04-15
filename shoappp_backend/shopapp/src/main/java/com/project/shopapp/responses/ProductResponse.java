package com.project.shopapp.responses;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductResponse extends BaseResponse {


    private String name;
    private Float price;
    private String thumbnail;
    private String description;
    private Long categoryId;

}

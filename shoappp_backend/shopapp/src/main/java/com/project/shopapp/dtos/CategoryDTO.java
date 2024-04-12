package com.project.shopapp.dtos;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.Getter;
import org.apache.logging.log4j.message.Message;

@Data
@Getter
public class CategoryDTO {
    @NotEmpty(message = "Tên không được để trống")
    private String name;
}

package com.project.shopapp.controllers;



import com.github.javafaker.Faker;
import com.project.shopapp.components.LocalizationUtils;
import com.project.shopapp.dtos.ProductDTO;
import com.project.shopapp.dtos.ProductImageDTO;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductImage;
import com.project.shopapp.responses.ProductListResponse;
import com.project.shopapp.responses.ProductResponse;
import com.project.shopapp.services.IProductService;
import com.project.shopapp.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.UrlResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.*;
import org.springframework.web.multipart.MultipartFile;


import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;


@RestController
@RequiredArgsConstructor
@RequestMapping("${api.prefix}/products")
public class ProductController {

    private final IProductService iProductService;
    private final ProductService productService;
    private final LocalizationUtils localizationUtils;

    @PostMapping("")
    //POST http://localhost:8088/v1/api/products
    public ResponseEntity<?> createProduct(
            @Valid @RequestBody ProductDTO productDTO,
            BindingResult result
    ) {
        try {
                if (result.hasErrors()) {
                    List<String> errorMessages = result.getFieldErrors()
                            .stream()
                            .map(FieldError::getDefaultMessage)
                            .toList();
                    return ResponseEntity.badRequest().body(errorMessages);
                }

            Product newProduct = iProductService.createProduct(productDTO);

            return ResponseEntity.ok(newProduct);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

        @PostMapping(value = "uploads/{id}",
            consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
        public ResponseEntity<?> uploadImages(
                @PathVariable("id") Long productId,
                @ModelAttribute("files") List<MultipartFile> files) {

            try {

                Product existingProduct = iProductService.getProductById(productId);

                files = files == null ? new ArrayList<MultipartFile>() : files;

                if (files.size() > ProductImage.MAXIMUM_IMAGES_PER_PRODUCT)
                {
                    ResponseEntity.badRequest().body("You can only upload maximum 5 images");
                }

                List<ProductImage> productImages = new ArrayList<>();
                for (MultipartFile file : files) {
                    if (file.getSize() == 0) {
                        continue;
                    }
                    // Kiểm tra kích thước file và định dạng
                    if (file.getSize() > 10 * 1024 * 1024) { // Kích thước > 10MB
                        return ResponseEntity.status(HttpStatus.PAYLOAD_TOO_LARGE)
                                .body("File is too large! Maximum size is 10MB");
                    }
                    String contentType = file.getContentType();
                    if (contentType == null || !contentType.startsWith("image/")) {
                        return ResponseEntity.status(HttpStatus.UNSUPPORTED_MEDIA_TYPE)
                                .body("File must be an image");
                    }
                    // Lưu file và cập nhật thumbnail trong DTO
                    String filename = storeFile(file); // Thay thế hàm này với code của bạn để lưu file
                    //lưu vào đối tượng product trong DB
                    //lưu vào bảng product_images
                    ProductImage productImage = iProductService.createProductImage(
                            existingProduct.getId(),
                            ProductImageDTO.builder()
                                    .imageURL(filename)
                                    .build());

                    productImages.add(productImage);
                }

                return ResponseEntity.ok().body(productImages);

            } catch (Exception e) {
                return ResponseEntity.badRequest().body(e.getMessage());
            }


        }

        @GetMapping("/images/{imageName}")
        public ResponseEntity<?> viewImage(@PathVariable String imageName) {
            try {
                java.nio.file.Path imagePath = Paths.get("uploads/"+imageName);
                UrlResource resource = new UrlResource(imagePath.toUri());

                if (resource.exists()) {
                    return ResponseEntity.ok()
                            .contentType(MediaType.IMAGE_JPEG)
                            .body(resource);
                } else {
                    return ResponseEntity.ok()
                            .contentType(MediaType.IMAGE_JPEG)
                            .body(new UrlResource(Paths.get("uploads/notfound.jpeg").toUri()));
                    //return ResponseEntity.notFound().build();
                }
            } catch (Exception e) {
                return ResponseEntity.notFound().build();
            }
        }
        
        private String storeFile(MultipartFile file) throws IOException {

            if (!isImageFile(file) || file.getOriginalFilename() == null)
            {
                throw new IOException("Invalid image format");
            }

            String filename = StringUtils.cleanPath(file.getOriginalFilename());
            // Thêm UUID vào trước tên file để đảm bảo tên file là duy nhất
            String uniqueFilename = UUID.randomUUID().toString() + "_" + filename;
            // Đường dẫn đến thư mục mà bạn muốn lưu file
            java.nio.file.Path uploadDir = Paths.get("uploads");
            // Kiểm tra và tạo thư mục nếu nó không tồn tại
            if (!Files.exists(uploadDir)) {
                Files.createDirectories(uploadDir);
            }
            // Đường dẫn đầy đủ đến file
            java.nio.file.Path destination = Paths.get(uploadDir.toString(), uniqueFilename);
            // Sao chép file vào thư mục đích
            Files.copy(file.getInputStream(), destination, StandardCopyOption.REPLACE_EXISTING);
            return uniqueFilename;
        }

        private boolean isImageFile(MultipartFile file)
        {
            String contentType = file.getContentType();
            return contentType != null && contentType.startsWith("image/");
        }


        @GetMapping("")
    public ResponseEntity<ProductListResponse> getAllProducts(@RequestParam("page") int page
                , @RequestParam("limit") int limit)
    {
        PageRequest pageRequest = PageRequest.of(page, limit, Sort.by("id").ascending());
        Page<ProductResponse> productPage = iProductService.getAllProducts(pageRequest);

        int totalPages = productPage.getTotalPages();
        List<ProductResponse> products = productPage.getContent();

        return ResponseEntity.ok(ProductListResponse.builder()
                        .products(products)
                        .totalPages(totalPages)
                        .build());
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getProductById(@PathVariable("id") long productId)
    {
        try {

            Product existingProduct = iProductService.getProductById(productId);
            return ResponseEntity.ok().body(ProductResponse.fromProduct(existingProduct));

        } catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @Transactional
    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteProduct(@PathVariable("id") long productId)
    {
        try {

            iProductService.deleteProduct(productId);
            return ResponseEntity.status(HttpStatus.OK).body("delete product with id = " + productId + " successfully");
        }
        catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateProduct(@PathVariable("id") long productId, @RequestBody ProductDTO productDTO)
    {
        try {

            Product newProduct = iProductService.updateProduct(productId, productDTO);
            return ResponseEntity.ok().body(newProduct);

        }
        catch (Exception e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }

    //@PostMapping("/generateFakeProducts")
    private ResponseEntity<?> generateFakeProducts() {

        Faker faker = new Faker();

        for (int i = 0; i < 300; i++) {

            String productName = faker.commerce().productName();
            if (productService.existsByName(productName))
            {
                continue;
            }

            ProductDTO productDTO = ProductDTO.builder()
                    .name(productName)
                    .price((float)faker.number().numberBetween(1000, 50000))
                    .description(faker.lorem().sentence())
                    .thumbnail("")
                    .categoryId((long)faker.number().numberBetween(1,5))

                    .build();

            try {
                productService.createProduct(productDTO);
            }
            catch (Exception e)
            {
                return ResponseEntity.badRequest().body(e.getMessage());
            }

        }
        return ResponseEntity.ok().body("fake products created");
    }
}



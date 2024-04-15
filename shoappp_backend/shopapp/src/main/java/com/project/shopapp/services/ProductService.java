package com.project.shopapp.services;

import com.project.shopapp.dtos.ProductDTO;
import com.project.shopapp.dtos.ProductImageDTO;
import com.project.shopapp.exceptions.DataNotFoundException;
import com.project.shopapp.exceptions.InvalidParamException;
import com.project.shopapp.models.Category;
import com.project.shopapp.models.Product;
import com.project.shopapp.models.ProductImage;
import com.project.shopapp.repositories.CategoryRepository;
import com.project.shopapp.repositories.ProductImageRepository;
import com.project.shopapp.repositories.ProductRepository;
import com.project.shopapp.responses.ProductResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProductService implements IProductService {

    private final ProductRepository productRepository;
    private final CategoryRepository categoryRepository;
    private final ProductImageRepository productImageRepository;
    @Override
    public Product createProduct(ProductDTO productDTO) throws DataNotFoundException {
        Category existingCategory = categoryRepository
                .findById(productDTO.getCategoryId())
                .orElseThrow(() ->
                        new DataNotFoundException(
                                "Cannot find category with id:  " + productDTO.getCategoryId()));

        Product newProduct = Product.builder()
                .name(productDTO.getName())
                .price(productDTO.getPrice())
                .thumbnail(productDTO.getThumbnail())
                .description(productDTO.getDescription())
                .category(existingCategory)
                .build();

        return productRepository.save(newProduct);
    }

    @Override
    public Product getProductById(Long productId) throws Exception{

        return productRepository.findById(productId)
                .orElseThrow(()->
                        new DataNotFoundException("Cannot find product with id = " + productId));
    }

    @Override
    public Page<ProductResponse> getAllProducts(PageRequest pageRequest) {
        return productRepository.findAll(pageRequest).map(
                product -> {
                ProductResponse productResponse = ProductResponse.builder()
                        .name(product.getName())
                        .price(product.getPrice())
                        .thumbnail(product.getThumbnail())
                        .description(product.getDescription())
                        .categoryId(product.getCategory().getId())
                        .build();

                productResponse.setCreatedAt(product.getCreatedAt());
                productResponse.setUpdatedAt(product.getUpdatedAt());
                return productResponse;
                });
    }

    @Override
    public Product updateProduct(Long id, ProductDTO productDTO) throws Exception {

        Product existingProduct = getProductById(id);
        if (existingProduct != null) {
            Category existingCategory = categoryRepository
                    .findById(productDTO.getCategoryId())
                    .orElseThrow(() ->
                            new DataNotFoundException(
                                    "Cannot find category with id:  " + productDTO.getCategoryId()));
            existingProduct.setName(productDTO.getName());
            existingProduct.setCategory(existingCategory);
            existingProduct.setPrice(productDTO.getPrice());
            existingProduct.setDescription(productDTO.getDescription());
            existingProduct.setThumbnail(productDTO.getThumbnail());
            return productRepository.save(existingProduct);
        }

        return null;
    }

    @Override
    public void deleteProduct(Long id) {
        Optional<Product> optionalProduct = productRepository.findById(id);
        optionalProduct.ifPresent(productRepository::delete);
    }

    @Override
    public boolean existsByName(String name) {
        return productRepository.existsByName(name);
    }


    @Override
    public ProductImage createProductImage(
            Long productId,
            ProductImageDTO productImageDTO) throws Exception {

        Product existingProduct = productRepository
                .findById(productId)
                .orElseThrow(() ->
                        new DataNotFoundException(
                                "Cannot find product with id:  " + productImageDTO.getProductID()));

        ProductImage newProductImage = ProductImage
                .builder()
                .product(existingProduct)
                .imageURL(productImageDTO.getImageURL())
                .build();

        // khong cho insert qua 5 ảnh
        int size = productImageRepository.findByProductId(productId).size();
        if (size > ProductImage.MAXIMUM_IMAGES_PER_PRODUCT)
        {
            throw new InvalidParamException("Number of images must be < " +
                    ProductImage.MAXIMUM_IMAGES_PER_PRODUCT);
        }

        return productImageRepository.save(newProductImage);
    }

}

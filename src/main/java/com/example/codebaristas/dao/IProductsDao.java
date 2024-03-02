package com.example.codebaristas.dao;

import com.example.codebaristas.dto.ProductsDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface IProductsDao {
    List<ProductsDto> getAllProducts();
    List<ProductsDto> showProducts();
    ProductsDto getProductById(int productId);
    Integer getProductPriceById(int productId); // productId로 제품 가격을 조회하는 메소드

    void completeProductAddition(ProductsDto productsDto);

    void completeProductDeletion(ProductsDto productsDto);


}

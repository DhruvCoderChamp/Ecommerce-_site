<%-- 
    Document   : index
    Created on : 18-Mar-2022, 10:10:13 pm
    Author     : uer
--%>

<%@page import="com.learn.mycart.helper.Helper"%>
<%@page import="com.learn.mycart.entites.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.entites.Product"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>MyCart-Home</title>
        
        <%@include file="components/common_css_js.jsp" %>
             
    </head>
    <body>
        <%@include file="components/navbar.jsp" %>
        <div class="row mt-3 mx-2">
            
            <%
                
               String cat=request.getParameter("category");
                ProductDao pdao=new ProductDao(FactoryProvider.getFactory());
                 List<Product> list;
                if(cat==null || cat.trim().equals("all"))
                {
                   list=pdao.getAllProduct();
                }else{
                      int cid=Integer.parseInt(cat.trim());
                      list = pdao.getAllProductId(cid);
                }
                
                 
                CategoryDao cdao=new CategoryDao(FactoryProvider.getFactory());
                List<Category> list1=cdao.getCategories();
               

            %>
            
            <!--to store category-->
            <div class="col-md-2">
                
                <div class="list-group mt-4">
                    <a href="index.jsp?category=all" class="list-group-item  lsit-group-item-action active">
                        All Products
                    </a>
            
                 <%
                     for(Category category:list1)
                     {
                 %>
                 
                 <a href="index.jsp?category=<%=category.getCategoryId() %>" class="list-group-item list-group-item-action"><%=category.getCategoryTitle()%></a>
                 
                 <%
                     }
                   
                 %>
                 
                 
            </div>
                 
            </div>
            <!--to store product-->
            <div class="col-md-10">
                
               <div class="row mt-4">
                   
                   <div class="col-md-12">
                       <div class="card-columns">
                           
                           <!--traversing product-->
                           <% 
                                for(Product product:list){
                            %>
                           
                            
                            <div class="card">
                                <div class="container text-center">
                                 <img class="card-img-top m-2" src="img/products/<%=product.getpPhoto() %>" style="max-height: 200px; max-width: 100%; width: auto;" alt="...">
                                </div>
                                 <div class="card-body">
                                    
                                    <h5 class="card-title"><%=product.getpName()%></h5>
                                    <p class="card-text"><%=Helper.get10Words(product.getpDesc()) %>
                                    </p>
                                </div>
                                    
                                    <div class="card-footer">
                                        <button class="btn custom-bg text-dark" onclick="add_to_cart(<%=product.getpId()%>,'<%=product.getpName()%>',<%=product.getPriceAfterDiscount()%>)">Add to cart</button>
                                        <button class="btn btn-outline-primary">	&#8377;<%=product.getPriceAfterDiscount()%>/- <span class="text-secondary"><%=product.getpDiscount() %>% off</span></button>
                                        
                                    </div>
                            </div>
                            
                           
                           <% }
                                  if(list.size()==0)
                    {
                      out.println("<h3>no item in this category</h3>");
                    }
                           %>
                           
                           
                       </div>
                       
                   </div>
                   
               </div>
                 
                 
            </div>
            
        </div>
        
    </body>
</html>

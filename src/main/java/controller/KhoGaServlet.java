/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import data.CartDAO;
import data.OrdersDAO;
import data.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Customer;
import model.Orders;
import model.Product;

/**
 *
 * @author Admin
 */
@WebServlet(name = "KhoGaServlet", urlPatterns = {"/KhoGaServlet"})
public class KhoGaServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet KhoGaServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet KhoGaServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer)session.getAttribute("acc");
        if (customer!=null) request.setAttribute("carts", CartDAO.getCart(customer.getCustomerID()));
        
        String url = "/view/home.jsp";
        
        List<String> types = ProductDAO.getAllProductTypes();
        request.setAttribute("allTypes", types);
        
        String action = request.getParameter("action");
        if (action==null) action = "list";
        
        if (action.equals("list")){
            List<Product> products = ProductDAO.getProducts();
        
            request.setAttribute("products", products);
            
        } else if (action.equals("viewDetail")){
            String id = request.getParameter("productID");
            int productID = Integer.parseInt(id);
            
            Product product = ProductDAO.getProduct(productID);
            url = "/view/viewDetail.jsp";
            request.setAttribute("product", product);
        } else if (action.equals("search")){
            String name = request.getParameter("query");
            
            List<Product> searchProduct = ProductDAO.searchName(name);
            
            request.setAttribute("products", searchProduct);
        } else if (action.equals("filter")) {
            String type = request.getParameter("type");
            
            List<Product> typeProduct = ProductDAO.getProductByType(type);
            
            request.setAttribute("products", typeProduct);
        }
        
        
        
        request.getRequestDispatcher(url).forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<String> types = ProductDAO.getAllProductTypes();
        request.setAttribute("allTypes", types);
        
        List<Product> products = ProductDAO.getProducts();
        
        request.setAttribute("products", products);
        
        request.getRequestDispatcher("/view/home.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

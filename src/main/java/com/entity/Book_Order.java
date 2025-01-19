package com.entity;

import java.sql.Timestamp; // Correct import
import java.sql.Date;

public class Book_Order {

    private int id;
    private String orderId;
    private String userName;
    private String email;
    private String phno;
    private String fulladdr;
    private String payment;
    private String bookName;
    private String author;
    private String price;
    private Timestamp date; // Correct type

    public Book_Order() {
        super();
    }

    @Override
    public String toString() {
        return "Book_Order [id=" + id + ", userName=" + userName + ", email=" + email + ", phno=" + phno + 
               ", fulladdr=" + fulladdr + ", payment=" + payment + "]";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhno() {
        return phno;
    }

    public void setPhno(String phno) {
        this.phno = phno;
    }

    public String getFulladdr() {
        return fulladdr;
    }

    public void setFulladdr(String fulladdr) {
        this.fulladdr = fulladdr;
    }

    public String getPayment() {
        return payment;
    }

    public void setPayment(String payment) {
        this.payment = payment;
    }

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
}

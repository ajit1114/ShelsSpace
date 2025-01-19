package com.entity;

public class Cart {
    private int cid;
    private int bid;
    private int userid;
    private String bookName;
    private String author;
    private Double price;
    private Double totalPrice;

    public Cart() {
        this.totalPrice = 0.0; // Initialize totalPrice to avoid null
    }

    public int getCid() {
        return cid;
    }

    public void setCid(int cid) {
        this.cid = cid;
    }

    public int getBid() {
        return bid;
    }

    public void setBid(int bid) {
        this.bid = bid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
        updateTotalPrice(); // Automatically update totalPrice when price is set
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    // Method to calculate total price (if quantity is involved, you can modify this)
    private void updateTotalPrice() {
        if (price != null) {
            this.totalPrice = price; // Assuming totalPrice = price for a single item
        } else {
            this.totalPrice = 0.0;
        }
    }
}

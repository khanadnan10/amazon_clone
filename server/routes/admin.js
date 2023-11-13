const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const Product = require("../models/product");

// add product
adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;
    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });
    product = await product.save();
    res.json(product);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

// get products of the seller

adminRouter.get("/admin/get-products", admin, async (req, res) => {
  try {
    const product = await Product.find({});
    res.status(200).json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// delete product

adminRouter.post("/admin/delete-product", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = adminRouter;

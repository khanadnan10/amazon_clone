const express = require("express");
const mongoose = require("mongoose");
// Import other files
const authRouter = require("./routes/auth");

// Server Initialization
const PORT = 3000;
const app = express();

//middleware
app.use(express.json());
app.use(authRouter);

// database connections
const DB = 'mongodb+srv://adnan:adnanpassword123@cluster0.pbe7qxd.mongodb.net/';
mongoose
  .connect(DB)
  .then(() => {
    console.log(`connection successfull`);
  })
  .catch((e) => {
    console.log(e);
  }); 

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port: ${PORT}`);
});

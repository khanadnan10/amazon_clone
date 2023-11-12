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
// const DB = "mongodb://127.0.0.1:27017/myDb";
mongoose
  .connect(DB)
  .then(() => {
    console.log(`connection successfull`);
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, () => {
  console.log(`connected at port: ${PORT}`);
});

const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({
        msg: "Token is not valid",
      });
    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res.status(401).json({
        msg: "Verification failed. Unauthorized user.",
      });
    const user = await User.findById(verified.id);
    if (user.type == "user") {
      return res.status(401).json({ msg: "Unauthorized user. Not a seller." });
    }

    req.user = verified.id;
    req.token = token;

    next();
  } catch (error) {
    res.status.json({
      error: error.message,
    });
  }
};

module.exports = admin;

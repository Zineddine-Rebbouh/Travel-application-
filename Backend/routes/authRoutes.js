const express = require("express")
const router = express.Router()
const authController = require("../controllers/authController")
const { body } = require("express-validator")
const User = require("../models/user")
const bcrypt = require("bcrypt")
const multer = require("multer")
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "images/") // Destination folder for uploaded files
  },
  filename: (req, file, cb) => {
    const timestamp = Date.now() // Get the current timestamp
    const filename = `${timestamp}_${file.originalname}` // Concatenate timestamp and original filename
    cb(null, filename)
  },
})

//
router.post(
  "/register",
  multer({ storage: storage }).single("profile_picture"),
  [
    body("email")
      .isEmail()
      .withMessage("Please enter a valid email.")
      .custom((value, { req }) => {
        return User.findOne({ email: value }).then(userDoc => {
          if (userDoc) {
            return Promise.reject("E-Mail address already exists!")
          }
        })
      })
      .normalizeEmail(),
    body("password")
      .trim()
      .isLength({ min: 6 })
      .withMessage("Password must be at least 5 characters long"),
    body("username").trim().not().isEmpty(),
  ],
  authController.registerController
)

router.post(
  "/login",
  body("email")
    .isEmail()
    .withMessage("Please enter a valid email.")
    .custom((value, { req }) => {
      return User.findOne({ email: value }).then(userDoc => {
        if (!userDoc) {
          return Promise.reject("Email not found!")
        }
      })
    }),
  body("password")
    .isLength({ min: 6 })
    .withMessage("Password must be at least 6 characters.")
    .custom(async (value, { req }) => {
      const userDoc = await User.findOne({ email: req.body.email })
      if (userDoc) {
        // You should compare the provided password with the hashed password in your database here
        // For example, using bcrypt.compare
        // For simplicity, I'll assume userDoc.password is the hashed password in your User model
        // Replace this with your actual password comparison logic

        try {
          const isEqual = await bcrypt.compare(value, userDoc.password)
          if (!isEqual) {
            return Promise.reject("Incorrect password!")
          }
        } catch (error) {
          return Promise.reject("Error comparing passwords!")
        }
      }
    }),
  authController.loginController
)

module.exports = router

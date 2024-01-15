const User = require("../models/user")
const bcrypt = require("bcrypt")
const { validationResult } = require("express-validator")

exports.loginController = async (req, res, next) => {
  try {
    console.log("Hello World")

    const errors = validationResult(req)
    if (!errors.isEmpty()) {
      const error = new Error("Validation failed.")
      error.statusCode = 422
      error.data = errors.array()
      console.error(error)
      throw error
    }

    const email = req.body.email

    const loadedUser = await User.findOne({ email: email })
      .populate("saves")
      .populate("favourites")

    if (!loadedUser) {
      const error = new Error("A user with this email could not be found.")
      error.statusCode = 404 // Updated status code
      console.error(error)
      throw error
    }

    console.log(loadedUser)
    console.log("Login successful!")

    return res
      .status(200)
      .json({ user: loadedUser, message: "Success to login user" })
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500
    }
    console.error(err)
    next(err)
  }
}

exports.registerController = async (req, res, next) => {
  try {
    const errors = validationResult(req)

    console.log(req.file)
    console.log(req.body)
    if (req.file) {
      console.log("File Received:", req.file)
    }
    if (!req.file) {
      const error = new Error("no file send.")
      error.statusCode = 422
      error.data = errors.array()
      console.error(error)
      throw error
    }

    if (!errors.isEmpty()) {
      const error = new Error("Validation failed.")
      error.statusCode = 422
      error.data = errors.array()
      console.error(error)
      throw error
    }

    const { username, password, profile_picture, email } = req.body
    console.log(profile_picture)
    const profilePic = req.file ? req.file.path : null

    const hashedPassword = await bcrypt.hash(password, 12)

    const user = new User({
      username: username,
      email: email,
      password: hashedPassword,
      profilePic: profilePic,
      saves: [],
      favourites: [],
    })

    const result = await user.save()

    console.log("Created user successfully!")

    return res
      .status(201)
      .json({ message: "User created!", userId: result._id })
  } catch (err) {
    if (!err.statusCode) {
      err.statusCode = 500
    }
    console.error(err)
    next(err)
  }
}

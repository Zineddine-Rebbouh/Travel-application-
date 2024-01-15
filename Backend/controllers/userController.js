const User = require("../models/user")
exports.getUser = async (req, res, next) => {
  try {
    const userId = req.params.id
    const user = await User.findById(userId)
      .populate({
        path: "favourites",
      })
      .lean()

    if (!user) {
      return res.status(404).json({ message: "failed to fetch user" })
    }
    return res.status(200).json({
      message: "succes to fetch user",
      user: user,
    })
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500
    }
    next(error)
  }
}

exports.getAllUsers = async (req, res, next) => {
  try {
    const users = await User.find().lean().exec()
    if (!users) {
      return res.status(404).json({ message: "failed to fetch users" })
    }
    return res.status(200).json({
      message: "success to fetch users",
      users: users, // Change 'posts' to 'users'
    })
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500
    }
    next(error)
  }
}

exports.updateUser = async (req, res, next) => {
  try {
    const data = req.body
    const userId = req.params.id
    const user = User.find({ _id: userId }).populate("saves", "favourites")
    if (!user) {
      return res.status(404).json({ message: "failed to fetch user" })
    }

    user.username = data.username
    user.email = data.email
    user.password = data.password

    user.save()

    return res.status(200).json({
      message: "succes to update user",
    })
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500
    }
    next(error)
  }
}

exports.deleteUser = async (req, res, next) => {
  try {
    const userId = req.params.id
    console.log(userId)
    await User.findOneAndDelete({ _id: userId })
    return res.status(200).json({
      message: "succes to delete user",
    })
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500
    }
    next(error)
  }
}

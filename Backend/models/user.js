const mongoose = require("mongoose")

const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
    unique: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  profilePic: {
    type: String, // Using Buffer to store image data
  },
  saves: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Post",
    },
  ],
  favourites: [
    {
      type: mongoose.Schema.Types.ObjectId,
      ref: "Post",
    },
  ],
})

const User = mongoose.model("User", userSchema)

module.exports = User

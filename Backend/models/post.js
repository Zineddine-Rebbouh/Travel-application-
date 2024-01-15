const mongoose = require("mongoose")

const postSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    unique: true,
  },
  location: {
    type: String,
    required: true,
    unique: true,
  },
  type: {
    type: String,
    required: true,
    enum: [
      "Museums",
      "Cafes",
      "Restaurants",
      "HistoricalSites",
      "Beach",
      "Forest",
      "Desert",
    ],
  },
  place_image: {
    type: String,
    required: true,
  },
  star: {
    type: String,
    required: true,
  },
  about: {
    type: String,
    required: true,
  },
})

const Post = mongoose.model("Post", postSchema)

module.exports = Post

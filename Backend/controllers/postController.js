const User = require("../models/user")

const Post = require("../models/post") // replace with the actual path

exports.addPost = async (req, res, next) => {
  try {
    const { name, location, star, about, type } = req.body

    // Check if an image was uploaded
    const placeImage = req.file ? req.file.path : ""
    console.log(req.file)
    const post = await Post.create({
      name,
      location,
      place_image: placeImage,
      star,
      about,
      type,
    })

    if (!post) {
      return res.status(404).json({ message: "Failed to create a new post" })
    }

    return res
      .status(201)
      .json({ message: "Successfully created a new post", post })
  } catch (error) {
    console.error(error)
    return res.status(500).json({ message: "Internal server error" })
  }
}

exports.getPost = async (req, res, next) => {
  try {
    const postId = req.params.id
    const post = await Post.find({ _id: postId }).lean()
    if (!post) {
      return res.status(404).json({ message: "failed to fetch post" })
    }
    return res.status(200).json({
      message: "succes to fetch post",
      post: post,
    })
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500
    }
    next(error)
  }
}

exports.getPosts = async (req, res) => {
  try {
    const posts = await Post.find().lean()

    if (!posts) {
      return res.status(404).json({ message: "failed to fetch posts" })
    }

    return res.status(200).json({
      message: "success to fetch posts",
      posts: posts,
    })
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500
    }
    next(error)
  }
}

exports.addSaves = async (req, res, next) => {
  try {
    const userId = req.params.userId
    const postId = req.params.postId

    const user = await User.findById(userId)

    if (!user) {
      return res.status(404).json({ message: "Failed to fetch user" })
    }

    user.saves.push(postId)

    await user.save() // Save the updated user to the database

    return res.status(200).json({ message: "Success to add a new save" })
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500
    }
    next(error)
  }
}

exports.addFavourites = async (req, res, next) => {
  try {
    const userId = req.params.userId
    const postId = req.params.postId
    const user = await User.findById(userId)

    if (!user) {
      return res.status(404).json({ message: "failed to fetch user" })
    }

    user.favourites.push(postId)
    await user.save() // Save the updated user to the database

    return res.status(200).json({ message: "succes to add a new favourite" })
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500
    }
    next(error)
  }
}

exports.getPostByType = async (req, res, next) => {
  try {
    const postType = req.params.type

    const posts = await Post.find({ type: postType }).lean()

    if (!posts) {
      return res.status(404).json({ message: "failed to fetch posts" })
    }

    return res.status(200).json({
      message: "success to fetch posts",
      posts: posts,
    })
  } catch (error) {
    if (!error.statusCode) {
      error.statusCode = 500
    }
    next(error)
  }
}

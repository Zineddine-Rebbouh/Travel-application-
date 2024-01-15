const express = require("express")
const router = express.Router()
const postController = require("../controllers/postController")
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

// Create multer instance

router.post(
  "/add-post",
  multer({ storage: storage }).single("place_image"),
  postController.addPost
)

router.get("/get-post/:id", postController.getPost)
router.get("/get-post-by-type/:type", postController.getPostByType)
router.get("/get-posts", postController.getPosts)
router.get("/add-favourites/:userId/:postId", postController.addFavourites)

module.exports = router

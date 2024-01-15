const express = require("express")
const app = express()
const mongoose = require("mongoose")
require("dotenv").config()
const port = process.env.PORT || 6000
const authRoutes = require("./routes/authRoutes")
const multer = require("multer")
const path = require("path")
const postRoutes = require("./routes/postRoutes")
const userRoutes = require("./routes/userRoutes")
const morgan = require("morgan")
app.use("/images", express.static(path.join(__dirname, "images")))
// Define a route
app.use(express.json())
// Enable CORS if needed
// app.use(
//   cors({
//     origin: "", // Update this to your frontend's origin
//   })
// )
app.use(express.urlencoded({ extended: true }))
app.use(morgan("combined")) // 'combined' format includes more details

app.use("/auth", authRoutes)
app.use("/post", postRoutes)
app.use("/user", userRoutes)

app.use((error, req, res, next) => {
  console.log(error)
  const messageError = error.message
  const statuscode = error.statusCode || 500
  const data = error.data
  console.log(data)
  res.status(statuscode).json({ message: messageError, errors: data })
})

mongoose
  .connect(process.env.MONGOOSE_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    app.listen(port, () => {
      console.log(`mongodb is connected`)
      console.log(`server is running on ${port}`)
    })
  })
  .catch(err => console.log(err))

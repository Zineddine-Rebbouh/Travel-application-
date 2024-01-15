const express = require("express")
const router = express.Router()
const userController = require("../controllers/userController")

router.get("/all-users", userController.getAllUsers)
router.get("/get-user/:id", userController.getUser)

router.put("/update-user/:id", userController.updateUser)
router.delete("/delete-user/:id", userController.deleteUser)

module.exports = router

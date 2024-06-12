const express = require("express");

const {
  getAllPosts,
  getSinglePost,
  createPost,
  deletePosts,
  deleteSinglePost,
  updatePost,
} = require("../controllers/postController");

const router = express.Router();

// get all posts
router.get("/", getAllPosts);

// get single post
router.get("/:id", getSinglePost);

// create post
router.post("/", createPost);

// delete posts
router.delete("/", deletePosts);

//delete single post
router.delete("/:id", deleteSinglePost);

// update post
router.patch("/:id", updatePost);

module.exports = router;

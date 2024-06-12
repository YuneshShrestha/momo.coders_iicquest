const express = require("express");

const router = express.Router();

// get all videos
router.get("/");

// get single video
router.get("/:id");

// create video
router.post("/");

// delete videos
router.delete("/");

//delete video
router.delete("/:id");

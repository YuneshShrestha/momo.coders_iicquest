const express = require("express");

const router = express.Router();

const {
  getAllVideos,
  getSingleVideo,
  createVideo,
  deleteVideos,
  deleteVideo,
} = require("../controllers/videoController");

// get all videos
router.get("/", getAllVideos);

// get single video
router.get("/:id", getSingleVideo);

// create video
router.post("/", createVideo);

// delete videos
router.delete("/", deleteVideos);

//delete video
router.delete("/:id", deleteVideo);

module.exports = router;

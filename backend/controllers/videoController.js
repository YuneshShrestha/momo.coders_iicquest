const primsa = require("@prisma/client");

const prisma = new primsa.PrismaClient();

// get all videos
const getAllVideos = async (req, res) => {
  try {
    const videos = await prisma.video.findMany();
    if (!videos) {
      return res.status(404).json({ error: "No videos found." });
    }
    res.status(200).json(videos);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// get single video
const getSingleVideo = async (req, res) => {
  try {
    const { id } = req.params;
    const video = await prisma.video.findUnique({
      where: {
        id,
      },
    });

    if (!video) {
      return res.status(404).json({ error: "Video not found." });
    }
    res.status(200).json(video);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// create video
const createVideo = async (req, res) => {
  try {
    const { url, categoryId } = req.body;

    const video = await prisma.video.create({
      data: {
        url,
        categoryId,
      },
    });

    if (!video) {
      return res.status(404).json({ error: "Video not found." });
    }
    res.status(200).json(video);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// delete videos
const deleteVideos = async (req, res) => {
  try {
    const videos = await prisma.video.deleteMany();
    if (!videos) {
      return res.status(404).json({ error: "No videos found." });
    }
    res.status(200).json(videos);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};

// delete video
const deleteVideo = async (req, res) => {
  try {
    const { id } = req.params;
    const video = await prisma.video.delete({
      where: {
        id,
      },
    });

    if (!video) {
      return res.status(404).json({ error: "Video not found." });
    }
    res.status(200).json(video);
  } catch (error) {
    res.status(500).json({ error: "Internal server error." });
  }
};
